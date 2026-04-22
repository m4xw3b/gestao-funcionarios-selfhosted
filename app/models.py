import psycopg2
import os
from dotenv import load_dotenv

# Carrega as variáveis do ficheiro .env
load_dotenv()

# Função básica para abrir a ligação à base de dados
def obter_ligacao():
    ligacao = psycopg2.connect(
        host='localhost',
        database='gestao_db',
        user='admin',
        password=os.getenv('DB_PASSWORD')
    )
    return ligacao

# Função simples para ler todos os departamentos
def listar_departamentos():
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('SELECT * FROM departamentos;')
    departamentos = cursor.fetchall()
    
    cursor.close()
    ligacao.close()
    
    return departamentos

# Função simples para ler todos os níveis de permissão
def listar_permissoes():
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('SELECT * FROM permissoes;')
    permissoes = cursor.fetchall()
    
    cursor.close()
    ligacao.close()
    
    return permissoes
# Função para obter os detalhes de um departamento específico
def obter_departamento(id_depto):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    # O %s é a forma segura de passar variáveis no PostgreSQL
    cursor.execute('SELECT * FROM departamentos WHERE id = %s;', (id_depto,))
    departamento = cursor.fetchone() # Traz apenas 1 resultado
    
    cursor.close()
    ligacao.close()
    
    return departamento

# Função para listar os funcionários daquele departamento
def listar_funcionarios_depto(id_depto):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('SELECT * FROM funcionarios WHERE departamento_id = %s;', (id_depto,))
    funcionarios = cursor.fetchall() # Traz todos os funcionários deste depto
    
    cursor.close()
    ligacao.close()
    
    return funcionarios
# Função simples para inserir um novo funcionário
def inserir_funcionario(nome, morada, telemovel, email, foto_path, departamento_id, permissao_id):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    # Executa a inserção dos dados
    cursor.execute('''
        INSERT INTO funcionarios (nome, morada, telemovel, email, foto_path, departamento_id, permissao_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    ''', (nome, morada, telemovel, email, foto_path, departamento_id, permissao_id))
    
    ligacao.commit() # Guarda as alterações definitivamente
    
    cursor.close()
    ligacao.close()
# 1. Função para apagar um funcionário pelo ID
def apagar_funcionario(id_func):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('DELETE FROM funcionarios WHERE id = %s;', (id_func,))
    ligacao.commit()
    
    cursor.close()
    ligacao.close()

# 2. Função para ir buscar os dados de APENAS UM funcionário (para preencher o formulário de edição)
def obter_funcionario(id_func):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('SELECT * FROM funcionarios WHERE id = %s;', (id_func,))
    func = cursor.fetchone()
    
    cursor.close()
    ligacao.close()
    return func

# 3. Função para atualizar os dados de texto
def atualizar_funcionario(id_func, nome, morada, telemovel, email, permissao_id):
    ligacao = obter_ligacao()
    cursor = ligacao.cursor()
    
    cursor.execute('''
        UPDATE funcionarios
        SET nome = %s, morada = %s, telemovel = %s, email = %s, permissao_id = %s
        WHERE id = %s;
    ''', (nome, morada, telemovel, email, permissao_id, id_func))
    
    ligacao.commit()
    
    cursor.close()
    ligacao.close()
