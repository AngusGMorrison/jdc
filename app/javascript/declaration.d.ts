// Allow ts/tsx components to import sass files.
declare module '*.sass' {
  const styles: Record<string, string>
  export default styles
}
