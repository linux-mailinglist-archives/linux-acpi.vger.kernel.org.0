Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF4DB318
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440630AbfJQRPA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 13:15:00 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41934 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfJQRO7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 13:14:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E266328;
        Thu, 17 Oct 2019 10:14:38 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADDE3F718;
        Thu, 17 Oct 2019 10:14:37 -0700 (PDT)
Date:   Thu, 17 Oct 2019 18:14:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017171432.GA32485@bogus>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016142343.GB5330@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 03:23:43PM +0100, Sudeep Holla wrote:
> On Wed, Oct 16, 2019 at 12:37:58PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > The motivation for this series is to address the problem discussed here:
> >
> > https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f
> >
> > and also reported here:
> >
> > https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> >
> > Plus, generally speaking, using the policy CPU as a proxy for the policy
> > with respect to PM QoS does not feel particularly straightforward to me
> > and adds extra complexity.
> >
> > Anyway, the first patch adds frequency QoS that is based on "raw" PM QoS (kind
> > of in analogy with device PM QoS) and is just about min and max frequency
> > requests (no direct relationship to devices).
> >
> > The second patch switches over cpufreq and its users to the new frequency QoS.
> > [The Fixes: tag has been tentatively added to it.]
> >
> > The third one removes frequency request types from device PM QoS.
> >
> > Unfortunately, the patches are rather big, but also they are quite
> > straightforward.
> >
> > I didn't have the time to test this series, so giving it a go would be much
> > appreciated.
>
> Thanks for the spinning these patches so quickly.
>
For the record, I thought of providing the crash that this series fixes.
After applying [1] which fixes the boot issue I was seeing on TC2, I started
seeing the below crash, which this series fixes.

FWIW,
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

--

Unable to handle kernel paging request at virtual address 31b2c303
pgd = 772b96e1
[31b2c303] *pgd=a4050003, *pmd=00000000
Internal error: Oops: 206 [#1] SMP THUMB2
Modules linked in:
CPU: 1 PID: 518 Comm: bash Not tainted 5.4.0-rc3-00062-g6e3a7fd7a87e-dirty #123
Hardware name: ARM-Versatile Express
PC is at blocking_notifier_chain_unregister+0x2a/0x78
LR is at blocking_notifier_chain_unregister+0x1b/0x78
Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA Thumb  Segment user
Control: 70c5387d  Table: a57b08c0  DAC: 55555555
Process bash (pid: 518, stack limit = 0x018ebe57)
(blocking_notifier_chain_unregister) from (dev_pm_qos_remove_notifier+0x5d/0xb4)
(dev_pm_qos_remove_notifier) from (cpufreq_policy_free+0x77/0xc8)
(cpufreq_policy_free) from (subsys_interface_unregister+0x4f/0x80)
(subsys_interface_unregister) from (cpufreq_unregister_driver+0x29/0x6c)
(cpufreq_unregister_driver) from (bL_cpufreq_switcher_notifier+0x41/0x4c)
(bL_cpufreq_switcher_notifier) from (notifier_call_chain+0x3d/0x58)
(notifier_call_chain) from (blocking_notifier_call_chain+0x29/0x38)
(blocking_notifier_call_chain) from (bL_activation_notify+0x13/0x40)
(bL_activation_notify) from (bL_switcher_active_store+0x59/0x190)
(bL_switcher_active_store) from (kernfs_fop_write+0x85/0x12c)
(kernfs_fop_write) from (__vfs_write+0x21/0x130)
(__vfs_write) from (vfs_write+0x6b/0xfc)
(vfs_write) from (ksys_write+0x6d/0x90)
(ksys_write) from (ret_fast_syscall+0x1/0x5a)
