%livro(nome).
livro('Os Maias').

%autor(nome).
autor('Eça de Queiroz').

%nacionalidade(nome).
nacionalidade('português').
nacionalidade('inglês').

%tipo(nome).
tipo('romance').
tipo('ficção').

%escreveu(autor, livro).
escreveu('Eça de Queiroz', 'Os Maias').

%nacionalidade_autor(nacionalidade, autor).
nacionalidade_autor('português', 'Eça de Queiroz').

%tipo_livro(nome, tipo)
tipo_livro('Os Maias', 'romance').
tipo_livro('Os Maias', 'ficção').

%escreve_tipo(Autor, Tipo).
escreve_tipo(Autor, Tipo):-
    autor(Autor),
    tipo(Tipo),
    escreveu(Autor, Livro),
    tipo_livro(Livro, Tipo).

%autor_portugues_tipo(Nacionalidade, Tipo, Autor).
autor_portugues_tipo(Tipo, Autor):-
    nacionalidade('português'),
    escreve_tipo(Autor, Tipo),
    nacionalidade_autor('português', Autor).

%autor_ficcao_e_outro_tipo(Autor).
autor_ficcao_e_outro_tipo(Autor):-
    escreve_tipo(Autor, 'ficção'),
    escreve_tipo(Autor, Tipo),
    Tipo \= 'ficção'.


/*
a)escreveu(Autor, 'Os Maias').
b)autor_portugues_tipo(_'romance', Autor). 
  Na alínea b tentei fazer algo genérico, mas devido ao acento em português foi impossível
c)autor_ficcao_e_outro_tipo(Autor).
*/