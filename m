Return-Path: <linux-acpi+bounces-10059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2289EBB68
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FB6283FB4
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CC22F3AA;
	Tue, 10 Dec 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLEz4f8v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CF1BD9E9;
	Tue, 10 Dec 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864485; cv=none; b=eGX+BgNpjK0fy/cPX5zDhbOkT18Q759bexvGmcEhY023QJi2k8ikV632BBV4C67A0tPERkUj/zxXxU+j9vznp13oyOhybzEnnK1afnTTfuxYsnY4zGtrn24g61FOl3ij3SKZiY3UHdfUyMCFbu4uVx/a1yl4o+ji/pUBmlx1MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864485; c=relaxed/simple;
	bh=OOzhAnOXpwKXN+M0vFRzr74D2kIKATTBAFk9E4P0T+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R37LpPdLBWHbUO9zUq/7ometCcuJLRzcbVF8MFUA4MovB8lyymWQsZxiM6q2oT+Hj5OuoZZ24B7zwc7A7HUXpp56JtlbsnRogz/Y9/IOtmpEI0joP0Jx8n/kre4E8kddEuDc8IpLbswKKAowcUzxuXeo0zz0r0rOIv1bodkQFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLEz4f8v; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864484; x=1765400484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OOzhAnOXpwKXN+M0vFRzr74D2kIKATTBAFk9E4P0T+U=;
  b=bLEz4f8visZlalczU9Fre3dn3yWk0UVySdq//rr8XzVgG6kD6EG5qU2p
   krWi9zqqlwR/hdVY5aKny9INSmWa5zZJmZ++FhvZPZHxeQ1Mv4n+2+qG0
   WY5GMfLjqT4hrDkKQeFYLMsNR8M0eS9ULiSYnGqDOhHoJ5owD8/eLlB9C
   j3wBIUJKspDNm8DFvV3LITuBkIJ2zEH3TaA+41j/w4e+NZj4O1ohsO2fp
   frPyZsN8M8cVhkBNKMMIOGidyCqXOfVrcfhtyRrYdIdZ+X4SL/+VOVNfq
   No34PFDYJ1zPBQJjxNtQhYCm09GpgN8WmwkY16zQ1MLXyS+pmT4YnFJp6
   g==;
X-CSE-ConnectionGUID: PI5NptKQTNyDz1VT+p76oA==
X-CSE-MsgGUID: 7PIpC7kJSIqCvRVL3l1i+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34280028"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34280028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:01:24 -0800
X-CSE-ConnectionGUID: m2VosdRXTkuaaB8Tw3UpyA==
X-CSE-MsgGUID: fc4OJARwTDmfjX2Ld57FRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95978425"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:01:21 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2370C11F81D;
	Tue, 10 Dec 2024 23:01:18 +0200 (EET)
Date: Tue, 10 Dec 2024 21:01:18 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Message-ID: <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of acpi_device_hid that can be used when
> CONFIG_ACPI is not set.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/acpi/acpi_bus.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 4f1b3a6f107b..c25914a152ee 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>  
>  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
>  
> +static inline const char *acpi_device_hid(struct acpi_device *device)
> +{
> +	return "";
> +}

I wonder if any caller might expect something of a string if provided?
Valid _HIDs are either 7 or 8 characters whereas the proper version of the
function returns "device" when one cannot be found (dummy_hid in
drivers/acpi/scan.c). Unlikely to be a problem perhaps.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +
>  static inline acpi_status
>  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
>  {
> 

-- 
Regards,

Sakari Ailus

