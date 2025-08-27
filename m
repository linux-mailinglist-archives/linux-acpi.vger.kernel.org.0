Return-Path: <linux-acpi+bounces-16102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BCB38035
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1955D7C7D68
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5752BE620;
	Wed, 27 Aug 2025 10:46:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAF2853E3;
	Wed, 27 Aug 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291608; cv=none; b=RRhW/1c95C39oXFEgmvsymxhYTrkM8TLd2zzLr30WDfg/NMaXUwo/4F7Mqw66+KOWxXGdkyNabA+ZN02IToBpBcgsN6BgDt2pEyhZWdFJgS7XJcgA7CWGhINa/r4N6UXDq09h1Vm4O2MOIX3cpLYZwr5cUvU9E6aVXbAjJPkgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291608; c=relaxed/simple;
	bh=NEeFWbxSjOhaJkreE/MdcTRInyZBXBYCV9SQqK9qwfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK2B+H0EhiRNZJRW90d5mTY3EwFZGxoK5HQpdAMaxxcD7mPbNyDMxbEMVjCMScJ8+/vhXw/k/6ZviGoblpmOmetnbQEjHrdELJFWoWDVPwnupHxojnHFCX0w9jbcHUvm/ilf85DBg2Crq+M2DOdTIg29kEdSIEHxjQmUTI0ctO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1D71688;
	Wed, 27 Aug 2025 03:46:37 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0753D3F738;
	Wed, 27 Aug 2025 03:46:39 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:46:37 +0100
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
Subject: Re: [PATCH 02/33] drivers: base: cacheinfo: Add helper to find the
 cache size from cpu+level
Message-ID: <aK7iDey7LATOXIUb@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-3-james.morse@arm.com>

Hi,

On Fri, Aug 22, 2025 at 03:29:43PM +0000, James Morse wrote:
> MPAM needs to know the size of a cache associated with a particular CPU.
> The DT/ACPI agnostic way of doing this is to ask cacheinfo.
> 
> Add a helper to do this.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>  * Converted to kdoc.
>  * Simplified helper to use get_cpu_cacheinfo_level().
> ---
>  include/linux/cacheinfo.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 2dcbb69139e9..e12d6f2c6a57 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -148,6 +148,21 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
>  	return ci ? ci->id : -1;
>  }
>  
> +/**
> + * get_cpu_cacheinfo_size() - Get the size of the cache.
> + * @cpu:      The cpu that is associated with the cache.
> + * @level:    The level of the cache as seen by @cpu.
> + *
> + * Callers must hold the cpuhp lock.
> + * Returns the cache-size on success, or 0 for an error.
> + */

Nit: Maybe use the wording

	cpuhp lock must be held.

in the kerneldoc here, to match the other helpers it sits alongside.

Otherwise, looks reasonable.

> +static inline unsigned int get_cpu_cacheinfo_size(int cpu, int level)
> +{
> +	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
> +
> +	return ci ? ci->size : 0;
> +}
> +

Orphaned function?

Can fs/resctrl/rdtgroup.c:rdtgroup_cbm_to_size() be ported to use this?
If so, this wouldn't just be dead code in this series.

Cheers
---Dave

