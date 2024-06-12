Return-Path: <linux-acpi+bounces-6357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EE905CF7
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3567C284984
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB284DF4;
	Wed, 12 Jun 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JtnpjQOV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807684D39;
	Wed, 12 Jun 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224897; cv=none; b=FD+jRkfWN9312zPND5YrFbXo3u+ZCIJ3kQn+EzzhoYLROcV85xxkMWikv1QMDPmi9gHH9a6opesIzQ9IjekrS2TKhXkgbwB+bDue6NJsCU1Fl6ZUHVaDL0e2AlZHfGss5DLv+E6GyGSD6PAs6xB+/By8DKC7y3EZfAXhNsK5Yws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224897; c=relaxed/simple;
	bh=iksz8x0J+16o1rcdeXT1mVm0qNREjzh30WqMubfeTgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRBhXGv/Ni7ESboRFcq42ha4mZnBmqN3mxd+oxCdbNRhwzhHA7xbanAI0d5tlqPC3ynm11fmuV84mY5PIWgyGmTAUotlKZbqwV+opIgShe/c6KEkaNAjCViTV0qZL20ruCIqKn4BHTpYygIpR7Tt8VyZcB27Fqs+HbmsFQGRBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JtnpjQOV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB78A12E4;
	Wed, 12 Jun 2024 22:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718224881;
	bh=iksz8x0J+16o1rcdeXT1mVm0qNREjzh30WqMubfeTgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtnpjQOVy2sLoaifEsK4xCzR24o0w82Tw4QpdFx7X5Z6WDWPm5piRH8BitafAQyoK
	 YeQ0NrkbMmSoltft8qcVxQzpKXUNLvv5Mbturel1XhUKux1YacEWxMJPTQEd1CnXmC
	 qDREB10+CTLfSv+fEt+Vxu9kZbg67c/g0fpCeVgY=
Date: Wed, 12 Jun 2024 23:41:14 +0300
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
Message-ID: <20240612204114.GV28989@pendragon.ideasonboard.com>
References: <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
 <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain>
 <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
 <20240612200012.GP28989@pendragon.ideasonboard.com>
 <CAJZ5v0hF+6_RCyP-Rr+ajNNEKe0YenFR8x6wX3dG1Pq+vguTwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hF+6_RCyP-Rr+ajNNEKe0YenFR8x6wX3dG1Pq+vguTwg@mail.gmail.com>

On Wed, Jun 12, 2024 at 10:31:06PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2024 at 10:00 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2024 at 8:41 PM Sakari Ailus wrote:
> > > > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jun 12, 2024 at 8:21 PM Sakari Ailus wrote:
> > > > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
> > > > > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > > > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > > > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > > > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > > > > > > > the DMI matching now.
> > > > > > > > > > > >
> > > > > > > > > > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > > > > > > > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > > > > > > > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > > > > > > > > > to DisCo for Imaging at all.
> > > > > > > > > > >
> > > > > > > > > > > So it looks like the changelog of that patch could be improved, right?
> > > > > > > > > >
> > > > > > > > > > Well, yes. The reason the function is in the file is that nearly all camera
> > > > > > > > > > related parsing is located there, not that it would be related to DisCo for
> > > > > > > > > > Imaging as such.
> > > > > > > > >
> > > > > > > > > So IIUC the camera graph port nodes are created by default with the
> > > > > > > > > help of the firmware-supplied information, but if that is defective a
> > > > > > > > > quirk can be added to skip the creation of those ports in which case
> > > > > > > > > they will be created elsewhere.
> > > > > > > > >
> > > > > > > > > Is this correct?
> > > > > > > >
> > > > > > > > Yes.
> > > > > > >
> > > > > > > So it would be good to add a comment to this effect to
> > > > > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > > > > called.
> > > > > > >
> > > > > > > And there is a somewhat tangential question that occurred to me: If
> > > > > > > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > > > > > > why is it necessary to consult the platform firmware for the
> > > > > > > information on them at all?  Wouldn't it be better to simply always
> > > > > > > create them elsewhere?
> > > > > >
> > > > > > Simple answer: for the same reason why in general system specific
> > > > > > information comes from ACPI and not from platform data compiled into the
> > > > > > kernel.
> > > > > >
> > > > > > Of course this is technically possible but it does not scale.
> > > > >
> > > > > While I agree in general, in this particular case the platform data
> > > > > compiled into the kernel needs to be present anyway, at least
> > > > > apparently, in case the data coming from the platform firmware is
> > > > > invalid.
> > > > >
> > > > > So we need to do 3 things: compile in the platform data into the
> > > > > kernel and expect the platform firmware to provide the necessary
> > > > > information, and add quirks for the systems where it is known invalid.
> > > > >
> > > > > Isn't this a bit too much?
> > > >
> > > > Isn't this pretty much how ACPI works currently?
> > >
> > > No, we don't need to put platform data into the kernel for every bit
> > > of information that can be retrieved from the platform firmware via
> > > ACPI.
> > >
> > > The vast majority of information in the ACPI tables is actually
> > > correct and if quirks are needed, they usually are limited in scope.
> > >
> > > Where it breaks is when the ACPI tables are not sufficiently validated
> > > by OEMs which mostly happens when the data in question are not needed
> > > to pass some sort of certification or admission tests.
> >
> > We have to be careful here. Part of the job of the ACPI methods for
> > camera objects is to control the camera sensor PMIC and set up the right
> > voltages (many PMICs have programmable output levels). In many cases
> > we've seen with the IPU3, broken ACPI support means the methods will try
> > to do something completely bogus, like accessing a PMIC at an incorrect
> > I2C address. That's mostly fine, it will result in the camera not being
> > detected. We could however have broken ACPI implementation that would
> > program the PMIC to output voltages that would damage the sensor. Users
> > won't be happy.
> 
> My point is basically that if that data were also used by Windows,
> then chances are that breakage of this sort would be caught during
> Windows validation before shipping the machines and so it wouldn't
> affect Linux as well.
> 
> However, if OEMs have no vehicle to validate their systems against,
> bad things can happen indeed.
> 
> Also, if an OEM has no incentive to carry out the requisite checks,
> the result is likely to be invalid data in the platform firmware.

We're exactly on the same page. The only solution [*] I can see for this
problem is to get the Windows drivers to use the same ACPI data as the
Linux drivers.

* Another solution would be for OEMs to stop caring about Windows and
testing their machines with Linux only, essentially reversing the
current situation. Chances of this happening however seem even tinier
:-)

-- 
Regards,

Laurent Pinchart

