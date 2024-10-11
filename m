Return-Path: <linux-acpi+bounces-8711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614399A280
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 13:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A461C20F4A
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C82139A8;
	Fri, 11 Oct 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpBIKj1o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1E17D2;
	Fri, 11 Oct 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645150; cv=none; b=GkqAjQD/siDg8OxVkyfvd6hWWsi8q5kSMENYNJjsKZzzJNLKEKgHlFABh/7G65WGkpOLDIQcI8MZEKIeNtLGnMTYZz+cY+qxViY8M6R3mVPcHFGA1QEbFjgzkoXoTtzZDBA+vQTyNoiFHnrGbYn6PQUAfJIcSlIxFKutaH7/FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645150; c=relaxed/simple;
	bh=GjFn+RXzDnuXWLSd+mRX9b2+JvLHsAtjbnQenqOhY7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9GwuqMHxVKNwxuvP//w0Dl26VuJXwXgyacpkBXNN01UlX9kCagjw0xubCrU2dN8LGs4sS6JhilojRcXRTmknI5Uk2KTyNOO1dX61DFZDmeuyk+7hFjJLblbhEVHE/LINxIuAhQ9QpJytCNUcDNUL0/ytKzdYUz8vPGTOfAquWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpBIKj1o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728645148; x=1760181148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GjFn+RXzDnuXWLSd+mRX9b2+JvLHsAtjbnQenqOhY7o=;
  b=LpBIKj1oBjQvswkK13KXM9GGKTvRIY7AJZphyoJ+jiQ2tiJL0XRIu4WD
   NHvP8F2vHhsT9u3mvIOmjbjMnde4YA4rIOrzMkUoH/FGbFzOrUy4bFg7B
   bFpusS4lMGUDFCiouxfnrwUBvA28+WGs5mqizKv4U/bnTnrawuZlmux4s
   3wkHZC6bg0zD9Z2IMQugqGVwNzXhsC/7u3mUuHVsiAFUPIz77oXcymFsR
   77m23ZGMehyYgsDhmGt068AACvoUb+fUuaEbyP7Z6g2Kvx4HW3Lzp0o0E
   3lDOSCKWIh0LjmIJRwq5RIdjwbXbwqd9o7s+cqY1svDtMu/J3+8VbaR80
   Q==;
X-CSE-ConnectionGUID: 7zEgB/flQZyQguLCze1Y6Q==
X-CSE-MsgGUID: H5ZArsgPQYSRLH0n69sCcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28151015"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28151015"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:12:27 -0700
X-CSE-ConnectionGUID: 7x+1jgOnRKCXwgXho0SGyQ==
X-CSE-MsgGUID: +UmUCXfeTm2o0qp3eRMp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76797912"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:12:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDZF-00000001s68-3E56;
	Fri, 11 Oct 2024 14:12:21 +0300
Date: Fri, 11 Oct 2024 14:12:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
 <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 09:59:46AM +0000, Arnd Bergmann wrote:
> On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:

...

> >> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> >> +		*value = BIT_MASK(width);
> >> +		return AE_NOT_IMPLEMENTED;
> >
> > Perhaps it has already been discussed, but why do we need to file value with
> > semi-garbage when we know it's invalid anyway?
> 
> It's not strictly necessary, just precaution for possible callers
> that use the resulting data without checking the error code.

Do you have any examples of that in the kernel?

> The all-ones data is what an x86 PC would see when an I/O
> port is read that is not connected to any device.

Yes, but it's not what your code does.

-- 
With Best Regards,
Andy Shevchenko



