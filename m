Return-Path: <linux-acpi+bounces-9188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8699B789B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2651C21533
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145161991CF;
	Thu, 31 Oct 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRc3REek"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13891991B8;
	Thu, 31 Oct 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370330; cv=none; b=aQU94EQf8N8hUuJG/YVLra8xgLp6udRXzQ/5wvUIJr6ar1x7tfiVcOusFMOdj0EMwCHrl0HInEF/ctMSampM0+XYDq1qgcqchR0yFsG3vKzWmUS9FkVxG/LM/QwrJvgYCMeZyF/DYZ6zN92aX2AfrtqczAzx6YaMhm2lsGDqyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370330; c=relaxed/simple;
	bh=QIs65bpp+AcjInZmsO+y+Ca2r4ViGo32+ltAm0FB+bQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lOsUMGuUudVe7Vw3V0hrML8uvBaY5S8HMyqliJquHz/6O8xLQPgqqJNShHteQ4hNRnI+EFr/MTlbeVuDL67h0RpP341DhQzcK+BoMiDpxrhlQmhxNkHI+w7/fXIyIPPLGLyETiwQPzb9gQXH65payyfjaOHOHeikVGhZT99LzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRc3REek; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730370327; x=1761906327;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QIs65bpp+AcjInZmsO+y+Ca2r4ViGo32+ltAm0FB+bQ=;
  b=JRc3REekBMW/XwFoWa2jUzYqR6ArKYi/4zExDjhed0vjs1ehtWfUR+oD
   +ciHRI7bAVsJNqLyDbpMNZnIXjllFUpkrJLUq0E2oJc8J4sfTYHtm6WXb
   8LBuPOwQzxeYVbft0MxTYhp83T4puA6jMYSreP9mgA7cfdBtvOxmIPw5x
   efqr4WkYhtcU27rcrScT8VfbxexYrXOlEPwMvLZWA4twsq2RVwn7hqftO
   0SkmrPYXgjMj/2RajkQZDvAJlVOrXF2VnZmXz8o48bdcJoXhZC1WH8Sr3
   0dDFel++jpaZw0XnXaZibAH5iyO9DfL2WBfNjTbyLIAOqAv+m1BJsJesa
   g==;
X-CSE-ConnectionGUID: yVj3l5lIQuak5lBHK6fBtw==
X-CSE-MsgGUID: Up5E+dK3SAWIPQWHr2YC9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29868121"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29868121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:25:27 -0700
X-CSE-ConnectionGUID: b91zI+x/R6i0z62Exve9Hw==
X-CSE-MsgGUID: ApzWE2hjSEKEabnDkPQZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="105911123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:25:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 12:25:16 +0200 (EET)
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
Subject: Re: [PATCH v3 16/22] ACPI: platform_profile: Set profile for all
 registered handlers
In-Reply-To: <20241031040952.109057-17-mario.limonciello@amd.com>
Message-ID: <7e2c26ab-9172-fa82-cd96-7f725d6c7687@linux.intel.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com> <20241031040952.109057-17-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Oct 2024, Mario Limonciello wrote:

> If multiple platform profile handlers have been registered then when
> setting a profile verify that all profile handlers support the requested
> profile and set it to each handler.
> 
> If this fails for any given handler, revert all profile handlers back to
> balanced and log an error into the kernel ring buffer.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 90cbc0de4d5bc..c2bb325ba531c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -99,6 +99,8 @@ static ssize_t platform_profile_store(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> +	struct platform_profile_handler *handler;
> +	unsigned long choices;
>  	int err, i;
>  
>  	/* Scan for a matching profile */
> @@ -107,16 +109,29 @@ static ssize_t platform_profile_store(struct device *dev,
>  		return -EINVAL;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> +		if (!platform_profile_is_registered())
>  			return -ENODEV;
>  
> -		/* Check that platform supports this profile choice */
> -		if (!test_bit(i, cur_profile->choices))
> +		/* Check that all handlers support this profile choice */
> +		choices = platform_profile_get_choices();
> +		if (!test_bit(i, &choices))
>  			return -EOPNOTSUPP;
>  
> -		err = cur_profile->profile_set(cur_profile, i);
> -		if (err)
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, i);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {

Too long line.

This looks an error rollback though so instead of break inside the loop 
you could goto into a label at the end of the function and have much less 
indentation to begin with.

> +				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
> +					pr_err("Failed to revert profile for handler %s\n",
> +					       handler->name);
> +			}
>  			return err;
> +		}
>  	}
>  
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 

-- 
 i.


