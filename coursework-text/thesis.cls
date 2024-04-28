%
% ----------------------------------------------------------------------------
% Constantin S. Pan <kvapen@gmail.com> wrote this file. As long as you retain
% this notice you can do whatever you want with this stuff. If we meet some
% day, and you think this stuff is worth it, you can buy me a can of Coke in
% return.
% 	Constantin S. Pan
% ----------------------------------------------------------------------------
%

% Класс для ВКР на кафедре системного программирования ЮУрГУ.
% Использовать с XeLaTeX. Возможно, будет работать ещё и в LuaLaTeX.

\NeedsTeXFormat{LaTeX2e} % требуемая версия латеха
\ProvidesClass{diploma}
\LoadClass[unicode, oneside, 14pt, a4paper]{extarticle} % расширяем класс extarticle

% использузем пакеты
\usepackage{fontspec}
\defaultfontfeatures{Mapping=tex-text} %% стандартные лигатуры

% В XeTeX лучше использовать polyglossia вместо babel, но по какой-то
% загадочной причине он не подошёл. FIXME: разобраться и выяснить.
\usepackage[english,russian]{babel}

\usepackage{xecyr}
\newfontfamily\russianfont{Times New Roman}
\setromanfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}
\usepackage{extsizes}
\usepackage{dsfont}


\usepackage[top=2cm,left=3.5cm,bottom=2cm,right=1.5cm]{geometry}
\usepackage{indentfirst}
\usepackage{chngpage} % для изменения полей страницы
\usepackage{fancyvrb} % для вывода кода
\usepackage{longtable}
\usepackage{enumitem}  % кастомизация списков (чёртов topsep!)

\usepackage{graphicx}

\usepackage{subfig}
\captionsetup[subfigure]{labelformat=empty}

\usepackage{refcount}
\usepackage{lastpage}
\setcounter{tocdepth}{2} % в оглавление попадут только первые два уровня
\setcounter{secnumdepth}{3}
\frenchspacing % обычный пробел после точек, а не увеличенный

\linespread{1.3} % 1.3 = полуторный (sic!) интервал

%\bibliographystyle{gost780u}

\footskip=1em % отступ нижнего колонтитула

\usepackage{titlesec}

\titleformat{\section}[hang]{\bfseries\uppercase}{}{0pt}{\raggedright\thesection. }
\titleformat{name=\section,numberless}[hang]{\bfseries\uppercase}{}{0pt}{\raggedright}

\titleformat{\subsection}[hang]{\bfseries}{}{0pt}{\raggedright\thesubsection. }
\titleformat{name=\subsection,numberless}[hang]{\bfseries}{}{0pt}{\hspace{1.25cm}\raggedright}

\titleformat{\subsubsection}[hang]{\bfseries}{}{0pt}{\raggedright\thesubsubsection. }
\titleformat{name=\subsubsection,numberless}[hang]{\bfseries}{}{0pt}{\raggedright}

\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}

\renewcommand*\l@section[2]{%
	\ifnum \c@tocdepth >\m@ne% if this depth should be in TOC
		\setlength\@tempdima{1em}%
		\begingroup
			\parindent 0pt
			\rightskip \@pnumwidth plus 1fil% All lines skip right...
			\parfillskip -\@pnumwidth% .. except the last one.
			\uppercase#1\nobreak\dotfill\nobreak #2\par
		\endgroup
	\fi%
}
\renewcommand*\l@subsection[2]{%
	\ifnum \c@tocdepth >\m@ne% if this depth should be in TOC
		\setlength\@tempdima{2em}%
		\begingroup
			\parindent 0pt
			\rightskip \@pnumwidth plus 1fil% All lines skip right...
			\parfillskip -\@pnumwidth% .. except the last one.
			#1\nobreak\dotfill\nobreak #2\par
		\endgroup
	\fi%
}


% --------------- Bibliography uglification ---------------

\renewenvironment{thebibliography}[1]{%
	\section*{\refname \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
	\list{\@biblabel{\@arabic\c@enumiv}}{%
		\leftmargin 0pt
		%\advance\leftmargin\labelsep 
		\itemsep\z@skip    % should this be commented out?
		\parsep\z@skip     % should this be commented out?
		\itemindent 2cm
		\labelsep 0.25cm
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty
		\renewcommand\theenumiv{\@arabic\c@enumiv}%
	}%
}{%
	\endlist
}

\def\bibitem{\@ifnextchar[\@lbibitem\@bibitem}
\def\@lbibitem[#1]#2{\item[\@biblabel{#1}\hfill]\if@filesw
      {\let\protect\noexpand
       \immediate
       \write\@auxout{\string\bibcite{#2}{#1}}}\fi\ignorespaces}
\def\@bibitem#1{\item\if@filesw \immediate\write\@auxout
       {\string\bibcite{#1}{\the\value{\@listctr}}}\fi\ignorespaces}

% --------------------------------------------------------

\AtBeginDocument{
%\renewcommand{\bfdefault}{b} % чтобы жирный шрифт не был таким уродски широким
\renewcommand{\refname}{\uppercase{Литература}} % заголовок списка литературы
\renewcommand{\tablename}{Табл.} % начало подписи к таблице
\renewcommand{\contentsname}{\uppercase{Оглавление}} % заголовок оглавления
\renewcommand{\labelenumi}{\theenumi.} % нумерация float-ов
\renewcommand{\labelenumii}{\theenumi.\theenumii.} % нумерация float-ов
\renewcommand{\theenumi}{\arabic{enumi}} % нумерация списков арабскими числами
\renewcommand{\theenumii}{\arabic{enumii}} % нумерация списков арабскими числами
\newcommand{\figref}[1]{рис.~\ref{#1}} % быстрая ссылка на рисунок
\newcommand{\tabref}[1]{табл.~\ref{#1}} % быстрая ссылка на таблицу
}


\captionsetup[figure]{
  justification=centering,
  %labelfont=bf,
  labelsep=period
}

\captionsetup[table]{
  justification=raggedright,
  labelsep=period,
}

\setlength{\abovecaptionskip}{0em}
\makeatletter % сделать @ обычной буквой
	\renewcommand{\@biblabel}[1]{#1.\hfill} % нумерация списка литературы
	\renewcommand{\@oddfoot}{\hfill{}\raisebox{-1em}{\thepage}} % колонтитулы
	\def\capfigure{figure}
	\def\captable{table}
%	\renewcommand{\@makecaption}[2]{ % правильные названия табличкам и рисункам
%		\vspace{\abovecaptionskip}%
%		\sbox{\@tempboxa}{\textbf{#1.} #2}
%		\ifdim \wd\@tempboxa >\hsize
%			{\centering \textbf{#1.} #2\par}
%		\else
%			\ifx\@captype\capfigure
%				\global\@minipagefalse
%				\hbox to \hsize {\hfil \textbf{#1.} #2\hfil}%
%			\else
%				\hbox to \hsize {\textbf{#1.} #2\hfil\vspace{3dd}}%
%			\fi
%		\fi
%		\vspace{\belowcaptionskip}
%	}
%	\def\LT@makecaption#1#2#3{%
%		\LT@mcol
%		\LT@cols
%		l{\hbox to\z@{\parbox[t]\LTcapwidth{%
%			\small\hspace{-1ex}\textbf{#1{#2. }}#3\hfill%
%			%\sbox\@tempboxa{\textbf{#1{#2. }}#3}%
%			%	\ifdim\wd\@tempboxa>\hsize
%			%		\textbf{#1{#2. }}#3\hfil%
%			%	\else
%			%		\hbox to\hsize{\box\@tempboxa}\hfil%
%			%	\fi
%			%	\endgraf\vskip\baselineskip
%				}%
%			}
%		}
%	}

	\newcommand{\byte}[1]{\texttt{\{#1\}}}
	% Точка в заголовке раздела
	\renewcommand{\@seccntformat}[1]{%
		\csname the#1\endcsname.
	}
\def\numberline#1{\leavevmode\hbox to \@tempdima{#1.\hfil}}
\makeatother % сделать @ снова спецсимволом

% ---------- команда и окружение для вставки фрагментов кода -----------
\def\codecaptionunskip{\vspace{-1.2em}}
\DefineVerbatimEnvironment{code}{Verbatim}{frame=single,
fontsize=\small}
\RecustomVerbatimCommand{\VerbatimInput}{VerbatimInput}{frame=single, fontsize=\small}

% ---------- команда для вставки раздела без номера ----------
\newcommand{\sectionnonumber}[1]{\section*{#1}\addcontentsline{toc}{section}{%\hspace{7.5mm}
#1}}

% ---------- тупо рамочка ----------
\newenvironment{ramka}
	{
		\begin{tabular}{|p{7cm}|}
		\hline
	}
	{
		\\
		\hline
		\end{tabular}
	}

% ------- маркированный список с уменьшенными интервалами --------
\newenvironment{itemizesm}
	{
		\begin{itemize}[topsep=0pt, itemsep=0pt, parsep=0pt]
	}
	{
		\end{itemize}
	}

% ------- нумерованный список с уменьшенными интервалами --------
\newenvironment{enumeratesm}
	{
		\begin{enumerate}[topsep=0pt, itemsep=0pt, parsep=0pt]
	}
	{
		\end{enumerate}
	}

% ------ быстрая вставка рисунка -------
\setlength{\intextsep}{1em}
\newcommand{\fig}[3]{% params, label, caption
	\begin{figure}[h!]
		\center
		\includegraphics[#1]{#2}
		\caption{#3}
		\label{#2}
	\end{figure}
}
\newcommand{\figframe}[3]{% params, label, caption
	\begin{figure}[h!]
		\center
		\fbox{\includegraphics[#1]{#2}}
		\caption{#3}
		\label{#2}
	\end{figure}
}

% ------ команда для вставки "FIXME" ------
\newcommand{\fixme}[1]{%
	\vspace{1em}
	\hrule
	\vspace{1em}
	\noindent
	\textsf{\textbf{FIXME: #1}}
	\vspace{1em}
	\hrule
	\vspace{1em}
}

\newcommand{\underfield}{\underline{\hspace{7em}}}
\newcommand{\No}{\ifmmode{\nfss@text{\textnumero}}\else\textnumero\fi}

\usepackage{amsmath,amssymb} % математика
\newcommand*\Lapl{\mathop{}\!\mathbin\bigtriangleup}

\setlength{\parindent}{1.25cm}

\def\enumerateparen{
	\enumerate[itemindent=2cm, leftmargin=0cm, labelsep=0.25cm, topsep=0cm, itemsep=0cm, parsep=0cm, label=\arabic*), after=\vspace{-0.2cm}]
}
\let\endenumerateparen\endenumerate

\def\enumerateparendot{
	\enumerate[itemindent=2cm, leftmargin=0cm, labelsep=0.4cm, topsep=0cm, itemsep=0cm, parsep=0cm, label=\arabic*., after=\vspace{-0.2cm}]
}
\let\endenumerateparendot\endenumerate

\def\itemizecustom{
	\itemize[itemindent=2cm, leftmargin=0cm, labelsep=0.5cm, topsep=0cm, itemsep=0cm, parsep=0cm]
}
\let\enditemizecustom\enditemize

% -------------- Skip above and below the equations -----------------
\expandafter\def\expandafter\normalsize\expandafter{%
  \setlength\abovedisplayskip{0.5em}
  \setlength\belowdisplayskip{0.5em}
  \setlength\abovedisplayshortskip{0.0em}
  \setlength\belowdisplayshortskip{0.0em}
}
% -------------------------------------------------------------------


\newcommand{\todo}[1]{%
	\vspace{1em}
	\hrule
	\vspace{1em}
	\noindent
	\textit{\textbf{TODO}}  #1
	\vspace{1em}
	\hrule
	\vspace{1em}
}