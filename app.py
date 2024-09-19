import streamlit as st
import mysql.connector
from mysql.connector import Error

# Função para conectar ao banco de dados MySQL
def connect_to_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="12345678",
        database="programacoes_filmes"
    )

# Função para consultar canais
def get_canais():
    try:
        db = connect_to_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM canal")
        canais = cursor.fetchall()
        cursor.close()
        db.close()
        return canais
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

# Função para consultar filmes
def get_filmes():
    try:
        db = connect_to_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM filme")
        filmes = cursor.fetchall()
        cursor.close()
        db.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

def get_exibicao():
    try:
        db = connect_to_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute(""" 
            SELECT
                e.num_filme,
                e.num_canal,
                f.titulo_original AS nome_filme,
                DATE_FORMAT(e.data, '%d-%m-%Y %H:%i:%s') AS data_formatada,
                c.imagem_url AS imagem_canal
            FROM exibicao e
            JOIN filme f ON e.num_filme = f.num_filme
            JOIN canal c ON e.num_canal = c.num_canal
        """)
        exibicoes = cursor.fetchall()
        cursor.close()
        db.close()
        return exibicoes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

# Função para verificar se o número do filme já existe
def filme_existe(num_filme):
    try:
        db = connect_to_db()
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM filme WHERE num_filme = %s", (num_filme,))
        resultado = cursor.fetchone()[0]
        cursor.close()
        db.close()
        return resultado > 0
    except Error as e:
        st.error(f"Erro ao verificar existência do filme: {e}")
        return False

# Função para adicionar um novo filme
def add_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao):
    if filme_existe(num_filme):
        st.error("Erro: Já existe um filme com esse número.")
        return

    try:
        db = connect_to_db()
        cursor = db.cursor()
        query = """
        INSERT INTO filme (num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
        cursor.execute(query, values)
        db.commit()
        cursor.close()
        db.close()
        st.success("Filme adicionado com sucesso!")
    except Error as e:
        st.error(f"Erro ao adicionar filme: {e}")

# Função para remover um filme
def remove_filme(num_filme):
    try:
        db = connect_to_db()
        cursor = db.cursor()
        query = "DELETE FROM filme WHERE num_filme = %s"
        cursor.execute(query, (num_filme,))
        db.commit()
        cursor.close()
        db.close()
        st.success("Filme removido com sucesso!")
    except Error as e:
        st.error(f"Erro ao remover filme: {e}")

# Função para atualizar um filme
def update_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao):
    if not filme_existe(num_filme):
        st.error("Erro: Filme com esse número não encontrado.")
        return

    try:
        db = connect_to_db()
        cursor = db.cursor()
        query = """
        UPDATE filme
        SET titulo_original = %s,
            titulo_brasil = %s,
            ano_lancamento = %s,
            pais_origem = %s,
            categoria = %s,
            duracao = %s,
            imagem_url = %s,
            classificacao = %s
        WHERE num_filme = %s
        """
        values = (titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao, num_filme)
        cursor.execute(query, values)
        db.commit()
        cursor.close()
        db.close()
        st.success("Filme atualizado com sucesso!")
    except Error as e:
        st.error(f"Erro ao atualizar filme: {e}")

# Função para consultar filmes por gênero
def get_filmes_por_genero(genero):
    try:
        db = connect_to_db()
        cursor = db.cursor(dictionary=True)
        query = "SELECT * FROM filme WHERE categoria = %s ORDER BY ano_lancamento DESC"
        cursor.execute(query, (genero,))
        filmes = cursor.fetchall()
        cursor.close()
        db.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

# Função para consultar filmes por ano de lançamento
def get_filmes_por_ano(ano):
    try:
        db = connect_to_db()
        cursor = db.cursor(dictionary=True)
        query = "SELECT * FROM filme WHERE ano_lancamento = %s ORDER BY categoria"
        cursor.execute(query, (ano,))
        filmes = cursor.fetchall()
        cursor.close()
        db.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

# Função para verificar a classificação e mostrar uma notificação
def verificar_classificacao(classificacao):
    if classificacao == "18":
        st.warning("Este filme é para maiores de 18 anos.")

# Função principal da aplicação
def main():
    with open('styles.css', 'r') as css_file:
        css_content = css_file.read()

    # Customizando o estilo com CSS
    st.markdown(
        f"""
        <style>
        {css_content}
        </style>
        """,
        unsafe_allow_html=True
    )

    st.title("🎬 RURAFLIX")
    st.sidebar.title("Menu")

    menu_principal = ["Canais", "Filmes", "Exibição"]
    opcao_principal = st.sidebar.radio("Escolha uma opção", menu_principal)

    if opcao_principal == "Canais":
        st.subheader("Canais Disponíveis")
        canais = get_canais()
        if canais:
            num_colunas = 3  # Definindo o número de colunas
            colunas = st.columns(num_colunas)
            
            for idx, canal in enumerate(canais):
                coluna = colunas[idx % num_colunas]  # Seleciona a coluna com base no índice do canal
                
                with coluna:
                    st.markdown(f'<img src="{canal["imagem_url"]}" class="canal-imagem">', unsafe_allow_html=True)
                    # Exibindo as demais informações do canal
                    st.markdown(f"""
                        <div class="canal-card">
                            <p><strong>ID:</strong> {canal['num_canal']}</p>
                            <p><strong>Nome:</strong> {canal['nome']}</p>
                            <p><strong>Sigla:</strong> {canal['sigla']}</p>
                        </div>
                    """, unsafe_allow_html=True)
                    st.markdown("---")
        else:
            st.write("Nenhum canal encontrado.")

    elif opcao_principal == "Filmes":
        menu_filmes = ["Visualizar Filmes", "Adicionar Filme", "Remover Filme", "Atualizar Filme", "Recomendações"]
        escolha = st.sidebar.radio("Escolha uma opção", menu_filmes)

        if escolha == "Visualizar Filmes":
            st.subheader("Catálogo")
            filmes = get_filmes()
            if filmes:
                num_colunas = 3  # Número de colunas para exibir os filmes
                colunas = st.columns(num_colunas)
                
                for idx, filme in enumerate(filmes):
                    coluna = colunas[idx % num_colunas]  # Seleciona a coluna com base no índice do filme
                    
                    with coluna:
                        st.markdown(f'''
                            <div class="filme-card">
                                <img src="{filme['imagem_url']}" class="filme-imagem">
                                <p><strong>Título Original:</strong> {filme['titulo_original']}</p>
                                <p><strong>Título Brasil:</strong> {filme['titulo_brasil']}</p>
                                <p><strong>Ano de Lançamento:</strong> {filme['ano_lancamento']}</p>
                                <p><strong>País de Origem:</strong> {filme['pais_origem']}</p>
                                <p><strong>Categoria:</strong> {filme['categoria']}</p>
                                <p><strong>Duração:</strong> {filme['duracao']}</p>
                                <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                            </div>
                        ''', unsafe_allow_html=True)
            else:
                st.write("Nenhum filme encontrado.")

        elif escolha == "Adicionar Filme":
            st.subheader("Adicionar Novo Filme")
            num_filme = st.text_input("Número do Filme")
            titulo_original = st.text_input("Título Original")
            titulo_brasil = st.text_input("Título Brasil")
            ano_lancamento = st.text_input("Ano de Lançamento")
            pais_origem = st.text_input("País de Origem")
            categoria = st.text_input("Categoria")
            duracao = st.text_input("Duração")
            imagem_url = st.text_input("URL da Imagem")
            classificacao = st.text_input("Classificação")

            if st.button("Adicionar Filme"):
                add_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
                verificar_classificacao(classificacao)

        elif escolha == "Remover Filme":
            st.subheader("Remover Filme")
            num_filme = st.text_input("Número do Filme")

            if st.button("Remover Filme"):
                remove_filme(num_filme)

        elif escolha == "Atualizar Filme":
            st.subheader("Atualizar Filme")
            num_filme = st.text_input("Número do Filme")
            titulo_original = st.text_input("Novo Título Original")
            titulo_brasil = st.text_input("Novo Título Brasil")
            ano_lancamento = st.text_input("Novo Ano de Lançamento")
            pais_origem = st.text_input("Novo País de Origem")
            categoria = st.text_input("Nova Categoria")
            duracao = st.text_input("Nova Duração")
            imagem_url = st.text_input("Nova URL da Imagem")
            classificacao = st.text_input("Nova Classificação")

            if st.button("Atualizar Filme"):
                update_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
                verificar_classificacao(classificacao)

        elif escolha == "Recomendações":
            st.subheader("Recomendações de Filmes")
            genero = st.text_input("Digite o gênero dos filmes que você gosta:")
            ano = st.text_input("Digite o ano de lançamento (opcional):")

            if genero:
                filmes_recomendados = get_filmes_por_genero(genero)
                if filmes_recomendados:
                    st.write(f"Filmes recomendados para o gênero {genero}:")
                    for filme in filmes_recomendados:
                        st.markdown(f'''
                            <div class="filme-card">
                                <img src="{filme['imagem_url']}" class="filme-imagem">
                                <p><strong>Título Original:</strong> {filme['titulo_original']}</p>
                                <p><strong>Título Brasil:</strong> {filme['titulo_brasil']}</p>
                                <p><strong>Ano de Lançamento:</strong> {filme['ano_lancamento']}</p>
                                <p><strong>País de Origem:</strong> {filme['pais_origem']}</p>
                                <p><strong>Categoria:</strong> {filme['categoria']}</p>
                                <p><strong>Duração:</strong> {filme['duracao']}</p>
                                <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                            </div>
                        ''', unsafe_allow_html=True)
                else:
                    st.write("Nenhum filme encontrado para o gênero especificado.")

            if ano:
                filmes_por_ano = get_filmes_por_ano(ano)
                if filmes_por_ano:
                    st.write(f"Filmes lançados em {ano}:")
                    for filme in filmes_por_ano:
                        st.markdown(f'''
                            <div class="filme-card">
                                <img src="{filme['imagem_url']}" class="filme-imagem">
                                <p><strong>Título Original:</strong> {filme['titulo_original']}</p>
                                <p><strong>Título Brasil:</strong> {filme['titulo_brasil']}</p>
                                <p><strong>Ano de Lançamento:</strong> {filme['ano_lancamento']}</p>
                                <p><strong>País de Origem:</strong> {filme['pais_origem']}</p>
                                <p><strong>Categoria:</strong> {filme['categoria']}</p>
                                <p><strong>Duração:</strong> {filme['duracao']}</p>
                                <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                            </div>
                        ''', unsafe_allow_html=True)
                else:
                    st.write("Nenhum filme encontrado para o ano especificado.")

    elif opcao_principal == "Exibição":
        st.subheader("Exibição de Filmes")
        exibicoes = get_exibicao()
        if exibicoes:
            for exibicao in exibicoes:
                st.write(f"Filme: {exibicao['nome_filme']}")
                st.write(f"Data: {exibicao['data_formatada']}")
                st.markdown(f'<img src="{exibicao["imagem_canal"]}" class="canal-imagem">', unsafe_allow_html=True)
                st.markdown("---")
        else:
            st.write("Nenhuma exibição encontrada.")

if __name__ == "__main__":
    main()
