import Foundation
import Observation

// MARK: - Error Types

enum CalculationError: LocalizedError {
    case endBeforeStart
    case serviceTooLong(service: Int, total: Int)

    var errorDescription: String? {
        switch self {
        case .endBeforeStart:
            return "종료 시간이 시작 시간보다 이전입니다."
        case .serviceTooLong(let service, let total):
            return "서비스 시간(\(service)분)이 전체 시간(\(total)분)을 초과합니다."
        }
    }
}

// MARK: - Result Type

struct ScheduleResult {
    let startTime: Date
    let endTime: Date
    let serviceStartTime: Date
    let serviceEndTime: Date
    let totalMinutes: Int
    let serviceMinutes: Int
    let teamAMinutes: Int
    let teamBMinutes: Int
}

// MARK: - Model

@Observable
final class CalculatorModel {
    var startTime: Date = {
        Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date()) ?? Date()
    }()

    var endTime: Date = {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) ?? Date()
    }()

    var serviceMinutes: Int = 30

    var result: ScheduleResult? = nil
    var calculationError: CalculationError? = nil
    var showError: Bool = false
    var showResult: Bool = false

    // MARK: - Actions

    func incrementService() {
        serviceMinutes += 1
    }

    func decrementService() {
        guard serviceMinutes > 1 else { return }
        serviceMinutes -= 1
    }

    func calculate() {
        let totalMinutes = minutesDifference(from: startTime, to: endTime)

        guard totalMinutes > 0 else {
            calculationError = .endBeforeStart
            showError = true
            return
        }

        guard serviceMinutes < totalMinutes else {
            calculationError = .serviceTooLong(service: serviceMinutes, total: totalMinutes)
            showError = true
            return
        }

        // Core logic — integer (truncating) division
        let midPoint = totalMinutes / 2
        let serviceStart = midPoint - serviceMinutes / 2
        let serviceEnd = serviceStart + serviceMinutes

        let teamAMinutes = serviceStart
        let teamBMinutes = totalMinutes - serviceEnd   // odd minute falls to B

        let calendar = Calendar.current
        let serviceStartDate = calendar.date(byAdding: .minute, value: serviceStart, to: startTime) ?? startTime
        let serviceEndDate   = calendar.date(byAdding: .minute, value: serviceEnd,   to: startTime) ?? startTime

        result = ScheduleResult(
            startTime: startTime,
            endTime: endTime,
            serviceStartTime: serviceStartDate,
            serviceEndTime: serviceEndDate,
            totalMinutes: totalMinutes,
            serviceMinutes: serviceMinutes,
            teamAMinutes: teamAMinutes,
            teamBMinutes: teamBMinutes
        )
        showResult = true
    }

    // MARK: - Helpers

    private func minutesDifference(from start: Date, to end: Date) -> Int {
        let cal = Calendar.current
        let s = cal.dateComponents([.hour, .minute], from: start)
        let e = cal.dateComponents([.hour, .minute], from: end)
        let startMin = (s.hour ?? 0) * 60 + (s.minute ?? 0)
        let endMin   = (e.hour ?? 0) * 60 + (e.minute ?? 0)
        return endMin - startMin
    }
}
