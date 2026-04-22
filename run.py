import os
from flask import Flask, render_template, request, redirect
from werkzeug.utils import secure_filename
from app.models import listar_departamentos, listar_permissoes, obter_departamento, listar_funcionarios_depto, inserir_funcionario, apagar_funcionario, obter_funcionario, atualizar_funcionario

app = Flask(__name__, template_folder='app/templates', static_folder='app/static')

# Pasta onde vamos guardar as fotografias
app.config['PASTA_FOTOS'] = 'app/static/img'

# 1. Rota da Página Inicial (Menu Windows 11)
@app.route('/')
def index():
    try:
        departamentos = listar_departamentos()
        permissoes = listar_permissoes()
        return render_template('index.html', departamentos=departamentos, permissoes=permissoes)
    except Exception as erro:
        return f"<h1>Erro na ligacao:</h1><p>{erro}</p>"

# 2. Rota para VER os funcionários de um Departamento (A rota que se perdeu!)
@app.route('/departamento/<int:id>')
def ver_departamento(id):
    try:
        depto = obter_departamento(id)
        funcionarios = listar_funcionarios_depto(id)
        return render_template('departamento.html', departamento=depto, funcionarios=funcionarios)
    except Exception as erro:
        return f"<h1>Erro:</h1><p>{erro}</p>"

# 3. Rota para ADICIONAR um novo funcionário
@app.route('/departamento/<int:id_depto>/adicionar', methods=['GET', 'POST'])
def adicionar_funcionario_rota(id_depto):
    if request.method == 'POST':
        # Recolhe os dados do formulário HTML
        nome = request.form['nome']
        morada = request.form['morada']
        telemovel = request.form['telemovel']
        email = request.form['email']
        permissao_id = request.form['permissao_id']
        
        # Trata da fotografia
        foto = request.files.get('foto')
        foto_path = None
        if foto and foto.filename:
            nome_seguro = secure_filename(foto.filename)
            foto.save(os.path.join(app.config['PASTA_FOTOS'], nome_seguro))
            foto_path = nome_seguro
            
        # Guarda na base de dados
        inserir_funcionario(nome, morada, telemovel, email, foto_path, id_depto, permissao_id)
        
        # Volta para a página do departamento
        return redirect(f'/departamento/{id_depto}')
        
    # Se não for POST (ou seja, apenas abrir a página), mostra o formulário vazio
    depto = obter_departamento(id_depto)
    permissoes = listar_permissoes()
    return render_template('adicionar.html', departamento=depto, permissoes=permissoes)

# Rota para APAGAR
@app.route('/departamento/<int:id_depto>/apagar/<int:id_func>')
def apagar_funcionario_rota(id_depto, id_func):
    apagar_funcionario(id_func)
    return redirect(f'/departamento/{id_depto}')

# Rota para EDITAR
@app.route('/departamento/<int:id_depto>/editar/<int:id_func>', methods=['GET', 'POST'])
def editar_funcionario_rota(id_depto, id_func):
    if request.method == 'POST':
        nome = request.form['nome']
        morada = request.form['morada']
        telemovel = request.form['telemovel']
        email = request.form['email']
        permissao_id = request.form['permissao_id']
        
        atualizar_funcionario(id_func, nome, morada, telemovel, email, permissao_id)
        return redirect(f'/departamento/{id_depto}')
        
    # Se for GET, vai buscar os dados e mostra o formulário preenchido
    func = obter_funcionario(id_func)
    depto = obter_departamento(id_depto)
    permissoes = listar_permissoes()
    return render_template('editar.html', departamento=depto, funcionario=func, permissoes=permissoes)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
