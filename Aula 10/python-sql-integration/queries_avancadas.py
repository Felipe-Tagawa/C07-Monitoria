from database import DatabaseManager

def demo_queries_avancadas():
    print("=== Queries MySQL Avançadas ===\n")

    db = DatabaseManager(
        host="localhost",
        user="root",
        password="",  # Coloque sua senha do MySQL
        database="monitoria_db"
    )

    # 1. GROUP BY com agregação
    print("1. Query com agregação (GROUP BY):")
    query = """
    SELECT curso, COUNT(*) as qtd, AVG(nota) as media
    FROM estudantes
    GROUP BY curso
    ORDER BY media DESC
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   {row[0]}: {row[1]} estudantes, média {row[2]:.2f}")

    # 2. HAVING - filtrar grupos
    print("\n2. HAVING (cursos com média > 8.0):")
    query = """
    SELECT curso, AVG(nota) as media
    FROM estudantes
    GROUP BY curso
    HAVING AVG(nota) > 8.0
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   {row[0]}: média {row[1]:.2f}")

    # 3. Subquery
    print("\n3. Subquery (estudantes com nota acima da média):")
    query = """
    SELECT nome, nota
    FROM estudantes
    WHERE nota > (SELECT AVG(nota) FROM estudantes)
    ORDER BY nota DESC
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   {row[0]}: {row[1]}")

    # 4. CASE WHEN
    print("\n4. CASE WHEN (classificação por nota):")
    query = """
    SELECT nome, nota,
        CASE
            WHEN nota >= 9.0 THEN 'Excelente'
            WHEN nota >= 8.0 THEN 'Muito Bom'
            WHEN nota >= 7.0 THEN 'Bom'
            ELSE 'Precisa Melhorar'
        END as classificacao
    FROM estudantes
    ORDER BY nota DESC
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   {row[0]}: {row[1]} - {row[2]}")

    # 5. LIMIT e OFFSET (paginação)
    print("\n5. Paginação (LIMIT 2 OFFSET 1):")
    query = """
    SELECT nome, nota, curso
    FROM estudantes
    ORDER BY nota DESC
    LIMIT 2 OFFSET 1
    """
    cursor = db.execute_query(query).fetchall()
    for i, row in enumerate(cursor, 2):
        print(f"   {i}. {row[0]} ({row[2]}): {row[1]}")

    # 6. DISTINCT
    print("\n6. DISTINCT (cursos únicos):")
    query = """
    SELECT DISTINCT curso
    FROM estudantes
    ORDER BY curso
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   - {row[0]}")

    # 7. IFNULL (equivalente ao COALESCE no MySQL)
    print("\n7. IFNULL (tratamento de nulos):")
    query = """
    SELECT nome, IFNULL(nota, 0) as nota
    FROM estudantes
    WHERE id = 1
    """
    cursor = db.execute_query(query).fetchone()
    print(f"   {cursor[0]}: nota = {cursor[1]}")

    # 8. Funções de string MySQL
    print("\n8. Funções MySQL (LENGTH, UPPER, CONCAT):")
    query = """
    SELECT UPPER(nome) as nome_maiusculo,
           LENGTH(nome) as tamanho_nome,
           UPPER(curso) as curso
    FROM estudantes
    LIMIT 3
    """
    cursor = db.execute_query(query).fetchall()
    for row in cursor:
        print(f"   {row[0]} ({row[1]} chars) - {row[2]}")

    # 9. JOIN (exemplo com duas tabelas)
    print("\n9. Exemplo de estrutura para JOIN:")
    print("   Para usar JOIN, crie outra tabela (ex: departamentos)")
    print("   SELECT e.nome, e.curso, d.nome_departamento")
    print("   FROM estudantes e")
    print("   INNER JOIN departamentos d ON e.curso = d.id_curso")

    # 10. Funções de data
    print("\n10. Funções de data (CURRENT_DATE, etc.):")
    query = """
    SELECT CURRENT_DATE() as hoje,
           CURRENT_TIME() as hora,
           NOW() as agora
    """
    cursor = db.execute_query(query).fetchone()
    print(f"   Data: {cursor[0]}, Hora: {cursor[1]}, Agora: {cursor[2]}")

    db.close()
    print("\nQueries MySQL demonstradas!")

if __name__ == "__main__":
    demo_queries_avancadas()
