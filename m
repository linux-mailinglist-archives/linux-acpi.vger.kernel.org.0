Return-Path: <linux-acpi+bounces-4186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B93876578
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367731C20A09
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3392CCDF;
	Fri,  8 Mar 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8Z4dEFn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCD381C1
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905148; cv=none; b=piQROtKPhgDIamRc/OaQrQY/D3VIGFtBbCDge0BZB5adw7O8guzCmYOhazbB2DmXEWF4GWQpgAfKx5uDj99C3rNQVvdT9NyzKoymJo0NkTL3k6eX/9lW7H7WSMihcQcCI7bGV87nMFrY6+8J15J7nsMXxLjJenMUZl4SiKKPhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905148; c=relaxed/simple;
	bh=GciotLxwspdeyyyB0U/YUypbPZGqg8FE4QdrXJixYVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLxH3hADa+zukpC/LlMStL6dTjBPloxi1rna4U3YWZl2EcoTCkhjof789meZ/LKiMk+KAVCLSRzvDD3kKnHnS8iJFPrN5X4OG5oVFrd4kasviwyP/9ohskyGchK8w/FoV4CmvwGys+uMWirw2XkcCYQfStrElskiN08n3AE5jOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8Z4dEFn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709905147; x=1741441147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GciotLxwspdeyyyB0U/YUypbPZGqg8FE4QdrXJixYVY=;
  b=i8Z4dEFnDhSopGM0469nyuDmrX8jZFU0RcEoX4EjrrcXEalV3FmSkq18
   o08xQ/JKyDV42+divNvGqX4l2wrAfNuH41ask2aqi/O07YKKd/FeDErbn
   g7rONUDCDtFFgiD6D25ApCW6qpv1uVtYQFNlOOMGGuTQ7aqzSK3R5Tonr
   Iz44REeC/X/HcA1xBrX/+Fw3JQA/kwhUJ8uqz5L3KimXWMRgPKITA0OWl
   DckwJpZcYSk0zCMjDcLzgXvurPBoIBZGtEFwtciX7ETYvkMEN4VtZI9YK
   BI6f+fhbYj0KfMHWOf9/L2xfnOpz6xquIy/zhv4z6KVDc7DgIzGdYJSZd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4493823"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4493823"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914246807"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914246807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:39:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaRB-0000000Aqrd-3MEg;
	Fri, 08 Mar 2024 15:39:01 +0200
Date: Fri, 8 Mar 2024 15:39:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v6 2/4] ACPI: NHLT: Introduce API for the table
Message-ID: <ZesU9QXtM2n2eiZ1@smile.fi.intel.com>
References: <20240308073240.2047932-1-cezary.rojewski@intel.com>
 <20240308073240.2047932-3-cezary.rojewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308073240.2047932-3-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 08:32:38AM +0100, Cezary Rojewski wrote:
> The table is composed of a range of endpoints with each describing
> audio formats they support. Most of the operations involve iterating
> over elements of the table and filtering them. Simplify the process by
> implementing range of getters.
> 
> While the acpi_nhlt_endpoint_mic_count() stands out a bit, it is a
> critical component for any AudioDSP driver to know how many digital
> microphones it is dealing with.

...

+ acpi.h ?

> +#include <linux/export.h>

+ errno.h

+ minmax.h

+ printk.h
+ types.h

> +#include <acpi/nhlt.h>

...

> +#if IS_ENABLED(CONFIG_ACPI_NHLT)

+ kconfig.h ?

> +#endif /* CONFIG_ACPI_NHLT */

-- 
With Best Regards,
Andy Shevchenko



