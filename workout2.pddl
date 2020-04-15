(define (problem workout) (:domain gym)
(:objects 
        user - person 
        benchPress1 - benchPress
)

(:init
        (at user benchpress1)
        (=(stamina-level user) 100)
        (=(stamina-required benchPress1) 5)
        (=(calories-burnt user) 0)
        (=(injury-level user) 0)
        (=(injury-threshold user) 150)
        (=(injury-risk benchPress1) 10)
        (=(activity-calories benchPress1) 10) 
        (=(calorie-ratio user) 2)
        (=(rest-gain user) 10)
        (=(rest-loss user) 0.5)
        (=(time-limit user) 300)
        (=(current-time user) 0)
        (=(calory-goal user) 215)
        (=(stamina-ceiling user) 100)
        (=(calorie-ratio-floor user) 1)
)

(:goal (and (< (injury-level user) (injury-threshold user))
            (<= (current-time user) (time-limit user))
            (>= (calories-burnt user) (calory-goal user)))
)

;un-comment the following line if metric is needed
(:metric minimize (injury-threshold user))

)
