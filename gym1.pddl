(define (domain gym1)

    (   :requirements
        :typing
        :fluents
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
                (time-limit ?p - person)
                (current-time ?p - person)
                (stamina-ceiling ?p - person)
                (calorie-ratio-floor ?p - person))

    (:action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :precondition (and (at ?p ?s) 
                        (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p))
                        (< (+ (current-time ?p) 5) (time-limit ?p))
                        (> (- (stamina-level ?p) (stamina-required ?s)) 0))               
        :effect (and (decrease (stamina-level ?p) (stamina-required ?s))
                (increase (calories-burnt ?p) (activity-calories ?s)) 
                (increase (injury-level ?p) (injury-risk ?s))
                (increase (current-time ?p) 5))
                
    )

    (:action rest
       :parameters(?p - person)
        :precondition (and (< (+ (current-time ?p) 30) (time-limit ?p))
                           (< (+(stamina-level ?p)(rest-gain ?p)) (stamina-ceiling ?p))
                           (>= (- (calorie-ratio ?p) (rest-loss ?p)) (calorie-ratio-floor ?p)))
        :effect (and 
                    (increase (stamina-level ?p) (rest-gain ?p))
                    (decrease (calorie-ratio ?p) (rest-loss ?p))
                    (increase (current-time ?p) 30))       
            
    )

    (:action recover
        :parameters (?p - person)
        :precondition (< (+ (current-time ?p) 30) (time-limit ?p))
        :effect (and (decrease (injury-level ?p) (rest-gain ?p)))
    )
          
)