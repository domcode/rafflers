import sys
import random


def coroutine(fn):
    def decorator(*args, **kwargs):
        gen = fn(*args, **kwargs)
        gen.send(None)
        return gen
    return decorator


def generator(fn):
    def decorator(*args, **kwargs):
        gen = fn(*args, **kwargs)
        return lambda: next(gen)
    return decorator


@generator
def lototron(choices):
    while True:
        yield random.choice(choices)


@coroutine
def yield_winner(candidates):
    winner = ''
    bingo = False
    while not bingo:
        choice = yield
        maybe_winner = winner + choice
        for candidate in candidates:
            if candidate.startswith(maybe_winner):
                winner = maybe_winner
                if candidate == winner:
                    bingo = True
    yield winner


def raffle(choices, candidates):
    winner = None
    lottery_machine = lototron(choices)
    winner_generator = yield_winner(candidates)
    while not winner:
        winner = winner_generator.send(lottery_machine())
    return winner


def load_data(filepath):
    with open(filepath, 'r') as f:
        data = f.read().strip()
    choices = list(data.replace('\n', ''))
    candidates = data.split('\n')
    return choices, candidates


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: {0} <file>'.format(sys.argv[0]))
        sys.exit(1)
    winner = raffle(*load_data(sys.argv[1]))
    print('And the winner is ... {0}'.format(winner))
