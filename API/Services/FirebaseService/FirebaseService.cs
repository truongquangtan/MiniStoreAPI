using Firebase.Storage;
using Firebase.Auth;

namespace BLL.Services
{
    public class FirebaseService
    {
        IConfiguration config;
        public  FirebaseService()
        {
            config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true)
                .Build();
        }
        public async Task<string> Upload(Stream fileStream, string fileName)
        {
            var firebaseAuthLink = await SignIn();
            var cancellation = new CancellationTokenSource();
            var task = new FirebaseStorage(
                    config["firebase:Bucket"],
                    new FirebaseStorageOptions()
                    {
                        AuthTokenAsyncFactory = () => Task.FromResult(firebaseAuthLink.FirebaseToken),
                        ThrowOnCancel = true
                    }
                ).Child(fileName)
                .PutAsync(fileStream);
            return await task;
        }
        public async void Delete
            (string fileName)
        {
            var firebaseAuthLink = await SignIn();
            var cancellation = new CancellationTokenSource();
            var task = new FirebaseStorage(
                    config["firebase:Bucket"],
                    new FirebaseStorageOptions()
                    {
                        AuthTokenAsyncFactory = () => Task.FromResult(firebaseAuthLink.FirebaseToken),
                        ThrowOnCancel = true
                    }
                ).Child(fileName)
                .DeleteAsync();
            await task;
        }

        private async Task<FirebaseAuthLink> SignIn()
        {
            var auth = new FirebaseAuthProvider(new FirebaseConfig(config["firebase:ApiKey"]));
            var a = await auth.SignInWithEmailAndPasswordAsync(config["firebase:auth:email"], config["firebase:auth:password"]);
            return a;
        }
    }
}
