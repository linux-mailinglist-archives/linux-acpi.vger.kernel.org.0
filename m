Return-Path: <linux-acpi+bounces-1603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D87F108F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 11:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13181F23646
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A011714
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+rYXya1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1632F9C;
	Mon, 20 Nov 2023 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700472748; x=1732008748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOu8RgApBuBgJtz/u/ZO1QzgpElGl4/utOOXjjtTTZU=;
  b=H+rYXya1F0i+Mh+zZ01FVNQCTiwi7zQYL8rzmrdkt3imCnN+uJZQ/+E9
   a+pmTZOylQF1v12vW6F7XZs7E2wXNbP0vQuiOVFrbBbgvYcuNirAGPMYq
   KyNwEMCYYxV7BgB8+4iL9sBwsqRx0Hydl5Yr+WU2UluuEnl7OYMrwaNW3
   cV+hg5UJL36sSBJo6+8AduVEPK+yMehy71c764VK07tTcrxUJjlMW38WD
   m4EnnPQL6EDJgtbe8J+BWDg+BBfzCfX/kbcmHsEwcrNLJDlCsvUrAETlh
   cog/Ysbv4nfwLU62Y0TtJYUDZiIlpjWFdXQ4fdkgWV2Iz1s/TsfiEW1wT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="10255968"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="10255968"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="14093417"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:32:13 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 12B0211FBD1;
	Mon, 20 Nov 2023 11:32:10 +0200 (EET)
Date: Mon, 20 Nov 2023 09:32:10 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 6/7] media: imx319: Put usage_count correctly in
 s_ctrl callback
Message-ID: <ZVsnmk2JrCsYNGQT@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
 <20231118185248.GI20846@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118185248.GI20846@pendragon.ideasonboard.com>

Hi Laurent,

On Sat, Nov 18, 2023 at 08:52:48PM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Fri, Nov 17, 2023 at 01:14:32PM +0200, Sakari Ailus wrote:
> > pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
> > the device, in which case it won't increment the use count.
> > pm_runtime_put() does that unconditionally however. Only call
> > pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
> > 0.
> 
> Why don't you use pm_runtime_get_if_active() ?

It's only meaningful if the driver uses autosuspend. The imx319 driver does
not.

> 
> Other than that, same comment as for patch 5/7, I don't like the
> increased complexity.
> 
> These comments apply to 7/7 as well.
> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/i2c/imx319.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
> > index 5378f607f340..e7b2d0c20d29 100644
> > --- a/drivers/media/i2c/imx319.c
> > +++ b/drivers/media/i2c/imx319.c
> > @@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> >  	struct imx319 *imx319 = container_of(ctrl->handler,
> >  					     struct imx319, ctrl_handler);
> >  	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
> > +	int ret, pm_status;
> >  	s64 max;
> > -	int ret;
> >  
> >  	/* Propagate change of current control to all related controls */
> >  	switch (ctrl->id) {
> > @@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> >  	 * Applying V4L2 control value only happens
> >  	 * when power is up for streaming
> >  	 */
> > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > +	pm_status = pm_runtime_get_if_in_use(&client->dev);
> > +	if (!pm_status)
> >  		return 0;
> >  
> >  	switch (ctrl->id) {
> > @@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> >  		break;
> >  	}
> >  
> > -	pm_runtime_put(&client->dev);
> > +	if (pm_status > 0)
> > +		pm_runtime_put(&client->dev);
> >  
> >  	return ret;
> >  }
> 

-- 
Regards,

Sakari Ailus

