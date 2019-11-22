(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holding ?x - block)
	       )

  (:action pickup
	     :parameters (?x - block)
	     :precondition (and (clear ?x) (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (clear ?x))
		   (not (handempty))
		   (holding ?x)))

  (:action putdown
	     :parameters (?x - block)
	     :precondition (and (holding ?x))
	     :effect
	     (and (not (holding ?x))
		   (clear ?x)
		   (handempty)
		   (ontable ?x)))

  (:action stack
	     :parameters (?x - block ?y - block)
	     :precondition (and (holding ?x))
	     :effect
	     (and (not (holding ?x))))
		   

  (:action unstack
	     :parameters (?x - block ?y - block)
	     :precondition (and (on ?x ?y))
	     :effect
	     (and (holding ?x)
		  )))