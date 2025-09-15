Return-Path: <linux-acpi+bounces-16965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECD5B585F4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9048A7A278D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A468287260;
	Mon, 15 Sep 2025 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxFTcAEH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15184286412;
	Mon, 15 Sep 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967544; cv=none; b=ct17YDQkiVcOONrMqxCB+nCVU/HWsHwaGqSvjfGz5No1IxuF76kWSMS2AscfTH4V0RNV6m6Y8HJjfuuqCw9L5Qu2ypuIZGHEuGTB9ByDb2/3TaAt3Bt760o6s4QcnT6ZL5PTL+tc5vtFg2IdIjr8Y8XjMtP2FbVXZ6PNlUwVm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967544; c=relaxed/simple;
	bh=9It1wQ5uR41eu0ARWQzVLjUmtSCbCuUHt/xOPwPXjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKQAugw17i1H0GGLo0LKvudk/4z9R5Qs89FP9lfi5siUSnFO/Nfh5zQevLnLStzpVJRr5ejJeRQ5MzVnwvp89ptkA09Btm4cu8jVV4uRSvhCtiCiibtWZMxwF5yClFxbnLjLb7/qbcUEpJk3vw08bSbimG45u98aCboygISGqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxFTcAEH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757967543; x=1789503543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9It1wQ5uR41eu0ARWQzVLjUmtSCbCuUHt/xOPwPXjyM=;
  b=HxFTcAEHGg55C58WWGUfKf3z1GgIQNbYpB2r4yh2oPllKyjM7yCBNHBB
   WcMiJk3M8CbftssdQEskWPXQOcfkILwiyB2wTBoFftwVfc4bFZiCuDSCd
   tPHn1fq8K61v5eGshh5MYBT9g0OhmP4h7QQeLTMFztOBPorqP35UWwtqq
   EO1kmrgOUiQZZAYy0SMA/s3ULpDW9wnhzy6jma5n/BygfSGPqVRirREso
   +gxIIdxM9C/IHbyjUszPUA6/dkRMmOfVJoU9KrLvGxcf4Wx5VIzeagUsp
   dZQXUysxRFpviy+1AXARPFIH6nAZI9WLvcUZiK/s4hQcgcmPhku3XUU1U
   w==;
X-CSE-ConnectionGUID: JFrbaIraQs69rXMOlri+3A==
X-CSE-MsgGUID: sakxFc+PSJKw8kOx++bPTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77845092"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="77845092"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:19:02 -0700
X-CSE-ConnectionGUID: sX5dBo5DQt67lVIC6XZvWQ==
X-CSE-MsgGUID: rMQOsQaqTeG+EtQSlM7dqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="174281734"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.113])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:19:00 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7FB5A11F785;
	Mon, 15 Sep 2025 23:18:57 +0300 (EEST)
Date: Mon, 15 Sep 2025 23:18:57 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
Message-ID: <aMh0sRizzRFTtp6z@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
 <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>

Hi Rafael,

On Mon, Sep 15, 2025 at 02:27:16PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Sep 15, 2025 at 1:32 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > +                     /*
> > > +                      * The reference is expected to point to an object
> > > +                      * returning a package that contains _DSD-equivalent
> > > +                      * information.
> > > +                      */
> > >                       handle = link->package.elements[1].reference.handle;
> > >                       result = acpi_nondev_subnode_data_ok(handle, link, list,
> > >                                                            parent);
> > >                       break;
> > >               case ACPI_TYPE_PACKAGE:
> >
> > And similarly, the result of an evaluation here is a package when a
> > reference points to a name object (i.e. a data node).
> 
> Well, I'm not sure how this remark is related to the new comment below.
> 
> Do you mean that this always happens when a reference is used in ASL
> to point to the target here?

As long as the target is a non-device object (or name or method object at
least), which is required by DSD-guide for (non-string-)referenced objects.

> 
> But the comment would still be valid in that case, wouldn't it?

After re-reading the first paragraph, I agree.

> 
> > > +                     /*
> > > +                      * This happens when the target package is embedded
> > > +                      * within the links package as a result of direct
> > > +                      * evaluation of an object pointed to by a reference.
> > > +                      *
> > > +                      * The target package is expected to contain _DSD-
> > > +                      * equivalent information, but the scope in which it
> > > +                      * is located in the original AML is unknown.  Thus
> > > +                      * it cannot contain pathname segments represented as
> > > +                      * strings because there is no way to build full
> > > +                      * pathnames out of them.

Is the "original AML" relevant? Aren't we just interested in how the
evaluation result was reached instead of what was its actual path? We won't
know the latter in any case. What would you think of:

			/*
			 * Evaluating a reference results in a package object
			 * (required by DSD guide) allocated on the fly. The
			 * actual target object of the reference isn't
			 * available.
			 */

I guess nothing prevents having further string references within the
object?

I think it'd be best to deprecate direct references in the DSD guide.

> > > +                      */
> > >                       desc = &link->package.elements[1];
> > >                       result = acpi_nondev_subnode_extract(desc, NULL, link,
> > >                                                            list, parent);
> > >
> >

-- 
Kind regards,

Sakari Ailus

