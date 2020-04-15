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
        user - person
        benchPress squat - station)


    (:predicates 
        (at ?p - person ?s - station))

    (:functions (stamina-level ?p - person)
                (stamina-required ?s - station)
                (calories-burnt ?p - person) 
                (calory-goal ?p - person) 
                (injury-level ?p - person)
                (injury-threshold ?p - person)
                (injury-risk ?s - station)
                (activity-calories ?s - station)
                (calorie-ratio ?p)
                (rest-gain ?p)
                (rest-loss ?p)
                (time-limit ?p)
                (current-time ?p))

    (:durative-action useBenchPress
        :parameters (?p - user ?s - benchPress)
        :duration(= ?duration 1)
        :condition (and (at start(at ?p ?s)) 
                        (at start (> (injury-level ?p) (injury-threshold ?p)))
                        (at start (< (+ (current-time ?p) 5) (time-limit ?p)))
                        (at start (> (stamina-level ?p) 0))
                        (over all (at ?p ?s)))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p))))
                (at end (increase (injury-level ?p) (injury-risk ?s)))
                (at end (increase (current-time ?p) 5)))
                
    )

    (:durative-action rest
        :parameters(?p - person)
        :duration(= ?duration 30)
        :condition (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p)))
                    (at end(increase (current-time ?p) 30)))       
            
    )

    (:action move
        :parameters (?p - person ?from ?to - station)
        :precondition (and (at ?p ?from))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
)