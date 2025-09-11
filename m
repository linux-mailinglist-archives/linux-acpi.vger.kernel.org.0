Return-Path: <linux-acpi+bounces-16677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3AB536D1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFF1CC3B09
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB45322C7D;
	Thu, 11 Sep 2025 15:00:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7231355A;
	Thu, 11 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602840; cv=none; b=n4UflG/QWYaFovmoaKtW0ktoNmWWBbB4zvaZinUc5lhSqZoFK8IS3SDme7X4NI88/zx2Dra1wNqSryf82fht+3agwi/Eywmw4MggmubCH4SMesU4+7YIdruDO8XTM/3PNMwXvklgS1t7tZwbo8qKyTnPX1VutufD3MGgb6BEAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602840; c=relaxed/simple;
	bh=OOC9yP53JCA8miopYLpoW4SfdRDHAJte+PkBlrYrHy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcpyBYADfGuxTUdDJNuyJ8lXWmpVpdHzq0I79kR7QtsxZZoiDvS3pWGwG3LBqDAW1Kky0zO30M8dl2uPSpCCakvrycQmb7bh/Lf53HtI3gXmJs5ShJG3l8ks1LgfsTPCNRZRevZ7lFPSaZkrr7hFb5FOlOqTY+EfGTBOQghNvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cN0zQ1Gh7z6LDB4;
	Thu, 11 Sep 2025 22:57:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 35CF01402F8;
	Thu, 11 Sep 2025 23:00:34 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 17:00:33 +0200
Date: Thu, 11 Sep 2025 16:00:31 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v2 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
Message-ID: <20250911160031.000026c7@huawei.com>
In-Reply-To: <20250910204309.20751-10-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-10-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:49 +0000
James Morse <james.morse@arm.com> wrote:

> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
Hi James,

I'm not sure why some things ended up in this patch and others didn't.
MPAMCFG_EN for example isn't here.

If doing a separate 'register defines' patch I'd do the lot as of
the current spec.

> 
> Link: https://developer.arm.com/documentation/ihi0099/latest/

Maybe link a specific version? I'm not sure if I'm looking at is the same one
as you were when you wrote this. That will become worse over time.  I'm definitely
seeing extra bits in a number of registers.

I'm lazy enough not to go see if the cover letter calls out a version.

Anyhow, various small things on ordering that would have made this easier to review
against the spec.

Jonathan


> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v1:
>  * Whitespace.
>  * Added constants for CASSOC and XCL.
>  * Merged FLT/CTL defines.
>  * Fixed MSMON_CFG_CSU_CTL_TYPE_CSU definition.
> 
> Changes since RFC:
>  * Renamed MSMON_CFG_MBWU_CTL_TYPE_CSU as MSMON_CFG_CSU_CTL_TYPE_CSU
>  * Whitepsace churn.
>  * Cite a more recent document.
>  * Removed some stale feature, fixed some names etc.
> ---
>  drivers/resctrl/mpam_internal.h | 267 ++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 02e9576ece6b..109f03df46c2 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -152,4 +152,271 @@ extern struct list_head mpam_classes;
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>  				   cpumask_t *affinity);
>  
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/

Maybe be friendly and give some section number references.

> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */
> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR		0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR		0x0080  /* performance monitoring features */

Any reason this one is out of order with respect to the addresses?

> +#define MPAMF_IMPL_IDR		0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR		0x0030  /* cache-portion partitioning */
> +#define MPAMF_CCAP_IDR		0x0038  /* cache-capacity partitioning */
> +#define MPAMF_MBW_IDR		0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR		0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR	0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR	0x0090  /* mem-bw usage monitor */
> +#define MPAMF_PARTID_NRW_IDR	0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR		0x0018  /* implementer id register */
> +#define MPAMF_AIDR		0x0020  /* architectural id register */

These 3 as well. I'm not sure what the ordering is conveying but probably easier to just
to put them in address order.

There are some other cases of this below.


> +/* MPAMF_IIDR - MPAM implementation ID register */
> +#define MPAMF_IIDR_PRODUCTID	GENMASK(31, 20)
> +#define MPAMF_IIDR_PRODUCTID_SHIFT	20
> +#define MPAMF_IIDR_VARIANT	GENMASK(19, 16)
> +#define MPAMF_IIDR_VARIANT_SHIFT	16
> +#define MPAMF_IIDR_REVISON	GENMASK(15, 12)
> +#define MPAMF_IIDR_REVISON_SHIFT	12
> +#define MPAMF_IIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define MPAMF_IIDR_IMPLEMENTER_SHIFT	0
I'd expect to see FIELD_GET/ PREP rather than use of shifts. Can we drop the defines?

Pick an order for reg field definitions. Until here they've been low to high.


> +/* Error conditions in accessing memory mapped registers */
> +#define MPAM_ERRCODE_NONE			0
> +#define MPAM_ERRCODE_PARTID_SEL_RANGE		1
> +#define MPAM_ERRCODE_REQ_PARTID_RANGE		2
> +#define MPAM_ERRCODE_MSMONCFG_ID_RANGE		3
> +#define MPAM_ERRCODE_REQ_PMG_RANGE		4
> +#define MPAM_ERRCODE_MONITOR_RANGE		5
> +#define MPAM_ERRCODE_INTPARTID_RANGE		6
> +#define MPAM_ERRCODE_UNEXPECTED_INTERNAL	7

Seems there are more in latest spec..
> +
> +/*
> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure cache storage
> + *                    usage monitor control register
> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor configure memory
> + *                     bandwidth usage monitor control register
> + */
> +#define MSMON_CFG_x_CTL_TYPE			GENMASK(7, 0)
> +#define MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L	BIT(15)
> +#define MSMON_CFG_x_CTL_MATCH_PARTID		BIT(16)
> +#define MSMON_CFG_x_CTL_MATCH_PMG		BIT(17)
> +#define MSMON_CFG_x_CTL_SCLEN			BIT(19)
On the spec I'm looking at this is reserved in CSU_CTL

> +#define MSMON_CFG_x_CTL_SUBTYPE			GENMASK(22, 20)
> +#define MSMON_CFG_x_CTL_OFLOW_FRZ		BIT(24)
> +#define MSMON_CFG_x_CTL_OFLOW_INTR		BIT(25)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS		BIT(26)
> +#define MSMON_CFG_x_CTL_CAPT_RESET		BIT(27)
> +#define MSMON_CFG_x_CTL_CAPT_EVNT		GENMASK(30, 28)
> +#define MSMON_CFG_x_CTL_EN			BIT(31)

I guess this combining of definitions will show some advante in common code
later but right now it seems confusing given not all bits are present in both.

> +
> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU			0x42
> +#define MSMON_CFG_CSU_CTL_TYPE_CSU			0x43
> +
> +/*
> + * MSMON_CFG_CSU_FLT -  Memory system performance monitor configure cache storage
> + *                      usage monitor filter register
> + * MSMON_CFG_MBWU_FLT - Memory system performance monitor configure memory
> + *                      bandwidth usage monitor filter register
> + */
> +#define MSMON_CFG_x_FLT_PARTID			GENMASK(15, 0)
> +#define MSMON_CFG_x_FLT_PMG			GENMASK(23, 16)
> +
> +#define MSMON_CFG_MBWU_FLT_RWBW			GENMASK(31, 30)
> +#define MSMON_CFG_CSU_FLT_XCL			BIT(31)
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
> +#define MSMON___LWD_VALUE	GENMASK(62, 0)
> +
> +/*
> + * MSMON_CAPT_EVNT - Memory system performance monitoring capture event
> + *                  generation register
> + */
> +#define MSMON_CAPT_EVNT_NOW	BIT(0)
> +
>  #endif /* MPAM_INTERNAL_H */


