Return-Path: <linux-acpi+bounces-1599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87BA7F0DA0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E21C2115A
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F47486
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzyyzV7J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A2137;
	Mon, 20 Nov 2023 00:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700469075; x=1732005075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSqxMouuJFaVnVg+4nvXMXYc/b/CnBPtnslafhZwyjQ=;
  b=jzyyzV7JGIfYVwXgkuwNFKLQzrE+9xqe7WcaRUc5Tg7EpNk5ZxfRq2Uc
   hhPgmEKkMrY5Nx6avp0XGGuzaNwSv+cMtefwzcDrmieVSPDj2OVTaAcUM
   9YH63JvQVG+1V7zDjQeU9TVgXTsjhD77SG5Kh81v539sb+RA3OMhJmFGZ
   MKwaFJGnKLh2gkRfuOv+0O8hVkB/be/IfED3VySBlHx04lObcwOaNaTkn
   gjdQLUhSRxGhgOt9E4jEcWGT9QLVefQca3STuHFvC7DDZ87v3XZKUllc8
   tyahSAgIG4uKn+IE5plZCSX/M+IpeqGv/GAe7vvzTbRTtc0FBUiOvNzxP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13128819"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13128819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795401503"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="795401503"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:31:12 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 35DC7120A59;
	Mon, 20 Nov 2023 10:31:09 +0200 (EET)
Date: Mon, 20 Nov 2023 08:31:09 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH v2 5/7] media: ov8858: Use pm_runtime_get_if_active(),
 put usage_count correctly
Message-ID: <ZVsZTbd2U4IX2v1j@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-6-sakari.ailus@linux.intel.com>
 <ledwhthyoc6h5ccmwdvyl7cqrp3kdwijcpkzxpp4jvemd6iz2a@na2elf7674a5>
 <ZVicKX8kw94TuOxA@kekkonen.localdomain>
 <20231118173315.GD20846@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118173315.GD20846@pendragon.ideasonboard.com>

Hi Laurent,

On Sat, Nov 18, 2023 at 07:33:15PM +0200, Laurent Pinchart wrote:
> Hi Sakari
> 
> On Sat, Nov 18, 2023 at 11:12:41AM +0000, Sakari Ailus wrote:
> > On Fri, Nov 17, 2023 at 04:30:15PM +0100, Jacopo Mondi wrote:
> > > On Fri, Nov 17, 2023 at 01:14:31PM +0200, Sakari Ailus wrote:
> > > > Use pm_runtime_get_if_active() to get the device's runtime PM usage_count
> > > > and set controls, then use runtime PM autosuspend once the controls have
> > > > been set (instead of likely transitioning to suspended state immediately).
> > > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/media/i2c/ov8858.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
> > > > index 3af6125a2eee..a99b91700a8d 100644
> > > > --- a/drivers/media/i2c/ov8858.c
> > > > +++ b/drivers/media/i2c/ov8858.c
> > > > @@ -1538,7 +1538,7 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  	struct v4l2_subdev_state *state;
> > > >  	u16 digi_gain;
> > > >  	s64 max_exp;
> > > > -	int ret;
> > > > +	int ret, pm_status;
> > > >
> > > >  	/*
> > > >  	 * The control handler and the subdev state use the same mutex and the
> > > > @@ -1561,7 +1561,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  		break;
> > > >  	}
> > > >
> > > > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > > > +	pm_status = pm_runtime_get_if_active(&client->dev);
> > > > +	if (!pm_status)
> > > >  		return 0;
> > > >
> > > >  	switch (ctrl->id) {
> > > > @@ -1601,7 +1602,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  		break;
> > > >  	}
> > > >
> > > > -	pm_runtime_put(&client->dev);
> > > > +	if (pm_status > 0)
> > > 
> > > I'm not 100% sure I get this bit.
> > > 
> > > If we get here it means pm_status is either -EINVAL or > 0, otherwise
> > > we would have exited earlier.
> > > 
> > > What's the point of checking for > 0 here ?
> > > 
> > > There are two cases where pm_status is -EINVAL, either !CONFIG_PM and
> > > the the below call is a nop, or if pm_runtime has not been enabled by
> > > the driver, which means the driver doesn't use pm_runtime at all.
> > > 
> > > Are there other cases I have missed that require checking here for
> > > pm_status > 0 ?
> > 
> > Other than Runtime PM being disabled, I don't think that should happen.
> > 
> > So as such this patch does not fix a bug. I just prefer to be extra
> > cautious when it comes to use counts.
> 
> What happened to the old motto of "if it's not broken, don't fix it" ?

People tend to take patterns used in drivers and this indeed works here,
but only when taken with the rest of the Runtime PM API usage.

> :-) I like how this series (slightly) simplifies the runtime PM API by
> giving pm_runtime_get_if_active() the right behaviour for the most
> common use cases. Let's continue in that direction, and evolve the API
> to simplify driver, not render them more complex.
> 
> I would prefer refactoring this series to first switch drivers to
> pm_runtime_get_if_active(), and then use autosuspend at the end of the
> .s_ctrl() handler. That can be two patches, each modifying all relevant
> sensor driver.

I think it should be fine to do both in the same patch indeed.

-- 
Regards,

Sakari Ailus

