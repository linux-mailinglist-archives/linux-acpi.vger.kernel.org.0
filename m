Return-Path: <linux-acpi+bounces-1008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A77D7B7F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 06:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ABF1C20E0A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9322C120
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWiqRLr1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA3646
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 03:00:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58DA182;
	Wed, 25 Oct 2023 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698289254; x=1729825254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AiMwsKoIqJ/vLjZTysZ5Brq6QaeclE1a+bWmPlvUU8w=;
  b=FWiqRLr1y50gB5xRAZeBtYoHYxlwHbRrWeXxZsTqPryRPcK3Ek7xpCsr
   6MElyy4R/MAwEV+B6pxFJ00GFb87DQyH7iBf/rAQ0bJc0TbreZS0ThCgh
   PG+u2VYr3WHMLEXk6pB3SRqk60qz17UlQarcikGjTo9+Wi+nlMN3+hVfz
   w2kwVmw0PlkCYeugjnsnImEf8S+bQjUeDNoDM2MQpTfzEN4Z97+654jXv
   t390MTBNdnqdS8uZbYCFjvgCBUisemf7g/l0eC8TM6oaVuErfKOxXClna
   poXlgjxSLxXuTNMffCirS1C9zjsjhDw6kvAmS4GECZEsiVshpA3I7NWAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366796595"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="366796595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735606846"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735606846"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:00:28 -0700
Date: Thu, 26 Oct 2023 06:00:25 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTnWSRIr1o7RLcOl@black.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
 <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>

On Wed, Oct 25, 2023 at 11:33:40PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > as an integer.
> 
> NAK. See below why.
> 
> ...
> 
> >  static void byt_pwm_setup(struct lpss_private_data *pdata)
> >  {
> > -	u64 uid;
> > -
> >  	/* Only call pwm_add_table for the first PWM controller */
> > -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> > +	if (!acpi_dev_uid_match(pdata->adev, "1"))
> 
> _UID by specification is a type of _string_. Yet, that string may represent an
> integer number. Now, how many variants of the strings can you imagine that may
> be interpreted as integer 1? I can tell about dozens.
> 
> With your change you restricted the all possible spectre of the 1
> representations to a single one. Have you checked ALL of the DSDTs
> for these platforms to say 'hey, all current tables uses "1" and
> this is not an issue'?

I'm not sure if I'm following you, this would basically invalidate every
usage of acpi_dev_hid_uid_match() helper across the driver.

Raag

