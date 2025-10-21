Return-Path: <linux-acpi+bounces-18045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C8BF7786
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2517A188F061
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766F339B55;
	Tue, 21 Oct 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkDKwOTR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6C1F2C45;
	Tue, 21 Oct 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061654; cv=none; b=lL4/RmTkQtGBHLM82SmH9VR/pju8fU2kMmHfqT6ehpmpZo7xSB3CPyghHbYh/yKGuXPeaQgK8WRi3nnaVcT/8ArO/zZtUs/e4oocDjq5VvQJ9cX1OFrT0x2I8FSp0JZjO1pRYDiIgz4M5TU46ewWobHbmIYis8WszH16ulRVP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061654; c=relaxed/simple;
	bh=eaHQqvuP4JugBgY02+OkIO+XqF1YyKm2Y3bYRizxYaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCep4qbhKSvw2rqDuurJJqTz3fhlIECRr0XqjYQbH6BrxDvIP2fMkpP7TQn2NpzowKlQilMyJ35vwmVE0F00uA03Gyg/KiUo9X1FCYufP2tWHDBYxYgHkp3bVx+l8fKQ9RTw472nErOorO0rBakJzoYiHgz7prkaptpatYVpo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkDKwOTR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761061653; x=1792597653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eaHQqvuP4JugBgY02+OkIO+XqF1YyKm2Y3bYRizxYaw=;
  b=UkDKwOTR8RbajhvqevIoF+CJnQSIJKFcJQRczkYjFGWQgEiVToc+1Bp/
   T4Iuoa1YAXU/QmKQ0jpwxLdr1rOk6Yd7zkmmq1BwYYbghXlkK4fpoioMp
   PlcBtiq9GrqmCstFmoXML4VenG5PCxekKQMt5wi2DOxAlpRuWNcUqu5E7
   jpjCmoQTnPIfsIdszIBHXqPcAGeyclXdqnh+XCDYFBXU+Zs+F+YMhEYci
   nIGlxLqpcUZUjzd9QgTCFKj0uUqH96ZxoIpqttWdT3fdz1Vw806TcTe+s
   3byl7ImJGCxcqq6cuSoUjopCPElAD8qiyW4bxZ5vbbAeYNj/rv5zw64ae
   A==;
X-CSE-ConnectionGUID: prQmdjxFSOuNA9PyH+gUow==
X-CSE-MsgGUID: m2fgC3wbT2+s1Pxs1EcasA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73798618"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="73798618"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:47:31 -0700
X-CSE-ConnectionGUID: gvTj7yWSS2K8EXIojiOR2Q==
X-CSE-MsgGUID: sYAoFFBaSdGQ+8f5ZTvxKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="207294935"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:47:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBEa5-00000001XAx-3XJk;
	Tue, 21 Oct 2025 18:47:25 +0300
Date: Tue, 21 Oct 2025 18:47:25 +0300
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
Message-ID: <aPerDcMFdbWecGEv@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com>
 <aPegyVyONkPWRgi9@smile.fi.intel.com>
 <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 05:23:33PM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 21, 2025 at 5:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote:
> > > > On Tue, Oct 21, 2025 at 11:31 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:

[...]

> > > > > No need to convert all existing drivers right away, but I'd like to see
> > > > > a user that benefits from the conversion.
> > > > >
> > > >
> > > > The first obvious user will be the reset-gpio driver which will see
> > > > its core code simplified as we won't need to cast between OF and
> > > > fwnodes.
> > >
> > > +1 to Bart's work. reset-gpio in current form is useless in all my cases
> > > (it's OF-centric in 2025! We should not do that in a new code).
> > >
> > > More over, conversion to reset-gpio from open coded GPIO APIs is a clear
> > > regression and I want to NAK all those changes (if any already done) for
> > > the discrete components that may be used outside of certainly OF-only niche of
> > > the platforms.
> >
> > To be clear, the conversion that's done while reset-gpio is kept OF-centric.
> > I'm in favour of using it, but we need to make it agnostic.
> 
> As of now, the whole reset framework is completely OF-centric, I don't
> know what good blocking any such conversions would bring? I intend to
> convert the reset core but not individual drivers.

Blocking making new regressions?

Otherwise as long as reset framework and reset-gpio are agnostic, I'm pretty
much fine with the idea and conversion.


-- 
With Best Regards,
Andy Shevchenko



