(define (problem workout1) (:domain testDomain)
(:objects 
        user - person 
        benchPress1 - benchPress
)

(:init
        (at user benchpress1)
        (is-Person user)
        (is-Station benchPress1)
        (=(stamina-level user) 101)
        (=(stamina-required benchPress1) 50)
        (=(calories-burnt user) 0)
        (=(injury-level user) 0)
        (=(injury-threshold user) 101)
        (=(injury-risk benchPress1) 5)
        (=(activity-calories benchPress1) 10)
        (=(calorie-ratio user) 1.5)
        
        (=(rest-gain user) 50)
        (=(rest-loss user) 0.5)
        (=(calory-goal user) 60)
        (=(stamina-ceiling user) 100)
        (=(calorie-ratio-floor user) 0.5)
)

(:goal  (and (>= (calories-burnt user) (calory-goal user)) ))
             
(:metric minimize (total-time))

)