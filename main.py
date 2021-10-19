#!/usr/bin/env python
import os

from prometheus_client import CollectorRegistry, Counter, push_to_gateway


def main():
    gateway = os.getenv('PUSH_GATEWAY_URI', 'prometheus-pushgateway.prometheus')
    registry = CollectorRegistry()
    counter = Counter('example_counter_pushed_cronjob_processed_total', 'Total processed by the push gateway',
                      registry=registry)
    counter.inc(10)
    push_to_gateway(gateway, job='prometheus-counter-pushgateway-example', registry=registry)


if __name__ == '__main__':
    main()
