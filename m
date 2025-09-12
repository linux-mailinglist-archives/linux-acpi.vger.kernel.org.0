Return-Path: <linux-acpi+bounces-16725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A724B54EED
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F27C7061
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2535D30CDA1;
	Fri, 12 Sep 2025 13:11:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084A3019B2;
	Fri, 12 Sep 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682690; cv=none; b=lYkTcSLICQ3milAVdCMATA+IhHdVmsOl4aXtKmZjB4mmA7QIgaggfn3YAiqX+OflYOTmWTEXU18L3vehCt2DwTKMnE4Iz48ZxiXPZkkrgfRbMnQwmkgnU39JRqNUAjH4JtdfTnKNM2YcYT2/lsj3aLhXbYQXiuvXumZNfLPCv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682690; c=relaxed/simple;
	bh=+m5lD7IwF2dEqBxaX4aWCIx6v4ycCHdTpOnurxo6N4g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROj5Sv6pxH8o3J4jDAAtIJxk09CCI9qNDmZukU3rkGKOuOfmegl+/AFFakQwbzGgccaQE6/ThUOfihn3GjmQSNFvP6WYwN6I9ARJcjcHeAn9IcJzwfdwROJ+IJ/zaJtBAm2QQ+45oRrQJ2mwtiVA3j0dmXW/BN49sSVZoukfyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZXb5JGLz6GDFb;
	Fri, 12 Sep 2025 21:10:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E29FC1402A4;
	Fri, 12 Sep 2025 21:11:25 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:11:24 +0200
Date: Fri, 12 Sep 2025 14:11:23 +0100
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
Subject: Re: [PATCH v2 22/29] arm_mpam: Add helpers to allocate monitors
Message-ID: <20250912141123.000068e2@huawei.com>
In-Reply-To: <20250910204309.20751-23-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-23-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:43:02 +0000
James Morse <james.morse@arm.com> wrote:

> MPAM's MSC support a number of monitors, each of which supports
> bandwidth counters, or cache-storage-utilisation counters. To use
> a counter, a monitor needs to be configured. Add helpers to allocate
> and free CSU or MBWU monitors.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

One minor requested change inline that will probably otherwise get picked
up by someone's cleanup script

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/resctrl/mpam_devices.c  |  2 ++
>  drivers/resctrl/mpam_internal.h | 35 +++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index f536ebbcf94e..cf190f896de1 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -340,6 +340,8 @@ mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
>  	class->level = level_idx;
>  	class->type = type;
>  	INIT_LIST_HEAD_RCU(&class->classes_list);
> +	ida_init(&class->ida_csu_mon);
> +	ida_init(&class->ida_mbwu_mon);
>  
>  	list_add_rcu(&class->classes_list, &mpam_classes);
>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 326ba9114d70..81c4c2bfea3d 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -210,6 +210,9 @@ struct mpam_class {
>  	/* member of mpam_classes */
>  	struct list_head	classes_list;
>  
> +	struct ida		ida_csu_mon;
> +	struct ida		ida_mbwu_mon;
> +
>  	struct mpam_garbage	garbage;
>  };
>  
> @@ -288,6 +291,38 @@ struct mpam_msc_ris {
>  	struct mpam_garbage	garbage;
>  };
>  
> +static inline int mpam_alloc_csu_mon(struct mpam_class *class)
> +{
> +	struct mpam_props *cprops = &class->props;
> +
> +	if (!mpam_has_feature(mpam_feat_msmon_csu, cprops))
> +		return -EOPNOTSUPP;
> +
> +	return ida_alloc_range(&class->ida_csu_mon, 0, cprops->num_csu_mon - 1,
> +			       GFP_KERNEL);
> +}
> +
> +static inline void mpam_free_csu_mon(struct mpam_class *class, int csu_mon)
> +{
> +	ida_free(&class->ida_csu_mon, csu_mon);
> +}
> +
> +static inline int mpam_alloc_mbwu_mon(struct mpam_class *class)
> +{
> +	struct mpam_props *cprops = &class->props;
> +
> +	if (!mpam_has_feature(mpam_feat_msmon_mbwu, cprops))
> +		return -EOPNOTSUPP;
> +
> +	return ida_alloc_range(&class->ida_mbwu_mon, 0,
> +			       cprops->num_mbwu_mon - 1, GFP_KERNEL);

ida_alloc_max() - which is just a wrapper that sets the minimum to 0
but none the less perhaps conveys things slightly better.

> +}
> +
> +static inline void mpam_free_mbwu_mon(struct mpam_class *class, int mbwu_mon)
> +{
> +	ida_free(&class->ida_mbwu_mon, mbwu_mon);
> +}
> +
>  /* List of all classes - protected by srcu*/
>  extern struct srcu_struct mpam_srcu;
>  extern struct list_head mpam_classes;


