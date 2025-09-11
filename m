Return-Path: <linux-acpi+bounces-16673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D26B53529
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D07A7A51A1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A023225A24;
	Thu, 11 Sep 2025 14:22:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040B2367A0;
	Thu, 11 Sep 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600572; cv=none; b=rUJYO5iJ6Za0QVL9YzI9NAoR1PgctebRFK//IipbKGeBXynRO3PEtkUAlMrO3sFd9h3gjB/QkZl1J6BywGZPy7QS4yeoU6LzzGN6x6Sec+cAXl2ITnGRM0cZWtmkXPQH+QWRSYbdf7oszC0PKPPRe4Hk/QGBY4lW2ju1AYmW7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600572; c=relaxed/simple;
	bh=mijEeafRmhWE496Glh2QhH7og8eglLX5doEvUy4vZZo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l06XghBjoKO2ukk/qwRX3Oa0UeODgY97Xe6fYDCHzgl8X3tcKU7/OMwbg/7eyTuHODQlGq15sVzFuitKY7IPyEFqRkj6RNtnkp/gnhD58W7WWnRbguZhZcspIL6LQm+9I3EJ1ueP1VQpaQlr9gBuKe9lq9V8sr0PJYDavY19Ve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cN07p3l0xz6LD8G;
	Thu, 11 Sep 2025 22:20:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BCCE1402FE;
	Thu, 11 Sep 2025 22:22:46 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 16:22:45 +0200
Date: Thu, 11 Sep 2025 15:22:44 +0100
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
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component
 structures for firmware described ris
Message-ID: <20250911152244.000047db@huawei.com>
In-Reply-To: <20250910204309.20751-9-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-9-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:48 +0000
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
> Signed-off-by: James Morse <james.morse@arm.com>

Various minor things inline.

Biggest is I think maybe just moving to explicit reference counts
rather than using the empty list for that might end up easier to
read. Mostly because everyone knows what a kref_put() is about.

Obviously a bit pointless in practice, but I prefer not to think too
hard.


> ---
> Changes since v1:
>  * Fixed a comp/vmsc typo.
>  * Removed duplicate description from the commit message.
>  * Moved parenthesis in the add_to_garbage() macro.
>  * Check for out of range ris_idx when creating ris.
>  * Removed GFP as probe_lock is no longer a spin lock.
>  * Removed alloc flag as ended up searching the lists itself.
>  * Added a comment about affinity masks not overlapping.
> 
> Changes since RFC:
>  * removed a pr_err() debug message that crept in.
> ---
>  drivers/resctrl/mpam_devices.c  | 406 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  90 +++++++
>  include/linux/arm_mpam.h        |   8 +-
>  3 files changed, 493 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index efc4738e3b4d..c7f4981b3545 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -18,7 +18,6 @@
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/srcu.h>

Why does this include no longer make sense?


>  #include <linux/types.h>
>  
>  #include "mpam_internal.h"
> @@ -31,7 +30,7 @@
>  static DEFINE_MUTEX(mpam_list_lock);
>  static LIST_HEAD(mpam_all_msc);
>  
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;

...

> +/* List of all objects that can be free()d after synchronise_srcu() */
> +static LLIST_HEAD(mpam_garbage);
> +
> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)

Whilst this obviously works, I'd rather pass garbage to init_garbage
instead of the containing structure (where type varies)

> +
> +static struct mpam_vmsc *
> +mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	vmsc = kzalloc(sizeof(*vmsc), GFP_KERNEL);
> +	if (!vmsc)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(vmsc);
> +
> +	INIT_LIST_HEAD_RCU(&vmsc->ris);
> +	INIT_LIST_HEAD_RCU(&vmsc->comp_list);
> +	vmsc->comp = comp;
> +	vmsc->msc = msc;
> +
> +	list_add_rcu(&vmsc->comp_list, &comp->vmsc);
> +
> +	return vmsc;
> +}

> +static struct mpam_component *
> +mpam_component_get(struct mpam_class *class, int id)
> +{
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(comp, &class->components, class_list) {
> +		if (comp->comp_id == id)
> +			return comp;
> +	}
> +
> +	return mpam_component_alloc(class, id);
> +}

> +static struct mpam_class *
> +mpam_class_get(u8 level_idx, enum mpam_class_types type)
> +{
> +	bool found = false;
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		if (class->type == type && class->level == level_idx) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (found)
> +		return class;

Maybe this gets more complex later, but if it doesn't, just return class where you set
found above.  Matches with pattern used in mpam_component_get() above.


> +
> +	return mpam_class_alloc(level_idx, type);
> +}


> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
> +{
> +	struct mpam_vmsc *vmsc = ris->vmsc;
> +	struct mpam_msc *msc = vmsc->msc;
> +	struct platform_device *pdev = msc->pdev;
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
> +	add_to_garbage(ris);
> +	ris->garbage.pdev = pdev;
> +
> +	if (list_empty(&vmsc->ris))

See below. I think it is worth using an explicit reference count even
though that will only reach zero when the list is empty.

> +		mpam_vmsc_destroy(vmsc);
> +}


> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id)
> +{
> +	int err;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
> +		return -EINVAL;
> +
> +	if (test_and_set_bit(ris_idx, &msc->ris_idxs))
> +		return -EBUSY;
> +
> +	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
> +	if (!ris)
> +		return -ENOMEM;
> +	init_garbage(ris);
> +
> +	class = mpam_class_get(class_id, type);
> +	if (IS_ERR(class))
> +		return PTR_ERR(class);
> +
> +	comp = mpam_component_get(class, component_id);
> +	if (IS_ERR(comp)) {
> +		if (list_empty(&class->components))
> +			mpam_class_destroy(class);

Maybe just reference count the classes with a kref and do a put here?

> +		return PTR_ERR(comp);
> +	}
> +
> +	vmsc = mpam_vmsc_get(comp, msc);
> +	if (IS_ERR(vmsc)) {
> +		if (list_empty(&comp->vmsc))
> +			mpam_comp_destroy(comp);
Similar to classes I wonder if simple reference counting is cleaner.
> +		return PTR_ERR(vmsc);
> +	}
> +
> +	err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
> +	if (err) {
> +		if (list_empty(&vmsc->ris))

and here as well.

> +			mpam_vmsc_destroy(vmsc);
> +		return err;
> +	}
> +
> +	ris->ris_idx = ris_idx;
> +	INIT_LIST_HEAD_RCU(&ris->vmsc_list);
> +	ris->vmsc = vmsc;
> +
> +	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
> +	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
> +
> +	return 0;
> +}

>  /*
>   * An MSC can control traffic from a set of CPUs, but may only be accessible
>   * from a (hopefully wider) set of CPUs. The common reason for this is power
> @@ -74,10 +469,10 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>  		return;
>  
>  	mutex_lock(&mpam_list_lock);
> -	platform_set_drvdata(pdev, NULL);
> -	list_del_rcu(&msc->all_msc_list);
> -	synchronize_srcu(&mpam_srcu);
> +	mpam_msc_destroy(msc);

I'd suggest introducing mpam_msc_destroy() in the earlier patch. Doesn't make a huge
difference but 2 out of 3 things removed here would be untouched if you do that.

>  	mutex_unlock(&mpam_list_lock);
> +
> +	mpam_free_garbage();
>  }




