Return-Path: <linux-acpi+bounces-10090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B59EC7A8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BEB188873A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E91E9B07;
	Wed, 11 Dec 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1CXcQDj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA01C5F12;
	Wed, 11 Dec 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906939; cv=none; b=GKFNdRf89nA2W9zWtMCEzWaxdQP7fq6RBfSXsHGuvu5Zbhh7vrf9qme8MrXDw/R0qOw2zs7IU5uAJTl3ELbBoxbvW067bwR+ql4r796l0Xu0RxITALs0vtlMkjqmEJUfOkzFyrD1x8l3L/dXSR3ZBBpZx4qc3ZbFasI/RBzd+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906939; c=relaxed/simple;
	bh=j+vqd/a5a5hgbl3tcDMK9EMkSQgtkl+vvBnHssubgDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/xcznoVyYAaLXpgHb73TtHeAdxAeQgkYU5XzoZwJ2q2A8cG3r/MbpbgBbhy6ycxNy1qQDjrbN+/A/BGEhOeiIX26oFFU7CaR4cG55tbASJlBxyKToOghe9HPqagTWdgSoFfSVY7o5yBHvCUHGJQQ5Uu2HNdg1woYhE8mFuU/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1CXcQDj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733906937; x=1765442937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+vqd/a5a5hgbl3tcDMK9EMkSQgtkl+vvBnHssubgDs=;
  b=J1CXcQDjqM9YLnjrdYaSJevDGPA2JJQO6WIxsfmIvbdvUjJ97FxjB6a4
   DdoE8Aiw2An4ICk6nJgSUVNAlWcqZHc3ImeFqOGnC94yl09Jirt7Y2twS
   26adQC2GYKEr6z+126z9UccjXrfwTp/KwGD8wCdd+5s6zcJD/71OSA3Al
   aY6kSJuljXyFv7ejDRrLzrWuQi5IxbpCqwtgnG7dWxd4V9XhmvswTDh8w
   iVy1wKTHJ6I/vI3GY8g0C4eSvdcUTp3bdG+9y/TzcW7dqHERLDq5+9zxr
   i7cBL/cvSJwd4TZYkm2LuvwFNZjcRhjjhRlsFJquNBVoj0xd4A7CoGDQT
   g==;
X-CSE-ConnectionGUID: pqNUoLOORAOmpzseWZADPw==
X-CSE-MsgGUID: pWqr35LNSjGhEzubVYzFqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44946662"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="44946662"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:48:56 -0800
X-CSE-ConnectionGUID: Q1ogiordSHGSAV9fQnvLlA==
X-CSE-MsgGUID: EGEskwiASuGo+htXH3OG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99809895"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:48:54 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 67CF011F99E;
	Wed, 11 Dec 2024 10:48:51 +0200 (EET)
Date: Wed, 11 Dec 2024 08:48:51 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Message-ID: <Z1lR869cuIw_p2-l@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
 <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
 <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
 <Z1lF0ij99KpbVKQs@kekkonen.localdomain>
 <20241211094037.26aa369a@foz.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211094037.26aa369a@foz.lan>

Hi Mauro,

On Wed, Dec 11, 2024 at 09:40:37AM +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 11 Dec 2024 07:57:06 +0000
> Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:
> 
> > Hi Ricardo,
> > 
> > On Tue, Dec 10, 2024 at 11:35:35PM +0100, Ricardo Ribalda wrote:
> > > On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:  
> > > >
> > > > Hi Ricardo,
> > > >
> > > > On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:  
> > > > > Provide an implementation of acpi_device_hid that can be used when
> > > > > CONFIG_ACPI is not set.
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  include/acpi/acpi_bus.h | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > > > index 4f1b3a6f107b..c25914a152ee 100644
> > > > > --- a/include/acpi/acpi_bus.h
> > > > > +++ b/include/acpi/acpi_bus.h
> > > > > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> > > > >
> > > > >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > > > >
> > > > > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > > > > +{
> > > > > +     return "";
> > > > > +}  
> > > >
> > > > I wonder if any caller might expect something of a string if provided?
> > > > Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> > > > function returns "device" when one cannot be found (dummy_hid in
> > > > drivers/acpi/scan.c). Unlikely to be a problem perhaps.  
> > > 
> > > Good point. I changed it to return "device"  
> > 
> > When ACPI is disabled, it's unlikely that string would be used anyway, vs.
> > the case when ACPI is enabled but there's no _HID. So I think an empty
> > string should be fine. I wonder what others think.
> > 
> Returning "" also caused me some attention at the original patch. IMO,
> placing a pseudo-valid HID would be better, but I guess "device" is also
> invalid, as, at least I always saw HIDs in uppercase. Also, I guess it
> is always a vendor ID + a 4 digit number.
> 
> so, IMHO, something like "DEVC9999" would be a better name if we fill it.

How about post a patch changing "device" in drivers/acpi/scan.c? :-) But I
think the string also needs to be an invalid as a _HID object so it's not
masking an actual hardware ID used by a real device.

-- 
Kind regards,

Sakari Ailus

