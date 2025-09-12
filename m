Return-Path: <linux-acpi+bounces-16728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C7B54F81
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3020B1CC6B7B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1A30DEC9;
	Fri, 12 Sep 2025 13:27:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178628641B;
	Fri, 12 Sep 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683652; cv=none; b=W7idZvXBMP9XNOYTkdUkfWc7PNJshqcjA/eVR/APmQzFBHiAEQ5ZYhJff5wX22LvEdCHdn+zBrbHnMSY+ijAEmMRVHCOjfEIm6CKyXt+9pInZnK87o27lCAaxodHlsoXeBJcrnOTN7WbxaIjrkls8t9QgLm0J/ocd7vVdKjCcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683652; c=relaxed/simple;
	bh=z2gpvoxIqmZiOnujPr79DbJXDeYEkwLzVyTlRzVRc7o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC43Z5f2jlV7dUnbL43DYTxucMm/gUmUCeGveM6R7UcBpaZUCz1Dj/J9XhI064P6sJVRXkbR9IOAP3mYlJuL/bKrWkmYzbH5Kygix1RsLe/0KokQy++yHjEoSn+e7MVh/fQSmLVofmqrG7K+ARBJuyEJCkbmcjypF/mwk7kA64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZv46TKdz6GDH6;
	Fri, 12 Sep 2025 21:26:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 23B7214038F;
	Fri, 12 Sep 2025 21:27:27 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:27:25 +0200
Date: Fri, 12 Sep 2025 14:27:24 +0100
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
Subject: Re: [PATCH v2 25/29] arm_mpam: Probe for long/lwd mbwu counters
Message-ID: <20250912142724.000026a7@huawei.com>
In-Reply-To: <20250910204309.20751-26-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-26-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:43:05 +0000
James Morse <james.morse@arm.com> wrote:

> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register have fields
> indicating support for long counters. As of now, a 44 bit counter
> represented by HAS_LONG field (bit 30) and a 63 bit counter represented
> by LWD (bit 29) can be optionally integrated. Probe for these counters
> and set corresponding feature bits if any of these counters are present.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Hi Rohit, James.

I'd like a little more justification of the 'front facing' use for the first
feature bit.  To me that seems confusing but I may well be missing why
we can't have 3 exclusive features.

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c  | 23 ++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  9 +++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index eeb62ed94520..bae9fa9441dc 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -795,7 +795,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
>  		}
>  		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
> -			bool hw_managed;
> +			bool has_long, hw_managed;
>  			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
>  
>  			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
> @@ -805,6 +805,27 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
>  				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
>  
> +			/*
> +			 * Treat long counter and its extension, lwd as mutually
> +			 * exclusive feature bits. Though these are dependent
> +			 * fields at the implementation level, there would never
> +			 * be a need for mpam_feat_msmon_mbwu_44counter (long
> +			 * counter) and mpam_feat_msmon_mbwu_63counter (lwd)
> +			 * bits to be set together.
> +			 *
> +			 * mpam_feat_msmon_mbwu isn't treated as an exclusive
> +			 * bit as this feature bit would be used as the "front
> +			 * facing feature bit" for any checks related to mbwu
> +			 * monitors.

Why do we need such a 'front facing' bit?  Why isn't it sufficient just to
add a little helper or macro to find out if mbwu is turned on?

> +			 */
> +			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumon_idr);
> +			if (props->num_mbwu_mon && has_long) {
> +				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumon_idr))
> +					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
> +				else
> +					mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
> +			}
> +
>  			/* Is NRDY hardware managed? */
>  			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
>  			if (hw_managed)
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 725c2aefa8a2..c190826dfbda 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -158,7 +158,16 @@ enum mpam_device_features {
>  	mpam_feat_msmon_csu_capture,
>  	mpam_feat_msmon_csu_xcl,
>  	mpam_feat_msmon_csu_hw_nrdy,
> +
> +	/*
> +	 * Having mpam_feat_msmon_mbwu set doesn't mean the regular 31 bit MBWU
> +	 * counter would be used. The exact counter used is decided based on the
> +	 * status of mpam_feat_msmon_mbwu_44counter/mpam_feat_msmon_mbwu_63counter
> +	 * as well.
> +	 */
>  	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_44counter,
> +	mpam_feat_msmon_mbwu_63counter,
>  	mpam_feat_msmon_mbwu_capture,
>  	mpam_feat_msmon_mbwu_rwbw,
>  	mpam_feat_msmon_mbwu_hw_nrdy,


