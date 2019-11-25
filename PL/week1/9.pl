aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

%aluno_do_professor(+NomeProfessor, -NomeAluno)
aluno_do_professor(Professor, Aluno) :-
    professor(Professor, Disciplina),
    aluno(Aluno, Disciplina).

%pessoa_da_universidade(+NomeUniversidade, -NomePessoa)
pessoa_da_universidade(Universidade, Pessoa) :-
    frequenta(Pessoa, Universidade);
    funcionario(Pessoa, Universidade).

%colega(?Pessoa1, ?Pessoa2)
colega(Pessoa1, Pessoa2) :- (
        aluno(Pessoa1, D1),
        aluno(Pessoa2, D1);
        frequenta(Pessoa1, U1),
        frequenta(Pessoa2, U1);
        funcionario(Pessoa1, U2),
        funcionario(Pessoa2, U2)
    ),
    Pessoa1 \= Pessoa2.