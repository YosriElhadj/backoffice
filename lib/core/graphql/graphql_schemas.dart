class GraphQLQueries {
  // Authentication Queries
  static String loginMutation = r'''
    mutation Login($email: String!, $password: String!) {
      login(credentials: {
        email: $email,
        password: $password
      }) {
        accessToken
        refreshToken
        user {
          id
          email
          username
          role
        }
        requiresTwoFactor
      }
    }
  ''';

  // Properties Queries
  static String getPropertiesMutation = r'''
    query GetProperties {
      properties {
        id
        name
        location
        type
        status
        investmentAmount
      }
    }
  ''';

  // Users Queries
  static String getUsersMutation = r'''
    query GetUsers {
      users {
        id
        username
        email
        role
        status
      }
    }
  ''';
}