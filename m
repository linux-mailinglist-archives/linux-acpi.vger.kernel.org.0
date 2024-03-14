Return-Path: <linux-acpi+bounces-4338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EC87BD88
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828001F224AA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3470CDC;
	Thu, 14 Mar 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cae6EuGo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469B71720;
	Thu, 14 Mar 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422292; cv=none; b=oBt/qwfxlYMLZMrvf9xNbUl31vpbFz2mJuPEMbF4YDVRtoOZHYwzl2rACExFivHrxKb55MBpHSfq51mVqh1Ol1/w4HTyHaGYMlhQA/At25bLrgi+/w/2EGejahFKgwFqEyLdNIqZHysxfY6aMIoW3MmGLUxvKDnI70s0f3nPkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422292; c=relaxed/simple;
	bh=TIpEZ52kU0piR4WN3tJ7pG9MeperkqFwPKj1jGcMTOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6J2TLAtT1LX5JkfIo/iNHIKgQ2n0SuGkIHEZGq5zzOtgxwOAsfrKu1+M2RSQfleFeHUqexHBYQyVKcwysiNtPosVE2MVfHgmEKMiLu0vNVzrlMpmJFdaadamezEyNpufnAcOyBrTQdE6DcOnIn2Z1aZnsMPGCsRDeG+auO0YQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cae6EuGo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710422291; x=1741958291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIpEZ52kU0piR4WN3tJ7pG9MeperkqFwPKj1jGcMTOE=;
  b=Cae6EuGoylqteVrbAI5ECSTDQoCessnIAyqEcBSvtYTvxBzLpkdW40rP
   s7GW2tTC1RX6gnETEqVzF5RcWTTogwDZ1m7yyzlRr1DIF03rHUYjPslIr
   /C1rm4N0CfVmd+KEecM36qf/GmeG6tOD5ARNbVuxIj4eQoGPVg3jbta9D
   Th0zs5xV7qqxdhuRapOuD760DuCM4XL9C5M54ApjSBjWjKNKIHgH1ikS8
   7g46Q3jbUSCn8rKvinpdXqrdTMhgg+pDHlvivWarAYxnopE+l5zPIWgj9
   B8y0fSTNll07XSc0eauGBTJu9d3pWinDFnEO13JiL+JDyHOnnC5HKR0Ed
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5091828"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5091828"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914460152"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="914460152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:18:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkky9-0000000CWMl-4ARz;
	Thu, 14 Mar 2024 15:18:01 +0200
Date: Thu, 14 Mar 2024 15:18:01 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Message-ID: <ZfL5CYMLY03i8q6u@smile.fi.intel.com>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
 <ZfGMNWtFrgsuUdLz@smile.fi.intel.com>
 <ZfGNfucm2-izJBfd@smile.fi.intel.com>
 <f6833616b81e4e35f561dc0ea4dae8dcd0ac026b.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6833616b81e4e35f561dc0ea4dae8dcd0ac026b.camel@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 14, 2024 at 01:13:31AM +0000, Hamish Martin wrote:
> On Wed, 2024-03-13 at 13:26 +0200, Andy Shevchenko wrote:

...

> Removing the setting of the handle to invalid may be the right fix but
> I don't feel I know the code well enough to make a decision on that. It
> certainly doesn't resolve things immediately - I saw ref counting
> warnings output.

Not removing, but moving to the better place?
Can you share warnings, though?

P.S.
I'm not an expert in ACPICA and low lever of ACPI glue layer in the Linux
kernel, perhaps Rafael can suggest something better.

-- 
With Best Regards,
Andy Shevchenko



