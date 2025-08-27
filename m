Return-Path: <linux-acpi+bounces-16101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC811B38032
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA8C34E404E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7096028D8E8;
	Wed, 27 Aug 2025 10:46:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C120ED;
	Wed, 27 Aug 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291578; cv=none; b=AtkGISt0BbejYMK7xwEIMgsD3qEW7K59wZme5HmwKuamhT84NnBOrW2U7PoKtVtc2KVxhxIA1PB1D2GyLqDmhwuP29bwCMgcp5nnVRq20Xi0nkaUHDqrU5ibj5PuEtqOxRFw9N8vcKIN4DTpJbdncfAS7IzOoIHYTt2qMb/dZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291578; c=relaxed/simple;
	bh=WAQA74idaX90UlIpUem5NDOqd5djJuJGPghggS60YDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNqH07/nTKqAw4ij5XxZbz/SSZ2Rq534J8ArZWGABJ2k8xdKnuc1/viy/vs497gKrHtIcDyHPzFo4LS/znljpZ3FmwL/aJrEnnYIJO0AfzQ3UAqHMhjMzAmW2wmzlpJqhgrSHrIw8/G2JARMo7+EEpemmd/kEVHFaHDzJ85JS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 517931688;
	Wed, 27 Aug 2025 03:46:07 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB74E3F738;
	Wed, 27 Aug 2025 03:46:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:46:02 +0100
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
Subject: Re: [PATCH 01/33] cacheinfo: Expose the code to generate a cache-id
 from a device_node
Message-ID: <aK7h6seHNWs5rO9Q@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-2-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-2-james.morse@arm.com>

Hi James,

On Fri, Aug 22, 2025 at 03:29:42PM +0000, James Morse wrote:
> The MPAM driver identifies caches by id for use with resctrl. It
> needs to know the cache-id when probe-ing, but the value isn't set
> in cacheinfo until device_initcall().
> 
> Expose the code that generates the cache-id. The parts of the MPAM
> driver that run early can use this to set up the resctrl structures
> before cacheinfo is ready in device_initcall().

Why can't the MPAM driver just consume the precomputed cache-id
information?

Possible reasons are that the MPAM driver probes too early, or that it
must parse the PPTT directly (which is true) and needs to label caches
consistently with the way the kernel does it.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Renamed cache_of_get_id() cache_of_calculate_id().
> ---
>  drivers/base/cacheinfo.c  | 19 +++++++++++++------
>  include/linux/cacheinfo.h |  1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 613410705a47..f6289d142ba9 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -207,11 +207,10 @@ static bool match_cache_node(struct device_node *cpu,
>  #define arch_compact_of_hwid(_x)	(_x)
>  #endif
>  
> -static void cache_of_set_id(struct cacheinfo *this_leaf,
> -			    struct device_node *cache_node)
> +unsigned long cache_of_calculate_id(struct device_node *cache_node)
>  {
>  	struct device_node *cpu;
> -	u32 min_id = ~0;
> +	unsigned long min_id = ~0UL;

Why the change of type here?

This does mean that 0xffffffff can now be generated as a valid cache-id,
but if that is necessary then this patch is also fixing a bug in the
code -- but the commit message doesn't say anything about that.

For a patch that is just exposing an internal result, it may be
better to keep the original type.  ~(u32)0 is already used as an
exceptional value.

[...]

Otherwise, this looks reasonable to me.

Cheers
---Dave

