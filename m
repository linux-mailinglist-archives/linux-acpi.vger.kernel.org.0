Return-Path: <linux-acpi+bounces-16708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B907CB5494E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C024818EE
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F52E6CAC;
	Fri, 12 Sep 2025 10:15:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6D2E62B3;
	Fri, 12 Sep 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672108; cv=none; b=rd9jVICMbv8zKruKb3eox50ghbMJ9Ps4HSOPeE+/3rmR21DTWJVEYpv0YiUsr+xUHdT1xjYmXRr0m54EENRID2X0pWEVjeO8X/SijH35z2uc1qMDoAl1QkbMZ89L1OgrSkMlvWoTI1f8JMEZQL+YvQpMrDzN0y4mrdMULjCYQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672108; c=relaxed/simple;
	bh=F6uU4Bkpe4tSQ27Lw7rgOCdqDM9bV/yN2roBcAa9G4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcWuioO2zmoxxQJrb2eQdwKEnhyoXKvKCgRpUkKan1HMTkn+YEqsIZkQmax65qUMVHdl1dW+hVCzwLJwQ/EBcDvUtzLg9GoRzYEQ8TWo8nK0IwPmoEeiCj4Nw1VQhKs6SXZIGbtS6shKMB6pbLu0R2I3wDsKR5eEwV1T6zrwk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7973916A3;
	Fri, 12 Sep 2025 03:14:57 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563A93F66E;
	Fri, 12 Sep 2025 03:15:01 -0700 (PDT)
Message-ID: <3a93f4f3-cafc-40f5-b405-d42d5f5c9525@arm.com>
Date: Fri, 12 Sep 2025 11:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-6-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it. As MPAM is only found on arm64
> platforms, the arm64 tree is the most natural home for the Kconfig
> option.
> 
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and to register properties
> of CPUs with the MPAM driver.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> CC: Dave Martin <dave.martin@arm.com>
> ---
> Changes since v1:
>  * Help text rewritten by Dave.
> ---
>  arch/arm64/Kconfig | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e9bbfacc35a6..4be8a13505bf 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2060,6 +2060,29 @@ config ARM64_TLB_RANGE
>  	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>  	  range of input addresses.
>  
> +config ARM64_MPAM
> +	bool "Enable support for MPAM"
> +	help
> +	  Memory System Resource Partitioning and Monitoring (MPAM) is an
> +	  optional extension to the Arm architecture that allows each
> +	  transaction issued to the memory system to be labelled with a
> +	  Partition identifier (PARTID) and Performance Monitoring Group
> +	  identifier (PMG).
> +
> +	  Memory system components, such as the caches, can be configured with
> +	  policies to control how much of various physical resources (such as
> +	  memory bandwidth or cache memory) the transactions labelled with each
> +	  PARTID can consume.  Depending on the capabilities of the hardware,
> +	  the PARTID and PMG can also be used as filtering criteria to measure
> +	  the memory system resource consumption of different parts of a
> +	  workload.
> +
> +	  Use of this extension requires CPU support, support in the
> +	  Memory System Components (MSC), and a description from firmware
> +	  of where the MSCs are in the address space.
> +
> +	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
> +
>  endmenu # "ARMv8.4 architectural features"
>  
>  menu "ARMv8.5 architectural features"

Seems good to me. I guess we can consider separately whether we want
this to be default or not.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


