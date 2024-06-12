Return-Path: <linux-acpi+bounces-6336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A41905AAF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D508B2344A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A039FE5;
	Wed, 12 Jun 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTeizW+V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44B381C4;
	Wed, 12 Jun 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216478; cv=none; b=V3Vqs8M9B+M3D0A2nl8aNC2BuyQLPfj7NyffQzPzuc4JI3oyWKSiw2WquWWQHtauMaNgvdUWBNrD0PcZ4WGF330HziSQl+0Li+ZnlZ3Zy1ZbMkmkLwW7eAPhKGPey2adKLXEn/ZJpE+uw9jjvxCaugQFA0zRQrtK+qWGon8YoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216478; c=relaxed/simple;
	bh=UQ/0K0tgkEB2g6sr8y0pChy/iFNEa60HIj3E8+6/imk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQPtWAa+Mux3lLiqWzhYYN2hdHF/H3466QhEg2fVYIT1ffYzRhFBqcdtIMZNiQFAWlurK+cqjpV6l4hWnsapFYNwGORPDN9/aMm9P6twxrIsyrt/+cPTZTr0RYr25lwxZmdlbRYQV5ZiJr5kzopkGSEt+f00HZh7gyuXEvsjXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTeizW+V; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718216477; x=1749752477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UQ/0K0tgkEB2g6sr8y0pChy/iFNEa60HIj3E8+6/imk=;
  b=gTeizW+VwcXqwOAG7wix5ysyy6p2SftUgmql4OPAAy2oBtqOsuZNTA5y
   N+ciAYQ2D54Fg59iGJ+5TDldyrRbmM8ZTWLLj3myAQOLg1ZfyOrBIQ06V
   z2wzEKqw6lTDNqOP8tSK0n05/z08xELAFgMbeVBghXdkjmNemw+Gc5huB
   I6RXDj9CRkyn+ZBhJJ3nIvzzsUpCAyAfOILqxWGE0Ec+QCUNS6JNNkDs5
   +xXUQObkXeVt040/jc2GHOxFxi6nxnLHBW2gpbEdE6bBsW/aS7Runx63E
   mSFA1aN5MsUCAqZ6HEsKGoF1MfRUJVUGfvKgo8kauhzYFfjLn2h/KLMul
   A==;
X-CSE-ConnectionGUID: 7FnSa0EkQ4GTb3js9moFQg==
X-CSE-MsgGUID: SIWGNaUCRR2rF0CY3FM2Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14962699"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14962699"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:21:16 -0700
X-CSE-ConnectionGUID: LhFJoJscTlmG4nGPqnjo+g==
X-CSE-MsgGUID: DDhy7ZtYTnCfs4UbcFWAvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44418408"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:21:13 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5736811FA94;
	Wed, 12 Jun 2024 21:21:10 +0300 (EEST)
Date: Wed, 12 Jun 2024 18:21:10 +0000
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
Message-ID: <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
References: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > >
> > > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > the DMI matching now.
> > > > > >
> > > > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > > > to DisCo for Imaging at all.
> > > > >
> > > > > So it looks like the changelog of that patch could be improved, right?
> > > >
> > > > Well, yes. The reason the function is in the file is that nearly all camera
> > > > related parsing is located there, not that it would be related to DisCo for
> > > > Imaging as such.
> > >
> > > So IIUC the camera graph port nodes are created by default with the
> > > help of the firmware-supplied information, but if that is defective a
> > > quirk can be added to skip the creation of those ports in which case
> > > they will be created elsewhere.
> > >
> > > Is this correct?
> >
> > Yes.
> 
> So it would be good to add a comment to this effect to
> acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> called.
> 
> And there is a somewhat tangential question that occurred to me: If
> the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> why is it necessary to consult the platform firmware for the
> information on them at all?  Wouldn't it be better to simply always
> create them elsewhere?

Simple answer: for the same reason why in general system specific
information comes from ACPI and not from platform data compiled into the
kernel.

Of course this is technically possible but it does not scale. On laptops
shipped with Windows some additional information is also available from
ACPI via custom objects but a lot of information is just hard coded into
the IPU bridge as well as the INT3472 driver.

-- 
Kind regards,

Sakari Ailus

