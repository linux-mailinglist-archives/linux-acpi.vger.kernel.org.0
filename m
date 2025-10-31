Return-Path: <linux-acpi+bounces-18399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A595C243C8
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 275C834E6BA
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCE3195F0;
	Fri, 31 Oct 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UheooJD3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028A1E9B3D;
	Fri, 31 Oct 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904016; cv=none; b=UK5JRgkV+Rdbzjs08dhKhbTFqTx24XFmc/ndcFt1YTwW953fO7QQ3NPhxA4aaYOYr9OrlzzieoHHXqipFlkEpVoX6ziXJCPU4op/lvktfphWw5lzNceHMwA8JrYLiGViamIlwM3xqeJ3A3y3NbWQJASady2pw6uTnlqNG3qs6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904016; c=relaxed/simple;
	bh=2eMlBgwX73pe9RAiAfHmesRjr+Xow2HzEmR6TjqXqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERSi9nySFiQaAx9/A0Qful8mEnEhojKRpAU5c9RbyGaB5ybrxFFT969jIT8kOKfhLVDIXIR2VNpU0mORu3AB3kj3390Yk3zDfwCteR13dODc5ym9VIzQ8pVPOaHTxjIpOca+wGjrVAEEnd2HfoEW0/j9JdjjQkV/2IQhldebAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UheooJD3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761904015; x=1793440015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2eMlBgwX73pe9RAiAfHmesRjr+Xow2HzEmR6TjqXqSY=;
  b=UheooJD3raSfEj9nkVon/uD67uSbkM+Be8BAWqjbvJFcYuVBjW6yhEIQ
   Uiyo5wEi5K4nwISWfzlywY6kfKbq2Fe1OaFWEbE2+saT3rwQ9ZY0EqeV/
   trVcN8ZURvsuGEHdb4dz6kXDxYmT/3ZA548/U1YgyBNeLf6yJQ3A+6RED
   KNeUO4jGHKy7GwyPzyWF2y/HSQK2en2D1rP9V9gI5yi4gax0LRLYS9305
   nS8VddtWwpS2TxyYGCbX1p1sVUIkDNnYgHHnD0Er9ZnpSlNhwtSHuXONa
   ANay/rpdcHJj/+IS531ZqQz8wVMXxHBvglRhQmeeHpxcJsNyuf5Rza0zr
   w==;
X-CSE-ConnectionGUID: vmibVxc7SGqhB8RkucyWcQ==
X-CSE-MsgGUID: 53e7CBsuR3mrFT1GpVDtsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67901001"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67901001"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:46:54 -0700
X-CSE-ConnectionGUID: NU+JcNjpT7W+uY91AWHlcA==
X-CSE-MsgGUID: 8Mpc5cneR4OWCfngFJAIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="216850790"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:46:51 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEliX-00000004E91-1gch;
	Fri, 31 Oct 2025 11:46:45 +0200
Date: Fri, 31 Oct 2025 11:46:44 +0200
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
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
Message-ID: <aQSFhHB3txNJ-8uc@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
 <aQMy00pxp7lrIrvh@smile.fi.intel.com>
 <CAMRc=MdP58d=o7ZL4bAdsaYwzrs6nJo3bhS7Jf1UkDNwPOnAsg@mail.gmail.com>
 <aQRyFSHWzccTPa3M@smile.fi.intel.com>
 <CAMRc=McT+Q8ZVk9_HTyWd6uS0OoP92E_phwef7CDyDVeNbJCqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McT+Q8ZVk9_HTyWd6uS0OoP92E_phwef7CDyDVeNbJCqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 10:00:37AM +0100, Bartosz Golaszewski wrote:
> On Fri, Oct 31, 2025 at 9:24 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 30, 2025 at 04:17:48AM -0700, Bartosz Golaszewski wrote:

...

> > But first of all, your series doesn't compile AFAICS:
> >
> > drivers/reset/core.c:981:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >   981 |         if (IS_ERR(rgpio_dev->swnode))
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/reset/core.c:1001:9: note: uninitialized use occurs here
> >        1001 |         return ret;
> >             |                ^~~
> > drivers/reset/core.c:981:2: note: remove the 'if' if its condition is always false
> >   981 |         if (IS_ERR(rgpio_dev->swnode))
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   982 |                 goto err_put_of_node;
> >       |                 ~~~~~~~~~~~~~~~~~~~~
> > drivers/reset/core.c:905:13: note: initialize the variable 'ret' to silence this warning
> >   905 |         int id, ret, lflags;
> >       |                    ^
> >       |                     = 0
> > 1 error generated.
> 
> You're not wrong but for the record: it builds fine for me with
> aarch64-linux-gnu-gcc 14.2 for some reason so I didn't notice it. I'll
> fix it.

GCC is not _the_ compiler nowadays. And building with `make W=1` should be a good
practice for subsystem maintainers :-)

...

> > So, but to the topic
> >
> > I have applied this and get the only error as per above
> >
> >  (const struct software_node_ref_args) {                                \
> >  -       ._node = _ref,                                          \
> >  +       .swnode = _Generic(_ref, const struct software_node *: _ref, default: NULL), \
> >  +       .fwnode = _Generic(_ref, struct fwnode_handle *: _ref, default: NULL), \
> >
> 
> That works, thanks for the idea.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko



