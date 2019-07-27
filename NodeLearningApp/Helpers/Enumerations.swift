//
//  Enumerations.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import Foundation

enum ResponseStatus : Int {
    case APIFailure = 0
    case Success = 1001
    case AuthorisationFailed = 1002
    case ValidationFailed = 1003
    case EmptyResponse = 1004
    case UnknownError = 1005 // Not used
    case TryAgain = 1007
    case ConversationUnmatch = 1008 // Not used
    case InvalidRequest = 1009
    case MovedToForgotPasswordForLoginFailure = 1010
    case Unknown1011 = 1011
    case BTPinAlreadyTaken = 1014
    case Unknown1015 = 1015
    case Unknown1016 = 1016
    case ChatUserBlocked = 1020
    case ChatRequestDeclined = 1021
    case SuccessAlternate = 1022
    case UserBlocked = 1024
    case ReviewRejected = 1030
}
