(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holding ?x - block)
	       )

  (:action pick-up
	     :parameters (?x - block)
	     :precondition (and  (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (clear ?x))
		   (not (handempty))
		   ))

  (:action pick-up_new
	     :parameters (?x - block)
	     :precondition (and  (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (clear ?x))
		   (not (handempty))
		   ))

  (:action put-down
	     :parameters (?x - block)
	     :precondition (and (holding ?x))
	     :effect
	     (and (not (holding ?x))
		   (clear ?x)
		   (handempty)
		   (ontable ?x)))

  (:action put-down_new
	     :parameters (?x - block)
	     :precondition (and (holding ?x))
	     :effect
	     (and (not (holding ?x))
		   (clear ?x)
		   (handempty)
		   (ontable ?x)))
  (:action stack
	     :parameters (?x - block ?y - block)
	     :precondition (and (clear ?y))
	     :effect
	     (and (not (holding ?x))
		   (not (clear ?y))
		
		   (handempty)
		   (on ?x ?y)))

  (:action stack_new
	     :parameters (?x - block ?y - block)
	     :precondition (and (clear ?y))
	     :effect
	     (and (not (holding ?x))
		   (not (clear ?y))
		
		   (handempty)
		   (on ?x ?y)))
  (:action unstack
	     :parameters (?x - block ?y - block)
	     :precondition (and  (clear ?x) (handempty))
	     :effect
	     (and (holding ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (on ?x ?y))))
  
  (:action unstack_new
	     :parameters (?x - block ?y - block)
	     :precondition (and  (clear ?x) (handempty))
	     :effect
	     (and (holding ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (on ?x ?y)))))