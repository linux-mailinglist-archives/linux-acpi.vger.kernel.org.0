Return-Path: <linux-acpi+bounces-6324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED68905221
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BF21F21849
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857116F845;
	Wed, 12 Jun 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hf5l7iP8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C016F28C;
	Wed, 12 Jun 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194230; cv=none; b=N6J8batRUstNqRNNKGVjWGc+ReG4PabLIjl9YFH/DxGbTD6zGb/nx9goWZLVFNlb3uhjLTiJBUP866N7W/QCP7FZ5HZvCWp6uwa7vyp5r8l5oBPbVPaBX0mOjR0Qv8Upe3M7CqSVZd+pED0zIrvfjijeEwWFQNfLEGhI9tJjOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194230; c=relaxed/simple;
	bh=ulVQlXizho1q+gbUxAcMgft3CXjIyNd0pCbLQeN7++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIvKl7yriFtrUQoYvtVLyxZjJbMWbF3U5fUA4w98R0H9ltJt/e1BBLDoQJ/9JAJxaGtRLy1MNkz7Pwk0T01R54XjA3cWaUc1cSQMHUEXRnyrOR3Lh5fFCU67uDIK2pBMevBtzHq9K9VDC0XsM9VZjGTnpKviatPxnKc4oDJSUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hf5l7iP8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718194228; x=1749730228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulVQlXizho1q+gbUxAcMgft3CXjIyNd0pCbLQeN7++A=;
  b=hf5l7iP8FPLx+15p5Q89OYNazELMP1tRa7B4TEnuf9v0Dd28RD1AITNv
   SPYTxpFP2ey01Gh8nexhXJdqExCR2ggiB+O4/7vkgiAVOePiK42Gjxkp9
   A6IsH9f9DqHNaXE5BwsABq4IkHMkGP1iFtNhYypA6qa47u5yvCGSfiNMl
   slfROz3PbAseUbhwOf/3PsR4R16vflHjUSgJH5uN+PJkXorOIUCXaX5f2
   zu/zG9TpXfD89WiCzU8JxGygS8z4uKUSkETBRtpXFPf/coM7hE7Kw595C
   3X4umr+/owTHWCxvoPfGYMe7Y+dDdFuYAYkp6+3sqRgHxTakxwbuVnqvg
   Q==;
X-CSE-ConnectionGUID: 2ZfLEKjGTwWFVOl66+Z+aQ==
X-CSE-MsgGUID: 4cIO2zSgT1K0VRCxs6hmaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11100"; a="18732031"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="18732031"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:10:27 -0700
X-CSE-ConnectionGUID: Em0Cr2PkQSS3XQMXaBHuqQ==
X-CSE-MsgGUID: ZsmZCoSISxiQ8xgl0rYpEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="39834907"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:10:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6A6A911FA94;
	Wed, 12 Jun 2024 15:10:22 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:10:22 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Genes Lists <lists@sapience.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
	wentong.wu@intel.com, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>

Hi Hans,

Just read this discussion, too...

On Wed, Jun 12, 2024 at 12:08:49PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/6/24 8:12 PM, Hans de Goede wrote:
> > Hi,
> > 
> > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > to Rafael directly.
> > 
> > Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> > to make the cameras work on the Dell XPS 13 plus 9320 .
> > 
> > On 5/28/24 7:09 PM, Hans de Goede wrote:
> >> Hi Sakari,
> >>
> >> On 5/28/24 10:44 AM, Sakari Ailus wrote:
> >>> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
> >>> is buggy, just like it is for Dell XPS 9315. The corresponding software
> >>> nodes are created by the ipu-bridge.
> >>>
> >>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >>> ---
> >>> Hi,
> >>>
> >>> Could you test this and see whether it fixes the warning?
> >>>
> >>> The camera might work with this change, too.
> >>
> >> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> >> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> >> works, including giving a picture with the libcamera software ISP +
> >> 3 small libcamera patches.
> > 
> > I forgot to add:
> > 
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I just hit the same problem on another Dell laptop. It seems that
> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> and Raptor Lake generations suffer from this problem.
> 
> So instead of playing whack a mole with DMI matches we should
> simply disable ACPI MIPI DISCO support on all Dell laptops
> with those CPUs. I'm preparing a fix for this to replace
> the DMI matching now.

DisCo for Imaging support shouldn't be dropped on these systems, and this
isn't what your patch does either. Instead the ACPI graph port nodes (as
per Linux specific definitions) are simply dropped, i.e. this isn't related
to DisCo for Imaging at all.

-- 
Kind regards,

Sakari Ailus

