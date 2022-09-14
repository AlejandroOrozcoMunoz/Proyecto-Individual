from flask import render_template, redirect, session, request, flash
from flask_app import app

#Importación del modelo
from flask_app.models.users import User
from flask_app.models.events import Event

@app.route('/new/event')
def new_event():
    if 'user_id' not in session: #Comprobamos que el usuario haya iniciado sesiónh
        return redirect('/')

    formulario = {
        'id': session['user_id']
    }

    user = User.get_by_id(formulario) #Instancia del usuario que inicio sesión

    return render_template('new_event.html', user=user)


@app.route('/create/event', methods=['POST'])
def create_event():
    if 'user_id' not in session: #Comprobamos que el usuario haya iniciado sesión
        return redirect('/')

    Event.save(request.form)

    return redirect('/dashboard')

@app.route('/edit/event/<int:id>') #a través de la URL recibimos el ID de la receta
def edit_event(id):
    if 'user_id' not in session: #Comprobamos que el usuario haya iniciado sesiónh
        return redirect('/')

    formulario = {
        'id': session['user_id']
    }

    user = User.get_by_id(formulario) #Instancia del usuario que inicio sesión

    formulario_event = {"id": id}
    evento = Event.get_by_id(formulario_event)

    return render_template('edit_event.html', user=user, evento=evento)


@app.route('/update/event', methods=['POST'])
def update_event():
    if 'user_id' not in session: #Comprobamos que el usuario haya iniciado sesiónh
        return redirect('/')
    
    Event.update(request.form)
    return redirect('/dashboard')

@app.route('/view/event/<int:id>') #A través de la URL recibimos el ID de la receta
def event_recipe(id):
    if 'user_id' not in session: #Solo puede ver la página si ya inició sesión 
        return redirect('/')

    formulario = {
        "id": session['user_id']
    }

    user = User.get_by_id(formulario) #Usuario que inició sesión


    formulario_evento = { "id": id }
    #llamar a una función y debo de recibir la receta
    evento = Event.get_by_id(formulario_evento)

    return render_template('view_event.html', user=user, evento=evento)




