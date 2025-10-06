Return-Path: <linux-acpi+bounces-17634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861CBBFC1F
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD06D34BF21
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7D20E030;
	Mon,  6 Oct 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2gBuEGO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78715667D
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792447; cv=none; b=avETHd2uPOTXI7cstC2Yw8a1S/AxRV0JqkLfCYDfwOurHw3720rmMqPmoER4z29TV7LOKzSxuWYc2bd6buK+6m0+X2tUYfKdCpYJ9fap6NmnwRaW+plIkH/gy+o+L1pBSYt5XNLqvLd5JxCx8qDNrw4GaXPeqXv+XQxzUli834Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792447; c=relaxed/simple;
	bh=Xl545wk4mPFC4jifhX643nWXCQAU95Jb0AktXtK6wSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXhLK0kPaxLYQmsHqDwAEUrFdy27RmX0O+m7iMoiJXjNOLjGLPS6S8uHqg/fNnVAmpg5Z8e0KuKJCTJcFbWzSLEtZ5Ax+nE4JJaVaBZSqNUW0/yCWCIakZbi3p14oUr3uI7JjD9HQbRgubvmOpJpJV8KbT15lL+F5TSqyGN0bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2gBuEGO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759792442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa+MpMZ/lZINzLZIETNTAi0oCbySu53dxn0/NP0jrXs=;
	b=X2gBuEGONjLER4vrsNyngNiZnsrHm/3BBWAMD1wuiCJ4Kp5NuodnTzFd3IZtPzT/GJU0xc
	3E0MOGBWPYvKtFzGMVJYfyEtK3hIUtGGdLFGIf1r8pMI5WYwSHnD6CqCTLdr/eWFGGwY3X
	yputXIIWhLamfuCVa/vRzEr2jaKTix0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-UM4chBFpOE6jnVuCSczrOA-1; Mon, 06 Oct 2025 19:14:00 -0400
X-MC-Unique: UM4chBFpOE6jnVuCSczrOA-1
X-Mimecast-MFC-AGG-ID: UM4chBFpOE6jnVuCSczrOA_1759792439
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso5448100a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 16:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792439; x=1760397239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oa+MpMZ/lZINzLZIETNTAi0oCbySu53dxn0/NP0jrXs=;
        b=d+RnXoD1nsudArJOJ310zRw7jKG1ti6tYXVbs2rwqe9FrqFiB2+eRGvnW77XQBd5Ca
         yidqGtHCXi6cgaBMX9ztHzgS0/s3tv7oKJSIfa3pW+IOX+jgMdkix9/BhT/hTYSMnAYj
         TABTUV+CacisS8nj+22nOBhmjEbOAWW6kNe319tRDYMZ5deADRPDyeuayqDxZ0FVQe1/
         b9GDprq/9fqCUNysAZHpP0R/0FWaOi3ePJi12QicUUyQykPDAginiwZjdBh/l/+AYmRI
         6iWkMzV+1egcebJctIjcnIJu+D3Syzhy7jbfQEI9vi1Dl58CKNE0wsQ43wbsTsD0VPMz
         oszA==
X-Forwarded-Encrypted: i=1; AJvYcCVPWw58ODnH1DEieBnQxXDipkcns4uZMRXDF9bfXEHvLVqPMHsUySy0/BY078kJHTgOLcjk8qAOGYYg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+PQ8AvNUM2CLf2NhJMlbCCoy3tSFfHpjSICEeS7QsOEkcFzX
	wbvvVOAkYJo5p0KWM4vRjIgr5PtGCj8/g1MlWhEGbt8mZo+j521qcEPyenH6FLJojI24EckzGr6
	muewMX729cA6CD4t72ekO8sZnuBHeUl3PJTQFEQ+diG9BnpAtKzr/AeHHfGL+eZw=
X-Gm-Gg: ASbGnct/z5vnIQnZhyKzKVHRGHRf3sRq65sBMcuHDC9IDthaYuG8TGkhBk+lxqt+EXL
	sfnSbejjKJbFEHdC10QHWgCOns2IQxfuJPjFthe24RCUYzpAwxykN7CjBjcD4jfkzWeN8iGZIbc
	b38EbFPp1/FgOX8AuKwZDNCDR6J2R8QC4nGDHNuC1gCNwvbO4570ipcXgAgYVtWsvW/l3rNOCos
	U6Dq9E38KpXU2we1uWpD92XBu5FS0KNOoc/sFV2mEaT5/88hJW+JO8eiNW5yeRHu9ngdY5B+7Cw
	k4x9CZFyZytK7CCOHSdQEXt6rgoFoani2mxAmWlk986TYPwo30v67lqr5aQEOfHNZR/wh7UF8dS
	COAYvDpdPug==
X-Received: by 2002:a17:90b:2707:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-339c273dbd2mr19824931a91.12.1759792438587;
        Mon, 06 Oct 2025 16:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCL9CIIP6ShRGT6w3b9IqDb9kzjTE57UQdsNLLOzB4RcN2VETVeYXKpuWTODjQnmcyM1Q1NQ==
X-Received: by 2002:a17:90b:2707:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-339c273dbd2mr19824876a91.12.1759792437961;
        Mon, 06 Oct 2025 16:13:57 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee8d2aeasm247777a91.2.2025.10.06.16.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:13:57 -0700 (PDT)
Message-ID: <a66c6df0-f5e7-4704-a341-d34d07b8c6e1@redhat.com>
Date: Tue, 7 Oct 2025 09:13:43 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-9-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/11/25 6:42 AM, James Morse wrote:
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
> ---
> Changes since v1:
>   * Fixed a comp/vmsc typo.
>   * Removed duplicate description from the commit message.
>   * Moved parenthesis in the add_to_garbage() macro.
>   * Check for out of range ris_idx when creating ris.
>   * Removed GFP as probe_lock is no longer a spin lock.
>   * Removed alloc flag as ended up searching the lists itself.
>   * Added a comment about affinity masks not overlapping.
> 
> Changes since RFC:
>   * removed a pr_err() debug message that crept in.
> ---
>   drivers/resctrl/mpam_devices.c  | 406 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  90 +++++++
>   include/linux/arm_mpam.h        |   8 +-
>   3 files changed, 493 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index efc4738e3b4d..c7f4981b3545 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -18,7 +18,6 @@
>   #include <linux/printk.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> -#include <linux/srcu.h>
>   #include <linux/types.h>
>   
>   #include "mpam_internal.h"
> @@ -31,7 +30,7 @@
>   static DEFINE_MUTEX(mpam_list_lock);
>   static LIST_HEAD(mpam_all_msc);
>   
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;
>   
>   /*
>    * Number of MSCs that have been probed. Once all MSC have been probed MPAM
> @@ -39,6 +38,402 @@ static struct srcu_struct mpam_srcu;
>    */
>   static atomic_t mpam_num_msc;
>   
> +/*
> + * An MSC is a physical container for controls and monitors, each identified by
> + * their RIS index. These share a base-address, interrupts and some MMIO
> + * registers. A vMSC is a virtual container for RIS in an MSC that control or
> + * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
> + * not all RIS in an MSC share a vMSC.
> + * Components are a group of vMSC that control or monitor the same thing but
> + * are from different MSC, so have different base-address, interrupts etc.
> + * Classes are the set components of the same type.
> + *
> + * The features of a vMSC is the union of the RIS it contains.
> + * The features of a Class and Component are the common subset of the vMSC
> + * they contain.
> + *
> + * e.g. The system cache may have bandwidth controls on multiple interfaces,
> + * for regulating traffic from devices independently of traffic from CPUs.
> + * If these are two RIS in one MSC, they will be treated as controlling
> + * different things, and will not share a vMSC/component/class.
> + *
> + * e.g. The L2 may have one MSC and two RIS, one for cache-controls another
> + * for bandwidth. These two RIS are members of the same vMSC.
> + *
> + * e.g. The set of RIS that make up the L2 are grouped as a component. These
> + * are sometimes termed slices. They should be configured the same, as if there
> + * were only one.
> + *
> + * e.g. The SoC probably has more than one L2, each attached to a distinct set
> + * of CPUs. All the L2 components are grouped as a class.
> + *
> + * When creating an MSC, struct mpam_msc is added to the all mpam_all_msc list,
> + * then linked via struct mpam_ris to a vmsc, component and class.
> + * The same MSC may exist under different class->component->vmsc paths, but the
> + * RIS index will be unique.
> + */
> +LIST_HEAD(mpam_classes);
> +
> +/* List of all objects that can be free()d after synchronise_srcu() */
> +static LLIST_HEAD(mpam_garbage);
> +
> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
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
> +
> +static struct mpam_vmsc *mpam_vmsc_get(struct mpam_component *comp,
> +				       struct mpam_msc *msc)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		if (vmsc->msc->id == msc->id)
> +			return vmsc;
> +	}
> +
> +	return mpam_vmsc_alloc(comp, msc);
> +}
> +
> +static struct mpam_component *
> +mpam_component_alloc(struct mpam_class *class, int id)
> +{
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	comp = kzalloc(sizeof(*comp), GFP_KERNEL);
> +	if (!comp)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(comp);
> +
> +	comp->comp_id = id;
> +	INIT_LIST_HEAD_RCU(&comp->vmsc);
> +	/* affinity is updated when ris are added */
> +	INIT_LIST_HEAD_RCU(&comp->class_list);
> +	comp->class = class;
> +
> +	list_add_rcu(&comp->class_list, &class->components);
> +
> +	return comp;
> +}
> +
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
> +
> +static struct mpam_class *
> +mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
> +{
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	class = kzalloc(sizeof(*class), GFP_KERNEL);
> +	if (!class)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(class);
> +
> +	INIT_LIST_HEAD_RCU(&class->components);
> +	/* affinity is updated when ris are added */
> +	class->level = level_idx;
> +	class->type = type;
> +	INIT_LIST_HEAD_RCU(&class->classes_list);
> +
> +	list_add_rcu(&class->classes_list, &mpam_classes);
> +
> +	return class;
> +}
> +
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
> +
> +	return mpam_class_alloc(level_idx, type);
> +}
> +

The variable @found can be avoided if the found class can be returned immediately.

	list_for_each_entry(class, &mpam_classes, classes_list) {
		if (class->type == type && class->level == level_idx)
			return class;
	}

	return mpam_class_alloc(level_idx, type);

> +#define add_to_garbage(x)				\
> +do {							\
> +	__typeof__(x) _x = (x);				\
> +	_x->garbage.to_free = _x;			\
> +	llist_add(&_x->garbage.llist, &mpam_garbage);	\
> +} while (0)
> +
> +static void mpam_class_destroy(struct mpam_class *class)
> +{
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&class->classes_list);
> +	add_to_garbage(class);
> +}
> +
> +static void mpam_comp_destroy(struct mpam_component *comp)
> +{
> +	struct mpam_class *class = comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&comp->class_list);
> +	add_to_garbage(comp);
> +
> +	if (list_empty(&class->components))
> +		mpam_class_destroy(class);
> +}
> +
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
> +		mpam_vmsc_destroy(vmsc);
> +}
> +
> +/*
> + * There are two ways of reaching a struct mpam_msc_ris. Via the
> + * class->component->vmsc->ris, or via the msc.
> + * When destroying the msc, the other side needs unlinking and cleaning up too.
> + */
> +static void mpam_msc_destroy(struct mpam_msc *msc)
> +{
> +	struct platform_device *pdev = msc->pdev;
> +	struct mpam_msc_ris *ris, *tmp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
> +		mpam_ris_destroy(ris);
> +
> +	list_del_rcu(&msc->all_msc_list);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	add_to_garbage(msc);
> +	msc->garbage.pdev = pdev;
> +}
> +
> +static void mpam_free_garbage(void)
> +{
> +	struct mpam_garbage *iter, *tmp;
> +	struct llist_node *to_free = llist_del_all(&mpam_garbage);
> +
> +	if (!to_free)
> +		return;
> +
> +	synchronize_srcu(&mpam_srcu);
> +
> +	llist_for_each_entry_safe(iter, tmp, to_free, llist) {
> +		if (iter->pdev)
> +			devm_kfree(&iter->pdev->dev, iter->to_free);
> +		else
> +			kfree(iter->to_free);
> +	}
> +}
> +
> +/*
> + * The cacheinfo structures are only populated when CPUs are online.
> + */
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity)
> +{
> +	return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
> +}
> +
> +/*
> + * cpumask_of_node() only knows about online CPUs. This can't tell us whether
> + * a class is represented on all possible CPUs.
> + */
> +static void get_cpumask_from_node_id(u32 node_id, cpumask_t *affinity)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (node_id == cpu_to_node(cpu))
> +			cpumask_set_cpu(cpu, affinity);
> +	}
> +}
> +
> +static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
> +				 enum mpam_class_types type,
> +				 struct mpam_class *class,
> +				 struct mpam_component *comp)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case MPAM_CLASS_CACHE:
> +		err = mpam_get_cpumask_from_cache_id(comp->comp_id, class->level,
> +						     affinity);
> +		if (err)
> +			return err;
> +
> +		if (cpumask_empty(affinity))
> +			pr_warn_once("%s no CPUs associated with cache node",
> +				     dev_name(&msc->pdev->dev));
> +
> +		break;

"\n" missed in the error message and dev_warn_once() can be used:

		if (cpumask_empty(affinity))
			dev_warn_once(&msc->pdev->dev, "No CPUs associated with cache node\n");

> +	case MPAM_CLASS_MEMORY:
> +		get_cpumask_from_node_id(comp->comp_id, affinity);
> +		/* affinity may be empty for CPU-less memory nodes */
> +		break;
> +	case MPAM_CLASS_UNKNOWN:
> +		return 0;
> +	}
> +
> +	cpumask_and(affinity, affinity, &msc->accessibility);
> +
> +	return 0;
> +}
> +
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
> +		return PTR_ERR(comp);
> +	}
> +
> +	vmsc = mpam_vmsc_get(comp, msc);
> +	if (IS_ERR(vmsc)) {
> +		if (list_empty(&comp->vmsc))
> +			mpam_comp_destroy(comp);
> +		return PTR_ERR(vmsc);
> +	}
> +
> +	err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
> +	if (err) {
> +		if (list_empty(&vmsc->ris))
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
> +
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id)
> +{
> +	int err;
> +
> +	mutex_lock(&mpam_list_lock);
> +	err = mpam_ris_create_locked(msc, ris_idx, type, class_id,
> +				     component_id);
> +	mutex_unlock(&mpam_list_lock);
> +	if (err)
> +		mpam_free_garbage();
> +
> +	return err;
> +}
> +
>   /*
>    * An MSC can control traffic from a set of CPUs, but may only be accessible
>    * from a (hopefully wider) set of CPUs. The common reason for this is power
> @@ -74,10 +469,10 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   		return;
>   
>   	mutex_lock(&mpam_list_lock);
> -	platform_set_drvdata(pdev, NULL);
> -	list_del_rcu(&msc->all_msc_list);
> -	synchronize_srcu(&mpam_srcu);
> +	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
> +
> +	mpam_free_garbage();
>   }
>   
>   static int mpam_msc_drv_probe(struct platform_device *pdev)
> @@ -95,6 +490,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>   			err = -ENOMEM;
>   			break;
>   		}
> +		init_garbage(msc);
>   
>   		mutex_init(&msc->probe_lock);
>   		mutex_init(&msc->part_sel_lock);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 7c63d590fc98..02e9576ece6b 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -7,10 +7,29 @@
>   #include <linux/arm_mpam.h>
>   #include <linux/cpumask.h>
>   #include <linux/io.h>
> +#include <linux/llist.h>
>   #include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
>   #include <linux/resctrl.h>
>   #include <linux/sizes.h>
> +#include <linux/srcu.h>
> +
> +#define MPAM_MSC_MAX_NUM_RIS	16
> +
> +/*
> + * Structures protected by SRCU may not be freed for a surprising amount of
> + * time (especially if perf is running). To ensure the MPAM error interrupt can
> + * tear down all the structures, build a list of objects that can be gargbage
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
>   
>   struct mpam_msc {
>   	/* member of mpam_all_msc */
> @@ -57,8 +76,79 @@ struct mpam_msc {
>   
>   	void __iomem		*mapped_hwpage;
>   	size_t			mapped_hwpage_sz;
> +
> +	struct mpam_garbage	garbage;
>   };
>   
> +struct mpam_class {
> +	/* mpam_components in this class */
> +	struct list_head	components;
> +
> +	cpumask_t		affinity;
> +
> +	u8			level;
> +	enum mpam_class_types	type;
> +
> +	/* member of mpam_classes */
> +	struct list_head	classes_list;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_component {
> +	u32			comp_id;
> +
> +	/* mpam_vmsc in this component */
> +	struct list_head	vmsc;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_class:components */
> +	struct list_head	class_list;
> +
> +	/* parent: */
> +	struct mpam_class	*class;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_vmsc {
> +	/* member of mpam_component:vmsc_list */
> +	struct list_head	comp_list;
> +
> +	/* mpam_msc_ris in this vmsc */
> +	struct list_head	ris;
> +
> +	/* All RIS in this vMSC are members of this MSC */
> +	struct mpam_msc		*msc;
> +
> +	/* parent: */
> +	struct mpam_component	*comp;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_msc_ris {
> +	u8			ris_idx;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_vmsc:ris */
> +	struct list_head	vmsc_list;
> +
> +	/* member of mpam_msc:ris */
> +	struct list_head	msc_list;
> +
> +	/* parent: */
> +	struct mpam_vmsc	*vmsc;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +/* List of all classes - protected by srcu*/
> +extern struct srcu_struct mpam_srcu;
> +extern struct list_head mpam_classes;
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index 3d6c39c667c3..3206f5ddc147 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -38,11 +38,7 @@ static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
>   static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
>   #endif
>   
> -static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> -				  enum mpam_class_types type, u8 class_id,
> -				  int component_id)
> -{
> -	return -EINVAL;
> -}
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id);
>   
>   #endif /* __LINUX_ARM_MPAM_H */

Thanks,
Gavin


