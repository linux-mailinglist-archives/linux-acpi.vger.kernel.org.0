Return-Path: <linux-acpi+bounces-6337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C054A905ACA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D9D1F21BF3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CEE3A1CC;
	Wed, 12 Jun 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPtx9k3g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6251EB2A;
	Wed, 12 Jun 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216706; cv=none; b=mzreR5vfuskMyi+saIM6HKLp08Hg57hENhBvh4nIC3qQ6G/8+5m2xkqMzb8aNuFDv0G5Wp1FQxPCKgbMsWbsSMynlyBUub2WsZqdKcwqZQEgSZxTUfrJPvqN5RujnYfHfB5NU4JNP0MFvc34kpSxGjL9VIZoxDDJ6cyXbdoT3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216706; c=relaxed/simple;
	bh=ZA5vx2/Eess46EaN+jWAdvt4nm7yn6vBuHlgmTShaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptV185yKSgK8zmyHoyMxZXcyDKi5AAO1Ss7k6HhdDCsMXJA4WirynBRqb5978RahINMi747qdYHxMMMN3EJxnCmn5Su1KUsUeBRMn7XBnLib81rfO5zMniO8DslT9/DA0Yh7JvBYqjYvxMDqCbR6RbOInwnBdcOfYQxccThyUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPtx9k3g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718216705; x=1749752705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZA5vx2/Eess46EaN+jWAdvt4nm7yn6vBuHlgmTShaXA=;
  b=cPtx9k3gdfj5fl867+ncDWjnd47n0PEuFznmoWVJNFwpH5ehJXElsA3U
   fkFr5Pi6cLpVGkCzuloqk3wrQwgwGzRnXnHw4htJWfniJUBSmK0Iuc5Cz
   qO1drJHK7+Zhn0B4ObeC09UFXa1noxJhGROtqYZhIJlbE4za+dZEOa6Pe
   00GZmG2mmLFZm8T0hBrQg/PZXJEDcTEoTOTDdfZD2rso4ps48HBRyzy7G
   mghEQ2EMXFTW7+DN09pRXGGWrw2YSwJiwcPCYIAJKGnB96EAp5wlLQx62
   ShRDvNq+E5mjnPM136untaWEq2XMXuKZ+G8XTBujNXLlNjwTEP+Kn4+6N
   g==;
X-CSE-ConnectionGUID: dOhDK/2nRnqIN0oUUjOX9Q==
X-CSE-MsgGUID: rAzF3PvsT4uOi1ljH+uURQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15126224"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15126224"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:25:04 -0700
X-CSE-ConnectionGUID: R+l4VIJvTxqKRhDTCcxucw==
X-CSE-MsgGUID: udjPtfrFRTKad3twLqlt1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39740781"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:25:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 138E511FA94;
	Wed, 12 Jun 2024 21:24:59 +0300 (EEST)
Date: Wed, 12 Jun 2024 18:24:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <Zmnn-zCYTrUm1u0X@kekkonen.localdomain>
References: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
 <20240612143956.GN28989@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612143956.GN28989@pendragon.ideasonboard.com>

Hi Laurent,

On Wed, Jun 12, 2024 at 05:39:56PM +0300, Laurent Pinchart wrote:
> On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus wrote:
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
> 
> I think it's shipped in Chrome Books. Sakari can confirm.

Not yet but I'd expect that some time in the future. The Chromebooks use
Linux specific definitions that pre-date DisCo for Imaging but are still
relatively close to that.

-- 
Kind regards,

Sakari Ailus

