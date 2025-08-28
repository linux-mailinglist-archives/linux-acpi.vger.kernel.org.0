Return-Path: <linux-acpi+bounces-16144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7EDB3A165
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD70A20658
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5113148A3;
	Thu, 28 Aug 2025 14:10:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A15218ABD;
	Thu, 28 Aug 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390234; cv=none; b=FBn69poAk6gTRC0xHAx6PoaUH9XNcBJ3M5aVnE/BaYejnl3Q0+2yBbO0o15Xd0Bay4KoaVKRTLLAc+4zcbsnqiFhDSR950kDR1nZ6AvY0zLB+Hc6HCPkf740dR8+irPDc17aiR/TslG34iZrJcV8hEjWOSJ99RaaRIOEhuaEPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390234; c=relaxed/simple;
	bh=JbfXuzndkTW2/wKmak9wb5k4WTaXXXZK9l9RYz1eD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBa0eAZ17zixyNm/ezzu3+QcSVp4WO5ijlpJ6T2JOGVAZK91m+lplpf8WWYRXb81ThJzzAg+Zlz0UDQiVwMK1k/GRuTQTVwHOgsMXFOuLQjgV2jX8nw89GVoxTOaeXDmtQDXAEqgzYTdq9mDSZP971L0I/5+MRiAW6y9wg//ElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6FF31688;
	Thu, 28 Aug 2025 07:10:23 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95A893F694;
	Thu, 28 Aug 2025 07:10:26 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:10:23 +0100
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
Message-ID: <aLBjTyTKk6Pod40v@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-3-james.morse@arm.com>
 <aK7iDey7LATOXIUb@e133380.arm.com>
 <2ac66605-ee6a-495b-a0fb-910926abd8b0@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac66605-ee6a-495b-a0fb-910926abd8b0@arm.com>

Hi James,

On Wed, Aug 27, 2025 at 06:11:43PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 11:46, Dave Martin wrote:
> > Hi,
> > 
> > On Fri, Aug 22, 2025 at 03:29:43PM +0000, James Morse wrote:
> >> MPAM needs to know the size of a cache associated with a particular CPU.
> >> The DT/ACPI agnostic way of doing this is to ask cacheinfo.
> >>
> >> Add a helper to do this.
> 
> >> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> >> index 2dcbb69139e9..e12d6f2c6a57 100644
> >> --- a/include/linux/cacheinfo.h
> >> +++ b/include/linux/cacheinfo.h
> >> @@ -148,6 +148,21 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
> >>  	return ci ? ci->id : -1;
> >>  }
> >>  
> >> +/**
> >> + * get_cpu_cacheinfo_size() - Get the size of the cache.
> >> + * @cpu:      The cpu that is associated with the cache.
> >> + * @level:    The level of the cache as seen by @cpu.
> >> + *
> >> + * Callers must hold the cpuhp lock.
> >> + * Returns the cache-size on success, or 0 for an error.
> >> + */
> > 
> > Nit: Maybe use the wording
> > 
> > 	cpuhp lock must be held.
> > 
> > in the kerneldoc here, to match the other helpers it sits alongside.
> > 
> > Otherwise, looks reasonable.
> 
> Sure,
> 
> 
> >> +static inline unsigned int get_cpu_cacheinfo_size(int cpu, int level)
> >> +{
> >> +	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
> >> +
> >> +	return ci ? ci->size : 0;
> >> +}
> >> +
> > 
> > Orphaned function?
> > 
> > Can fs/resctrl/rdtgroup.c:rdtgroup_cbm_to_size() be ported to use this?
> > If so, this wouldn't just be dead code in this series.
> 
> Ah - I thought the MPAM driver was pulling this value in, but its the resctrl glue code.
> I was trying to reduce the number of trees this touches - its probably best to kick this
> into the next series that adds the resctrl code as its pretty trivial.
> 
> 
> Thanks,
> 
> James

Sure, that also works.

Cheers
---Dave

