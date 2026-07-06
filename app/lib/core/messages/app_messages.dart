class AppMessages {
  AppMessages._();

  // General Messages
  static const String loading = 'Caricamento in corso.';
  static const String operationCompleted = 'Operazione completata correttamente.';
  static const String noResultsFound = 'Nessun risultato trovato.';

  // Authentication/Session Messages
  static const String loginSuccess = 'Accesso eseguito correttamente.';
  static const String logoutSuccess = 'Uscita eseguita correttamente.';
  static const String sessionExpired = 'Sessione scaduta. Accedi di nuovo.';
  static const String invalidCredentials = 'Email o password non corrette.';
  static const String invalidSession = 'Sessione non valida. Accedi di nuovo.';

  // Validation Messages
  static const String emailRequired = 'Email obbligatoria.';
  static const String passwordRequired = 'Password obbligatoria.';
  static const String nameRequired = 'Nome obbligatorio.';
  static const String companyNameRequired = 'Nome azienda obbligatorio.';
  static const String quantityRequired = 'Quantità obbligatoria.';
  static const String quantityMustBeGreaterThanZero = 'La quantità deve essere maggiore di zero.';

  // Success Messages
  static const String categorySaved = 'Categoria salvata correttamente.';
  static const String supplierSaved = 'Fornitore salvato correttamente.';
  static const String productSaved = 'Prodotto salvato correttamente.';
  static const String movementRecorded = 'Movimento registrato correttamente.';

  // Error Messages
  static const String genericError = 'Si è verificato un errore. Riprova.';
  static const String networkError = 'Connessione assente. Controlla Internet e riprova.';
  static const String unauthorized = 'Operazione non autorizzata.';
  static const String insufficientStock = 'Scorta insufficiente.';
  static const String productNotFound = 'Prodotto non trovato.';
  static const String invalidSupplier = 'Fornitore non valido.';
  static const String duplicateName = 'Esiste già un elemento con questo nome.';
  static const String duplicateBarcode = 'Esiste già un prodotto con questo barcode.';
  static const String productDeactivated = 'Il prodotto selezionato è disattivato.';
  static const String newStockCoincides = 'La nuova scorta coincide con quella attuale.';

  // Info/Status Messages
  static const String profileAlreadyCreated = 'Il profilo risulta già creato. Ricarico i dati.';

  // Warning Messages
  static const String stockBelowMinimum = 'Attenzione: scorta inferiore al livello minimo.';

  // Auth/Session Block 002 Messages
  static const String checkingSession = 'Controllo sessione in corso.';
  static const String login = 'Login';
  static const String signIn = 'Accedi';
  static const String signOut = 'Esci';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String profileNotCreatedYet = 'Profilo non ancora creato.';
  static const String onboardingWillBeImplemented = 'Il flusso onboarding sarà implementato nel blocco successivo.';
  static const String loginCompleted = 'Accesso completato.';
  static const String homeWillBeImplemented = 'La home sarà implementata nel blocco 004.';
  static const String retry = 'Riprova';
  static const String retryCheckingSession = 'Riprova controllo sessione';
  static const String retryLoadingProfile = 'Riprova caricamento profilo';
}
