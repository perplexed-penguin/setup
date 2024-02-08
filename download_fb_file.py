import argparse
import firebase_admin
from firebase_admin import credentials, storage


def download_file(bucket, destination_file_path, local_file_path):
    blob = bucket.blob(destination_file_path)
    blob.download_to_filename(local_file_path)
    print('File downloaded successfully')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Download a file from Firebase Storage.')
    parser.add_argument('credentials_path', help='Path to Firebase credentials')
    parser.add_argument('bucket_url', help='Firebase Storage bucket url to pull from')
    parser.add_argument('remote_file_path', help='Remote file path in Firebase Storage')
    parser.add_argument('local_file_path', help='Local file path')
    args = parser.parse_args()

    cred = credentials.Certificate(args.credentials_path)
    firebase_admin.initialize_app(cred, { 'storageBucket': args.bucket_url })
    bucket = storage.bucket()

    download_file(bucket, args.remote_file_path, args.local_file_path)
