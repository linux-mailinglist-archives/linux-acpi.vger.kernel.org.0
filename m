Return-Path: <linux-acpi+bounces-16679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E31BB53793
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F2818838CB
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB6350D77;
	Thu, 11 Sep 2025 15:18:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D234AB16;
	Thu, 11 Sep 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603939; cv=none; b=uzpEAdVTtt0E1WnnxEKrdh1gfiO/HJGCLPGP3dP6C5UzGG1UsgVdxds8L83sWYwouUVi97aQ4U44Ipw5vt949C3ipNZw6zUro25IuCRxvpBzwejID/Wbv1u/lIcTjDeM66n7gQy/2NPtZ25b8GXvCSsgY94aA+bM8rVpe9lMvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603939; c=relaxed/simple;
	bh=I7YGGanpOgi0GxybFy5Wf2Mk7TVpMUQ+ZwWpHZt5siU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHlpSFEtMhnBOpoXQ4rT/RrhdFNhml7k3zYJFHqDrq9ioP/e30YOBfBIlNB2f+DKaMK+NRuQdqo9oWUZ1MSTitUuYgEsCseiuGa0PJ7O9I5zfgL55TXF3qKUtUmD8utHeLPVP7Nuou3cgd2fYlXN3cW5sajcMgWtCaHn5fovTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cN1NY10YNz6LDBg;
	Thu, 11 Sep 2025 23:16:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 319A3140446;
	Thu, 11 Sep 2025 23:18:53 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 17:18:51 +0200
Date: Thu, 11 Sep 2025 16:18:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 11/29] arm_mpam: Probe hardware to find the supported
 partid/pmg values
Message-ID: <20250911161850.00005667@huawei.com>
In-Reply-To: <20250910204309.20751-12-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-12-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:51 +0000
James Morse <james.morse@arm.com> wrote:

> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
> 
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
> 
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Trivial stuff inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> Changes since v1:
>  * Change to lock ordering now that the list-lock mutex isn't held from
>    the cpuhp call.
>  * Removed irq-unmaksed assert in requestor register.
>  * Changed captialisation in print message.
> ---
>  drivers/resctrl/mpam_devices.c  | 150 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |   6 ++
>  include/linux/arm_mpam.h        |  14 +++
>  3 files changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index c265376d936b..24dc81c15ec8 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c


> +int mpam_register_requestor(u16 partid_max, u8 pmg_max)
> +{
> +	int err = 0;
> +
> +	spin_lock(&partid_max_lock);
guard() perhaps so you can return early in the error pat and avoid
need for local variable err.

> +	if (!partid_max_init) {
> +		mpam_partid_max = partid_max;
> +		mpam_pmg_max = pmg_max;
> +		partid_max_init = true;
> +	} else if (!partid_max_published) {
> +		mpam_partid_max = min(mpam_partid_max, partid_max);
> +		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
> +	} else {
> +		/* New requestors can't lower the values */
> +		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
> +			err = -EBUSY;
> +	}
> +	spin_unlock(&partid_max_lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(mpam_register_requestor);

> @@ -470,9 +547,37 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>  	return err;
>  }
>  
> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
> +						   u8 ris_idx)
> +{
> +	int err;
> +	struct mpam_msc_ris *ris, *found = ERR_PTR(-ENOENT);
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (!test_bit(ris_idx, &msc->ris_idxs)) {
> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
> +					     0, 0);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	list_for_each_entry(ris, &msc->ris, msc_list) {
> +		if (ris->ris_idx == ris_idx) {
> +			found = ris;
I'd return ris;

Then can do return ERR_PTR(-ENOENT) below and not bother with found.

Ignore if this gets more complex later.

> +			break;
> +		}
> +	}
> +
> +	return found;
> +}

> @@ -675,9 +813,18 @@ static struct platform_driver mpam_msc_driver = {
>  
>  static void mpam_enable_once(void)
>  {
> +	/*
> +	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
> +	 * longer change.
> +	 */
> +	spin_lock(&partid_max_lock);
> +	partid_max_published = true;
> +	spin_unlock(&partid_max_lock);
> +
>  	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>  
> -	pr_info("MPAM enabled\n");
> +	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
> +	       mpam_partid_max + 1, mpam_pmg_max + 1);

Not sure why pr_info before and printk now.  

>  }



