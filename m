Return-Path: <linux-acpi+bounces-18750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC96C4850D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CD5188ADFA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4692BE05F;
	Mon, 10 Nov 2025 17:27:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF627F74B;
	Mon, 10 Nov 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795653; cv=none; b=nQ/NCBetv2QGEMwcTOqcs5aR7mvBhwfeB+KwIa5gaBZ52rwwic3417dibSTdannudG2xGqhjkMkCCfkKKtldVKTFWnptkAdC+XwinRd3cKNo9cKuAi3biAAf+ZTTpFpYcobv76paoP8bLE8vIdffQfEU0jmW7VtZorGE/KCOlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795653; c=relaxed/simple;
	bh=XNTPb2CQYs4j8ULibpqU5Vo9ZhP/k37sp6wJQuryjxA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9koqfd3SYykR8ii17Yqi7zcgWn6mMiYeseaz0dLNVl4xdN1wo0lTrF4+Zcb7C+zb7v6L3VNDf6DAoOqZshopQM6Qf5Ho5F5tNXv/k2Vi73LbIHL4sCTkFVYBHsbQ2zGCEEsg/L5ZD/TkH5j8sUHNclZw++VKm5PAXd0zO5/pUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4xRz5k1QzHnGjG;
	Tue, 11 Nov 2025 01:27:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 49F8E14033C;
	Tue, 11 Nov 2025 01:27:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 17:27:25 +0000
Date: Mon, 10 Nov 2025 17:27:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Message-ID: <20251110172724.00005675@huawei.com>
In-Reply-To: <20251107123450.664001-24-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-24-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:40 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate

I'm not following 'were modified'.  When?  Sometime in the past?
Perhaps "features that have been modified when XXX happens" or

Having read the code I think this is something like "are modified as configuration
is read".

> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
> Cc: Peter Newman peternewman@google.com
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix component reset, otherwise cpbm wrong and controls not set.
> Add a cfg_lock to guard configuration of an msc

The use of bitmap_set() for things that aren't unsigned long (arrays) is a bad
idea. Much better to use GENMASK() to fill those.

> ---
>  drivers/resctrl/mpam_devices.c  | 268 ++++++++++++++++++++++++++++++--
>  drivers/resctrl/mpam_internal.h |  27 ++++
>  2 files changed, 280 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3a0ad8d93fff..8b0944bdaf28 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c



> @@ -1125,6 +1225,9 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  	if (err)
>  		return ERR_PTR(err);
>  	err = devm_mutex_init(dev, &msc->error_irq_lock);
> +	if (err)
> +		return ERR_PTR(err);
Trivial: As in earlier patches. I'd put a blank line here for readability.
> +	err = devm_mutex_init(dev, &msc->cfg_lock);
>  	if (err)
>  		return ERR_PTR(err);
>  	mpam_mon_sel_lock_init(msc);
> @@ -1585,6 +1688,70 @@ static void mpam_unregister_irqs(void)
>  	}
>  }
>  
> +static void __destroy_component_cfg(struct mpam_component *comp)
> +{
> +	add_to_garbage(comp->cfg);
> +}
> +
> +static void mpam_reset_component_cfg(struct mpam_component *comp)
> +{
> +	int i;
> +	struct mpam_props *cprops = &comp->class->props;
> +
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (!comp->cfg)
> +		return;
> +
> +	for (i = 0; i <= mpam_partid_max; i++) {
> +		comp->cfg[i] = (struct mpam_config) {};
> +		bitmap_fill(comp->cfg[i].features, MPAM_FEATURE_LAST);
> +		bitmap_set((unsigned long *)&comp->cfg[i].cpbm, 0, cprops->cpbm_wd);

Why manipulate a u32 with bitmap_set() with a horrible pretend it's an unsigned long cast.
Instead just do:
		comp->cfg[i].cpbm = GENMASK(cprops->cpbm_wd, 0);
Which is indeed what bitmap_set will do internally due to an optimization for small bitmaps
but lets avoid that making one integer pretend to be another of a different length.


> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_pbm, 0, cprops->mbw_pbm_bits);
> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_max, 16 - cprops->bwa_wd, cprops->bwa_wd);
> +	}
> +}


