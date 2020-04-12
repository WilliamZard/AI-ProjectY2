(define (domain <gym>)

    (   :requirements
        :types
        :fluents
        :durative-actions
        :duration-inequalities
    )
    
    (:types 
            benchPress deadLift pullupBar squat row pushup situp - station
            person - person)


    (:predicates (at ?p - person ?s - station) 
                 (injured ?p - person))

    (:functions (stamina-level ?p - person)
                (stamina-required ?a - action)
                (calories-burnt ?p - person) 
                (calory-goal ?p - person) 
                (injury-level ?p - person)
                (injury-threshold ?p - person)
                (injury-risk ?a -action)
                (activity-calories ?a - action)
                (calorie-ratio ?p)
                (rest-gain ?p)
                (rest-loss ?p)
                (time-limit ?p)
                (current-time ?p))

    (:durative-action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :duration(= ?duration 1)
        :condition (and (at start(at ?p ?s)) 
                        (>= (at start (stamina-level ?p) (stamina-required ?a))) 
                        (< (at start (injury-level ?p) (injury-threshold ?p)))
                        (< (at start (+(current-time ?p)(5)) (time-limit ?p)))  ;duration is 5 seconds for each rep
                        (over all(at ?p ?s)))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?a))) 
                (at end (increase (calories-burnt ?p) (scale-up (activity-calories ?a) (calorie-ratio ?p))))
                (at end (increase (injury-level ?p) (injury-risk ?a))))
    )

    (:durative-action rest
        :parameters(?p - person)
        :duration(= ?duration 30)
        :condition (at start(<(+(current-time ?p(30) (time-limit ?p)))))
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p)))
                    (at end(increase (current-time ?p) (30))))
            
    )

    (:action move
        :parameters (?p - person ?from ?to - station)
        :precondition (and (at ?p ?from))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
)