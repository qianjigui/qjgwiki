---
title: "Latex使用知识"
tags: Latex
---



#Latex#

##目录控制##
###经典用例###
充分利用自定义目录、标号和修正。


```latex
\documentclass[a4paper,jounral]{report}
\usepackage{../paper/sty/dcuappendices}
\input{../paper/src/config}
\usepackage[top=\finalReporttoptextmargin, bottom=\finalReportbottomtextmargin, left=\finalReportinnersidemargin, right=\finalReportoutersidemargin]{geometry}
\usepackage{pdfpages}
\input{src/global}
\input{src/config}

% Set link in the document
\usepackage{hyperref}
\hypersetup{colorlinks,%
            citecolor=black,%
            filecolor=black,%
            linkcolor=black,%
            urlcolor=black,%
            pdfauthor={\finalReportAuthor},
            pdftitle={\finalReportTitle},
            pdfsubject={xxx},
            pdfkeywords={xxx},
            pdftex
}
\usepackage{appendix}


\begin{document}
\pagenumbering{Roman}
\setcounter{page}{1}
\input{coversheet/coversheet}

\newpage
\pagenumbering{roman}
\setcounter{page}{1}
\pagestyle{ieeeheadings}

\input{coversheet/acknowledgements}

\newpage
\input{coversheet/declaration}

\newpage
\tableofcontents

\newpage
\pagenumbering{arabic}
\setcounter{page}{1}

\phantomsection
\addcontentsline{toc}{chapter}{\finalPaperBaseTitle}
\includepdf[pages=1-5]{../paper/output/main.pdf}

\appendix
\noappendicestocpagenum

\newpage
\setcounter{page}{0}

\phantomsection
\addcontentsline{toc}{chapter}{Appendices}

\renewcommand{\thepage}{A}
\phantomsection
\addcontentsline{toc}{section}{\finalPaperAppATitle}
\includepdf[pages=7]{../paper/output/main.pdf}

\renewcommand{\thepage}{A-\arabic{page}}
\includepdf[pages=-]{../../report/output/main-final.pdf}

\newpage
\setcounter{page}{0}

\renewcommand{\thepage}{B}
\phantomsection
\addcontentsline{toc}{section}{\finalPaperAppBTitle}
\includepdf[pages=9]{../paper/output/main.pdf}

\renewcommand{\thepage}{B-\arabic{page}}
\includepdf[pages=10-11]{../paper/output/main.pdf}

\newpage
\setcounter{page}{0}

\renewcommand{\thepage}{C}
\phantomsection
\addcontentsline{toc}{section}{\finalPaperAppCTitle}
\includepdf[pages=13]{../paper/output/main.pdf}

\renewcommand{\thepage}{C-\arabic{page}}
\includepdf[pages=14-16]{../paper/output/main.pdf}

\end{document}
```


##页面布局##
###自定义布局###

```latex
\ProvidesPackage{dcuappendices}

%Set Header & Footer
\def\ps@ieeeheadings{
\def\@oddhead{\mbox{}\scriptsize\MakeUppercase{\finalReportLeftheaderTitle} \hfil \thepage}%
\def\@evenhead{\mbox{}\scriptsize\MakeUppercase{\finalReportLeftheaderTitle} \hfil \thepage}%
\def\@oddfoot{}%
\def\@evenfoot{}}
```


###页面边距设置###

```latex
\usepackage[top=1in, bottom=1in, left=1.25in, right=1.25in]{geometry}
```


###强制figure,table进行放置停止float###
Try the placeins package: it defines a \FloatBarrier command beyond which floats may not pass.
A package option allows you to declare that floats may not pass a \section command, but you can place \FloatBarriers wherever you choose.


```latex
\usepackage[section]{placeins}
% Let the subsection can FloatBarrier
\let \oldsubsection \subsection
\renewcommand{\subsection}[2][]{
  \FloatBarrier
  \oldsubsection#1{#2}
}

% Let the subsubsection can FloatBarrier
\let \oldsubsubsection \subsubsection
\renewcommand{\subsubsection}[2][]{
  \FloatBarrier
  \oldsubsubsection#1{#2}
}
```


###How do I vertically center the text on a page?###
纵向居中:

```latex
\begin{document}
%
\vspace*{\fill}
text
\vspace*{\fill}
%
\end{document}
```


##合并PDF##

```latex
\usepackage{pdfpages}
\includepdf[pages=1-5]{../paper/output/main.pdf}
\includepdf[pages=-]{../paper/output/main.pdf}
\includepdf[pages=3-]{../paper/output/main.pdf}
\includepdf[pages=13]{../paper/output/main.pdf}
```


##字号字体##
[字体大小对照表](http://qianjigui.iteye.com/blog/841052)

###标准文档类型中字体的绝对大小###
|  *size*         |     10pt (default)|   11pt option|  12pt option | 
|------|------|------|------|
|  \tiny          |          5pt      |     6pt      |    6pt       |  
|  \scriptsize    |          7pt      |     8pt      |    8pt       |  
|  \footnotesize  |          8pt      |     9pt      |   10pt       |  
|  \small         |          9pt      |    10pt      |   11pt       |  
|  \normalsize    |         10pt      |    11pt      |   12pt       |  
|  \large         |         12pt      |    12pt      |   14pt       |  
|  \Large         |         14pt      |    14pt      |   17pt       |  
|  \LARGE         |         17pt      |    17pt      |   20pt       |  
|  \huge          |         20pt      |    20pt      |   25pt       |  
|  \Huge          |         25pt      |    25pt      |   25pt       |  

###印刷字号、磅数和级数一览表###
|  *号数*      |     *磅数(pt)* |          *尺寸（mm）*    |   
|------|------|------|
|  大特号    |      63  |        22.142          | 
|  特号      |      54  |        18.979          | 
|  初号      |      42  |        14.761          | 
|  小初号    |      36  |        12.653          | 
|  大一号    |     31.5 |        11.071          | 
|  一（头）号|       28 |         9.841          | 
|  小一号    |      24  |              很好匹配  | 
|  二号      |      22  |        7.381           | 
|  小二号    |      18  |        6.326  一般匹配 |  
|  三号      |      16  |        5.62  很好匹配  | 
|  小三      |  15      |  较好匹配              | 
|  四号      |      14  |        4.920 完美匹配  | 
|  小四号    |      12  |        4.218 完美匹配  | 
|  五号      |    10.5  |        3.690 很好匹配  | 
|  小五号    |       9  |         3.163 很好匹配 |  
|  六号      |       8  |        2.812 完美匹配  | 
|  小六号    |    6.875 |      2.416   很好匹配  | 
|  七号      |     5.25 |       1.845            | 
|  八号      |     4.5  |        1.581           | 

##Counter设置##
http://www.personal.ceu.hu/tex/counters.htm

##IEEE模板常见问题##
###IEEE模板的尾页如何平衡###
http://bbs.ctex.org/viewthread.php?tid=52302

使用LaTeX的双栏(twocolumn)格式在最后一页如果不加修改，通常会左面到底，右面悬空这样的两边不齐的样子，这通常不是我们想要的输出。如何使双栏的底端找齐呢？基本上有如下方法:
  1. 如果文章到最后是进入到参考文献的部分，可以在你觉得应该拐弯儿的地方加入\newpage命令。可是如果你的参考文献是用BibTeX来嵌入的话，就不好办了，虽然可以在.bbl文件里面加入，但是如果重新编译了BibTeX的话，.bbl文件会被重新刷新。如果是使用IEEEtran（用来向IEEE 会刊投稿的样式）的style的话，可以使用IEEE提供的\IEEEtriggeratref{x}命令，这个命令放在bibliography的前面，x就是你想要断开的文献号码。他会在第x个参考文献前面自动加入\newpage。
  1. 如果你的文档没有参考文献，或者很少，上面的方法就不适用了。这种情况下可以用\enlargethispage{-X.Yin}命令来使最后一页的左面栏的长度缩短。这个命令需要放在你最后一页第一栏的文字顶部某处，X.Y就是要缩小的量。在IEEEtran中命令变成了\IEEEtriggercmd{\enlargethispage{-5.35in}}的格式。
  1. 使用第三方的package。如：balance.sty或者flushend.sty。虽然他们都可以很方便的得到，但是不少杂志都不太接受这种非官方的包，因为这样也许会使排版变得不够标准。所以，很多目的都必须通过很传统的LaTeX命令来实现，这也正是深入了解LaTeX的必要性。
