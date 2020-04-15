(define (domain gym)

    (   :requirements
        :typing
        :fluents
        :durative-actions
        :duration-inequalities
        :equality
        :negative-preconditions
    )
    
    (:types 
            benchPress squat - station
            person - person)


    (:predicates (at ?p - person ?s - station) 
                 (injured ?p - person)
                 (fatigued ?p - person)
                 (in-time-frame ?p -person)
                 (calorie-goal-reached ?p -person))

    (:functions (stamina-level ?p - person)
                (stamina-required ?s - station)
                (calories-burnt ?p - person) 
                (calory-goal ?p - person) 
                (injury-level ?p - person)
                (injury-threshold ?p - person)
                (injury-risk ?s -action)
                (activity-calories ?s - action)
                (calorie-ratio ?p)
                (rest-gain ?p)
                (rest-loss ?p)
                (time-limit ?p)
                (current-time ?p))

    (:durative-action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :duration(= ?duration 1)
        :condition (and (at start(at ?p ?s)) 
                        (at start (not(injured ?p)))
                        (at start (in-time-frame ?p))
                        (at start (not (fatigued ?p)))
                        (over all (at ?p ?s)))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (scale-up (activity-calories ?s) (calorie-ratio ?p))))
                (at end (increase (injury-level ?p) (injury-risk ?s)))
                (at end (increase (current-time ?p)(5)))
                (at end (when(<=((stamina-level ?p)(0))) 
                                (fatigued ?p)))
                (at end(when(>=((injury-level ?p)(injury-threshold ?p)))
                                (injured ?p)))
                (at end (when(>(current-time ?p)(time-limit ?p))) 
                                (not(in-time-frame ?p)))
                (at end (when(=(calories-burnt ?p)(calory-goal ?p)))
                                (calorie-goal-reached ?p)))
                
    )`

    (:durative-action rest
        :parameters(?p - person)
        :duration(= ?duration 30)
        :condition (in-time-frame ?p)
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p)))
                    (at end(increase (current-time ?p) (30)))
                    (at end (when(>(current-time ?p)(time-limit ?p))) 
                                (not(in-time-frame ?p)))
                    (at end (when(>(stamina-level ?p)(0))
                                (not(fatigued ?p)))))          
            
    )

    (:action move
        :parameters (?p - person ?from ?to - station)
        :precondition (and (at ?p ?from))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
)