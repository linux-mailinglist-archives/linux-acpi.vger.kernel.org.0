Return-Path: <linux-acpi+bounces-16721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C9B54D8A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C92D169D2C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71592DF13A;
	Fri, 12 Sep 2025 12:22:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B842749E0;
	Fri, 12 Sep 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679757; cv=none; b=Eui+JsVeb8jFHb777Y7MTX43L4U1HGr/0HvHbOXOFzwQByEMtoR01+7RdF4muOT3Uz21czqRn1a3WJfebzjR2kpRnGUnq//0pVMG12ZpqEWOBSJew+rGCCobeHJEi/ija4ohlV9ECAiXSn2zcGIhU65qK740V0P1vQDIwkmMRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679757; c=relaxed/simple;
	bh=mRRtzhHa3/oVhUpszk0hMMthfzQIOsVey2IFkTKlWtE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LehNeyLOfhlrvH+QX8yLHITzVPqig80ILl3L3a+AsOfZvkdGyarqf7oST/bvribHxOXmqiwiijq9koPN2MAhHmgsJvX6usJUztmHnCPrvuePSxxMjEhnHhGtsaJfrRyQ3VB2SkoQM7QvvufUOtsFlBtkmTRvjgYRtV9Wt+UQOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNYQb0Bswz6M4YB;
	Fri, 12 Sep 2025 20:19:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D6491402EF;
	Fri, 12 Sep 2025 20:22:32 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 14:22:31 +0200
Date: Fri, 12 Sep 2025 13:22:29 +0100
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
Subject: Re: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied
 and restored during cpu online
Message-ID: <20250912132229.000044c7@huawei.com>
In-Reply-To: <20250910204309.20751-21-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-21-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:43:00 +0000
James Morse <james.morse@arm.com> wrote:

> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Trivial comments
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> +
> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
> +{
> +	memset(reset_cfg, 0, sizeof(*reset_cfg));

Might as well do the following and skip the memset.

	*reset_cfg = (struct mpam_config) {
		.features = ~0,
		.cpbm = ~0,
		.mbw_pbm = ~0,
		.mbw_max = MPAM...
		.reset_cpbm = true,
		.reset_mbw_pbm = true,
	};
> +
> +	reset_cfg->features = ~0;
> +	reset_cfg->cpbm = ~0;
> +	reset_cfg->mbw_pbm = ~0;
> +	reset_cfg->mbw_max = MPAMCFG_MBW_MAX_MAX;
> +
> +	reset_cfg->reset_cpbm = true;
> +	reset_cfg->reset_mbw_pbm = true;
> +}

> +static int mpam_allocate_config(void)
> +{
> +	int err = 0;

Always set before use. Maybe push down so it is in tighter scope and
can declare and initialize to final value in one line.

> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list) {
> +			err = __allocate_component_cfg(comp);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}


> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index b69fa9199cb4..17570d9aae9b 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -169,11 +169,7 @@ struct mpam_props {
>  	u16			num_mbwu_mon;
>  };
>  
> -static inline bool mpam_has_feature(enum mpam_device_features feat,
> -				    struct mpam_props *props)
> -{
> -	return (1 << feat) & props->features;
> -}
> +#define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)

If this is worth doing push it back to original introduction.
I'm not sure it is necessary.

Jonathan




