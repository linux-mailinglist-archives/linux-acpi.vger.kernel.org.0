Return-Path: <linux-acpi+bounces-6351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EB905C6D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E95B21024
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315454BD8;
	Wed, 12 Jun 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MRYSh+uT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E68282F7;
	Wed, 12 Jun 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222437; cv=none; b=l3ftX4kx1rTHqFcU3b7k6fZcrJFcDJj7y6ZC6v0IZrxnwq4dwkQP2N+4v+h25RPIkjQwayC6+BhOSQOFQG8dgMAP/FYmer02lUixXz43RuRB1JPWUufhu27K/mn7ssv1uFfLG7VPx3sdNXUkiD+culzUMZJLIaA9x6dID3Mj2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222437; c=relaxed/simple;
	bh=r6UKj1YTs/BxhHFO//uwGY1rsOihH/uBihwuOdyGH/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkvLEVweytqON9xiERJ+eVR6waMKICFOWmeuUVDN2FTDa9f5IOjUOACttXJjvGAujmLeNWB3SP3Kxzo8Dtf8prbA95sxSyOlza1yJ8FyPwFy7jkgLIbc8JZdyfCkoT2d7cnk3JaLGdZW1IasI9C4HihaZzH23ekp25U41BHT3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MRYSh+uT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54309230;
	Wed, 12 Jun 2024 22:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718222420;
	bh=r6UKj1YTs/BxhHFO//uwGY1rsOihH/uBihwuOdyGH/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRYSh+uT1ng2i6Y82++s/bC6+d+Zssg77Js1G8bZ90OxtbAVOPfWyNfmpVy8M5gIM
	 Bj72uuvAXPqavtwGwzUOMfaU9yIJDhLQUSCmbvSKlMH90fnKjUtqJK0l8FxB0iboAn
	 L+cqt8YeAHmjFguN1Kpx1O8+tfBZL8yi5YTr1c24=
Date: Wed, 12 Jun 2024 23:00:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <20240612200012.GP28989@pendragon.ideasonboard.com>
References: <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
 <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain>
 <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>

On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2024 at 8:41 PM Sakari Ailus wrote:
> > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2024 at 8:21 PM Sakari Ailus wrote:
> > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
> > > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > > > > >
> > > > > > > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > > > > > the DMI matching now.
> > > > > > > > > >
> > > > > > > > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > > > > > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > > > > > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > > > > > > > to DisCo for Imaging at all.
> > > > > > > > >
> > > > > > > > > So it looks like the changelog of that patch could be improved, right?
> > > > > > > >
> > > > > > > > Well, yes. The reason the function is in the file is that nearly all camera
> > > > > > > > related parsing is located there, not that it would be related to DisCo for
> > > > > > > > Imaging as such.
> > > > > > >
> > > > > > > So IIUC the camera graph port nodes are created by default with the
> > > > > > > help of the firmware-supplied information, but if that is defective a
> > > > > > > quirk can be added to skip the creation of those ports in which case
> > > > > > > they will be created elsewhere.
> > > > > > >
> > > > > > > Is this correct?
> > > > > >
> > > > > > Yes.
> > > > >
> > > > > So it would be good to add a comment to this effect to
> > > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > > called.
> > > > >
> > > > > And there is a somewhat tangential question that occurred to me: If
> > > > > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > > > > why is it necessary to consult the platform firmware for the
> > > > > information on them at all?  Wouldn't it be better to simply always
> > > > > create them elsewhere?
> > > >
> > > > Simple answer: for the same reason why in general system specific
> > > > information comes from ACPI and not from platform data compiled into the
> > > > kernel.
> > > >
> > > > Of course this is technically possible but it does not scale.
> > >
> > > While I agree in general, in this particular case the platform data
> > > compiled into the kernel needs to be present anyway, at least
> > > apparently, in case the data coming from the platform firmware is
> > > invalid.
> > >
> > > So we need to do 3 things: compile in the platform data into the
> > > kernel and expect the platform firmware to provide the necessary
> > > information, and add quirks for the systems where it is known invalid.
> > >
> > > Isn't this a bit too much?
> >
> > Isn't this pretty much how ACPI works currently?
> 
> No, we don't need to put platform data into the kernel for every bit
> of information that can be retrieved from the platform firmware via
> ACPI.
> 
> The vast majority of information in the ACPI tables is actually
> correct and if quirks are needed, they usually are limited in scope.
> 
> Where it breaks is when the ACPI tables are not sufficiently validated
> by OEMs which mostly happens when the data in question are not needed
> to pass some sort of certification or admission tests.

We have to be careful here. Part of the job of the ACPI methods for
camera objects is to control the camera sensor PMIC and set up the right
voltages (many PMICs have programmable output levels). In many cases
we've seen with the IPU3, broken ACPI support means the methods will try
to do something completely bogus, like accessing a PMIC at an incorrect
I2C address. That's mostly fine, it will result in the camera not being
detected. We could however have broken ACPI implementation that would
program the PMIC to output voltages that would damage the sensor. Users
won't be happy.

And now that I wrote that, maybe that's what we should hope for, a major
recall of machines from Dell or Lenovo, whose financial cost would give
an incentive to fixing this mess in the future... *sigh*

> Which unfortunately is related to whether or not Windows uses those data.
> 
> > We can support systems that contain correct DSDT description of cameras
> > without platform data. I was, until recently, only aware of Dell XPS 9315
> > that has incorrect camera description and that based on recent findings
> > seems to extend to other Dell systems with IPU6 (Hans's patches have the
> > details).
> >
> > Still this is not a reason to break systems that have correct camera
> > description and expect the users to report them so they can be listed as
> > such.
> 
> Well, what do you mean by "break".  I thought that platform data
> needed to support them were built into the kernel, weren't they?
> 
> > > > On laptops shipped with Windows some additional information is also available
> > > > from ACPI via custom objects but a lot of information is just hard coded into
> > > > the IPU bridge as well as the INT3472 driver.
> > >
> > > Well, that's how it goes.
> >
> > Yes, but is it desirable?
> 
> No, it is not desirable, but the way to address it is to convince the
> Windows people to stop doing this and use standard-defined data from
> the ACPI tables instead.  It cannot be addressed by Linux unilaterally
> trying to do the right thing, because there are OEMs who don't care
> about Linux.

-- 
Regards,

Laurent Pinchart

