//
//  MoreViewController.swift
//  Milestone
//
//  Created by 서은수 on 2023/08/14.
//

import UIKit

import SnapKit
import Then

// MARK: - 상위 목표 상세 더보기 화면

class MoreViewController: BaseViewController {
    
    // MARK: - SubViews
    
    let containerView = UIView()
        .then {
            $0.backgroundColor = .white
            $0.layer.masksToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = 20
        }
    let barView = UIView()
        .then {
            $0.backgroundColor = .gray02
            $0.layer.cornerRadius = 5 / 2
        }
    lazy var modifyOptionView = MoreOptionView()
        .then {
            $0.iconImageView.image = ImageLiteral.imgModify
            $0.optionLabel.text = "수정하기"
            var tapModifyGesture = UITapGestureRecognizer(target: self, action: #selector(self.presentModifyGoalViewController))
            $0.addGestureRecognizer(tapModifyGesture)
        }
    lazy var removeOptionView = MoreOptionView()
        .then {
            $0.iconImageView.image = ImageLiteral.imgRemove
            $0.optionLabel.text = "삭제하기"
            var tapRemoveGesture = UITapGestureRecognizer(target: self, action: #selector(self.presentDeleteGoalViewController))
            $0.addGestureRecognizer(tapRemoveGesture)
        }
    lazy var restoreOptionView = MoreOptionView()
        .then {
            $0.iconImageView.image = ImageLiteral.imgRestore
            $0.optionLabel.text = "복구하기"
//            var tapRestorGesture = UITapGestureRecognizer(target: self, action: #selector(self.presentDeleteGoalViewController))
//            $0.addGestureRecognizer(tapRestorGesture)
        }
    
    // MARK: - Properties
    
    var isFromStorage = false
    let viewHeight = 173.0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFromStorage { setRestoreOption() }
    }
    
    // MARK: - Functions
    
    override func render() {
        view.addSubViews([containerView])
        containerView.addSubViews([barView, modifyOptionView, removeOptionView])
        
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        barView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        modifyOptionView.snp.makeConstraints { make in
            make.top.equalTo(barView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        removeOptionView.snp.makeConstraints { make in
            make.top.equalTo(modifyOptionView.snp.bottom).offset(32)
            make.left.equalTo(modifyOptionView)
        }
    }

    override func configUI() {
        containerView.makeShadow(color: .init(hex: "#464646", alpha: 0.2), alpha: 1, x: 0, y: -10, blur: 20, spread: 0)
    }
    
    func setRestoreOption() {
        modifyOptionView.removeFromSuperview()
        view.addSubView(restoreOptionView)
        restoreOptionView.snp.makeConstraints { make in
            make.top.equalTo(barView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        removeOptionView.snp.remakeConstraints { make in
            make.top.equalTo(restoreOptionView.snp.bottom).offset(32)
            make.left.equalTo(restoreOptionView)
        }
    }
    
    // MARK: - @objc Functions

    @objc
    private func presentModifyGoalViewController() {
        lazy var addParentGoalVC = AddParentGoalViewController()
            .then {
                $0.completeButton.titleString = "목표 수정 완료"
                $0.enterGoalTitleView.titleTextField.text = "토익 900점 넘기기"
                $0.enterGoalTitleView.updateNowNumOfCharaters()
            }
        dismiss(animated: true)
        self.presentingViewController?.presentCustomModal(addParentGoalVC, height: addParentGoalVC.viewHeight)
    }

    @objc
    private func presentDeleteGoalViewController() {
        Logger.debugDescription("삭제하기 클릭")
        let deleteGoalPopUp = DeleteGoalViewController()
            .then {
                $0.modalTransitionStyle = .crossDissolve
                $0.modalPresentationStyle = .overFullScreen
            }
        dismiss(animated: true)
        self.presentingViewController?.present(deleteGoalPopUp, animated: true)
    }
}
