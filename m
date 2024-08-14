Return-Path: <linux-acpi+bounces-7586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFE952315
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055CD1C21AAE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A61BD51C;
	Wed, 14 Aug 2024 20:10:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976120B0F;
	Wed, 14 Aug 2024 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666200; cv=none; b=tiO/rvEwMm2zYS3U1+BU7ghP681Q5znTKnCkRDr8fA2VIQv4zeYUFsB1xh1NsPb7iiGXzitzjRm1FGMo78JSfGTkhKWEBTa0mcEnY//UBakpsnGazRXyoJrcwgoWf9UtBFeH/2bFtiJBW8bHe5GJx2OAjqPi8CiYv3u13hh/TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666200; c=relaxed/simple;
	bh=k2EQlZ+vVusYm6wUFcjxMloJjFPbRIL/CK/1jNKJYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhJIROsGmRz2lLlrC8X6B8KLYTYMgkReeEGcUjUZ5MS7DNYL5/2wE8BVHbpE/QG3NcccE7tEqFM9mk0xqCWcbJCRAdByZLIOADxh+zqlwsUW9O8vW8e3224m0oEaFJSmYFpI1mLVp5Dqg8D0/FGPW3zLY4lRPkAVaSCl8b2bQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2rER/dgTTZKBOV0Kn102cw==
X-CSE-MsgGUID: qSZu9Q+4TE+USWAKg5baXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21717739"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="21717739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 13:09:57 -0700
X-CSE-ConnectionGUID: lehesZ2DRn6EGmfYQhm7uA==
X-CSE-MsgGUID: DKr/xl3zROi7zpSX0ECAtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="63284262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 13:09:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1seKJb-0000000FKIv-43Lk;
	Wed, 14 Aug 2024 23:09:51 +0300
Date: Wed, 14 Aug 2024 23:09:51 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI/video / platform/x86: Add backlight=native
 quirk for Dell OptiPlex 7760 AIO
Message-ID: <Zr0PD5d2bqpikxf_@smile.fi.intel.com>
References: <20240814190159.15650-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814190159.15650-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 14, 2024 at 09:01:56PM +0200, Hans de Goede wrote:
> Hi Rafael,
> 
> 6.10 has a new backlight driver for UART attached backlight controller
> boards found in some Dell All in One models.
> 
> Now the first AIO has turned up which has not only the DSDT bits for this,
> but also an actual controller attached to the UART, yet it is not using
> this controller for backlight control (it needs GPU native control).
> 
> I did not tie the dell-uart-backlight into acpi_video_get_backlight_type()
> yet, so the first 2 patches in this series deal with that and the third
> patch adds a DMI quirk to select native backlight control on top.
> 
> Backlight control used to work on the Dell OptiPlex 7760 AIO with kernel
> 6.9 and older, so this is a regression and I would like to see this
> series merged as fixes for 6.11.
> 
> Rafael, the drivers/platform/x86/dell/dell-uart-backlight.c are small
> and isolated. So I believe it is best if you take the entire series,
> to avoid conflicts if any other drivers/apci/video_detect.c DMI quirks
> show up this cycle.

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

I find this quite small and I agree this would be nice to have as fixes.

-- 
With Best Regards,
Andy Shevchenko



