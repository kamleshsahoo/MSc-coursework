;;;;See the comments below where you need to set the working directory;;;;;;;;

breed [symptoms symptom]

symptoms-own
[
  symptom-present?
  b
  activation
  total-activation
  chance-to-become-activated
  individual-stress
  Act
]

links-own
[
  weight-edge
]


globals
[
  iter-ctr
  mood
  connection-strength
  external-activation
  kindling-effect?
  Depmood
  Lossint
  Wloss
  Wgain
  Dapp
  Iapp
  Insom
  Hypersom
  Pagit
  Pretar
  Fatigue
  Worthless
  Conc
  Death
  connection-strength-list
  external-activation-list
  kindling-effect-list
  depmood-list
  lossint-list
  wloss-list
  wgain-list
  dapp-list
  iapp-list
  insom-list
  hypersom-list
  pagit-list
  pretar-list
  fatigue-list
  worthless-list
  conc-list
  death-list
  episode-cntr
  episode
  episode-continue?
  connection-strength-after-episode
]


to setup
  clear-all
  setup-symptoms
  ask symptom 0 [set b 2.3129 set label "Depmood"]
  ask symptom 1 [set b 3.1946 set label "Lossint"]
  ask symptom 2 [set b 4.3092 set label "Wloss"]
  ask symptom 3 [set b 3.8332 set label "Wgain"]
  ask symptom 4 [set b 3.9153 set label "Dapp"]
  ask symptom 5 [set b 3.9012 set label "Iapp"]
  ask symptom 6 [set b 3.0246 set label "Insom"]
  ask symptom 7 [set b 4.4480 set label "Hypersom"]
  ask symptom 8 [set b 3.1753 set label "Pagit"]
  ask symptom 9 [set b 4.3372 set label "Pretar"]
  ask symptom 10 [set b 2.8269 set label "Fatigue"]
  ask symptom 11 [set b 4.4272 set label "Worthless"]
  ask symptom 12 [set b 4.0421 set label "Conc"]
  ask symptom 13 [set b 5.8303 set label "Death"]
  setup-network
  set mood []
  set episode-cntr 0
  set episode 0
  set episode-continue? false
  set external-activation 0
  set kindling-effect? false
  set Depmood 0
  set Lossint 0
  set Wloss 0
  set Wgain 0
  set Dapp 0
  set Iapp 0
  set Insom 0
  set Hypersom 0
  set Pagit 0
  set Pretar 0
  set Fatigue 0
  set Worthless 0
  set Conc 0
  set Death 0
  set connection-strength-list []
  set external-activation-list []
  set kindling-effect-list []
  set depmood-list []
  set lossint-list []
  set wloss-list []
  set wgain-list []
  set dapp-list []
  set iapp-list []
  set insom-list []
  set hypersom-list []
  set pagit-list []
  set pretar-list []
  set fatigue-list []
  set worthless-list []
  set conc-list []
  set death-list []
  set iter-ctr 0
  ;;;;;;;;;;;;;;;;;;;;;;;;Change the path to where the param_values.txt is created. Note this file is created from Python so the file is created where your current Jupyter Notebook file is located;;;;;;;;;;;;;;;;;;;;
  set-current-directory "C:\\Users\\Kamlesh\\dir1\\ComplexSystems2021"
  file-open "param_values.txt"
  while [not file-at-end?]
  [
  set connection-strength-list lput file-read connection-strength-list
  set external-activation-list lput file-read external-activation-list
  set kindling-effect-list lput file-read kindling-effect-list
  set depmood-list lput file-read depmood-list
  set lossint-list lput file-read lossint-list
  set wloss-list lput file-read wloss-list
  set wgain-list lput file-read wgain-list
  set dapp-list lput file-read dapp-list
  set iapp-list lput file-read iapp-list
  set insom-list lput file-read insom-list
  set hypersom-list lput file-read hypersom-list
  set pagit-list lput file-read pagit-list
  set pretar-list lput file-read pretar-list
  set fatigue-list lput file-read fatigue-list
  set worthless-list lput file-read worthless-list
  set conc-list lput file-read conc-list
  set death-list lput file-read death-list
  ]
  file-close
  ;;;;;;;;;;;;;;;;;;;;;;;;;; Change the path to the same path you set above. Note if you already have a output.txt file delete it, otherwise Netlogo will append the results to the existing output.txt;;;;;;;;;;;;;;;;;;;;;;
  set-current-directory "C:\\Users\\Kamlesh\\dir1\\ComplexSystems2021"
  file-open "output.txt"
  reset-ticks
end

to setup-symptoms
  create-symptoms 14 [ set shape "circle"]
  layout-circle (sort symptoms) max-pxcor - 4.5
  ask symptoms
    [
      setxy (xcor * 0.70) (ycor * 0.70)
      become-symptom-absent
    ]
end

to setup-network
ask symptom 0  [create-link-with symptom 1]
ask symptom 0  [create-link-with symptom 2]
ask symptom 0  [create-link-with symptom 3]
ask symptom 0  [create-link-with symptom 4]
ask symptom 0  [create-link-with symptom 5]
ask symptom 0  [create-link-with symptom 6]
ask symptom 0  [create-link-with symptom 7]
ask symptom 0  [create-link-with symptom 8]
ask symptom 0  [create-link-with symptom 9]
ask symptom 0  [create-link-with symptom 10]
ask symptom 0  [create-link-with symptom 11]
ask symptom 0  [create-link-with symptom 12]
ask symptom 0  [create-link-with symptom 13]
ask symptom 1  [create-link-with symptom 2]
ask symptom 1  [create-link-with symptom 3]
ask symptom 1  [create-link-with symptom 4]
ask symptom 1  [create-link-with symptom 5]
ask symptom 1  [create-link-with symptom 6]
ask symptom 1  [create-link-with symptom 7]
ask symptom 1  [create-link-with symptom 8]
ask symptom 1  [create-link-with symptom 9]
ask symptom 1  [create-link-with symptom 10]
ask symptom 1  [create-link-with symptom 11]
ask symptom 1  [create-link-with symptom 12]
ask symptom 1  [create-link-with symptom 13]
ask symptom 2  [create-link-with symptom 3]
ask symptom 2  [create-link-with symptom 4]
ask symptom 2  [create-link-with symptom 6]
ask symptom 2  [create-link-with symptom 11]
ask symptom 2  [create-link-with symptom 12]
ask symptom 2  [create-link-with symptom 13]
ask symptom 3  [create-link-with symptom 4]
ask symptom 3  [create-link-with symptom 5]
ask symptom 3  [create-link-with symptom 6]
ask symptom 3  [create-link-with symptom 7]
ask symptom 3  [create-link-with symptom 10]
ask symptom 3  [create-link-with symptom 11]
ask symptom 4  [create-link-with symptom 6]
ask symptom 4  [create-link-with symptom 7]
ask symptom 4  [create-link-with symptom 8]
ask symptom 4  [create-link-with symptom 9]
ask symptom 4  [create-link-with symptom 10]
ask symptom 4  [create-link-with symptom 11]
ask symptom 4  [create-link-with symptom 12]
ask symptom 4  [create-link-with symptom 13]
ask symptom 5  [create-link-with symptom 7]
ask symptom 5  [create-link-with symptom 8]
ask symptom 5  [create-link-with symptom 9]
ask symptom 5  [create-link-with symptom 10]
ask symptom 5  [create-link-with symptom 13]
ask symptom 6  [create-link-with symptom 7]
ask symptom 6  [create-link-with symptom 8]
ask symptom 6  [create-link-with symptom 10]
ask symptom 6  [create-link-with symptom 12]
ask symptom 6  [create-link-with symptom 13]
ask symptom 7  [create-link-with symptom 9]
ask symptom 7  [create-link-with symptom 10]
ask symptom 7  [create-link-with symptom 11]
ask symptom 7  [create-link-with symptom 12]
ask symptom 7  [create-link-with symptom 13]
ask symptom 8  [create-link-with symptom 10]
ask symptom 8  [create-link-with symptom 11]
ask symptom 8  [create-link-with symptom 12]
ask symptom 8  [create-link-with symptom 13]
ask symptom 9  [create-link-with symptom 10]
ask symptom 9  [create-link-with symptom 11]
ask symptom 9  [create-link-with symptom 12]
ask symptom 9  [create-link-with symptom 13]
ask symptom 10  [create-link-with symptom 11]
ask symptom 10  [create-link-with symptom 12]
ask symptom 11  [create-link-with symptom 12]
ask symptom 11  [create-link-with symptom 13]
ask symptom 12  [create-link-with symptom 13]

  ask link 0 1   [set weight-edge 2.1407 set color 9]
  ask link 0 2   [set weight-edge 0.7232 set color 9]
  ask link 0 3   [set weight-edge 0.2041 set color 9]
  ask link 0 4   [set weight-edge 1.1296 set color 9]
  ask link 0 5   [set weight-edge 0.5217 set color 9]
  ask link 0 6   [set weight-edge 1.0530 set color 9]
  ask link 0 7   [set weight-edge 0.9409 set color 9]
  ask link 0 8   [set weight-edge 0.7484 set color 9]
  ask link 0 9   [set weight-edge 0.6849 set color 9]
  ask link 0 10  [set weight-edge 1.0979 set color 9]
  ask link 0 11  [set weight-edge 1.8733 set color 9]
  ask link 0 12  [set weight-edge 1.0211 set color 9]
  ask link 0 13  [set weight-edge 2.0693 set color 9]
  ask link 1 2   [set weight-edge 0.1766 set color 9]
  ask link 1 3   [set weight-edge 0.2811 set color 9]
  ask link 1 4   [set weight-edge 0.5763 set color 9]
  ask link 1 5   [set weight-edge 0.2392 set color 9]
  ask link 1 6   [set weight-edge 0.4273 set color 9]
  ask link 1 7   [set weight-edge 0.5311 set color 9]
  ask link 1 8   [set weight-edge 0.4459 set color 9]
  ask link 1 9   [set weight-edge 0.6564 set color 9]
  ask link 1 10  [set weight-edge 0.5070 set color 9]
  ask link 1 11  [set weight-edge 0.6826 set color 9]
  ask link 1 12  [set weight-edge 0.8178 set color 9]
  ask link 1 13  [set weight-edge 0.4986 set color 9]
  ask link 2 3   [set weight-edge -0.6082 set color 9]
  ask link 2 4   [set weight-edge 2.9840 set color 9]
  ask link 2 6   [set weight-edge 0.2045 set color 9]
  ask link 2 11  [set weight-edge 0.3772 set color 9]
  ask link 2 12  [set weight-edge 0.1063 set color 9]
  ask link 2 13  [set weight-edge 0.252 set color 9]
  ask link 3 4   [set weight-edge -0.5389 set color 9]
  ask link 3 5   [set weight-edge 3.165 set color 9]
  ask link 3 6   [set weight-edge 0.2672 set color 9]
  ask link 3 7   [set weight-edge 0.2041 set color 9]
  ask link 3 10  [set weight-edge 0.4112 set color 9]
  ask link 3 11  [set weight-edge 0.5226 set color 9]
  ask link 4 6   [set weight-edge 0.7033 set color 9]
  ask link 4 7   [set weight-edge 0.4020 set color 9]
  ask link 4 8   [set weight-edge 0.4724 set color 9]
  ask link 4 9   [set weight-edge 0.2219 set color 9]
  ask link 4 10  [set weight-edge 0.2284 set color 9]
  ask link 4 11  [set weight-edge 0.1203 set color 9]
  ask link 4 12  [set weight-edge 0.4177 set color 9]
  ask link 4 13  [set weight-edge 0.1198 set color 9]
  ask link 5 7   [set weight-edge 0.5475 set color 9]
  ask link 5 8   [set weight-edge 0.4890 set color 9]
  ask link 5 9   [set weight-edge 0.2914 set color 9]
  ask link 5 10  [set weight-edge 0.4546 set color 9]
  ask link 5 13  [set weight-edge 0.1620 set color 9]
  ask link 6 7   [set weight-edge -0.5009 set color 9]
  ask link 6 8   [set weight-edge 1.2951 set color 9]
  ask link 6 10  [set weight-edge 0.8279 set color 9]
  ask link 6 12  [set weight-edge 0.2585 set color 9]
  ask link 6 13  [set weight-edge 0.4514 set color 9]
  ask link 7 9   [set weight-edge 0.4048 set color 9]
  ask link 7 10  [set weight-edge 1.4768 set color 9]
  ask link 7 11  [set weight-edge 0.2708 set color 9]
  ask link 7 12  [set weight-edge 0.0597 set color 9]
  ask link 7 13  [set weight-edge 0.2151 set color 9]
  ask link 8 10  [set weight-edge 0.3751 set color 9]
  ask link 8 11  [set weight-edge 0.3893 set color 9]
  ask link 8 12  [set weight-edge 0.9414 set color 9]
  ask link 8 13  [set weight-edge 0.1939 set color 9]
  ask link 9 10  [set weight-edge 1.5718 set color 9]
  ask link 9 11  [set weight-edge 0.3491 set color 9]
  ask link 9 12  [set weight-edge 0.7233 set color 9]
  ask link 9 13  [set weight-edge 0.1407 set color 9]
  ask link 10 11 [set weight-edge 0.2362 set color 9]
  ask link 10 12 [set weight-edge 0.4935 set color 9]
  ask link 11 12 [set weight-edge 0.666 set color 9]
  ask link 11 13 [set weight-edge 1.4769 set color 9]
  ask link 12 13 [set weight-edge 0.2156 set color 9]

end



to go
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Simulation for 5000 ticks;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  if ticks >= 5000 [
   show iter-ctr
  ;;;;;;;;;;;;;;;;;;;;;;Total 7200 parameter combinations from SOBOL analysis;;;;;;;;;;;;;;;;;;;;
  ifelse iter-ctr >= 7199 [
      file-close-all
      stop]
  [set iter-ctr iter-ctr + 1
    ;clear-all
     clear-turtles
    clear-links
    clear-patches
    reset-ticks]]

  if ticks = 0
  [
   setup-symptoms
  set external-activation 0
  set kindling-effect? false
  set Depmood 0
  set Lossint 0
  set Wloss 0
  set Wgain 0
  set Dapp 0
  set Iapp 0
  set Insom 0
  set Hypersom 0
  set Pagit 0
  set Pretar 0
  set Fatigue 0
  set Worthless 0
  set Conc 0
  set Death 0
  ask symptom 0 [set b 2.3129 set label Depmood]
  ask symptom 1 [set b 3.1946 set label Lossint]
  ask symptom 2 [set b 4.3092 set label Wloss]
  ask symptom 3 [set b 3.8332 set label Wgain]
  ask symptom 4 [set b 3.9153 set label Dapp]
  ask symptom 5 [set b 3.9012 set label Iapp]
  ask symptom 6 [set b 3.0246 set label Insom]
  ask symptom 7 [set b 4.4480 set label Hypersom]
  ask symptom 8 [set b 3.1753 set label Pagit]
  ask symptom 9 [set b 4.3372 set label Pretar]
  ask symptom 10 [set b 2.8269 set label Fatigue]
  ask symptom 11 [set b 4.4272 set label Worthless]
  ask symptom 12 [set b 4.0421 set label Conc]
  ask symptom 13 [set b 5.8303 set label Death]
  setup-network
  set episode-cntr 0
  set episode 0
  set episode-continue? false
  set connection-strength item iter-ctr connection-strength-list
  set connection-strength-after-episode connection-strength
  set mood []  ]
  ;;;;;;;;;;;;;;;;;;;;; Let the system evolve for a bit then introduce the factors ;;;;;;;;;;;;;;;
  if ticks = 300
  [
    set external-activation item iter-ctr external-activation-list
    ifelse item iter-ctr kindling-effect-list = 1
    [set kindling-effect? true]
    [set kindling-effect? false]
    set Depmood item iter-ctr depmood-list
    set Lossint item iter-ctr lossint-list
    set Wloss item iter-ctr wloss-list
    set Wgain item iter-ctr wgain-list
    set Dapp item iter-ctr dapp-list
    set Iapp item iter-ctr iapp-list
    set Insom item iter-ctr insom-list
    set Hypersom item iter-ctr hypersom-list
    set Pagit item iter-ctr pagit-list
    set Pretar item iter-ctr pretar-list
    set Fatigue item iter-ctr fatigue-list
    set Worthless item iter-ctr worthless-list
    set Conc item iter-ctr conc-list
    set Death item iter-ctr death-list ]

  spread-activation
  list-mood
  file-write (count symptoms with [symptom-present?])
  tick

end

to spread-activation
  ask symptoms with [symptom-present?]
    [
      calculate-chance-to-become-activated
      if random 1000 / 1000 >  chance-to-become-activated
        [
          become-symptom-absent
        ]
    ]
  ask symptoms with [not symptom-present?]
    [
      calculate-chance-to-become-activated
      if random 1000 / 1000 < chance-to-become-activated
        [
          become-symptom-present
        ]
    ]
end

to calculate-chance-to-become-activated
  ind-stress
  ask symptoms
  [
    set total-activation 0
    let j 0
    while [j < count symptoms]
    [
      if link who j != nobody
      [
        if who < j
        [
          let temptot-activation 1
          ifelse kindling-effect? [set temptot-activation ([weight-edge] of link who j * [activation] of symptom j * connection-strength-after-episode)]
          [ set temptot-activation ([weight-edge] of link who j * [activation] of symptom j * connection-strength) ]
          set total-activation total-activation + temptot-activation
        ]
        if who > j
        [
          let temptot-activation 1
          ifelse kindling-effect? [set temptot-activation ([weight-edge] of link j who * [activation] of symptom j * connection-strength-after-episode)]
          [set temptot-activation ([weight-edge] of link j who * [activation] of symptom j * connection-strength)]
          set total-activation total-activation + temptot-activation
        ]
      ]
      set j j + 1
      ]
    set Act total-activation + external-activation + individual-stress
    set chance-to-become-activated (1 / (1 + exp ((b - Act))))
  ]
end

to ind-stress
ask symptom 0  [set individual-stress Depmood]
ask symptom 1  [set individual-stress Lossint]
ask symptom 2  [set individual-stress Wloss]
ask symptom 3  [set individual-stress Wgain]
ask symptom 4  [set individual-stress Dapp]
ask symptom 5  [set individual-stress Iapp]
ask symptom 6  [set individual-stress Insom]
ask symptom 7  [set individual-stress Hypersom]
ask symptom 8  [set individual-stress Pagit]
ask symptom 9  [set individual-stress Pretar]
ask symptom 10 [set individual-stress Fatigue]
ask symptom 11 [set individual-stress Worthless]
ask symptom 12 [set individual-stress Conc]
ask symptom 13 [set individual-stress Death]
end

to episode-counter
  if ticks >= 365 [
    let last14days sublist mood (length mood - 14) (length mood)
    ifelse length (filter [i -> i >= 7] last14days) = 14
    [ifelse episode-continue?
      [ set episode 1]
      [ set episode 1
        set episode-cntr episode-cntr + 1
        if kindling-effect? [set connection-strength-after-episode connection-strength-after-episode + 0.01]
        set episode-continue? true]
    ]
    [ifelse length (filter [i -> i >= 7] last14days) > 7
      [ if episode-continue?
        [set episode 1]
      ]
      [ set episode 0
        set episode-continue? false ]
    ]

  ]
end

to become-symptom-absent
  set symptom-present? false
  set activation 0
  set shape "circle 2"
  set size 1
end

to become-symptom-present
  set symptom-present? true
  set activation 1
  set shape "circle"
  set color red
  set size 2
end

to list-mood
  set mood lput (count symptoms with [symptom-present?]) mood
  if length mood > 1000
  [
    set mood butfirst mood
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
9
41
101
92
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
10
112
104
169
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
711
17
1123
306
1) Hit 'setup' and then 'go' to start the \nSOBOL analysis.\n\n2) The simulations will automatically stop when all the parameters are used. So no need to hit the 'setup' or 'go' button again. \n\n3) The output is automatically stored in 'output.txt' file. See the code tab at the top left of this page, for details about the file location.\n\n4) Because we were concerned only with the model output we dont show any visualisations here. Except the fast blinking red lights :) \n\n5) The simulation time will depend on the number of parameter combinations. The current code is based on 7200 parameter combinations which took us approximately 17 hours.
14
0.0
1

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

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

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

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

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

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

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
NetLogo 6.2.0
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
