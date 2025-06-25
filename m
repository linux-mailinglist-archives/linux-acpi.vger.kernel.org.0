Return-Path: <linux-acpi+bounces-14590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88EAE8280
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 14:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729865A0BC2
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B225E823;
	Wed, 25 Jun 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCQMnHHN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5832147EF;
	Wed, 25 Jun 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853980; cv=none; b=Tk+EKLBLZYIcaTGoFU52Pwl552UDHODCTl2rLCb2duNBnNIUHLJPsBaJCrEnWcr2xOPz4sWa5qm4Pfqt8DWBD/BY8C1FMWeNpP6YmAhV5HRriyQVf/89ZOpih7Vo+5fW2InfrQRaniDSXEnzu6MF4WNdEBg+PV52kniintXEh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853980; c=relaxed/simple;
	bh=Jf/WnBQXn6g8/WrK555BMqtkJLwU4/g0UWPzaefHEqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF69ivKcc4udjsk8m8JPzPuj2wq2utyik9+aD1pe1XmgQVl3vT9GRQnBnC7UoZxhPrdHd2NwrAr3t0kgm1wVU1iCZBzDCMzi9kjjLxpT/jGGz1TxoGWkMEvpP0DNhr6egaX+eyIEqcrV7Z1TN5WLjPbYXAX7xT4CHQlrgekV6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCQMnHHN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750853978; x=1782389978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jf/WnBQXn6g8/WrK555BMqtkJLwU4/g0UWPzaefHEqs=;
  b=YCQMnHHNS1ilzb2t7WaM8R0QnnATMXfVyEustUpVAIlVWz/DK7Me7rt7
   ASqfLxCJ50Xpyo45R0a2GmtVoV4n7CJwb3HraOOwdfR4JJGz30ES1HCvv
   7ETFlPy2H8ZoL791E8j9FEkCZfSOaAEnc4E0GGKl0eDC1Nx7dSwdl+XRy
   WODbUNUuP83xQ2JqLnIauWWeVy2awM0TbNvQAtU5aeV6cLo4sGpQc42wG
   fEnneNODOB4pVc4htvsEOnLn7eFlGGkoHZ3hRMG73PRTygquqWzkKwT92
   +YlEzOhrlpz79ovRkER+O2hP18KtC6ZWW8DDSmZ2eYvcXDygElhDeVo9U
   g==;
X-CSE-ConnectionGUID: NPqn4hzxSaCnDGo6EpilmQ==
X-CSE-MsgGUID: TiJCOOdLTA+buWFsrnyj1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52350417"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52350417"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:19:35 -0700
X-CSE-ConnectionGUID: YHRZb4YNSGqs4tk5oznBGA==
X-CSE-MsgGUID: QyAipQ2oTx2fWr6ehkzPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="157970991"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:19:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUP68-00000009lRF-3sCx;
	Wed, 25 Jun 2025 15:19:28 +0300
Date: Wed, 25 Jun 2025 15:19:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <aFvpUBM0xSdM76xz@smile.fi.intel.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624202211.1088738-2-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 03:22:10PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
> which will parse _CRS.
> 
> acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
> gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
> gpiod_get_index (drivers/gpio/gpiolib.c:4877)
> 
> The GPIO is setup basically, but the debounce information is discarded.
> The platform will assert what debounce should be in _CRS, so program it
> at the time it's available.

If this will be needed we can factor out acpi_gpio_set_debounce() with
the warning and use it in both cases.

-- 
With Best Regards,
Andy Shevchenko



