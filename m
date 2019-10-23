Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7339E14CB
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfJWIyo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 04:54:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45181 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390348AbfJWIyo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 04:54:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so16678874oib.12;
        Wed, 23 Oct 2019 01:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/tYMdvknt4Y45qXikSRBwej7y1KwwcBMADpz4Xm+Go=;
        b=C6UZClynQ/HN2DGGUh7euNW/2al2w/i2b1WtfANPs+t1oAMzTWuxCVrSHd8+IhtTP3
         WTea2j9KSndANdt7cxy4TPrcDbWElXQprG6jqnv5+3gEof56Y1IJQ2pMW+ORlCsT8Pzq
         CQeZyTRB7ws0/VAH0twFh8RlQ3zpRxyw7iAAIo6J4hk4bHOyEYK/CHSAxHj7Won1HgL/
         iaT1jOu1jKgiKLwgb0+9BmIm3r8INDM+u+HERfKMcrDkM/gzVaRPFbgucplhy/TDfJbq
         EYfxyA3hipDyja6jSF0chPOBqbpYQY5W+AS/iuBAP9uN8X6Xg0mEHqEjF7M+mikKnslO
         NIAg==
X-Gm-Message-State: APjAAAVbL6unGW903X3wBIyXiyHz6GC/LY39o0wDGstNxYC70bN1Wv9l
        jxIea7QJIaEelPTzUSCF9TJsYc6K6+df6TfRUO8=
X-Google-Smtp-Source: APXvYqybflU7DWe+aDpt9KxzvaDxipKdXHCdTIZtzL+dBmDd6MHS4G0Vc4XexUXKpw/cUNXWkGIsJWz9bjslk2tCWok=
X-Received: by 2002:aca:d405:: with SMTP id l5mr6308661oig.115.1571820882347;
 Wed, 23 Oct 2019 01:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com> <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 10:54:31 +0200
Message-ID: <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
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

On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:
> > On Wed, Oct 23, 2019 at 12:06 AM Leonard Crestez
> > <leonard.crestez@nxp.com> wrote:
> >> I've been working on a series which add DEV_PM_QOS support to devfreq,
> >> now at v9:
> >>
> >> Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series
> >> depends upon. I found the email on patchwork, hopefully the in-reply-to
> >> header is OK?
> >>
> >> As far as I can tell the replacement ("frequency qos") needs constraints
> >> to be managed outside the device infrastructure and it's not obviously
> >> usable a generic mechanism for making "min_freq/max_freq" requests to a
> >> specific device.
> >
> > You can add a struct freq_constrants pointer to struct dev_pm_info and
> > use it just fine.  It doesn't have to be bolted into struct
> > dev_pm_qos.
>
> I'm not sure what you mean by this? min/max_freq was already available
> in dev_pm_qos so it's not clear why it would be moved somewhere else.
> What I'm looking for is a mechanism to make min/max_freq requests on a
> per-device basis and DEV_PM_QOS_MIN_FREQUENCY already did that.
>
> Reuse is good, right?

But they go away in patch 3 of this series as there are no users in
the tree.  Sorry about that.

> >> I've read a bit through your emails and it seems the problem is that
> >> you're dealing with dev_pm_qos on per-policy basis but each "struct
> >> cpufreq_policy" can cover multiple CPU devices.
> >>
> >> An alternative solution which follows dev_pm_qos would be to add
> >> notifiers for each CPU inside cpufreq_online and cpufreq_offline. This
> >> makes quite a bit of sense because each CPU is a separate "device" with
> >> a possibly distinct list of qos requests.
> >
> > But combining the lists of requests for all the CPUs in a policy
> > defeats the idea of automatic aggregation of requests which really is
> > what PM QoS is about.
>
> My primary interest is the "dev" part of dev_pm_qos: making pm_qos
> requests tied to a specific device.

The list of requests needs to be associated with the user of the
effective constraint.  If that is the device, it is all good.

> > There have to be two lists of requests per policy, one for the max and
> > one for the min frequency >
> >> If cpufreq needs a group of CPUs to run at the same frequency then it
> >> should deal with this by doing dev_pm_qos_read_frequency on each CPU
> >> device and picking a frequency that attempts to satisfy all constraints.
> >
> > No, that would be combining the requests by hand.
>
> It's just a loop though.

Yes, it is, and needs to be run on every change of an effective
constraint for any CPU even if the total effective constraint doesn't
change.  And, of course, the per-policy user space limits would need
to be combined with that by hand.

Not particularly straightforward if you asked me.

Not to mention the fact that, say, cpu_cooling, has a per-policy list
of requests anyway.

> >> Handling sysfs min/max_freq through dev_pm_qos would be of dubious
> >> value, though I guess you could register identical requests for each CPU.
> >>
> >> I'm not familiar with what you're trying to accomplish with PM_QOS other
> >> than replace the sysfs min_freq/max_freq files:
> >
> > QoS-based management of the frequency limits is not really needed for
> > that.  The real motivation for adding it were things like thermal and
> > platform firmware induced limits that all have their own values to
> > combine with the ones provided by user space.
>
> Current users seem to be thermal-related. Do you care about min/max_freq
> requests from stuff not directly tied to a CPU?

Yes, I do.

And they will need to add requests per policy.

> >> What I want to do is add
> >> a driver using the interconnect driver which translates requests for
> >> "bandwidth-on-a-path" into "frequency-on-a-device". More specifically a
> >> display driver could request bandwidth to RAM and this would be
> >> translated into min frequency for NoC and the DDR controller, both of
> >> which implement scaling via devfreq:
> >>
> >> This is part of an effort to upstream an out-of-tree "busfreq" feature
> >> which allows device device to make "min frequency requests" through an
> >> entirely out-of-tree mechanism. It would also allow finer-grained
> >> scaling that what IMX tree currently support.
> >>
> >> If you're making cpufreq qos constrains be "per-cpufreq-policy" then
> >> it's not clear how you would handle in-kernel constraints from other
> >> subsystems. Would users have to get a pointer to struct cpufreq_policy
> >> and struct freq_constraints?
> >
> > Yes.
> >
> >> That would make object lifetime a nightmare!
> >
> > Why really?  It is not much different from the device PM QoS case
>  >> Actually,  is a simple
> > one-for-one replacement of the former.  As it turns out, all of its
> > users have access to a policy object anyway already.
>
> All current users are very closely tied to cpufreq, what I had in mind
> is requests from unrelated subsystems.

You can use cpufreq policy notifiers for that.  Add a request for each
CPU in the policy (or for each related CPU if that is needed) to
policy->constraints on CREATE_POLICY and remove them on REMOVE_POLICY.
That's all you need to do.

BTW, the original code from Viresh did that already, I haven't changed
it.  And it didn't have per-CPU lists of frequency requests for that
matter, it used the ones in policy->cpu as the per-policy lists, which
doesn't work.

> Browsing through the cpufreq core it seems that it's possible for a
> struct cpufreq_policy to be created and destroyed at various points, the
> simplest example being rmmod/modprobe on a cpufreq driver.
>
> The freq_qos_add_request function grabs a pointer to struct
> freq_constraints, this can become invalid when cpufreq_policy is freed.
>
> I guess all users need to register a CPUFREQ_POLICY_NOTIFIER and make
> sure to freq_qos_add_request every time?

Yes.

The policy is the user of the effective constraint anyway and holding
on to a list of requests without a user of the effective constraint
would be, well, not useful.

> Looking at your [PATCH 2/3] I  can't spot any obvious issue, thermal clamping
> code seems to get the appropriate callbacks.
>
> >> But dev_pm_qos solves this by tying to struct device.
>
> The lifetime of "struct device" is already controlled by
> get_device/put_device.

And why does this matter here?

> > Well, the cpufreq sysfs is per-policy and not per-CPU and we really
> > need a per-policy min and max frequency in cpufreq, for governors etc.
>
> Aggregation could be performed at two levels:
>
> 1) Per cpu device (by dev_pm_qos)
> 2) Per policy (inside cpufreq)
>
> The per-cpu dev_pm_qos notifier would just update a per-policy
> pm_qos_constraints object. The second step could even be done strictly
> inside the cpufreq core using existing pm_qos, no need to invent new
> frameworks.
>
> Maybe dev_pm_qos is not a very good fit for cpufreq because of these
> "cpu device versus cpufreq_policy" issues but it makes a ton of sense
> for devfreq. Can you maybe hold PATCH 3 from this series pending further
> discussion?

It can be reverted at any time if need be and in 5.4 that would be dead code.
