Return-Path: <linux-acpi+bounces-18724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D8C462B4
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDD23AD361
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A43074A0;
	Mon, 10 Nov 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT1dcY47"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A36221542;
	Mon, 10 Nov 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773260; cv=none; b=UsRpbvaUcVhmmLbZt6Zn2fmx5JIvj4Wr5/7JnAEHb1lBz5kbc9AbO4Pau4TddZlUHOFeSayFE5WS/cPFoETmIk3bWtMr+RozynTBo22yMhEnwwbplCebl7L9+Ge2sefOoujsQXS0oIF5+aTK6UI8QbGeeBFbbOOy3//YDZIc778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773260; c=relaxed/simple;
	bh=Tb3gGuGtl8j/1gHHLyftk/wWI4ks/TnsXd/Czi8Q01M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AiEEOg32og8bYlIIhSeUEL5WHUR+TyN+YlNBW+b2JKcCt26lpqbA6W5a7htDTiMmQakOTuy+m01CfaHMt62YAL3cqsoxNFpbULv3z36JQ/vCqe9+uZKqJOFsUtn7VZ7nIr7jb9Jdt3Y4a0gWSg8EPZDfL8ZDOI7X9xsK5PoMmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT1dcY47; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762773258; x=1794309258;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tb3gGuGtl8j/1gHHLyftk/wWI4ks/TnsXd/Czi8Q01M=;
  b=YT1dcY47my/X4QLBPSbuMKIo+3Sdym2+IUzAHausngiDw5Tum/8qYPw0
   NeMgnllVyYY1G7vjb0OpzL4hcPPnIMLqSUuYHSx91RXC0r7gt85l/CtMY
   bFo83KLE182h9S5RQL/xkhYsaJKQQ3S6vDkyfSmWuDeq8KWq4Po9VtZ7S
   0OY0BS10Z5j3M5VfzMyogBjeZFuM2GPRw8A6lR0WL7XJKVzxaSDLy2a7K
   tuQsKYB7sjT/EfPYuBUe3CmipyPavK0DQ4sm4MUiUJ3ECD0ph9tZANUaX
   oUGQjfw2WSG8luGqyU1kk0HEkEMTkJKmogYiT524bcK3ipBt+gvRaIwik
   g==;
X-CSE-ConnectionGUID: /eBAel49SLqPcfGyqr/c8A==
X-CSE-MsgGUID: vINU1X54TGOxoCX7wdGuxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75507021"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75507021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:14:17 -0800
X-CSE-ConnectionGUID: qa1zIVn6QxG/ucqV7AEW3Q==
X-CSE-MsgGUID: bSXtiLKeRPaXy0gb8YYAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192757513"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:14:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 13:14:07 +0200 (EET)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mario Limonciello <superm1@kernel.org>, Hans de Goede <hansg@kernel.org>
cc: Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] acpi: platform_profile - Add Extreme profile
 option
In-Reply-To: <20251106212121.447030-2-derekjohn.clark@gmail.com>
Message-ID: <701898dd-3310-e86d-7499-fca5a445447a@linux.intel.com>
References: <20251106212121.447030-1-derekjohn.clark@gmail.com> <20251106212121.447030-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Nov 2025, Derek J. Clark wrote:

> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> power draw is at the maximum limit of the cooling hardware. Add a new
> "extreme" platform profile to properly reflect this operating mode.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>  drivers/acpi/platform_profile.c                        | 1 +
>  include/linux/platform_profile.h                       | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> index dc72adfb830a..9bee8deb4dc9 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
>  					power consumption with a slight bias
>  					towards performance
>  		performance		High performance operation
> +		extreme			Higher performance operation that may exceed
> +					internal battery draw limits when on AC power
>  		custom			Driver defined custom profile
>  		====================	========================================
>  
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index b43f4459a4f6..78da17e16d9b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -37,6 +37,7 @@ static const char * const profile_names[] = {
>  	[PLATFORM_PROFILE_BALANCED] = "balanced",
>  	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
>  	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
> +	[PLATFORM_PROFILE_EXTREME] = "extreme",
>  	[PLATFORM_PROFILE_CUSTOM] = "custom",
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index a299225ab92e..2bf178bde2b5 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -24,6 +24,7 @@ enum platform_profile_option {
>  	PLATFORM_PROFILE_BALANCED,
>  	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>  	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_EXTREME,
>  	PLATFORM_PROFILE_CUSTOM,
>  	PLATFORM_PROFILE_LAST, /*must always be last */
>  };
> 

I wonder if "extreme" is the best name for this? Given the description you 
gave above, perhaps "max-power" would be more descriptive (and we already 
have "low-power" so it kind of feels fitting the theme too).

I don't have strong opinion on this so if you guys feel this suggestion 
would not make things better, feel free to voice it. :-)

-- 
 i.


