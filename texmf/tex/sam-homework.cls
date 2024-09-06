\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sbaumohlhw}[A Custom Template for Sam Baumohl\'s homework assignments]
\LoadClass[]{book}
\RequirePackage{xcolor}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{lipsum}
\RequirePackage[twoside]{fancyhdr}
\RequirePackage[margin=0.65in]{geometry}
\RequirePackage[most]{tcolorbox}
\pagestyle{fancy}

% ifempty{str to check}{if not empty}{empty}
\newcommand{\ifempty}[3]{%
  \ifx\relax#1\relax
    #3
  \else
    #2
  \fi
}

% Command for setting the header for a homework assignment:
% 	1. Name
% 	2. Class
% 	3. Assignment Name
% 	4. Due date
% 	5. Prof
\newcommand{\hwhf}[5]{
	\lhead{#1}
	\chead{#2}
	\rhead{#3}
	\lfoot{#5}
	\cfoot{pg. \thepage}
	\rfoot{Due #4}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
}

\newtcolorbox[auto counter]{questionbox}[1][]{
  enhanced,
  colback=red!5!white,
  colframe=red!60!black,
  coltitle=white,
  fonttitle=\bfseries,
  title={Question \thetcbcounter \ifempty{#1}{\ (#1)}{}}
}

\newtcolorbox[auto counter]{answerbox}[1][]{
  enhanced,
  colback=cyan!5!white,
  colframe=cyan!60!black,
  coltitle=white,
  fonttitle=\bfseries,
  title={Answer}
}

%------ 
% 1. Question Subject
% 2. Question Text
% 3. Answer
\newcommand{\hwquestion}[3]{
	\begin{questionbox}[#1]
		#2
	\end{questionbox}

	% \vspace{2mm}

	\begin{answerbox}
		#3
	\end{answerbox}

	% \vspace{10mm}
  % \break
}

