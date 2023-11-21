Return-Path: <linux-acpi+bounces-1649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8807F278A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 09:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD36B21851
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B52568
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyohiAcW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81641FE7;
	Tue, 21 Nov 2023 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700554713; x=1732090713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1gP/kyd2HuAZq2Svti1WDK6qsZC2V7l/JkjgJHKc99s=;
  b=OyohiAcWqUU1BsPLAJv2t1Pe3PzGGyPlUpkrBnTNF770ScWhJF4Mg5B6
   PkC0Q0Hs4fTABzMAdgvMCCHMxDwJoVaLR30N3Aqj7AnfxFHetjnWhey1P
   3/U58Rrzpc7tad2fKf8mGMArf+Qg99eOWLSY0fxEld9yT6UHuF84vCz4g
   y1q98IjmS85b7EXL6CNRKPEAotLjADC9NFJdWARR0F98XynC7ieqKVQ/r
   56N8i4h8gqy5IFGRFjaX9G0E5sEBTs7gHe9/HgSCKH5BPDNDxcapC5hQa
   aAyzvR6VSdeZimBcp2XLCD74OcwWI7FfI57xTE1ttB2COiVtUbg+RP3Cx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4985079"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4985079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="910378508"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="910378508"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:18:27 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7AFA811FC2D;
	Tue, 21 Nov 2023 10:18:24 +0200 (EET)
Date: Tue, 21 Nov 2023 08:18:24 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 6/7] media: imx319: Put usage_count correctly in
 s_ctrl callback
Message-ID: <ZVxn0Em-RmfZP-Pm@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
 <20231118185248.GI20846@pendragon.ideasonboard.com>
 <ZVsnmk2JrCsYNGQT@kekkonen.localdomain>
 <20231120094503.GB6824@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120094503.GB6824@pendragon.ideasonboard.com>

Hi Laurent,

On Mon, Nov 20, 2023 at 11:45:03AM +0200, Laurent Pinchart wrote:
> On Mon, Nov 20, 2023 at 09:32:10AM +0000, Sakari Ailus wrote:
> > On Sat, Nov 18, 2023 at 08:52:48PM +0200, Laurent Pinchart wrote:
> > > On Fri, Nov 17, 2023 at 01:14:32PM +0200, Sakari Ailus wrote:
> > > > pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
> > > > the device, in which case it won't increment the use count.
> > > > pm_runtime_put() does that unconditionally however. Only call
> > > > pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
> > > > 0.
> > > 
> > > Why don't you use pm_runtime_get_if_active() ?
> > 
> > It's only meaningful if the driver uses autosuspend. The imx319 driver does
> > not.
> 
> Does pm_runtime_get_if_active() causes issues with the driver uses
> autosuspend ? Standardizing on a single API that covers all the use
> cases would increase consistency and make the code base easier to
> understand. Beside, the driver should switch to autosuspend :-) Using
> the correct RPM calls already is a good thing, if they don't introduce
> any issue.

Both are fine but they're there for a different purpose. The driver should
consistently use either usage_count or status based calls (for autosuspend
to make sense).

> 
> > > Other than that, same comment as for patch 5/7, I don't like the
> > > increased complexity.
> > > 
> > > These comments apply to 7/7 as well.
> > > 
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/media/i2c/imx319.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
> > > > index 5378f607f340..e7b2d0c20d29 100644
> > > > --- a/drivers/media/i2c/imx319.c
> > > > +++ b/drivers/media/i2c/imx319.c
> > > > @@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  	struct imx319 *imx319 = container_of(ctrl->handler,
> > > >  					     struct imx319, ctrl_handler);
> > > >  	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
> > > > +	int ret, pm_status;
> > > >  	s64 max;
> > > > -	int ret;
> > > >  
> > > >  	/* Propagate change of current control to all related controls */
> > > >  	switch (ctrl->id) {
> > > > @@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  	 * Applying V4L2 control value only happens
> > > >  	 * when power is up for streaming
> > > >  	 */
> > > > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > > > +	pm_status = pm_runtime_get_if_in_use(&client->dev);
> > > > +	if (!pm_status)
> > > >  		return 0;
> > > >  
> > > >  	switch (ctrl->id) {
> > > > @@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >  		break;
> > > >  	}
> > > >  
> > > > -	pm_runtime_put(&client->dev);
> > > > +	if (pm_status > 0)
> > > > +		pm_runtime_put(&client->dev);
> > > >  
> > > >  	return ret;
> > > >  }
> 

-- 
Regards,

Sakari Ailus

