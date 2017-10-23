" 
"
" Abbreviationst or misspellings
"
"
"

" Some time my fingers failed
abbr itme item
abbr foonote footnote
abbr retrun return
abbr rigth right
abbr varaible variable
abbr vpsace vspace

" Java abbreviations
" To the end of the line you find some chars for well positionning the cursor
" (try with and without) 
abbr sout System.out.println("");<esc>hhha  
abbr serr System.err.println("");<esc>hhha   
abbr souf System.out.printf("");<esc>hhha  
abbr pr private
abbr st static
abbr _scanner import java.util.Scanner ; <cr>
abbr _class public class <esc>:r!echo %:r<cr><up>A<del><end> { <cr>
abbr _main public static void main (String[] args) { <cr>
abbr _clavier Scanner keyboard = new Scanner (System.in); 
abbr _entete /** <cr> <esc>:r!echo %:r<cr><up>A<del><end> <cr><cr>@author PbT<cr>@since <esc>:r!date +"\%d \%B \%Y" <esc>i<bs><end><cr>/<cr><esc>kkkkko


"
" 
" I don't speak good English. I like to say it when I speak on a forum or by
" mail.
abbr _E (English is not my native language)


" Just for "fun" or exercice me
iab ladate <C-R>=strftime("%A %d %B %Y")<CR>
iab lheure <C-R>=strftime("%H:%M")<CR>


" Last abbreviation
" Automaticaly close '{' by '} // end <name>'
iab }// } // end - <esc>10h%$?\w\+\s*(<cr>"xy/\s*(<cr>/{<cr>:nohl<cr>%$"xpa 
