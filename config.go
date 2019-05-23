package main

import (
	"strings"
	"time"
)

type arrayFlags []string

type flags struct {
	Kubeconfig         string
	ResyncPeriodS      string
	ResyncPeriod       time.Duration
	StatusAddr         string
	AllowAll           bool
	CopyFreeNamespaces arrayFlags
}

func (i *arrayFlags) String() string {
	return strings.Join(*i, ",")
}

func (i *arrayFlags) Set(value string) error {
	*i = append(*i, value)
	return nil
}
