Return-Path: <linux-acpi+bounces-1587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4457F01F5
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 19:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C349B207F2
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A41CFA0
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n5gk1bPg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D48AF;
	Sat, 18 Nov 2023 09:33:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62582DA7;
	Sat, 18 Nov 2023 18:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700328760;
	bh=kYa/kdM1taEQ7R/xrgVMx238iKq4e7XT2QN4efJ7Pw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5gk1bPgAXxXcGPwtOWmko/KRyVpTV8QszmV26oolOONf8kn6jP3sXdThpXYcma14
	 LiLqE/pYChNovqNzRgVb4+OaWinFuAXmBoFuOiMpBYZ/KAltbo8RqpTIjBRmNkAzz9
	 nUyoINyKslwV2OUCG8/Z4OxNOLm7OlepXilhW8tI=
Date: Sat, 18 Nov 2023 19:33:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH v2 5/7] media: ov8858: Use pm_runtime_get_if_active(),
 put usage_count correctly
Message-ID: <20231118173315.GD20846@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-6-sakari.ailus@linux.intel.com>
 <ledwhthyoc6h5ccmwdvyl7cqrp3kdwijcpkzxpp4jvemd6iz2a@na2elf7674a5>
 <ZVicKX8kw94TuOxA@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVicKX8kw94TuOxA@kekkonen.localdomain>

Hi Sakari

On Sat, Nov 18, 2023 at 11:12:41AM +0000, Sakari Ailus wrote:
> On Fri, Nov 17, 2023 at 04:30:15PM +0100, Jacopo Mondi wrote:
> > On Fri, Nov 17, 2023 at 01:14:31PM +0200, Sakari Ailus wrote:
> > > Use pm_runtime_get_if_active() to get the device's runtime PM usage_count
> > > and set controls, then use runtime PM autosuspend once the controls have
> > > been set (instead of likely transitioning to suspended state immediately).
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/media/i2c/ov8858.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
> > > index 3af6125a2eee..a99b91700a8d 100644
> > > --- a/drivers/media/i2c/ov8858.c
> > > +++ b/drivers/media/i2c/ov8858.c
> > > @@ -1538,7 +1538,7 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > >  	struct v4l2_subdev_state *state;
> > >  	u16 digi_gain;
> > >  	s64 max_exp;
> > > -	int ret;
> > > +	int ret, pm_status;
> > >
> > >  	/*
> > >  	 * The control handler and the subdev state use the same mutex and the
> > > @@ -1561,7 +1561,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > >  		break;
> > >  	}
> > >
> > > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > > +	pm_status = pm_runtime_get_if_active(&client->dev);
> > > +	if (!pm_status)
> > >  		return 0;
> > >
> > >  	switch (ctrl->id) {
> > > @@ -1601,7 +1602,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> > >  		break;
> > >  	}
> > >
> > > -	pm_runtime_put(&client->dev);
> > > +	if (pm_status > 0)
> > 
> > I'm not 100% sure I get this bit.
> > 
> > If we get here it means pm_status is either -EINVAL or > 0, otherwise
> > we would have exited earlier.
> > 
> > What's the point of checking for > 0 here ?
> > 
> > There are two cases where pm_status is -EINVAL, either !CONFIG_PM and
> > the the below call is a nop, or if pm_runtime has not been enabled by
> > the driver, which means the driver doesn't use pm_runtime at all.
> > 
> > Are there other cases I have missed that require checking here for
> > pm_status > 0 ?
> 
> Other than Runtime PM being disabled, I don't think that should happen.
> 
> So as such this patch does not fix a bug. I just prefer to be extra
> cautious when it comes to use counts.

What happened to the old motto of "if it's not broken, don't fix it" ?
:-) I like how this series (slightly) simplifies the runtime PM API by
giving pm_runtime_get_if_active() the right behaviour for the most
common use cases. Let's continue in that direction, and evolve the API
to simplify driver, not render them more complex.

I would prefer refactoring this series to first switch drivers to
pm_runtime_get_if_active(), and then use autosuspend at the end of the
.s_ctrl() handler. That can be two patches, each modifying all relevant
sensor driver.

> > > +		pm_runtime_mark_busy_autosusp(&client->dev);
> > >
> > >  	return ret;
> > >  }

-- 
Regards,

Laurent Pinchart

