Return-Path: <linux-acpi+bounces-9066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A39B46AF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F5F1F23F8A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21344204F65;
	Tue, 29 Oct 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcV6GVF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4E204940;
	Tue, 29 Oct 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197389; cv=none; b=WUDtP9N1Yp3Gm2z3yzgaZmBUkR3eW0T4SFCWT2+yRjg6C9XlJZ5XBBimx69gcv6PRkoC0UuRKfHkBEkOLLZYg5EOKFm8cNxhKZ+glW8FOXBKmthMw0V2145D+PQ3P24Tuzk4dCsGHsXfdUweH/tciq0pzlaCkthVxrLjSsCnjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197389; c=relaxed/simple;
	bh=jb4N726ZXjdmDPyvA5AaSI5/eBYq/GaU8Q9ml+c2ubo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PoPueJkRv8pPBI4Q2Kh4yDoyEOqHX8e1AEIW24zWJ3Ea3hIUDgwKQN0EW7cR7Lslo1/MvmRef2BuUQsa6HxwxmJD7CnaoqRFfb4ew2O5mJKk96KrjjXo3UAx2iEG/15TojrZaLeak7sIgRNK3/lMkTMCy2BzWaGs4wcmGaryVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcV6GVF/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730197387; x=1761733387;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jb4N726ZXjdmDPyvA5AaSI5/eBYq/GaU8Q9ml+c2ubo=;
  b=JcV6GVF/xEG9nyA3pTEl4iW2bX7m2toJouorFo68QN9m0qu40aDhF2tK
   Tuh4ms7ziDnMv4w9OxuERQK0NbvlaQS/iil5sz353bLuIrMgjgTZvTKZJ
   nHA/hAmZYo3mCFHZNiHRM81Az6Z31H4NKou72TSA/qm7+v/YT2l7OTlCS
   /pCMzhsMCf8v0+Ddv2PY/73HHHGkYm6alDkVetCNG/ZXzhUicHKwiFEAu
   Ma4U2Y89h7DU45DnYuOsXgKd+rih00YokbMigisUBhpKSU0z1gNCJXRtL
   TZ/0438bv3M27fr/JinK+peZRzGvLZElNctIhBVNR+KogJXHg+EvKaKi3
   Q==;
X-CSE-ConnectionGUID: +up1DUp4QxCCjldP6scJyg==
X-CSE-MsgGUID: pEl/PaTTRMuTVyxCawW25g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29945969"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29945969"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:23:06 -0700
X-CSE-ConnectionGUID: 2DE7Nzw/QHGN3gX1K3kDAA==
X-CSE-MsgGUID: 9Dlz26aqT3uszb0h6f6E7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="85876891"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:23:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:22:56 +0200 (EET)
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
Subject: Re: [PATCH v2 11/15] ACPI: platform_profile: Set profile for all
 registered handlers
In-Reply-To: <20241028020131.8031-12-mario.limonciello@amd.com>
Message-ID: <46e19bc3-2624-f4b9-a946-050c92c0591d@linux.intel.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com> <20241028020131.8031-12-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Mario Limonciello wrote:

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
>  drivers/acpi/platform_profile.c | 47 ++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index a83842f05022b..db2ebd0393cf7 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -105,37 +105,42 @@ static ssize_t platform_profile_store(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> +	struct platform_profile_handler *handler;
> +	unsigned long choices;
>  	int err, i;
>  
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> -
>  	/* Scan for a matching profile */
>  	i = sysfs_match_string(profile_names, buf);
>  	if (i < 0) {
> -		mutex_unlock(&profile_lock);
>  		return -EINVAL;
>  	}
>  
> -	/* Check that platform supports this profile choice */
> -	if (!test_bit(i, cur_profile->choices)) {
> -		mutex_unlock(&profile_lock);
> -		return -EOPNOTSUPP;
> -	}
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {

You made guard() conversions in the earlier patch but for some reason 
left scoped_cond_guard() ones mixed into other changes still. Is there
a very good reason for that?

-- 
 i.

> +		if (!platform_profile_is_registered())
> +			return -ENODEV;
>  
> -	err = cur_profile->profile_set(cur_profile, i);
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +		/* Check that all handlers support this profile choice */
> +		choices = platform_profile_get_choices();
> +		if (!test_bit(i, &choices))
> +			return -EOPNOTSUPP;
> +
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, i);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
> +				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
> +					pr_err("Failed to revert profile for handler %s\n", handler->name);
> +			}
> +			return err;
> +		}
> +	}
>  
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  	return count;
>  }
>  
> 

