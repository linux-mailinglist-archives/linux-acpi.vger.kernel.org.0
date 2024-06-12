Return-Path: <linux-acpi+bounces-6339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD996905B06
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785A12821E5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4184CB5B;
	Wed, 12 Jun 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCzru+PM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F84597A;
	Wed, 12 Jun 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217208; cv=none; b=p59yQh4TZexYO9oZKw9hELZgpCKrH2UxP6a/Dcfkl3Wx2zu444/HvPlTwgZQN17OSJLALl/rkx3+SJMS8tf/AtvGgcRhPIG4r5QGYfwL9sRkM1EpH7gb1cbW5YQDbYyeqy1pbYUEIOIvs9GNA5G1KBY47HaHVn+474nrcCYwUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217208; c=relaxed/simple;
	bh=3chq8aGAuNSKagtHO9pYuCTMVP7l20YtXhwbbVv0/gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVMwycmI5x+siqK+wWHmlksi6DPpbA6oY49/0bRGlKVI/RUtYK255QxQC18sPZwC1+3UG/TZOKbG33DMzsjNazEkqxQL4wT23yTxSljYEOdn2csdLA4DXx05MMBMm25fl619WMOISRuIb8sqSUYU1+VrNINeC/FG/KPRkZUrBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCzru+PM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718217207; x=1749753207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3chq8aGAuNSKagtHO9pYuCTMVP7l20YtXhwbbVv0/gg=;
  b=ZCzru+PM1DKbDnL5qAs7z7kTlFub5V2FwmnFAH4T84Ol95C0bdpTl6HC
   itzu8+a+iB2XkZT9I8ghCXh65HLoBuwxCIqo0wOS/v+x63NtmnWB4dW0y
   Je092v7C2wHkluV8mhgw9MmXqJ40oEEmuXOA6e0Ki/8+kCywJvL4KY1rQ
   O7TNKNrzgVYuBmhqf0PPw8686F2AqyH9HlJX0/l91NVTJI1pAVEIK6rBz
   0r34U00SaUn0r+GRjJZCy+n72D+r+j4L3Zv8anaJleA16mf4KvRxADQvH
   vGKNh0ywsaHZFwoHdd0VARAnypIYLpXFYYMVvH+ol8fHJ0+ToeYsg5BiZ
   w==;
X-CSE-ConnectionGUID: zxyeR/zJRYetvrC+Zm8Haw==
X-CSE-MsgGUID: WCnow9OEQOKuGVKPcRhSKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18858296"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18858296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:33:26 -0700
X-CSE-ConnectionGUID: D8O8/xUdTBKzElSgYmAnyA==
X-CSE-MsgGUID: 3g51+lagSs6J3ayfXpGkkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39768352"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:33:23 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E2B6D11FA94;
	Wed, 12 Jun 2024 21:33:20 +0300 (EEST)
Date: Wed, 12 Jun 2024 18:33:20 +0000
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
Message-ID: <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain>
References: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
 <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 05:26:46PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 4:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > Hi Sakari,
> > >
> > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > >>>>>>> I just hit the same problem on another Dell laptop. It seems that
> > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > >>>>>>> and Raptor Lake generations suffer from this problem.
> > >>>>>>>
> > >>>>>>> So instead of playing whack a mole with DMI matches we should
> > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> > >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> > >>>>>>> the DMI matching now.
> > >>>>>>
> > >>>>>> DisCo for Imaging support shouldn't be dropped on these systems, and this
> > >>>>>> isn't what your patch does either. Instead the ACPI graph port nodes (as
> > >>>>>> per Linux specific definitions) are simply dropped, i.e. this isn't related
> > >>>>>> to DisCo for Imaging at all.
> > >>>>>
> > >>>>> So it looks like the changelog of that patch could be improved, right?
> > >>>>
> > >>>> Well, yes. The reason the function is in the file is that nearly all camera
> > >>>> related parsing is located there, not that it would be related to DisCo for
> > >>>> Imaging as such.
> > >>>
> > >>> So IIUC the camera graph port nodes are created by default with the
> > >>> help of the firmware-supplied information, but if that is defective a
> > >>> quirk can be added to skip the creation of those ports in which case
> > >>> they will be created elsewhere.
> > >>>
> > >>> Is this correct?
> > >>
> > >> Yes.
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
> > That is a good question. The ACPI MIPI DISCO specification is an
> > attempt standardize how MIPI cameras and their sensors are described
> > in ACPI.
> >
> > But this is not actually being used by any Windows drivers atm. The windows
> > drivers rely on their own custom ACPI data which gets translated into
> > standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge.c
> >
> > and so far AFAIK there are 0 laptops where there actually is 100% functional
> > ACPI MIPI information. I believe that some work is in place to get correct
> > usable ACPI MIPI information in place in the ACPI tables of some Meteor Lake
> > laptops. But I believe that there too it does not work yet with the BIOS
> > version with which current Windows models are shipping. It is being fixed
> > for systems which have Linux support from the vendor but I suspect that
> > on other models if ACPI MIPI DISCO information is there it will not
> > necessarily be reliable because AFAICT Windows does not actually use it.
> >
> > And TBH this has me worried about camera support for Meteor Lake devices
> > going forward. We really need to have 1 reliable source of truth here and
> > using information which is ignored by Windows does not seem like the best
> > source to use.
> >
> > Sakari I know you have been pushing for MIPI camera descriptions under
> > ACPI to move to a standardized format and I can see how that is a good
> > thing, but atm it seems to mainly cause things to break and before
> > the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
> > since the information used by the ipu-bridge code does seem to be correct.
> 
> Well, if Windows doesn't use this information, it is almost guaranteed
> to be garbage.

No ACPI DSDT in production systems uses DisCo for Imaging as of now at
least to my knowledge.

> 
> So maybe it would be better to make acpi_graph_ignore_port() return
> true by default and false only when the information is known to be
> valid.  IOW, whitelist things instead of adding blacklist entries in
> perpetuum.

What could be gained from this?

> 
> And hopefully we'll eventually get to the point at which we are able
> to say "whitelist everything from now on".

-- 
Kind regards,

Sakari Ailus

