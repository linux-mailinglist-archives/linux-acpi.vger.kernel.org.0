Return-Path: <linux-acpi+bounces-9124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42719B671E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88576281EDC
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352F2141B1;
	Wed, 30 Oct 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVlILVSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5E213EDC;
	Wed, 30 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301203; cv=none; b=sVNPEur+3ELMmfdOR/iZvkl+lfkUqbV0nBU/5I5Jnjs5PWK6b+1+DDKB7BeRlKbjwPVBa3n+PF3YoLya+/UTNovUVRknm4MLjp02ZqzLFIcn84hVtvQayF8VVtexc0pael7iroHzurnVejX40v7YKP/6dpo3nyJiZGREmVeYmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301203; c=relaxed/simple;
	bh=LuEdHPduW79U4O3XLY1gGdLAM5ujOyiDtRI4qWqVFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhVlMKLhwtOnOb8GUceiCwkylh1D9zpb+vUlhbTZgHgjxyc+HE9B8XAXrpv6CeRxrilWE9USzM3WjGDt2RMplYxi1WqaD+64KQXuXKimffkczPR38tHBo8NXuCm4eLIN4F3QDRVsh7vKiUZ9MFCMIhAFRkurmfjVQGkOCIPC8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVlILVSM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730301202; x=1761837202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LuEdHPduW79U4O3XLY1gGdLAM5ujOyiDtRI4qWqVFuw=;
  b=MVlILVSMqBqJr+ur2kOCgWTBEMgJ5f2P0hmTB626dy27BOwQZjrByH7E
   nqoqHccGoj7q+NVJLyqQfjLVHSAnitSk7tGuB42RaAfNhUu2WBkNUqn17
   JzT8PGPCf6jsFHrQWEATenbYpnNFnY4eWPV5q8I8VJl8Q22Lp0AFTCtgY
   acj5bFxq5jPOukkiMVVRbC/nkP/+7XeSceKi/C/+UhuwS1jaxDQ6jgDh5
   y8tTKRJ0SxiZ4pDOVJb47ZDp81aJVnc5MXMCyr/86eg5Q/xG+c6i/UXOS
   4lQuPCX8mNZ3LC+eIsnemCvnsAw4g4m5KICFBJJxh4bl7TDTlRzsb7Fuw
   g==;
X-CSE-ConnectionGUID: hjHz78dIQ/SCIGpn8cLgdw==
X-CSE-MsgGUID: 8LY0ubjsQkqH/LQDkLp5QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40542002"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40542002"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:13:20 -0700
X-CSE-ConnectionGUID: re2uEumQTOy26heq2IEy0A==
X-CSE-MsgGUID: xWhHf4zATleSPYPwptJ85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86953417"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:13:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6ANn-000000094nf-3BxU;
	Wed, 30 Oct 2024 17:13:15 +0200
Date: Wed, 30 Oct 2024 17:13:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <ZyJNC44r11a83FlI@smile.fi.intel.com>
References: <20241030123701.1538919-1-arnd@kernel.org>
 <20241030123701.1538919-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030123701.1538919-2-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 12:36:41PM +0000, Arnd Bergmann wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +		/*
> +		 * set all-1 result as if reading from non-existing
> +		 * I/O port
> +		 */

Don't know if Rafael can / want to tweak this, but would be nice to follow
standard style for multi-line comments.

		/*
		 * Set all-1 result as if reading from non-existing
		 * I/O port.
		 */

> +		*value = GENMASK(width, 0);
> +		return AE_NOT_IMPLEMENTED;
> +	}

-- 
With Best Regards,
Andy Shevchenko



