Return-Path: <linux-acpi+bounces-12809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355AA7EC00
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1815E188C1D7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511125EF8B;
	Mon,  7 Apr 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMCLsbyi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B3254AE7;
	Mon,  7 Apr 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050974; cv=none; b=hJLg62bQAgH0R/rCBqL6JHeFR6YbSeLIn0GuHYjr1rwdjmWaFcBh2mE1Uvf0XiQaXCN0yo74eezz4WeiAUVgSQlxOHy0d1MuYZNKP71EPTXwinKvsZLzEXblBKC9NNfT7sFoPWsCkFeHPf7VsB4t5iJfoWRTFXCRx4CDokWhl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050974; c=relaxed/simple;
	bh=Huf+fB0OWTt8HKqf6bIgXiTDuhBI+Xm6QC5tveP53G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXk+JPF3rnYe705innLZq5Nkh3aY4pSEWe/DXgEmwkGcB34xxY3hAxdR2cqpt/eo9PMuRql+DRFKOhtlGobUCCV/kMV/ZXpK286aqEiiIUttroYmXwtI33UFgLQTBeqwNcq69M7q/R/pV4rMPi/NLddhSBSmju9MmDyPdhLX/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMCLsbyi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744050973; x=1775586973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Huf+fB0OWTt8HKqf6bIgXiTDuhBI+Xm6QC5tveP53G0=;
  b=CMCLsbyiBxz8Y6KlTfZQBgiZYimYxFjPf/nK49bcVzMdGvf7ng2/dhB5
   5m6YPXoocOuQZ2n5BrDIyap63fNTjXkjxD5AMrXMjf8852M69W/lPbz+v
   POxC3JHbEotlab3Q6U4uJO65OqJgBponbSszg+c08NpUDB5NMCYhtoXhC
   lJQ02aqfxjskKNkNNtx8+mGNHLb2Y+6Dy/v2igKHzEYOfr8QccJ+J+3Zw
   p1ghienEDlVCqcGOh05bzGruRQpAUDXbLD0o1d/AOZ2EOQIndyApfiYI/
   ICe9TzS5HMrK359sbkiVhFIaikT9tnXbhgn36ebUa5egiD+kM9gudR7bN
   Q==;
X-CSE-ConnectionGUID: IIx6SHHXQ0OVscdLndzeiQ==
X-CSE-MsgGUID: 9yg1wn1eQju5/ikAl/u1tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49248764"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49248764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:36:12 -0700
X-CSE-ConnectionGUID: eoC9EKxPRy2Sffy+6ED+Dw==
X-CSE-MsgGUID: umNgzXgPT/+heAPDoiFQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="159034031"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:36:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1rKI-0000000AADm-3pe8;
	Mon, 07 Apr 2025 21:36:06 +0300
Date: Mon, 7 Apr 2025 21:36:06 +0300
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
Message-ID: <Z_QbFgSFMv58-QmM@smile.fi.intel.com>
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 08:17:17PM +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 31, 2025 at 6:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Add a note to the fwnode.h that the header should not be used
> > directly in the leaf drivers, they all should use the higher
> > level APIs and the respective headers.
> 
> This sounds like a solution to a problem, but the problem statement is missing.

> What's your motivation?

Found a few drivers that are mistakenly include fwnode.h while they meant to
have either of.h or more likely property.h.

...

> > + * Note, this header is not meant to be used by the leaf drivers.
> > + * It provides the low level data types and definitions for the firmware
> > + * and device property providers. The respective API headers should
> > + * guarantee all the required data types and definitions without including
> > + * this header directly.

-- 
With Best Regards,
Andy Shevchenko



