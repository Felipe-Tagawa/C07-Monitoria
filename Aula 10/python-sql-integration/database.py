import mysql.connector
from config import MYSQL_CONFIG
from mysql.connector import Error

class DatabaseManager:
    def __init__(self, host="127.0.0.1", user="root", password="root", database="monitoria_db"):
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.conn = None
        self.cursor = None
        self.connect()

    def connect(self):
        """Estabelece conexão com o banco de dados MySQL"""
        try:
            self.conn = mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database
            )
            self.cursor = self.conn.cursor()
            print(f"Conectado ao MySQL: {self.database}")
        except Error as e:
            print(f"Erro de conexão: {e}")
            raise

    def close(self):
        """Fecha a conexão com o banco de dados"""
        if self.conn:
            self.cursor.close()
            self.conn.close()
            print("Conexão fechada")

    def execute_query(self, query, params=None):
        """Executa uma query SQL genérica"""
        if params:
            self.cursor.execute(query, params)
        else:
            self.cursor.execute(query)
        self.conn.commit()
        return self.cursor

    def insert_estudante(self, estudante):
        """Insere um novo estudante"""
        query = "INSERT INTO estudantes (nome, idade, curso, nota) VALUES (%s, %s, %s, %s)"
        self.execute_query(query, estudante)

    def get_all_estudantes(self):
        """Retorna todos os estudantes"""
        query = "SELECT * FROM estudantes ORDER BY nota DESC"
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_estudante_by_id(self, student_id):
        """Retorna um estudante pelo ID"""
        query = "SELECT * FROM estudantes WHERE id = %s"
        self.cursor.execute(query, (student_id,))
        return self.cursor.fetchone()

    def get_estudantes_by_curso(self, curso):
        """Retorna estudantes de um curso específico"""
        query = "SELECT * FROM estudantes WHERE curso = %s ORDER BY nota DESC"
        self.cursor.execute(query, (curso,))
        return self.cursor.fetchall()

    def get_estudantes_by_nota_range(self, min_nota, max_nota):
        """Retorna estudantes com nota em um intervalo"""
        query = "SELECT * FROM estudantes WHERE nota BETWEEN %s AND %s ORDER BY nota DESC"
        self.cursor.execute(query, (min_nota, max_nota))
        return self.cursor.fetchall()

    def get_estatisticas(self):
        """Retorna estatísticas dos estudantes"""
        query = """
        SELECT
            COUNT(*) as total,
            AVG(nota) as media,
            MAX(nota) as max,
            MIN(nota) as min
        FROM estudantes
        """
        self.cursor.execute(query)
        result = self.cursor.fetchone()
        return {
            'total': result[0],
            'media': float(result[1]) if result[1] else 0,
            'max': float(result[2]) if result[2] else 0,
            'min': float(result[3]) if result[3] else 0
        }

    def update_nota(self, student_id, nova_nota):
        """Atualiza a nota de um estudante"""
        query = "UPDATE estudantes SET nota = %s WHERE id = %s"
        self.execute_query(query, (nova_nota, student_id))

    def update_estudante(self, student_id, nome, idade, curso, nota):
        """Atualiza todos os dados de um estudante"""
        query = """
        UPDATE estudantes
        SET nome = %s, idade = %s, curso = %s, nota = %s
        WHERE id = %s
        """
        self.execute_query(query, (nome, idade, curso, nota, student_id))

    def delete_estudante(self, student_id):
        """Deleta um estudante"""
        query = "DELETE FROM estudantes WHERE id = %s"
        self.execute_query(query, (student_id,))

    def search_by_name(self, nome):
        """Busca estudantes por nome (case insensitive)"""
        query = "SELECT * FROM estudantes WHERE LOWER(nome) LIKE LOWER(%s)"
        self.cursor.execute(query, (f"%{nome}%",))
        return self.cursor.fetchall()

    def get_top_students(self, limit=3):
        """Retorna os N estudantes com maiores notas"""
        query = "SELECT * FROM estudantes ORDER BY nota DESC LIMIT %s"
        self.cursor.execute(query, (limit,))
        return self.cursor.fetchall()
