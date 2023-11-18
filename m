Return-Path: <linux-acpi+bounces-1594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5E7F0320
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 23:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5581F227E4
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AF0200A4
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P0J/vhfv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CABF1AD;
	Sat, 18 Nov 2023 13:30:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0930BAF2;
	Sat, 18 Nov 2023 22:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700342996;
	bh=/BsQ0rUbz8hyAjQIFNuSXbvhNDzVG+afifIz06rCI/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0J/vhfv1UfUyt7MWCm/fqGJBos1krT2hRPyiBOMyTOqpHHrS6R57DIgChAvVW13T
	 JrEVdHFMnSbPd68fPKRHo/fu+JwdBxZ3v92kiNFuCQ/QEIXQRoIuvuQ/zL3PVRrvn5
	 Xo+ljg2QMGhwZKmoED6DJo9oK7txXdNlsRyVhDPE=
Date: Sat, 18 Nov 2023 23:30:31 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <20231118213031.GD28790@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
 <20231118174903.GF20846@pendragon.ideasonboard.com>
 <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>

Hi Rafael,

On Sat, Nov 18, 2023 at 10:20:46PM +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 18, 2023 at 6:49 PM Laurent Pinchart wrote:
> > On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > > wish to set the last_busy timestamp to current time and put the
> > > usage_count of the device and set the autosuspend timer.
> > >
> > > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > > calling first pm_runtime_mark_last_busy() and then
> > > pm_runtime_put_autosuspend().
> >
> > The vast majority if the pm_runtime_put_autosuspend() users call
> > pm_runtime_mark_last_busy() right before. Let's make the
> > pm_runtime_put_autosuspend() function do that by default, and add a
> > __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> > of cases where updating the last busy timestamp isn't desired. We want
> > to simplify the API, not make it more complex.
> 
> I would also prefer it to be done this way if not too problematic.

I'm glad you agree :-) The change will probably be a bit painful, but I
think it's for the best. Sakari, please let me know if I can help.

-- 
Regards,

Laurent Pinchart

