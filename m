Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24BBADB273
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408174AbfJQQel (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 12:34:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34833 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393857AbfJQQel (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 12:34:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id x3so2723353oig.2;
        Thu, 17 Oct 2019 09:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTweReGzWRV6Ob0sCHbhOekauupQAppLGL1gzS8TcKs=;
        b=pe9wF3D7Kl6nB4c9mowgsk+ThJW8q9PSq+ivgjpZzgoQuAtK20bJviLymZe7UKCdw0
         mJVlQzxDvL9DuDg6s9DB7vkG19y/oxgWV3w6YiGH8t+a7zXbp/TGkqL1pz3R5bfwJWys
         +F9wJteJPyaoiXUswxnEAdFnpPj0yGYWFLgfzQ6qmtIjhNotK555sI2oDRIzxPDCzYAm
         hmwhcI/9x1559oUC2HxrWG7O6T21BIGT0Xj5tF6TYcXY/seo+19Z6PxYbJfeV62/gHXA
         rqJ1/b5wl7LBUqVpu7WSUQdksmQYUPmg8YV10wEHSCMprEpXSI+TqgI0D0rvLANqhbsQ
         n4iA==
X-Gm-Message-State: APjAAAUeawEOwNz7YVRhZ+kYtlvXEHr6skB4Nk+n3OoHw/LeFO7k/Fa6
        uN4Re11HXK3Y4GZZ3HeTvpnYXS7AUoRUpbBnUxQ=
X-Google-Smtp-Source: APXvYqxdtwn4csBmwqLiWGMGaWig215MMPVHzs3sAF65tbKccsRNu9C3I2YhQmoUAwnEvbh1AfpL5ERkR4gfKHL+voQ=
X-Received: by 2002:aca:b6c5:: with SMTP id g188mr4177262oif.103.1571330080233;
 Thu, 17 Oct 2019 09:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7> <20191017095942.GF8978@bogus>
In-Reply-To: <20191017095942.GF8978@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 18:34:28 +0200
Message-ID: <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2019 at 12:00 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 17, 2019 at 03:27:25PM +0530, Viresh Kumar wrote:
> > On 16-10-19, 15:23, Sudeep Holla wrote:
> > > Thanks for the spinning these patches so quickly.
> > >
> > > I did give it a spin, but unfortunately it doesn't fix the bug I reported.
> > > So I looked at my bug report in detail and looks like the cpufreq_driver
> > > variable is set to NULL at that point and it fails to dereference it
> > > while trying to execute:
> > >     ret = cpufreq_driver->verify(new_policy);
> > > (Hint verify is at offset 0x1c/28)
> > >
> > > So I suspect some race as this platform with bL switcher tries to
> > > unregister and re-register the cpufreq driver during the boot.
> > >
> > > I need to spend more time on this as reverting the initial PM QoS patch
> > > to cpufreq.c makes the issue disappear.

I guess you mean commit 67d874c3b2c6 ("cpufreq: Register notifiers
with the PM QoS framework")?

That would make sense, because it added the cpufreq_notifier_min() and
cpufreq_notifier_max() that trigger handle_update() via
schedule_work().

[BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
that the new min is less than the new max, because the QoS doesn't do
that.]

> > Is this easily reproducible ? cpufreq_driver == NULL shouldn't be the case, it
> > get updated only once while registering/unregistering cpufreq drivers. That is
> > the last thing which can go wrong from my point of view :)
> >
>
> Yes, if I boot my TC2 with bL switcher enabled, it always crashes on boot.

It does look like handle_update() races with
cpufreq_unregister_driver() and cpufreq_remove_dev (called from there
indirectly) does look racy.
