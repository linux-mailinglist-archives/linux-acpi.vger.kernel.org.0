Return-Path: <linux-acpi+bounces-10077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E29EC623
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A83B1652FE
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3D1CACF6;
	Wed, 11 Dec 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnOw2C/E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DC1C726D;
	Wed, 11 Dec 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903834; cv=none; b=ryvI3tZ25Qymi/+SxyyhXnqkFPX12n4lQa7ONBZSoDdZRoRIphUZBEVRcErY8tAAuoYykij+WYegF0Cd+ERcb2x43KyQ2KhASna6YQn/XNnr72u7tG4AnJiU9vtwu4Qr3A9BhTo+ETgHgGevFz8t97ejmwU+jVMVlrQ4Z5g1lYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903834; c=relaxed/simple;
	bh=TNHoeayqTPJ6AMctaO/TnteDAl9yYo6MW6f0vnT3lmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivwJ9qKKwEVDFIMUkYVfG+iTrHI0NZCELNLHfKwO7I6s8s5+wbirRqbTPYFiFeKl+m/2BlG7dEU4PgnoQOWm4AITdSLgXudnTDcwQVYA6VVgsvpkeP4wnoeVnNeliI5dUUDU1/c35YS89pbOlgHOWdmJ7RtyxbSTqA12CdTG5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnOw2C/E; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733903832; x=1765439832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNHoeayqTPJ6AMctaO/TnteDAl9yYo6MW6f0vnT3lmk=;
  b=EnOw2C/EQ+IMrBZiHgXcvArVEBTc80vbPzUOU3zK9R+xt4ywOdO4xKZn
   snV/XtV6vuqTmCAbn/V+MrpyptOICPS6uJCUNCiHRsO6YjVo+/20k7939
   vRj/Q5tV9RwJIkvl4VHAcQN8kl1ZMozYjetQ/NUF/lZ0Zs+RC4a373/43
   yGHxHJSrw/tS5bx5XWOaH7cucj4DN3WVgsggiJzVOtw9zU7lChtBcMOwf
   ukx2xszsnZgAkZTZqsYeYlB0z4SkwLvzQvvoOOXMzmL/8bOesuv/Gpthq
   AC69S+fw3U65LJmoS/rkmiB6f1O8JNJxW8SmucXU/Zqd1+Jal+ixLsq2V
   g==;
X-CSE-ConnectionGUID: lm4xJSlKT7O4PdsN1WTjhQ==
X-CSE-MsgGUID: 1KPIJlUZTPWfqWWM5albZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51803554"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="51803554"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:57:11 -0800
X-CSE-ConnectionGUID: bP6dVd3cRgmbRiE5w75fyA==
X-CSE-MsgGUID: 6WDo9tM6RU2hapCW1CU/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126628807"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:57:09 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0114511F71F;
	Wed, 11 Dec 2024 09:57:06 +0200 (EET)
Date: Wed, 11 Dec 2024 07:57:06 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Message-ID: <Z1lF0ij99KpbVKQs@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
 <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
 <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>

Hi Ricardo,

On Tue, Dec 10, 2024 at 11:35:35PM +0100, Ricardo Ribalda wrote:
> On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:
> > > Provide an implementation of acpi_device_hid that can be used when
> > > CONFIG_ACPI is not set.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  include/acpi/acpi_bus.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > index 4f1b3a6f107b..c25914a152ee 100644
> > > --- a/include/acpi/acpi_bus.h
> > > +++ b/include/acpi/acpi_bus.h
> > > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> > >
> > >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > >
> > > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > > +{
> > > +     return "";
> > > +}
> >
> > I wonder if any caller might expect something of a string if provided?
> > Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> > function returns "device" when one cannot be found (dummy_hid in
> > drivers/acpi/scan.c). Unlikely to be a problem perhaps.
> 
> Good point. I changed it to return "device"

When ACPI is disabled, it's unlikely that string would be used anyway, vs.
the case when ACPI is enabled but there's no _HID. So I think an empty
string should be fine. I wonder what others think.

-- 
Sakari Ailus

