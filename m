Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70624E456D
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407814AbfJYIRt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:17:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45612 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405453AbfJYIRt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:17:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so969670oib.12;
        Fri, 25 Oct 2019 01:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfnbCnGC7bfHOPS0ndKHFbRPzpZx17Z/G8hlBOm+gDw=;
        b=SzKm8X5kDdzGk2IaVp/Lq25RtzTxxFCl+gs9SXSCVtLukCzgCp3ep9o9wG7PljhWSX
         RQCEfRoMjfXh7O3qEUdHXhQqbafpO3KRRzzgsuHuTsKqm+iLwaPyCI/3oIwxBnaZOAHR
         a2THVIJxco3+nc7wvhIoPnT/42OK7KbOvFYdModD3xuUnahgdEhWZN2/yLlpT/RWQ0hW
         FJmdxw4emPDFBVRdYFoKmZJyzPj87tyZ9huR2es8Int8WqOQe7yd3yWnR6Q1C6JmROr7
         MvydLZOiQfdp87dKPfN7j/dRFKF+rJaAMHaLPNxC1rZ6VQgQ6e2woNkMa0jJ4g1PGBR7
         i8Hg==
X-Gm-Message-State: APjAAAUQ8qISP2O49SbC0DGgDNdnqr48ZWZrORro+pfrEWZ712BOToiX
        nzNxjM1TZaopwRTecAlxGaRvkPeecs5b71EMKHiA6ROx
X-Google-Smtp-Source: APXvYqy8cLx1sSZoK5TmfzZ9Fq2zyzJe1nqJrBJBeOYFMnzoCQUbQKbV2BtvN5+jfRQs36i5xBnTlOAQNSQe/C70Bo8=
X-Received: by 2002:aca:5885:: with SMTP id m127mr1963800oib.110.1571991468336;
 Fri, 25 Oct 2019 01:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <2435090.1mJ0fSsrDY@kreacher> <20191025025343.tyihliza45os3e4r@vireshk-i7>
In-Reply-To: <20191025025343.tyihliza45os3e4r@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 10:17:37 +0200
Message-ID: <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 4:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The _PPC change notifications from the platform firmware are per-CPU,
> > so acpi_processor_ppc_init() needs to add a frequency QoS request
> > for each CPU covered by a cpufreq policy to take all of them into
> > account.
> >
> > Even though ACPI thermal control of CPUs sets frequency limits
> > per processor package, it also needs a frequency QoS request for each
> > CPU in a cpufreq policy in case some of them are taken offline and
> > the frequency limit needs to be set through the remaining online
> > ones (this is slightly excessive, because all CPUs covered by one
> > cpufreq policy will set the same frequency limit through their QoS
> > requests, but it is not incorrect).
> >
> > Modify the code in accordance with the above observations.
>
> I am not sure if I understood everything you just said, but I don't
> see how things can break with the current code we have.
>
> Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
> called from acpi_processor_notifier() which is registered as a policy
> notifier and is called when a policy is created or removed. Even if
> some CPUs of a policy go offline, it won't matter as the request for
> the policy stays and it will be dropped only when all the CPUs of a
> policy go offline.
>
> What am I missing ?

The way the request is used.

Say there are two CPUs, A and B, in the same policy.  A is
policy->cpu, so acpi_processor_ppc_init() adds a QoS request for A
only (note that the B's QoS request, B->perflib_req, remains
inactive).

Now, some time later, the platform firmware notifies the OS of a _PPC
change for B.  That means acpi_processor_notify() is called and it
calls acpi_processor_ppc_has_changed(B) and that invokes
acpi_processor_get_platform_limit(B), which in turn looks at the B's
QoS request (B->perflib_req) and sees that it is inactive, so 0 is
returned without doing anything.  However, *some* QoS request should
be updated then.

Would it be correct to update the A's QoS request in that case?  No,
because the _PPC limit for A may be different that the _PPC limit for
B in principle.

The thermal case is not completely analogous, because
cpufreq_set_cur_state() finds online CPUs in the same package as the
target one and tries to update the QoS request for each of them, which
will include the original policy->cpu, whose QoS request has been
registered by acpi_thermal_cpufreq_init(), as long as it is online.
If it is offline, it will be skipped and there is no easy way to find
a "previous policy->cpu".  It is possible to do that, but IMO it is
more straightforward to have a request for each CPU added.
