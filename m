Return-Path: <linux-acpi+bounces-16417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAFB45DCF
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC95C5E45
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8AD306B00;
	Fri,  5 Sep 2025 16:19:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558272F7ABF;
	Fri,  5 Sep 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089190; cv=none; b=pCQjDyGxJj6KMPsER8rtC6w77vtNbqdCsYcjFzbTCe7Y2v9FQYKVNga2mg2I+HDwI3h06lMWj1V4XQwXruOTfilxkBr0kmY+Hxkph+8G2E+F01+JJmZNmOD3wjasu+uMGxInhpMklS382LvT1qLQvLxniGV/Uw6wV27WrV90wK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089190; c=relaxed/simple;
	bh=4hbd2XwoLVVA/f+86Q5KT4OHBRHzD7m8e0OymCmsTgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqKrTp5Q8QIhPMIYGXRnhqoVJgoMgW1YH9Jt/SZGWHfMAiwRH8jMMQE+t15d5e6ptCtJmKXhTLoBYr1wvR8p3xQaTDy67mWLFvj4Ajk1JMdV0VfO7rs3Ilxd9gRNVjFGaw7114e7JEbqkPDqgE+XdbeCNBjRjDPydggA+RutSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7DF152B;
	Fri,  5 Sep 2025 09:19:38 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 654D73F63F;
	Fri,  5 Sep 2025 09:19:41 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:19:34 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
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
Message-ID: <aLsNljxM+DN7kmC7@e133380.arm.com>
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

Hi,

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

[...]

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
> 

Fair enough.

Cheers
---Dave

