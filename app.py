import streamlit as st
import mysql.connector
from mysql.connector import Error

# Função para conectar ao banco de dados MySQL usando as credenciais fornecidas
def connect_to_db(user, password):
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user=user,
            password=password,
            database="programacoes_filmes"
        )
        if connection.is_connected():
            return connection
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Função principal para exibir a tela de login
def login():
    st.markdown('<h1 style="color: red;">🎬 RURAFLIX</h1>', unsafe_allow_html=True)

    # Campos para o usuário inserir nome de usuário e senha
    user = st.text_input("Usuário do MySQL", value="", max_chars=30)
    password = st.text_input("Senha do MySQL", value="", type="password", max_chars=30)

    if st.button("Conectar"):
        if user and password:
            # Tentar conectar ao banco de dados com os dados fornecidos
            connection = connect_to_db(user, password)
            if connection:
                # Armazenar a conexão no session_state
                st.session_state['connection'] = connection
                st.session_state['logged_in'] = True  # Marca que o usuário está logado
                st.success("Conexão bem-sucedida ao banco de dados!")
            else:
                st.error("Erro ao conectar. Verifique as credenciais.")
        else:
            st.warning("Por favor, insira usuário e senha!")

# Função para verificar se o usuário já está conectado
def check_connection():
    if 'connection' not in st.session_state or st.session_state['connection'] is None:
        st.error("Você precisa fazer login primeiro!")
        return False
    return True

# Função para consultar canais
def get_canais():
    if not check_connection():
        return []

    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        cursor.execute("SELECT * FROM canal")
        canais = cursor.fetchall()
        cursor.close()
        return canais
    except Error as e:
        st.error(f"Erro ao buscar canais: {e}")
        return []

# Função para consultar filmes
def get_filmes():
    if not check_connection():
        return []

    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        cursor.execute("SELECT * FROM filme")
        filmes = cursor.fetchall()
        cursor.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao buscar filmes: {e}")
        return []
    
def get_exibicao():
    if not check_connection():
        return []
    
    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        cursor.execute("""
            SELECT
                e.num_filme,
                e.num_canal,
                f.titulo_original AS nome_filme,
                DATE_FORMAT(e.data, '%d-%m-%Y %H:%i:%s') AS data_formatada
            FROM exibicao e
            JOIN filme f ON e.num_filme = f.num_filme
        """)
        exibicoes = cursor.fetchall()
        cursor.close()
        return exibicoes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")

# Função para adicionar um novo filme
def add_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao):
    try:
        # Acessa a conexão armazenada em session_state
        cursor = st.session_state['connection'].cursor(dictionary=True)
        
        # Query de inserção
        query = """
        INSERT INTO filme (num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
        cursor.execute(query, values)
        
        # Confirma a operação no banco de dados
        st.session_state['connection'].commit()
        cursor.close()
        
        # Mensagem de sucesso após inserir
        st.success("Filme adicionado com sucesso!")

    except Error as e:
        st.error(f"Erro ao adicionar filme: {e}")

# Função para remover um filme
def remove_filme(num_filme):
    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        query = "DELETE FROM filme WHERE num_filme = %s"
        cursor.execute(query, (num_filme,))
        st.session_state['connection'].commit()
        cursor.close()
        st.success("Filme removido com sucesso!")
    except Error as e:
        st.error(f"Erro ao remover filme: {e}")

# Função para atualizar um filme
def update_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao):
    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
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
        st.session_state['connection'].commit()
        cursor.close()
        st.success("Filme atualizado com sucesso!")
    except Error as e:
        st.error(f"Erro ao atualizar filme: {e}")

# Função para consultar filmes por gênero
def get_filmes_por_genero(genero):
    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        query = "SELECT * FROM filme WHERE categoria = %s ORDER BY ano_lancamento DESC"
        cursor.execute(query, (genero,))
        filmes = cursor.fetchall()
        cursor.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

# Função para consultar filmes por ano de lançamento
def get_filmes_por_ano(ano):
    try:
        cursor = st.session_state['connection'].cursor(dictionary=True)
        query = "SELECT * FROM filme WHERE ano_lancamento = %s ORDER BY categoria"
        cursor.execute(query, (ano,))
        filmes = cursor.fetchall()
        cursor.close()
        return filmes
    except Error as e:
        st.error(f"Erro ao conectar ao banco de dados: {e}")
        return []

def add_exibicao(num_filme, num_canal, data):
    try:
        # Acessa a conexão armazenada em session_state
        cursor = st.session_state['connection'].cursor(dictionary=True)
        
        # Query de inserção para adicionar a exibição
        query = """
        INSERT INTO exibicao (num_filme, num_canal, data)
        VALUES (%s, %s, %s)
        """
        values = (num_filme, num_canal, data)
        cursor.execute(query, values)
        
        # Confirma a operação no banco de dados
        st.session_state['connection'].commit()
        cursor.close()
        
        # Mensagem de sucesso após inserir
        st.success("Exibição adicionada com sucesso!")
    except Error as e:
        st.error(f"Erro ao adicionar exibição: {e}")


# Função principal da aplicação
def main():
    # Verifica se o usuário está logado
    if 'connection' not in st.session_state:
        login()
    else:
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
                    num_colunas = 3  # Definindo o número de colunas
                    colunas = st.columns(num_colunas)
                    
                    for idx, filme in enumerate(filmes):
                        coluna = colunas[idx % num_colunas]  # Seleciona a coluna com base no índice do filme
                        
                        with coluna:
                            st.image(filme['imagem_url'], width=222)  # Exibir o poster
                            st.markdown(f"""
                                <div class="filme-card">
                                    <p><strong>Número do Filme</strong>: {filme['num_filme']}</p>
                                    <p><strong>Título Original</strong>: {filme['titulo_original']}</p>
                                    <p><strong>Título no Brasil</strong>: {filme['titulo_brasil']}</p>
                                    <p><strong>Ano de Lançamento</strong>: {filme['ano_lancamento']}</p>
                                    <p><strong>País de Origem</strong>: {filme['pais_origem']}</p>
                                    <p><strong>Categoria</strong>: {filme['categoria']}</p>
                                    <p><strong>Duração</strong>: {filme['duracao']} minutos</p>
                                    <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                                </div>
                            """, unsafe_allow_html=True)
                            st.markdown("---")
                else:
                    st.write("Nenhum filme encontrado.")

            elif escolha == "Adicionar Filme":
                st.subheader("Adicionar Novo Filme")
                num_filme = st.number_input("Número do Filme", min_value=1)
                titulo_original = st.text_input("Título Original")
                titulo_brasil = st.text_input("Título no Brasil")
                ano_lancamento = st.number_input("Ano de Lançamento", min_value=1900, max_value=2100)
                pais_origem = st.text_input("País de Origem")
                categoria = st.text_input("Categoria")
                duracao = st.number_input("Duração (em minutos)", min_value=0)
                imagem_url = st.text_input("URL da Imagem")
                classificacao = st.number_input("Classificação", min_value=0)

                if st.button("Adicionar Filme"):
                    add_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)
                
            elif escolha == "Remover Filme":
                st.subheader("Remover Filme")
                num_filme = st.number_input("Número do Filme", min_value=1)
                
                if st.button("Remover Filme"):
                    remove_filme(num_filme)

            elif escolha == "Atualizar Filme":
                st.subheader("Atualizar Filme")
                num_filme = st.number_input("Número do Filme", min_value=1)
                titulo_original = st.text_input("Novo Título Original")
                titulo_brasil = st.text_input("Novo Título no Brasil")
                ano_lancamento = st.number_input("Novo Ano de Lançamento", min_value=1900, max_value=2100)
                pais_origem = st.text_input("Novo País de Origem")
                categoria = st.text_input("Nova Categoria")
                duracao = st.number_input("Nova Duração (em minutos)", min_value=0)
                imagem_url = st.text_input("Nova URL da Imagem")
                classificacao = st.number_input("Nova Classificação", min_value=0)

                if st.button("Atualizar Filme"):
                    update_filme(num_filme, titulo_original, titulo_brasil, ano_lancamento, pais_origem, categoria, duracao, imagem_url, classificacao)

            elif escolha == "Recomendações":
                st.subheader("Recomendações de Filmes")
                genero = st.selectbox("Selecione o Gênero", options=["Ação", "Animação", "Comédia", "Drama", "Ficção Científica", "Fantasia", "Suspense", "Romance", "Terror"])
                ano = st.number_input("Ano de Lançamento", min_value=1900, max_value=2100)

                col1, col2 = st.columns(2)

                with col1:
                    if st.button("Recomendar por Gênero"):
                        filmes_por_genero = get_filmes_por_genero(genero)
                        if filmes_por_genero:
                            st.write(f"Filmes no gênero {genero}:")
                            for filme in filmes_por_genero:
                                st.markdown(f"""
                                    <div class="filme-card">
                                        <p><strong>Título Original</strong>: {filme['titulo_original']}</p>
                                        <p><strong>Título no Brasil</strong>: {filme['titulo_brasil']}</p>
                                        <p><strong>Ano de Lançamento</strong>: {filme['ano_lancamento']}</p>
                                        <p><strong>País de Origem</strong>: {filme['pais_origem']}</p>
                                        <p><strong>Categoria</strong>: {filme['categoria']}</p>
                                        <p><strong>Duração</strong>: {filme['duracao']} minutos</p>
                                        <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                                    </div>
                                """, unsafe_allow_html=True)
                                st.markdown("---")
                        else:
                            st.write("Nenhum filme encontrado.")

                with col2:
                    if st.button("Recomendar por Ano"):
                        filmes_por_ano = get_filmes_por_ano(ano)
                        if filmes_por_ano:
                            st.write(f"Filmes do ano {ano}:")
                            for filme in filmes_por_ano:
                                st.markdown(f"""
                                    <div class="filme-card">
                                        <p><strong>Título Original</strong>: {filme['titulo_original']}</p>
                                        <p><strong>Título no Brasil</strong>: {filme['titulo_brasil']}</p>
                                        <p><strong>Ano de Lançamento</strong>: {filme['ano_lancamento']}</p>
                                        <p><strong>País de Origem</strong>: {filme['pais_origem']}</p>
                                        <p><strong>Categoria</strong>: {filme['categoria']}</p>
                                        <p><strong>Duração</strong>: {filme['duracao']} minutos</p>
                                        <p><strong>Classificação:</strong> {filme['classificacao']}</p>
                                    </div>
                                """, unsafe_allow_html=True)
                                st.markdown("---")
                        else:
                            st.write("Nenhum filme encontrado.")
        
        elif opcao_principal == "Exibição":
            st.subheader("Filmes na Telinha")

            # Formulário para adicionar uma nova exibição
            with st.form(key='adicionar_exibicao'):
                st.write("Adicionar nova exibição de filme")
                
                # Campos de entrada para adicionar a exibição
                num_filme = st.text_input("Número do Filme")
                num_canal = st.text_input("Número do Canal")
                data_exibicao = st.date_input("Data da Exibição")
                hora_exibicao = st.time_input("Hora da Exibição")
                
                # Botão de submissão
                submit_button = st.form_submit_button(label="Adicionar Exibição")
                
                # Ação ao submeter o formulário
                if submit_button:
                    if num_filme and num_canal:
                        # Junta a data e a hora para criar o campo completo da data de exibição
                        data_completa = f"{data_exibicao} {hora_exibicao}"
                        
                        # Função para adicionar exibição
                        add_exibicao(num_filme, num_canal, data_completa)
                    else:
                        st.error("Por favor, preencha os campos obrigatórios (Número do Filme, Número do Canal).")
            
            # Listagem das exibições de filmes
            st.write("### Exibições Atuais")
            exibicoes = get_exibicao()  # Função que consulta as exibições
            
            if exibicoes:
                num_colunas = 3  # Definindo o número de colunas
                colunas = st.columns(num_colunas)
                
                for idx, exibicao in enumerate(exibicoes):
                    coluna = colunas[idx % num_colunas]  # Seleciona a coluna com base no índice do canal
                    
                    with coluna:
                        st.markdown(f"""
                            <div class="canal-card">
                                <p><strong>Número do Filme:</strong> {exibicao['num_filme']}</p>
                                <p><strong>Nome do Filme:</strong> {exibicao['nome_filme']}</p>
                                <p><strong>Canal:</strong> {exibicao['num_canal']}</p>
                                <p><strong>Data e Hora:</strong> {exibicao['data_formatada']}</p>
                            </div>
                        """, unsafe_allow_html=True)
                        st.markdown("---")
            else:
                st.write("Nenhuma exibição encontrada.")



if __name__ == "__main__":
    main()