Return-Path: <linux-acpi+bounces-6340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE3905B3A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3841F21396
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B14AEF5;
	Wed, 12 Jun 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0Wu1Wyg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005C47F4B;
	Wed, 12 Jun 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217660; cv=none; b=COMbnZZeux00a1whm85+GN2U6VDad1qxBKCHIBv/0Nj6Zm5H1nRsLhAtLFBMp6q8Gz2cqVRgpu+ZaO+jA/8efvKwP1Ce5hqIK7cQYj8P2cHXqzNfNP9JrYvZvTL3d+sYzqNmPkHBF9L1UOQ3rkDH9mu75SFrmwb89FHvfFYF/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217660; c=relaxed/simple;
	bh=XAl+xt3Ajhmcb21HlyPPHcVsPGjc8S1/jBgQhVYVmEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewI4a9ldahI18XWBP6L/bB+AHkySxEOHo3WS+0Lo/CNo7jUngd2hiGRyDq7zdD0vulFNw65cpmk4qscBuFBcuFOQ1vGfDEr/AkzG4l0ZAn9blddTBT72Q1r1wP9CgEzdpp+zHOJaJ5U+6j04P2MQ5tN/Jclv1VgLi0FEm3KU9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0Wu1Wyg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718217658; x=1749753658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XAl+xt3Ajhmcb21HlyPPHcVsPGjc8S1/jBgQhVYVmEU=;
  b=G0Wu1Wyg3wj7pZqyxMsue6vTaOvIgK3+fnLvQccJ3ualaiaaakiTIW23
   wQiZiN4KMt+2wyoOdAc2cwudap+wpKqmE0fnTuCAIFh7a5f0gC8ELHT3H
   2BzPER3f8xfgSNrjP8IwYvnSGP3LFtZQCR/zEjma9vRAlR7ZqwR5guEe8
   PYtkcwJfyjsQ8uqrXVE1lXDfXh7DZAIkj+RxXLP6cRcFzlWgpM3+oobRl
   JzxoVKPoS+hS407bgPw8WC45tcg+H18ZY4Y4uGDqXNY4Z+IWo4hLDBBSL
   l5jl5NtBa9JL3bVZMEQ4mz+dZe2ASiH395cb0OvAqnzSdS3p0CxG5Lmu3
   w==;
X-CSE-ConnectionGUID: rnwNqCsmQCeBXv39BLg4Lw==
X-CSE-MsgGUID: c9mb7vc0QsCiJzSHj/ADgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25634816"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25634816"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:40:57 -0700
X-CSE-ConnectionGUID: sx2zuM+FThuWBS97fQNFKw==
X-CSE-MsgGUID: vXAup4MLQlmh7pn/xxsj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44271382"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:40:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8C3FA11FA94;
	Wed, 12 Jun 2024 21:40:52 +0300 (EEST)
Date: Wed, 12 Jun 2024 18:40:52 +0000
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
Message-ID: <ZmnrtIEla9R24egi@kekkonen.localdomain>
References: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
 <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Wed, Jun 12, 2024 at 8:21 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > Hi Sakari,
> > >
> > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > > >
> > > > > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > > > the DMI matching now.
> > > > > > > >
> > > > > > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > > > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > > > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > > > > > to DisCo for Imaging at all.
> > > > > > >
> > > > > > > So it looks like the changelog of that patch could be improved, right?
> > > > > >
> > > > > > Well, yes. The reason the function is in the file is that nearly all camera
> > > > > > related parsing is located there, not that it would be related to DisCo for
> > > > > > Imaging as such.
> > > > >
> > > > > So IIUC the camera graph port nodes are created by default with the
> > > > > help of the firmware-supplied information, but if that is defective a
> > > > > quirk can be added to skip the creation of those ports in which case
> > > > > they will be created elsewhere.
> > > > >
> > > > > Is this correct?
> > > >
> > > > Yes.
> > >
> > > So it would be good to add a comment to this effect to
> > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > called.
> > >
> > > And there is a somewhat tangential question that occurred to me: If
> > > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > > why is it necessary to consult the platform firmware for the
> > > information on them at all?  Wouldn't it be better to simply always
> > > create them elsewhere?
> >
> > Simple answer: for the same reason why in general system specific
> > information comes from ACPI and not from platform data compiled into the
> > kernel.
> >
> > Of course this is technically possible but it does not scale.
> 
> While I agree in general, in this particular case the platform data
> compiled into the kernel needs to be present anyway, at least
> apparently, in case the data coming from the platform firmware is
> invalid.
> 
> So we need to do 3 things: compile in the platform data into the
> kernel and expect the platform firmware to provide the necessary
> information, and add quirks for the systems where it is known invalid.
> 
> Isn't this a bit too much?

Isn't this pretty much how ACPI works currently?

We can support systems that contain correct DSDT description of cameras
without platform data. I was, until recently, only aware of Dell XPS 9315
that has incorrect camera description and that based on recent findings
seems to extend to other Dell systems with IPU6 (Hans's patches have the
details).

Still this is not a reason to break systems that have correct camera
description and expect the users to report them so they can be listed as
such.

> 
> > On laptops shipped with Windows some additional information is also available
> > from ACPI via custom objects but a lot of information is just hard coded into
> > the IPU bridge as well as the INT3472 driver.
> 
> Well, that's how it goes.

Yes, but is it desirable?

-- 
Kind regards,

Sakari Ailus

