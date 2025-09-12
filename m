Return-Path: <linux-acpi+bounces-16745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A3B55335
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2554E5C4D2F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1222212F89;
	Fri, 12 Sep 2025 15:23:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3E214210;
	Fri, 12 Sep 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690580; cv=none; b=saZYu2nRZilRmk+8YXpCv+hE6v4xO3T5MsZyl2f265zQutCwk26X7fV5S/k7AJ2igi09DFkKG/52xt2jeJ2aBevL+RId1IGrQG3aRLl8EXvYWw98CtTc6PagiYB/L/8zWja9MQ2VCR52FVt8JOd35odLnRtdJUEnnkm5vrBeOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690580; c=relaxed/simple;
	bh=uLMlNwa0AZMzUI+4J6trDRbXbv9TBj5WYvvApicfJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEQTeVUoIwfSHcCZP+sLMV0MaYn0I29bx9+fAj2XHETLHozZGC5gbkGktMJMF0po8pFfGj2SBXg7u2/VXwR53YS4KS4rEDbOkvnxnNMpR6nGm7DQpv7MFzvdKo/zutY1H3fPpB3ZqqMaAUB/ctiFqJDHwUs8zRdCRKzNwmFoqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C046D1515;
	Fri, 12 Sep 2025 08:22:49 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E06B3F694;
	Fri, 12 Sep 2025 08:22:52 -0700 (PDT)
Date: Fri, 12 Sep 2025 16:22:44 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
Message-ID: <aMQ6xODb+QRWdblG@e133380.arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-19-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910204309.20751-19-james.morse@arm.com>

Hi James,

On Wed, Sep 10, 2025 at 08:42:58PM +0000, James Morse wrote:
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the ESR register, so no locking is needed.

Nit: MPAMF_ESR?  (Casual readers may confuse it with ESR_ELx.
Formally, there is no MPAM "ESR" register, though people familiar with
the spec will of course know what you're referring to.)

> The work to disable MPAM after an error needs to happen at process
> context as it takes mutex. It also unregisters the interrupts, meaning
> it can't be done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.
> 
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Made mpam_unregister_irqs() safe to race with itself.
>  * Removed threaded interrupts.
>  * Schedule mpam_disable() from cpuhp callback in the case of an error.
>  * Added mpam_disable_reason.
>  * Use alloc_percpu()
> 
> Changes since RFC:
>  * Use guard marco when walking srcu list.
>  * Use INTEN macro for enabling interrupts.
>  * Move partid_max_published up earlier in mpam_enable_once().
> ---
>  drivers/resctrl/mpam_devices.c  | 277 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  10 ++
>  2 files changed, 284 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index a9d3c4b09976..e7e4afc1ea95 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -14,6 +14,9 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
>  #include <linux/mutex.h>
> @@ -166,6 +169,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>  	return (idr_high << 32) | idr_low;
>  }
>  
> +static void mpam_msc_zero_esr(struct mpam_msc *msc)

Nit: Maybe clear_esr?  (The fact that setting the ERRCODE and OVRWR
fields to zero clears the interrupt and prepares for unambiguous
reporting of the next error is more of an implementation detail.
It doesn't matter what the rest of the register is set to.)

> +{
> +	__mpam_write_reg(msc, MPAMF_ESR, 0);
> +	if (msc->has_extd_esr)

This deasserts the interrupt (if level-sensitive) and enables the MSC
to report further errors.  If we are unlucky and error occurs now,
won't we splat the newly HW-generated RIS field by:

> +		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);

...?  If so, we will diagnose the wrong RIS when we pump the new error
from MPAMF_ESR.  I think the correct interpretation of the spec may be
that:

 a) software should treat fields in MPAMF_ESR[63:32] as vaild only if
    ERRCODE is nonzero, and

 b) software should never write to MPAMF_ESR[63:32] while ERRCODE is
    zero.

Does this look right?  Should the fields be cleared in the opposite
order?

Or alternatively, is it actually necessary to clear MPAMF_ESR[63:32]
at all?

(The spec seems a bit vague on what software is supposed to do with
this register to ensure correctness...)

> +}
> +
> +static u64 mpam_msc_read_esr(struct mpam_msc *msc)
> +{
> +	u64 esr_high = 0, esr_low;
> +
> +	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
> +	if (msc->has_extd_esr)
> +		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
> +
> +	return (esr_high << 32) | esr_low;
> +}

[...]

> @@ -895,6 +920,13 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>  	}
>  }
>  
> +static void _enable_percpu_irq(void *_irq)
> +{
> +	int *irq = _irq;
> +
> +	enable_percpu_irq(*irq, IRQ_TYPE_NONE);

Can the type vary?  (Maybe this makes no sense on GIC-based systems --
IRQ_TYPE_NONE (or "0") seems overwhelmingly common.)

(Just my lack of familiarity takling, here.)

[...]

> +static int __setup_ppi(struct mpam_msc *msc)
> +{
> +	int cpu;
> +	struct device *dev = &msc->pdev->dev;
> +
> +	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
> +	if (!msc->error_dev_id)
> +		return -ENOMEM;
> +
> +	for_each_cpu(cpu, &msc->accessibility) {
> +		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
> +
> +		if (empty) {
> +			dev_err_once(dev, "MSC shares PPI with %s!\n",
> +				     dev_name(&empty->pdev->dev));
> +			return -EBUSY;
> +		}
> +		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
> +	}

How are PPIs supposed to work?

An individual MSC that is affine to multiple CPUs has no way to
distinguish which CPU an error relates to, and no CPU-specific (or even
RIS-specific) ESR.

So, won't such an interrupt be pointlessly take the interrupt on all
CPUs, which would all fight over the reported event?

Have you encountered any platforms wired up this way?  The spec
recommends not to do this, but does not provide any rationale...

The spec only mentions PPIs in the context of being affine to a single
CPU (PE).  It's not clear to me that any other use of PPIs makes
sense (?)

If we really have to cope with this, maybe it would make sense to pick
a single CPU in the affinity set (though we might have to move it
around if the unlucky CPU is offlined).

[...]

> +static char *mpam_errcode_names[16] = {
> +	[0] = "No error",
> +	[1] = "PARTID_SEL_Range",
> +	[2] = "Req_PARTID_Range",
> +	[3] = "MSMONCFG_ID_RANGE",
> +	[4] = "Req_PMG_Range",
> +	[5] = "Monitor_Range",
> +	[6] = "intPARTID_Range",
> +	[7] = "Unexpected_INTERNAL",
> +	[8] = "Undefined_RIS_PART_SEL",
> +	[9] = "RIS_No_Control",
> +	[10] = "Undefined_RIS_MON_SEL",
> +	[11] = "RIS_No_Monitor",
> +	[12 ... 15] = "Reserved"
> +};
> +
> +static int mpam_enable_msc_ecr(void *_msc)
> +{
> +	struct mpam_msc *msc = _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
> +
> +	return 0;
> +}

This could also be a switch () { case 0: return "foo";
case 1: return "bar"; ... }, without the explicit table.  This would
avoid having to think about the ERRCODE field growing.  (There are some
RES0 bits looming over it.)

(This also tends to avoid the extra pointer table in .rodata, which
might be of interest if this were a hot path.)

[...]

(Review truncated -- that's the comments I had so far on the previous
series.)

Cheers
---Dave

