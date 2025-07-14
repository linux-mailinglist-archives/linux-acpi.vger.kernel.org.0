Return-Path: <linux-acpi+bounces-15153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B657CB04A7F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1066F1A646B2
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B201265CD0;
	Mon, 14 Jul 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/DzskkK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC72417F2;
	Mon, 14 Jul 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531708; cv=none; b=G2ccfXnbWkoBjFyPw3Xmln4rjfWJfWlfjRTtXAfRAGieunrWXzXjoIgJmGUCx7AmBNM5BdcPMiRxk+LjnsKnw3MFMe4tP3b+CSvKrEqOukV3zDbqzfA7knhrLjB6KEBBhRf1/m4Vps/0jjrJ9jnYwHOjAUUmLQT35cCfZn+odiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531708; c=relaxed/simple;
	bh=gob8qkgliZxPkWX7FZAA+iLSehjFtaMX8AhTrYAAosE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJxLEKzm1ia4W4tv0v4zwIPQkvdrT728gxpGJwLZmdWhL1JPZGBtwBcNqs3rR33gbg+L1YV3iSr+ZDO4LOG+GyBU1gzPQpvRyBJfk8RAV2yaHOVbNCudY0p7XHs1rI2+2EVjmTuS+w67VqyMdstXSGsG6s/ZjsejtyaLyn7xqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/DzskkK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752531706; x=1784067706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gob8qkgliZxPkWX7FZAA+iLSehjFtaMX8AhTrYAAosE=;
  b=l/DzskkKICYRe/ZV7jQR2peLnPprYRTXGlrFs/fNLi03zIg/dHw/rrDB
   xNhFFeNl9/YWM9/BOq91ZwW0FQehtkbLc1HyV23pq4olu4xhheUQWUl4J
   m5P5UcS6OSUSA9I/6dnihwr5MFsxGX29Njsu3GpuPeh1jj4nvX+KQDaRz
   m9jr1i+MPhI+Y6CKgv1OLKbgt2tRXinIoTjIm8O2XqWT/AU0CFHcwR4jF
   B0Tp7/gvhSWo41FAS58YYfi0ihwgWzoERWfVatmBn1Z3Q8Igs5h1TAcRN
   zRWvHBifcqEccd1MK0FPf0L6mfVWFgzXWwEH1YYzCljGI/gsBS09hUK/h
   A==;
X-CSE-ConnectionGUID: gKBjUJ1YTyOEiMpPp0xXzA==
X-CSE-MsgGUID: TbHk8vMaQkmt/Z2CZp+smw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72313910"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="72313910"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:21:46 -0700
X-CSE-ConnectionGUID: iz+JpsTaQLi9IFSI4bD3hw==
X-CSE-MsgGUID: msxzYfwBTkWy8pACtUaT7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156686024"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:21:46 -0700
Date: Mon, 14 Jul 2025 15:21:44 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <aHWC-J851eaHa_Au@agluck-desk3>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>

On Mon, Jul 14, 2025 at 07:35:56PM +0200, Borislav Petkov wrote:
> On Mon, Jul 14, 2025 at 05:33:45PM +0000, Luck, Tony wrote:
> > > If you're going to do this, then you can perhaps make this variable always
> > > present so that you don't need an export and call it "hardware_errors_count"
> > > or so and all machinery which deals with RAS - GHES, MCE, AER, bla, can
> > > increment it...
> > 
> > Not sure I'd want to see all the different classes of errors bundled together
> > in a single count.  I think MCE recovery is quite robust and rarely leads to
> > subsequent kernel problems.
> 
> That's what I said. And a RAS tool can give that info already.

There's some value in it being in the kdump file, rather than having
to correlate data from multiple places. That's both time consuming
and error prone.

> But for some reason Breno still wants that info somewhere else.

So what about something like:

enum recovered_error_sources {
	ERR_GHES,
	ERR_MCE,
	ERR_AER,
	...
	ERR_NUM_SOURCES
};

static struct recovered_error_info {
	int	num_recovered_errors;
	time64_t	last_recovered_error_timestamp;
} recovered_error_info[ERR_NUM_SOURCES];

void log_recovered_error(enum recovered_error_sources src)
{
	recovered_error_info[src].num_recovered_errors++;
	recovered_error_info[src].last_recovered_error_timestamp =
		ktime_get_real_seconds();
}
EXPORT_SYMBOL_GPL(log_recovered_error);


PLus code to include that in VMCORE.

Then each subsystem just adds:


	log_recovered_error(ERR_GHES);
or
	log_recovered_error(ERR_MCE);
etc.

in the recovery path.

A count is just a hint. A count with a timestamp that is shortly
before a crash is a smoking gun.

-Tony

