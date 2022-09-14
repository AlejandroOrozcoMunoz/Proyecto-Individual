from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash

class Event:

    def __init__(self, data):
        self.id = data['id']
        self.event = data['event']
        self.location = data['location']
        self.attendees = data['attendees']
        self.date = data['date']
        self.time = data['time']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']
        self.user_id = data['user_id']

        # LEFT JOIN
        self.first_name = data['first_name']

    
    @classmethod
    def save(cls, formulario):
        query = "INSERT INTO events (event, location, attendees, date, time, user_id) VALUES (%(event)s, %(location)s, %(attendees)s, %(date)s, %(time)s, %(user_id)s) "
        result = connectToMySQL('medelliin').query_db(query, formulario)
        return result
    
    @classmethod
    def get_all(cls):
        query = "SELECT events.*, first_name  FROM events LEFT JOIN users ON users.id = events.user_id;"
        results = connectToMySQL('medelliin').query_db(query) #Lista de diccionarios 
        eventos = []
        for evento in results:
            #recipe = diccionario
            eventos.append(cls(evento)) 
        
        return eventos
    
    @classmethod
    def get_by_id(cls, formulario): #formulario = {id: 1}
        query = "SELECT events.*, first_name  FROM events LEFT JOIN users ON users.id = events.user_id WHERE events.id = %(id)s"
        result = connectToMySQL('medelliin').query_db(query, formulario) #Lista de diccionarios
        evento = cls(result[0])
        return evento
    
    @classmethod
    def update(cls, formulario):
        query = "UPDATE events SET event=%(event)s, location=%(location)s, attendees=%(attendees)s, date=%(date)s, time=%(times)s WHERE id = %(id)s"
        result = connectToMySQL('medelliin').query_db(query, formulario)
        return result