Return-Path: <linux-acpi+bounces-20368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69902D23C7A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75AB730124DA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0033DEDB;
	Thu, 15 Jan 2026 10:02:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7D332902;
	Thu, 15 Jan 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471333; cv=none; b=uzxbvgekvectz9IJ9SA60LLeGM/Za40AZ/A+K0Hi6r5HO3SknKq00R4Wp/8X4YvqxaIC6fyQtubv+nvYRK9BxUB0lQO443MnOqRfSfnLeu0lAyqhtsfrQILlJ22ZyTU92aXA/ZT0TWifKrvibutGydTJXlPNPAWR0EiYEb28gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471333; c=relaxed/simple;
	bh=7cOXmFb5/fAMKOB12FLK+H6kXes8B7FHL8ZrfhgWjeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbWoKja7fN0m0VFey4L7ViVgKhYNFpnmzr/blEL/MJ5kjIziz4L04qy5vYT3hXsfFuUwex/5teVtK6PXRg85ZpeKrpwhbc9i6uUWwA9GO6wai7/RVFLLxx3jqfKSqXfcbqvePI4a67AZOFtalAu49EnREVFpkhl1IdOGJtr8Mt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9ADD1515;
	Thu, 15 Jan 2026 02:02:03 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D4F3F632;
	Thu, 15 Jan 2026 02:02:09 -0800 (PST)
Date: Thu, 15 Jan 2026 10:02:06 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWi7HjGDAGdRYjS6@bogus>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
 <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
 <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
 <aWew4SHS4c34z0AU@bogus>
 <aWit6bbjwfTzDRQw@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWit6bbjwfTzDRQw@U-2FWC9VHC-2323.local>

On Thu, Jan 15, 2026 at 05:05:45PM +0800, Feng Tang wrote:
> Hi Sudeep,
> 
> On Wed, Jan 14, 2026 at 03:06:09PM +0000, Sudeep Holla wrote:
> > On Wed, Jan 14, 2026 at 10:28:19PM +0800, Feng Tang wrote:
> > > 
> > > As for the original issue where kernel printed the error message
> > > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > > can we just printed out all the CPU entries of the PPTT table? 
> > > which is much cleaner and smaller, and have the enough information
> > > for quickly identifying the root cause. As the number of cache
> > > items is usually 3X of number of CPUs.
> > 
> > I am still not sure what additional value is gained by listing all those CPU
> > entries. On a 512-CPU system, for example, if an issue is identified with the
> > entry for CPU 256, what extra information is obtained by listing all the other
> > CPUs, such as those sharing the same L3 cache or entire list of CPUs on this
> > system?
> 
> My bad that I didn't make it clear. As for the original issue, the
> platform has 8 CPUs, but the PPTT table only has 4 CPUs, while the MADT
> and other tables are correct about the CPU numbers, and kernel does
> successfully bringup all 8 CPUs. The PPTT message
> " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)" is kind
> of modest and didn't caught our much attention as all 8 CPUS were onlined
> fine. So with the "print only necessary info" suggestion from Rafael,
> it will print out only 4 CPUS, which should immediately show the PPTT
> table itself is wrong, and worth deeper check.
> 

To be clear, listing CPUs is annoying on large systems. In your case, it may
be only 4 CPUs and that seems fine, but imagine if one CPU entry is missing on
a 512 CPU system - dumping a list of 511 CPUs is not only irritating, but also
largely useless for diagnosing the issue.

In my view, for the scenario above, the error should say something along the
lines of: the PPTT CPU entry count does not match the system CPU count.

-- 
Regards,
Sudeep

