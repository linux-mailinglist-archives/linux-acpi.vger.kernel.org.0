Return-Path: <linux-acpi+bounces-1606-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534697F1096
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 11:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D2D1C20434
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E0134A5
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rSXpw/o3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068788F;
	Mon, 20 Nov 2023 01:47:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F916250;
	Mon, 20 Nov 2023 10:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700473627;
	bh=4HY3HnVs0loqV+EkJSs7zTflrqHV9ctOB66whBr9lDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSXpw/o3bIquYklfeL163WbjOTKj8wBoP/skbMT1FLs3YvAenoN8+OJ2CGi4fPjEt
	 SEIgbGhbjsxpfhhTAm0Bfs7bCQ+nz7iaTsfED+f4HRTuhw3ibKeltXoh4WvMHMPV/4
	 MXhC5m0bZp/FfAg+xHAE5LR9p1dvpDuV1i+J6H30=
Date: Mon, 20 Nov 2023 11:47:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <20231120094743.GC6824@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
 <20231118213031.GD28790@pendragon.ideasonboard.com>
 <ZVsml5E46uAM-94q@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVsml5E46uAM-94q@kekkonen.localdomain>

Hi Sakari,

On Mon, Nov 20, 2023 at 09:27:51AM +0000, Sakari Ailus wrote:
> On Sat, Nov 18, 2023 at 11:30:31PM +0200, Laurent Pinchart wrote:
> > On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > > > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > > > wish to set the last_busy timestamp to current time and put the
> > > > > usage_count of the device and set the autosuspend timer.
> > > > >
> > > > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > > > calling first pm_runtime_mark_last_busy() and then
> > > > > pm_runtime_put_autosuspend().
> > > >
> > > > The vast majority if the pm_runtime_put_autosuspend() users call
> > > > pm_runtime_mark_last_busy() right before. Let's make the
> > > > pm_runtime_put_autosuspend() function do that by default, and add a
> > > > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > > > of cases where updating the last busy timestamp isn't desired. We want
> > > > to simplify the API, not make it more complex.
> > > 
> > > I would also prefer it to be done this way if not too problematic.
> > 
> > I'm glad you agree :-) The change will probably be a bit painful, but I
> > think it's for the best. Sakari, please let me know if I can help.
> 
> I actually do prefer this approach, too.
> 
> There about 350 drivers using pm_runtime_autosuspend() currently. Around
> 150 uses pm_runtime_autosuspend() which is not preceded by
> pm_runtime_mark_last_busy(). Call-wise the numbers are ~ 1050 and ~ 330.
> 
> I checked some of what's left: most do still call both, but in a way that
> evades Coccinelle matching. Some omissions seem to remain.
> 
> Given that there are way more users that do also call
> pm_runtime_mark_last_busy(), I think I'll try to introduce
> __pm_runtime_put_autosuspend() and pm_runtime_put_autosuspend()
> documentation change first and then rename the callers that don't use
> pm_runtime_mark_last_busy().

And also drop pm_runtime_mark_last_busy() from the drivers that call
pm_runtime_put_autosuspend(), right ?

This sounds good to me. Thank you for working on this. Two RPM API
simplifications in a week, it feels like Christmas is coming :-)

-- 
Regards,

Laurent Pinchart

