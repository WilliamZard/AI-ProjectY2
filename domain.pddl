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
        person station - object
        legPress treadmill benchPress squat rowingMachine - station
        )


    (:predicates 
        (at ?p - person ?s - station)
        (can-move ?p - person ?s1 ?s2 - station)
        (is-Station ?s - station)
        (is-Person ?p - person)
    )

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
                ;(time-limit ?p - person)
                ;(current-time ?p - person)
                (stamina-ceiling ?p - person)
                (calorie-ratio-floor ?p - person))

    (:durative-action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :duration(= ?duration 5)
        :condition (and (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (at ?p ?s))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p)))) 
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )

    (:durative-action useSquat
        :parameters (?p - person ?s - squat)
        :duration(= ?duration 50)
        :condition (and (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (at ?p ?s))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p))))
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )

    (:durative-action useRowing
        :parameters (?p - person ?s - rowingMachine)
        :duration(= ?duration 20)
        :condition (and (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (at ?p ?s))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p))))
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )

    (:durative-action useTreadmil
        :parameters (?p - person ?s - treadmill)
        :duration(= ?duration 25)
        :condition (and (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (at ?p ?s))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p)))) 
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )

    (:durative-action useLegPress
        :parameters (?p - person ?s - legPress)
        :duration(= ?duration 50)
        :condition (and (at start (< (+(injury-level ?p)(injury-risk ?s)) (injury-threshold ?p)))
                        (at start (at ?p ?s))
                        (at start (> (stamina-level ?p) (stamina-required ?s)))
                        (at end (> (stamina-level ?p) 0))
                        (over all (at ?p ?s))
                        (over all (> (stamina-level ?p) (stamina-required ?s))))
        :effect (and (at end (decrease (stamina-level ?p) (stamina-required ?s))) 
                (at end (increase (calories-burnt ?p) (* (activity-calories ?s) (calorie-ratio ?p)))) 
                (at end (increase (injury-level ?p) (injury-risk ?s))))
    )
    

    (:durative-action rest
       :parameters(?p - person)
       :duration(= ?duration 30)
        :condition (and ;(at start (< (+ (current-time ?p) 30) (time-limit ?p)))
                        (at start (< (+(stamina-level ?p)(rest-gain ?p)) (stamina-ceiling ?p)))
                        (at start (>= (- (calorie-ratio ?p) (rest-loss ?p)) (calorie-ratio-floor ?p))))
        :effect (and 
                    (at end(increase (stamina-level ?p) (rest-gain ?p)))
                    (at end(decrease (calorie-ratio ?p) (rest-loss ?p))))
                    ;(at end(increase (current-time ?p) 30)))       
            
    )

    (:durative-action move
        :parameters (?p - person ?from - station ?to - station)
        :duration (= ?duration 1)
            :condition (and
                        (at start (is-Person ?p))
                        (at start (is-Station ?from))
                        (at start (is-Station ?to))
                        (over all (can-move ?p ?from ?to)) 
                        (at start (at ?p ?from)))
                        
            :effect (and 
                        (at end (at ?p ?to))
                        (at start (not (at ?p ?from))))                       
    )

    ;(:durative-action rest
        ;:parameters (?p - person)
        ;:duration (= ?duration 30)
        ;:condition (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
        ;:effect (at end(increase (stamina-level ?p) (rest-gain ?p)))
        
   ;)

    (:durative-action recover
        :parameters (?p - person)
        :duration (= ?duration 30)
        ;:condition (at start (< (+ (current-time ?p) 30) (time-limit ?p)))
        :effect (at end(decrease (injury-level ?p) (rest-gain ?p)))
        
    )
    
    

    
)