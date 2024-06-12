Return-Path: <linux-acpi+bounces-6327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E0905260
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCCA28342A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1216F83E;
	Wed, 12 Jun 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGy9Y+gV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEE16D4E0;
	Wed, 12 Jun 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195183; cv=none; b=nDsRu0TsFZ7ij44NtzLAbqAa+XeBl8OClZeRElB5Vy7ma++0rpQ5h8frWXkIt9ZOvyE4ZLsdmmxzaGDBHqmpmDTV1b7QCHNtO9Fx5wR6Ad7Ifm75g2wBCVUlzK+PMFMAnhyW49MgXK2tuMPpEllABEqhWhSjJ+BtMcO0D4LBwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195183; c=relaxed/simple;
	bh=X6rqLVsqcFx/K6egI2W2ToBN1EUUl0Rv0GR7XWoyRCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh1oQROyn9F3/n9ihc8vWGeULCY1H+AEk0uGtwcfbCi+rp6cPvzz5cU08gEXOPXdbwg5dqZ8D+KUJkS133W8fA+T8nQJ0vXAueFKfk0fApjYCyWXpb5GGLuofYor08fhDSIG0bjW4nxAPjTvYrm+1urbpZlpJvtdl7/A7QMWZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGy9Y+gV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718195181; x=1749731181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X6rqLVsqcFx/K6egI2W2ToBN1EUUl0Rv0GR7XWoyRCM=;
  b=bGy9Y+gVD5Yd6mNCO5jlXxRf7vHGuwbYU6a4rZl4lKW5PD38+UrckzUB
   Lm7pGESFXTHEvPy9H3flnxD/kxhGH9YODQj6+uCkbO7PoyUXf7YS8SJnC
   lNkqu71oMdsgOLQahYdd+hw4coN6mYu/lKepHjI4rZd/yYdtQNQ/CsKT9
   YPJzt+XELISpIyPuPuKYzCJpqVM+52b61gvdZmKOjAKsOY82jFGkZ7/1l
   AKhzvTQs7zie5fyE9+eOKpYHw4qMzxa/buRwGXtVBfklWLUzdJNIuWSNo
   Ku32hFAMf7r038o0+hXiEarE2wC4GrwspA+fMcGoz6Mxt2C1eNdH01Cxq
   w==;
X-CSE-ConnectionGUID: 7XYIUnqMT5S/h4c0z1q5rg==
X-CSE-MsgGUID: mLT40FX8Qh2E0TDf9nsb2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11100"; a="14790210"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="14790210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:26:21 -0700
X-CSE-ConnectionGUID: 5hxRAjI+QreLRwOiDvheWQ==
X-CSE-MsgGUID: Oz+VyKnmT9ioRULZEqRQfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="39878520"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:26:19 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6018811FA94;
	Wed, 12 Jun 2024 15:26:15 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:26:15 +0000
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
Message-ID: <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 02:21:51PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2024 at 2:10 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Hans,
> >
> > Just read this discussion, too...
> >
> > On Wed, Jun 12, 2024 at 12:08:49PM +0200, Hans de Goede wrote:
> > > Hi,
> > >
> > > On 6/6/24 8:12 PM, Hans de Goede wrote:
> > > > Hi,
> > > >
> > > > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > > > to Rafael directly.
> > > >
> > > > Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> > > > to make the cameras work on the Dell XPS 13 plus 9320 .
> > > >
> > > > On 5/28/24 7:09 PM, Hans de Goede wrote:
> > > >> Hi Sakari,
> > > >>
> > > >> On 5/28/24 10:44 AM, Sakari Ailus wrote:
> > > >>> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
> > > >>> is buggy, just like it is for Dell XPS 9315. The corresponding software
> > > >>> nodes are created by the ipu-bridge.
> > > >>>
> > > >>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > >>> ---
> > > >>> Hi,
> > > >>>
> > > >>> Could you test this and see whether it fixes the warning?
> > > >>>
> > > >>> The camera might work with this change, too.
> > > >>
> > > >> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> > > >> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> > > >> works, including giving a picture with the libcamera software ISP +
> > > >> 3 small libcamera patches.
> > > >
> > > > I forgot to add:
> > > >
> > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > >
> > > I just hit the same problem on another Dell laptop. It seems that
> > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > and Raptor Lake generations suffer from this problem.
> > >
> > > So instead of playing whack a mole with DMI matches we should
> > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > with those CPUs. I'm preparing a fix for this to replace
> > > the DMI matching now.
> >
> > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > to DisCo for Imaging at all.
> 
> So it looks like the changelog of that patch could be improved, right?

Well, yes. The reason the function is in the file is that nearly all camera
related parsing is located there, not that it would be related to DisCo for
Imaging as such.

-- 
Kind regards,

Sakari Ailus

