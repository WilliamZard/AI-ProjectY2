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
                (time-limit ?p - person)
                (current-time ?p - person)
                (stamina-ceiling ?p - person)
                (calorie-ratio-floor ?p - person))

    (:durative-action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :duration(= ?duration 30)
        :condition (and (at start(at ?p ?s)) 
                        (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (< (+ (current-time ?p) 5) (time-limit ?p)))
                        (at start (> (- (stamina-level ?p) (stamina-required ?s)) 0))
                        (over all (at ?p ?s)))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (activity-calories ?s))) 
                (at end (increase (injury-level ?p) (injury-risk ?s)))
                (at end (increase (current-time ?p) 5)))
                
    )

    (:durative-action rest
       :parameters(?p - person)
       :duration(= ?duration 30)
        :condition (and (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
                        (at start (< (+(stamina-level ?p)(rest-gain ?p)) (stamina-ceiling ?p)))
                        (at start (>= (- (calorie-ratio ?p) (rest-loss ?p)) (calorie-ratio-floor ?p))))
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p)))
                    (at end(increase (current-time ?p) 30)))       
            
    )

    ;(:action move
        ;:parameters (?p - person ?from ?to - station)
        ;:precondition (and (at ?p ?from))
        ;:effect (and (not (at ?p ?from)) (at ?p ?to))
    ;)
    ;(:durative-action rest
        ;:parameters (?p - person)
        ;:duration (= ?duration 30)
        ;:condition (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
        ;:effect (at end(increase (stamina-level ?p) (rest-gain ?p)))
        
   ;)

    (:durative-action recover
        :parameters (?p - person)
        :duration (= ?duration 30)
        :condition (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
        :effect (at end(decrease (injury-level ?p) (rest-gain ?p)))
        
    )
    
    

    
)