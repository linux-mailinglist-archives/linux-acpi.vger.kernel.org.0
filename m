Return-Path: <linux-acpi+bounces-12844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BDA7FB28
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B73D16A256
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E44265CBD;
	Tue,  8 Apr 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxo76sqU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461C33FE;
	Tue,  8 Apr 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106983; cv=none; b=rd+LWrBfITEL7EB3xReEWK2y5SbEeDUBdjUu8YXe6JlD9pgAshhQmGuY8MsydgW757iywP2RAjo5SJqEPVWatFR0wz1zKjEh/Ql/j3VnRHfvjr+XziFy9qXNr7BFOQpxjqjhg/1hqmJv6cFmesxrXJrk7T80YB3KB0KfQiBMahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106983; c=relaxed/simple;
	bh=OPjTTa1NbLeMf1j6vRXKSfNayZckVUxDF+LbfaElLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7d5k5swb8gOeKZomKTwBi0k1831DktxgFVbhMga4kyk1RfpGLGXs4Pgg+4Ns8ysMSxRQCRuGlXeo9FdqRN/Yi2/qhWVvdtQP0btAC4EfS7R9Q2v6c66jRbVlK/ijZ51pmvQjMSrqUdZuCY7oLWa6/wn3Pzb3T+rqYw349Gl9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxo76sqU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744106982; x=1775642982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPjTTa1NbLeMf1j6vRXKSfNayZckVUxDF+LbfaElLZc=;
  b=Qxo76sqUIXwZ0vTstjMHsS3FYkAx9zwabwi4oFXPuSU5YIP2mxqSfgWS
   /yYTByeCEByTG0AYKXgvuE3jxKuTGPWPQuetMgfzWc4vcghUQdzcnxisZ
   OHMgCr57V066lkqW10BJB7f5VV+HylNDCNU2C88PgPxDYRtGqb7wLvCcv
   GZbVSuHuUAlmyzUmOKoAKyF32BwMwcwnCo6o6GFMDInmTofMytSHdqkEG
   H+LVwh09lczblT817XrpcuMdpqlwVMnLvsLIxGtfKL0aERau/z8FYW0Pb
   JDUWuETFgyWB/N83otr7JBYqISXzoH0E9U9nvyelPl4VEnIcIzmBWg7Lb
   Q==;
X-CSE-ConnectionGUID: t/ezILkaRpSDHWSiKa3yZg==
X-CSE-MsgGUID: qt/pMY00RgWU97na69a7/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48238944"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="48238944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 03:09:41 -0700
X-CSE-ConnectionGUID: D0xD4TVhQle/OH3yX/WW/Q==
X-CSE-MsgGUID: dxiRiwhzTheikWw2pYIJdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="133089441"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 03:09:39 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8594911FB1F;
	Tue,  8 Apr 2025 13:09:35 +0300 (EEST)
Date: Tue, 8 Apr 2025 10:09:35 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z_T13wt6CRyF2EGs@kekkonen.localdomain>
References: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>

On Tue, Apr 08, 2025 at 12:48:55PM +0300, Andy Shevchenko wrote:
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.
> 
> The purpose of this note is to give guidance to driver writers
> to avoid repeating a common mistake.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
> 
> v3: reworded the note, added problem statement into commit message (Rafael)
> v2: added "...into the driver" piece at the end to remove ambiguity
> 
>  include/linux/fwnode.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 87b183595ba1..900ecd8f45a1 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -2,6 +2,11 @@
>  /*
>   * fwnode.h - Firmware device node object handle type definition.
>   *
> + * This header file provides low-level data types and definitions for firmware
> + * and device property providers. The respective API header files supplied by
> + * them should contain all of the requisite data types and definitions for end
> + * users, so including it directly should not be necessary.
> + *
>   * Copyright (C) 2015, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */

-- 
Regards,

Sakari Ailus

