Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B264EDB2AE
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409198AbfJQQmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 12:42:43 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41286 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbfJQQmm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D4A328;
        Thu, 17 Oct 2019 09:42:22 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 127E23F6C4;
        Thu, 17 Oct 2019 09:42:20 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:42:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017164215.GA32531@bogus>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2019 at 06:34:28PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 17, 2019 at 12:00 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 17, 2019 at 03:27:25PM +0530, Viresh Kumar wrote:
> > > On 16-10-19, 15:23, Sudeep Holla wrote:
> > > > Thanks for the spinning these patches so quickly.
> > > >
> > > > I did give it a spin, but unfortunately it doesn't fix the bug I reported.
> > > > So I looked at my bug report in detail and looks like the cpufreq_driver
> > > > variable is set to NULL at that point and it fails to dereference it
> > > > while trying to execute:
> > > >     ret = cpufreq_driver->verify(new_policy);
> > > > (Hint verify is at offset 0x1c/28)
> > > >
> > > > So I suspect some race as this platform with bL switcher tries to
> > > > unregister and re-register the cpufreq driver during the boot.
> > > >
> > > > I need to spend more time on this as reverting the initial PM QoS patch
> > > > to cpufreq.c makes the issue disappear.
>
> I guess you mean commit 67d874c3b2c6 ("cpufreq: Register notifiers
> with the PM QoS framework")?
>

Correct.

> That would make sense, because it added the cpufreq_notifier_min() and
> cpufreq_notifier_max() that trigger handle_update() via
> schedule_work().
>

Yes, it was not clear as I didn't trace to handle_update earlier. After
looking at depth today afternoon, I arrived at the same conclusion.

> [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> that the new min is less than the new max, because the QoS doesn't do
> that.]
>
> > > Is this easily reproducible ? cpufreq_driver == NULL shouldn't be the case, it
> > > get updated only once while registering/unregistering cpufreq drivers. That is
> > > the last thing which can go wrong from my point of view :)
> > >
> >
> > Yes, if I boot my TC2 with bL switcher enabled, it always crashes on boot.
>
> It does look like handle_update() races with
> cpufreq_unregister_driver() and cpufreq_remove_dev (called from there
> indirectly) does look racy.

Indeed, we just crossed the mails. I just found that and posted a patch.

--
Regards,
Sudeep
