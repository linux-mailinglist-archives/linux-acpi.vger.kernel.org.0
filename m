Return-Path: <linux-acpi+bounces-18042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A9BF7402
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E610A18A1F58
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53D342157;
	Tue, 21 Oct 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgVdLutz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0657342167;
	Tue, 21 Oct 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059026; cv=none; b=KNP+b7uJfLGO9MCM+HZbLHHuYXdSIYKY32evuX8g5h3bentJHD2nlIAnoHxd8VoPT3ZH/byGl/56nuInsrt3cuFmkqfxI5anrdUxDf05ebGHEYSDHf3iLLRh21Mm7mbBddiO2mJkKJfKUuRfc+rBObyQzLiTz9UYqrpmtX8FC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059026; c=relaxed/simple;
	bh=Fq7QJUZylawxmTRZOe6AWyIOczyVTpsBV5ofZGW16WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyaj4JZ3a3S3aXAKCH5PUB0dEHsUa9Vh6iEe9OMLarECVcQtHQ/u5lqWfm4ZVK9ezPFFFVb36TrL0HI6gySG0kT4r8x1DKY11VxUQEhn2W0Ujyq3ZNqIDBNz2OTevV+74lP3cSw9IMC+nyRMaCJQjPFCREvOpwlU2ZxSax36mNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgVdLutz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059024; x=1792595024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fq7QJUZylawxmTRZOe6AWyIOczyVTpsBV5ofZGW16WM=;
  b=KgVdLutzqW/ke3S10Qz25up1QShEMSgJaSGNNdC04s97A8P8+Nv94zzo
   wBf7LnO/3l9YXtsOwE7KITbfQlLJrKXOjLA28SwXkXi5BN5wYj8afqOo0
   dteUK3isOJBvSew6dMrL9Hv1J8+mz34cNQVxS/ALF55dBmWhdL/wyyhls
   q7VkQ0CyFFeXUHUc0WkodzngUMk8ySdUpMyTt8NghfrZmiPaYTvWAySbj
   3IxKaMfQjfMHxqBtqdkMAwytAK6AHawySppiVkyACgEDqxGfHJxm2mgdU
   zePaE26rNbyEz+eUW5cJbsTpDcO0eTkVeTNEI3sAQgsu2yM80XuR80AJg
   g==;
X-CSE-ConnectionGUID: YrIT0OpVQK+P6uqO1SRdkw==
X-CSE-MsgGUID: /EpGBJS4TF63q88BMrTisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62394724"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62394724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:03:44 -0700
X-CSE-ConnectionGUID: h9An80xFRDeQC606t1Y9zQ==
X-CSE-MsgGUID: 5U/akT3JTju7XUgOphRgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="214566406"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:03:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBDti-00000001WcU-0ZQz;
	Tue, 21 Oct 2025 18:03:38 +0300
Date: Tue, 21 Oct 2025 18:03:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
Message-ID: <aPegyVyONkPWRgi9@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPeexuA1nu-7Asws@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 21, 2025 at 11:31 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:

[...]

> > > No need to convert all existing drivers right away, but I'd like to see
> > > a user that benefits from the conversion.
> > >
> > 
> > The first obvious user will be the reset-gpio driver which will see
> > its core code simplified as we won't need to cast between OF and
> > fwnodes.
> 
> +1 to Bart's work. reset-gpio in current form is useless in all my cases
> (it's OF-centric in 2025! We should not do that in a new code).
> 
> More over, conversion to reset-gpio from open coded GPIO APIs is a clear
> regression and I want to NAK all those changes (if any already done) for
> the discrete components that may be used outside of certainly OF-only niche of
> the platforms.

To be clear, the conversion that's done while reset-gpio is kept OF-centric.
I'm in favour of using it, but we need to make it agnostic.

-- 
With Best Regards,
Andy Shevchenko



