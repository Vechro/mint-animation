enum Animation.Error {
  Unknown
  TypeError
  SyntaxError
  NotSupportedError
  InvalidStateError
  AbortError
  HierarchyRequestError
}

module Animation.Error {
  fun toString (error : Animation.Error) : String {
    case (error) {
      Animation.Error::Unknown => "Unknown error"
      Animation.Error::TypeError => "TypeError"
      Animation.Error::SyntaxError => "SyntaxError"
      Animation.Error::NotSupportedError => "NotSupportedError"
      Animation.Error::InvalidStateError => "InvalidStateError"
      Animation.Error::AbortError => "AbortError"
      Animation.Error::HierarchyRequestError => "HierarchyRequestError"
    }
  }
}
