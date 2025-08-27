Return-Path: <linux-acpi+bounces-16093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C0BB37E21
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7411B6526C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5033CE96;
	Wed, 27 Aug 2025 08:53:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30152335BC1;
	Wed, 27 Aug 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284835; cv=none; b=NJZlHVf2m8PjGOz2eIuEidUpXVC29n5Sl37XBobZ2tRTxZjQxRu2A6h2jgsS0Xjjz4V0xfl83OvwPsbH0CaitApkMmTinb65f0uT1lBrm6po25W4wGF3WpANsoMckSuIWc8Og1lk3AK8D+LZDJ1URqJinfyw9fPPOQRiwvtzfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284835; c=relaxed/simple;
	bh=P38O43fMuBeGBKDmS2PF3LrHlp668kFtyl36Iw5bUrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+SHBp7lNJ4IpIioW0KsbY6irCArybLIue7jpoOirirbjByJ/92PKxptRPBXNP0RHM8MYCukPcbF9vwBKgVUTTwpBmGNTQmtwb61sRu+EUhkpt+yQwMVvyybJp+G7DF+RHMesV56yO2F9Yktq4PufpSxcYHqzrlDLCMlDqulPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159921655;
	Wed, 27 Aug 2025 01:53:44 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE013F738;
	Wed, 27 Aug 2025 01:53:47 -0700 (PDT)
Message-ID: <0c8a6a7c-3d0d-4093-8bc5-3a04f70b00fa@arm.com>
Date: Wed, 27 Aug 2025 09:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] arm64: kconfig: Add Kconfig entry for MPAM
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-8-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:29, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it, as MPAM is only found on arm64
> platforms, that is where the Kconfig option makes the most sense.
> 
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and registering the CPUs
> properties with the MPAM driver.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  arch/arm64/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e9bbfacc35a6..658e47fc0c5a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2060,6 +2060,23 @@ config ARM64_TLB_RANGE
>  	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>  	  range of input addresses.
>  
> +config ARM64_MPAM
> +	bool "Enable support for MPAM"
> +	help
> +	  Memory Partitioning and Monitoring is an optional extension
> +	  that allows the CPUs to mark load and store transactions with
> +	  labels for partition-id and performance-monitoring-group.
> +	  System components, such as the caches, can use the partition-id
> +	  to apply a performance policy. MPAM monitors can use the
> +	  partition-id and performance-monitoring-group to measure the
> +	  cache occupancy or data throughput.
> +
> +	  Use of this extension requires CPU support, support in the
> +	  memory system components (MSC), and a description from firmware
> +	  of where the MSC are in the address space.
> +
> +	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
> +
>  endmenu # "ARMv8.4 architectural features"

Should this be moved to "ARMv8.2 architectural features" rather than the
8.4 menu? In the arm reference manual, version L.b, I see FEAT_MPAM
listed in the section A2.2.3.1 Features added to the Armv8.2 extension
in later releases.

>  
>  menu "ARMv8.5 architectural features"

Thanks,

Ben


