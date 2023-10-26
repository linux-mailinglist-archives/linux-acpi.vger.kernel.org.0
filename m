Return-Path: <linux-acpi+bounces-1018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7D7D82B8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C0B20AB6
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34392DF95
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITXwuNHO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676512B69
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 12:24:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487EB9;
	Thu, 26 Oct 2023 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698323056; x=1729859056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0GV2vhjs9lB5jYaMXp0AfM1dB/lKUlw9QbqlDS0z9A=;
  b=ITXwuNHOGV5WngS5ykFVlrrmfav+Q7Ql1Ag248KsYir4OW2IwGyzejbo
   DeZFuTNq96oygXXRn1FBtXt+6hXTbVTkF3yJuQl4hrfow/5jtAIn5nwpE
   yiYZE3brGNH6kF2+wBMFz29soj+Ojq2qIm0Su/OHmmyFJwJpr+tL5kzTT
   mPja9W+GjdWbaNdFBABqe7pPNR8sk0XOIPYRjfMpbNanhzbkKfIiwrNA8
   hcSeyyW1HwIlaOrN/XVQQ6Y+IEJQaMgVMW57kLWMNi1NG/Yy9hNBSvq2F
   2Wjol9DUwLp2LcMCJbSv9k0yqKYNuDsIhIy9ldUcT2WjkqWbOCxmPEMMZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386420829"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="386420829"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882788641"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="882788641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:24:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qvzPH-00000008qr4-30G9;
	Thu, 26 Oct 2023 15:24:11 +0300
Date: Thu, 26 Oct 2023 15:24:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com, lenb@kernel.org
Subject: Re: [PATCH v1 4/6] ACPI: acpi_video: Replace acpi_driver with
 platform_driver
Message-ID: <ZTpaa0p7nvR4E4nC@smile.fi.intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
 <20231025111806.2416524-5-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025111806.2416524-5-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 25, 2023 at 02:18:04PM +0300, Michal Wilczynski wrote:
> The acpi_video driver uses struct acpi_driver to register itself while it
> would be more logically consistent to use struct platform_driver for this
> purpose, because the corresponding platform device is present and the
> role of struct acpi_device is to amend the other bus types. ACPI devices
> are not meant to be used as proper representation of hardware entities,
> but to collect information on those hardware entities provided by the
> platform firmware.
> 
> Use struct platform_driver for registering the acpi_video driver.

...

>  #include <linux/dmi.h>
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <acpi/video.h>
>  #include <linux/uaccess.h>

Despite this being unsorted I would squeeze to the most sorted part of it,
i.e.  with the given context the new inclusion is good to have after dmi.h
(but in full context it might be even better spot).

-- 
With Best Regards,
Andy Shevchenko



