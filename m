Return-Path: <linux-acpi+bounces-1601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C37F108D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E31F23620
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9267134BD
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6lYaxkU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCC85;
	Mon, 20 Nov 2023 01:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700472476; x=1732008476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d/Z18ET+KUkKb8I+OqyUPt+RntdNvMUKjhfW949ZQ9k=;
  b=G6lYaxkUxpU9CPqFUEn8cF9AdaiwqXSkgKgg5YhfjA33JtMCbu91Zas6
   KJGuMjwUU8bXPh99GjWnNSMeSQ2nj3BlvI+N8dEaPPHu5hhZ8CJu30w+V
   KrLE9QMwi1dBzEXALeMk9KDtvugWmcRRuMCrHxHn8VVGM5HM/uuVFqW4Y
   rViqO6NVjS1n3idljLZtS2KvVVJXhh+9gevd4Gu3JIGYA7a0pP+S2lyI0
   DY3cATIaB3Z6fFmGiqhiZ+ETGu8xlJVt01IFsqzy2xt0OneYJzKGMhh0H
   66Cah5bWmgqqPRG56wqJ3T55hwCUhIf+Le+fn394yvUtmCK4j0+LhjIeG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4701352"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4701352"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:27:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="883805408"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="883805408"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:27:53 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 52EEC11FBD1;
	Mon, 20 Nov 2023 11:27:51 +0200 (EET)
Date: Mon, 20 Nov 2023 09:27:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <ZVsml5E46uAM-94q@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
 <20231118213031.GD28790@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118213031.GD28790@pendragon.ideasonboard.com>

Hi Laurent,

On Sat, Nov 18, 2023 at 11:30:31PM +0200, Laurent Pinchart wrote:
> Hi Rafael,
> 
> On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > > wish to set the last_busy timestamp to current time and put the
> > > > usage_count of the device and set the autosuspend timer.
> > > >
> > > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > > calling first pm_runtime_mark_last_busy() and then
> > > > pm_runtime_put_autosuspend().
> > >
> > > The vast majority if the pm_runtime_put_autosuspend() users call
> > > pm_runtime_mark_last_busy() right before. Let's make the
> > > pm_runtime_put_autosuspend() function do that by default, and add a
> > > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > > of cases where updating the last busy timestamp isn't desired. We want
> > > to simplify the API, not make it more complex.
> > 
> > I would also prefer it to be done this way if not too problematic.
> 
> I'm glad you agree :-) The change will probably be a bit painful, but I
> think it's for the best. Sakari, please let me know if I can help.

I actually do prefer this approach, too.

There about 350 drivers using pm_runtime_autosuspend() currently. Around
150 uses pm_runtime_autosuspend() which is not preceded by
pm_runtime_mark_last_busy(). Call-wise the numbers are ~ 1050 and ~ 330.

I checked some of what's left: most do still call both, but in a way that
evades Coccinelle matching. Some omissions seem to remain.

Given that there are way more users that do also call
pm_runtime_mark_last_busy(), I think I'll try to introduce
__pm_runtime_put_autosuspend() and pm_runtime_put_autosuspend()
documentation change first and then rename the callers that don't use
pm_runtime_mark_last_busy().

-- 
Regards,

Sakari Ailus

