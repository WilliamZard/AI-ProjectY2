(define (problem problem4) (:domain gym)
(:objects 
        user - person 
        squat1 - squat
        treadmill1 - treadmill
        legPress1 - legPress
)

(:init
        (at user squat1)
        (can-move user squat1 treadmill1)
        (can-move user treadmill1 squat1)
        (can-move user squat1 legPress1)
        (can-move user legPress1 squat1)
        (can-move user legPress1 treadmill1)
        (can-move user treadmill1 legPress1)
        
        (is-Station squat1)
        (is-Station treadmill1)
        (is-Station legPress1)

        (is-Person user)
        
        (=(stamina-level user) 100)

        (=(stamina-required treadmill1) 40)
        (=(injury-risk treadmill1) 5)
        (=(activity-calories treadmill1) 60)

        (=(stamina-required squat1) 25)
        (=(injury-risk squat1) 10)
        (=(activity-calories squat1) 25)

        (=(stamina-required legPress1) 20)
        (=(injury-risk legPress1) 10)
        (=(activity-calories legPress1) 15)

        (=(calories-burnt user) 0)
        (=(injury-level user) 0)
        (=(injury-threshold user) 101)
        (=(calorie-ratio user) 1.5)
        (=(rest-gain user) 50)
        (=(rest-loss user) 0.5)
        (=(calory-goal user) 120)
        (=(stamina-ceiling user) 100)
        (=(calorie-ratio-floor user) 0.5)
)

(:goal  (and (>= (calories-burnt user) (calory-goal user)))
)

(:metric minimize (total-time))

)