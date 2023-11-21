Return-Path: <linux-acpi+bounces-1651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A47F2A7F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D2228209D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103323D3AB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXtc+kl7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58F100;
	Tue, 21 Nov 2023 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556098; x=1732092098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5YBhqvW6IPqtnwEfVk2Z+fjkpgFwIvXy5agQXJ9f0Ss=;
  b=QXtc+kl7eLovkjuYT3PfgbhAD44Cr+moKvpJhaMQ5svdu8Eo1thwozu2
   3DKV6OXe8lwE+8eRpj2E14WFEJN83l/ONMy8Sw5QZLxD3H3SrjsZ53DOt
   CeajKc+JkoMxWmY8LGV9WHIsyPEs7pCKjC+yZPS/bFD/Q4iVS3My65Sdq
   wnbjCxGxdppjM5VRQPdrMQI9MenE58lJxTwPb+S3Jlupd3b2JdnLtZGfB
   C2c4U51P6fM3w/OYM5ikkcaZ/7HC/8PI3Ylci10GK1ZKTZsSkfWJ9tEgr
   MniV8F7hhXSbgyqsGwfKRqgTWL70bCLGkkEIszlD37ugZBcb5QcyF+pUg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391571647"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="391571647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14839258"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:41:37 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B3C8811FC2D;
	Tue, 21 Nov 2023 10:41:34 +0200 (EET)
Date: Tue, 21 Nov 2023 08:41:34 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <ZVxtPvS5UdTGPs38@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
 <20231118213031.GD28790@pendragon.ideasonboard.com>
 <ZVsml5E46uAM-94q@kekkonen.localdomain>
 <20231120094743.GC6824@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120094743.GC6824@pendragon.ideasonboard.com>

Hi Laurent,

On Mon, Nov 20, 2023 at 11:47:43AM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> On Mon, Nov 20, 2023 at 09:27:51AM +0000, Sakari Ailus wrote:
> > On Sat, Nov 18, 2023 at 11:30:31PM +0200, Laurent Pinchart wrote:
> > > On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> > > > On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > > > > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > > > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > > > > wish to set the last_busy timestamp to current time and put the
> > > > > > usage_count of the device and set the autosuspend timer.
> > > > > >
> > > > > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > > > > calling first pm_runtime_mark_last_busy() and then
> > > > > > pm_runtime_put_autosuspend().
> > > > >
> > > > > The vast majority if the pm_runtime_put_autosuspend() users call
> > > > > pm_runtime_mark_last_busy() right before. Let's make the
> > > > > pm_runtime_put_autosuspend() function do that by default, and add a
> > > > > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > > > > of cases where updating the last busy timestamp isn't desired. We want
> > > > > to simplify the API, not make it more complex.
> > > > 
> > > > I would also prefer it to be done this way if not too problematic.
> > > 
> > > I'm glad you agree :-) The change will probably be a bit painful, but I
> > > think it's for the best. Sakari, please let me know if I can help.
> > 
> > I actually do prefer this approach, too.
> > 
> > There about 350 drivers using pm_runtime_autosuspend() currently. Around
> > 150 uses pm_runtime_autosuspend() which is not preceded by
> > pm_runtime_mark_last_busy(). Call-wise the numbers are ~ 1050 and ~ 330.
> > 
> > I checked some of what's left: most do still call both, but in a way that
> > evades Coccinelle matching. Some omissions seem to remain.
> > 
> > Given that there are way more users that do also call
> > pm_runtime_mark_last_busy(), I think I'll try to introduce
> > __pm_runtime_put_autosuspend() and pm_runtime_put_autosuspend()
> > documentation change first and then rename the callers that don't use
> > pm_runtime_mark_last_busy().
> 
> And also drop pm_runtime_mark_last_busy() from the drivers that call
> pm_runtime_put_autosuspend(), right ?

That should be done but as it doesn't affect the functionality, it can (and
may only) be done later on --- the current users need to be converted to
use the to-be-added __pm_runtime_put_autosuspend() first.

> 
> This sounds good to me. Thank you for working on this. Two RPM API
> simplifications in a week, it feels like Christmas is coming :-)

Yes. And it's always the case actually! Only the time that it takes
differs.

-- 
Regards,

Sakari Ailus

