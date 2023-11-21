Return-Path: <linux-acpi+bounces-1650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F637F278B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002728209D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3D184C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mLGi/G6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C795;
	Tue, 21 Nov 2023 00:25:30 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5EC52E4;
	Tue, 21 Nov 2023 09:24:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700555098;
	bh=wu5bAQsUBMGhfqI4kV5Lkw3qa0jjJActcUfhAkc+wuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLGi/G6wqYPEEvHUndDCZ1bAzYDrH8G6X9TUZPxJgOOJLMlWbJowesL0ptpuq+2xR
	 zjseYjR5jVNz/gL9WTd6K3oloc/MEukfHdTLoiFbKNUhxilcuQf2dXoJ6ddgY0V4vg
	 UalKfjYtQJhl8ng3EMcWxxGdopXl07z6NObhqapg=
Date: Tue, 21 Nov 2023 10:25:35 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 6/7] media: imx319: Put usage_count correctly in
 s_ctrl callback
Message-ID: <20231121082535.GB8627@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
 <20231118185248.GI20846@pendragon.ideasonboard.com>
 <ZVsnmk2JrCsYNGQT@kekkonen.localdomain>
 <20231120094503.GB6824@pendragon.ideasonboard.com>
 <ZVxn0Em-RmfZP-Pm@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVxn0Em-RmfZP-Pm@kekkonen.localdomain>

On Tue, Nov 21, 2023 at 08:18:24AM +0000, Sakari Ailus wrote:
> Hi Laurent,
> 
> On Mon, Nov 20, 2023 at 11:45:03AM +0200, Laurent Pinchart wrote:
> > On Mon, Nov 20, 2023 at 09:32:10AM +0000, Sakari Ailus wrote:
> > > On Sat, Nov 18, 2023 at 08:52:48PM +0200, Laurent Pinchart wrote:
> > > > On Fri, Nov 17, 2023 at 01:14:32PM +0200, Sakari Ailus wrote:
> > > > > pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
> > > > > the device, in which case it won't increment the use count.
> > > > > pm_runtime_put() does that unconditionally however. Only call
> > > > > pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
> > > > > 0.
> > > > 
> > > > Why don't you use pm_runtime_get_if_active() ?
> > > 
> > > It's only meaningful if the driver uses autosuspend. The imx319 driver does
> > > not.
> > 
> > Does pm_runtime_get_if_active() causes issues with the driver uses
> > autosuspend ? Standardizing on a single API that covers all the use
> > cases would increase consistency and make the code base easier to
> > understand. Beside, the driver should switch to autosuspend :-) Using
> > the correct RPM calls already is a good thing, if they don't introduce
> > any issue.
> 
> Both are fine but they're there for a different purpose. The driver should
> consistently use either usage_count or status based calls (for autosuspend
> to make sense).

But what's the drawback of using pm_runtime_get_if_active() in all cases
(for camera sensor drivers) ? The semantics in the .s_ctrl() handler is
"I want to proceed only if the device is powered on", and that's exactly
what pm_runtime_get_if_active() gives us. The semantics of using
pm_runtime_get_if_in_use() is "I want to proceed if someone else is
holding a reference". It happens to give the same practical result as
pm_runtime_get_if_active() when not using autosuspend, but it's still
not the right semantics.

> > > > Other than that, same comment as for patch 5/7, I don't like the
> > > > increased complexity.
> > > > 
> > > > These comments apply to 7/7 as well.
> > > > 
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  drivers/media/i2c/imx319.c | 8 +++++---
> > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
> > > > > index 5378f607f340..e7b2d0c20d29 100644
> > > > > --- a/drivers/media/i2c/imx319.c
> > > > > +++ b/drivers/media/i2c/imx319.c
> > > > > @@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > >  	struct imx319 *imx319 = container_of(ctrl->handler,
> > > > >  					     struct imx319, ctrl_handler);
> > > > >  	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
> > > > > +	int ret, pm_status;
> > > > >  	s64 max;
> > > > > -	int ret;
> > > > >  
> > > > >  	/* Propagate change of current control to all related controls */
> > > > >  	switch (ctrl->id) {
> > > > > @@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > >  	 * Applying V4L2 control value only happens
> > > > >  	 * when power is up for streaming
> > > > >  	 */
> > > > > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > > > > +	pm_status = pm_runtime_get_if_in_use(&client->dev);
> > > > > +	if (!pm_status)
> > > > >  		return 0;
> > > > >  
> > > > >  	switch (ctrl->id) {
> > > > > @@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > >  		break;
> > > > >  	}
> > > > >  
> > > > > -	pm_runtime_put(&client->dev);
> > > > > +	if (pm_status > 0)
> > > > > +		pm_runtime_put(&client->dev);
> > > > >  
> > > > >  	return ret;
> > > > >  }

-- 
Regards,

Laurent Pinchart

