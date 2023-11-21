Return-Path: <linux-acpi+bounces-1652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B37F2A80
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953CF1C20A8A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DE440E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yqm889Nc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933198;
	Tue, 21 Nov 2023 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556264; x=1732092264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u62A7F1oWtzbEIi4LYOedZMIWGJAw2h4FmwwmpvK9po=;
  b=Yqm889NcmEAcAbNsrVGUPMqtmVzqoOLPtTDMgCvkerAgPy/EZZxL2Tit
   xayCAA21cgBcH6vgBBxWkbGy2Rjz2KhWchaG14xoN3auIjp3WISOm7fd8
   K1MZ580skn5Dy9nk17T50onDNYs8JW1vhpEBLhxC0fFWGpZD26uD2rm0M
   0RqjdUVvJXDWeOHZEg9TXBjnJWn9zb4n9lBWhUB3RM/A0raWQF64IEepx
   MRCY3Nge9L2wqkaAqT8LffgB2EoapLNdQaLUcZIb66CUCuNxpzED3DpY9
   KNE5tlkMwtJ2U+zecXGtfFZ1AMvZ3JZrjozSDusFscSRnxxM4DgjilyU5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395721622"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="395721622"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124471"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884124471"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:44:21 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0AAB111FC2D;
	Tue, 21 Nov 2023 10:44:19 +0200 (EET)
Date: Tue, 21 Nov 2023 08:44:18 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 6/7] media: imx319: Put usage_count correctly in
 s_ctrl callback
Message-ID: <ZVxt4s_IZvHv_xf5@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
 <20231118185248.GI20846@pendragon.ideasonboard.com>
 <ZVsnmk2JrCsYNGQT@kekkonen.localdomain>
 <20231120094503.GB6824@pendragon.ideasonboard.com>
 <ZVxn0Em-RmfZP-Pm@kekkonen.localdomain>
 <20231121082535.GB8627@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121082535.GB8627@pendragon.ideasonboard.com>

Hi Laurent,

On Tue, Nov 21, 2023 at 10:25:35AM +0200, Laurent Pinchart wrote:
> On Tue, Nov 21, 2023 at 08:18:24AM +0000, Sakari Ailus wrote:
> > Hi Laurent,
> > 
> > On Mon, Nov 20, 2023 at 11:45:03AM +0200, Laurent Pinchart wrote:
> > > On Mon, Nov 20, 2023 at 09:32:10AM +0000, Sakari Ailus wrote:
> > > > On Sat, Nov 18, 2023 at 08:52:48PM +0200, Laurent Pinchart wrote:
> > > > > On Fri, Nov 17, 2023 at 01:14:32PM +0200, Sakari Ailus wrote:
> > > > > > pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
> > > > > > the device, in which case it won't increment the use count.
> > > > > > pm_runtime_put() does that unconditionally however. Only call
> > > > > > pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
> > > > > > 0.
> > > > > 
> > > > > Why don't you use pm_runtime_get_if_active() ?
> > > > 
> > > > It's only meaningful if the driver uses autosuspend. The imx319 driver does
> > > > not.
> > > 
> > > Does pm_runtime_get_if_active() causes issues with the driver uses
> > > autosuspend ? Standardizing on a single API that covers all the use
> > > cases would increase consistency and make the code base easier to
> > > understand. Beside, the driver should switch to autosuspend :-) Using
> > > the correct RPM calls already is a good thing, if they don't introduce
> > > any issue.
> > 
> > Both are fine but they're there for a different purpose. The driver should
> > consistently use either usage_count or status based calls (for autosuspend
> > to make sense).
> 
> But what's the drawback of using pm_runtime_get_if_active() in all cases
> (for camera sensor drivers) ? The semantics in the .s_ctrl() handler is
> "I want to proceed only if the device is powered on", and that's exactly
> what pm_runtime_get_if_active() gives us. The semantics of using
> pm_runtime_get_if_in_use() is "I want to proceed if someone else is
> holding a reference". It happens to give the same practical result as
> pm_runtime_get_if_active() when not using autosuspend, but it's still
> not the right semantics.

Well, using the _active() variant here may introduce an unneeded write
operation so that isn't actually an issue. But using the _if_in_use()
variant in a driver using autosuspend may lead to missing a write --- as it
returns 0 if the usage_count is 0 even if the device is in active state. Oh
well.

I can change the driver to use autosuspend but I think I'll split the set
into two, one doing the Runtime PM API changes and another to address
issues in sensor drivers.

> 
> > > > > Other than that, same comment as for patch 5/7, I don't like the
> > > > > increased complexity.
> > > > > 
> > > > > These comments apply to 7/7 as well.
> > > > > 
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > ---
> > > > > >  drivers/media/i2c/imx319.c | 8 +++++---
> > > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
> > > > > > index 5378f607f340..e7b2d0c20d29 100644
> > > > > > --- a/drivers/media/i2c/imx319.c
> > > > > > +++ b/drivers/media/i2c/imx319.c
> > > > > > @@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > > >  	struct imx319 *imx319 = container_of(ctrl->handler,
> > > > > >  					     struct imx319, ctrl_handler);
> > > > > >  	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
> > > > > > +	int ret, pm_status;
> > > > > >  	s64 max;
> > > > > > -	int ret;
> > > > > >  
> > > > > >  	/* Propagate change of current control to all related controls */
> > > > > >  	switch (ctrl->id) {
> > > > > > @@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > > >  	 * Applying V4L2 control value only happens
> > > > > >  	 * when power is up for streaming
> > > > > >  	 */
> > > > > > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > > > > > +	pm_status = pm_runtime_get_if_in_use(&client->dev);
> > > > > > +	if (!pm_status)
> > > > > >  		return 0;
> > > > > >  
> > > > > >  	switch (ctrl->id) {
> > > > > > @@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > > >  		break;
> > > > > >  	}
> > > > > >  
> > > > > > -	pm_runtime_put(&client->dev);
> > > > > > +	if (pm_status > 0)
> > > > > > +		pm_runtime_put(&client->dev);
> > > > > >  
> > > > > >  	return ret;
> > > > > >  }
> 

-- 
Regards,

Sakari Ailus

