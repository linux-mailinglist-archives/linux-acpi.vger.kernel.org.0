Return-Path: <linux-acpi+bounces-1654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA527F2A82
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD61D281CDD
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925962D60C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duMtLH8l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD2184;
	Tue, 21 Nov 2023 02:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560819; x=1732096819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gJC13Z8A3YEItyajBlDhtPhLjRfyBkmoP3LffPWAULk=;
  b=duMtLH8lvVw/ZqZMi01knsIFD95q+iKl5MYryitgTPrYLfVtQgKrkN7h
   f8L6F8OGLyN1aKi6A77qHKRyYxaZzXnuWdSdnNjEwiWzyaReH7kaRyWmB
   JteqRstQxyoaSTEaXcGSsti3yAtVZMDZOUfRVDLjSyxywBMZ62f72DaOe
   yNaLYvCMlqewpA4X7oiTENwCCEthVoitXIcRQ2kfHjQWYlm0rEtzDIiwV
   ja3ltwae3wzJdzsBBT4Szs30qwoet8TtNEMuvx5EHn+/mA+8187z85H1C
   Uzzdq81EFR88G7w64M+Co5u9/AYtd7nPRlqxaKMYwh6h7kxihjvmzlMfL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388951697"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="388951697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884151027"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884151027"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:00:17 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E189A11FC2D;
	Tue, 21 Nov 2023 12:00:14 +0200 (EET)
Date: Tue, 21 Nov 2023 10:00:14 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <ZVx_rmzI11r7C_M6@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
 <20231118213031.GD28790@pendragon.ideasonboard.com>
 <ZVsml5E46uAM-94q@kekkonen.localdomain>
 <20231120094743.GC6824@pendragon.ideasonboard.com>
 <ZVxtPvS5UdTGPs38@kekkonen.localdomain>
 <20231121085056.GC8627@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121085056.GC8627@pendragon.ideasonboard.com>

Hi Laurent,

On Tue, Nov 21, 2023 at 10:50:56AM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> On Tue, Nov 21, 2023 at 08:41:34AM +0000, Sakari Ailus wrote:
> > On Mon, Nov 20, 2023 at 11:47:43AM +0200, Laurent Pinchart wrote:
> > > On Mon, Nov 20, 2023 at 09:27:51AM +0000, Sakari Ailus wrote:
> > > > On Sat, Nov 18, 2023 at 11:30:31PM +0200, Laurent Pinchart wrote:
> > > > > On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > > > > > > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > > > > > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > > > > > > wish to set the last_busy timestamp to current time and put the
> > > > > > > > usage_count of the device and set the autosuspend timer.
> > > > > > > >
> > > > > > > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > > > > > > calling first pm_runtime_mark_last_busy() and then
> > > > > > > > pm_runtime_put_autosuspend().
> > > > > > >
> > > > > > > The vast majority if the pm_runtime_put_autosuspend() users call
> > > > > > > pm_runtime_mark_last_busy() right before. Let's make the
> > > > > > > pm_runtime_put_autosuspend() function do that by default, and add a
> > > > > > > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > > > > > > of cases where updating the last busy timestamp isn't desired. We want
> > > > > > > to simplify the API, not make it more complex.
> > > > > > 
> > > > > > I would also prefer it to be done this way if not too problematic.
> > > > > 
> > > > > I'm glad you agree :-) The change will probably be a bit painful, but I
> > > > > think it's for the best. Sakari, please let me know if I can help.
> > > > 
> > > > I actually do prefer this approach, too.
> > > > 
> > > > There about 350 drivers using pm_runtime_autosuspend() currently. Around
> > > > 150 uses pm_runtime_autosuspend() which is not preceded by
> > > > pm_runtime_mark_last_busy(). Call-wise the numbers are ~ 1050 and ~ 330.
> > > > 
> > > > I checked some of what's left: most do still call both, but in a way that
> > > > evades Coccinelle matching. Some omissions seem to remain.
> > > > 
> > > > Given that there are way more users that do also call
> > > > pm_runtime_mark_last_busy(), I think I'll try to introduce
> > > > __pm_runtime_put_autosuspend() and pm_runtime_put_autosuspend()
> > > > documentation change first and then rename the callers that don't use
> > > > pm_runtime_mark_last_busy().
> > > 
> > > And also drop pm_runtime_mark_last_busy() from the drivers that call
> > > pm_runtime_put_autosuspend(), right ?
> > 
> > That should be done but as it doesn't affect the functionality, it can (and
> > may only) be done later on --- the current users need to be converted to
> > use the to-be-added __pm_runtime_put_autosuspend() first.
> 
> True. If you're going to send a series that change things tree-wide I
> was thinking that it would be best to address multiple tree-wide changes
> at the same time, that would be less churn, especially if it can be
> mostly scripted with Coccinelle. That would be my preference (especially
> because the issue will then be solved and we'll be able to move to
> something else, instead of leaving old code lingering on for a long
> time), but it's up to you.

This will mean around 1000 changed lines in 350 files.

Given the number of changes and how they're scattered around, I'd expect
to merge first the Runtime PM API change, then later on the driver specific
changes via their own trees. Doing it differently risks a large number of
conflicts.

Hopefully faster than changing the I²C driver probe function though.

We also need to have some time before all users of
pm_runtime_put_autosuspend() have been converted, including new ones merged
meanwhile.

-- 
Regards,

Sakari Ailus

