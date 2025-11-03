Return-Path: <linux-acpi+bounces-18455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A37C2C435
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 14:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DF73A381B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81652271468;
	Mon,  3 Nov 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/ihlPqo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AB185E4A;
	Mon,  3 Nov 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177597; cv=none; b=T3lzhoVf/oXwe0wvuR2+pC0Iy2XJF+x/31XBS8T/3n45zBN8RHA/SKSjpys5gSswUxie442aIL6LOYHsCMR5iGZhEJcnHfuLgV/hhFIAGvKIQdw0S6zC2yk/VEIN3B0A8jAsUl9jhJyd5EfnZLHREbexu9OmlYNjVpew5CF0znQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177597; c=relaxed/simple;
	bh=qpufKMelXPajJGPNRFvo+hu6rFKxInjbrZYX2294aZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acvMUT0y28GzfN2q6+Xzsg1SHH0wylapnq4QfXfwKcGxQivw7MZhnCAj6hNLOGyNqrY8H1Pweq3rhomXc9PAHIFX2F+guyMju3dDGY60uQA/JQjko22Yy52rZO2N+rTJpoa3oQRzAY6f0hFqIul7XsiNEyv+RKwZT7YAjw/YwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/ihlPqo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762177595; x=1793713595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qpufKMelXPajJGPNRFvo+hu6rFKxInjbrZYX2294aZI=;
  b=f/ihlPqoijBKkGDez0PtHyFSIZhb21QIhCtBShp4HBwpP4TaoWxcB6ru
   zgWlw2eVlU+cxeLxISLYXI5Xeo+i/5GlJKTwHMQgaVZu05fga8JD3+N8P
   p0LqgqbUiCGXC86jleZhz8ZLRs1L738NmPvIj3WswxZRIxd2XPPRIpZ4O
   y+sPgPfJXNIHlUZwyLS+dgKDW/Y3NuV56RoZ8f40SFtNaUQ0RdL3t04vM
   tvbAFvExKFXRDDD6hwKMybonxANE+q9gZ2n6kQzBW5YsgenhDujjcHWJx
   ebwKkJGSCjx+5Xgk/1QwtTt1QoooC+tK+gfKcZiwoGbe82HN1QRMAUolw
   Q==;
X-CSE-ConnectionGUID: gW9IK7maSN2+vKFs2Qjh5w==
X-CSE-MsgGUID: gLzSqDKbS2WftGU6mwZvAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89713519"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89713519"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:46:35 -0800
X-CSE-ConnectionGUID: 6zUn4xy4RU+o2dblMGXDIg==
X-CSE-MsgGUID: 0SuI7D+hQuKDBF3VNsAh0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187185451"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:46:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFut8-00000005A9r-1wU9;
	Mon, 03 Nov 2025 15:46:26 +0200
Date: Mon, 3 Nov 2025 15:46:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
Message-ID: <aQiyMdvUhPQxkpmw@smile.fi.intel.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
 <aQh6n2XuI0oayg2g@smile.fi.intel.com>
 <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 11:36:36AM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 3, 2025 at 10:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Nov 03, 2025 at 10:35:23AM +0100, Bartosz Golaszewski wrote:

...

> > > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > +
> > > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > +
> > > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
> >
> > Now, useless.
> 
> No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
> misleading or incomplete, so I'm proposing to start replacing it with
> SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
> a better name.

It's an unneeded churn. I don't see a confusion here. One may interpret
That it is a reference in a software node to another node.

...

> > > -#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)                               \
> > > +#define __PROPERTY_ENTRY_REF(_type, _name, _ref, ...)                        \
> > >  (struct property_entry) {                                            \
> > > -     .name = _name_,                                                 \
> > > +     .name = _name,                                                  \
> > >       .length = sizeof(struct software_node_ref_args),                \
> > >       .type = DEV_PROP_REF,                                           \
> > > -     { .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), }, \
> > > +     { .pointer = &_type(_ref, ##__VA_ARGS__), },                    \
> > >  }
> >
> > Do we need this now? I assume that _Generic() takes case of this.


> Ah, right, it should be done here as well.

Just it should work as is without changes, did I miss anything?

...

> > > +#define PROPERTY_ENTRY_REF_SWNODE(_name, _ref, ...)                  \
> > > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_SWNODE,                  \
> > > +                          _name, _ref, __VA_ARGS__)
> > > +
> > > +#define PROPERTY_ENTRY_REF_FWNODE(_name, _ref, ...)                  \
> > > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_FWNODE,                  \
> > > +                         _name, _ref, __VA_ARGS__)
> > > +
> > > +/* DEPRECATED, use PROPERTY_ENTRY_REF_SWNODE() instead. */
> > > +#define PROPERTY_ENTRY_REF(_name, _ref, ...)                         \
> > > +     PROPERTY_ENTRY_REF_SWNODE(_name, _ref, __VA_ARGS__)
> >
> > Seems like useless churn.
> 
> This is the same argument as with SOFTWARE_NODE_REF_SWNODE(). It's not
> clear from the name what PROPERTY_ENTRY_REF() is really referencing.

Same answer as above.

...

TL;DR: Let's leave renaming / splitting to another series. It doesn't sound
like a required thingy. Only what I see is unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



