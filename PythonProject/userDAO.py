from connectionDAO import get_connection, close_connection
from mysql.connector import Error
# 1. CREATE (INSERT - Inserir Novo Registro)
def create_record(nome, email):
    """Insere um novo usuário na tabela 'usuarios'."""
    conn = get_connection()
    if conn is None:
        return

    cursor = conn.cursor()
    # Query parametrizada: o %s é um placeholder seguro para evitar SQL Injection.
    query = "INSERT INTO usuarios (nome, email) VALUES (%s, %s)"
    data = (nome, email)

    try:
        cursor.execute(query, data)
        conn.commit()  # Confirma a transação para efetivar a inserção no banco.
        print(f"\n[CREATE - INSERT] Usuário {nome} inserido com sucesso! ID: {cursor.lastrowid}")
    except Error as e:
        print(f"\n[CREATE - INSERT] Erro ao inserir registro: {e}")
        conn.rollback() # Desfaz a transação em caso de erro.
    finally:
        close_connection(conn, cursor)

# 2. READ (SELECT - Consultar Dados)
def read_all_records():
    """Lê e exibe todos os registros da tabela 'usuarios'."""
    conn = get_connection()
    if conn is None:
        return []

    cursor = conn.cursor()
    query = "SELECT id, nome, email FROM usuarios"

    try:
        cursor.execute(query)
        records = cursor.fetchall() # Retorna todos os resultados como uma lista de tuplas.
        print("\n[READ - SELECT] Todos os Usuários:")
        if records:
            for row in records:
                # O resultado é uma tupla: (id, nome, email)
                print(f"   ID: {row[0]}, Nome: {row[1]}, Email: {row[2]}")
            return records
        else:
            print("   Nenhum registro encontrado.")
            return []
    except Error as e:
        print(f"\n[READ - SELECT] Erro ao ler registros: {e}")
        return []
    finally:
        close_connection(conn, cursor)


# 3. UPDATE (Atualizar Registro)
def update_record(user_id, novo_email):
    """Atualiza o email de um usuário específico pelo ID."""
    conn = get_connection()
    if conn is None:
        return False

    cursor = conn.cursor()
    # ATENÇÃO: O WHERE é crucial para atualizar apenas o registro desejado!
    query = "UPDATE usuarios SET email = %s WHERE id = %s"
    data = (novo_email, user_id)

    try:
        cursor.execute(query, data)
        conn.commit()
        if cursor.rowcount > 0:
            print(f"\n[UPDATE] Usuário ID {user_id} atualizado com sucesso. Novo email: {novo_email}")
            return True
        else:
            print(f"\n[UPDATE] Nenhum usuário encontrado com ID {user_id} para atualizar.")
            return False
    except Error as e:
        print(f"\n[UPDATE] Erro ao atualizar registro: {e}")
        conn.rollback() # Desfaz a transação
        return False
    finally:
        close_connection(conn, cursor)


# 4. DELETE (Deletar Registro)
def delete_record(user_id):
    """Deleta um usuário específico pelo ID."""
    conn = get_connection()
    if conn is None:
        return False

    cursor = conn.cursor()
    # ATENÇÃO: O WHERE é crucial para não deletar todos os registros!
    query = "DELETE FROM usuarios WHERE id = %s"
    data = (user_id,) # Tupla de um único elemento.

    try:
        cursor.execute(query, data)
        conn.commit()
        if cursor.rowcount > 0:
            print(f"\n[DELETE] Usuário ID {user_id} deletado com sucesso.")
            return True
        else:
            print(f"\n[DELETE] Nenhum usuário encontrado com ID {user_id} para deletar.")
            return False
    except Error as e:
        print(f"\n[DELETE] Erro ao deletar registro: {e}")
        conn.rollback() # Desfaz a transação
        return False
    finally:
        close_connection(conn, cursor)


# --- Demonstração do Fluxo ---
if __name__ == '__main__':
    print("--- DEMONSTRAÇÃO DO CRUD EM PYTHON ---")

    # 1. CREATE (INSERT)
    # Insere dois registros de exemplo
    create_record("Joao Silva", "joao.silva@exemplo.com")
    create_record("Maria Santos", "maria.santos@exemplo.com")

    # 2. READ (SELECT)
    # Lê todos os registros para determinar os IDs para as próximas operações
    all_users = read_all_records()

    if all_users:
        # Pega o ID do primeiro usuário inserido para o UPDATE
        user_to_update_id = all_users[0][0]
        # Pega o ID do último usuário inserido para o DELETE
        user_to_delete_id = all_users[-1][0]

        # 3. UPDATE
        # Altera o email do primeiro usuário
        update_record(user_to_update_id, "joao.silva.novo@empresa.com.br")

        # 4. DELETE
        # Deleta o último usuário
        delete_record(user_to_delete_id)

        # 5. READ (SELECT)
        # Leitura final para verificar as mudanças (apenas o usuário atualizado deve restar)
        print("\n--- Verificação Final ---")
        read_all_records()
    else:
        print("\nNenhum usuário inserido para continuar a demonstração de CRUD.")