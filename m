Return-Path: <linux-acpi+bounces-18195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248AC07640
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488C91B87EE0
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40231D74E;
	Fri, 24 Oct 2025 16:47:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C7F9C1;
	Fri, 24 Oct 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324441; cv=none; b=Zk0/mJ1B/CJLF5/JFptuoaa7KyLGBJJvJjI7wG+Z0DzIaUWHEQsl3Iu1XNM2hy04fSLytlJk/PS/hduyO5WL0QWC2uN4Bw4MpThPuMUHcIcyA/h1fON2obqE6iXX+rSSo0FuRPZSXIT4EdEIHVG6sGpp6TtoaaEsMJvNFZQI9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324441; c=relaxed/simple;
	bh=1DlT732Q4g9Q7JvygNsAztbcORNBus7wT5QEd/JJuNE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTei48lag+SrIPiBxDGSsoJq8vZFmBj2CPJvvI+dxktb2qdLsR0UwZjxOPhY6wu6zphbdxNKjKQBz2yLc+KWSwmH5X1fbKVJ0aQfavAgW3aqOHbOnD5v4E7bqhqC01M9gfD/oXHD9YQ8JgE6MncmYVXnB1uD/eWEhJ/A/mJkhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctTHS0tZKz6M4Yg;
	Sat, 25 Oct 2025 00:43:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CC4F14010C;
	Sat, 25 Oct 2025 00:47:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:47:14 +0100
Date: Fri, 24 Oct 2025 17:47:12 +0100
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
Subject: Re: [PATCH v3 08/29] arm_mpam: Add the class and component
 structures for firmware described ris
Message-ID: <20251024174712.000051b6@huawei.com>
In-Reply-To: <20251017185645.26604-9-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-9-james.morse@arm.com>
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

n Fri, 17 Oct 2025 18:56:24 +0000
James Morse <james.morse@arm.com> wrote:

> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the system.
> Others are discovered when the driver probes the hardware.
> 
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which
> are visible to user-space as there are likely to be multiple instances
> of the L2 cache. (e.g. one per cluster or package)
> 
> Add support for creating and destroying structures to allow a hierarchy
> of resources to be created.
> 
> CC: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
A few minor things inline.  Mostly code ordering related to make
it easier to review!

> ---
>  drivers/resctrl/mpam_devices.c  | 390 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  93 ++++++++
>  include/linux/arm_mpam.h        |   8 +-
>  3 files changed, 483 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index d18eeec95f79..8685e50f08c6 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -30,7 +30,7 @@
>  static DEFINE_MUTEX(mpam_list_lock);
>  static LIST_HEAD(mpam_all_msc);
>  
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;

Meh. Others may be fussier about this but I'd rather you just
added the extern when this was first introduced and didn't
have this churn here.


> +static void mpam_vmsc_destroy(struct mpam_vmsc *vmsc)
> +{
> +	struct mpam_component *comp = vmsc->comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&vmsc->comp_list);
> +	add_to_garbage(vmsc);
> +
> +	if (list_empty(&comp->vmsc))
> +		mpam_comp_destroy(comp);
> +}
> +
> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
I'd rather see the create / destroy next to each other if possible.
Makes it easier to check this unwinds the creat path.

> +{
> +	struct mpam_vmsc *vmsc = ris->vmsc;
> +	struct mpam_msc *msc = vmsc->msc;
> +	struct mpam_component *comp = vmsc->comp;
> +	struct mpam_class *class = comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	/*
> +	 * It is assumed affinities don't overlap. If they do the class becomes
> +	 * unusable immediately.
> +	 */
> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> +	clear_bit(ris->ris_idx, &msc->ris_idxs);
> +	list_del_rcu(&ris->vmsc_list);
> +	list_del_rcu(&ris->msc_list);
Can you reorder these so that they are reverse of what happens in create path?
Makes not real difference other than slightly easier to check everything is done.
Right now I'm failing to spot where this was added to ris->msc_list in the
create path.


> +	add_to_garbage(ris);
> +
> +	if (list_empty(&vmsc->ris))
> +		mpam_vmsc_destroy(vmsc);
> +}
> +

> +
> +/*
> + * The cacheinfo structures are only populated when CPUs are online.
> + * This helper walks the device tree to include offline CPUs too.

Comment stale?  It does walk a tree of devices but I'm not sure that's
what people will read device tree as meaning.

> + */
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity)
> +{
> +	return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
> +}

> +
> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id)
> +{
...

> +	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
> +	if (!ris)
> +		return -ENOMEM;
> +	init_garbage(&ris->garbage);
> +	ris->garbage.pdev = pdev;
I wonder if it's cleaner to just pass the pdev (sometimes null) in
as a parameter to init_garbage()
> +
> +	class = mpam_class_find(class_id, type);
> +	if (IS_ERR(class))
> +		return PTR_ERR(class);



> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 6ac75f3613c3..1a5d96660382 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h

> +/*
> + * Structures protected by SRCU may not be freed for a surprising amount of
> + * time (especially if perf is running). To ensure the MPAM error interrupt can
> + * tear down all the structures, build a list of objects that can be gargbage

Spell check.  garbage

> + * collected once synchronize_srcu() has returned.
> + * If pdev is non-NULL, use devm_kfree().
> + */
> +struct mpam_garbage {
> +	/* member of mpam_garbage */
> +	struct llist_node	llist;
> +
> +	void			*to_free;
> +	struct platform_device	*pdev;
> +};


