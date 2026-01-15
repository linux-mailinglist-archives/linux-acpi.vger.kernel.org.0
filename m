Return-Path: <linux-acpi+bounces-20373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19546D2405F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D80F3013306
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227536D4E6;
	Thu, 15 Jan 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CJZiYdCM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747133123E;
	Thu, 15 Jan 2026 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474340; cv=none; b=qtI3mVd2WPNSEuKaudpBVIitCJka+EkxR8IeJfOSLgifDcCy6dIfWN7SDU8bFcCCoh4ZKrW/xnXDbOJ4fh7CyBNrY3DXuNEcPd3e0fBb4KEB9z/iqNmf7fNLj6ty94a3bq+VUTOPTdfsW00wep4BNR9iYeEx24OF6F2JwG5XE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474340; c=relaxed/simple;
	bh=d5ic5UjjSJbUndYwrwl9ywLTfsNx3edbp0zUfoAnl6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/UDv80YJ0dl8Dz+oLuIESj2iE8qLaoJzXLt+gqhBMf1SGqy9vf7skx6Y0y+Uxfxfyhp+JbKM0e0GzT4IwnN1R+jvDwmHD/j8oAwyAFauboXPbxOegUCIMzgNLJMDieNWRthbfMsASIyFBXxuyOh5wD8+wxl5zEjMfsVEemOghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CJZiYdCM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768474329; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=wfTNfIK//2QZfS4cueGR7+8oULaDBEyK6LYtP0zcy38=;
	b=CJZiYdCMpgiNZWpgzdlX8xe/JMyHzFIrklzvFNI+B7xIVED1Snf0m4KwQkS9jspQvW2Bno4IPOPxShkyRXQFOpnzWioVWvgVcGiZk4tI3PQyGSZphKME5Pj7PSwXHCHTe5wrFx0ILIPRvjT9aUYwQzkqz/DtV8XlvqvEV3pp0Rw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx6HLZG_1768474327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 18:52:08 +0800
Date: Thu, 15 Jan 2026 18:52:07 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWjG15INQHBJo6X6@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
 <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
 <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
 <aWew4SHS4c34z0AU@bogus>
 <aWit6bbjwfTzDRQw@U-2FWC9VHC-2323.local>
 <aWi7HjGDAGdRYjS6@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWi7HjGDAGdRYjS6@bogus>

On Thu, Jan 15, 2026 at 10:02:06AM +0000, Sudeep Holla wrote:
> On Thu, Jan 15, 2026 at 05:05:45PM +0800, Feng Tang wrote:
> > Hi Sudeep,
> > 
> > On Wed, Jan 14, 2026 at 03:06:09PM +0000, Sudeep Holla wrote:
> > > On Wed, Jan 14, 2026 at 10:28:19PM +0800, Feng Tang wrote:
> > > > 
> > > > As for the original issue where kernel printed the error message
> > > > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > > > can we just printed out all the CPU entries of the PPTT table? 
> > > > which is much cleaner and smaller, and have the enough information
> > > > for quickly identifying the root cause. As the number of cache
> > > > items is usually 3X of number of CPUs.
> > > 
> > > I am still not sure what additional value is gained by listing all those CPU
> > > entries. On a 512-CPU system, for example, if an issue is identified with the
> > > entry for CPU 256, what extra information is obtained by listing all the other
> > > CPUs, such as those sharing the same L3 cache or entire list of CPUs on this
> > > system?
> > 
> > My bad that I didn't make it clear. As for the original issue, the
> > platform has 8 CPUs, but the PPTT table only has 4 CPUs, while the MADT
> > and other tables are correct about the CPU numbers, and kernel does
> > successfully bringup all 8 CPUs. The PPTT message
> > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)" is kind
> > of modest and didn't caught our much attention as all 8 CPUS were onlined
> > fine. So with the "print only necessary info" suggestion from Rafael,
> > it will print out only 4 CPUS, which should immediately show the PPTT
> > table itself is wrong, and worth deeper check.
> > 
> 
> To be clear, listing CPUs is annoying on large systems. In your case, it may
> be only 4 CPUs and that seems fine, but imagine if one CPU entry is missing on
> a 512 CPU system - dumping a list of 511 CPUs is not only irritating, but also
> largely useless for diagnosing the issue.
> 
> In my view, for the scenario above, the error should say something along the
> lines of: the PPTT CPU entry count does not match the system CPU count.

This makes sense to me, thanks for the suggestion! Will check how to
implement it and test. The error happens in early boot phase, and I
guess only '__cpu_possible_mask' could be used for 'system CPU count'. 

Thanks,
Feng

