Return-Path: <linux-acpi+bounces-758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07547CF924
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE1E1C209B3
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80323225A4
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLrmFEkv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575C1EB5F
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 12:17:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA19AB;
	Thu, 19 Oct 2023 05:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717867; x=1729253867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+nyLhbjTR1LgRZ98q1rh6aAFetoBlm+WQFuCloYpSM=;
  b=OLrmFEkvAN1SnH6HHFl5NSzEM1UjS7wITdgM5Gb8x7eVxgukgxjlnRG8
   DjLjnnXKAknvz5GE5J5RmrwOlXdSL5SO68kKX6DD4FFu0aVWm9PzRIpRR
   YpTfpgCdEwURslY0elAqcfRdItM6G//kFEonMFqaNKAc/E+id4Hlr+KeZ
   HKYHnXzY7biF95yrK5EUqWSWJLKvI/UAqxvYI3378kt2YPIA0NvPk65xv
   xiiXkLOEXNYzDfG4KoVvkkQ4lXcqloyadQ8K0ljDBNViJmsyO+PfVasai
   HnFxXusENdpUy3q0ltr39G/Y1ev8E47qWDr3V7ys9gQzkecmMiYGuuCvM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472466505"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="472466505"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733540240"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="733540240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:17:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qtRyA-00000006rFB-3Fdy;
	Thu, 19 Oct 2023 15:17:42 +0300
Date: Thu, 19 Oct 2023 15:17:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com, lenb@kernel.org
Subject: Re: [PATCH v2 0/3] Replace acpi_driver with platform_driver
Message-ID: <ZTEeZt9rGplso1HV@smile.fi.intel.com>
References: <20231018190945.252428-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018190945.252428-1-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 18, 2023 at 10:09:42PM +0300, Michal Wilczynski wrote:
> This patchset is a continuation of efforts from [1] aiming to replace
> acpi_driver with platform_driver. To ease up review effort I'm sending
> miniseries per driver, with a replacement patch + various improvements
> that were noticed by me, or during internal review.
> 
> This mini-series takes care of acpi_pad driver.

All three LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



