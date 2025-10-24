Return-Path: <linux-acpi+bounces-18196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B4C078DE
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A2304F79AF
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A535345CD4;
	Fri, 24 Oct 2025 17:32:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C732E722;
	Fri, 24 Oct 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327157; cv=none; b=IHrubt0f9iqlOqRfalTGlcdSPaHvlLOTqRPwQZvIIIELlnC4fJrKbQZgAWg+FLWcR2GZ03ci7DRZ7fRkLvtnVVmFMEiVv/wGfsCpIDRUCAUir5E/2ugsqAIizPXUeLtCKl2kvRw5l/rknxdwWS0BlEUbjvuVJIEGBCb9zybOEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327157; c=relaxed/simple;
	bh=uZhm2leRVs+ChR1cEyMdtRUl3cZTvucBu6IlUN6kQlo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVK4gdN1WQ17bSk6GzoWI5/H33+Mj/hhet+91cm9AIu6vWlPjvtRhDFWAqq4BWx9yiqnPHkREiBP8zzgs9XWDhjcrPHBrtIIr1dI8V1ASrTuqKYZu8K20c/nTT8HKaR82JIhJ4TnFxwdN3uPgCD1A6KAI5XJP06ZUDKEW4BY8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctVJ84zcpz6GDFt;
	Sat, 25 Oct 2025 01:29:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 855BD1400CB;
	Sat, 25 Oct 2025 01:32:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 18:32:30 +0100
Date: Fri, 24 Oct 2025 18:32:28 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v3 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
Message-ID: <20251024183228.00005a64@huawei.com>
In-Reply-To: <20251017185645.26604-10-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-10-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:25 +0000
James Morse <james.morse@arm.com> wrote:

> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Link: https://developer.arm.com/documentation/ihi0099/latest/

I can't figure out how to get a stable link when there is only
one version.  If possible would be good to use one.

I guess it probably doesn't matter unless someone renames things as
you only have as subset of the fields currently there for some registers.

> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
A few tiny things inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  drivers/resctrl/mpam_internal.h | 268 ++++++++++++++++++++++++++++++++
>  1 file changed, 268 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 1a5d96660382..1ef3e8e1d056 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -142,4 +142,272 @@ extern struct list_head mpam_classes;
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>  				   cpumask_t *affinity);
>  
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/
> + */
> +#define MPAM_ARCHITECTURE_V1    0x10

> +#define MSMON_MBWU_L		0x0880  /* current long mem-bw usage value */
> +#define MSMON_MBWU_CAPTURE_L	0x0890  /* last long mem-bw value captured */
Spec name I'm seeing is
MSMON_MBWU_L_CAPTURE.  Maybe a good idea to match?

> + */
> +#define MSMON_CFG_x_CTL_TYPE			GENMASK(7, 0)
> +#define MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L	BIT(15)
> +#define MSMON_CFG_x_CTL_MATCH_PARTID		BIT(16)
> +#define MSMON_CFG_x_CTL_MATCH_PMG		BIT(17)
> +#define MSMON_CFG_x_CTL_SUBTYPE			GENMASK(22, 20)
> +#define MSMON_CFG_x_CTL_OFLOW_FRZ		BIT(24)
> +#define MSMON_CFG_x_CTL_OFLOW_INTR		BIT(25)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS		BIT(26)
> +#define MSMON_CFG_x_CTL_CAPT_RESET		BIT(27)
> +#define MSMON_CFG_x_CTL_CAPT_EVNT		GENMASK(30, 28)
> +#define MSMON_CFG_x_CTL_EN			BIT(31)
> +
> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU		0x42
> +#define MSMON_CFG_CSU_CTL_TYPE_CSU		0x43
> +
> +#define MSMON_CFG_MBWU_CTL_SCLEN		BIT(19)

Why is this one down here, but OFLOW_STATUS_L is in middle of the shared
block of definitions? I don't mind which approach you use, but not a mix.

> +
> +/*
> + * MSMON_CSU - Memory system performance monitor cache storage usage monitor
> + *            register
> + * MSMON_CSU_CAPTURE -  Memory system performance monitor cache storage usage
> + *                     capture register
> + * MSMON_MBWU  - Memory system performance monitor memory bandwidth usage
> + *               monitor register
> + * MSMON_MBWU_CAPTURE - Memory system performance monitor memory bandwidth usage
> + *                     capture register
> + */
> +#define MSMON___VALUE		GENMASK(30, 0)
> +#define MSMON___NRDY		BIT(31)
> +#define MSMON___NRDY_L		BIT(63)
> +#define MSMON___L_VALUE		GENMASK(43, 0)
Positioning of L in these seems a little inconsistent?

> +#define MSMON___LWD_VALUE	GENMASK(62, 0)

>  #endif /* MPAM_INTERNAL_H */


