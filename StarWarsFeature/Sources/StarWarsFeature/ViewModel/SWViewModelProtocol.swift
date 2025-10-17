@MainActor
protocol SWViewModelProtocol: AnyObject {
	associatedtype Action: Hashable
	
	var isLoading: Bool { get set }
	var error: SWError? { get set }
	var inFlightTasks: [Action: Task<Void, Never>] { get set }
	
	func withTask(
		for action: Action,
		showLoading: Bool,
		operation: @escaping () async throws -> Void
	) async
}

extension SWViewModelProtocol {
	func withTask(
		for action: Action,
		showLoading: Bool = false,
		operation: @escaping () async throws -> Void
	) async {
		error = nil

		if let existingTask = inFlightTasks[action] {
			existingTask.cancel()
			inFlightTasks.removeValue(forKey: action)
		}
		
		let task = Task { [weak self] in
			guard let self = self else { return }
			
			do {
				if showLoading {
					self.isLoading = true
				}
				
				try await operation()
				
				guard !Task.isCancelled else {
					return
				}
				
				self.isLoading = false
				
			} catch {
				guard !Task.isCancelled else {
					return
				}
				
				self.error = SWError.message(error.localizedDescription)
				self.isLoading = false
			}
		}
		
		inFlightTasks[action] = task
		// Wait for task completion and then remove from dictionary
		await task.value
		inFlightTasks.removeValue(forKey: action)
	}
}
