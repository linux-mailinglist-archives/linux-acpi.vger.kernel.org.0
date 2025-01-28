Return-Path: <linux-acpi+bounces-10855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CFAA2133A
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 21:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976921883BB0
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45F1E0B74;
	Tue, 28 Jan 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H6z2Atca"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E801DE8AC
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jan 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096968; cv=none; b=rSyMAPYM/66ov2xF6ElfXlv1QqLZbpcd+YwaHkWJO9A3iVpB6aTIXvSIjzG6sbVGGJVbGCjTNz+IVLeTwN4pR2brTLMiEAy3/EDKoU6VrSmf6N4PsbrRRkd2hpzFUDBe38NiocSaaQyOB5pyyq0KFsZeJpSxsbGs74dfS9OCY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096968; c=relaxed/simple;
	bh=hfZURXY9Q0UNWXaXALdG56eXuQNwSwfMlU0LptzP2yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNNeoQ2U+yNf9oGiBw7HdBWY1nO7GWFYrohAwC2V+viEtZcouw2izeVAb1YOmI5/2evo54h53f10x9vlkNQwaO+R1nZ760Du9mFx+0W3FyuNKwk/3r8KnhlGEN0uXNeFUmbOPQekeEievvxJnpLhrgIw0cYGlfpmx16OJfUmTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H6z2Atca; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 12:42:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738096954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZITjXCuyDtKK1qtqnTTdQ9PmU2bXeOu1iAWHigtFFs=;
	b=H6z2AtcawhAIWMhD9yaCeCJk3LBm6DXMoLKTAkNF/PTdoPU1ntEQpTT2ear9g3GN0Ex3gp
	Hjj9xpszPzHhxqUvb60Rg/LP2je3PbM2KTXqsZd70P1YYGDabpydCw6kfMAehbDB7EmqQK
	SCBQXoIwD5Pxt8hT1qDsOzRdphLh2Ys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers
 array count
Message-ID: <Z5lBMBY7XoFJmpGM@linux.dev>
References: <20250128001749.3132656-1-oliver.upton@linux.dev>
 <Z5i2j9gFB2iyN9g4@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5i2j9gFB2iyN9g4@lpieralisi>
X-Migadu-Flow: FLOW_OUT

Hi Lorenzo,

On Tue, Jan 28, 2025 at 11:50:55AM +0100, Lorenzo Pieralisi wrote:
> > @@ -188,13 +188,17 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
> >  		cnt++;
> >  
> >  	if (cnt != gtdt->platform_timer_count) {
> > +		cnt = min(cnt, gtdt->platform_timer_count);
> 
> Thank you for reporting this.
> 
> There is something I need to understand.
> 
> What's wrong cnt (because platform_timer_valid() fails for some
> reason on some entries whereas before the commit we
> are fixing was applied we *were* parsing those entries) or
> gtdt->platform_timer_count ?
> 
> I *guess* the issue is the following:
> 
> gtdt->platform_timer_count reports the number of GT blocks in the
> GTDT not including Arm generic watchdogs, whereas cnt counts both
> structure types (and that's what gtdt->platform_timer_count should
> report too if it was correct).

I've seen two different issues so far:

 - In one case, the offset of the platform timer array is entirely
   beyond the GTDT

 - In another, the GTDT has a timer array of length 2, but only the
   first structure falls within the length of the overall GTDT

Since cnt is the result of doing a bounds-checked walk of the platform
timer array, both of these issues cause the sanity check to fail.

> >  	if (platform_timer_count)
> > -		*platform_timer_count = gtdt->platform_timer_count;
> > +		*platform_timer_count = cnt;
> 
> I think this should be fine as things stand (but see above).
> 
> It is used in:
> 
> gtdt_sbsa_gwdt_init() - just to check if there are platform timers entries
> 
> arch_timer_mem_acpi_init() - to create a temporary array to init arch mem timer
> 			     entries (the array is oversized because it
> 			     includes watchdog entries in the count)
> 
> In both cases taking the
> 
> min(cnt, gtdt->platform_timer_count);
> 
> should work AFAICS

It was probably worth noting in the changelog that I did this to
gracefully handle the reverse of this issue where we could dereference
platform timer entries that are within the bounds of the GTDT but exceed
gtdt->platform_timer_count.

> (hard to grok though, we - as in ACPI maintainers -
> need to clean this up).

Heh, thought this smelled a little ripe ;-) Went for the minimal fix
first.

-- 
Thanks,
Oliver

