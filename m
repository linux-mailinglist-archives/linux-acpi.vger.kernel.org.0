Return-Path: <linux-acpi+bounces-17635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F9BBFC80
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 01:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2595C3BAEC4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117251DBB13;
	Mon,  6 Oct 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbLHdYro"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489D1A2547
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793173; cv=none; b=tPHBtJEku86PnxMyXmnd1VYdjb0pSS3fWRIAin6bDl1V2kYNYs0FLocBaUthme6p5MhdZg7Ln+xLHWUIfOzVzwE5gO6vHegttqj0pdJp+8wQ3VOep139jluJgxkJXTaP0MGoJW2ER6o/XipNiEt2jQ/rutinmTDKIKZuq4692zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793173; c=relaxed/simple;
	bh=cUxTi5HF8VOvBv7tRC5vMBxPjQKykV1ubt5L5qkzgiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSwIlChAOlFlPmQYumEQ2Gd7RX8d/RfRD5ppQ+Spb5eIOS8Wd2SABZ+GUI7TAkTV+RsKLMZXFYIzo4SO4n+lkPKbNHR6GhoVWRbSDdl1o1vH4fzvfeaQQUNC5FVAQcsAYypBVqPGYBr3n1WXu8fYQd02wjKM1Qivv6be8iHQyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbLHdYro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759793170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyB/2Pk5wijagVYBD6/smx6bBOT8c4NVWW3i8n/rIkA=;
	b=AbLHdYro6p8XL/0/7lrqOPWhCRymXVEihMuEjBT0EjLc/O/SZgAh0J72LviqtvDFtTlDL0
	AfcXYhtYpV5OZC9rSqz+tkNvOu/7M/QJ3oTlwuCPjFf61nYmNRodlpxROl74W+2MiDFK+M
	ztm8QowS6okKwCIcuWRJQcRoXBZbyAY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-JkXix0HpNAyX0kEbHyyReA-1; Mon, 06 Oct 2025 19:26:08 -0400
X-MC-Unique: JkXix0HpNAyX0kEbHyyReA-1
X-Mimecast-MFC-AGG-ID: JkXix0HpNAyX0kEbHyyReA_1759793167
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befc08so9241783a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 16:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793167; x=1760397967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyB/2Pk5wijagVYBD6/smx6bBOT8c4NVWW3i8n/rIkA=;
        b=QblmoN9xqMZD1RpO9yPtqbYTPgwV/mA29JJX893LRWcIdTnfIWDaWiOUAzE0hjJUxY
         dWxGVwBwuQVm1fO5Lne1DonXT426pV82dQJNr874btSFwGG2ptK9LEoBi5JSIGAk0ZKk
         yj2ET/eScHBBiNU6lX2GQ96hJgFMip1xBqq+xYIiZQssNtD70W9OZPrn26RNuxTeJNhG
         8+khT0IrxGXtTMevlCQg+3M4qSg6qmf9dvm6bPahZSlxaY2c1UaqizMNw8th3VZVDQ3f
         +3iQvZzPltMK6sB2E4mnXmpD81iae30Ja9MAMNWetKNvCUVdZi/3b1p/NPRfr4++YvUR
         nLGA==
X-Forwarded-Encrypted: i=1; AJvYcCUhI7OKpJHFTp8fDck+yYJahPB0gEFI5zdfIp5mIUGB+Dkxk0GE08x9hMUX852hZrb8FVK+cSPbIRAl@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTmkerP4ddp3pBDXxCHymryeZiwa0BVUF/54EThwSL3iosKrD
	OqAOY1G694MZmAn1ADSrnGpg339VD2SmvOUnPe6UVPSAavS2gKUDmVU9Udm4Kw5eqkbjXVBw9jk
	0iegEszB4HZuK6AZU8ps4AfKDO/gQrcM3agENXpv4/QfUDjjK4ALok6ttGMffzk0=
X-Gm-Gg: ASbGncufupNpbi+BJzxEE2QbdnWZ8tUKX0K2uFzsPc6mtT6YxbWOXmUBM1t0cj5BzKz
	FO3DoedHSgOiiFzjK7sdVpOmyvKC8T9ulVEnH7nQkfqhWs1rY4hwgFyGskjARPloAc3H6aENdT1
	hh2JQ0FcZnTz45vh/vuBcYniT+CAMCQTtxVfJiVjh3xe0a4M4FU0uEDFIuVz/r9nHYFV17FDDVY
	jyTxs/hwEfA0/6rAJaQWAxk08SdkGIENtFQqRKUXcrXkizXdAJw0wP/I4I5DGYlY31E/vaBRlZ0
	zbkz432MdrTg3UY+zT00SamNPUJFXiC39OLPPbYXX0vmRqWWU8focbnCcIKlPkvJ6isPN14VpPR
	8/UHv0tGMpA==
X-Received: by 2002:a17:90b:4a8c:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-339c27bc475mr17899824a91.29.1759793167272;
        Mon, 06 Oct 2025 16:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERIFLl8GkviCDqbLVDIbfSKCg91e+HAkaXDPlbRbY5H7aG5yx3n7cRQWkYPRFuLdo2BGpp1g==
X-Received: by 2002:a17:90b:4a8c:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-339c27bc475mr17899797a91.29.1759793166872;
        Mon, 06 Oct 2025 16:26:06 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff256dsm17874793a91.16.2025.10.06.16.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:26:06 -0700 (PDT)
Message-ID: <92e05ef2-356b-4c1f-99c3-1e7482775cdc@redhat.com>
Date: Tue, 7 Oct 2025 09:25:53 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-10-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/11/25 6:42 AM, James Morse wrote:
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Link: https://developer.arm.com/documentation/ihi0099/latest/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v1:
>   * Whitespace.
>   * Added constants for CASSOC and XCL.
>   * Merged FLT/CTL defines.
>   * Fixed MSMON_CFG_CSU_CTL_TYPE_CSU definition.
> 
> Changes since RFC:
>   * Renamed MSMON_CFG_MBWU_CTL_TYPE_CSU as MSMON_CFG_CSU_CTL_TYPE_CSU
>   * Whitepsace churn.
>   * Cite a more recent document.
>   * Removed some stale feature, fixed some names etc.
> ---
>   drivers/resctrl/mpam_internal.h | 267 ++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 02e9576ece6b..109f03df46c2 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -152,4 +152,271 @@ extern struct list_head mpam_classes;
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/
> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */

":" seems unnecessary.

> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR		0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR		0x0080  /* performance monitoring features */
> +#define MPAMF_IMPL_IDR		0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR		0x0030  /* cache-portion partitioning */
> +#define MPAMF_CCAP_IDR		0x0038  /* cache-capacity partitioning */
> +#define MPAMF_MBW_IDR		0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR		0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR	0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR	0x0090  /* mem-bw usage monitor */
> +#define MPAMF_PARTID_NRW_IDR	0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR		0x0018  /* implementer id register */
> +#define MPAMF_AIDR		0x0020  /* architectural id register */
> +
> +/* Configuration and Status Register offsets in the memory mapped page */
> +#define MPAMCFG_PART_SEL	0x0100  /* partid to configure: */

":" seems unnecessary.

> +#define MPAMCFG_CPBM		0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX		0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN		0x0110  /* cache-capacity config */
> +#define MPAMCFG_CASSOC		0x0118  /* cache-associativity config */
> +#define MPAMCFG_MBW_MIN		0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX		0x0208  /* max mem-bw config */
> +#define MPAMCFG_MBW_WINWD	0x0220  /* mem-bw accounting window config */
> +#define MPAMCFG_MBW_PBM		0x2000  /* mem-bw portion bitmap config */
> +#define MPAMCFG_PRI		0x0400  /* priority partitioning config */
> +#define MPAMCFG_MBW_PROP	0x0500  /* mem-bw stride config */
> +#define MPAMCFG_INTPARTID	0x0600  /* partid-narrowing config */
> +

[...]

Thanks,
Gavin


