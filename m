Return-Path: <linux-acpi+bounces-16527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F4B4A957
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D63363FF0
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CB2F3C30;
	Tue,  9 Sep 2025 10:07:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D82D46BC;
	Tue,  9 Sep 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412431; cv=none; b=L/ZqVJP1LV/GHub81gvfd3jRSleVAaI0MvVwLm3ziZjbEdeS4MowajtFKPjGUZpEyCCZJb2aJdZM4iPWUJbHgr/eryw6Jck/o8Q0vxENom6pRILYW43cuNyW+BYlO61f57fuGrjkhcFlZDhmJTRq+4hAJZkCEgTqbWKObQjOmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412431; c=relaxed/simple;
	bh=/KbbwvQvwoDDtcfJnQaWn3NiqCRJWQONsBAd5RtWH88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM7pl55cwm8HwDomgt/uHJ3xZiDJZzxDsPIj/l/C3TRd9/l+cgOI4GlwUkF90M9ltgCZ3ljvecLfxNkaNv38zd8ep5hikESsGI4zR9qKuLKndkNbO2m3sTjvS1H89q7knhhsjS1hVGp/++rBQnlIDXQ8phW3AopzjtN+7PRNQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4797113E;
	Tue,  9 Sep 2025 03:06:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B533F66E;
	Tue,  9 Sep 2025 03:07:01 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:06:52 +0100
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
Subject: Re: [PATCH 04/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
Message-ID: <aL/8PIcebYGoB/g6@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-5-james.morse@arm.com>
 <aK7iyf/6iVOuVhTr@e133380.arm.com>
 <1914b7f0-10e6-4cf4-ad53-5ae03c69964d@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1914b7f0-10e6-4cf4-ad53-5ae03c69964d@arm.com>

Hi James,

On Thu, Aug 28, 2025 at 04:57:15PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 11:49, Dave Martin wrote:
> > On Fri, Aug 22, 2025 at 03:29:45PM +0000, James Morse wrote:
> >> acpi_count_levels() passes the number of levels back via a pointer argument.
> >> It also passes this to acpi_find_cache_level() as the starting_level, and
> >> preserves this value as it walks up the cpu_node tree counting the levels.
> >>
> >> This means the caller must initialise 'levels' due to acpi_count_levels()
> >> internals. The only caller acpi_get_cache_info() happens to have already
> >> initialised levels to zero, which acpi_count_levels() depends on to get the
> >> correct result.
> >>
> >> Two results are passed back from acpi_count_levels(), unlike split_levels,
> >> levels is not optional.
> >>
> >> Split these two results up. The mandatory 'levels' is always returned,
> >> which hides the internal details from the caller, and avoids having
> >> duplicated initialisation in all callers. split_levels remains an
> >> optional argument passed back.
> > 
> > Nit: I found all this a bit hard to follow.
> > 
> > This seems to boil down to:
> > 
> > --8<--
> > 
> > In acpi_count_levels(), the initial value of *levels passed by the
> > caller is really an implementation detail of acpi_count_levels(), so it
> > is unreasonable to expect the callers of this function to know what to
> > pass in for this parameter.  The only sensible initial value is 0,
> > which is what the only upstream caller (acpi_get_cache_info()) passes.
> > 
> > Use a local variable for the starting cache level in acpi_count_levels(),
> > and pass the result back to the caller via the function return value.
> > 
> > Gid rid of the levels parameter, which has no remaining purpose.
> > 
> > Fix acpi_get_cache_info() to match.
> > 
> > -->8--
> 
> I've taken this instead,

OK

[...]

> >> @@ -731,7 +735,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
> >>  	if (!cpu_node)
> >>  		return -ENOENT;
> >>  
> >> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> >> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
> >>  
> >>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
> >>  		 *levels, split_levels ? *split_levels : -1);
> > 
> > Otherwise, looks reasonable to me.
> > 
> > (But see my comments on the next patches re whether we really need this.)
> 
> It was enough fun to debug that I'd like to save anyone else the trouble!

Fair enough.

Cheers
---Dave

