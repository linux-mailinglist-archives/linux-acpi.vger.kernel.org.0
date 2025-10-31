Return-Path: <linux-acpi+bounces-18402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F1C25068
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 13:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC3864F5ECA
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412634A3B6;
	Fri, 31 Oct 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEM92E8z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8C338F54;
	Fri, 31 Oct 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913930; cv=none; b=O9Y89lelE9QstUt4RiOeQ3eL+0weVCoH/Hg/AgMlabtv+OHs7cD4u4MCqrnS10KS0lg4/g935lylVlREmr3BZXbZuN5JDP2mEYK/8Pse/y09sRCMDpvNeUvRkPsk4nvUOnxmgRw99gEZPtjbTTkiEO+djyTp/NSlQo4MIqfqkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913930; c=relaxed/simple;
	bh=vAvTZWxGuxuqYRzWeF+dPsTukeuTCdomYTBSlfcskGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B72sLgQZgRFKfVnTDuQv/qs5bS8yB6H3jZyIYA1JixWTJnH15U7oaO7qZ4xN1T6+HwcBM3rtU+8qrS9fxm0HPLVL6VDhOn3kfVITB/Lax2GzQvHrs8161pCzeDZKZBFCgid0yk0KHx2hcmZkBxwwOe4pu6/YYud3G0WicpjGKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEM92E8z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761913927; x=1793449927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vAvTZWxGuxuqYRzWeF+dPsTukeuTCdomYTBSlfcskGI=;
  b=lEM92E8z7PO6kvI8wA1U/JkObZeBvcJuFxTyjjFKfsSkSD0Vy83wntd2
   1Oe7evCWnEAY2QgR89OitD6/O2OnNf18lInbiiP8oSolSpc+mbXlAnmH2
   2C78G2n+NCpJ0DJEpTSf4wbyQPqrdhF8wBE0H9jcvsE4u/bAu50jgCdD3
   zynmT3/PI2tVLBY+teeL0CkgP1do1tnpScGms9Q4+uzv7dVq/5HcYkQy+
   1w8T0P9oawETXwhGYysr7vKi12vIuGOW8QWpWasv6msB4joNzMqu4sMxQ
   cFxA7OvL/4qKiqV5MMhh+aupIABw5nXfJaUxg8S9fCjPNyX8GYb+x+Hag
   w==;
X-CSE-ConnectionGUID: Gml329+OQSuyGMI9HS1tvw==
X-CSE-MsgGUID: b1L/cz73Qli1dLTZTtXHHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64001045"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64001045"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:32:05 -0700
X-CSE-ConnectionGUID: imYMsrLsRyC9p//fO6WQxg==
X-CSE-MsgGUID: 3/0RZUxDQyub/6nfaKcuNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186342409"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:32:03 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEoIP-00000004GCj-28Or;
	Fri, 31 Oct 2025 14:31:57 +0200
Date: Fri, 31 Oct 2025 14:31:56 +0200
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
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aQSsPIJ26Sx2WqhE@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
 <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
 <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
 <aQRztwrOFCWk8IG8@smile.fi.intel.com>
 <CAMRc=MezQ7RC=ZjiKkMa0qiaKTRXePOKxOCDjjV=-qUYto2jqA@mail.gmail.com>
 <aQSFDhUp89xul2AP@smile.fi.intel.com>
 <CAMRc=MdfbbkWBeAgw3G=k7xgSc8TPhZQ56ks9Or9p9Ah-y5YQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdfbbkWBeAgw3G=k7xgSc8TPhZQ56ks9Or9p9Ah-y5YQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 05:27:10AM -0500, Bartosz Golaszewski wrote:
> On Fri, 31 Oct 2025 10:44:46 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Fri, Oct 31, 2025 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
> >> On Fri, Oct 31, 2025 at 9:30 AM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >> > On Thu, Oct 30, 2025 at 03:33:02AM -0700, Bartosz Golaszewski wrote:
> >> > > On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
> >> > > <andriy.shevchenko@linux.intel.com> said:

...

> >> > > Andy: the resulting code after patch 3/10 looks like this:
> >> > >
> >> > > struct fwnode_handle *refnode;
> >> > >
> >> > > (...)
> >> >
> >> > Let's say something like below to be put here
> >> >
> >> > /*
> >> >  * The reference in software node may refer to a node of a different type.
> >> >  * Depending on the type we choose either to use software node directly, or
> >> >  * delegate that to fwnode API.
> >> >  */
> >>
> >> But this is incorrect: we're not really doing that. We either use the
> >> firmware node reference directly OR cast the software node to its
> >> firmware node representation. We ALWAYS use the firmware node API
> >> below.
> >>
> >> This really *is* evident from the code but if it'll make you happy and
> >> make you sign off on this, I'll add a corrected version.
> >
> > The comment should answer to the Q: "Why the heck are we calling fwnode APIs here?"
> >
> >> IMO It's completely redundant.
> >
> > This is unusual case for swnode API (see other functions, they call directly
> > the low-level implementation instead of going to a round via fwnode). That's
> > why I insist on a comment of this piece. It may be obvious for you, but the
> > unprepared read would be surprised by this inconsistency.
> >
> 
> I propose to have the following:
> 
> +       /*
> +        * A software node can reference other software nodes or firmware
> +        * nodes (which are the abstraction layer sitting on top of them).
> +        * This is done to ensure we can create references to static software
> +        * nodes before they're registered with the firmware node framework.
> +        * At the time the reference is being resolved, we expect the swnodes
> +        * in question to already have been registered and to be backed by
> +        * a firmware node. This is why we use the fwnode API below to read the
> +        * relevant properties and bump the reference count.
> +        */
> 
> This at least adds relevant information on *why* we're using the fwnode API.

Yes, works for me, thanks!

-- 
With Best Regards,
Andy Shevchenko



