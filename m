Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D08E0E5D
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfJVWsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Oct 2019 18:48:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45582 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbfJVWsJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2019 18:48:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so15654533oib.12;
        Tue, 22 Oct 2019 15:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9L4/DISQ1pi09uDSEWmyigMpSQdCoEyqU+nuf3ilsk=;
        b=N5YvAF/E7rffyB7YYjcg/EDfGyF5vYYXwwBN5g0UXQQppXWAlLjDaYqZ0EYmaLNM+5
         BZj7+T49bL4dH4DH1o+vxpPkRy5jX0DB5yoV1mgORlRp4Ldk114MEMB+v6Y/TcRaqLBg
         WGCIblpFFHA0+cbqc+8sX+xM+sJ7TfTCqpQ08gL0dZowTXewSKmdXAZD83DMFQMSYaUl
         jnGbg8/joYnJZENg2D0sVqA8NC61/e8vMMKiBg6d4/jF1ObFWYTwGw+D3R5vmTnw1p3S
         rv1oJ09jinQ6/w/S/5V1Nxk2JknktfsktAls1VW1zzPrhg45xoxNnE07UjvGWTWZZ0Tu
         +zrQ==
X-Gm-Message-State: APjAAAUjKTtA4qG1PIboLlnRi4dwFlualjuXimS4NmvRNSYeC/f6XBVt
        eebHPRH5uGcRBPmi53rT4dcQEVxw8UyfIKmf2d8=
X-Google-Smtp-Source: APXvYqxWoILeH19laoeNKDUdds+SZKoNMXfjWGd9r0pgEhx4ynET56t6cJvMxEBQHr3SW5FzJcxIDj9vvsdeRCsFt4g=
X-Received: by 2002:aca:5885:: with SMTP id m127mr5145692oib.110.1571784486810;
 Tue, 22 Oct 2019 15:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 00:47:55 +0200
Message-ID: <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Oct 23, 2019 at 12:06 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> Hello,
>
> I've been working on a series which add DEV_PM_QOS support to devfreq,
> now at v9:
>
>         https://patchwork.kernel.org/cover/11171807/
>
> Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series
> depends upon. I found the email on patchwork, hopefully the in-reply-to
> header is OK?
>
> As far as I can tell the replacement ("frequency qos") needs constraints
> to be managed outside the device infrastructure and it's not obviously
> usable a generic mechanism for making "min_freq/max_freq" requests to a
> specific device.

You can add a struct freq_constrants pointer to struct dev_pm_info and
use it just fine.  It doesn't have to be bolted into struct
dev_pm_qos.

> I've read a bit through your emails and it seems the problem is that
> you're dealing with dev_pm_qos on per-policy basis but each "struct
> cpufreq_policy" can cover multiple CPU devices.
>
> An alternative solution which follows dev_pm_qos would be to add
> notifiers for each CPU inside cpufreq_online and cpufreq_offline. This
> makes quite a bit of sense because each CPU is a separate "device" with
> a possibly distinct list of qos requests.

But combining the lists of requests for all the CPUs in a policy
defeats the idea of automatic aggregation of requests which really is
what PM QoS is about.

There have to be two lists of requests per policy, one for the max and
one for the min frequency.

> If cpufreq needs a group of CPUs to run at the same frequency then it
> should deal with this by doing dev_pm_qos_read_frequency on each CPU
> device and picking a frequency that attempts to satisfy all constraints.

No, that would be combining the requests by hand.

> Handling sysfs min/max_freq through dev_pm_qos would be of dubious
> value, though I guess you could register identical requests for each CPU.
>
> I'm not familiar with what you're trying to accomplish with PM_QOS other
> than replace the sysfs min_freq/max_freq files:

QoS-based management of the frequency limits is not really needed for
that.  The real motivation for adding it were things like thermal and
platform firmware induced limits that all have their own values to
combine with the ones provided by user space.

> What I want to do is add
> a driver using the interconnect driver which translates requests for
> "bandwidth-on-a-path" into "frequency-on-a-device". More specifically a
> display driver could request bandwidth to RAM and this would be
> translated into min frequency for NoC and the DDR controller, both of
> which implement scaling via devfreq:
>
>         https://patchwork.kernel.org/cover/11104113/
>         https://patchwork.kernel.org/cover/11111865/
>
> This is part of an effort to upstream an out-of-tree "busfreq" feature
> which allows device device to make "min frequency requests" through an
> entirely out-of-tree mechanism. It would also allow finer-grained
> scaling that what IMX tree currently support.
>
> If you're making cpufreq qos constrains be "per-cpufreq-policy" then
> it's not clear how you would handle in-kernel constraints from other
> subsystems. Would users have to get a pointer to struct cpufreq_policy
> and struct freq_constraints?

Yes.

> That would make object lifetime a nightmare!

Why really?  It is not much different from the device PM QoS case.

Actually, https://patchwork.kernel.org/patch/11193019/ is a simple
one-for-one replacement of the former.  As it turns out, all of its
users have access to a policy object anyway already.

> But dev_pm_qos solves this by tying to struct device.

Well, the cpufreq sysfs is per-policy and not per-CPU and we really
need a per-policy min and max frequency in cpufreq, for governors etc.

> And if you don't care about in-kernel requests then what's the purpose
> of involving PM QoS? The old min/max_freq sysfs implementation worked.

See above.

Thanks!
