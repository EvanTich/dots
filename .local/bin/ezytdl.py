#!/bin/env python
import sys
from io import BytesIO
from os.path import exists as file_exists, expanduser
from PIL import Image
import requests
import yt_dlp
from mutagen.mp4 import MP4, MP4Cover

DEFAULT_ARCHIVE = expanduser('~/Music/archive.txt')

MUSIC_OPTIONS = {
    'noplaylist': True,
    'windowsfilenames': True,
    'outtmpl': '%(artist)s - %(title)s.%(ext)s',
    'format': 'bestaudio[ext=m4a]',
    'ignoreerrors': True,
    'abort_on_unavailable_fragments': True,
    #  'break_on_existing': True,
    'break_per_url': True,
    'retries': 10,
    'retry_sleep_functions': {
        'http': lambda attempt: attempt * 2
    },
    'continuedl': True,
    'postprocessors': [{
        'key': 'FFmpegMetadata'
    }]
}

def get_image(url: str) -> Image.Image:
    return Image.open(requests.get(url, stream=True).raw, formats=['WEBP', 'JPEG', 'PNG'])

def center_image(img: Image.Image, width, height) -> Image.Image:
    left = int(img.size[0] / 2 - width / 2)
    upper = int(img.size[1] / 2 - height / 2)
    right = left + width
    lower = upper + height
    return img.crop((left, upper, right, lower))

def set_cover(file: MP4, img: Image.Image):
    with BytesIO() as img_bytes:
        img.save(img_bytes, format='PNG')
        file['covr'] = [
            MP4Cover(img_bytes.getvalue(), imageformat=MP4Cover.FORMAT_PNG)
        ]

class EzYTDLPP(yt_dlp.postprocessor.PostProcessor):

    def __init__(self, thumbnail=True, numbering=False, initial_number=1):
        super().__init__(None)
        self.thumbnail = thumbnail
        self.numbering = numbering
        self.number = initial_number

    def run(self, info):
        filepath = info['filepath']
        file = MP4(filepath)

        if self.thumbnail:
            self.to_screen('adding thumbnail')
            thumbnail_url = info['thumbnail']
            img = get_image(thumbnail_url)
            img = center_image(img, 720, 720)
            set_cover(file, img)

        if self.numbering:
            self.to_screen('adding track number')
            file['trkn'] = self.number
            self.number += 1

        file.save()

        return [], info

def download(urls, thumbnail=True, archive=DEFAULT_ARCHIVE, numbering=False):
    if not urls:
        return

    options = { **MUSIC_OPTIONS }
    if archive:
        options['download_archive'] = archive

    with yt_dlp.YoutubeDL(options) as ydl:
        ydl.add_post_processor(EzYTDLPP(thumbnail, numbering))
        ydl.download(urls)

def help():
    prog = sys.argv[0] or 'ez-ytdl'
    print('Usage:', prog, '[--thumbnails | --no-thumbnails] [--tracknums | --no-tracknums] [--archive archive_file | --no-archive] urls...')

def main():
    thumbnail = True
    numbering = False
    archive = DEFAULT_ARCHIVE

    possible_args = [
        '--help',
        '--thumbnails', '--no-thumbnails',
        '--tracknums', '--no-tracknums',
        '--archive', '--no-archive'
    ]

    urls = []

    size = len(sys.argv)
    skip_next = False
    for i in range(1, size):
        if skip_next:
            skip_next = False
            continue

        arg = sys.argv[i]
        next_arg = None if i + 1 >= size else sys.argv[i + 1]

        match arg:
            case '--help':
                help()
                return
            case '--thumbnails': thumbnail = True
            case '--no-thumbnails': thumbnail = False
            case '--tracknums': numbering = True
            case '--no-tracknums': numbering = False
            case '--archive':
                if next_arg:
                    if file_exists(next_arg):
                        archive = next_arg
                    else:
                        print('File doesn\'t exist')
                        continue
                else:
                    archive = DEFAULT_ARCHIVE
                skip_next = True
            case '--no-archive': archive = None
            case _:
                urls.append(arg)
                if not next_arg or next_arg in possible_args:
                    download(urls, thumbnail, archive, numbering)
                    urls = []

if __name__ == '__main__':
    main()
