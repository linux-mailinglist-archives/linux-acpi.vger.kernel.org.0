Return-Path: <linux-acpi+bounces-9189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B786D9B78D0
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC411C2415D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C08199392;
	Thu, 31 Oct 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT8Q80Eq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60518593C;
	Thu, 31 Oct 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371238; cv=none; b=tx5+jP552+PCGWhl9vSPiQ/5W/Xqdca1gsbiui5S8e9V8ZRqqXcHAcxTqwkkrOgnEPhUUCruZIY7Jg/gly1NQSbkE8hXUmUZpKmYFcQ2hGnCibaMG9GIVL2OcU/CvJkQyYuoMuch/RRA5uC5yvKX1/TlgUQ+K9aaTvVTsUrtreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371238; c=relaxed/simple;
	bh=9pxHDuQFnahO7h4g4uLSVfsqa6hZ0lzOKmSrX1WNWDg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i2vJ6fXQq9LORvPhKbnNrluBnt3b0NBWskh7DX4jhFe38kf2jO8Z1oMO0lfp2b80eC2gbFU64OUR2dBkJ661VDkf/1Zri+DWMLZ1FW0MXP+YkKPwYl5d8toaSHYAjQ0F8B+1kwleH9idWywwmrgEpPxG5FZYPQqr2vpaWiBxeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT8Q80Eq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730371236; x=1761907236;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9pxHDuQFnahO7h4g4uLSVfsqa6hZ0lzOKmSrX1WNWDg=;
  b=LT8Q80Eqz8z7kU+a4TfKsdsCjNKJUqdSVkIdnzMhmlIR3Z8mLrgm5YlQ
   PE5ra7PhvMR696GrgNJxkcpX1B/ig+DTxqmv7AiIATixQnUgoM2aHgQBQ
   cCG9O0QIVjhTtA1gOsz9nXkqrNu9XU273mrYXspwrvOXsbBWgPee9BbPB
   GTFOxE2CHTT8IVJGo/1JNMY0tsgZZD1V8pVznb1loB92epoul3aTm8bdz
   CpN6dnXyHLzdii2y/HouhHvZ7mhHsN7vHPOYGiJzu3hUcnpvuFeUJm1EJ
   XCRwwoECNSr7rCf3Tj7GYqL2aOp5o3LVo3E6dygixaStzMKBI7QiAe8XS
   w==;
X-CSE-ConnectionGUID: nwtlbhs+T1mb6ci7nYuvwg==
X-CSE-MsgGUID: RTuv/nKNQyuEBPCLMSVBQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30268133"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30268133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:40:35 -0700
X-CSE-ConnectionGUID: Qz2aoTdeS/+2QhzzpvKwvg==
X-CSE-MsgGUID: tZ1v9YUhQtmW+KRDt4DLHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87133136"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:40:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 12:40:26 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v3 19/22] ACPI: platform_profile: Check all profile
 handler to calculate next
In-Reply-To: <20241031040952.109057-20-mario.limonciello@amd.com>
Message-ID: <86d94339-3651-c4ea-306c-05589bee0040@linux.intel.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com> <20241031040952.109057-20-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Oct 2024, Mario Limonciello wrote:

> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
> 
> Check what is active and supported by all handlers to decide what
> to do.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 35 ++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 5baac1f9a9c0e..9b681884ae324 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -187,30 +187,41 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>  
>  int platform_profile_cycle(void)
>  {
> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> +	struct platform_profile_handler *handler;
>  	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	unsigned long choices;
>  	int err;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		err = cur_profile->profile_get(cur_profile, &profile);
> +		err = platform_profile_get_active(&profile);

If platform_profile_cycle() is called without any profiles registered, 
platform_profile_get_active() will return success.

I suppose you'd want check first that there is one registered and return 
-EINVAL if none are, especially since this is an exported function.

>  		if (err)
>  			return err;
>  
> -		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> -					  profile + 1);
> +		choices = platform_profile_get_choices();
>  
> -		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
> -			return -EINVAL;
> +		next = find_next_bit_wrap(&choices,
> +					  PLATFORM_PROFILE_LAST,
> +					  profile + 1);
>  
> -		err = cur_profile->profile_set(cur_profile, next);
> -		if (err)
> -			return err;
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, next);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {

Same here, instead of break you could goto to a rollback label to 
deindent the rollback loop a lot and make the code flow more obvious too.

> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
> +				err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
> +				if (err)
> +					pr_err("Failed to revert profile for handler %s\n", handler->name);
> +			}
> +		}
>  	}
>  
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> 

-- 
 i.


