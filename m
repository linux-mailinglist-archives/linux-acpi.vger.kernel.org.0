Return-Path: <linux-acpi+bounces-18130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD40BFF5E6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7F43A8703
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D7299A85;
	Thu, 23 Oct 2025 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5o5fGAK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAC2980A8;
	Thu, 23 Oct 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201583; cv=none; b=rguur2znN/8wMjovrx00vvbG6zTR17wLDVorVN8qi2c3jI2sEkWAik8s/FC/He6SBsa8WaD3uneRqiGB2e/W/X/tgGOM9zzrJyX4IzqG6pdKTgYR05uC1AIhHP085CFETf0Uq9wai8dqTatO0hCfGul+JnTlD6NwyrT4C4XFKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201583; c=relaxed/simple;
	bh=YyvvwYN7bxHsIVzFJjPr+syowRuB6CCI1UdA16U57IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLpFjIetaFcYDnlU2ztP9yw2IqIAK8b+1phaAJ31WXVY8V1CopLBySThdP3UMnXpYJ0CHeSR4V6ydygMFOEDMBc/W/ZKSzmoH81M6QUZr6Eo3NHvwJXDKvXjSdDQSVgVlWBJYz9J6txev/l/z7ZLviMzXFnNuei4nWMkp9TpsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5o5fGAK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761201581; x=1792737581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YyvvwYN7bxHsIVzFJjPr+syowRuB6CCI1UdA16U57IE=;
  b=M5o5fGAKL5KYw7/VXgWdxwrJfOCabK2UwAm5uDDiZvAFv9mq1bibYz+9
   OIT3zQBOZi+urRZh1JiQKpr2YwGnXleJLeYaqgwo1bNVSnErpYPOr2QAT
   bWD6QRYvcpnwVs/OM2OGEEsX4kG8wdvniaMVq2s1KfZdiL8GRqQpx3Us6
   S0Q7WsZzpso4dkXf768TD5dg17jrCQBSM93/eL7oBgMXSyvQrisIXHrn1
   P4vWMm7V/d2kUMeVfV06VffJz97AMRgTAy6GH3fi5MdNvjERq9zl1FaXA
   HRgYe6ln6EOsl8vGS0VjKK/Se5J2D4bbZGcUlXCZ6GmfrQbBl/VgSq7y5
   A==;
X-CSE-ConnectionGUID: RxcCrE/dRqiet2wIrH884w==
X-CSE-MsgGUID: eTicpYy7S6OyOLPTn04rqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88827816"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="88827816"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:39:40 -0700
X-CSE-ConnectionGUID: E6BmgmP0SEOq5mzUudffcQ==
X-CSE-MsgGUID: ALsmw+gLRLmsGVxve1foOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184006536"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:39:38 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBoz1-00000001rhn-2NId;
	Thu, 23 Oct 2025 09:39:35 +0300
Date: Thu, 23 Oct 2025 09:39:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>
Subject: Re: [REGRESSION FIX resend 1/1] gpiolib: acpi: Make set debounce
 errors non fatal
Message-ID: <aPnNpy6tXlCKnBsL@smile.fi.intel.com>
References: <20251022133715.331241-1-hansg@kernel.org>
 <20251022133715.331241-2-hansg@kernel.org>
 <CAHp75VcDmafp4fiOH7LqhPqtTX5BEp1w0eA5UMk13U=2_tHsyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcDmafp4fiOH7LqhPqtTX5BEp1w0eA5UMk13U=2_tHsyA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 04:47:34PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 22, 2025 at 4:37 PM Hans de Goede <hansg@kernel.org> wrote:
> >
> > Commit 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
> > adds a gpio_set_debounce_timeout() call to acpi_find_gpio() and makes
> > acpi_find_gpio() fail if this fails.
> >
> > But gpio_set_debounce_timeout() failing is a somewhat normal occurrence,
> > since not all debounce values are supported on all GPIO/pinctrl chips.
> >
> > Making this an error for example break getting the card-detect GPIO for
> > the micro-sd slot found on many Bay Trail tablets, breaking support for
> > the micro-sd slot on these tablets.
> >
> > acpi_request_own_gpiod() already treats gpio_set_debounce_timeout()
> > failures as non-fatal, just warning about them.
> >
> > Add a acpi_gpio_set_debounce_timeout() helper which wraps
> > gpio_set_debounce_timeout() and warns on failures and replace both existing
> > gpio_set_debounce_timeout() calls with the helper.
> >
> > Since the helper only warns on failures this fixes the card-detect issue.
> 
> Acked-by: Andy Shevchenko <andy@kernel.org>
> if Bart wants to take this directly.

Never mind, it seems we gotta fix an LKP thingy, I'm about to send a PR out of
two patches.

-- 
With Best Regards,
Andy Shevchenko



