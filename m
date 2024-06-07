Return-Path: <linux-acpi+bounces-6263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4608FFF52
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04B21F225B2
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947EF15B96F;
	Fri,  7 Jun 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyY7035T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0813A40F;
	Fri,  7 Jun 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752285; cv=none; b=LuKnk74zOLolkf5QqMlogHMuk44FueOiAD43zywotR+qDl84fdPnT3rHpCN8nJ/vplD0zvpixydPPSmbPob6ibSsw67yf99byyM0BklwyBCcZKG5GKLRoCckNxLUIOoLOvapzDV+1vWyIs7QjLkVF8x+epLz8YDUvizSulZNTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752285; c=relaxed/simple;
	bh=/91veDI2nMtqBub59WBSpwzgigLamN1h/2wkE6HNjH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF+aiU9EIFAHGJKYhELiClbzhYZ1IBCNs/wgb34SFHpCj9OxqFcGzdJYzl+fpyJmxDXadH8EZxrwDOKPbu8ZhIeGVcftTxZ7p+WVeTNWS0Ar0uGj0ho2TNNskImGXU0vXTfrw15j64FGW7msd2gTXdrQMm7PGIGNISsE5JThvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyY7035T; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717752284; x=1749288284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/91veDI2nMtqBub59WBSpwzgigLamN1h/2wkE6HNjH8=;
  b=dyY7035TH9RukSu+QNssgAqe28NDZbwf2EHzlaGy1kV8/UrYor2OHukr
   K99Pc/L599CTGWwIDU0seXvtIlC93Dy2cuSUp7+TS0TBoC9r4psa1tdHt
   TMRE1epkukyO6j/yqbb+q3xwHrcyWPEDcQzRPuMwa3tBIu+XpHij3FhcX
   HaAnITt87fX+39C2jxuLGqq4HhZ2YeSG/DpqZ3yBH9Ut1rqOdup2ddpQZ
   ASObWm8UuRK8u8mCY09ZbD+xm3c/8AWuSYyq2RFoKyN6dyMBhclhSQZiq
   j/vkcIDnC1ET21zBYKgyUObM9t4T8yCa4rPVXPDPdUbCV4eyuPJkxC2aI
   A==;
X-CSE-ConnectionGUID: BYcNsk5bRi6uUP9DrjTA7Q==
X-CSE-MsgGUID: zJOIYdV2RbaVLE3l78r/Lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25038857"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="25038857"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:24:43 -0700
X-CSE-ConnectionGUID: d2+XNwo6QAWxHv4YWX/UKQ==
X-CSE-MsgGUID: XqwGMeuFTPeiu12b9mjWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38190513"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:24:40 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 875AF12027E;
	Fri,  7 Jun 2024 12:24:37 +0300 (EEST)
Date: Fri, 7 Jun 2024 09:24:37 +0000
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
Message-ID: <ZmLR1XX8ctUladp-@kekkonen.localdomain>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <CAJZ5v0i1NxGHMKskP7W+hAusjt=5jYYWTF2vgJPR0gnrNTgFaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i1NxGHMKskP7W+hAusjt=5jYYWTF2vgJPR0gnrNTgFaw@mail.gmail.com>

Hi Rafael,

On Fri, Jun 07, 2024 at 09:55:44AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 6, 2024 at 8:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > to Rafael directly.
> >
> > Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> > to make the cameras work on the Dell XPS 13 plus 9320 .
> >
> > On 5/28/24 7:09 PM, Hans de Goede wrote:
> > > Hi Sakari,
> > >
> > > On 5/28/24 10:44 AM, Sakari Ailus wrote:
> > >> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
> > >> is buggy, just like it is for Dell XPS 9315. The corresponding software
> > >> nodes are created by the ipu-bridge.
> > >>
> > >> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > >> ---
> > >> Hi,
> > >>
> > >> Could you test this and see whether it fixes the warning?
> > >>
> > >> The camera might work with this change, too.
> > >
> > > Thank you I just received a Dell XPS 13 plus 9320 myself to use
> > > for VSC testing and I can confirm that with this patch 6.10.0-rc1
> > > works, including giving a picture with the libcamera software ISP +
> > > 3 small libcamera patches.
> >
> > I forgot to add:
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied as 6.10-rc material.

Thanks!

> 
> I've also added Reported-by and Closes tags to this, but I'm not sure
> which commit exactly is fixed by it, so the Fixes tag is missing.

That's fine. We don't know which systems have faulty camera graph in DSDT
so these are added as they're found.

-- 
Regards,

Sakari Ailus

