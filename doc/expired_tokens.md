# Handling Expired Tokens

When a deployment token expires, the system will typically return a `401 – Bad Credentials` error during the deploy process. This indicates that authentication has failed and the token is no longer valid.

To restore functionality, a new token must be generated.

## Token Ownership
All deployment tokens should be created under the `lpm-automaton` user.  

This ensures that:
- Deployments are consistently attributed in logs  
- Audit trails remain clean and traceable  

## Creating a New Token
Follow these steps to generate a replacement token:

1. Navigate to:
   `Settings → Developer Settings → Personal Access Tokens → Tokens (classic)`
2. Click **"Generate new token"**
3. Assign the required scopes:
   - `repo`
   - `workflow`
4. Save and securely store the generated token

## Expiration Policy
- Tokens should be configured with an expiration date
- The maximum allowed duration is **1 year**
