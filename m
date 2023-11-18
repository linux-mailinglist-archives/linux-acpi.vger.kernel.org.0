Return-Path: <linux-acpi+bounces-1586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BF7EFF81
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DAD1F22D80
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7211C8A
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk/3uO/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3731A1;
	Sat, 18 Nov 2023 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700305966; x=1731841966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dv9bsZf1pssRWPb2EsvH9OVnT85g/k9+I9cm9iqmQzA=;
  b=Fk/3uO/lrnQjqLXGoEaAG7yoqCpqh3T6ooyU3C1k82tBLIUVv6HF0Xvg
   TrRFCuIeg9MxQeaV+ysGSoHWVDUYrCB7r/PEDL3czThXr8Hx/Oh1mIiaW
   tCeOPrcIslLLm1Km2PEnRRbqKsH1q1pQpO/2nQhbsnylIN3K6ohDB+28j
   VP5e31YX8MiVIU5v1GvVBSQhzzzS2P/1KB8dY7BYCO1wtPMOIReaqGz+1
   z4+guZx+G88WjN31iztMlKYlXtLeXoYArQGEl/nEXVEZu2z255BYeWLQc
   k/msAxts3FXcAxFrj1Cu+5ufS3hp2NkU8HU9BEjvAQatB7rRzHKq6SnFc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="376467785"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="376467785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 03:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="909652856"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="909652856"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 03:12:44 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 976A511FC2D;
	Sat, 18 Nov 2023 13:12:41 +0200 (EET)
Date: Sat, 18 Nov 2023 11:12:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v2 5/7] media: ov8858: Use pm_runtime_get_if_active(),
 put usage_count correctly
Message-ID: <ZVicKX8kw94TuOxA@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-6-sakari.ailus@linux.intel.com>
 <ledwhthyoc6h5ccmwdvyl7cqrp3kdwijcpkzxpp4jvemd6iz2a@na2elf7674a5>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ledwhthyoc6h5ccmwdvyl7cqrp3kdwijcpkzxpp4jvemd6iz2a@na2elf7674a5>

Hi Jacopo,

On Fri, Nov 17, 2023 at 04:30:15PM +0100, Jacopo Mondi wrote:
> Hi Sakari
> 
> On Fri, Nov 17, 2023 at 01:14:31PM +0200, Sakari Ailus wrote:
> > Use pm_runtime_get_if_active() to get the device's runtime PM usage_count
> > and set controls, then use runtime PM autosuspend once the controls have
> > been set (instead of likely transitioning to suspended state immediately).
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/i2c/ov8858.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
> > index 3af6125a2eee..a99b91700a8d 100644
> > --- a/drivers/media/i2c/ov8858.c
> > +++ b/drivers/media/i2c/ov8858.c
> > @@ -1538,7 +1538,7 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> >  	struct v4l2_subdev_state *state;
> >  	u16 digi_gain;
> >  	s64 max_exp;
> > -	int ret;
> > +	int ret, pm_status;
> >
> >  	/*
> >  	 * The control handler and the subdev state use the same mutex and the
> > @@ -1561,7 +1561,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> >  		break;
> >  	}
> >
> > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > +	pm_status = pm_runtime_get_if_active(&client->dev);
> > +	if (!pm_status)
> >  		return 0;
> >
> >  	switch (ctrl->id) {
> > @@ -1601,7 +1602,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
> >  		break;
> >  	}
> >
> > -	pm_runtime_put(&client->dev);
> > +	if (pm_status > 0)
> 
> I'm not 100% sure I get this bit.
> 
> If we get here it means pm_status is either -EINVAL or > 0, otherwise
> we would have exited earlier.
> 
> What's the point of checking for > 0 here ?
> 
> There are two cases where pm_status is -EINVAL, either !CONFIG_PM and
> the the below call is a nop, or if pm_runtime has not been enabled by
> the driver, which means the driver doesn't use pm_runtime at all.
> 
> Are there other cases I have missed that require checking here for
> pm_status > 0 ?

Other than Runtime PM being disabled, I don't think that should happen.

So as such this patch does not fix a bug. I just prefer to be extra
cautious when it comes to use counts.

> 
> > +		pm_runtime_mark_busy_autosusp(&client->dev);
> >
> >  	return ret;
> >  }

-- 
Regards,

Sakari Ailus

