Return-Path: <linux-acpi+bounces-16727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B12B54F69
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701D1189298E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2273093B6;
	Fri, 12 Sep 2025 13:24:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B6276056;
	Fri, 12 Sep 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683467; cv=none; b=VFtg3ymN1QJ//E7xeT+iaO7MTpQSpo0fkk/myaRU69Iv81SLtNMmotQw8YcGZSKMCOqS1GMJuvLRZ5HpUnAbT3703hpgZ2k1LdeItpOL0UY1Qa3/5K8m9jx3GUUmoADpbY/yFCqkEdttCi/97DXGHFPpqKJJ6XDwwZn4kzWUAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683467; c=relaxed/simple;
	bh=8hO1gh4QPpX+qUJtvAUp2n3+2tbru0yK4/bJ3sYDKoQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD5ztY+L0oh4d0cEdPGFHgzlD3rOPHuGT2nVu13Z38/QlTj6hx4/cRak9B3zEf8YK73bzW/CBt1Jsnm7uvnMbnf7TLMqLQhNG2pQFUh74elYN+GMyqjS5w/eYm6tUcbuTyWO5Wv++91sqjU/hQbtULonxyj+MJU/VDvqcC3D1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZqX0v5cz6GDGM;
	Fri, 12 Sep 2025 21:23:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5579C14038F;
	Fri, 12 Sep 2025 21:24:22 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:24:21 +0200
Date: Fri, 12 Sep 2025 14:24:19 +0100
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
Subject: Re: [PATCH v2 24/29] arm_mpam: Track bandwidth counter state for
 overflow and power management
Message-ID: <20250912142419.00006c6d@huawei.com>
In-Reply-To: <20250910204309.20751-25-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-25-james.morse@arm.com>
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

On Wed, 10 Sep 2025 20:43:04 +0000
James Morse <james.morse@arm.com> wrote:

> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> The value read may be lower than the previous value read in the case
> of overflow and when the hardware is reset due to CPU hotplug.
> 
> Add struct mbwu_state to track the bandwidth counter to allow overflow
> and power management to be handled.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Trivial comment inline.  I haven't spent enough time thinking about this
to give a proper review so no tags yet.

Jonathan
 
> ---
> Changes since v1:
>  * Fixed lock/unlock typo.
> ---
>  drivers/resctrl/mpam_devices.c  | 154 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  23 +++++
>  2 files changed, 175 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 1543c33c5d6a..eeb62ed94520 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -918,6 +918,7 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>  	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>  
>  	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
> +
Unrelated change.  If it makes sense figure out where to push it back to.

>  	if (m->ctx->match_pmg) {
>  		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>  		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);


