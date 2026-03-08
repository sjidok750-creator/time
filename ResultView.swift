import SwiftUI

// MARK: - ScheduleCard

struct ScheduleCard: View {
    let title: String
    let startTime: Date
    let endTime: Date
    let minutes: Int
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.bold())
                .foregroundStyle(color)

            Text(timeRange)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundStyle(.primary)

            Text("\(minutes)분")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.12))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.35), lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var timeRange: String {
        let fmt = Date.FormatStyle(date: .omitted, time: .shortened)
        return "\(startTime.formatted(fmt)) ~ \(endTime.formatted(fmt))"
    }
}

// MARK: - TotalSummaryRow

struct TotalSummaryRow: View {
    let totalMinutes: Int
    let serviceMinutes: Int

    var body: some View {
        HStack {
            Label("전체 시간", systemImage: "clock")
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(totalMinutes)분  (서비스 \(serviceMinutes)분)")
                .font(.subheadline.bold())
        }
        .padding(16)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - ResultView

struct ResultView: View {
    let result: ScheduleResult

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ScheduleTimelineView(result: result)
                    .padding(.horizontal, 4)
                    .padding(.top, 4)

                ScheduleCard(
                    title: "A조 휴식",
                    startTime: result.startTime,
                    endTime: result.serviceStartTime,
                    minutes: result.teamAMinutes,
                    color: .teamA
                )

                ScheduleCard(
                    title: "서비스",
                    startTime: result.serviceStartTime,
                    endTime: result.serviceEndTime,
                    minutes: result.serviceMinutes,
                    color: .serviceOrange
                )

                ScheduleCard(
                    title: "B조 휴식",
                    startTime: result.serviceEndTime,
                    endTime: result.endTime,
                    minutes: result.teamBMinutes,
                    color: .teamB
                )

                TotalSummaryRow(
                    totalMinutes: result.totalMinutes,
                    serviceMinutes: result.serviceMinutes
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("편성 결과")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Previews

#Preview("Result") {
    let cal = Calendar.current
    let now = Date()
    let start     = cal.date(bySettingHour: 10, minute:  0, second: 0, of: now)!
    let svcStart  = cal.date(bySettingHour: 10, minute: 30, second: 0, of: now)!
    let svcEnd    = cal.date(bySettingHour: 11, minute:  0, second: 0, of: now)!
    let end       = cal.date(bySettingHour: 12, minute:  1, second: 0, of: now)!

    let result = ScheduleResult(
        startTime: start,
        endTime: end,
        serviceStartTime: svcStart,
        serviceEndTime: svcEnd,
        totalMinutes: 121,
        serviceMinutes: 60,
        teamAMinutes: 30,
        teamBMinutes: 31
    )

    NavigationStack {
        ResultView(result: result)
    }
}
