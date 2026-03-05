Return-Path: <linux-acpi+bounces-21392-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g2XRHYQsqWlK2wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21392-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:11:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3920C36D
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9A33026AA3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468930FF32;
	Thu,  5 Mar 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6UUu1RD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5329B233;
	Thu,  5 Mar 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694656; cv=none; b=QQCtYm3vi4OH0JDS0xFBJGAmeK/ZFLq6UoI57xNBzhPhdLtFSJvS0yuwvGyVi40+uyiNoVqi8FGTDE9He2zQSLssbeHeHnKFqzD4wolUt0r2kY99keRQVzLfkJsB5ocm/K2c4BfVeplHPGmjFhw+pMaJpC3iMwx20Fdz7qkbglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694656; c=relaxed/simple;
	bh=BrBsfcEwmxCSZNukAXJqgEdJ3gvsxcJ0292168bXN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK4Frjm7ZglJEhOo/M94x9g7J/X3uvJ0y//1Vx+5ZMunOSJ+0VnSrXEmjfUS89a9P8lRnK+WND92lEzS/rb7zpJLiayMUnHRxI13w5oGfTl6/iKYCZ5uYXCDUn5Y58ASgeGOka0AKHXNIwVfx64VGqXDFDixz61ab9rT2k7zVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6UUu1RD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694655; x=1804230655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BrBsfcEwmxCSZNukAXJqgEdJ3gvsxcJ0292168bXN4E=;
  b=Q6UUu1RDvljtcXbIJ5iFTYfrZHxV9fBV/lnyyVYJ5F3g2M6SjGLDsHmV
   Oyqm9WRm1oBBlRJYTL3PdgB4+8PbYc8VHNmplUQKIAjVvhrTHvK4N87dn
   PKB1C99zhA8zwExc647piym65TGMs0/drfPPf85ZvSe3KBblNvxzzEEJV
   TXW0UDwOvnxP9TCiJwC33LkkTQiI2yNAeGLFzBaQki5vOqU9WFHzhFUSs
   MFjVKHQxYRY5yf89Qzgw3v6FpMOA9HZNNfwFML8wG56G7SYyMZBI1zMPJ
   SkMsOzmDJ/5odlYY7uT/ZHbWg398vxjrPhWAdQcwkOaJWGdh6rf3QDEfd
   A==;
X-CSE-ConnectionGUID: OlpGE/YzTZuziRrSpCa8MA==
X-CSE-MsgGUID: XLMWZSAoT4+J05yNTL5BKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73680385"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="73680385"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:10:54 -0800
X-CSE-ConnectionGUID: GtwM292MScy7vodUxQ/Log==
X-CSE-MsgGUID: qoHORzIZTEWkjmZm8th41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="256476371"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:10:52 -0800
Date: Thu, 5 Mar 2026 09:10:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: acpi-als: Convert ACPI driver to a
 platform one
Message-ID: <aakseadAuKEMAmvq@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
 <3609079.QJadu78ljV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3609079.QJadu78ljV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: C3F3920C36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21392-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:33:14PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI ambient light sensor driver to a
> platform one.
> 
> After this change, the subordinate IIO device will be registered under
> the platform device used for driver binding instead of its ACPI
> companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.

...

> -static struct acpi_driver acpi_als_driver = {
> -	.name	= "acpi_als",
> -	.class	= ACPI_ALS_CLASS,
> -	.ids	= acpi_als_device_ids,
> -	.ops = {
> -		.add	= acpi_als_add,
> -		.remove	= acpi_als_remove,
> +static struct platform_driver acpi_als_driver = {
> +	.probe = acpi_als_probe,
> +	.remove = acpi_als_remove,
> +	.driver = {
> +		.name = "acpi_als",
> +		.acpi_match_table = acpi_als_device_ids,
>  	},
>  };

>  

You can also drop this unneeded blank line.

> -module_acpi_driver(acpi_als_driver);
> +module_platform_driver(acpi_als_driver);

Anyways, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



