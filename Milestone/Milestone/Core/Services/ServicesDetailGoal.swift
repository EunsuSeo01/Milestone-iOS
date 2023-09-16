//
//  ServicesDetailGoal.swift
//  Milestone
//
//  Created by 서은수 on 2023/08/24.
//

import Foundation

import RxSwift

// MARK: - 세부 목표와 관련된 서비스 함수 작성

protocol ServicesDetailGoal: Service {
    /// 세부 목표 리스트 조회 API 요청
    func requestDetailGoalList(id: Int) -> Observable<Result<BaseModel<[DetailGoal]>, APIError>>
    /// 세부 목표 생성 API 요청
    func requestPostDetailGoal(id: Int, reqBody: NewDetailGoal) -> Observable<Result<EmptyDataModel, APIError>>
    /// 세부 목표 완료 API 요청
    func requestCompleteDetailGoal(id: Int) -> Observable<Result<BaseModel<StateUpdatedDetailGoal>, APIError>>
    /// 세부 목표 완료 취소 API 요청
    func requestIncompleteDetailGoal(id: Int) -> Observable<Result<EmptyDataModel, APIError>>
    /// 세부 목표 상세 정보 API 요청
    func requestDetailGoalInfo(id: Int) -> Observable<Result<BaseModel<DetailGoalInfo>, APIError>>
    /// 세부 목표 수정 API 요청
    func requestEditDetailGoal(id: Int, reqBody: NewDetailGoal) -> Observable<Result<EmptyDataModel, APIError>>
    /// 세부 목표 삭제 API 요청
    func requestDeleteDetailGoal(id: Int) -> Observable<Result<BaseModel<StateUpdatedDetailGoal>, APIError>>
}

extension ServicesDetailGoal {
    func requestDetailGoalList(id: Int) -> Observable<Result<BaseModel<[DetailGoal]>, APIError>> {
        return apiSession.request(.requestAllDetailGoal(higherLevelGoalId: id))
    }
    func requestPostDetailGoal(id: Int, reqBody: NewDetailGoal) -> Observable<Result<EmptyDataModel, APIError>> {
        return apiSession.request(.postDetailGoal(higherLevelGoalId: id, detailGoal: reqBody))
    }
    func requestCompleteDetailGoal(id: Int) -> Observable<Result<BaseModel<StateUpdatedDetailGoal>, APIError>> {
        return apiSession.request(.completeDetailGoal(lowerLevelGoalId: id))
    }
    func requestIncompleteDetailGoal(id: Int) -> Observable<Result<EmptyDataModel, APIError>> {
        return apiSession.request(.incompleteDetailGoal(lowerLevelGoalId: id))
    }
    func requestDetailGoalInfo(id: Int) -> Observable<Result<BaseModel<DetailGoalInfo>, APIError>> {
        return apiSession.request(.requestDetailGoalInformation(lowerLevelGoalId: id))
    }
    func requestEditDetailGoal(id: Int, reqBody: NewDetailGoal) -> Observable<Result<EmptyDataModel, APIError>> {
        return apiSession.request(.editDetailGoal(lowerLevelGoalId: id, detailGoal: reqBody))
    }
    func requestDeleteDetailGoal(id: Int) -> Observable<Result<BaseModel<StateUpdatedDetailGoal>, APIError>> {
        return apiSession.request(.deleteDetailGoal(lowerLevelGoalId: id))
    }
}