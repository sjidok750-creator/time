import SwiftUI

/// 비례 색상 막대 + 4개 시각 레이블
struct ScheduleTimelineView: View {
    let result: ScheduleResult

    private var teamAFraction: CGFloat {
        CGFloat(result.teamAMinutes) / CGFloat(result.totalMinutes)
    }
    private var serviceFraction: CGFloat {
        CGFloat(result.serviceMinutes) / CGFloat(result.totalMinutes)
    }
    private var teamBFraction: CGFloat {
        CGFloat(result.teamBMinutes) / CGFloat(result.totalMinutes)
    }

    var body: some View {
        VStack(spacing: 8) {
            // Proportional color bar
            GeometryReader { geo in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.teamA)
                        .frame(width: geo.size.width * teamAFraction)

                    Rectangle()
                        .fill(Color.serviceOrange)
                        .frame(width: geo.size.width * serviceFraction)

                    Rectangle()
                        .fill(Color.teamB)
                        .frame(width: geo.size.width * teamBFraction)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(height: 56)

            // 4 time labels positioned at segment boundaries
            GeometryReader { geo in
                let w = geo.size.width
                let serviceStartX = w * teamAFraction
                let serviceEndX   = w * (teamAFraction + serviceFraction)

                ZStack(alignment: .topLeading) {
                    // Start — left edge
                    timeLabel(result.startTime)
                        .frame(maxWidth: w * 0.3, alignment: .leading)
                        .offset(x: 0)

                    // Service start — centred on boundary
                    timeLabel(result.serviceStartTime)
                        .frame(maxWidth: w * 0.3, alignment: .center)
                        .offset(x: max(0, serviceStartX - w * 0.15))

                    // Service end — centred on boundary
                    timeLabel(result.serviceEndTime)
                        .frame(maxWidth: w * 0.3, alignment: .center)
                        .offset(x: min(w - w * 0.3, serviceEndX - w * 0.15))

                    // End — right edge
                    timeLabel(result.endTime)
                        .frame(maxWidth: w * 0.3, alignment: .trailing)
                        .offset(x: w * 0.7)
                }
            }
            .frame(height: 18)
        }
    }

    private func timeLabel(_ date: Date) -> some View {
        Text(date.formatted(date: .omitted, time: .shortened))
            .font(.caption2)
            .foregroundStyle(.secondary)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
}
