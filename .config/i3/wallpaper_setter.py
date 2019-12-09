#!/usr/bin/env python3

'''
Sets Wallpaper for home or work use according in which mode i3 started
'''

from subprocess import Popen, PIPE
import argparse
from os.path import expanduser, join

images = {
    'home': 'naruto_kurama.jpg',
    'work': 'black_rock.jpg'
}


def main(mode):
    home = expanduser('~')
    wp = 'wallpapers'
    image = images.get(mode.lower(), 'black_rock.jpg')
    wp_path = join(home, wp, image)

    Popen(
        ['feh', '--bg-scale', wp_path],
        stdin=PIPE, stdout=PIPE, stderr=PIPE
    )


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-m',
                        '--mode',
                        action='store',
                        dest='mode',
                        default='',
                        help='Which mode to use (home/work)')
    result = parser.parse_args()

    main(result.mode)
