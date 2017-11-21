//
//  popanimation.swift
//  StopTap
//
//  Created by wajdi muhtadi on 8/25/17.
//  Copyright © 2017 wajdi muhtadi. All rights reserved.
//

import UIKit

class popanimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
        return 0.65
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController: UIViewController? = transitionContext.viewController(forKey: .from)
        let toViewController: UIViewController? = transitionContext.viewController(forKey: .to)
        if(fromViewController?.title! == "Settings" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "nm", defaultValue: 0) == 0){
            transitionContext.containerView.backgroundColor = UIColor.white
            }else{
                 transitionContext.containerView.backgroundColor = UIColor.black
            }
            toViewController?.view?.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.alpha = 1
                fromViewController?.view?.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Dev" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "nm", defaultValue: 0) == 0){
                transitionContext.containerView.backgroundColor = UIColor.white
            }else{
                transitionContext.containerView.backgroundColor = UIColor.black
            }
            toViewController?.view?.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.alpha = 1
                fromViewController?.view?.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Language" && toViewController?.title! == "Settings"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "nm", defaultValue: 0) == 0){
                transitionContext.containerView.backgroundColor = UIColor.white
            }else{
                transitionContext.containerView.backgroundColor = UIColor.black
            }
            toViewController?.view?.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.alpha = 1
                fromViewController?.view?.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(ProcessInfo().operatingSystemVersion.majorVersion > 8 && ProcessInfo().operatingSystemVersion.majorVersion < 11){
        print("ios 9 - 10")
         if(fromViewController?.title! == "Play" && toViewController?.title! == "Main"){
        transitionContext.containerView.addSubview((toViewController?.view)!)
        transitionContext.containerView.backgroundColor = UIColor.white
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
            toViewController?.view?.center.y = (fromViewController?.view.center.y)!
            fromViewController?.view?.center.y = (fromViewController?.view.center.y)! / -1
        }, completion: {(_ finished: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        }
        if(fromViewController?.title! == "Htp" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            transitionContext.containerView.backgroundColor = UIColor.white
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                fromViewController?.view?.center.x = (fromViewController?.view.center.x)! / -1
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Shop" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            transitionContext.containerView.backgroundColor = UIColor.white
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
             toViewController?.view?.center.x = (fromViewController?.view.center.x)!
              fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Score" && toViewController?.title! == "Play"){
                transitionContext.containerView.addSubview((toViewController?.view)!)
                transitionContext.containerView.backgroundColor = UIColor.white
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                    toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                    fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
                }, completion: {(_ finished: Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
        }
            if(fromViewController?.title! == "Score" && toViewController?.title! == "Main"){
                transitionContext.containerView.addSubview((toViewController?.view)!)
                transitionContext.containerView.backgroundColor = UIColor.white
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                    toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                    fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
                }, completion: {(_ finished: Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
            
        }else{
        print("ios 8 or 11")
        if(fromViewController?.title! == "Play" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            transitionContext.containerView.backgroundColor = UIColor.white
            toViewController?.view?.center.y = (toViewController?.view?.center.y)! * 3
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.center.y = (fromViewController?.view.center.y)!
                fromViewController?.view?.center.y = (fromViewController?.view.center.y)! / -1
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Htp" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            transitionContext.containerView.backgroundColor = UIColor.white
            toViewController?.view?.center.x = (toViewController?.view?.center.x)! * 3
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                fromViewController?.view?.center.x = (fromViewController?.view.center.x)! / -1
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        if(fromViewController?.title! == "Shop" && toViewController?.title! == "Main"){
            transitionContext.containerView.addSubview((toViewController?.view)!)
            transitionContext.containerView.backgroundColor = UIColor.white
            toViewController?.view?.center.x = (toViewController?.view.center.x)! / -1
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
            }, completion: {(_ finished: Bool) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
            if(fromViewController?.title! == "Score" && toViewController?.title! == "Play"){
                transitionContext.containerView.addSubview((toViewController?.view)!)
                transitionContext.containerView.backgroundColor = UIColor.white
                toViewController?.view?.center.x = (toViewController?.view.center.x)! / -1
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                    toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                    fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
                }, completion: {(_ finished: Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
            if(fromViewController?.title! == "Score" && toViewController?.title! == "Main"){
                transitionContext.containerView.addSubview((toViewController?.view)!)
                transitionContext.containerView.backgroundColor = UIColor.white
                toViewController?.view?.center.x = (toViewController?.view.center.x)! / -1
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {() -> Void in
                    toViewController?.view?.center.x = (fromViewController?.view.center.x)!
                    fromViewController?.view?.center.x = (fromViewController?.view.center.x)! * 3
                }, completion: {(_ finished: Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
            
        }
        }
    }

