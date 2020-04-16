(define (problem workout1) (:domain gym)
(:objects 
        user - person 
        benchPress1 - benchPress
)

(:init
        (at user benchpress1)
        (=(stamina-level user) 101)
        (=(stamina-required benchPress1) 50)
        (=(calories-burnt user) 0)
        (=(injury-level user) 0)
        (=(injury-threshold user) 101)
        (=(injury-risk benchPress1) 5)
        (=(activity-calories benchPress1) 10)
        (=(calorie-ratio user) 1.5)
        ;(=(time-limit user) 216000)
        ;(=(current-time user) 0)
        (=(rest-gain user) 50)
        (=(rest-loss user) 0.5)
        (=(calory-goal user) 50)
        (=(stamina-ceiling user) 100)
        (=(calorie-ratio-floor user) 0.5)
)

(:goal  (and (>= (calories-burnt user) (calory-goal user)) )
             ;(> (stamina-level user) 0)
             ;(> (injury-threshold user) (injury-level user)))
             ;(< (current-time user)(time-limit user)))
)
;un-comment the following line if metric is needed
(:metric minimize (total-time))

)