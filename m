Return-Path: <linux-acpi+bounces-6353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B788905C75
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484A81C231A2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62983CDB;
	Wed, 12 Jun 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="A/IzcKWF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492783CD3;
	Wed, 12 Jun 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222514; cv=none; b=j718ycDI+oKYB91ahcOVXpc+Gn7BUjulkrxirbiVEkSY/NdfZ0Fpia7Exo4DozzTF49tlbKqqSRsGZPGzC08q+P++s6dcgp5SsYor3eVRUE/LkNkA9O1brhqlsql+72p7jzWNg7QOSg+fg2fsnsCTVXIptpewCuGPEDvBg6zVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222514; c=relaxed/simple;
	bh=89+kjFXh2oXPASs1slgl/MaJkh7Lr0/NggJNDrEMkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlhl17VzgPn0leIihajIVoUNNur7YOyw2PdsH3VGteoMW/kRnx/eVPytOstuL9HGqYOdSS/0Zq/bdMUFVzVEtrH+N2oLIcwfWEwfiH2SX7gunED29LjnFnPQ9dMCLkpUQ42Uz7eN6cb+6i1+9GY+Az1vUAlS0fjcP2Z8xrN3TrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=A/IzcKWF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B229EA2;
	Wed, 12 Jun 2024 22:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718222497;
	bh=89+kjFXh2oXPASs1slgl/MaJkh7Lr0/NggJNDrEMkUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/IzcKWFHJj11PB0fcB3oL//inBtScfZWq3Zub8NXLpC3h1wkVAriilaYrY+rMJNv
	 Z3VXWyI/N+u1rANoAxUkKVh/nuHZRPQpKoScQSJ3BgjKgjhdz1lNpdIs/0csnnkUoK
	 4ehxSct92dMx3QShO1hHstJo/honcqmGtcm8WJlE=
Date: Wed, 12 Jun 2024 23:01:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <20240612200131.GQ28989@pendragon.ideasonboard.com>
References: <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
 <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmnrtIEla9R24egi@kekkonen.localdomain>

On Wed, Jun 12, 2024 at 06:40:52PM +0000, Sakari Ailus wrote:
> On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 8:21 PM Sakari Ailus wrote:
> > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
> > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > > > >
> > > > > > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > > > > the DMI matching now.
> > > > > > > > >
> > > > > > > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > > > > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > > > > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > > > > > > to DisCo for Imaging at all.
> > > > > > > >
> > > > > > > > So it looks like the changelog of that patch could be improved, right?
> > > > > > >
> > > > > > > Well, yes. The reason the function is in the file is that nearly all camera
> > > > > > > related parsing is located there, not that it would be related to DisCo for
> > > > > > > Imaging as such.
> > > > > >
> > > > > > So IIUC the camera graph port nodes are created by default with the
> > > > > > help of the firmware-supplied information, but if that is defective a
> > > > > > quirk can be added to skip the creation of those ports in which case
> > > > > > they will be created elsewhere.
> > > > > >
> > > > > > Is this correct?
> > > > >
> > > > > Yes.
> > > >
> > > > So it would be good to add a comment to this effect to
> > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > called.
> > > >
> > > > And there is a somewhat tangential question that occurred to me: If
> > > > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > > > why is it necessary to consult the platform firmware for the
> > > > information on them at all?  Wouldn't it be better to simply always
> > > > create them elsewhere?
> > >
> > > Simple answer: for the same reason why in general system specific
> > > information comes from ACPI and not from platform data compiled into the
> > > kernel.
> > >
> > > Of course this is technically possible but it does not scale.
> > 
> > While I agree in general, in this particular case the platform data
> > compiled into the kernel needs to be present anyway, at least
> > apparently, in case the data coming from the platform firmware is
> > invalid.
> > 
> > So we need to do 3 things: compile in the platform data into the
> > kernel and expect the platform firmware to provide the necessary
> > information, and add quirks for the systems where it is known invalid.
> > 
> > Isn't this a bit too much?
> 
> Isn't this pretty much how ACPI works currently?
> 
> We can support systems that contain correct DSDT description of cameras
> without platform data. I was, until recently, only aware of Dell XPS 9315
> that has incorrect camera description and that based on recent findings
> seems to extend to other Dell systems with IPU6 (Hans's patches have the
> details).

Are you aware of any IPU6-based devices, apart from chromebooks, that
have correct ACPI tables for the camera ?

> Still this is not a reason to break systems that have correct camera
> description and expect the users to report them so they can be listed as
> such.
> 
> > > On laptops shipped with Windows some additional information is also available
> > > from ACPI via custom objects but a lot of information is just hard coded into
> > > the IPU bridge as well as the INT3472 driver.
> > 
> > Well, that's how it goes.
> 
> Yes, but is it desirable?

-- 
Regards,

Laurent Pinchart

