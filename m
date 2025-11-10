Return-Path: <linux-acpi+bounces-18751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C61C4859A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913E3A6DD8
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA72D73BD;
	Mon, 10 Nov 2025 17:31:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA372D3A6D;
	Mon, 10 Nov 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795903; cv=none; b=uF1JTvYbVSJa4InNag1/S2URxfp773RdB4HUZZQzPzgrsCvc6Ew4qGC2jqze2I44rCoaTMorbbXEdJzg6ZRcTvHtdweesyFSewsENeJlqe5UAinxtZl4MKCdT0kxBDC+eKfh8tmK39X8g1qYS8+EajjMqqXT9IiNY06z6W4QmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795903; c=relaxed/simple;
	bh=hjLldDOBYLwmC9Y21K9hHSE9sbYPZmRGkL2qIhSQFcs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRpBb2wJtqEJCAxaPC2wtFbHg2NjXUkBecaovvYOJVPcmgVLBC3i0YpvTnnDopXaEDS57RJckrCTbp8/VQh1nwhC/l1u0YeB28z9U9344VU7DE9nlORqS8Kn8fi51Hkhe69kdgEXZTElhCsA2vwhCKp670P98bxrxdUxHPBVJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4xXq462SzHnGcw;
	Tue, 11 Nov 2025 01:31:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1921314033C;
	Tue, 11 Nov 2025 01:31:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 17:31:37 +0000
Date: Mon, 10 Nov 2025 17:31:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, Zeng Heng <zengheng4@huawei.com>
Subject: Re: [PATCH 27/33] arm_mpam: Track bandwidth counter state for power
 management
Message-ID: <20251110173136.000074ce@huawei.com>
In-Reply-To: <20251107123450.664001-28-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-28-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:44 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> Save the counter state when the hardware is reset due to CPU hotplug.
> Add struct mbwu_state to track the bandwidth counter. Support for
> tracking overflow with the same structure will be added in a
> subsequent commit.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

One trivial below.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index d8f8e29987e0..1f2b04b7703e 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -91,7 +91,10 @@ struct mpam_msc {
>  	 */
>  	struct mutex		part_sel_lock;
>  
> -	/* cfg_lock protects the msc configuration. */
> +	/*
> +	 * cfg_lock protects the msc configuration and guards against mbwu_state
> +	 * and save and restore racing.

Stray "and" that isn't needed on this second line.

> +	 */
>  	struct mutex		cfg_lock;
>  



