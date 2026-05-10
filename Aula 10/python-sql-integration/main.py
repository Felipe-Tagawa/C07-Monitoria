from database import DatabaseManager
from config import MYSQL_CONFIG


def main():
    print("=== Python + MySQL Integration===\n")

    db = DatabaseManager(**MYSQL_CONFIG)

    # Inserir dados
    print("1. Inserindo dados de estudantes...")
    estudantes = [
        ("João Silva", 20, "Ciência da Computação", 8.5),
        ("Maria Santos", 19, "Engenharia", 9.2),
        ("Pedro Costa", 21, "Matemática", 7.8),
        ("Ana Oliveira", 20, "Ciência da Computação", 9.5),
        ("Lucas Ferreira", 22, "Física", 8.9)
    ]

    for estudante in estudantes:
        db.insert_estudante(estudante)
    print(f"   {len(estudantes)} estudantes inseridos\n")

    # Consultar todos
    print("2. Listando todos os estudantes:")
    all_students = db.get_all_estudantes()
    for idx, student in enumerate(all_students, 1):
        print(f"   {idx}. {student[1]} - Curso: {student[3]}, Nota: {student[4]}")

    # Consultar por curso
    print("\n3. Buscando estudantes de Ciência da Computação:")
    cc_students = db.get_estudantes_by_curso("Ciência da Computação")
    for student in cc_students:
        print(f"   - {student[1]}, Nota: {student[4]}")

    # Consultar com média
    print("\n4. Estatísticas:")
    stats = db.get_estatisticas()
    print(f"   - Total de estudantes: {stats['total']}")
    print(f"   - Media geral: {stats['media']:.2f}")
    print(f"   - Maior nota: {stats['max']}")
    print(f"   - Menor nota: {stats['min']}")

    # Atualizar nota
    print("\n5. Atualizando nota do João Silva...")
    db.update_nota(1, 9.0)
    updated = db.get_estudante_by_id(1)
    print(f"   Nova nota: {updated[4]}")

    # Deletar estudante
    print("\n6. Deletando estudante com ID 5...")
    db.delete_estudante(5)
    print("   Estudante deletado")

    # Finalizar
    print("\n7. Consulta final:")
    final_students = db.get_all_estudantes()
    for student in final_students:
        print(f"   - {student[1]} ({student[3]})")

    db.close()
    print("\nOperacoes concluidas!")

if __name__ == "__main__":
    main()
