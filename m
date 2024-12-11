Return-Path: <linux-acpi+bounces-10078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA09EC641
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A291881F91
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422621D61B9;
	Wed, 11 Dec 2024 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh7EW2kp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFE1C760A;
	Wed, 11 Dec 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903940; cv=none; b=CbO4iRwzMun0XhiMaQipQc9depQPK5z83HLmbJJHeDP0uFGgT2VcyY3aEzfxRymVoCnXjQZ/8rw4I6+EAZcsnEY0gqXcYl1Kmw9pLsvwMR12t81Lx7Qfgg7moqQNgMEMGs/8/rBNoTzqS2jN7n7PF5z1oCSub+9h2lEXnefoHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903940; c=relaxed/simple;
	bh=nKdwgQDMHYy/FWDmzfRtOGZOPchDY10KI7885OTpYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghToZVY6OfUMkhPiVaua5j0SeKIhj1SGnZi8mtDzkaMCR9H3eWdxrEEQsNhV+dNji4tav8z2U1w/9MmKxp6inb3ZDfqjxhtFU/v/gKnJZAiZJefp7AEADuJOZUvsM22SeAt48l+E44UagJWO+02SjQSPHAa3AfqbtkvzGyN88nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh7EW2kp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733903939; x=1765439939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKdwgQDMHYy/FWDmzfRtOGZOPchDY10KI7885OTpYnE=;
  b=Yh7EW2kpHHZqgDdeSeOv4xsBhcR184xhf04htjpELXPkHR62byJCHr7I
   XK2pkPNxG3xfJkRqQYBUg16sR0AIKth/y0Bv6ng1+0vRme7X00RgsECPm
   73GXjxfEfZk+SIqAMIT+/M72T7rOIvOq+X3c6VPiSyEqa1RorBrbvFhIF
   3anjq0QCaHsu//j5nnIC6oaaWMQFHKfXchqL9qTHkN3AYO9HuY2iOo5/V
   YNslrWLz4DGJdmYCnrqkUY5geUE8MCYCGWxnhaJ4a6KMVqdO3NAiECRZK
   ZR9P0+1qKCsKA+UQnM0zP0PCw5WZECX3nSRqJv2DA1BzPbHL7nH6JBX6o
   Q==;
X-CSE-ConnectionGUID: PYgDUudTT7aLzWoEsGAdjw==
X-CSE-MsgGUID: mnMC7c0JSPmEBeZXfDcEqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45676065"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45676065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:58:58 -0800
X-CSE-ConnectionGUID: KZD06ebBQvqEVdy+PuLNHQ==
X-CSE-MsgGUID: wW9CCKjLTPqRhEUzKDIw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95539871"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:58:55 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 38E6B11F71F;
	Wed, 11 Dec 2024 09:58:53 +0200 (EET)
Date: Wed, 11 Dec 2024 07:58:53 +0000
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
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Message-ID: <Z1lGPWHYTdfcxFPL@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>
 <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
 <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>

On Tue, Dec 10, 2024 at 11:31:57PM +0100, Ricardo Ribalda wrote:
> On Tue, 10 Dec 2024 at 21:56, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> > > Provide an implementation of acpi_device_handle that can be used when
> > > CONFIG_ACPI is not set.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  include/linux/acpi.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index 05f39fbfa485..59a5d110ff54 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
> > >  #define acpi_dev_hid_uid_match(adev, hid2, uid2)     (adev && false)
> > >
> > >  struct fwnode_handle;
> > > +struct acpi_device;
> > > +
> > > +static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
> > > +{
> > > +     return NULL;
> > > +}
> > >
> > >  static inline bool acpi_dev_found(const char *hid)
> > >  {
> > >
> >
> > Please remove the extra forward declaration of struct acpi_device a few
> > lines below this.
> 
> Instead I have moved the function under the forward declaration. Let
> me know if you disagree.

The same order in which the functions are found in the actual
implementation would be my suggestion. Rafael could also have an opinion.

-- 
Sakari Ailus

