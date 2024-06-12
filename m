Return-Path: <linux-acpi+bounces-6346-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4EB905BB7
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9851C238A3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C3824B1;
	Wed, 12 Jun 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgTyb1Pe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64443548F7;
	Wed, 12 Jun 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219491; cv=none; b=B4gp3WC5tz5l1usYh4d6rSkYV9RVTsuy8+4x8i3d+1NwcEHG26P/BShfOmU2Yq6gpS8r0c38Q07ChvPfxVjf91SrZXLIrZhCRHADg0No4usNgGZZvEklaFmAqnjGi4ORLfBUvPEbe8RNk5RVc4oHRP4W2Vaotpn9k15GvdrQJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219491; c=relaxed/simple;
	bh=Ttq4qfXksryXex7mrsiS6uTlf+0jAGHhF9UdYXczJd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZg7FknghYgJoGrkZnW4cvaHpvBQUn2/IK8IuXGpTkE8MsLgGKYS9nZ3dNivHqOhKdl4IYTfNSUul+RpBB/y9Mj3zWo9djg+XeAtgRkOBykfFodjsnlWV37Oi5xx5qiUGWmzls8NpmisA5FeYBnuQ110dmFGb22f011xXt6Z77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgTyb1Pe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718219489; x=1749755489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ttq4qfXksryXex7mrsiS6uTlf+0jAGHhF9UdYXczJd4=;
  b=fgTyb1Pez5XAGVzsBzZvlpcmq3hb4Rw7nbZdx0WkOakccLsBMuVxR1N2
   7iSs88HiAQoT8yZpush3rMk+P/bM3S0t0z31whmqa57vJxQj7w5jxzD9p
   nBK5sQHr/mwVqz6kytknvERE4kNwY/zAktZRW1sa7QydwDq57N4ABOIsZ
   I2PS5eg1KxCUDQxDuDGIAsMRDso4K2zUR0rScWsuGJYCEsMxSPYjkfpsM
   1z+Na75h0E3rcxNloRBTRfvzN5+OavV7kMkY7JcnBIxDQYXH+vUqvQ+No
   8C0K/bc/HtMYGOcfZ9qlmDhA94okey2L/jRTmwDCwspQ0agz8f1IZTAO1
   A==;
X-CSE-ConnectionGUID: 3Tj6Kp8WReGPLwdz/wu5Vw==
X-CSE-MsgGUID: d6MRldsVRUCsoSPwV3lQqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15235058"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15235058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:11:29 -0700
X-CSE-ConnectionGUID: oVc/Qmi/QayPjc20VmoTxg==
X-CSE-MsgGUID: kCm7DKKHSaWJwI4uvU0nmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44829375"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:11:26 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DDECD11FA94;
	Wed, 12 Jun 2024 22:11:23 +0300 (EEST)
Date: Wed, 12 Jun 2024 19:11:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Genes Lists <lists@sapience.com>,
	linux-kernel@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
	wentong.wu@intel.com, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <Zmny2zKoXvKN9TxF@kekkonen.localdomain>
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

Hi Rafael,

On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Wed, Jun 12, 2024 at 8:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > > Hi Sakari,
> > >
> > > On Wed, Jun 12, 2024 at 8:21 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > > > Hi Sakari,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
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
> 
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

If you add a whitelist for systems where the port aren't just dropped, that
is bound to break camera on a lot of current systems that depend on the
said port nodes.

> 
> > >
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

I don't disagree with that as such but it's not really the matter here, is
it?

Historically, some systems were amended with special "Linux support" which
I believe is what these Dell systems have. That was done because the IPU
bridge driver did not exist yet. I frankly don't think it was ever tested
on Linux either.

-- 
Kind regards,

Sakari Ailus

