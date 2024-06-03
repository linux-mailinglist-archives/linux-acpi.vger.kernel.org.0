Return-Path: <linux-acpi+bounces-6150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77F8E96B2
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716231C2239A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020413C3DD;
	Mon,  3 Jun 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCf9oSWG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E813A244;
	Mon,  3 Jun 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450437; cv=none; b=KYAR3LG4Y3cV9m5DxuDz5T7JCBA6FLjWtt3nwd9iybaCGFIFWl+F1R7kQGF6Q6jMGBWTJ7Kf8Px8c9g8tXCICCcdxc2Nc846+rJWfdsu2S8kc/esuXRuJRrp2pN0yzFWOcLTsqZ/IJEuiuxUHeILs40YvvvEqQ5lPf0gW65SF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450437; c=relaxed/simple;
	bh=+WAVr7Cr9XJko6qLCCjaOI8VDhsbvA5KZNsxHN21Bjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL3csRXsDZdY30Kh+aVQ0kMCYO/jVu9hfUjId5cOXpzv42+HiI0OIN5QwlVFcL75sjDAytiS0W5eHYMRcfHayvABWw1ypDp4wN4ZcHeEr9UgE+kSALruHigJJ8UE9halfPZJ4qm5B1VfTf/oJdCDZ+Mu44CtKHgN2ZtRWuDD5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCf9oSWG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717450436; x=1748986436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+WAVr7Cr9XJko6qLCCjaOI8VDhsbvA5KZNsxHN21Bjc=;
  b=lCf9oSWGd6ldqlVNFtRP0oFOHb/FcDj+k88HqngTJaWpz59IAEE8kuVf
   +DTiXWZp6GNkZvsXQZrbiCxow6NgjkksDkSDEtEdA0yqfc7g2mqDKDR6l
   GxCDd6hUJTCAwsbeUjZsyAHrggmYgSV4dEI1as4w/0M38pc42PIegkOWf
   9T9hlpuBCVFOu5YgplZLi755ByrFDhoeUEk/jMg7032viD6VaiO8Q0tXH
   h0jOPyHdhdas8iKQ6sBQZGq6hVwm37b6KoyS7F7TPMPH3DqP/uJD68X3M
   RDSvhlRnTvBkBen2FqYgFxsw5zyHGrsSmw6OP1CaxICPJwA/bIqKtbmBA
   Q==;
X-CSE-ConnectionGUID: eBxkM+7sSxmbuSNHgogz1A==
X-CSE-MsgGUID: JIqM9ELST4+TvcIuQ5+Kzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17754278"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17754278"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:33:55 -0700
X-CSE-ConnectionGUID: BVT8Mfq7QcCyeWc3iTkFNA==
X-CSE-MsgGUID: MX87PzPBQhC/KM/+zBMT+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36991062"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:33:53 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DD6B111FB5E;
	Tue,  4 Jun 2024 00:33:49 +0300 (EEST)
Date: Mon, 3 Jun 2024 21:33:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Wentong Wu <wentong.wu@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, Kate Hsuan <hpa@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
Message-ID: <Zl42vYs40MJiPxl7@kekkonen.localdomain>
References: <20240603205050.505389-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603205050.505389-1-hdegoede@redhat.com>

Hi Hans,

Thanks for the patch.

On Mon, Jun 03, 2024 at 10:50:50PM +0200, Hans de Goede wrote:
> When using an initializer for a union only one of the union members
> must be initialized. The initializer for the acpi_object union variable
> passed as argument to the SID ACPI method was initializing both
> the type and the integer members of the union.
> 
> Unfortunately rather then complaining about this gcc simply ignores
> the first initializer and only used the second integer.value = 1
> initializer. Leaving type set to 0 which leads to the argument being
> skipped by acpi acpi_ns_evaluate() resulting in:
> 
> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
> Caller passed 0, method requires 1 (20240322/nsarguments-232)
> 
> Fix this by initializing only the integer struct part of the union
> and initializing both members of the integer struct.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Even though this is a one-liner, figuring out what was actually going
> wrong here took quite a while.

I was wondering this with Wentong, too...!

> ---
>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
> index ffa4ccd96a10..596a9d695dfc 100644
> --- a/drivers/misc/mei/vsc-fw-loader.c
> +++ b/drivers/misc/mei/vsc-fw-loader.c
> @@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
>  	union acpi_object obj = {
> -		.type = ACPI_TYPE_INTEGER,
> +		.integer.type = ACPI_TYPE_INTEGER,
>  		.integer.value = 1,

I guess initialising integer.value implies that all integer fields are set
to zero (and so zeroing type set the line above)? Maybe moving setting type
below setting integer.value might do the trick as well? ;-)

It'd be useful to be warned by the compiler in such a case. There are much
less useful warnings out there.

Excellent finding indeed.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This could be cc'd to stable, this warning will display for a lot of
systems. I.e. I think:

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8 and later

>  	};
>  	struct acpi_object_list arg_list = {

-- 
Kind regards,

Sakari Ailus

