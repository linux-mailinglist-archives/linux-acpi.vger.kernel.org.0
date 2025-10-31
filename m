Return-Path: <linux-acpi+bounces-18398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BABC243AD
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFF5F4E1764
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3C3328FF;
	Fri, 31 Oct 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJQp45jW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A53321D0;
	Fri, 31 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903898; cv=none; b=bpW/i1WQ4vIbjppsjZFMOjQ51toVAfK8o2KGSxW1BUg7R9NoVHfMdumB8NY8IhpLv/SRDBDYt2ECP7t/4uKBKZ7d097AIfS5QQgUfBiEWmR0GeXRReZEh6pCLx2/C3441tM+dkNUkUq6vAgdeZiCl22CD6I6Ij28t9gzB2Zn+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903898; c=relaxed/simple;
	bh=W1/1S8pbkK7C0u28bpvyZYwnXyaEuxILSG4wJI3da0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suFQoiekjTaqjvNuPmQonuKZG9LsGdM+M1y0NhqyEiSb0sCg+6oRyrlPyUjOpSD9DvyA4wixaleItbyYPw29X7Rbd07EOsL9GuReJw1Db/sdKHxcwFPWSOplqvSaMCbDkDpT89LvdGBPk+yhORR8dqC1XTrRbJl/le9EfGuNmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJQp45jW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761903896; x=1793439896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W1/1S8pbkK7C0u28bpvyZYwnXyaEuxILSG4wJI3da0U=;
  b=NJQp45jWsGQ1mgXuayf5WZA0L20Eu8bR713gH0Uwqbh099WxF4V+ro/W
   EwmNDzqPTqxTCkrKa6/dbvY0r2GeH7Zue0qMBrkx0iRV6GN47WYILxHeM
   xSn/6eSnlsM1cpXeDbjsyF6ggSs3DmwzARVu1Og4UHi2VvTKwzj7WsERO
   5a3S7RqrSxqc/bxCtn5fyLwcmlUHfBR2WY42hY9JF/Np/jW6SiSWDkzhx
   OarkA1bhkz4FRmeuYwHE1zTuENVNZVb/hNfGr1y2BKWzoo+ypapfTb/AQ
   pM4JaXh9FkI1m2lJHmLlbIxnRbUuqqPxi7XV2X7HR+R7XfHnxW/KfS35N
   Q==;
X-CSE-ConnectionGUID: 76fjW3gIQKCIcqlpR/lUtg==
X-CSE-MsgGUID: vkS5KT6gQFOkUSHkkSmy2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75412428"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="75412428"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:44:56 -0700
X-CSE-ConnectionGUID: 1RCOsBKvQwW89kLC4Pp0qQ==
X-CSE-MsgGUID: ZcpeyFZjRpuYbf/w3i1gFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186312801"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:44:53 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vElgd-00000004E7V-0sB5;
	Fri, 31 Oct 2025 11:44:47 +0200
Date: Fri, 31 Oct 2025 11:44:46 +0200
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
Message-ID: <aQSFDhUp89xul2AP@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
 <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
 <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
 <aQRztwrOFCWk8IG8@smile.fi.intel.com>
 <CAMRc=MezQ7RC=ZjiKkMa0qiaKTRXePOKxOCDjjV=-qUYto2jqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MezQ7RC=ZjiKkMa0qiaKTRXePOKxOCDjjV=-qUYto2jqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
> On Fri, Oct 31, 2025 at 9:30 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 30, 2025 at 03:33:02AM -0700, Bartosz Golaszewski wrote:
> > > On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> said:

...

> > > Andy: the resulting code after patch 3/10 looks like this:
> > >
> > > struct fwnode_handle *refnode;
> > >
> > > (...)
> >
> > Let's say something like below to be put here
> >
> > /*
> >  * The reference in software node may refer to a node of a different type.
> >  * Depending on the type we choose either to use software node directly, or
> >  * delegate that to fwnode API.
> >  */
> 
> But this is incorrect: we're not really doing that. We either use the
> firmware node reference directly OR cast the software node to its
> firmware node representation. We ALWAYS use the firmware node API
> below.
> 
> This really *is* evident from the code but if it'll make you happy and
> make you sign off on this, I'll add a corrected version.

The comment should answer to the Q: "Why the heck are we calling fwnode APIs here?"

> IMO It's completely redundant.

This is unusual case for swnode API (see other functions, they call directly
the low-level implementation instead of going to a round via fwnode). That's
why I insist on a comment of this piece. It may be obvious for you, but the
unprepared read would be surprised by this inconsistency.

-- 
With Best Regards,
Andy Shevchenko



