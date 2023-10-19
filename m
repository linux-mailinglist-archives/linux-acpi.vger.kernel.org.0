Return-Path: <linux-acpi+bounces-760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D957CFFBB
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21D0B20FE2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0B63CF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiGSlY9j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748C30F82
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 15:36:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99A196;
	Thu, 19 Oct 2023 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697729800; x=1729265800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vuyr/wjcaq45z5sHIWsOKl3qqIBusIoS8TyidC9xcRM=;
  b=OiGSlY9jIovhRSgUOsANKFX73lWiBk4Fm5QUULT4aRyefIDyo0ZcWeRd
   5HWGsXwwnYvcC2daK6v6AbQqYZIe29Z1p5ABdJwX7bnEyuKF8HNdj6eUR
   ZWCeFS8t+XfW75jevyzd+IGExODJttrl0wDrPalSacx7aLl8XQyUALW4v
   2ClZTa03cBBDh8HN5fS3XvdEQ3U7kGnw48LoEhOqBCHY7K60rFpB7nqeG
   Lzxlzea0KrO8wRY4zNoVEmD3btuv8psahotc6O4CbGkTTRIV5n22kOSH0
   fIxVFf9waovb1CEyI/hAjtxmfxqivsiHQaxjjIBYrtiDsRZiwLAZxl2O8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="386109291"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="386109291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004277332"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="1004277332"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:36:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qtV4d-00000006ur5-1sLB;
	Thu, 19 Oct 2023 18:36:35 +0300
Date: Thu, 19 Oct 2023 18:36:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <ZTFNA3M7OaiIoIw+@smile.fi.intel.com>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 02, 2023 at 04:54:58PM +0300, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.

Dan, do you have any comments?

-- 
With Best Regards,
Andy Shevchenko



