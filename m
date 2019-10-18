Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86F8DC240
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392659AbfJRKM6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 06:12:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41123 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387545AbfJRKM6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 06:12:58 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 49e72b95e28af242; Fri, 18 Oct 2019 12:12:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port access for wait
Date:   Fri, 18 Oct 2019 12:12:54 +0200
Message-ID: <2566427.rT6C98KLSe@kreacher>
In-Reply-To: <2b3ce9e9-e805-1b8d-86c3-c8f498a4d3dd@intel.com>
References: <20191015080404.6013-1-fengwei.yin@intel.com> <c9f3f4f93bb946f790fce4709253b359@AcuMS.aculab.com> <2b3ce9e9-e805-1b8d-86c3-c8f498a4d3dd@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, October 16, 2019 7:56:17 AM CEST Yin, Fengwei wrote:
> Hi David,
> 
> On 10/15/2019 7:48 PM, David Laight wrote:
> > From: Yin Fengwei
> >> Sent: 15 October 2019 09:04
> >> In function acpi_idle_do_entry(), an ioport access is used for dummy
> >> wait to guarantee hardware behavior. But it could trigger unnecessary
> >> vmexit in virtualization environment.
> >>
> >> If we run linux as guest and export all available native C state to
> >> guest, we did see many PM timer access triggered VMexit when guest
> >> enter deeper C state in our environment (We used ACRN hypervisor
> >> instead of kvm or xen which has PM timer emulated and exports all
> >> native C state to guest).
> >>
> >> According to the original comments of this part of code, io port
> >> access is only for dummy wait. We could use busy wait instead of io
> >> port access to guarantee hardware behavior and avoid unnecessary
> >> VMexit.
> > 
> > You need some hard synchronisation instruction(s) after the inb()
> > and before any kind of delay to ensure your delay code is executed
> > after the inb() completes.
> > 
> > I'm pretty sure that inb() is only synchronised with memory reads.
> Thanks a lot for the comments.
> 
> I didn't find the common serializing instructions API in kernel (only
> memory  barrier which is used to make sure of memory access). For Intel
> x86, cpuid could be used as serializing instruction. But it's not
> suitable for common code here. Do you have any suggestion?

In the virt guest case you don't need to worry at all AFAICS, because the inb()
itself will trap to the HV.

> > 
> > ...
> >> +	/* profiling the time used for dummy wait op */
> >> +	ktime_get_real_ts64(&ts0);
> >> +	inl(acpi_gbl_FADT.xpm_timer_block.address);
> >> +	ktime_get_real_ts64(&ts1);

You may as well use ktime_get() for this, as it's almost the same code as
ktime_get_real_ts64() AFAICS, only simpler.

Plus, static vars need not be initialized to 0.

> > 
> > That could be dominated by the cost of ktime_get_real_ts64().
> > It also need synchronising instructions.
> I did some testing. ktime_get_real_ts64() takes much less time than io
> port access.
> 
> The test code is like:
> 1.
> 	local_irq_save(flag);
> 	ktime_get_real_ts64(&ts0);
> 	inl(acpi_gbl_FADT.xpm_timer_block.address);
> 	ktime_get_real_ts64(&ts1);
> 	local_irq_restore(flag);
> 
> 2.
> 	local_irq_save(flag);
> 	ktime_get_real_ts64(&ts0);
> 	ktime_get_real_ts64(&ts1);
> 	local_irq_restore(flag);
> 
> The delta in 1 is about 500000ns. And delta in 2 is about
> 2000ns. The date is gotten on Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz.
> So I suppose the impact of ktime_get_real_ts64 is small.

You may not be hitting the worst case for ktime_get_real_ts64(), though.

I wonder if special casing the virt guest would be a better approach.

Then, you could leave the code as is for non-virt and I'm not sure if the
delay is needed in the virt guest case at all.

So maybe do something like "if not in a virt guest, do the dummy inl()"
and that would be it?



