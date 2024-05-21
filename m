Return-Path: <linux-acpi+bounces-5909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DBF8CAFD4
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930701F2194A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EDD7C6C1;
	Tue, 21 May 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GED+tXhJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435A1E502;
	Tue, 21 May 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300016; cv=none; b=s/3Besofhh+5A55A23DjvIRCECGOI7VCRqeVPGMcPreDMOG9n+CKCVgstjpU7t6YSBGrL5/BM/IryA0N3mDPVW+tdaRaNBgx6li7cX5zzOASWuFgssOSvZmL4hW8tLecDJ9LrLk5XCxxr9qBXcz2Qhmq36KCMzQc9nn9L4UOWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300016; c=relaxed/simple;
	bh=1fC1qPkHIzJeKGkFtyxB3WvFL7tvcX3u9xMga4DyzdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKru6iv4CpOO3307B67R5QuLsfIUY7F6/Qrm59snCVg7gW4+omeprvfTmWJiIxZONuuavzIpmDwdZtKgyiUOjDRwVT3LdRrzFgd6HpBolLZnC0EeLsYXXot0wdmaTv+u0gDxTcPHsdL3o8MMwugFxzTWP2fwVb5eQQSuvzvb76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GED+tXhJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716300015; x=1747836015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1fC1qPkHIzJeKGkFtyxB3WvFL7tvcX3u9xMga4DyzdM=;
  b=GED+tXhJWaBT6iq2YZ9TiYJpplDYEpVn+Mag5IVZTOCjVMC2xHjIjNx2
   uPArEkvz/+lmz0zndvnUaKJBpvUoReuuqHE80J3nHub5bEfMcTWm8UFrQ
   n9WiH3o/JwcEHjIWwk+itGXZm7HuFP03KAThvVv9DTDc2v8cTititeDvg
   /xQUxdx/FWAKVRUswEcC0kiYS4+bFy0kgd1SNAibkrWc4BUxSB82xB24n
   aRZ/B4Vc/MVOTKLqH4IRxeCkRUJvwxgJekjce1DNPRZqLKQoeGS/hBh26
   2qr1VshiPpywsqHp1swwG1PEqjtlFjBrksgJRsOvC4YwfK+N1jDOnECGm
   w==;
X-CSE-ConnectionGUID: iytRVh3hQdabtI2Ydo+yrA==
X-CSE-MsgGUID: 5KIGelyUS2KVGTaU8gpB2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16334075"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16334075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:00:14 -0700
X-CSE-ConnectionGUID: D+4sqOvIR1S+ndvCyQ4I8Q==
X-CSE-MsgGUID: CHCjpVRuSsq5mWwTi2UUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33531814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:00:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9Q2D-00000009fnx-0Pr9;
	Tue, 21 May 2024 17:00:09 +0300
Date: Tue, 21 May 2024 17:00:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Laura Nao <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
Message-ID: <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.05.24 12:02, Andy Shevchenko wrote:
> > On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
> >> Following the relocation of the function call outside of
> >> __acpi_find_gpio(), move the ACPI device NULL check to
> >> acpi_can_fallback_to_crs().
> > 
> > Thank you, I'll add this to my tree as we have already the release happened.
> > I will be available after v6.10-rc1 is out.
> 
> Hmm, what exactly do you mean with that? It sounds as you only want to
> add this to the tree once -rc1 is out -- which seems likely at this
> point, as that patch is not yet in -next. If that's the case allow me to
> ask: why?

Because:

- that's the policy of Linux Next (do not include what's not supposed to be
  merged during merge window), Cc'ed to Stephen to clarify, it might be that
  I'm mistaken

- the process of how we maintain the branches is to have them based on top of
  rc1 (rarely on other rcX and never on an arbitrary commit from vanilla

> I'd say it should be fixes rather sooner than later, as other
> people might run into this as well and then have to deal with bisecing,
> reporting, ...

Yes, but we have a process during merge window, it's special and different
from vX.Y-rc1..vX.Y times.

-- 
With Best Regards,
Andy Shevchenko



