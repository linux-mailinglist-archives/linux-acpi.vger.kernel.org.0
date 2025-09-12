Return-Path: <linux-acpi+bounces-16714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6EB54B91
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DD41CC0B04
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83230103F;
	Fri, 12 Sep 2025 11:49:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5030147E;
	Fri, 12 Sep 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677792; cv=none; b=PrCyn0HuJjJ6cuEkJ8I/OpqTwpKsaicecmJ4kPB+Y3bnleYnMdB8oZaCRqUpF5iBtKleik9e/gNMrK1WAgWEEVHCKnvXNlHDoY1EjDfCgN3Z+69U2E815qFnaKBHQ/PlPSvSGCD6d4yfXXYuN1p2D1hyX2v4u8OXnmeBLTfvbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677792; c=relaxed/simple;
	bh=foqElKCs6b3ZlLAWTAc2Tf3h+G0EboccIwwnyrcqEZU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzHlVzjpV1aBrbfOzg9tHNBk32moM94LBW/gAOgZGK63B5pWNGp09ZcI7f5WV48vFEyjLHa/sWVYNC50LSQ6WWY6ijISYbg8CxSf8RVLwNvGEtDPQaLlMLkKlJqzEmhcVraetGTuikQEJ5EMcQOnsXRr80YrW8f64mK3BPT8MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNXfq1y1Zz6L64k;
	Fri, 12 Sep 2025 19:45:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EC68E1402EA;
	Fri, 12 Sep 2025 19:49:39 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 13:49:38 +0200
Date: Fri, 12 Sep 2025 12:49:37 +0100
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
Subject: Re: [PATCH v2 14/29] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
Message-ID: <20250912124937.00004250@huawei.com>
In-Reply-To: <20250910204309.20751-15-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-15-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:42:54 +0000
James Morse <james.morse@arm.com> wrote:

> To make a decision about whether to expose an mpam class as
> a resctrl resource we need to know its overall supported
> features and properties.
> 
> Once we've probed all the resources, we can walk the tree
> and produce overall values by merging the bitmaps. This
> eliminates features that are only supported by some MSC
> that make up a component or class.
> 
> If bitmap properties are mismatched within a component we
> cannot support the mismatched feature.
> 
> Care has to be taken as vMSC may hold mismatched RIS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

A trivial things inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> +/*
> + * Combine two props fields.
> + * If this is for controls that alias the same resource, it is safe to just
> + * copy the values over. If two aliasing controls implement the same scheme
> + * a safe value must be picked.
> + * For non-aliasing controls, these control different resources, and the
> + * resulting safe value must be compatible with both. When merging values in
> + * the tree, all the aliasing resources must be handled first.
> + * On mismatch, parent is modified.
> + */
> +static void __props_mismatch(struct mpam_props *parent,
> +			     struct mpam_props *child, bool alias)
> +{
> +	if (CAN_MERGE_FEAT(parent, child, mpam_feat_cpor_part, alias)) {
> +		parent->cpbm_wd = child->cpbm_wd;
> +	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_cpor_part,
> +				   cpbm_wd, alias)) {
> +		pr_debug("%s cleared cpor_part\n", __func__);
> +		mpam_clear_feature(mpam_feat_cpor_part, &parent->features);
> +		parent->cpbm_wd = 0;
> +	}
> +
> +	if (CAN_MERGE_FEAT(parent, child, mpam_feat_mbw_part, alias)) {
> +		parent->mbw_pbm_bits = child->mbw_pbm_bits;
> +	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_mbw_part,
> +				   mbw_pbm_bits, alias)) {
> +		pr_debug("%s cleared mbw_part\n", __func__);
> +		mpam_clear_feature(mpam_feat_mbw_part, &parent->features);
> +		parent->mbw_pbm_bits = 0;
> +	}
> +
> +	/* bwa_wd is a count of bits, fewer bits means less precision */
> +	if (alias && !mpam_has_bwa_wd_feature(parent) && mpam_has_bwa_wd_feature(child)) {

Seems like an overly long line given other local wrapping.

> +		parent->bwa_wd = child->bwa_wd;
> +	} else if (MISMATCHED_HELPER(parent, child, mpam_has_bwa_wd_feature,
> +				     bwa_wd, alias)) {
> +		pr_debug("%s took the min bwa_wd\n", __func__);
> +		parent->bwa_wd = min(parent->bwa_wd, child->bwa_wd);
> +	}
> +
> +	/* For num properties, take the minimum */
> +	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_csu, alias)) {
> +		parent->num_csu_mon = child->num_csu_mon;
> +	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_csu,
> +				   num_csu_mon, alias)) {
> +		pr_debug("%s took the min num_csu_mon\n", __func__);
> +		parent->num_csu_mon = min(parent->num_csu_mon, child->num_csu_mon);
> +	}
> +
> +	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_mbwu, alias)) {
> +		parent->num_mbwu_mon = child->num_mbwu_mon;
> +	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_mbwu,
> +				   num_mbwu_mon, alias)) {
> +		pr_debug("%s took the min num_mbwu_mon\n", __func__);
> +		parent->num_mbwu_mon = min(parent->num_mbwu_mon, child->num_mbwu_mon);
> +	}

> +
> +/*
> + * If a vmsc doesn't match class feature/configuration, do the right thing(tm).
> + * For 'num' properties we can just take the minimum.
> + * For properties where the mismatched unused bits would make a difference, we
> + * nobble the class feature, as we can't configure all the resources.
> + * e.g. The L3 cache is composed of two resources with 13 and 17 portion
> + * bitmaps respectively.
> + */
> +static void
> +__class_props_mismatch(struct mpam_class *class, struct mpam_vmsc *vmsc)

I'm not really sure what the __ prefix denotes here.

> +{
> +	struct mpam_props *cprops = &class->props;
> +	struct mpam_props *vprops = &vmsc->props;
> +
> +	lockdep_assert_held(&mpam_list_lock); /* we modify class */
> +
> +	pr_debug("%s: Merging features for class:0x%lx &= vmsc:0x%lx\n",
> +		 dev_name(&vmsc->msc->pdev->dev),
> +		 (long)cprops->features, (long)vprops->features);

According to https://docs.kernel.org/core-api/printk-formats.html
should be fine using %x for u16 values. So why dance through a cast to long?
> +
> +	/* Take the safe value for any common features */
> +	__props_mismatch(cprops, vprops, false);
> +}
> +
> +static void
> +__vmsc_props_mismatch(struct mpam_vmsc *vmsc, struct mpam_msc_ris *ris)
> +{
> +	struct mpam_props *rprops = &ris->props;
> +	struct mpam_props *vprops = &vmsc->props;
> +
> +	lockdep_assert_held(&mpam_list_lock); /* we modify vmsc */
> +
> +	pr_debug("%s: Merging features for vmsc:0x%lx |= ris:0x%lx\n",
> +		 dev_name(&vmsc->msc->pdev->dev),
> +		 (long)vprops->features, (long)rprops->features);

Same as above comment on casts being unnecessary.

> +
> +	/*
> +	 * Merge mismatched features - Copy any features that aren't common,
> +	 * but take the safe value for any common features.
> +	 */
> +	__props_mismatch(vprops, rprops, true);
> +}
> +
> +/*
> + * Copy the first component's first vMSC's properties and features to the
> + * class. __class_props_mismatch() will remove conflicts.
> + * It is not possible to have a class with no components, or a component with
> + * no resources. The vMSC properties have already been built.

If it's not possible do we need the defensive _or_null and error checks?

> + */
> +static void mpam_enable_init_class_features(struct mpam_class *class)
> +{
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_component *comp;
> +
> +	comp = list_first_entry_or_null(&class->components,
> +					struct mpam_component, class_list);
> +	if (WARN_ON(!comp))
> +		return;
> +
> +	vmsc = list_first_entry_or_null(&comp->vmsc,
> +					struct mpam_vmsc, comp_list);
> +	if (WARN_ON(!vmsc))
> +		return;
> +
> +	class->props = vmsc->props;
> +}

> +/*
> + * Merge all the common resource features into class.
> + * vmsc features are bitwise-or'd together, this must be done first.

I'm not sure what 'this' is here - I think it's a missing plural that has
me confused.  Perhaps 'these must be done first.'

> + * Next the class features are the bitwise-and of all the vmsc features.
> + * Other features are the min/max as appropriate.
> + *
> + * To avoid walking the whole tree twice, the class->nrdy_usec property is
> + * updated when working with the vmsc as it is a max(), and doesn't need
> + * initialising first.

Perhaps state that this comment is about what happens in each call of
mpam_enable_merge_vmsc_features()  Or move the comment to that function.

> + */
> +static void mpam_enable_merge_features(struct list_head *all_classes_list)
> +{
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, all_classes_list, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list)
> +			mpam_enable_merge_vmsc_features(comp);
> +
> +		mpam_enable_init_class_features(class);
> +
> +		list_for_each_entry(comp, &class->components, class_list)
> +			mpam_enable_merge_class_features(comp);
> +	}
> +}



