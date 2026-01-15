Return-Path: <linux-acpi+bounces-20360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E07D2357E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62BF0301833A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D83451CC;
	Thu, 15 Jan 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p8ULPTtY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCC344021;
	Thu, 15 Jan 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467953; cv=none; b=ORLEhMdmT6a5xaGjo1EXgRYvRR1Jkcufmv/2QFwzGiHQEO2UDI2ZYA+jV+5mLr/R88DGgQQCPf1L0p9qO31S+3nSxu45qO5I+CM1Mcb3FsCqgiN5q4UmdbsJEXMRL8R3GB/zriuUJld+YBlfkLwjeMAIAtAdChBqGu845F1Ueew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467953; c=relaxed/simple;
	bh=ORd3/cpAV5GcPYwc+WPYd5O7xJYburtSz5nfr0Ut/GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syzKS/ALQ48UfxKDN0yWncsX1Pw5O0NDvBfkLkIeotlZvHubTKZhkxHNZ+3zcIGN0omaBgmg5+eW7baJzB+qHyqTaMPw3PGoh2LNgUcLtI7vfkc3/Y/WSQp+U2L4lMXNh9qqktAapGpyh7rmu822ZJkT9+XGOd8gtmkgFiCO+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p8ULPTtY; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768467947; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nK1eWVbNSIRh93hITJz+ylcy5Dqif/rIkygb1uLgTnU=;
	b=p8ULPTtYv+3lwdL1OzeUJ5hAyieP1ojhLozfR0DW42FW/Zc7pO79gMAm1Yzqfe8g4LByQZmIgNFf6oAxy/263RjnpTvO1py6yr99uJD6wUFmgvZFPV7vi6CP8/whYhYTBp5Q8ZqO/Nji55yVHao1zHr4DWn3Dtc3ybU04aFQvBQ=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx60XE0_1768467945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 17:05:46 +0800
Date: Thu, 15 Jan 2026 17:05:45 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWit6bbjwfTzDRQw@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
 <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
 <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
 <aWew4SHS4c34z0AU@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWew4SHS4c34z0AU@bogus>

Hi Sudeep,

On Wed, Jan 14, 2026 at 03:06:09PM +0000, Sudeep Holla wrote:
> On Wed, Jan 14, 2026 at 10:28:19PM +0800, Feng Tang wrote:
> > 
> > As for the original issue where kernel printed the error message
> > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > can we just printed out all the CPU entries of the PPTT table? 
> > which is much cleaner and smaller, and have the enough information
> > for quickly identifying the root cause. As the number of cache
> > items is usually 3X of number of CPUs.
> 
> I am still not sure what additional value is gained by listing all those CPU
> entries. On a 512-CPU system, for example, if an issue is identified with the
> entry for CPU 256, what extra information is obtained by listing all the other
> CPUs, such as those sharing the same L3 cache or entire list of CPUs on this
> system?

My bad that I didn't make it clear. As for the original issue, the
platform has 8 CPUs, but the PPTT table only has 4 CPUs, while the MADT
and other tables are correct about the CPU numbers, and kernel does
successfully bringup all 8 CPUs. The PPTT message
" ACPI PPTT: PPTT table found, but unable to locate core 1 (1)" is kind
of modest and didn't caught our much attention as all 8 CPUS were onlined
fine. So with the "print only necessary info" suggestion from Rafael,
it will print out only 4 CPUS, which should immediately show the PPTT
table itself is wrong, and worth deeper check.

> 
> The message above already indicates that something is wrong with core
> (n = 1 in above case). If that is not sufficiently clear, it should be
> improved to be more specific about the issue. Simply listing all CPUs in the
> PPTT provides no additional insight and only results in an unnecessarily long
> and distracting CPU list in the kernel log.

As the print will be embedded under a default-no kernel config as we
discussed, and only be printed when error is detects, it may still be
acceptable regarding kernel log buffer? Or, any suggestion on how to
check the PPTT table to help future debugging? thanks!

- Feng

