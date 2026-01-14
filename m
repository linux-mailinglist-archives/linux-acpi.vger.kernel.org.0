Return-Path: <linux-acpi+bounces-20321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89350D1F6A9
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E05F3020490
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993392D97BB;
	Wed, 14 Jan 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LHm6Y8m7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10579286416;
	Wed, 14 Jan 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400906; cv=none; b=MkYZTJuOHcPNptNo7zP//ZI2HiHQO9TwWjyh0WdSKmVm0UxJEre5mev9RoDe1gEGVyqj4SRm+27PTnqfoDtsLuxXiruZ3u2YT842koWeDGw70+weC6Dl4RIzKv43w27D5EKeQwoMH21678fGjr9RlJdtgNrqX5gHOVuhCrReuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400906; c=relaxed/simple;
	bh=dEgz23FFfu4f1kLXVWZPzTpFA+XngIDOaxOHF32UHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucKuORcRf5DMon7VvNN15NwkhhUIVvEDd81ncG+/U3VX4IIf278//Utiu85U1E9yO7wK+/j3sLXF0gJ8S0eDWQfKRXI1dFhEoavjCx5WnV/EnomdpOC30lIBRxVKBPiWbvVnUzwiEd/wlb0151T07NZBoTyR38ItYmDi1AHzupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LHm6Y8m7; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768400901; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uHmQCxSU+Nsl2SI1GGnceOYZhOceZM7EOZK5RO7J8Pg=;
	b=LHm6Y8m7PEA17DzqSAOE9Kj2TbUinQZ0nff2y3kmY5zaRkFp09ootFBPi4Adk06Oz9i6aEi2A/By8a6e3woDUa6OTjpBNxv5A+JDec1IDh3eVNxic0RoeJTOAUEuZ+e3l+1vFz40wxuDVIY8vds6WSPXnQEtWkPBQBHuADQ1+fw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx2jRmn_1768400899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 22:28:20 +0800
Date: Wed, 14 Jan 2026 22:28:19 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
 <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>

On Wed, Jan 14, 2026 at 12:36:58PM +0100, Rafael J. Wysocki wrote:
> > > Sure, that could be an option as long as CONFIG_ACPI_PPTT_ERR_DUMP is default
> > > off and are enabled only when debugging and not always like in distro images.
> > > Does that work for you ?
> >
> > Yes. It sounds great to me.
> >
> > > > We have had this in our tree for a while, and the good part is it gives a
> > > > direct overview of all the processors and caches in system, you get to
> > > > know the rough number of them from the index, and items are listed side
> > > > by side so that some minor error could be very obvious in this comparing
> > > > mode.
> > > >
> > >
> > > Agreed, but all this info are available to userspace in some form already.
> > > What does this dump give other than debugging a broken PPTT ?
> >
> > It is mainly for debugging issues. Though we locally has option to dump it
> > on boot unconditionally to help kernel/BIOS devleoper to have a quick
> > overview of the PPTT table, as the table gets updated from time to time,
> > or sometime the kernel could fail before booting to user space.
> 
> The kernel message buffer is not a great place for dumping ACPI tables though.

Yes.

> If an invalid PPTT prevents the system from booting, print out enough
> information to identify the cause of the failure.

Good suggestion! We do have some cases that wrong or missing info
of some ACPI table entries cause boot failure like IORT table.

As for the original issue where kernel printed the error message
" ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
can we just printed out all the CPU entries of the PPTT table? 
which is much cleaner and smaller, and have the enough information
for quickly identifying the root cause. As the number of cache
items is usually 3X of number of CPUs.

> 
> For everything else, use the tools in user space.

OK.

Thanks,
Feng

