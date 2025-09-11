Return-Path: <linux-acpi+bounces-16682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFCB537C8
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F4B1BC331E
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3834F476;
	Thu, 11 Sep 2025 15:30:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDA350837;
	Thu, 11 Sep 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604606; cv=none; b=eHJ6P3CgcpAsOcH1hmWW/7QEgAjVVvq8NDXvEm8626nBdzxq40oinxx4czN/BjD1JchHleyfqfPpn8cSdo+MV0rOe9hpC0lTj0ftoe20Xt2hrE1rOeZhpWat7024V91PC7D0h/x0IzA6ZuLVShON2cOOuUHsZLn8ACW+EEAiecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604606; c=relaxed/simple;
	bh=gyPV9uVTYjET/7vaw4E1pD9hWn9OZEJkjEj1Sv17mfQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbBON+Z17mYHFMC9xvWH//bE+VnONDqw5AtmRYY48Xqgp/2d3UxFhz7y48ieGa1z2XI9mT4DSp5/x84kz70S8oqeNeKmBxrE/Lgb+8oK+lz9KWLMG6fTJ4r3f/ZUkH5XXmqfnqjIJQ6vswLLjnH7fGkTpctotJQI5+j69euqmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cN1bY2hPnz6L5cG;
	Thu, 11 Sep 2025 23:25:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C82E1402FF;
	Thu, 11 Sep 2025 23:29:59 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 17:29:57 +0200
Date: Thu, 11 Sep 2025 16:29:56 +0100
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
Subject: Re: [PATCH v2 13/29] arm_mpam: Probe the hardware features resctrl
 supports
Message-ID: <20250911162956.00005157@huawei.com>
In-Reply-To: <20250910204309.20751-14-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-14-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:53 +0000
James Morse <james.morse@arm.com> wrote:

> Expand the probing support with the control and monitor types
> we can use with resctrl.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

A few trivial things inline.
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Out of time for today, fingers crossed I can get to the others tomorrow.

J
>  static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
>  	u64 idr;
> @@ -592,6 +736,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	mutex_lock(&msc->part_sel_lock);
>  	idr = mpam_msc_read_idr(msc);
>  	mutex_unlock(&msc->part_sel_lock);
> +
Stray change  - push it to earlier patch.

>  	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>  
>  	/* Use these values so partid/pmg always starts with a valid value */
> @@ -614,6 +759,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  		mutex_unlock(&mpam_list_lock);
>  		if (IS_ERR(ris))
>  			return PTR_ERR(ris);
> +		ris->idr = idr;
> +
> +		mutex_lock(&msc->part_sel_lock);
> +		__mpam_part_sel(ris_idx, 0, msc);
> +		mpam_ris_hw_probe(ris);
> +		mutex_unlock(&msc->part_sel_lock);
>  	}
>  
>  	spin_lock(&partid_max_lock);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4cc44d4e21c4..5ae5d4eee8ec 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -112,6 +112,55 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  	raw_spin_lock_init(&msc->_mon_sel_lock);
>  }
>  
> +/*
> + * When we compact the supported features, we don't care what they are.
> + * Storing them as a bitmap makes life easy.
> + */
> +typedef u16 mpam_features_t;

Maybe use a bitmap type and avoid the need to be careful on sizing etc?

> +
> +/* Bits for mpam_features_t */
> +enum mpam_device_features {
> +	mpam_feat_ccap_part = 0,
> +	mpam_feat_cpor_part,
> +	mpam_feat_mbw_part,
> +	mpam_feat_mbw_min,
> +	mpam_feat_mbw_max,
> +	mpam_feat_mbw_prop,
> +	mpam_feat_msmon,
> +	mpam_feat_msmon_csu,
> +	mpam_feat_msmon_csu_capture,
> +	mpam_feat_msmon_csu_hw_nrdy,
> +	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_capture,
> +	mpam_feat_msmon_mbwu_rwbw,
> +	mpam_feat_msmon_mbwu_hw_nrdy,
> +	mpam_feat_msmon_capt,
> +	MPAM_FEATURE_LAST,

If it's always meant to be LAST, I'd drop the trailing comma.

> +};
> +static_assert(BITS_PER_TYPE(mpam_features_t) >= MPAM_FEATURE_LAST);




