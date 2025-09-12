Return-Path: <linux-acpi+bounces-16724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D6B54EBF
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2180C1C8356E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3BB3043D1;
	Fri, 12 Sep 2025 13:07:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F712DC787;
	Fri, 12 Sep 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682431; cv=none; b=OxOUaWOk9nGLh6yL8og+t9+K7+jpiCh61qcDkgDSd+eDDmPWB/25ezUlBVvQs+EUqZkqkXw57drI8iZvZxXzOswFk3F10zHnwszie04x8N7OfiMYoFhxDbvP5ezhLdUZU/ZTyFhElx3WvBmXVfdQD/1+gwY1O+IazCJh/wj8dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682431; c=relaxed/simple;
	bh=I4D39sp4XXfq9x/AV8/E/xI3f1d1b3oZ7P8NdRZqfOY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC8LMy+DnKbl5dJDrCfqxBFrxZNiMM3N+VqSQVB9fdG8bxRYef1o+Yu4pNDPkxmFNApm0QKD2kZRjtwH3yWRubdwYXZKZinyplIIT79z6UxEw9Bh2Yhaggn3HgAFj8xx+WerGBg/1nXPdCIH2mM7e0/c2feQgV80W8aIwVf2fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZRZ5Wmwz6GDFf;
	Fri, 12 Sep 2025 21:05:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E737E1401F4;
	Fri, 12 Sep 2025 21:07:04 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:07:03 +0200
Date: Fri, 12 Sep 2025 14:07:02 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Zeng Heng <zengheng4@huawei.com>
Subject: Re: [PATCH v2 21/29] arm_mpam: Probe and reset the rest of the
 features
Message-ID: <20250912140702.00000a5a@huawei.com>
In-Reply-To: <20250910204309.20751-22-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-22-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:43:01 +0000
James Morse <james.morse@arm.com> wrote:

> MPAM supports more features than are going to be exposed to resctrl.
> For partid other than 0, the reset values of these controls isn't
> known.
> 
> Discover the rest of the features so they can be reset to avoid any
> side effects when resctrl is in use.
> 
> PARTID narrowing allows MSC/RIS to support less configuration space than
> is usable. If this feature is found on a class of device we are likely
> to use, then reduce the partid_max to make it usable. This allows us
> to map a PARTID to itself.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> CC: Zeng Heng <zengheng4@huawei.com>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

A few trivial things inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>  int mpam_register_requestor(u16 partid_max, u8 pmg_max)
>  {
>  	int err = 0;
> @@ -667,10 +676,35 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	struct mpam_msc *msc = ris->vmsc->msc;
>  	struct device *dev = &msc->pdev->dev;
>  	struct mpam_props *props = &ris->props;
> +	struct mpam_class *class = ris->vmsc->comp->class;
>  
>  	lockdep_assert_held(&msc->probe_lock);
>  	lockdep_assert_held(&msc->part_sel_lock);
>  
> +	/* Cache Capacity Partitioning */
> +	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
> +		u32 ccap_features = mpam_read_partsel_reg(msc, CCAP_IDR);
> +
> +		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
> +		if (props->cmax_wd &&
> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM, ccap_features))
> +			mpam_set_feature(mpam_feat_cmax_softlim, props);
> +
> +		if (props->cmax_wd &&
> +		    !FIELD_GET(MPAMF_CCAP_IDR_NO_CMAX, ccap_features))
> +			mpam_set_feature(mpam_feat_cmax_cmax, props);
> +
> +		if (props->cmax_wd &&
> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMIN, ccap_features))
> +			mpam_set_feature(mpam_feat_cmax_cmin, props);
> +
> +		props->cassoc_wd = FIELD_GET(MPAMF_CCAP_IDR_CASSOC_WD, ccap_features);
> +
Trivial but blank line here feels inconsistent with local style. I'd drop it.
> +		if (props->cassoc_wd &&
> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CASSOC, ccap_features))
> +			mpam_set_feature(mpam_feat_cmax_cassoc, props);
> +	}
> +

> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 17570d9aae9b..326ba9114d70 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -136,25 +136,34 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>   * When we compact the supported features, we don't care what they are.
>   * Storing them as a bitmap makes life easy.
>   */
> -typedef u16 mpam_features_t;
> +typedef u32 mpam_features_t;

This is strengthening my view that this should just be a DECLARE_BITMAP(MPAM_FEATURE_LAST)
in the appropriate places.

>  
>  /* Bits for mpam_features_t */
>  enum mpam_device_features {
> -	mpam_feat_ccap_part = 0,
> +	mpam_feat_cmax_softlim,
> +	mpam_feat_cmax_cmax,
> +	mpam_feat_cmax_cmin,
> +	mpam_feat_cmax_cassoc,
>  	mpam_feat_cpor_part,
>  	mpam_feat_mbw_part,
>  	mpam_feat_mbw_min,
>  	mpam_feat_mbw_max,
>  	mpam_feat_mbw_prop,
> +	mpam_feat_intpri_part,
> +	mpam_feat_intpri_part_0_low,
> +	mpam_feat_dspri_part,
> +	mpam_feat_dspri_part_0_low,
>  	mpam_feat_msmon,
>  	mpam_feat_msmon_csu,
>  	mpam_feat_msmon_csu_capture,
> +	mpam_feat_msmon_csu_xcl,
>  	mpam_feat_msmon_csu_hw_nrdy,
>  	mpam_feat_msmon_mbwu,
>  	mpam_feat_msmon_mbwu_capture,
>  	mpam_feat_msmon_mbwu_rwbw,
>  	mpam_feat_msmon_mbwu_hw_nrdy,
>  	mpam_feat_msmon_capt,
> +	mpam_feat_partid_nrw,
>  	MPAM_FEATURE_LAST,
>  };
>  static_assert(BITS_PER_TYPE(mpam_features_t) >= MPAM_FEATURE_LAST);
> @@ -165,6 +174,10 @@ struct mpam_props {
>  	u16			cpbm_wd;
>  	u16			mbw_pbm_bits;
>  	u16			bwa_wd;
> +	u16			cmax_wd;
> +	u16			cassoc_wd;
> +	u16			intpri_wd;
> +	u16			dspri_wd;
>  	u16			num_csu_mon;
>  	u16			num_mbwu_mon;
>  };


