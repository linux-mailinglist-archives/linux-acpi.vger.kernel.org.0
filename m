Return-Path: <linux-acpi+bounces-17965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E501BF06BC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C28644F0C11
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7162F6566;
	Mon, 20 Oct 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahVq1qNZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8512F5A0B;
	Mon, 20 Oct 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954755; cv=none; b=oAgq5zJim/Pk3beGa4fVYRcpMfaIOKBtfN3XBLoea1eFd7IjRFDOHWWkgeowW8jJgR4k5X5oKJaxnBSvvFeuUvB5US2OtYocOhf/dq8rBGn5Av+cwLZOtWM7rSSi1N88aWLANoiaKqmvFkcznj/jiF/9F0iTy4YzGcI1ctCzeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954755; c=relaxed/simple;
	bh=nEmUKNUCmJh39T+JKitYAUPYb5fVZOB6UXkFYmlmPFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrwovK6e+h7lXTCVO4NvMhYHXBoVDvj9RD5gwj7WXYxbAsiPbmVRYGttM1EIGIOLMhtaVS9sog5S7yv9DEGUhU49DZCrPTue8kpU4qSFaXZVcYG2TEIrHJplxmcsQaX7f4CbA1uIrzm9WBsNswFAGu19HJ+PguASvHnI73mIkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahVq1qNZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760954754; x=1792490754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nEmUKNUCmJh39T+JKitYAUPYb5fVZOB6UXkFYmlmPFI=;
  b=ahVq1qNZsJ0Ve2czSV8zFATAEjuH5i5yyOFZR69iWK3OQHnR5E1unN+x
   F1MOFRAChfGMCfdmIbQGcND9rdVU27rQRkQQMb8COs8yEWLwoAB2RPlTr
   IeL5AvCuRr8S3vClZXFfklf0j7xwglBsm0SIGQsGVJ2hHRpzYcTqtA8D4
   l67X1mr5ySWxO0DwbCBIwOwYMDzXWoAjAzUZ8qEqxNzuNZfp4pUnipzV2
   oTEhH9ofWoeLHWlcg+UK2KNUW9kjAmW3IxrHp0EC5sp0YWbNrRw/FlFok
   26TQiP97KzoTc7z1PJKU7BNPnAf6rT8+DicP/zxTvg+XjHZIfWpUQSeWR
   A==;
X-CSE-ConnectionGUID: xZ5IN7mPSSmZVhtzSQtKVg==
X-CSE-MsgGUID: hzY28RJJToy1hBx9zZs3Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63164800"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63164800"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:05:53 -0700
X-CSE-ConnectionGUID: 1a7cDbxTTG6g0oJTFKlwpg==
X-CSE-MsgGUID: AkSw/isoQBG/lGi5VdZh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183309468"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.6])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:05:49 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAmlu-00000001Gnk-1nYO;
	Mon, 20 Oct 2025 13:05:46 +0300
Date: Mon, 20 Oct 2025 13:05:46 +0300
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
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
Message-ID: <aPYJeqFY_9YV9AQn@ashevche-desk.local>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
 <aO1dBgPZfDJTsPfE@smile.fi.intel.com>
 <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 10:06:43AM +0200, Bartosz Golaszewski wrote:
> On Sat, Oct 18, 2025 at 7:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 06, 2025 at 03:00:18PM +0200, Bartosz Golaszewski wrote:

...

> > > +enum software_node_ref_type {
> > > +     /* References a software node. */
> > > +     SOFTWARE_NODE_REF_SWNODE = 0,
> >
> > I don't see why we need an explicit value here.
> 
> It was to make it clear, this is the default value and it's the one
> used in older code with the legacy macros. I can drop it, it's no big
> deal.

Usually when we assign a default value(s) in enum, it should be justified.
The common mistake here (not this case) is to use autoincrement feature
with some of the values explicitly defined for the enums that reflect the
HW bits / states, which obviously makes code fragile and easy to break.

> > > +     /* References a firmware node. */
> > > +     SOFTWARE_NODE_REF_FWNODE,
> > > +};

...

> > >  /**
> > >   * struct software_node_ref_args - Reference property with additional arguments
> > > - * @node: Reference to a software node
> > > + * @swnode: Reference to a software node
> > > + * @fwnode: Alternative reference to a firmware node handle
> > >   * @nargs: Number of elements in @args array
> > >   * @args: Integer arguments
> > >   */
> > >  struct software_node_ref_args {
> > > -     const struct software_node *node;
> > > +     enum software_node_ref_type type;
> > > +     union {
> > > +             const struct software_node *swnode;
> > > +             struct fwnode_handle *fwnode;
> > > +     };
> >
> > Can't we always have an fwnode reference?
> 
> Unfortunately no. A const struct software_node is not yet a full
> fwnode, it's just a template that becomes an actual firmware node when
> it's registered with the swnode framework. However in order to allow
> creating a graph of software nodes before we register them, we need a
> way to reference those templates and then look them up internally in
> swnode code.

Strange that you need this way. The IPU3 bridge driver (that creates a graph of
fwnodes at run-time for being consumed by the respective parts of v4l2
framework) IIRC has no such issue. Why your case is different?

> > >       unsigned int nargs;
> > >       u64 args[NR_FWNODE_REFERENCE_ARGS];
> > >  };

-- 
With Best Regards,
Andy Shevchenko



