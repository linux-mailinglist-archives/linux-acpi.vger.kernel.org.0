Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61FE3483
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393690AbfJXNmW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 09:42:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389598AbfJXNmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 09:42:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so20614251oib.12;
        Thu, 24 Oct 2019 06:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v65XPmSdUFz0UF1/zSSxF9xHx4d8boMDUd5sPcsrtTM=;
        b=jq2e11mWxEKjHzMIMBF8msiMPeh3H22H7ciTPWsXCuiGN3Bk1l0ms1ll5X5sT6t3vf
         0MzSSTaH6bP+SqDfXQeU3cr2vXnY5Flud6gSxCQ2i+tYKP/vgmPul61J1n/7gAxnTw6o
         4Zh4j447X49NHpuNVyFfkW0G3+rYBT8Mve+jZyNs3gUvcU6BZfPHv+ttKQVil43iFQcl
         5HJ2VQvJPq5/pEWcumpXuXt3DYpIRBUY80GhMj0Zfl0PVmGyY8slRT6WCIM+E+4N5qqJ
         W/3E6+i7V7GdlsQWHgLgj5Soq/CsXPRESsxcGdUD/pzTsx3bGZ8nhEjoYqGikAQ3vX2A
         Ay0w==
X-Gm-Message-State: APjAAAXNy04mMaXMIb5ZwH09omNbazfuoaOmykttP4TzvPFx9Pt7w0e+
        FxaMrha/sPPusXwLAABH63b+t/1skHIz3iCQzsg=
X-Google-Smtp-Source: APXvYqzd4wT1azyXt+q32xSzopKpw/cc4FtOrJDZxZYX0NqyfkMvvUQAkyNWcy3oJLJ58d1cIF8rWJVNSF4luMyQUtQ=
X-Received: by 2002:aca:b6c5:: with SMTP id g188mr4807663oif.103.1571924540858;
 Thu, 24 Oct 2019 06:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
 <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com> <AM7PR04MB7015D5B0C6952BF6B04C140CEE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7015D5B0C6952BF6B04C140CEE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Oct 2019 15:42:09 +0200
Message-ID: <CAJZ5v0iY4QScdQJW4xzJEMcfxkB2QDjBkR2oo3zBRL7x70PmnQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2019 at 3:33 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 2019-10-23 11:54 AM, Rafael J. Wysocki wrote:
> > On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >> On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:

[cut]

> >>> But combining the lists of requests for all the CPUs in a policy
> >>> defeats the idea of automatic aggregation of requests which really is
> >>> what PM QoS is about.
> >>
> >> My primary interest is the "dev" part of dev_pm_qos: making pm_qos
> >> requests tied to a specific device.
> >
> > The list of requests needs to be associated with the user of the
> > effective constraint.  If that is the device, it is all good.
>
> The phrase "user of the effective constraint" is somewhat unclear.

Fair enough, so let me elaborate.

The effective constraint (ie. the one resulting from taking all of the
requests in the relevant QoS list into account) affects the selection
of an OPP, so it is natural to associate the QoS list producing it
with a list of OPPs to select.  In the cpufreq case, the policy holds
the list of OPPs and so it also should hold the corresponding QoS
lists (for the min and max frequency limits).  It "uses" the effective
constraints produced by those QoS lists by preventing the OPPs out of
the between the min and max values  from being selected.

Essentially, the policy represents a power (clock/voltage) domain with
multiple components (it doesn't matter what they are at this level of
abstraction). While there can be multiple sources of QoS requests
associated with each component, all of these requests ultimately need
to be passed to the domain for aggregation, because that's where the
frequency selection decisions are made and so that's where the
effective constraint value needs to be known. Now, the natural way to
allow requests from multiple sources to be passed for aggregation is
to provide a QoS list that they can be added to. That really is what
PM QoS is for.

> I'm using the target device as dev for dev_pm_qos, not the requestor.
> This is consistent with how it was used for cpufreq: thermal called a
> dev_pm_qos_add_request on with dev = cpu_dev not a thermal sensor or
> anything else.

Not really, but close. :-)

Without my series (that is 5.4-rc4, say), the cpu_cooling driver adds
its constraint to the device PM QoS of cpufreq_cdev which is a special
device created by that driver.  That would be fine, except that the
cpufreq core doesn't use that QoS.  It uses the device PM QoS of the
policy->cpu device instead.  That is, that's where it adds its
notifiers (see cpufreq_policy_alloc()), that's where user space
requests are added (see cpufreq_online()), and (most important) that's
where the effective constraint value is read from (see
cpufreq_set_policy()).  That turns out to be problematic (in addition
to the cpu_cooling driver's QoS requests going nowhere), because
confusion ensues if the current policy->cpu goes away.

> However looking at other dev_pm_qos users there are instances of a
> driver calling dev_pm_qos_add_request on it's own device but this is not
> a strict requirement, correct?

No, it isn't.

> >>> There have to be two lists of requests per policy, one for the max and
> >>> one for the min frequency >
> >>>> If cpufreq needs a group of CPUs to run at the same frequency then it
> >>>> should deal with this by doing dev_pm_qos_read_frequency on each CPU
> >>>> device and picking a frequency that attempts to satisfy all constraints.
> >>>
> >>> No, that would be combining the requests by hand.
> >>
> >> It's just a loop though.
> >
> > Yes, it is, and needs to be run on every change of an effective
> > constraint for any CPU even if the total effective constraint doesn't
> > change.  And, of course, the per-policy user space limits would need
> > to be combined with that by hand.
> >
> > Not particularly straightforward if you asked me.
>
> Well, this cpu-to-policy aggregation could also use a pm_qos_constraint
> object instead of looping.

Yes, it could, but then somebody would need to add those
"intermediate" requests to a proper policy-level QoS and it would need
an extra notifier invocation to update each of them on a "component"
QoS change.

This is an interesting idea in case we ever need to improve the
scalability of the QoS lists, but I'd rather use the simpler approach
for now.

[cut]

> >>> Well, the cpufreq sysfs is per-policy and not per-CPU and we really
> >>> need a per-policy min and max frequency in cpufreq, for governors etc.
> >>
> >> Aggregation could be performed at two levels:
> >>
> >> 1) Per cpu device (by dev_pm_qos)
> >> 2) Per policy (inside cpufreq)
> >>
> >> The per-cpu dev_pm_qos notifier would just update a per-policy
> >> pm_qos_constraints object. The second step could even be done strictly
> >> inside the cpufreq core using existing pm_qos, no need to invent new
> >> frameworks.
> >>
> >> Maybe dev_pm_qos is not a very good fit for cpufreq because of these
> >> "cpu device versus cpufreq_policy" issues but it makes a ton of sense
> >> for devfreq. Can you maybe hold PATCH 3 from this series pending further
> >> discussion?
> >
> > It can be reverted at any time if need be and in 5.4 that would be dead code.
>
> I guess I can post v10 of my "devfreq pm qos" which starts by reverting
> "PATCH 3" of this series?

You may do that, but I would consider adding a struct freq_constraints
pointer directly to struct dev_pm_info and using the new frequency QoS
helpers to manage it.

Arguably, there is no need to bundle that with the rest of device PM
QoS and doing the above would help to avoid some code duplication too.

Thanks!
