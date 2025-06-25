Return-Path: <linux-acpi+bounces-14617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353DAE8BEC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14BA680AF6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7B2D5415;
	Wed, 25 Jun 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zy2Ew1gh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56501E102D;
	Wed, 25 Jun 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874650; cv=none; b=Utm7sPxIqzd8pRW6nin50jhn8int/dVpY2uRquDmxnXvsMnbmJVD0JweQ2IbUiCl1LV1rQMROCInqyP1Sr2+MsCFQmNTqsh3B2nhCuh7CJP7q768vkwCCefoRXmGTqxg83pjNpJWJhZAMo/dwefTyM0R4oJ/3a6AguhQ8pmAnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874650; c=relaxed/simple;
	bh=LO7e4EYBmszs0563Cc+0GGuHijUvLUmeQHP/hczX230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVgWOkpWATGoXl43wwBzKOg2o0zx5vqMFsUrnou/asHo8Iy+RbY5MSs82q167GJpKwM0SC1pm9NQARetS3uTdxgQVvmw3Ktssxj5qEt65GQPCm6wRPCkrXiA+7zsfYL9ObV/EzGCLFvOMv3IDycNgOE4HSIRBOcMY8AwAyayJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zy2Ew1gh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750874648; x=1782410648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LO7e4EYBmszs0563Cc+0GGuHijUvLUmeQHP/hczX230=;
  b=Zy2Ew1ghhpLK7XXzXsdvirnVeX1PpauNTuA42L5MGxitCAN7qaa5oTvI
   Xi4FvcevvpaaE8op2D2NbK/TmkWZvDvrciJw78CmtFa8HrGAgY8n9mPNB
   m4IJrMJskh3SCZGj1ncQ7HkrleAhmgKbHF0PTg2rgl+XStT2QnKgMkE+f
   zvFS2QsBs01IwpVpT6SGKoGmWd23V30A0La7fCR8pNt6LRXFAJaCvdkFS
   8l/mDfZsb+5RVSW7P09nBShQULGXrmTNOHJYX8PyT51Bd93vMyU/jjtcw
   jLfBkCOWbXDtnNNcbPVn+JVBjMgM2Sqp4fp2iMDEqXhdAjpy3vD4KrGs/
   g==;
X-CSE-ConnectionGUID: dlahOxbaQJabvcg3X5hHwA==
X-CSE-MsgGUID: 69rROCZpRZiL2fkj6WYIcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52273586"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="52273586"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:03:49 -0700
X-CSE-ConnectionGUID: uELhlDWxSTyeEUw9vjZDlA==
X-CSE-MsgGUID: KDGSD49BQPWFxBi9pcDm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="183317707"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:03:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUUTH-00000009w7a-0FA5;
	Wed, 25 Jun 2025 21:03:43 +0300
Date: Wed, 25 Jun 2025 21:03:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Message-ID: <aFw5_rnz2dPdQcNG@smile.fi.intel.com>
References: <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
 <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
 <aFwTCUXQydxRVEfk@smile.fi.intel.com>
 <6c0514e5-0ea6-4f66-9bc0-4230d7ef0d4b@amd.com>
 <aFw3yhVUkdtNnWXT@smile.fi.intel.com>
 <eb0a872e-0c96-43be-a583-49d221db661d@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0a872e-0c96-43be-a583-49d221db661d@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 05:59:50PM +0000, Limonciello, Mario wrote:
> On 6/25/25 12:54 PM, Andy Shevchenko wrote:
> > On Wed, Jun 25, 2025 at 03:34:55PM +0000, Limonciello, Mario wrote:
> >> On 6/25/25 10:17 AM, Andy Shevchenko wrote:

...

> > Probably gpiod_set_debounce() should become a no-op in this case?
> 
> But my point is this 50 needs to be a quirk /somewhere/.  It shouldn't 
> be a default behavior.
> 
> It can be in the GPIO driver(s), it can be in soc-button-array, or it 
> can be in gpio_keys.
> 
> I've got an idea mocked up for a v2, I'll send that out and I think we 
> can discuss the merits of it on that series.

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



