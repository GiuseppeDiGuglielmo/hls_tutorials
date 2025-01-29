import argparse
import numpy as np
import logging

def print_data(data, title):
    logging.info(title)
    # Determine the maximum width of the numbers in the data for formatting
    max_width = max(len(str(item)) for row in data for item in row)
    for row in data:
        # Print each row with right-aligned elements
        logging.info(" ".join(f"{item:>{max_width}}" for item in row))

def compare(data1, data2):
    if np.array_equal(data1, data2):
        logging.info("Outputs match!")
        return 0
    else:
        logging.info("Outputs does NOT match!")
        return 1

def initialize_image(height, width, random_init, seed):
    if random_init:
        np.random.seed(seed)
        return np.random.randint(0, 256, (height, width))  # Initialize with random values from 0-255
    else:
        return np.array([[x + y * width for x in range(1, width+1)] for y in range(height)])

def horizontal_derivative(dat_in, dx, image_height, image_width, kernel):
    # Initialize pixel buffers
    pix_buf0 = 0
    pix_buf1 = 0
 
    pix0 = 0
    pix1 = 0
    pix2 = 0
         
    # Iteration over each row
    for y in range(image_height):

        logging.debug(f"row # {y} ========================================")

        # Iteration over each column plus one for boundary conditions
        for x in range(image_width + 1):

            logging.debug(f"col # {x} --------------")

            # Shift the pixel buffers
            pix2 = pix_buf1
            pix1 = pix_buf0
            
            # Fetch new pixel data if within bounds
            if x < image_width:
                pix0 = dat_in[y][x]

            # Handle left boundary condition
            if x <= 1:
                pix2 = pix1  # replicate pix1 to the left into pix2
            
            # Handle right boundary condition
            if x >= image_width:
                pix0 = pix1  # replicate pix1 to the right into pix0
              
            # Calculate and store derivative when possible
            if x > 0:
                logging.debug(f"{pix2} {pix1} {pix0}")
                dx[y][x-1] = pix2 * kernel[0] + pix1 * kernel[1] + pix0 * kernel[2]

            # Update pixel buffers for next iteration
            pix_buf1 = pix_buf0
            pix_buf0 = pix0

def main(image_height, image_width, kernel, random_init, seed):
    # Return value
    rv = 0

    # Initialize image data and output derivative array
    dat_in = initialize_image(image_height, image_width, random_init, seed)
    dx = [[0] * image_width for _ in range(image_height)]

    # Compute the horizontal derivative
    horizontal_derivative(dat_in, dx, image_height, image_width, kernel)

    # Print the results
    print_data(dat_in, "Input Image:")
    print_data(dx, "Output Horizontal Derivatives:")

    return rv

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Compute horizontal derivative of an image.')
    parser.add_argument('height', type=int, help='Height of the image')
    parser.add_argument('width', type=int, help='Width of the image')
    parser.add_argument('--kernel', type=int, nargs=3, default=[-1, 0, 1], help='Derivative kernel as three integers')
    parser.add_argument('--random', action='store_true', help='Initialize the image with random pixel values')
    parser.add_argument('--seed', type=int, default=None, help='Use a random seed to generate pixel values')
    parser.add_argument('--verbose', action='store_true', default=False, help="Increase output verbosity")
    args = parser.parse_args()

    if args.verbose:
        logging.basicConfig(level=logging.DEBUG, format='%(message)s')
    else:
        logging.basicConfig(level=logging.INFO, format='%(message)s')

    if args.width < 3:
        logging.info("Error: Image width must be at least 3 pixels")
        exit(1)

    rv = main(args.height, args.width, args.kernel, args.random, args.seed)

    exit(rv)