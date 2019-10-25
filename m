Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18CE4616
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408480AbfJYIqi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:46:38 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39667 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfJYIqh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:46:37 -0400
Received: by mail-ot1-f53.google.com with SMTP id s22so1481502otr.6;
        Fri, 25 Oct 2019 01:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otxxqPgprKIYLEC3VNtxVjP3ezUj30jnhVcDZmes+Yo=;
        b=Nq0nY2DzEwJYkedwhV7kR4qwWW/wKTvb1DY8Vm/XAjU5v0/XupV1neSpS+iUUaiQkd
         CLapJ5yPYK9NnnCOcCSV6yFY2fvjhkN156Xys36FtY+mqErT5X8eEw8rTXcU5PY7Jwpg
         uCDnMz1D1Ru9jDnkm+LAvxpUUFrr1sjaqfsmCSvYyDRJlX3W0gyM8QQjl1SLiUzvut8J
         woGiny3Wqs1IB+5ttLv6AC+w9WhdnkZiwxv1KBcIgQ+wtFiR2RJkVISJd0OvvU94GMam
         0tPYqad5aAf9+P7F+RxN5YhcRZ4/tI0bgmbG6vVUNcczmdHY0hhwFKPHUy1I0nU76Nyf
         d2kQ==
X-Gm-Message-State: APjAAAUjCba0Nz4IfXqYo1JuwF05txFJGsQFlGXpShFJKBfmv0XHdwyg
        N0/q/QQKyjyg8G+4eIKTAp52nWHTkqMfA/C2Jyg=
X-Google-Smtp-Source: APXvYqxrZPK5Xbm7wOodsn5y/Q4/paFEf7kNviIbVLCjlal3rZGpiBuAgJQ5f2XRmFqIA/1p13DXVtXIBmWKDP/Tj44=
X-Received: by 2002:a9d:664:: with SMTP id 91mr1748665otn.189.1571993196583;
 Fri, 25 Oct 2019 01:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <2435090.1mJ0fSsrDY@kreacher> <20191025025343.tyihliza45os3e4r@vireshk-i7>
 <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 10:46:25 +0200
Message-ID: <CAJZ5v0hWN4-HCts+CoGm01kRHc05m9BxCA0CYfionJJBsHG7oA@mail.gmail.com>
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

On Fri, Oct 25, 2019 at 10:17 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 4:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _PPC change notifications from the platform firmware are per-CPU,
> > > so acpi_processor_ppc_init() needs to add a frequency QoS request
> > > for each CPU covered by a cpufreq policy to take all of them into
> > > account.
> > >
> > > Even though ACPI thermal control of CPUs sets frequency limits
> > > per processor package, it also needs a frequency QoS request for each
> > > CPU in a cpufreq policy in case some of them are taken offline and
> > > the frequency limit needs to be set through the remaining online
> > > ones (this is slightly excessive, because all CPUs covered by one
> > > cpufreq policy will set the same frequency limit through their QoS
> > > requests, but it is not incorrect).
> > >
> > > Modify the code in accordance with the above observations.
> >
> > I am not sure if I understood everything you just said, but I don't
> > see how things can break with the current code we have.
> >
> > Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
> > called from acpi_processor_notifier() which is registered as a policy
> > notifier and is called when a policy is created or removed. Even if
> > some CPUs of a policy go offline, it won't matter as the request for
> > the policy stays and it will be dropped only when all the CPUs of a
> > policy go offline.
> >
> > What am I missing ?
>
> The way the request is used.
>
> Say there are two CPUs, A and B, in the same policy.  A is
> policy->cpu, so acpi_processor_ppc_init() adds a QoS request for A
> only (note that the B's QoS request, B->perflib_req, remains
> inactive).
>
> Now, some time later, the platform firmware notifies the OS of a _PPC
> change for B.  That means acpi_processor_notify() is called and it
> calls acpi_processor_ppc_has_changed(B) and that invokes
> acpi_processor_get_platform_limit(B), which in turn looks at the B's
> QoS request (B->perflib_req) and sees that it is inactive, so 0 is
> returned without doing anything.  However, *some* QoS request should
> be updated then.
>
> Would it be correct to update the A's QoS request in that case?  No,
> because the _PPC limit for A may be different that the _PPC limit for
> B in principle.
>
> The thermal case is not completely analogous, because
> cpufreq_set_cur_state() finds online CPUs in the same package as the
> target one and tries to update the QoS request for each of them, which
> will include the original policy->cpu, whose QoS request has been
> registered by acpi_thermal_cpufreq_init(), as long as it is online.
> If it is offline, it will be skipped and there is no easy way to find
> a "previous policy->cpu".  It is possible to do that, but IMO it is
> more straightforward to have a request for each CPU added.

BTW, IMO processor_thremal can be changed to use one frequency QoS
request per policy on top of this, but I'd rather take one step at a
time. :-)
