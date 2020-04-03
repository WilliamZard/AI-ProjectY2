(define (domain <gym>)

    (:requirements
        :types
        :fluents
    )
    
    (:types person benchPress deadLift pullupBar squat row pushup situp)

    (:predicates ((at ?p - person ?s - benchPress) (at ?p - person ?s - deadLift) (at ?p - person ?s - pullupBar)
                (at ?p - person ?s - pushup) (at ?p- person ?s - row) (at ?p - person ?s - situp) 
                (at ?p - person ?s - squat) (injured ?p - person))

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
                (rest-loss ?p))


    (:action useBenchPress
        :parameters (?p - person ?s - benchPress)
        :precondition (and (at ?p ?s) (>= (stamina-level ?p) (stamina-required ?a)) (< (injury-level ?p) (injury-threshold ?p))
        :effect (and (decrease (stamina-level ?p) (stamina-required ?a)) 
                (increase (calories-burnt ?p) (scale-up (activity-calories ?a) (calorie-ratio ?p))
                (increase (injury-level ?p) (injury-risk ?a))
    )

    (:action rest
        :parameters(?p - person)
        :effect (and (increase (stamina-level ?p) (rest-gain ?p)) (decrease (calorie-ratio ?p) (rest-loss ?p))) 
            
    )

    (:action move
        :parameters (?p - person ?from ?to - station)
        :precondition (and (at ?p ?from))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
)