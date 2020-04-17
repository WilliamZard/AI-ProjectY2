(define (problem workout2) (:domain testDomain)
(:objects 
        user - person 
        benchPress1 - benchPress
        squat1 - squat
)

(:init
        (at user squat1)
        (can-move user benchPress1 squat1)
        (can-move user squat1 benchPress1)
        (is-Station benchPress1)
        (is-Station squat1)
        (is-Person user)
        
        (=(stamina-level user) 100)

        (=(stamina-required benchPress1) 30)
        (=(injury-risk benchPress1) 5)
        (=(activity-calories benchPress1) 10)

        (=(stamina-required squat1) 40)
        (=(injury-risk squat1) 10)
        (=(activity-calories squat1) 15)

        (=(calories-burnt user) 0)
        (=(injury-level user) 0)
        (=(injury-threshold user) 101)
        (=(calorie-ratio user) 1.5)
        (=(rest-gain user) 50)
        (=(rest-loss user) 0.5)
        (=(calory-goal user) 60)
        (=(stamina-ceiling user) 100)
        (=(calorie-ratio-floor user) 0.5)
)

(:goal  (and (>= (calories-burnt user) (calory-goal user)))
)

(:metric minimize (total-time))

)