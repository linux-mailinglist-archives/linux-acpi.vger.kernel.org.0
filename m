Return-Path: <linux-acpi+bounces-18688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EBC43693
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1994E1967
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D46FC5;
	Sun,  9 Nov 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnMfK9Vx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Spt2Euks"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204E3FF1
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762646898; cv=none; b=UW5O1EJA7C2JHCzx5PfBIdMZiw0+cs6MgXoH44B/fXKXOXP+lhRddGBFSFYQ/NyuisnF3CID7Db7brQqj4XclRGQ5OpLVbz6hzLdf0Qu1g3UUTYXULPC7tATTUUul4xb7nMFH33t0eOcji+gk+oh2/ierwT6ORWZoqzqoyJZg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762646898; c=relaxed/simple;
	bh=4j8FzNeIM/7MrPyGBVtwXf3bNQW0X6thuKidu9/xrt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozAqANS4OuWyPLG4AOcGUH90WhyE1BvdMT+YQxIYvYCPZIEERjbgj46LLkrL1wJI61knDb1kGkhm0HkV9nM4JgpN7MfbQ7Upx3jS8V6N/hcGcrb3PN+yHdeMJvrSRw6cuFCIaoDXSRZj7PuVntGJSZT3LR88P7ZX4bUEJ8nqtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnMfK9Vx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Spt2Euks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6jfxB5NmaQjmcaHj7yJyMHGfb1WcngUkm2x4e1l5I=;
	b=RnMfK9Vx/shuEFDRvv7z+wkUA52sxqhr4m81/mXAGGiT3QDNJndRtnX/mBl+eZiPp+byQa
	Uqki15jszuXyTu0rR4ZrHVAeeWWcQITidfyjOeImwW59Yu/VsPY+h8E5A0WRguG4oE72DG
	bn6y20A41QFSEp26HWt1U1wSjYAThpw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-QoU_7QsrOkG-8l2w_-w25g-1; Sat, 08 Nov 2025 19:08:12 -0500
X-MC-Unique: QoU_7QsrOkG-8l2w_-w25g-1
X-Mimecast-MFC-AGG-ID: QoU_7QsrOkG-8l2w_-w25g_1762646892
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a153ba0009so4341425b3a.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2025 16:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762646892; x=1763251692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT6jfxB5NmaQjmcaHj7yJyMHGfb1WcngUkm2x4e1l5I=;
        b=Spt2EuksbzNEani5YJle+Nue62vczC3Yls20PssYvuVyvNfAwTKxAXTKRGJv+xasjl
         TCKnwHNmFpBWhPRPzA7OrLB/askTavn9cOMowDAKfDR9LjI9ecCshhWYq9bUtIKONnNn
         sREgbNxvG22j5aDlrdpmAhE1UIuGWPMpjKwwcK46IV4HbXcLUhNyaooOKSbFkDdQGnCS
         4UWLX9ZDsx4NInLQtFXQJDG+fy2wUVABloSmBsIUh9txEW9wqiyQ5TSjLbhmq9tFQHhM
         mADrTo0E/D8HIKZuhCZdNFN0XK52CLh9iH55NkmIus3312u/eXKHwU3mVpFcJAW/fV58
         dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762646892; x=1763251692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT6jfxB5NmaQjmcaHj7yJyMHGfb1WcngUkm2x4e1l5I=;
        b=eOQYY7ccYlOBcuPDL3eGvr1BBe46MK36gMODgRNcSLINQIHeMeoD3ANTd38NzkAxd9
         mPdy9ySfnO0OjleuottCmLHOl3UK8E3XJ/cSWpVYcoiz8EZi5p7nVmG11a9vrU7wDA4S
         NRXPNN6vpAZOf+yLfZCvvgTWBiosGrA/nHlRYZRtQxjMkyoSC2A2qzTfxt/X1T5plKMx
         J9YPYQPrUMC9WYiB9a7dP7punvHDtdnaZVI6KLH3oC2TKZW8VDa1EtHiIaHqVu6HB2tz
         kI+SIb85aYMM/6oCBeqcE6fa1kBBmX6zJCvhqFW56lrKG1aQj2CCm0nEiKE/XvtcQxtj
         k/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUNqJ0TwovlMxI2d0TbYoKNS9p0vDMgxfFgm60yomuLKULbZPt2Fbqj+SZ0ciuET7bsqHtvU8ZQc4hh@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFzT7dZOGsCpF0LXuEqUPOwJrlk1wYh7oY6KK2XelotipaSdz
	od3rC9v8pcdPab/CP88feoO4kpDHoP46ucBmGTguaJXSODIGoT490DEKspW9zPmmBjfkGl7Pcql
	B2mvlhMEvObykCXxpGqwPn/NpoRFQet5bxZGcc01K/dVbH+5lJZhkXsa7BHCqXWA=
X-Gm-Gg: ASbGncuovgOLA/nLZHOmZ2sm+HiaOYDMpk8yA6c5URyzwEv4NWdYqoQpKefqEwtAqIi
	3f/F8Z75ehxg27N/j1Oh1lASfVlmcSaObnzILfdBA716ZoA3RMziZTG6IqE4HMgtSqXeO0B4TMa
	hMdEwxf43b+tMWo7JRyoEnAnTvXZTBTeP/2iH8wW+wfdiac/KFLa/esCKHHct+WQFTvx8Fu9yhW
	l4K6xajNVX4d9dKB0cOQahNca5mxvNbl3mYAlbxsAPOXBN50+NbsoL0fdBHpRERCMv9i8QFYAeJ
	z2/bzk2fSOKYxX1LgB6us/5Q375GLvSk3WrCZ++1yw3odriS9wyD4a2g6zlixk5977yVtorNPqx
	UR/4DFiSdoFF+JdHByoF7mA42nAwSls/56vA1vYI=
X-Received: by 2002:a05:6a20:7fa9:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-353a43902b7mr5204446637.56.1762646891683;
        Sat, 08 Nov 2025 16:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1q+db/fkJietwlL/Prar50RZNUCwTE34Ueos7Upb4KE0XScpVAUszqOaYX3up7r2Ib6Q/4Q==
X-Received: by 2002:a05:6a20:7fa9:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-353a43902b7mr5204415637.56.1762646891234;
        Sat, 08 Nov 2025 16:08:11 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed21desm9048758a12.11.2025.11.08.16.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:08:10 -0800 (PST)
Message-ID: <2c81664f-45c0-43e4-91e9-79d0c84376b6@redhat.com>
Date: Sun, 9 Nov 2025 10:07:57 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-12-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
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
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Jonathan:
> Code reordering.
> Comments.
> ---
>   drivers/resctrl/mpam_devices.c  | 393 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  94 ++++++++
>   include/linux/arm_mpam.h        |   5 +
>   3 files changed, 491 insertions(+), 1 deletion(-)
> 

Some minor comments below and some of them may be invalid. Nothing really
looks incorrect to me:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 6c6be133d73a..48a344d5cb43 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -36,6 +36,384 @@ struct srcu_struct mpam_srcu;
>    */
>   static atomic_t mpam_num_msc;
>   
> +/*
> + * An MSC is a physical container for controls and monitors, each identified by
> + * their RIS index. These share a base-address, interrupts and some MMIO
> + * registers. A vMSC is a virtual container for RIS in an MSC that control or
> + * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
> + * not all RIS in an MSC share a vMSC.

s/a virtual container for RIS/a virtual container for RISes
s/all RIS/all RISes

An empty line may be needed here as paragraph separator.

> + * Components are a group of vMSC that control or monitor the same thing but
> + * are from different MSC, so have different base-address, interrupts etc.
> + * Classes are the set components of the same type.
> + *
> + * The features of a vMSC is the union of the RIS it contains.
> + * The features of a Class and Component are the common subset of the vMSC
> + * they contain.
> + *

s/the RIS/the RISes

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
> +static inline void init_garbage(struct mpam_garbage *garbage)
> +{
> +	init_llist_node(&garbage->llist);
> +}
> +
> +#define add_to_garbage(x)				\
> +do {							\
> +	__typeof__(x) _x = (x);				\
> +	_x->garbage.to_free = _x;			\
> +	llist_add(&_x->garbage.llist, &mpam_garbage);	\
> +} while (0)
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
> +	init_garbage(&vmsc->garbage);
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
> +static void mpam_component_destroy(struct mpam_component *comp);
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
> +		mpam_component_destroy(comp);
> +}
> +
> +static struct mpam_vmsc *
> +mpam_vmsc_find(struct mpam_component *comp, struct mpam_msc *msc)
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
> +	init_garbage(&comp->garbage);
> +
> +	comp->comp_id = id;
> +	INIT_LIST_HEAD_RCU(&comp->vmsc);
> +	/* affinity is updated when ris are added */

	/* Affinity is updated when RIS is added */

> +	INIT_LIST_HEAD_RCU(&comp->class_list);
> +	comp->class = class;
> +
> +	list_add_rcu(&comp->class_list, &class->components);
> +
> +	return comp;
> +}
> +
> +static void mpam_class_destroy(struct mpam_class *class);
> +
> +static void mpam_component_destroy(struct mpam_component *comp)
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
> +static struct mpam_component *
> +mpam_component_find(struct mpam_class *class, int id)
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
> +	init_garbage(&class->garbage);
> +
> +	INIT_LIST_HEAD_RCU(&class->components);
> +	/* affinity is updated when ris are added */

	/* Affinity is updated when RIS is added */

> +	class->level = level_idx;
> +	class->type = type;
> +	INIT_LIST_HEAD_RCU(&class->classes_list);
> +
> +	list_add_rcu(&class->classes_list, &mpam_classes);
> +
> +	return class;
> +}
> +
> +static void mpam_class_destroy(struct mpam_class *class)
> +{
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&class->classes_list);
> +	add_to_garbage(class);
> +}
> +
> +static struct mpam_class *
> +mpam_class_find(u8 level_idx, enum mpam_class_types type)
> +{
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		if (class->type == type && class->level == level_idx)
> +			return class;
> +	}
> +
> +	return mpam_class_alloc(level_idx, type);
> +}
> +
> +/*
> + * The cacheinfo structures are only populated when CPUs are online.
> + * This helper walks the acpi tables to include offline CPUs too.
> + */
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity)
> +{
> +	return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
> +}
> +

This function is only used in mpam_devices.c and won't be exposed in the
future, we can make it 'static' and 'inline'.

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

It's worthy to add a warning message here.

> +
> +		if (cpumask_empty(affinity))
> +			dev_warn_once(&msc->pdev->dev,
> +				      "no CPUs associated with cache node\n");

{} is needed here.

> +
> +		break;
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
> +	struct platform_device *pdev = msc->pdev;
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
> +	init_garbage(&ris->garbage);
> +	ris->garbage.pdev = pdev;
> +
> +	class = mpam_class_find(class_id, type);
> +	if (IS_ERR(class))
> +		return PTR_ERR(class);
> +
> +	comp = mpam_component_find(class, component_id);
> +	if (IS_ERR(comp)) {
> +		if (list_empty(&class->components))
> +			mpam_class_destroy(class);
> +		return PTR_ERR(comp);
> +	}
> +
> +	vmsc = mpam_vmsc_find(comp, msc);
> +	if (IS_ERR(vmsc)) {
> +		if (list_empty(&comp->vmsc))
> +			mpam_component_destroy(comp);
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
> +	INIT_LIST_HEAD_RCU(&ris->msc_list);
> +	INIT_LIST_HEAD_RCU(&ris->vmsc_list);
> +	ris->vmsc = vmsc;
> +
> +	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
> +	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
> +	list_add_rcu(&ris->msc_list, &msc->ris);
> +
> +	return 0;
> +}
> +
> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
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
> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> +	clear_bit(ris->ris_idx, &msc->ris_idxs);
> +	list_del_rcu(&ris->msc_list);
> +	list_del_rcu(&ris->vmsc_list);
> +	add_to_garbage(ris);
> +
> +	if (list_empty(&vmsc->ris))
> +		mpam_vmsc_destroy(vmsc);
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
> @@ -60,14 +438,25 @@ static int update_msc_accessibility(struct mpam_msc *msc)
>   
>   static int fw_num_msc;
>   
> +/*
> + * There are two ways of reaching a struct mpam_msc_ris. Via the
> + * class->component->vmsc->ris, or via the msc.
> + * When destroying the msc, the other side needs unlinking and cleaning up too.
> + */
>   static void mpam_msc_destroy(struct mpam_msc *msc)
>   {
>   	struct platform_device *pdev = msc->pdev;
> +	struct mpam_msc_ris *ris, *tmp;
>   
>   	lockdep_assert_held(&mpam_list_lock);
>   
> +	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
> +		mpam_ris_destroy(ris);
> +
>   	list_del_rcu(&msc->all_msc_list);
>   	platform_set_drvdata(pdev, NULL);
> +
> +	add_to_garbage(msc);
>   }
>   
>   static void mpam_msc_drv_remove(struct platform_device *pdev)
> @@ -81,7 +470,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
>   
> -	synchronize_srcu(&mpam_srcu);
> +	mpam_free_garbage();
>   }
>   
>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
> @@ -97,6 +486,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>   	if (!msc)
>   		return ERR_PTR(-ENOMEM);
> +	init_garbage(&msc->garbage);
> +	msc->garbage.pdev = pdev;
>   
>   	err = devm_mutex_init(dev, &msc->probe_lock);
>   	if (err)
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 540066903eca..8f7a28d2c021 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -7,11 +7,30 @@
>   #include <linux/arm_mpam.h>
>   #include <linux/cpumask.h>
>   #include <linux/io.h>
> +#include <linux/llist.h>
>   #include <linux/mutex.h>
> +#include <linux/srcu.h>
>   #include <linux/types.h>
>   
> +#define MPAM_MSC_MAX_NUM_RIS	16
> +
>   struct platform_device;
>   
> +/*
> + * Structures protected by SRCU may not be freed for a surprising amount of
> + * time (especially if perf is running). To ensure the MPAM error interrupt can
> + * tear down all the structures, build a list of objects that can be garbage
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
> +
>   struct mpam_msc {
>   	/* member of mpam_all_msc */
>   	struct list_head	all_msc_list;
> @@ -45,5 +64,80 @@ struct mpam_msc {
>   
>   	void __iomem		*mapped_hwpage;
>   	size_t			mapped_hwpage_sz;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
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
>   };
> +
> +/* List of all classes - protected by srcu*/
> +extern struct srcu_struct mpam_srcu;
> +extern struct list_head mpam_classes;
> +
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity);
> +
>   #endif /* MPAM_INTERNAL_H */
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index a3828ef91aee..5a3aab6bb1d4 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -37,11 +37,16 @@ static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
>   static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
>   #endif
>   
> +#ifdef CONFIG_ARM64_MPAM_DRIVER
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id);
> +#else
>   static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>   				  enum mpam_class_types type, u8 class_id,
>   				  int component_id)
>   {
>   	return -EINVAL;
>   }
> +#endif
>   
>   #endif /* __LINUX_ARM_MPAM_H */

Thanks,
Gavin


