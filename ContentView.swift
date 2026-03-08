import SwiftUI

struct ContentView: View {
    @State private var model = CalculatorModel()

    var body: some View {
        @Bindable var bindable = model

        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    TimePickerCard(title: "시작 시간", time: $bindable.startTime)
                    TimePickerCard(title: "종료 시간", time: $bindable.endTime)

                    ServiceTimeCard(
                        minutes: model.serviceMinutes,
                        onDecrement: model.decrementService,
                        onIncrement: model.incrementService
                    )

                    CalculateButton(action: model.calculate)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
            .navigationTitle("휴식시간 편성")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $bindable.showResult) {
                if let result = model.result {
                    ResultView(result: result)
                }
            }
            .alert(
                "입력 오류",
                isPresented: $bindable.showError,
                actions: {
                    Button("확인", role: .cancel) {}
                },
                message: {
                    Text(model.calculationError?.errorDescription ?? "알 수 없는 오류")
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
