extension Cookie: CustomStringConvertible {
    public var description: String {
        var string = "\(name)=\(value)"

        if let expires = expires {
            string += "; Expires=\(expires)"
        }

        if let maxAge = maxAge {
            string += "; Max-Age=\(maxAge)"
        }

        if let domain = domain {
            string += "; Domain=\(domain)"
        }

        if let path = path {
            string += "; Path=\(path)"
        }

        if secure {
            string += "; Secure"
        }

        if HTTPOnly {
            string += "; HttpOnly"
        }

        return string
    }
}
