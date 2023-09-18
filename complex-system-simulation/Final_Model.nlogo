breed [symptoms symptom]

symptoms-own
[
  symptom-present?    ;; if true, the symptom is a present symptom
  b                   ;; the threshold of regression
  activation          ;; =0 if symptom-absent, =1 if symptom-present
  total-activation    ;; total activation from network
  chance-to-become-activated ;; calculates the likelihood with logistic function to become active
  individual-stress
  Act
]

links-own
[
  weight-edge
]

globals
[
  mood
  external-stress
  shock
  episode-cntr
  episode
  episode-continue?
  connection-strength-after-episode
]


;;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

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
  set connection-strength-after-episode connection-strength
  set external-stress external-activation
  reset-ticks
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup symptoms: creates symptoms with a nice layout    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-symptoms
  create-symptoms 14 [ set shape "circle"]
  layout-circle (sort symptoms) max-pxcor - 4.5
  ask symptoms
    [
      setxy (xcor * 0.71) (ycor * 0.71)
      become-symptom-absent
    ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup network ;;
;; and assign weights to the links                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

  ask link 0 1   [set weight-edge 2.1407 set color 2]
  ask link 0 2   [set weight-edge 0.7232 set color 2]
  ask link 0 3   [set weight-edge 0.2041 set color 2]
  ask link 0 4   [set weight-edge 1.1296 set color 2]
  ask link 0 5   [set weight-edge 0.5217 set color 2]
  ask link 0 6   [set weight-edge 1.0530 set color 2]
  ask link 0 7   [set weight-edge 0.9409 set color 2]
  ask link 0 8   [set weight-edge 0.7484 set color 2]
  ask link 0 9   [set weight-edge 0.6849 set color 2]
  ask link 0 10  [set weight-edge 1.0979 set color 2]
  ask link 0 11  [set weight-edge 1.8733 set color 2]
  ask link 0 12  [set weight-edge 1.0211 set color 2]
  ask link 0 13  [set weight-edge 2.0693 set color 2]
  ask link 1 2   [set weight-edge 0.1766 set color 2]
  ask link 1 3   [set weight-edge 0.2811 set color 2]
  ask link 1 4   [set weight-edge 0.5763 set color 2]
  ask link 1 5   [set weight-edge 0.2392 set color 2]
  ask link 1 6   [set weight-edge 0.4273 set color 2]
  ask link 1 7   [set weight-edge 0.5311 set color 2]
  ask link 1 8   [set weight-edge 0.4459 set color 2]
  ask link 1 9   [set weight-edge 0.6564 set color 2]
  ask link 1 10  [set weight-edge 0.5070 set color 2]
  ask link 1 11  [set weight-edge 0.6826 set color 2]
  ask link 1 12  [set weight-edge 0.8178 set color 2]
  ask link 1 13  [set weight-edge 0.4986 set color 2]
  ask link 2 3   [set weight-edge -0.6082 set color 2]
  ask link 2 4   [set weight-edge 2.9840 set color 2]
  ask link 2 6   [set weight-edge 0.2045 set color 2]
  ask link 2 11  [set weight-edge 0.3772 set color 2]
  ask link 2 12  [set weight-edge 0.1063 set color 2]
  ask link 2 13  [set weight-edge 0.252 set color 2]
  ask link 3 4   [set weight-edge -0.5389 set color 2]
  ask link 3 5   [set weight-edge 3.165 set color 2]
  ask link 3 6   [set weight-edge 0.2672 set color 2]
  ask link 3 7   [set weight-edge 0.2041 set color 2]
  ask link 3 10  [set weight-edge 0.4112 set color 2]
  ask link 3 11  [set weight-edge 0.5226 set color 2]
  ask link 4 6   [set weight-edge 0.7033 set color 2]
  ask link 4 7   [set weight-edge 0.4020 set color 2]
  ask link 4 8   [set weight-edge 0.4724 set color 2]
  ask link 4 9   [set weight-edge 0.2219 set color 2]
  ask link 4 10  [set weight-edge 0.2284 set color 2]
  ask link 4 11  [set weight-edge 0.1203 set color 2]
  ask link 4 12  [set weight-edge 0.4177 set color 2]
  ask link 4 13  [set weight-edge 0.1198 set color 2]
  ask link 5 7   [set weight-edge 0.5475 set color 2]
  ask link 5 8   [set weight-edge 0.4890 set color 2]
  ask link 5 9   [set weight-edge 0.2914 set color 2]
  ask link 5 10  [set weight-edge 0.4546 set color 2]
  ask link 5 13  [set weight-edge 0.1620 set color 2]
  ask link 6 7   [set weight-edge -0.5009 set color 2]
  ask link 6 8   [set weight-edge 1.2951 set color 2]
  ask link 6 10  [set weight-edge 0.8279 set color 2]
  ask link 6 12  [set weight-edge 0.2585 set color 2]
  ask link 6 13  [set weight-edge 0.4514 set color 2]
  ask link 7 9   [set weight-edge 0.4048 set color 2]
  ask link 7 10  [set weight-edge 1.4768 set color 2]
  ask link 7 11  [set weight-edge 0.2708 set color 2]
  ask link 7 12  [set weight-edge 0.0597 set color 2]
  ask link 7 13  [set weight-edge 0.2151 set color 2]
  ask link 8 10  [set weight-edge 0.3751 set color 2]
  ask link 8 11  [set weight-edge 0.3893 set color 2]
  ask link 8 12  [set weight-edge 0.9414 set color 2]
  ask link 8 13  [set weight-edge 0.1939 set color 2]
  ask link 9 10  [set weight-edge 1.5718 set color 2]
  ask link 9 11  [set weight-edge 0.3491 set color 2]
  ask link 9 12  [set weight-edge 0.7233 set color 2]
  ask link 9 13  [set weight-edge 0.1407 set color 2]
  ask link 10 11 [set weight-edge 0.2362 set color 2]
  ask link 10 12 [set weight-edge 0.4935 set color 2]
  ask link 11 12 [set weight-edge 0.666 set color 2]
  ask link 11 13 [set weight-edge 1.4769 set color 2]
  ask link 12 13 [set weight-edge 0.2156 set color 2]

end

to go
  spread-activation
  list-mood
  tick
  update-plot
  set shock 1
  make-histogram
  episode-counter

end

to administer-shock
  set shock 0
end



;;;;;;;;;;;;;;;;;;;;;;;
;;; Main Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spread activation: The likelihood is calculated and drawing a random number between a uniform distribution of 0 and 1 ;;
;; determines whether the symptom will actually be activated or deactivated                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to spread-activation
  ask symptoms with [symptom-present?]
    [
      calculate-chance-to-become-activated
      if random 1000 / 1000 >  chance-to-become-activated
        [
          become-symptom-absent
          ;show individual-stress
        ]
    ]
  ask symptoms with [not symptom-present?]
    [
      calculate-chance-to-become-activated
      if random 1000 / 1000 < chance-to-become-activated
        [
          become-symptom-present
          ;show individual-stress
        ]
    ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculates the likelihood with a logistic function                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
          ;if kindling-effect?  [ set temptot-activation temptot-activation * (1 + 0.005 ^ ctr) ]
          set total-activation total-activation + temptot-activation
        ]
      ]
      set j j + 1
      ]
    set Act total-activation + external-activation + individual-stress
    set chance-to-become-activated (1 / (1 + exp ((b - Act)))) * shock
  ]
end

to ind-stress
ask symptom 0  [set individual-stress Depressed-mood]
ask symptom 1  [set individual-stress Loss-of-interest]
ask symptom 2  [set individual-stress Weight-loss]
ask symptom 3  [set individual-stress Weight-gain]
ask symptom 4  [set individual-stress Decreased-appetite]
ask symptom 5  [set individual-stress Increased-appetite]
ask symptom 6  [set individual-stress Insomnia]
ask symptom 7  [set individual-stress Hypersomnia]
ask symptom 8  [set individual-stress Psychomotor-agitation]
ask symptom 9  [set individual-stress Psychomotor-retardation]
ask symptom 10 [set individual-stress Fatigue]
ask symptom 11 [set individual-stress Worthlessness]
ask symptom 12 [set individual-stress Concentration-problems]
ask symptom 13 [set individual-stress Suicidal-thoughts]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculates the number of episodes;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to episode-counter
  if ticks >= 300 [
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
        [ set episode 1]
      ]
      [ set episode 0
        set episode-continue? false ]
    ]

  ]
end

to-report counter [a]
  report a
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; procedures to activate and deactivate symptoms ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;
;;;     Plots       ;;;
;;;;;;;;;;;;;;;;;;;;;;;
to update-plot
  set-current-plot "Network Status"
       set-current-plot-pen "cut-off"

  auto-plot-off
  plotxy 0 7
  plotxy 1000000000 7
  auto-plot-on
  set-current-plot-pen "symptom-present"
  plot (count symptoms with [symptom-present?])

  set-current-plot "Hysteresis plot"
  set-current-plot-pen "symptom-present"
  ifelse external-activation >= external-stress
  [set-plot-pen-color 15
 set external-stress external-activation ]
  [set-plot-pen-color 105]
  plotxy (external-activation) (mean mood)

  set-current-plot "Depressive episodes"
  set-current-plot-pen "episode"
  plot episode
end

to make-histogram
  set-current-plot "Histogram of active symptoms"
  set-current-plot-pen "mood"
  histogram  mood
end

; *** NetLogo 4.0.3 Model Copyright Notice ***
;
; Copyright 2008 by Uri Wilensky.  All rights reserved.
;
; Permission to use, modify or redistribute this model is hereby granted,
; provided that both of the following requirements are followed:
; a) this copyright notice is included.
; b) this model will not be redistributed for profit without permission
;    from Uri Wilensky.
; Contact Uri Wilensky for appropriate licenses for redistribution for
; profit.
; *** End of NetLogo 4.0.3 Model Copyright Notice ***
@#$#@#$#@
GRAPHICS-WINDOW
261
11
725
476
-1
-1
13.82
1
12
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
18
49
121
112
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
147
48
254
110
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

SLIDER
18
152
213
185
connection-strength
connection-strength
0.1
3
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
19
197
212
230
external-activation
external-activation
-8
8
0.0
0.1
1
NIL
HORIZONTAL

PLOT
1196
87
1518
397
Histogram of active symptoms
No. of active symptoms
Frequency
0.0
14.0
0.0
10.0
true
false
"" ""
PENS
"mood" 1.0 1 -13791810 true "" ""

PLOT
1115
408
1519
780
Hysteresis plot
external activation (stress)
Avg. active symptoms
0.0
10.0
0.0
14.0
true
true
"" ""
PENS
"symptom-present" 1.0 0 -2674135 true "" ""

BUTTON
20
252
184
311
NIL
administer-shock
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
740
12
912
45
Depressed-mood
Depressed-mood
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
740
58
912
91
Loss-of-interest
Loss-of-interest
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
741
104
913
137
Weight-loss
Weight-loss
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
742
150
914
183
Weight-gain
Weight-gain
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
743
197
915
230
Decreased-appetite
Decreased-appetite
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
743
242
915
275
Increased-appetite
Increased-appetite
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
744
285
916
318
Insomnia
Insomnia
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
941
12
1119
45
Hypersomnia
Hypersomnia
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
943
57
1119
90
Psychomotor-agitation
Psychomotor-agitation
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
943
105
1122
138
Psychomotor-retardation
Psychomotor-retardation
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
945
149
1120
182
Fatigue
Fatigue
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
946
196
1122
229
Worthlessness
Worthlessness
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
947
242
1122
275
Concentration-problems
Concentration-problems
-5
5
0.0
1
1
NIL
HORIZONTAL

SLIDER
948
288
1123
321
Suicidal-thoughts
Suicidal-thoughts
-5
5
0.0
1
1
NIL
HORIZONTAL

PLOT
5
490
729
780
Network Status
time
Number of active symptoms
0.0
0.0
0.0
14.0
true
true
"" ""
PENS
"symptom-present" 1.0 0 -2674135 true "" ""
"cut-off" 1.0 0 -16777216 true "" ""

SWITCH
20
334
213
367
kindling-effect?
kindling-effect?
1
1
-1000

PLOT
736
408
1107
780
Depressive episodes
Time
1- Depressed , 0- Non-Depressed
0.0
10.0
0.0
2.0
true
true
"" ""
PENS
"episode" 1.0 0 -16777216 true "" ""

TEXTBOX
1582
46
1862
511
Notes:- \n\n1) Connection strength is the individual's vulnerability and external-activation is the external stress to the entire system.\n \n2) A depressive episode is recognised when the person has atleast 7 symptoms in the last consecutive 2 weeks (14 days). (from DSMIIIR Manual).\n\n3) The individual symptoms sliders affects the activation of a specific symptom. It can also be thought of as threshold for a particular symptom where negative values on the slider relate to a higher threshold which in turn means lesser activation and vice-versa.  \n  \n4) Turning on 'kindling-effect' makes the connections strong by 0.001 each time the person has a new episode.\n \n5) Depressive episodes plot shows if the indivudual is having a depression episode or not. A flat line on the plot means the state is continuing. The epsiode counter shows the total number of episodes till date.\n\n6) Hystersis plot shows the memory of the system. On Y-axis we have the total number of active symptoms vs the external stress on X-axis.   
12
112.0
1

MONITOR
955
346
1108
407
Episode-Counter
counter episode-cntr
17
1
15

@#$#@#$#@
## WHAT IS IT?


This model is a network- representation of major depression. The nodes in this model represent the symptoms of major depression. According to the DSM-IV (APA, 2000) there are 14 symptoms: (1) depressed mood, (2) loss of interest, (3) weight loss, (4) weight gain, (5) decreased appetite, (6) increased appetite, (7) insomnia, (8) hypersomnia, (9) psychomotor agitation, (10) psychomotor retardation, (11) fatigue, (12) worthlessness or guilt, (13) concentration problems, and (14) suicidal thoughts.   
In this model, we hypothesize that symptoms of mental disorders have direct causal relations with one another and is called the causal network perspective. For instance, if one develops a symptom of major depression (e.g., insomnia) then this increases the likelihood of developing other symptoms (e.g., fatigue, lack of concentration). Conversely, if one of the symptoms disappears, this increases the likelihood that other symptoms disappear as well. 


In terms of this network, the vulnerabilities of a person are represented as connection strengths between the above symptoms. Higher connection strengths mean the person is more vulnerable to get the symptoms and consequently more likely to get into a depression. A lower connection strength (vulnerable) individual is less likely to sustain long depression episodes. Additionally, the kindling effect is used to represent the time varying nature of the vulnerabilities. The phenomenon states that stressful life events play the greatest role in the first onset of Major Depression. Subsequent episodes are then caused by less and less severe life events (Monroe, Torres, Guillaumot, Harkness, Roberts, Frank & Kupfer, 2006). So after each depression episode the vulnerabilites (connection strengths) are made stronger resulting into an earlier tipping point into a depression epsiode. Life events like severe marital problems give the depression network additional push, increasing the likelihood of triggering more depression symptoms over time. This is modelled as 'external-activation' parameter which can be altered in the model interface. Hystersis effect takes into account that strongly connected networks need interventions greater than what was required initially to get the system to depressed state. For instance, a person with substance abuse may not recover from depression even after he stops using substance. Conversely, a jolly person will recover soon from a relationship breakup even if he doesnot find a new partner. 


## HOW IT WORKS

1) At each 'tick' (time point) the probability a symptom 'i' becomes activated is calculated using logistic equation:

1 / 1 + e^(b - A)

where b is the individual threshold of symptom 'i' determined from empirical data and A is the total amount of stress on the symptom 'i'. 


2) A depressive episode is recognised when the person has atleast 7 symptoms (black cut-off line in Network status plot) in the last consecutive 2 weeks. (from DSM III R Manual)
   
3) Turning on 'kindling-effect' makes the connections strong by 0.001 each time the person has a new episode.

4) Hitting the 'adminsiter-shock' gives the network a shock which deactivates all the symptoms and gives the system a fresh start. However, keep in mind that turning on the kindling effect will have already increased the connection strengths to some degree. So adminstering shock and turning on kindling-effect again will start the system from the point where kindling-effect was stopped (if it was turned on previously).   


## HOW TO USE IT

1) Start the model by hitting the 'setup' button.

2) 'go' starts the simulations.

3) 'connection-strength' represents the vulnerability of a person while 'external-activation' is the external stress caused by significant life events.

4) Use the individual symptom sliders to see the effect of a specifc symptom, which may be useful to target a specific symptom having greatest impact on the network status. 

5) Hit 'administer-shock' to give the network a fresh start. This deactivates all the active symptoms momentarily.

## THINGS TO NOTICE

1) The person is said to be having a depression episode if the network status plot stays above the cutoff (black line) for at least 14 consecutive ticks. You can also see this as a new episode recorded in the Depression episodes plot.

2) Targeting specific symptoms has different effects on the network. For instance, you observe person cycling between depressed and non-depressed state continuosuly at some specific parameter values.

## THINGS TO TRY

1) You can try to see for which values of connection-strength or external-activation the person goes into depression. 

2) Turning on the kindling-effect changes the dynamics of system in intresting ways. A thing to note is that adminstering shocks brings the system back to healthy state momentarily however this has the net effect of increasing the episode count which requires a person to go back to healthy state, which in turn increases the connection strength. However, this happens at some parameter settings. Test this and feel free to make the dynamics even more interesting.  

## CREDITS AND REFERENCES

- Van Borkulo, C.D., Van der Maas, H.L.J., Borsboom, D., and Cramer, A.O.J. (2013). NetLogo Vulnerability_to_Depression.  
http://ccl.northwestern.edu/netlogo/models/community/Vulnerability_to_Depression. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.   
- Borsboom, 2008
- Cramer, Waldorp, van der Maas & Borsboom, 2010
- Schmittmann, Cramer, Waldorp, Epskamp, Kievit & Borsboom, 2011
- Cramer, Borsboom, Aggen, & Kendler, 2012
- Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.
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
