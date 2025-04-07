Return-Path: <linux-acpi+bounces-12814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4FA7EC77
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22301888287
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F974265CDA;
	Mon,  7 Apr 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnX5z7NF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315E2571D2;
	Mon,  7 Apr 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051742; cv=none; b=uRLnyzWJfCzO0Xi47GURedO5WV+y3zmT/jod+IQRy3Qcrjxn08+3aa0Xi2eFIwmFxGcsMGP/JfkRyTXuXOA94Bd9ykWWqhKIpk79CiNYHMJ+RZfYuRzWT7piOpRaNT5DqDCwhjuyau2SKWlN3X1VsTd+skYRft6EOhqFvLmgmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051742; c=relaxed/simple;
	bh=XJBBZbjJ7YLAsq+ynvqXWj2U8yQIx7KVxRbf4FSRfo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3mMUsH0Ta4qfFDBZO8FcM66iJypI9Ek1M/5WJtS4gI35K6KsjY+Ua3dn+QAfi08FjE86Twmla+dcmhNuWp3yypNYSiU/D9NpFxT+qAyMIvGhmGBO2XiSiOSTaQg3/9i//Jr4QebHNU3WDnplos34nn78uhUvx4OWq2xiBrIZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnX5z7NF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744051741; x=1775587741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XJBBZbjJ7YLAsq+ynvqXWj2U8yQIx7KVxRbf4FSRfo0=;
  b=CnX5z7NF4fknJpUWD7anu233w/xuFJ1/0RAtXBTl4NvyEceD29HXFawh
   QiY4cv0G+Ygv0Pa8iJTZCG+ZIar10Kuqt6ZafBNcj0xHEry58G6qeJsvd
   BZOnBKTq/1T93k50PFGpje7rxjp5FWDx1Ynd/wOeQr9wusmWliCYQ9lGO
   MfFNYNoamDbVjHdnMSI0FxxVwmYe4FLq0mS8H0HAa34BooiETgqRtPL0R
   gLoYV2Em3k1e6OP5cTs+TyeoMqKUcr+p60clHI7BGlnkbFVM/JL+AfRz/
   z4LK/VXS4fxMN5X/wjegIIpFUs2jYUEJihBndctaJa+lDg05Ivee38Fct
   g==;
X-CSE-ConnectionGUID: yS/FLCQASwatbl/V+sifHA==
X-CSE-MsgGUID: 0Zw4Z8ieTCqrtddsR5IWpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45167726"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45167726"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:49:00 -0700
X-CSE-ConnectionGUID: gGwWYoGRQhG7e8jP45MWWg==
X-CSE-MsgGUID: /WK4fOOdS7qJWPeRZOD6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="133011605"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:48:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1rWh-0000000AAQj-0BdE;
	Mon, 07 Apr 2025 21:48:55 +0300
Date: Mon, 7 Apr 2025 21:48:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z_QeFmdDH1ls-cRI@smile.fi.intel.com>
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com>
 <Z_QbFgSFMv58-QmM@smile.fi.intel.com>
 <CAJZ5v0hFNqUTVn4wVqigzhHTnmPU63+Z8iFwv++=gx8P7A-cow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hFNqUTVn4wVqigzhHTnmPU63+Z8iFwv++=gx8P7A-cow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 08:44:20PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 7, 2025 at 8:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 07, 2025 at 08:17:17PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Mar 31, 2025 at 6:32 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Add a note to the fwnode.h that the header should not be used
> > > > directly in the leaf drivers, they all should use the higher
> > > > level APIs and the respective headers.
> > >
> > > This sounds like a solution to a problem, but the problem statement is missing.
> >
> > > What's your motivation?
> >
> > Found a few drivers that are mistakenly include fwnode.h while they meant to
> > have either of.h or more likely property.h.
> 
> I see.
> 
> I would then say
> 
> "This header file provides low-level data types and definitions for
> firmware and device property providers.  The respective API header
> files supplied by them should contain all of the requisite data types
> and definitions for end users, so including it directly should not be
> necessary."
> 
> And I would mention that the purpose is to give guidance to driver
> writers to avoid repeating a common mistake.

A-ha, thanks for the suggestion, since there is also a v2, which almost
the same, I will incorporate it into v3.

-- 
With Best Regards,
Andy Shevchenko



