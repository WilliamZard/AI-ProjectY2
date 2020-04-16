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
        person - object
        benchPress - station
        )


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
                (calorie-ratio ?p - person)
                (rest-gain ?p - person)
                (rest-loss ?p - person)
                (stamina-ceiling ?p - person)
                (calorie-ratio-floor ?p - person))

    (:durative-action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :duration(= ?duration 1)
        :condition (and (at start(at ?p ?s)) 
                        (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (activity-calories ?s))) 
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )

    (:durative-action rest
       :parameters(?p - person)
       :duration(= ?duration 30)
        :condition (and 
                        (at start (< (+(stamina-level ?p)(rest-gain ?p)) (stamina-ceiling ?p)))
                        (at start (>= (- (calorie-ratio ?p) (rest-loss ?p)) (calorie-ratio-floor ?p))))
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p))))   
            
    )


    (:durative-action recover
        :parameters (?p - person)
        :duration (= ?duration 30)
        :effect (at end(decrease (injury-level ?p) (rest-gain ?p)))
        
    )
    
    

    
)