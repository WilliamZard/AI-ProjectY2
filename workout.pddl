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
        (=(injury-threshold user) 100)
        (=(injury-risk benchPress1) 10)
        (=(activity-calories benchPress1) 200) 
        (=(calorie-ratio user) 1)
        (=(rest-gain user) 10)
        (=(rest-loss user) 0.2)
        (=(time-limit user) 216000)
        (=(current-time user) 0)
        (=(calory-goal user) 200)
)

(:goal ;(and (< (injury-level user) (injury-threshold user))
            ;(> (stamina-level user) 0)
            ;(<= (current-time user) (time-limit user))
            (>= (calories-burnt user) (calory-goal user))
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)