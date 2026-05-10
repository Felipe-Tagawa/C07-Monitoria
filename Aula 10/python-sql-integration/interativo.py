from database import DatabaseManager
from config import MYSQL_CONFIG

def menu():
    print("\n=== Sistema de Gestão de Estudantes (MySQL) ===")
    print("1. Inserir estudante")
    print("2. Listar todos")
    print("3. Buscar por curso")
    print("4. Buscar por nome")
    print("5. Atualizar nota")
    print("6. Deletar estudante")
    print("7. Ver estatísticas")
    print("8. Top 3 estudantes")
    print("0. Sair")
    print("=" * 40)

def main():
    db = DatabaseManager(**MYSQL_CONFIG)

    while True:
        menu()
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            nome = input("Nome: ")
            idade = int(input("Idade: "))
            curso = input("Curso: ")
            nota = float(input("Nota: "))
            db.insert_estudante((nome, idade, curso, nota))
            print("Estudante inserido!")

        elif opcao == "2":
            estudantes = db.get_all_estudantes()
            print("\n=== Todos os Estudantes ===")
            for s in estudantes:
                print(f"[{s[0]}] {s[1]}, {s[2]} anos, {s[3]}, Nota: {s[4]}")

        elif opcao == "3":
            curso = input("Curso: ")
            estudantes = db.get_estudantes_by_curso(curso)
            print(f"\n=== Estudantes de {curso} ===")
            for s in estudantes:
                print(f"[{s[0]}] {s[1]}, Nota: {s[4]}")

        elif opcao == "4":
            nome = input("Nome (ou parte): ")
            estudantes = db.search_by_name(nome)
            print(f"\n=== Resultados para '{nome}' ===")
            for s in estudantes:
                print(f"[{s[0]}] {s[1]}, {s[3]}, Nota: {s[4]}")

        elif opcao == "5":
            student_id = int(input("ID do estudante: "))
            nova_nota = float(input("Nova nota: "))
            db.update_nota(student_id, nova_nota)
            print("Nota atualizada!")

        elif opcao == "6":
            student_id = int(input("ID do estudante: "))
            confirm = input(f"Tem certeza que deseja deletar ID {student_id}? (s/n): ")
            if confirm.lower() == 's':
                db.delete_estudante(student_id)
                print("Estudante deletado!")

        elif opcao == "7":
            stats = db.get_estatisticas()
            print("\n=== Estatísticas ===")
            print(f"Total: {stats['total']}")
            print(f"Media: {stats['media']:.2f}")
            print(f"Maior nota: {stats['max']}")
            print(f"Menor nota: {stats['min']}")

        elif opcao == "8":
            top = db.get_top_students(3)
            print("\n=== Top 3 Estudantes ===")
            for i, s in enumerate(top, 1):
                print(f"{i}. {s[1]} - Nota: {s[4]}")

        elif opcao == "0":
            db.close()
            print("Ate mais!")
            break

        else:
            print("Opção inválida!")

if __name__ == "__main__":
    main()
