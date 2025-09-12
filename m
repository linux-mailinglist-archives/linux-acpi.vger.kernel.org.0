Return-Path: <linux-acpi+bounces-16730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC9B54F99
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0951CC7A51
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849130DD2F;
	Fri, 12 Sep 2025 13:33:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CD3009F0;
	Fri, 12 Sep 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683989; cv=none; b=RuVPIoJ4HD6cwv2wDrb2i9HwVTnAJG3hFkl2vZVfinEknn4BY8Gz8JCCcLgJEyQycKGLyRS/8tUmD3QlUvFsy96e7v3+a1puaOGd09jW49L4j3VCPq1rghwQTtaadvoZ+li3sAMrtkhxIGJpqHw2Tb6mKDsBamhJNT3l7oAAKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683989; c=relaxed/simple;
	bh=sxp25xjSdH/ZYXWhXeQ7XndzgmAEKuWwNLWUueViX7o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuDSsqGfMjsSfSEQwjmlm3KyW8RN5YsvofCBya53rBuufF6rj6T6PpGDCT+kXTRo4Y4S97B3SEIeIMlml/Bw29WBJm7cLPCDuD90lUqFhjZ6sUT7EtLIt1D6G0uDqU9yBsAZ2srKuz6/8XGnwCADljUZiLiJ3ARHAjlIdqqnyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZzz1n8zz6M53H;
	Fri, 12 Sep 2025 21:30:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F4A1404FE;
	Fri, 12 Sep 2025 21:33:04 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:33:03 +0200
Date: Fri, 12 Sep 2025 14:33:02 +0100
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
Subject: Re: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
Message-ID: <20250912143302.00004d0e@huawei.com>
In-Reply-To: <20250910204309.20751-28-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-28-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:43:07 +0000
James Morse <james.morse@arm.com> wrote:

> resctrl expects to reset the bandwidth counters when the filesystem
> is mounted.
> 
> To allow this, add a helper that clears the saved mbwu state. Instead
> of cross calling to each CPU that can access the component MSC to
> write to the counter, set a flag that causes it to be zero'd on the
> the next read. This is easily done by forcing a configuration update.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Minor comments inline.

Jonathan

> @@ -1245,6 +1257,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>  	return err;
>  }
>  
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
> +{
> +	int idx;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	if (!mpam_is_enabled())
> +		return;
> +
> +	idx = srcu_read_lock(&mpam_srcu);

Maybe guard() though it doesn't add that much here.

> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {

Reason not to use _srcu variants?

> +		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
> +			continue;
> +
> +		msc = vmsc->msc;
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
> +				continue;
> +
> +			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +				continue;
> +
> +			ris->mbwu_state[ctx->mon].correction = 0;
> +			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
> +			mpam_mon_sel_unlock(msc);
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
>  static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>  {
>  	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index c190826dfbda..7cbcafe8294a 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -223,10 +223,12 @@ struct mon_cfg {
>  
>  /*
>   * Changes to enabled and cfg are protected by the msc->lock.
> - * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
> + * Changes to reset_on_next_read, prev_val and correction are protected by the
> + * msc's mon_sel_lock.
Getting close to the point where a list of one per line would reduce churn.
If you anticipate adding more to this in future I'd definitely consider it.
e.g.
 * msc's mon_sel_lcok protects:
 * - reset_on_next_read
 * - prev_val
 * - correction
 */
>   */
>  struct msmon_mbwu_state {
>  	bool		enabled;
> +	bool		reset_on_next_read;
>  	struct mon_cfg	cfg;
>  
>  	/* The value last read from the hardware. Used to detect overflow. */
> @@ -393,6 +395,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
>  
>  int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>  		    enum mpam_device_features, u64 *val);
> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
>  
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>  				   cpumask_t *affinity);


