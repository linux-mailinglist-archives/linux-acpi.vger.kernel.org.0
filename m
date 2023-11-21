Return-Path: <linux-acpi+bounces-1653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E87F2A81
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7952819FC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29371468A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hyo5T/HG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5895BD;
	Tue, 21 Nov 2023 00:50:51 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D038276;
	Tue, 21 Nov 2023 09:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700556620;
	bh=VWsx4ndl8n6hpB0oxZr76PMib8fxm2VHoooiEJBZ358=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hyo5T/HGnSOhEJwPtjlAGjijKYGDbyhBvT6ZH8ttMPsOEGaWRowAxC5m52RaBaN+V
	 SR/xVYa9hp2H56RlFO2K810QQ/MThiAYVqC9GOvlS+/Tk+dCgQ96gA2agejz5yReat
	 bv9dDawZoipGg0t81VI6zWPkTYRKXiLhMZgIWQEs=
Date: Tue, 21 Nov 2023 10:50:56 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <20231121085056.GC8627@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
 <20231118213031.GD28790@pendragon.ideasonboard.com>
 <ZVsml5E46uAM-94q@kekkonen.localdomain>
 <20231120094743.GC6824@pendragon.ideasonboard.com>
 <ZVxtPvS5UdTGPs38@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVxtPvS5UdTGPs38@kekkonen.localdomain>

Hi Sakari,

On Tue, Nov 21, 2023 at 08:41:34AM +0000, Sakari Ailus wrote:
> On Mon, Nov 20, 2023 at 11:47:43AM +0200, Laurent Pinchart wrote:
> > On Mon, Nov 20, 2023 at 09:27:51AM +0000, Sakari Ailus wrote:
> > > On Sat, Nov 18, 2023 at 11:30:31PM +0200, Laurent Pinchart wrote:
> > > > On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> > > > > On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > > > > > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > > > > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > > > > > wish to set the last_busy timestamp to current time and put the
> > > > > > > usage_count of the device and set the autosuspend timer.
> > > > > > >
> > > > > > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > > > > > calling first pm_runtime_mark_last_busy() and then
> > > > > > > pm_runtime_put_autosuspend().
> > > > > >
> > > > > > The vast majority if the pm_runtime_put_autosuspend() users call
> > > > > > pm_runtime_mark_last_busy() right before. Let's make the
> > > > > > pm_runtime_put_autosuspend() function do that by default, and add a
> > > > > > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > > > > > of cases where updating the last busy timestamp isn't desired. We want
> > > > > > to simplify the API, not make it more complex.
> > > > > 
> > > > > I would also prefer it to be done this way if not too problematic.
> > > > 
> > > > I'm glad you agree :-) The change will probably be a bit painful, but I
> > > > think it's for the best. Sakari, please let me know if I can help.
> > > 
> > > I actually do prefer this approach, too.
> > > 
> > > There about 350 drivers using pm_runtime_autosuspend() currently. Around
> > > 150 uses pm_runtime_autosuspend() which is not preceded by
> > > pm_runtime_mark_last_busy(). Call-wise the numbers are ~ 1050 and ~ 330.
> > > 
> > > I checked some of what's left: most do still call both, but in a way that
> > > evades Coccinelle matching. Some omissions seem to remain.
> > > 
> > > Given that there are way more users that do also call
> > > pm_runtime_mark_last_busy(), I think I'll try to introduce
> > > __pm_runtime_put_autosuspend() and pm_runtime_put_autosuspend()
> > > documentation change first and then rename the callers that don't use
> > > pm_runtime_mark_last_busy().
> > 
> > And also drop pm_runtime_mark_last_busy() from the drivers that call
> > pm_runtime_put_autosuspend(), right ?
> 
> That should be done but as it doesn't affect the functionality, it can (and
> may only) be done later on --- the current users need to be converted to
> use the to-be-added __pm_runtime_put_autosuspend() first.

True. If you're going to send a series that change things tree-wide I
was thinking that it would be best to address multiple tree-wide changes
at the same time, that would be less churn, especially if it can be
mostly scripted with Coccinelle. That would be my preference (especially
because the issue will then be solved and we'll be able to move to
something else, instead of leaving old code lingering on for a long
time), but it's up to you.

> > This sounds good to me. Thank you for working on this. Two RPM API
> > simplifications in a week, it feels like Christmas is coming :-)
> 
> Yes. And it's always the case actually! Only the time that it takes
> differs.

-- 
Regards,

Laurent Pinchart

