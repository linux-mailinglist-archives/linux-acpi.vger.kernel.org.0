Return-Path: <linux-acpi+bounces-6615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CE917B1C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0EB1C23478
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C730215D5DE;
	Wed, 26 Jun 2024 08:38:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979813B78F;
	Wed, 26 Jun 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391126; cv=none; b=fqAjnLhs5SD7mrfep82v77tJVgjbYGa2Uj65vM/Xvml/A9p20r013C4RrCETPFjPbGYT0HCzGNE38LoUNx1NAlvQRiBtKkuGF+wNfHDnrtbXoBjKxJemV8R+1qSLOtBcbG69lEDbGqoQMrGrLwl0YnAi2DNo4lQZmEh5FgT0lSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391126; c=relaxed/simple;
	bh=x66Rh0wYxbl1wMrelc5Hg4gRCofkzrUK9eT8THP9DA4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXUjvsMu1+8U1JdFpVRvvCnrFYvBshp4+eRth+3oh9XX/Q/jcQ15riY7U4U4TnFuRdMLscbnATKzlgsg5Ob9YmGbMNK6OJgWR+/amcqj0Pu9lmYVu6phE8R2Xo/6kkHtfE6llpXKRjbvbOO0RZLFgsqtafvylnMNhiFmlY7aY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W8FRt1rtrz6K7Fc;
	Wed, 26 Jun 2024 16:36:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE69B140F09;
	Wed, 26 Jun 2024 16:38:39 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 26 Jun
 2024 09:38:39 +0100
Date: Wed, 26 Jun 2024 09:38:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <20240626093838.000007dc@Huawei.com>
In-Reply-To: <66747a1d7d4b0_1daf294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240605101012.000041e4@Huawei.com>
	<6670c5b267a79_3101294e2@dwillia2-xfh.jf.intel.com.notmuch>
	<20240620183701.00000029@Huawei.com>
	<66747a1d7d4b0_1daf294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 20 Jun 2024 11:51:09 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > > I'd drop the 'may assume'  Also after this change it's not reserved.
> > > > 0 explicitly means transparent cache addressing.    
> > > 
> > > I am just going to switch the parenthetical to "(Unknown Address Mode)"
> > > because "transparent" does not give any actionable information about
> > > alias layout in the SRAT address space. So system-software can make no
> > > assumptions about layout without consulting implementation specific
> > > documentation.  
> > 
> > I'd like an option to indicate that we know reported errors will not
> > involve problems with aliases. Something like...
> > 
> > 0 - Unknown (all bets are off, read the manual).
> > 1 - No aliases.
> > 2 - your one.
> > 
> > A simple write-through or write-back cache would not result in aliases
> > for errors reported by the backing memory.  
> 
> This seems a separate proposal, and needs more discussion because there
> *are* aliases. While there is no HPA aliasing, there is a FRU
> (field-replaceable-unit) aliasing. So if system-software wants to
> determine what indicators to fire (i.e. replace cache-mem, replace
> backing-mem, or both) to the tech servicing the node it needs some ACPI
> help.

There is  a case for FW first CPER etc (or a side cache specific driver,
ideally binding to a suitable ACPIXXXX but that's a different ECN :))
having to identify errors coming from a memory-side cache but I don't
see it as an issue that sits in this place in the spec (or even this spec).

For the CXL case, the event record tells you enough info on where poison
originated to rule out or in the CXL device as the problem.  There is
a gap I think in errors for memory-side cache and agreed that's a
different ECN.

> 
> I would be ok to do:
> 
>  0 - Unknown (all bets are off, read the manual).
>  1 - Reserved
>  2 - Extended linear
> 
> ...just to try to keep the list ordered by complexity for now.
> 
> However, I am also worried about the case where folks want to do "noisy
> neighbor mitigation", which is something that has been attempted with
> PMEM caches. This involves knowing the layout of cache conflicts which
> need not be linear and involves reading the manual. So, I am not sure
> defining a "no aliases" indicator now improves the Extended Linear
> proposal, or is an improvement upon "read the manual".


It tells you if you are trying to do poison repair you only need to write
one 'cacheline etc' from the host, not several.   I wouldn't attempt
to take it any further than that due the sort of trickery you mention.


> 
> > Assuming we don't get an address corruption (in which case everything
> > dead anyway as uncontainable error), then poison can come from:
> > 1) poison happens in the memory itself (fine, the DPA in CXL is enough)
> > 2) poison happens in cache and is written back to memory. (fine
> >    the DPA in CXL is enough).
> > 3) poison happens in cache and is read by host. Synchronous handling and
> >    the HPA is available and enough.
> > 
> > Not much we can do with 0, but 1 at least lets us know we have the
> > single right answer.  
> 
> That is, assuming that this is caching CXL. With CXL, the DPA
> information is available to disambiguate the source of the poison, but
> for memory-side-caches that are not backed by CXL, what does
> system-software do with that "1" case?

If it got an HPA it does an arch specific poison clear on the HPA address
or isolates the page with that single address. If it didn't you have
no useful info - wait for synchronous poison.

Jonathan



