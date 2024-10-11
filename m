Return-Path: <linux-acpi+bounces-8708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D482199A078
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56378B239A6
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1F210C23;
	Fri, 11 Oct 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfGU+NTN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBA210C14;
	Fri, 11 Oct 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640431; cv=none; b=sKZAjjmJtlobdLFEMaZp2X7N5u2K6RIQ927SJXDTsiA53+5krI5Mqy4IvPJTCCmI7YQ9aRPbLbnJspOKG/0DA461bHGYn9cC2s/Bm8TpZoSFgv2nNg8yJTKbIerOeBBjYI8w3dLwnETpxZmOpTcNz+ZW4BclP9kXPtI52s1o29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640431; c=relaxed/simple;
	bh=eIZqDQo5dLLSytToQV22Rpep2s3UOmTEEKU222/W4XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blwVoOPKK15/f2lKsPVSG2f7c4DMEKI32JET2pvdh9ARTrgMVu5n0mG0h9oUSl47b3K1FmiYQ3AiqN0J6aOfltcOYZrFPlyiVkNR4OuT18P8HORDQF3cUf34015X89EPOBMLKl3+GtAgGDgmuH5ti2kAnJtjSALUSyTj8RhZoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfGU+NTN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640430; x=1760176430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIZqDQo5dLLSytToQV22Rpep2s3UOmTEEKU222/W4XI=;
  b=JfGU+NTNO+aea5bsmyljKOWMZ+DGVVKYVVIP32uz7jJxafarrSAUyJpk
   V+pMkQoWzxu1bi+hK1StvL17l2TrPUdEI9GJn7TGhweajJAj2W0wGAHrd
   8Grr5torT2X+3q6UGZGdZwlN4HhZfiFfIO5WZsZzR0VokHTKRLrZAG7lz
   r7whdxjv+u/Beg4FTyNuZa7iJG+37y4Gwz9zJT6TXtPLp8TO0Qgi+SJbY
   RXsS4vLgXyH5AQh7erciNrd4zHMFPFvnWsBayDwb3u7hm0VpVAVGVHqxk
   P3PYoS6Bgy2/xAEfskzE8G+idIqAMpBXcYpZNygLLsd/wxTx6//RxUjr6
   w==;
X-CSE-ConnectionGUID: A4mOLC9eQtC6WRkOzTNuEw==
X-CSE-MsgGUID: TWOICVdCRbO6Vnfe7YKMcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27844078"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27844078"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:53:49 -0700
X-CSE-ConnectionGUID: Ia+MkacoRnmGu2jnfXQXwQ==
X-CSE-MsgGUID: 5TGN61KMRLe6uaY2CIEMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80871058"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:53:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCLA-00000001qiD-14yV;
	Fri, 11 Oct 2024 12:53:44 +0300
Date: Fri, 11 Oct 2024 12:53:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011061948.3211423-2-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_HAS_IOPORT will soon become optional and cause a build time
> failure when it is disabled but a driver calls inb()/outb(). At the
> moment, all architectures that can support ACPI have port I/O, but this
> is not necessarily the case in the future on non-x86 architectures.
> The result is a set of errors like:
> 
> drivers/acpi/osl.c: In function 'acpi_os_read_port':
> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
> 
> Nothing should actually call these functions in this configuration,
> and if it does, the result would be undefined behavior today, possibly
> a NULL pointer dereference.
> 
> Change the low-level functions to return a proper error code when
> HAS_IOPORT is disabled.

...

> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +		*value = BIT_MASK(width);
> +		return AE_NOT_IMPLEMENTED;

Perhaps it has already been discussed, but why do we need to file value with
semi-garbage when we know it's invalid anyway?

> +	}

-- 
With Best Regards,
Andy Shevchenko



