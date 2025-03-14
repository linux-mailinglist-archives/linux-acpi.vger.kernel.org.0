Return-Path: <linux-acpi+bounces-12243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E460EA612D3
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20773463516
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA91FF61D;
	Fri, 14 Mar 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMOEWQK5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18071EB3E;
	Fri, 14 Mar 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959317; cv=none; b=f2FTsLi1amMPqUiycqBdNEFFF5T/YYlfnrObXcI1YeZHdsWN9bE3M8cXb1dvbe0XmQatNDkj4W5veJauALh6D8d6RRTMzi7ol1PMaBkqPIhJCmmQTIHgRDCm4tfbiGCZZxFeTU7lvEXaQw5AeA6pG42QdyBTJpE/r9Gp62lFSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959317; c=relaxed/simple;
	bh=lbrUpLlTAZfyKHLiUvGnCzGc/aS0XN2ZE5+Tyou0prI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNa3vDSTRDmPFBhKwYQkVDMbfrhxOXqKzleW3GreUoQFfRRl49VjDEnUUGHrSBVIMjRUQ3FCa18jKoCQ4b3wqFrEgLEPqmlBJhIs1jKf1Ns2qIpObyomdgAfO9sSKZWr15R4ya2rg0T9bkmuoSSeAZqdDfERlPdD/LVcEzF/OpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMOEWQK5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741959316; x=1773495316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbrUpLlTAZfyKHLiUvGnCzGc/aS0XN2ZE5+Tyou0prI=;
  b=ZMOEWQK5+W4RQBPeJ3tkSo1G+bYoSqRKkGA1YjSOyKKonD3Ttbynl3sQ
   j6bn/SgMFCqtbqgAbT6DtjLmA8YAzYXYniM7J1BKr71LLxNL9wdr6dD+r
   tUhdTnO9GKTsDEzrsj70b4HNwklO3OrJrP4wBzveb4AHGR2LYH5lR+FIB
   315DZ+K6Qm2Nmg+sbhgmfb4N5bLhBkEFA2D6xUnpc1KH8Mt2u5W5M+50s
   Ju5Qj42PG0+19/pg6fz3+icMnO0Vp4p84nR344FFuLg95t55NnsDCkL1P
   Fc7tTbinFmi/kLMr7jts6a/Sc00Rz8M27KH1otLAEAtCimXy1HiqOwBVl
   A==;
X-CSE-ConnectionGUID: 0XeC94sjQiC2Xf5uZZ2/hQ==
X-CSE-MsgGUID: anSITIJeTZ6jrJsFdXluUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="30698361"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="30698361"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:35:15 -0700
X-CSE-ConnectionGUID: tUOZILfqQoq1dyG1X7PWwg==
X-CSE-MsgGUID: TqbxCqtRTWu1u8xwaJEdwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152166835"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:35:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tt5Bs-00000002T8A-0FpA;
	Fri, 14 Mar 2025 15:35:08 +0200
Date: Fri, 14 Mar 2025 15:35:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 0/4] leds: Introduce and use
 fwnode_get_child_node_count()
Message-ID: <Z9Qwi6vJqNi6D9dz@smile.fi.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250314123936.GO3890718@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314123936.GO3890718@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 14, 2025 at 12:39:36PM +0000, Lee Jones wrote:
> On Mon, 10 Mar 2025, Andy Shevchenko wrote:
> 
> > This series was inspired during review of "Support ROHM BD79124 ADC" [1].
> > The three conversion patches are the examples of the new API in use.
> > 
> > Since the first two examples of LEDS, in case of posotove response it may
> > be routed via that tree and immutable branch/tag shared with others, e.g.,
> > IIO which Matti's series is targeting and might be dependent on. The USB
> > patch can be applied later separately, up to the respective maintainers.
> 
> Ah, just seen this.
> 
> I'm okay with that, but need Acks for the other patches.

Right, we need an Ack from Rafael / Greg I suppose?

-- 
With Best Regards,
Andy Shevchenko



