Return-Path: <linux-acpi+bounces-9184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DC9B750E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 08:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BE828570B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37049148314;
	Thu, 31 Oct 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG88voDa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0D1BD9D4;
	Thu, 31 Oct 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358527; cv=none; b=LYE2tCz9hKJJbKq1ZjbEDN9nxf9VCBcZ/DqThZmgsHnYf06w9kLO9zONwasT1N3l9cgBDFghKEwbmTg5MbABDAOZDYJ7T+IRfROXxRjRkYX0CidT7MCzkua1o2rOBV6oPxpDQSE/0xiwuHVDbfEs4JJnYRwCx4Wc5+bCCXPXp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358527; c=relaxed/simple;
	bh=IDn+0uw1n+KZJJDlQX9EkB0sPuZecc7OMwI8wYbJWX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/yPSWpI0KvWY54HZOlMr1rJYx77WGez1l1XGcEL2Q+GZJQstbxNeZzGjimchOOXT/9WUO9tgCFUy0TlOXo7nuSTOz9nT1qJYGbUb3GS3J8CB2jU2+yk6BCqpI6yjLTjFxTqr+gXVaaK8heKezI66cCAf4gEoagvXDRvfU/iKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG88voDa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730358525; x=1761894525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IDn+0uw1n+KZJJDlQX9EkB0sPuZecc7OMwI8wYbJWX8=;
  b=NG88voDawtWDBcgQd+/sz8grvcvsCKmb0vMXGEneuTj5CMIseS7JpDFW
   3QqRu0kJpwrmlUcvY26VBYF7/4wIJksLzMF2PSHgvlXhlVeDzIJEapBWA
   fWTR0jSfAYpW1DYidyidItv4/1CFm4uuWcY/+efMHHjWBRTrOY8FeUmUT
   MuNsAbkJnSc4b9cSKXDLdovrn2u7HSvAu6zdNo2ETMxJPtfgkPNv9nz1c
   tzbXk5dpNMePrzt7w7ufR9U6P9o+OrrTW6EUe41NtHABEsX4vM6VEHGmo
   DDVX13nLjsjB8AK35awPtyS8/Si5+iBON1mtCBXCASktZBGm0G+fLRz+l
   g==;
X-CSE-ConnectionGUID: KFRpWEAsQLOYiFLqlGpCmg==
X-CSE-MsgGUID: bfBZ/AknTa+q6/cQ5Qs+Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55480938"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="55480938"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:08:45 -0700
X-CSE-ConnectionGUID: /XCVvICMThKo0AR8Zd9vLw==
X-CSE-MsgGUID: zFVmURDrSjiv7WVGPLOtAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87327784"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:08:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6PIO-00000009KOC-1J0c;
	Thu, 31 Oct 2024 09:08:40 +0200
Date: Thu, 31 Oct 2024 09:08:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: battery: Check for error code from
 devm_mutex_init() call
Message-ID: <ZyMs-Ao8lUfMqYdB@smile.fi.intel.com>
References: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com>
 <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
 <ZyJtXzIReSHfKkd_@smile.fi.intel.com>
 <550e1dd5-91fb-44ae-bbd5-a10ce1b73ad4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <550e1dd5-91fb-44ae-bbd5-a10ce1b73ad4@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 12:29:31PM -0600, Thomas Weißschuh wrote:
> Oct 30, 2024 11:31:21 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Wed, Oct 30, 2024 at 10:42:18AM -0600, Thomas Weißschuh wrote:
> >> Oct 30, 2024 10:28:03 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

...

> >> wouldn't it make sense to mark devm_mutex_init() as __must_check?
> >
> > It's macro, any idea how to do that for the macros?
> 
> It should work on __devm_mutex_init().
> I don't think the expression macro  in between should interfere.
> Unfortunately I can't test it myself right now.

Okay, when you have a patch, feel free to Cc me for review.

-- 
With Best Regards,
Andy Shevchenko



