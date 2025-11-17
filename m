Return-Path: <linux-acpi+bounces-18980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E99C660D6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15514EBA42
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE22EC541;
	Mon, 17 Nov 2025 20:02:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A121283FCF;
	Mon, 17 Nov 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409750; cv=none; b=TxQqnbNFJhCwqgV3xBL3LD1DSvt+2cWWoy3oNYQQ1mWF8Ok1/KidB43OC1k1cEXIYyb+whzHSgrTwbT6omzbibv7kd1OVnMB8Lk7FplvaylotoJLI0vg703/1iE8XnPEA3fZ3RoCcsYKuO9aQ4bDhe9i0jhB/j9Em5FBsjB11Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409750; c=relaxed/simple;
	bh=LYD/HqZBe8TV+6HU0hH2eU4HtaC5BUfW1otkT1vNtms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFqX+PKoHRaBFGZbMtuPX/ehZFuZXmTtu2FVqCeORstRitBYN5eadSF1gxz9xoj2SGwlBtx2CHXJWwJCRg1Px0naw7f2qmlsM9CQdjcWVLA4NeBHZMR3VECZdETVZLakMPSvakI9geCB71P+hMzJh05qbwKcwFaGQLlTAj5LOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB3BFEC;
	Mon, 17 Nov 2025 12:02:19 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEAFD3F63F;
	Mon, 17 Nov 2025 12:02:21 -0800 (PST)
Date: Mon, 17 Nov 2025 20:02:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: gregkh@linuxfoundation.org, Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>
Cc: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com,
	amitsinght@marvell.com, baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com, dakr@kernel.org, dave.martin@arm.com,
	david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
	gshan@redhat.com, guohanjun@huawei.com, jeremy.linton@arm.com,
	jonathan.cameron@huawei.com, kobak@nvidia.com, lcherian@marvell.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, peternewman@google.com,
	quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
	rohit.mathew@arm.com, scott@os.amperecomputing.com,
	sdonthineni@nvidia.com, sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
Subject: Re: [PATCH v5 34/34] MAINTAINERS: new entry for MPAM Driver
Message-ID: <aRt_S7HUIifgJF6W@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-35-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117170014.4113754-35-ben.horgan@arm.com>

On Mon, Nov 17, 2025 at 05:00:13PM +0000, Ben Horgan wrote:
> Create a maintainer entry for the new MPAM Driver. Add myself and
> James Morse as maintainers. James created the driver and I have
> taken up the later versions of his series.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..ec9b2b255bef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17463,6 +17463,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>  F:	drivers/video/backlight/mp3309c.c
>  
> +MPAM DRIVER
> +M:	James Morse <james.morse@arm.com>
> +M:	Ben Horgan <ben.horgan@arm.com>
> +S:	Maintained
> +F:	drivers/resctrl/mpam_*
> +F:	drivers/resctrl/test_mpam_*
> +F:	include/linux/arm_mpam.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Greg, are you ok with the above maintainers entry? Happy to queue
patches for this via the arm64 tree (or at least the initial drop).

Reinette, Tony, I now realised you haven't been cc'ed on this series:

https://lore.kernel.org/r/20251117170014.4113754-1-ben.horgan@arm.com

While it doesn't touch fs/resctrl/, it's going to be a user of that API.
Are you ok with this maintainer setup? I wouldn't mind at all if you
want to be a co-maintainers or reviewers of drivers/resctrl/* (e.g.
adding this under the RDT entry) but I guess you would not be looking
forward to more email traffic.

Thanks.

-- 
Catalin

