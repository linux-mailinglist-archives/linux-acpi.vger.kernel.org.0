Return-Path: <linux-acpi+bounces-13459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E6AA98EB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E12817D2E3
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078B267B87;
	Mon,  5 May 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTMZtu9W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777525D213;
	Mon,  5 May 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462540; cv=none; b=QRPvpWsEzoosTUvJgr9CKZ8mTahjwl6eyCKG6mmQVmK5uSUKXJgzAVgm8PLFD24UJTWM7ioqk3CiJRgbnrIau2q48SxrX9FpcmOht+PBFtSNySqTRah8V5A0RYopt2rINkVAKNLGNoBdd2FjcFnhY0dIsrSCoIFfFlctbFlEADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462540; c=relaxed/simple;
	bh=RAdRNqPXKqyJwulTZBW+PrhpwJw3N8ivnpxB+phgTKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm3Ne5AGWORxGfy4/RKS+Er661ZgfC5YcyKLC1Z/PGtVjoRbJYVYe0fyCljKp32Gk+ek05oGw6oc+BGmnMEdCykAJixqSnvSFTpocayOFB+rCMeej1gLyFbaKsDD7bai0Uy5wqorqQhsF58u763I6fCGGW9DJM35a8lZj49O4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTMZtu9W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746462538; x=1777998538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RAdRNqPXKqyJwulTZBW+PrhpwJw3N8ivnpxB+phgTKs=;
  b=FTMZtu9WFdE6iAUMfB8Tzu7QOnGYkT9UioCABLGYlvcWhDObW1swA6/C
   QzR/voX5F4qOATXUjUH157df2tdHJ+ru3nHrUmKLxUyPazpWJfnjm/Jqg
   hr+sEdT3rJblfWRxMM8ETK517eMI1FSewATlLFHJ9AYNiFOqtZVKYFDCg
   kTpwVLqc6l6nkpeoEZIRBBfhT1qSWjqFRbkIGZm1urA2s8iFeQ5vqMSn6
   j5W6ryP091lwO75igXTL/CwTTdSHKTTrvCRr7blciCTQNtNwLk0//me7B
   NSVW1U/FMmS0f76FgygbVk1SxEbHYWbXtdB3CxO9r1b7utJ9Po6u5uzT4
   g==;
X-CSE-ConnectionGUID: vldBAIDlQZyArtMZKczy3g==
X-CSE-MsgGUID: ky/KHv5UQueukkubLEkAIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59431627"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="59431627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:28:57 -0700
X-CSE-ConnectionGUID: JEdfwkK8Qpy+fJQPK92ziQ==
X-CSE-MsgGUID: omA/bASURruuYcYsShQZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="158514813"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:28:58 -0700
Date: Mon, 5 May 2025 09:28:40 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 3/4] ACPI/MRRM: Add /sys files to describe memory
 ranges
Message-ID: <aBjnOJpDgq2XlWqj@agluck-desk3>
References: <20250429202412.380637-1-tony.luck@intel.com>
 <20250429202412.380637-4-tony.luck@intel.com>
 <466e9d9a-d0f0-443b-93d5-58d0ba968480@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466e9d9a-d0f0-443b-93d5-58d0ba968480@nvidia.com>

On Sun, May 04, 2025 at 11:23:50PM -0700, Fenghua Yu wrote:
> Hi, Tony,
> > +#define RANGE_ATTR(name, fmt)						\
> > +static ssize_t name##_show(struct kobject *kobj,			\
> 
> "name" is used as a macro parameter. But "name" is also used as a variable
> mre->name in the macro. checkpatch complains this kind of usage.

The checkpatch complaint is that is is used twice. Once as "mre->name"
(as you noted), but also as "__ATTR_RO(name)" two lines after.

Checkpatch is worried that the macor might be invoked with an argument
that has side effects ("foo++", or return from function call "baz()")
which would result in the side-effects happening twice.

It's a false positive in this case because:

1) This macro is only used with a simple argument (and can only ever be
used in that way.
2) It's used for a static initialization of compile time, so a 2nd
reason why side-effects from an argment are not possible.

> Maybe change the parameter "name" as something like "range_name" to avoid
> the potential confusion?
> 
> > +			  struct kobj_attribute *attr, char *buf)	\
> > +{									\
> > +	struct mrrm_mem_range_entry *mre;				\
> > +	const char *kname = kobject_name(kobj);				\
> > +	int n, ret;							\
> > +									\
> > +	ret = kstrtoint(kname + 5, 10, &n);				\
> > +	if (ret)							\
> > +		return ret;						\
> > +									\
> > +	mre = mrrm_mem_range_entry + n;					\
> > +									\
> > +	return sysfs_emit(buf, fmt, mre->name);				\
> > +}									\
> > +static struct kobj_attribute name##_attr = __ATTR_RO(name)
> > +
> > +RANGE_ATTR(base, "0x%llx\n");
> > +RANGE_ATTR(length, "0x%llx\n");
> > +RANGE_ATTR(node, "%d\n");
> > +RANGE_ATTR(local_region_id, "%d\n");
> > +RANGE_ATTR(remote_region_id, "%d\n");

...

> > +
> >   static __init int mrrm_init(void)
> >   {
> >   	int ret;
> >   	ret = acpi_table_parse(ACPI_SIG_MRRM, acpi_parse_mrrm);
> This blank line seems redundant. Maybe remove it so that the "if (ret < 0)"
> sentence follows the "ret = ...." sentence immediately?

Agreed. I will delete in next version.

> > -	return ret;
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return add_boot_memory_ranges();
> >   }
> >   device_initcall(mrrm_init);
> 
> Thanks.
> 
> -Fenghua

Thanks for the review.

-Tony
> 

