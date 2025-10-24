Return-Path: <linux-acpi+bounces-18197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8FC078FC
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 19:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553A7400DE6
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32991345759;
	Fri, 24 Oct 2025 17:41:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFC1C1AAA;
	Fri, 24 Oct 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327661; cv=none; b=oChKJSlzSOo+JkZz4jGOnaXE0zw4UsG7PWqhstDuG0glL4ueJvwYDYO3dxcA+jGc5zqqQuZx1mWtIRomVM8FfdlxKAAxi7jvXPe5yrcAKj0w5aoQ4H4Iuy0GWQCRovkCiHGwg3Wnq5e0QxkP3LNa27GOo1p6Ae8+ZKZja+h1Nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327661; c=relaxed/simple;
	bh=pGVdW/63t02VqVFfLGf9nw9CCWHp0E2yLsMDH6WIAVA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIJCOmIH6x3nGv7uOgLsb4bt1J0GcGA2lKMKIC3DtRSHbvBHqqfrR35rbTsFwCQp7gU9NAXuJyI0QIZb3o+oddRMkyyXaBi2E7BXG2nVvdv2KxK7W8YralDQy9xRRso20hij9C4ZV9qZATE49LWwz6XkTqPq4l3e7aFlqRdtNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctVWv55tQz6L57H;
	Sat, 25 Oct 2025 01:39:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 26BBA1402FB;
	Sat, 25 Oct 2025 01:40:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 18:40:53 +0100
Date: Fri, 24 Oct 2025 18:40:52 +0100
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
Subject: Re: [PATCH v3 11/29] arm_mpam: Probe hardware to find the supported
 partid/pmg values
Message-ID: <20251024184052.00004c24@huawei.com>
In-Reply-To: <20251017185645.26604-12-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-12-james.morse@arm.com>
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

On Fri, 17 Oct 2025 18:56:27 +0000
James Morse <james.morse@arm.com> wrote:

> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
> 
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
> 
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Trivial stuff inline. I'd definitely not trust this reviewer who
is horribly inconsistent ;)

> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

>  static struct mpam_vmsc *
>  mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc)
>  {
> @@ -427,6 +500,7 @@ static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
>  	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
>  	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
>  	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
> +	list_add_rcu(&ris->msc_list, &msc->ris);

This looks like it might the add I was missing earlier?  If so and it can
only be done now, move the del into this patch as well.

>  
>  	return 0;
>  }
> @@ -446,9 +520,36 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>  	return err;
>  }
>  
> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
> +						   u8 ris_idx)
> +{
> +	int err;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (!test_bit(ris_idx, &msc->ris_idxs)) {
> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
> +					     0, 0);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	list_for_each_entry(ris, &msc->ris, msc_list) {
> +		if (ris->ris_idx == ris_idx) {
> +			return ris;

I'm not seeing this change in later patches in this series, so brackets
seem unnecessary and against kernel style.

> +		}
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
>

