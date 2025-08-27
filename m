Return-Path: <linux-acpi+bounces-16107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4EEB38077
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9B1BA5E5E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBC1FA178;
	Wed, 27 Aug 2025 11:01:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F917E0;
	Wed, 27 Aug 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292513; cv=none; b=nPS1g+IkddIF/vwT64/NcbT5DfQzekpaBY+t9FYNRoREJqZm5h+QKeiID1esjlpVNRX/oDcLsURFxWUf9M8W2ZDllIEQEyD2I3FAd3pxwAYWgMN114yjaNZv5VjloHU1eDnsg1J1t7wI0+Vyc/QysyVVYE9cRqgVDzn91E8uHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292513; c=relaxed/simple;
	bh=b36ZFFus+YKM/DRzxZTRj7sJOanzLsVl0BSD9LanNug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSUeddpqwFcQL6C+ovCFPGl0W0U+htOaEcC4eIX7xjMFGQLjNpYq9Xu2Aa/g5IpNiX/72AO0cT05+zvvXh4bOfBstQy+kP7JND8O/IGBE/zabfuZRPcaFwaXT6PrAjuovEEjBJTcFNA+geJwVx2h1cli1M8Zq6uuq/aq3PmaJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2EB1688;
	Wed, 27 Aug 2025 04:01:42 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B543F694;
	Wed, 27 Aug 2025 04:01:45 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:01:42 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 07/33] arm64: kconfig: Add Kconfig entry for MPAM
Message-ID: <aK7llvNbXZKWhtoo@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-8-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-8-james.morse@arm.com>

Hi,

<super-pedantic mode enabled>

(Since this likely be people's go-to patch for understanding what MPAM
is, it is probably worth going the extra mile.)

On Fri, Aug 22, 2025 at 03:29:48PM +0000, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it, as MPAM is only found on arm64

Prefer -> "[...] to enable it. As MPAM is only [...]"

> platforms, that is where the Kconfig option makes the most sense.

It could be clearer what "where" refers to, here.

Maybe reword from ", that is [...]" -> ", the arm64 tree is the most
natural home for the Kconfig option."

(Or something like that.)

> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and registering the CPUs

Nit: "registering" -> "to register"

> properties with the MPAM driver.

Nit: "CPUs properties" -> "properties of CPUs" ?

(Maybe there was just a missed apostrophe, but it may be more readable
here if written out longhand.)


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

<pedantic mode on>

> +	  Memory Partitioning and Monitoring is an optional extension
> +	  that allows the CPUs to mark load and store transactions with

Nit: "memory transactions" ?

(I'm wondering whether there are some transactions such as atomic
exchanges that are not neatly characterised as "load" or "store".
Possibly MPAM labels some transactions that really are neither.)

> +	  labels for partition-id and performance-monitoring-group.

Nit: the hyphenation suggests that these are known terms (in this
specific, hyphenated, form) with specific definitions somewhere.
I don't think that this is the case?  At least, I have not seen the
terms presented in this way anywhere else.

Also, the partition ID is itself a label, so "label for partition-id"
is a tautology.

How about:

--8<--

	  Memory System Resource Partitioning and Monitoring (MPAM) is an
	  optional extension to the Arm architecture that allows each
	  transaction issued to the memory system to be labelled with a
	  Partition identifier (PARTID) and Performance Monitoring Group
	  identifier (PMG).

-->8--

(Yes, that really seems to be what MPAM stands for in the published
specs.  That's quite a mounthful, and news to me...  I can't say I paid
much attention to the document titles beyond "MPAM"!)

> +	  System components, such as the caches, can use the partition-id
> +	  to apply a performance policy. MPAM monitors can use the

What is a "performance policy"?

The MPAM specs talk about resource controls; it's probably best to
stick to the same terminology.

> +	  partition-id and performance-monitoring-group to measure the
> +	  cache occupancy or data throughput.

So, how about something like:

--8<--

	  Memory system components, such as the caches, can be configured with
	  policies to control how much of various physical resources (such as
	  memory bandwidth or cache memory) the transactions labelled with each
	  PARTID can consume.  Depending on the capabilities of the hardware,
	  the PARTID and PMG can also be used as filtering criteria to measure
	  the memory system resource consumption of different parts of a
	  workload.

-->8--

(Where "Memory system components" is used in a generic sense and so not
capitalised.)

> +
> +	  Use of this extension requires CPU support, support in the
> +	  memory system components (MSC), and a description from firmware

But here, we are explicitly using an architectural term now, so

	"Memory System Components" (MSC)

makes sense.

> +	  of where the MSC are in the address space.

Prefer "MSCs" ?  (Not everyone agrees about whether TLAs are
pluralisable but it is easier on the reader if "are" has an obviously
plural noun to bind to.)

> +
> +	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
> +
>  endmenu # "ARMv8.4 architectural features"
>  
>  menu "ARMv8.5 architectural features"

Cheers
---Dave

