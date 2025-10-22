Return-Path: <linux-acpi+bounces-18107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DABFD40A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1913E1888C58
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB435B149;
	Wed, 22 Oct 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtRD/+oP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AB35B148;
	Wed, 22 Oct 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149529; cv=none; b=XHsCYC71t3jfV9o1OT1ZvmWpI86VSxQy+c7x2+RCI9meL9GkxWFrCHK37+qqYUYVQYGouMx6piTXFjqN/1srs1rlmUalAu8ZGw3NSlXTd8RGQJohA1i8R8EPlWmmxW0VYNx8Z6SSVYcO3nTzX7dYxBVo6Hhqjk+hs+mPNB4GMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149529; c=relaxed/simple;
	bh=IaRshFLfVcx/emGoPV1f+QYE4VS3CjYShnZJTxeFLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0ZAgARK1vHcTp+6uZdHzZqkJiUaRv84osn3GTnbLBLfwP7WTjL2DEFJtLMprsUeQVO0fOlW5EFSX4X92+eGTGsGINzuLoL01gi4mMIwq+HnwR1XoW9I3iTYFIRLCU3TKuOaRtCeyR09zkuCwQuWWg3oPtv/pv4lisHO7NxlaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtRD/+oP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761149527; x=1792685527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IaRshFLfVcx/emGoPV1f+QYE4VS3CjYShnZJTxeFLog=;
  b=KtRD/+oPEX6e4H8O4aXKy7N/UwmwDK7/moUSkmezbYXHQbWqnlgqgvLT
   rimkXun03rEnKarcaYCQIc3TFmjRKI0uGtQ1ktCTRtkgfpbwvDh7xKQhS
   cOJmXlIwVOJypEtK8JciLglShc5iKgI0k9Zv6yHs+R6w2UB7SGLTRbfm1
   rM5yCFD2mo6qOsmwbgSXyLRrBv8iQJbiyqaVLrHFHg8j5Vi8Z92qwA9J6
   X8NjuqogJWbazATVdWd96Abm2vJY8HIEg1tYSmI44BnUiP4/uHey69+il
   z14Ojf4rF1KDOw4hIthguBW1BeBLj1axmBu+4sbuqHdu8a3/dy8v9CDBq
   A==;
X-CSE-ConnectionGUID: c3u/WTaoQx2Hwph3C8ym3g==
X-CSE-MsgGUID: u3jPCo/DSKaKjSvAorJckA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63211270"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63211270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:12:05 -0700
X-CSE-ConnectionGUID: aYLLBjbMSyuYEeaxbXLYaw==
X-CSE-MsgGUID: +gVc5kqQSNWrVGu6XV4sMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183962211"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:12:02 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBbRO-00000001jnj-2bzi;
	Wed, 22 Oct 2025 19:11:58 +0300
Date: Wed, 22 Oct 2025 19:11:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
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
Message-ID: <aPkCTgaqPHaTsFDH@smile.fi.intel.com>
References: <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com>
 <aPegyVyONkPWRgi9@smile.fi.intel.com>
 <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
 <aPerDcMFdbWecGEv@smile.fi.intel.com>
 <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
 <CAMRc=Md-KuNp1o6GLA0WTbknbN-qtt8YJqy5fJs0P0EyE7KY3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md-KuNp1o6GLA0WTbknbN-qtt8YJqy5fJs0P0EyE7KY3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 02:17:53PM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 22, 2025 at 10:39 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > On Di, 2025-10-21 at 18:47 +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 21, 2025 at 05:23:33PM +0200, Bartosz Golaszewski wrote:
> > > > On Tue, Oct 21, 2025 at 5:03 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote:
> > > > > > > On Tue, Oct 21, 2025 at 11:31 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > > > > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:

[...]

> > > > > > > > No need to convert all existing drivers right away, but I'd like to see
> > > > > > > > a user that benefits from the conversion.
> > > > > > > >
> > > > > > >
> > > > > > > The first obvious user will be the reset-gpio driver which will see
> > > > > > > its core code simplified as we won't need to cast between OF and
> > > > > > > fwnodes.
> > > > > >
> > > > > > +1 to Bart's work. reset-gpio in current form is useless in all my cases
> > > > > > (it's OF-centric in 2025! We should not do that in a new code).
> > > > > >
> > > > > > More over, conversion to reset-gpio from open coded GPIO APIs is a clear
> > > > > > regression and I want to NAK all those changes (if any already done) for
> > > > > > the discrete components that may be used outside of certainly OF-only niche of
> > > > > > the platforms.
> > > > >
> > > > > To be clear, the conversion that's done while reset-gpio is kept OF-centric.
> > > > > I'm in favour of using it, but we need to make it agnostic.
> > > >
> > > > As of now, the whole reset framework is completely OF-centric, I don't
> > > > know what good blocking any such conversions would bring? I intend to
> > > > convert the reset core but not individual drivers.
> > >
> > > Blocking making new regressions?
> > >
> > > Otherwise as long as reset framework and reset-gpio are agnostic, I'm pretty
> > > much fine with the idea and conversion.
> >
> > I think we might be talking about different "conversions" and different
> > "blocking" here?
> >
> > 1) Conversion of the reset core from of_node to fwnode.
> > 2) Conversion of reset controller drivers from of_node to fwnode.
> > 3) Conversion of consumer drivers from gpiod to reset_control API.
> >
> > My understanding is:
> >
> > Bartosz would like to convert the reset core to fwnode (1) but not
> > convert all the individual reset controller drivers (2). He doesn't
> > like blocking (1) - this statement was partially in reaction to me
> > bringing up a previous attempt that didn't go through.
> >
> > Andy would like to block consumer driver conversions from gpiod to
> > reset_control API (3) while the reset-gpio driver only works on OF
> > platforms.
> >
> > Please correct me if and where I misunderstood.
> 
> I think Andy is afraid that people will convert drivers that are used
> in the fwnode world to reset-gpio which only works with OF. I don't
> think that anyone's trying to do it though.

You are both right about my worries and there is of course the case.
https://patch.msgid.link/1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com

The mentioned change should be reverted.

And this was just found by a couple of minutes of `git log --grep`. I am pretty
sure there are handful of a such wrong patches.

Compare to https://patch.msgid.link/20250815172353.2430981-3-mohammad.rafi.shaik@oss.qualcomm.com
which is done correctly (it doesn't  break old functionality on non-OF platforms).

> > I think fwnode conversion of the reset controller framework core is a
> > good idea, I'd just like to see a use case accompanying the conversion.
> > It seems like enabling the reset-gpio driver to be used on non-OF
> > platforms could be that. Andy, do you have an actual case in mind?
> 
> I'd say converting the reset core to fwnode has merits on its own. We
> should typically use the highest available abstraction layer (which is
> fwnode in this case) unless we absolutely have no choice (for
> instance: using some very OF-specific APIs).
> 
> That being said: the reset-gpio driver will be able to work with any
> firmware node once we do the conversion which is a good first
> use-case.

+1, as I already mentioned I am in favour of this change.

-- 
With Best Regards,
Andy Shevchenko



