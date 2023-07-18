__includes [ "to_setup.nls" "rotinas.nls"]
extensions [profiler]

breed [fishes fish] ;--------------------------------------------------------------------> Criar o agente peixe laranja
breed [lamps anglerfish] ;---------------------------------------------------------------> Criar o agente peixe-lanterna
breed [corpses corpse] ;-----------------------------------------------------------------> Criar o agente corpo
breed [foods food] ;---------------------------------------------------------------------> Criar o agente comida
breed [dungs dung] ;---------------------------------------------------------------------> Criar o agente dejetos
breed [sands sand] ;---------------------------------------------------------------------> Criar o agente areia
breed [rocks rock] ;---------------------------------------------------------------------> Criar o agente pedras
breed [snails snail] ;-------------------------------------------------------------------> Criar o agente caracol
breed [cleaners cleaner] ;---------------------------------------------------------------> Criar o agente peixe-pleco
breed [resistances resistance] ;---------------------------------------------------------> Criar o agente resistência
breed [bombs bomb] ;---------------------------------------------------------------------> Criar o agente resistência
breed [nutrientes nutriente] ;-----------------------------------------------------------> Criar o agente nutriente
breed [seaweeds seaweed] ;---------------------------------------------------------------> Criar o agente algas
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////VARIAVEIS GLOBAIS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
globals
[ok xx yy i ok_corpse global_int fishes_breed leader leader_found leader_xy leader_x leader_y leader_heading temp_x temp_y temp_xx temp_yy temp_xxx temp_yyy temp_aux temp_auxtwo precisa_ligar? mostra med_temp]
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////VARIAVEIS DOS AGENTES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
patches-own [lixo temp]
fishes-own  [age eaten last_meal dung_size fish_hidden shoal_leader recent_parent]
lamps-own   [age eaten last_meal dung_size fish_hidden shoal_leader recent_parent]
dungs-own   [dung_size dung_birth dung_age dung_xx dung_yy dung_iterator dung_iterator_2 dung_up]
foods-own   [food_birth food_age food_xx food_yy food_iterator food_iterator_2 food_up]
snails-own  [snail_heading snail_xx snail_yy snail_iterator snail_iterator_2 snail_up can_clean snail_size]
cleaners-own[can_clean]
rocks-own   [rock_time rock_busy]
corpses-own [corpse_x corpse_y]
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
to test
profiler:start         ;; start profiling
repeat 20 [ go ]       ;; run something you want to measure
profiler:stop          ;; stop profiling
print profiler:report  ;; view the results
profiler:reset         ;; clear the data
end
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
to go ; Definição da Função 'go' (chamada por um botão)
  if(remainder ticks 500) = 0
  [
    aumenta-temperatura
  ]

;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)----------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask fishes ;---------------------------------------------------------------------------> Perguntar aos peixes laranja
    [
      set fishes_breed 1
      verifica_heading
      escolhe_lider
      define_info_lider
      recolhe_info_lider_cardume
      muda_direcao_aleatoriamente 50000 270 -90
      envelhecer 250
      verifica_condicoes_morte size age 29 6 15
      verifica_condicoes_alimentacao last_meal 5000 -1
      if (fish_hidden = false)
      [
        verifica_limites_aquario
        forward 1
      ]
      verifica_nutrientes
      procreate
      if ((age > 2) and (color = 65))
      [
        set color red
      ]
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FISHES)---
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    turn_dead
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask lamps ;---------------------------------------------------------------------------> Perguntar aos peixes lanterna
    [
      set fishes_breed 2
      verifica_heading
      muda_direcao_aleatoriamente 50000 270 -90
      envelhecer 250
      verifica_condicoes_morte size age 29 6 15
      verifica_condicoes_alimentacao last_meal 5000 -1
      if (fish_hidden = false)
      [
        verifica_limites_aquario
        forward 1
      ]
      verifica_nutrientes
      procreate
      if ((age > 2) and (color = 65))
      [
        set color magenta
      ]
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK LAMPS)---------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    turn_dead
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask foods ;---------------------------------------------------------------------------> Perguntar às comidas
    [
      deslocamento_aleatorio_foods
      verifica_comido
      set food_age food_age + 1 ;---------------------------------------------------> O pedaço de comida fica "mais velho" a cada tick se não for comido
      verifica_decomposicao
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK FOODS)---------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" CRIAÇÃO DE DEJETOS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    if (ok > 0) ;--------------------------------------------------------------------------> Se os peixes comeram...
    [
      create-dungs 1 ;-------------------------------------------------------------------> ... é criado 1 dejedo de cada vez
      [
        set shape "poop" ;-------------------------------------------------------------> Definir a forma/imagem dos dejeto
        setxy xx yy ;------------------------------------------------------------------> Definir as coordenadas do dejeto com base nas coordenadas da comida
        set heading 180 ;--------------------------------------------------------------> Definir a orientação do dejeto
        set size random 5 + 5 ;--------------------------------------------------------> Definir o tamanho do dejeto aleatoriamente ente 5 e 10
        set dung_size size ;-----------------------------------------------------------> Definir variável local que regista o tamanho do dejeto (relacionado com a sua posterior poluição da água)
        set dung_birth dung_birth + int (ticks) ;--------------------------------------> Definir variável local que regista o momento (ticks) em que o dejeto foi criado
        set dung_iterator 0 ;----------------------------------------------------------> Definir variável local [1] para iterar em loops para "espalhar" a poluição do dejeto quando este se desintegra
        set dung_iterator_2 0 ;--------------------------------------------------------> Definir variável local [2] para iterar em loops para "espalhar" a poluição do dejeto quando este se desintegra
        set dung_age 0 ;---------------------------------------------------------------> Definir variável local que regista o tempo/idade (ticks-dung_birth) em que o dejeto foi criado
        set dung_up 0 ;----------------------------------------------------------------> Definir variável local que é uma flag posicional relacionada com a poluição da água
      ]
      set ok 0 ;------------------------------------------------------------------> "Reset" da flag relacionada com a criação de dejetos
    ]
;   -----------------------------------------------------------------------------------------------------------S-E-C-T-I-O-N---E-N-D----------------------------------------------------------------------------------------------------------------------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask dungs ;----------------------------------------------------------------------------> Perguntar aos Dejetos
    [
      set dung_age dung_age + 1 ;--------------------------------------------------------> Aumento da idade dos dejetos a cada Tick
      suja_na_passagem
      desintegrar
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK DUNGS)---------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    set ok 0
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)----------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask snails ;--------------------------------------------------------------------------> Perguntar aos Caracóis
    [
      forward 0.05 ;-------------------------------------------------------------------> ... desloca-se uma casa
      muda_direcao_aleatoriamente 500 1.5 one-of [-90 90]
      limites_caracois
      shape_caracois
      set can_clean 0;
      ask patch-here ;------------------------------------------------------------> Pergunta às celulas
      [
        if count corpses-here = 1 ;------------------------------------------------------> Caso numa mesma célula se encontre um peixe laranja e comida
        [
          ask corpses-here
          [
            set xx xcor
            set yy ycor
            set ok 1
            die
          ]
        ]
      ]
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK SNAILS)---
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if (ok > 0)
    [
      convert_corpses xx yy
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask cleaners
    [
      forward 0.1 ;-------------------------------------------------------------------> ... desce uma casa
      muda_direcao_aleatoriamente 500 360 0
      limpar_lixo
      (ifelse ;------------------------------------------------------------------------> Caso:
          pycor = 0 ;--------------------------------------------------------> - a coordenada do peixe laranja em y seja 90 - 6 ...
            [
              muda_direcao_aleatoriamente 1 180 90
            ]
          pycor = min-pycor + 6 ;--------------------------------------------------------> - a coordenada do peixe laranja em y seja - 90 + 6
            [
              muda_direcao_aleatoriamente 1 180 -90
            ])
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK CLEANERS)---F-I-M---D-A---S-E-C-Ç-Ã-O--------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---I-N-I-C-I-O---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---------------------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ask rocks
    [
      shape_pedra
      hide_under_rock
      get_out_rock
    ]
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;   F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---F-I-M---D-A---S-E-C-Ç-Ã-O---(ASK ROCKS)---------
;   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if ((remainder ticks 1000 = 0) AND ticks != 0)
  [
    ask seaweeds
    [
      ask patches in-radius 10
      [
        set lixo 0
      ]
    ]
  ]
  if(remainder ticks 1500 = 0)[
    switches ;--------------------------------------------------------------------------> Chama o procedimento 'swtiches'
  ]
  tick
end
@#$#@#$#@
GRAPHICS-WINDOW
215
10
1006
461
-1
-1
2.442
1
10
1
1
1
0
1
1
1
-160
160
-90
90
0
0
1
ticks
30.0

BUTTON
34
10
206
43
Setup
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
34
45
206
78
Go
go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

SLIDER
690
468
842
501
Peixes_Laranja
Peixes_Laranja
0
100
20.0
1
1
NIL
HORIZONTAL

SLIDER
852
469
1005
502
Peixes_Lanterna
Peixes_Lanterna
0
100
20.0
1
1
NIL
HORIZONTAL

MONITOR
574
468
688
513
% de sujidade
mean[lixo] of patches * 12.5
5
1
11

PLOT
1013
10
1323
160
População Laranja
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count fishes"

BUTTON
34
80
206
113
Feed
Feed
NIL
1
T
OBSERVER
NIL
F
NIL
NIL
1

SLIDER
690
502
1005
535
QuantFood
QuantFood
0
1000
150.0
1
1
NIL
HORIZONTAL

PLOT
1013
163
1323
313
População Lanterna
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count lamps"

PLOT
34
118
206
268
Idade Média dos Peixes
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot ((mean[age] of fishes) + (mean[age] of lamps)) / 2"

MONITOR
452
468
569
513
Pedaços Comidos
sum[eaten] of fishes
0
1
11

MONITOR
215
468
329
513
Comida Disponível
count foods
17
1
11

MONITOR
333
468
447
513
Dejetos
count dungs
17
1
11

PLOT
1013
316
1323
536
População Geral
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Laranja" 1.0 0 -955883 true "" "plot count (fishes)"
"Lanterna" 1.0 0 -5825686 true "" "plot count (lamps)"

PLOT
34
269
206
389
Idade Média Laranja
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -955883 true "" "plot mean[age] of fishes"

PLOT
34
393
206
513
Idade Média Lanterna
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -5825686 true "" "plot mean[age] of lamps"

CHOOSER
1336
140
1619
185
patches_mostra?
patches_mostra?
"Temperatura" "Qualidade"
1

SWITCH
1336
193
1619
226
resistencia_ligada?
resistencia_ligada?
1
1
-1000

MONITOR
1336
267
1619
312
Temperatura
36 - mean[temp] of patches
2
1
11

PLOT
1336
316
1620
534
Qualidade da água
NIL
NIL
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"default" 1.0 0 -13791810 true "" "plot (100 - (mean[lixo] of patches * 12.5))"

BUTTON
1329
656
1614
782
test
test
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
1337
230
1619
263
troca_temperatura?
troca_temperatura?
1
1
-1000

SWITCH
1330
619
1613
652
bomba_ligada?
bomba_ligada?
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

algas
false
0
Polygon -13840069 true false 150 0 180 45 180 105 120 195 120 255 150 300 150 270
Polygon -10899396 true false 150 300 135 255 135 195 165 105 165 45 150 0 150 30

algas_2
false
0
Polygon -10899396 true false 165 30 180 45 180 105 150 150 120 195 120 270 150 300 150 255 150 225 150 195 150 180 150 150 150 105 150 60 150 30 105 0
Polygon -13840069 true false 165 30 165 45 165 105 150 150 135 195 135 255 150 300 150 255 150 225 150 195 150 180 150 150 150 105 150 60 150 30 135 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bomba
false
0
Polygon -16777216 true false 285 135 255 90 285 45
Rectangle -7500403 true true 105 75 165 135
Circle -7500403 true true 75 75 60
Circle -16777216 true false 84 84 42
Rectangle -7500403 true true 135 45 270 285
Polygon -7500403 true true 285 135 270 90 285 45
Circle -7500403 true true 99 84 42
Rectangle -16777216 true false 240 255 270 270
Rectangle -16777216 true false 240 225 270 240
Rectangle -16777216 true false 240 195 270 210
Polygon -7500403 true true 210 45 210 0 195 0 195 45

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

caracol_l
false
0
Circle -16777216 true false 75 30 240
Polygon -13840069 true false 105 135 120 180 135 195 165 225 210 240 270 210 285 180 300 135 300 105 315 60 315 240 285 270 255 285 225 300 180 300 105 285 90 270 75 255 60 225 45 195 30 165 30 135
Circle -6459832 true false 90 45 210
Polygon -13840069 true false 15 30 45 105 60 90 15 15
Circle -13840069 true false 90 0 30
Polygon -13840069 true false 105 30 75 105 60 90 105 15
Circle -13840069 true false 0 60 120
Circle -1 true false 69 84 42
Circle -1 true false 9 84 42
Circle -13840069 true false 0 0 30
Circle -16777216 true false 75 90 30
Circle -16777216 true false 15 90 30
Circle -1 true false 47 135 28
Circle -16777216 true false 234 84 42
Circle -955883 true false 204 189 42
Circle -16777216 true false 204 189 42
Circle -16777216 true false 129 99 42
Circle -16777216 true false 249 144 42
Circle -16777216 true false 129 174 42
Circle -16777216 true false 189 129 42
Circle -16777216 true false 174 54 42
Circle -7500403 true true 135 105 30
Circle -7500403 true true 135 180 30
Circle -7500403 true true 180 60 30
Circle -7500403 true true 195 135 30
Circle -7500403 true true 210 195 30
Circle -7500403 true true 255 150 30
Circle -7500403 true true 240 90 30

caracol_r
false
0
Circle -16777216 true false -15 30 240
Polygon -13840069 true false 195 135 180 180 165 195 135 225 90 240 30 210 15 180 0 135 0 105 -15 60 -15 240 15 270 45 285 75 300 120 300 195 285 210 270 225 255 240 225 255 195 270 165 270 135
Circle -6459832 true false 0 45 210
Polygon -13840069 true false 285 30 255 105 240 90 285 15
Circle -13840069 true false 180 0 30
Polygon -13840069 true false 195 30 225 105 240 90 195 15
Circle -13840069 true false 180 60 120
Circle -1 true false 189 84 42
Circle -1 true false 249 84 42
Circle -13840069 true false 270 0 30
Circle -16777216 true false 195 90 30
Circle -16777216 true false 255 90 30
Circle -1 true false 225 135 28
Circle -16777216 true false 24 84 42
Circle -955883 true false 54 189 42
Circle -16777216 true false 54 189 42
Circle -16777216 true false 129 99 42
Circle -16777216 true false 9 144 42
Circle -16777216 true false 129 174 42
Circle -16777216 true false 69 129 42
Circle -16777216 true false 84 54 42
Circle -7500403 true true 135 105 30
Circle -7500403 true true 135 180 30
Circle -7500403 true true 90 60 30
Circle -7500403 true true 75 135 30
Circle -7500403 true true 60 195 30
Circle -7500403 true true 15 150 30
Circle -7500403 true true 30 90 30

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cleaner
true
1
Polygon -10899396 true false 90 105 45 135 30 150 15 180 45 180 90 180 105 165 90 105
Line -16777216 false 90 120 45 150
Line -16777216 false 105 135 75 150
Polygon -10899396 true false 210 105 255 135 270 150 285 180 255 180 210 180 195 165 210 105
Line -16777216 false 195 135 225 150
Line -16777216 false 210 120 255 150
Polygon -13840069 true false 180 165 225 180 225 195 210 210 195 210 165 180 180 165
Polygon -13840069 true false 120 165 75 180 75 195 90 210 105 210 135 180 120 165
Polygon -6459832 true false 210 90 225 75 225 60 210 90
Polygon -6459832 true false 195 75 210 60 210 45 195 75
Polygon -6459832 true false 180 60 195 45 195 30 180 60
Polygon -6459832 true false 165 45 180 30 180 15 165 45
Polygon -6459832 true false 90 90 75 75 75 60 90 90
Polygon -6459832 true false 195 75 210 60 210 45 195 75
Polygon -6459832 true false 105 75 90 60 90 45 105 75
Polygon -6459832 true false 120 60 105 45 105 30 120 60
Polygon -6459832 true false 135 45 120 30 120 15 135 45
Polygon -6459832 true false 75 105 75 105 90 60 120 30 150 15 180 30 210 60 225 105 195 165 180 225 150 270 180 300 120 300 150 270 120 225 105 165 75 105
Circle -16777216 true false 103 43 94
Circle -6459832 true false 103 43 94
Polygon -6459832 true false 90 75 150 75 150 75 210 75 195 105 165 120 135 120 105 105
Circle -1184463 true false 120 60 60
Polygon -1184463 true false 105 90 150 75 150 75 195 90 180 105 165 120 135 120 120 105
Line -16777216 false 255 150 270 180
Line -16777216 false 225 150 240 180
Line -16777216 false 75 150 60 180
Line -16777216 false 45 150 30 180

corpse_l
false
0
Polygon -1184463 true false 255 135 270 75 285 86 300 120 285 150 300 180 287 214 270 225 255 165
Polygon -7500403 true true 105 135 120 75 74 81 20 119 8 146 8 160 13 170 30 195 120 225 105 165 270 150
Circle -16777216 true false 45 96 50
Rectangle -7500403 true true 105 135 270 165
Polygon -7500403 true true 150 135 180 75 165 135
Polygon -7500403 true true 180 165 210 225 195 165
Polygon -7500403 true true 210 165 240 210 225 165
Polygon -7500403 true true 210 135 240 90 225 135
Polygon -7500403 true true 120 165 135 225 135 165
Polygon -7500403 true true 150 165 180 225 165 165
Polygon -7500403 true true 180 135 210 75 195 135
Polygon -7500403 true true 120 135 135 75 135 135
Polygon -2674135 true false 60 105 90 135 75 135 45 105 60 105
Polygon -2674135 true false 60 135 90 105 75 105 45 135 60 135
Polygon -7500403 true true 255 135 264 87 270 86 285 120 270 150 285 180 272 214 265 212 255 165

corpse_r
false
0
Polygon -6459832 true false 45 135 30 75 15 86 0 120 15 150 0 180 13 214 30 225 45 165
Polygon -7500403 true true 195 135 180 75 226 81 280 119 292 146 292 160 287 170 270 195 180 225 195 165 30 150
Circle -16777216 true false 205 96 50
Rectangle -7500403 true true 30 135 195 165
Polygon -7500403 true true 150 135 120 75 135 135
Polygon -7500403 true true 120 165 90 225 105 165
Polygon -7500403 true true 90 165 60 210 75 165
Polygon -7500403 true true 90 135 60 90 75 135
Polygon -7500403 true true 180 165 165 225 165 165
Polygon -7500403 true true 150 165 120 225 135 165
Polygon -7500403 true true 120 135 90 75 105 135
Polygon -7500403 true true 180 135 165 75 165 135
Polygon -2674135 true false 240 105 210 135 225 135 255 105 240 105
Polygon -2674135 true false 240 135 210 105 225 105 255 135 240 135
Polygon -7500403 true true 45 135 36 87 30 86 15 120 30 150 15 180 28 214 35 212 45 165

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish_1_l
true
0
Polygon -1 true false 169 256 213 279 214 285 180 300 150 285 120 300 86 287 88 280 134 255
Polygon -1 true false 105 165 65 181 82 205 90 224 96 254 135 240
Polygon -1 true false 255 225 223 217 197 229 186 214 222 134 240 165
Polygon -7500403 true true 164 270 223 149 219 74 181 20 154 8 140 8 130 13 105 30 90 105 88 149 134 270
Circle -16777216 true false 164 55 30

fish_1_r
true
0
Polygon -1 true false 131 256 87 279 86 285 120 300 150 285 180 300 214 287 212 280 166 255
Polygon -1 true false 195 165 235 181 218 205 210 224 204 254 165 240
Polygon -1 true false 45 225 77 217 103 229 114 214 78 134 60 165
Polygon -7500403 true true 136 270 77 149 81 74 119 20 146 8 160 8 170 13 195 30 210 105 212 149 166 270
Circle -16777216 true false 106 55 30

fish_2_l
true
0
Polygon -1 true false 225 225 210 240 195 240 165 240 207 164 225 195
Polygon -1 true false 150 285 165 270 210 285 165 240 150 270 135 240 90 285 135 270 150 285
Polygon -7500403 true true 210 150 255 150 285 120 285 105 270 90 255 90 270 105 270 120 255 135 210 135
Circle -1184463 true false 234 54 42
Circle -2674135 false false 234 54 42
Line -16777216 false 225 225 180 195
Line -16777216 false 225 210 180 180
Line -16777216 false 225 195 180 165
Line -16777216 false 225 240 180 210
Line -16777216 false 225 255 180 225
Polygon -7500403 true true 164 270 223 149 219 74 181 20 154 8 135 15 135 120 105 30 90 105 88 149 134 270
Circle -1 true false 164 55 30
Circle -6459832 true false 169 60 20
Circle -2674135 true false 174 65 10
Polygon -1 true false 135 15 75 45 135 30 90 60 135 45 105 75 135 60 120 90 135 75 120 120 135 90

fish_2_r
true
0
Polygon -1 true false 75 225 90 240 105 240 135 240 93 164 75 195
Polygon -1 true false 150 285 135 270 90 285 135 240 150 270 165 240 210 285 165 270 150 285
Polygon -7500403 true true 90 150 45 150 15 120 15 105 30 90 45 90 30 105 30 120 45 135 90 135
Circle -1184463 true false 24 54 42
Circle -2674135 false false 24 54 42
Line -16777216 false 75 225 120 195
Line -16777216 false 75 210 120 180
Line -16777216 false 75 195 120 165
Line -16777216 false 75 240 120 210
Line -16777216 false 75 255 120 225
Polygon -7500403 true true 136 270 77 149 81 74 119 20 146 8 165 15 165 120 195 30 210 105 212 149 166 270
Circle -1 true false 106 55 30
Circle -6459832 true false 111 60 20
Circle -2674135 true false 116 65 10
Polygon -1 true false 165 15 225 45 165 30 210 60 165 45 195 75 165 60 180 90 165 75 180 120 165 90

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

king_fish_l
true
0
Polygon -1 true false 169 256 213 279 214 285 180 300 150 285 120 300 86 287 88 280 134 255
Polygon -1 true false 105 165 65 181 82 205 90 224 96 254 135 240
Polygon -1 true false 255 225 223 217 197 229 186 214 222 134 240 165
Polygon -7500403 true true 164 270 223 149 219 74 181 20 154 8 140 8 130 13 105 30 90 105 88 149 134 270
Circle -16777216 true false 164 55 30
Polygon -1184463 true false 195 45 210 135 285 150 240 120 285 105 240 90 285 60 225 60 270 15 195 45
Circle -1184463 true false 255 0 30
Circle -1184463 true false 270 45 30
Circle -1184463 true false 270 90 30
Circle -1184463 true false 255 135 30

king_fish_r
true
0
Polygon -1 true false 131 256 87 279 86 285 120 300 150 285 180 300 214 287 212 280 166 255
Polygon -1 true false 195 165 235 181 218 205 210 224 204 254 165 240
Polygon -1 true false 45 225 77 217 103 229 114 214 78 134 60 165
Polygon -7500403 true true 136 270 77 149 81 74 119 20 146 8 160 8 170 13 195 30 210 105 212 149 166 270
Circle -16777216 true false 106 55 30
Polygon -1184463 true false 105 45 90 135 15 150 60 120 15 105 60 90 15 60 75 60 30 15 105 45
Circle -1184463 true false 15 0 30
Circle -1184463 true false 0 45 30
Circle -1184463 true false 0 90 30
Circle -1184463 true false 15 135 30

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

nutriente
false
0
Circle -1 false false 59 59 182
Circle -13840069 false false 129 129 42
Circle -1 false false 75 75 150
Circle -1 false false 135 135 30
Circle -1 false false 90 90 120
Circle -1 false false 105 105 90
Circle -1 false false 120 120 60
Circle -13840069 false false 63 63 175
Circle -13840069 false false 70 70 160
Circle -13840069 false false 83 83 134
Circle -13840069 false false 96 96 108
Circle -13840069 false false 108 108 84
Circle -1 false false 60 60 180

nutriente_2
false
0
Circle -13840069 false false 60 60 180
Circle -14835848 false false 63 63 175
Polygon -10899396 true false 150 75 195 90 210 105 225 135 225 150 210 120 150 75
Polygon -1 true false 150 75 180 75 210 90 225 120 225 150 195 90 150 75

pedra
false
12
Rectangle -16777216 true false 60 60 90 210
Polygon -7500403 true false 60 165 60 120 90 90 120 75 135 90 165 75 195 75 210 90 210 105 225 120 240 135 240 180 210 210 120 210 90 195
Line -16777216 false 105 90 90 120
Line -16777216 false 105 135 120 150
Line -16777216 false 135 180 105 195
Line -16777216 false 180 120 165 105
Line -16777216 false 210 180 180 210
Line -16777216 false 150 135 165 165
Line -1 false 75 135 90 165
Line -1 false 195 135 180 165
Line -1 false 150 105 180 90
Line -1 false 165 195 135 165
Line -1 false 120 120 135 120
Line -1 false 210 165 225 135
Line -1 false 120 180 120 165
Line -955883 false 105 180 90 180
Line -955883 false 75 120 90 135
Line -955883 false 120 105 150 120
Line -955883 false 120 165 135 150
Line -955883 false 180 135 180 150
Line -955883 false 210 135 225 150
Line -955883 false 195 180 180 195
Line -955883 false 135 195 150 210
Polygon -16777216 true false 90 180 105 135 135 120 150 120 165 120 180 135 195 150 210 165 210 180 210 195 210 210 195 210 120 210 165 225 120 210
Rectangle -16777216 true false 105 165 135 165
Rectangle -1 true false 90 75 75 195
Circle -16777216 true false 54 39 42
Circle -16777216 true false 54 24 42
Circle -16777216 true false 54 9 42
Circle -16777216 true false 54 -6 42
Circle -16777216 true false 54 54 42
Circle -7500403 true false 60 15 30
Circle -13840069 true false 60 60 30

pedra_hidden
false
12
Rectangle -16777216 true false 60 60 90 210
Polygon -7500403 true false 60 165 60 120 90 90 120 75 135 90 165 75 195 75 210 90 210 105 225 120 240 135 240 180 210 210 120 210 90 195
Line -16777216 false 105 90 90 120
Line -16777216 false 105 135 120 150
Line -16777216 false 135 180 105 195
Line -16777216 false 180 120 165 105
Line -16777216 false 210 180 180 210
Line -16777216 false 150 135 165 165
Line -1 false 75 135 90 165
Line -1 false 195 135 180 165
Line -1 false 150 105 180 90
Line -1 false 165 195 135 165
Line -1 false 120 120 135 120
Line -1 false 210 165 225 135
Line -1 false 120 180 120 165
Line -955883 false 105 180 90 180
Line -955883 false 75 120 90 135
Line -955883 false 120 105 150 120
Line -955883 false 120 165 135 150
Line -955883 false 180 135 180 150
Line -955883 false 210 135 225 150
Line -955883 false 195 180 180 195
Line -955883 false 135 195 150 210
Polygon -16777216 true false 90 180 105 135 135 120 150 120 165 120 180 135 195 150 210 165 210 180 210 195 210 210 195 210 120 210 165 225 120 210
Circle -1 true false 99 144 42
Circle -1 true false 144 144 42
Circle -16777216 true false 150 150 30
Rectangle -16777216 true false 105 165 135 165
Circle -16777216 true false 105 150 30
Rectangle -1 true false 90 75 75 195
Circle -16777216 true false 54 39 42
Circle -16777216 true false 54 24 42
Circle -16777216 true false 54 9 42
Circle -16777216 true false 54 -6 42
Circle -16777216 true false 54 54 42
Circle -2674135 true false 60 15 30
Circle -7500403 true false 60 60 30

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

poop
false
0
Rectangle -6459832 true false 60 225 240 300
Rectangle -6459832 true false 75 180 225 225
Rectangle -6459832 true false 105 150 195 180
Rectangle -6459832 true false 135 135 165 150
Circle -6459832 true false 13 208 92
Circle -6459832 true false 193 208 92
Circle -6459832 true false 45 150 88
Circle -6459832 true false 165 150 88
Circle -6459832 true false 75 90 88
Circle -6459832 true false 135 90 88
Circle -6459832 true false 105 30 88
Polygon -6459832 true false 120 0 150 15 180 45 135 45
Circle -16777216 true false 120 180 0
Polygon -16777216 true false 120 210 150 210 180 210 225 195 195 255 180 270 120 270 105 255 75 195
Circle -1 true false 99 129 42
Circle -16777216 true false 105 135 30
Circle -1 true false 159 129 42
Circle -16777216 true false 165 135 30

resistencia
false
0
Polygon -2674135 true false 90 15 90 45 90 90 120 120 180 120 195 105 210 90 210 45 150 30 120 45 105 75 105 90 135 60 150 45 195 60 195 90 180 105 120 105 105 90 105 45 105 15 120 15
Polygon -955883 true false 120 60 90 90 90 135 120 165 180 165 195 150 210 135 210 90 150 75 120 90 105 120 105 135 135 105 150 90 195 105 195 135 180 150 120 150 105 135 105 90 135 60 120 60
Polygon -2674135 true false 120 105 90 135 90 180 120 210 180 210 195 195 210 180 210 135 150 120 120 135 105 165 105 180 135 150 150 135 195 150 195 180 180 195 120 195 105 180 105 135 135 105 120 105
Polygon -955883 true false 120 150 90 180 90 225 120 255 180 255 195 240 210 225 210 180 150 165 120 180 105 210 105 225 135 195 150 180 195 195 195 225 180 240 120 240 105 225 105 180 135 150 120 150
Polygon -2674135 true false 120 300 90 270 90 225 120 195 180 195 195 210 210 225 210 270 150 285 120 270 105 240 105 225 135 255 150 270 195 255 195 225 180 210 120 210 105 225 105 270 120 285 120 300
Circle -2674135 true false 84 -6 42

resistencia_desligada
false
0
Circle -16777216 true false 105 -30 90
Circle -16777216 true false 120 255 60
Rectangle -16777216 true false 120 30 180 270
Rectangle -2674135 true false 135 30 165 270
Circle -13345367 true false 129 264 42
Polygon -16777216 true false 135 75 150 90 165 75
Polygon -16777216 true false 135 105 150 120 165 105
Polygon -16777216 true false 135 135 150 150 165 135
Polygon -16777216 true false 135 165 150 180 165 165
Rectangle -13345367 true false 135 30 165 270
Polygon -16777216 true false 135 45 165 45 150 60 135 45
Polygon -16777216 true false 135 75 165 75 150 90 135 75
Polygon -16777216 true false 135 105 165 105 150 120 135 105
Polygon -16777216 true false 135 135 165 135 150 150 135 135
Polygon -16777216 true false 135 165 165 165 150 180 135 165
Polygon -16777216 true false 135 195 165 195 150 210 135 195
Polygon -16777216 true false 135 225 165 225 150 240 135 225
Line -16777216 false 150 285 180 270
Line -16777216 false 150 285 120 270
Line -16777216 false 150 285 180 255
Line -16777216 false 150 285 120 255
Circle -2674135 true false 120 -15 60

resistencia_ligada
false
0
Circle -16777216 true false 105 -30 90
Circle -16777216 true false 120 255 60
Rectangle -16777216 true false 120 30 180 270
Circle -2674135 true false 120 -15 60
Rectangle -2674135 true false 135 30 165 270
Circle -2674135 true false 129 264 42
Polygon -16777216 true false 135 75 150 90 165 75
Polygon -16777216 true false 135 105 150 120 165 105
Polygon -16777216 true false 135 135 150 150 165 135
Polygon -16777216 true false 135 165 150 180 165 165
Rectangle -2674135 true false 135 30 165 270
Polygon -16777216 true false 135 45 165 45 150 60 135 45
Polygon -16777216 true false 135 75 165 75 150 90 135 75
Polygon -16777216 true false 135 105 165 105 150 120 135 105
Polygon -16777216 true false 135 135 165 135 150 150 135 135
Polygon -16777216 true false 135 165 165 165 150 180 135 165
Polygon -16777216 true false 135 195 165 195 150 210 135 195
Polygon -16777216 true false 135 225 165 225 150 240 135 225
Line -16777216 false 150 285 180 270
Line -16777216 false 150 285 120 270
Line -16777216 false 150 285 180 255
Line -16777216 false 150 285 120 255

sand
false
0
Polygon -1184463 true false 0 150 15 135 30 120 30 120 45 120 45 120 60 135 75 105 105 90 135 105 150 120 90 120 90 120 105 120 120 120 120 120 150 120 150 120 150 135 150 120 150 120 150 135 165 120 180 120 195 105 195 135 195 105 210 105 225 135 225 135 240 135 240 135 255 120 225 165 255 120 270 120 285 120 300 135 300 150 300 210 300 300 0 300 0 150
Circle -6459832 true false 60 180 0
Circle -6459832 true false 15 165 30
Circle -6459832 true false 75 165 30
Circle -6459832 true false 105 210 30
Circle -6459832 true false 135 165 30
Circle -6459832 true false 165 210 30
Circle -6459832 true false 195 165 30
Circle -6459832 true false 45 210 30
Circle -6459832 true false 225 210 30
Circle -6459832 true false 255 165 30
Circle -6459832 true false 15 255 30
Circle -6459832 true false 75 255 30
Circle -6459832 true false 135 255 30
Circle -6459832 true false 195 255 30
Circle -6459832 true false 255 255 30
Circle -1184463 true false 15 180 30
Circle -1184463 true false 75 180 30
Circle -1184463 true false 135 180 30
Circle -1184463 true false 195 180 30
Circle -1184463 true false 255 180 30
Circle -1184463 true false 45 195 30
Circle -1184463 true false 105 195 30
Circle -1184463 true false 165 195 30
Circle -1184463 true false 225 195 30
Circle -1184463 true false 255 270 30
Circle -1184463 true false 195 270 30
Circle -1184463 true false 135 270 30
Circle -1184463 true false 75 270 30
Circle -1184463 true false 15 270 30
Circle -6459832 true false -15 210 30
Circle -6459832 true false 285 210 30
Circle -1184463 true false -15 195 30
Circle -1184463 true false 285 195 30

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
