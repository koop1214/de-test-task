import sys
from collections import defaultdict
from typing import Dict


def get_median(salaries: Dict, employees_num: int) -> int:
    median = 0
    counter = 0
    half_num = employees_num / 2
    sort_salaries = dict(sorted(salaries.items(), key=lambda item: item[0]))

    for salary, num in sort_salaries.items():
        counter += num
        median = salary

        if counter > half_num:
            break

    return median


def get_upper_num(salaries: Dict, avg_salary: float) -> int:
    upper_salaries = {k: v for k, v in salaries.items() if k > avg_salary}
    upper_salaries_num = sum(upper_salaries.values())

    return upper_salaries_num


def main(source):
    employees_num = 0
    k_employees_num = 0
    salary_amount = 0
    min_salary = sys.maxsize
    max_salary = 0
    salaries = defaultdict(int)

    for line in source:
        parts = line.split()
        employee = parts[0]
        salary = int(parts[1])

        employees_num += 1
        salary_amount += salary
        salaries[salary] += 1

        if salary < min_salary:
            min_salary = salary

        if salary > max_salary:
            max_salary = salary

        if employee[0] == "K":
            k_employees_num += 1

    if employees_num == 0:
        print("Нет данных")
        exit(0)

    avg_salary = salary_amount / employees_num
    upper_salaries_num = get_upper_num(salaries, avg_salary)

    median = get_median(salaries, employees_num)

    print("Кол-во сотрудников:", employees_num)
    print("Кол-во сотрудников, чьи фамилии начинаются на букву «K»:", k_employees_num)
    print("Общая сумма зарплат:", salary_amount)
    print("Минимальная зарплата:", min_salary)
    print("Максимальная зарплата:", max_salary)
    print("Средняя зарплата:", avg_salary)
    print("Кол-во сотрудников, получающих сумму строго большую, чем средняя зарплата:", upper_salaries_num)
    print("Медиана от зарплат:", median)


if __name__ == '__main__':
    if len(sys.argv) - 1 > 0:
        path = sys.argv[1]

        with open(path) as file:
            main(file)
    else:
        main(sys.stdin)
