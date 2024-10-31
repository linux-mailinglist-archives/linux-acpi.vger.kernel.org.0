Return-Path: <linux-acpi+bounces-9186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1BB9B787A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82591F21A31
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D7195F28;
	Thu, 31 Oct 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwOOnEz7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B813A25F;
	Thu, 31 Oct 2024 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369750; cv=none; b=d6L3Vq8LNHXxGelvuiC9FzhkUsBN57JSCb2Rl2f5YxWO2ipaNLZii56LfQ15q1dj9ZAPzWH56NOa4toU0zNM7Ruxd0KD2nxww8Bl7C4JgOYNa8R3VOI1sSSvffmpAdQ5zS0JWHaeiuesyRZRqGWo7S/Rx5jxDdAnfc7yescxx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369750; c=relaxed/simple;
	bh=XCXgN4lPnIAPqejxYbv7v0HSBCur4c0ci9vAjAXjYSo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zveg86DjDjIDcts0b8mzsLXn0ZGbskKoG6KS2pzEKWFViPo67ubvu4kBfNjYjMJlDzR2q7jUN5y+/n4Um4Iks0m9a4vN6ikU5tmqJIwWNY8abZFuqrloGIHwn94tff+/Q2dwVQkJaQu6MP8xabMMOU0WpKuYn8Y7d6BI7QPpmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwOOnEz7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730369748; x=1761905748;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCXgN4lPnIAPqejxYbv7v0HSBCur4c0ci9vAjAXjYSo=;
  b=NwOOnEz7qO+HT01IxotFTKH7TN2Holx+9SbJOb1O80qPkXFtz8OTPFUZ
   3X+syTHENhXXtznm5iGuG/MT9jYTsLW6P7nHj5oDcXDBUhfZVHyFqSijl
   pla/xX0MlSYm4SAQcGt24YmifPNNSRNzxflBObhjJlbS0N3u7nrNdrYjh
   QK/1zgTIPS//lD/EpI79Bx1Rl9ljrQ/z1F/PA/yrt3iR+p9fTvpif6b+P
   0MQEvAoguIlK1t2vWZUiHL1fYknnAL+3gz97NKa3vXgfIPkPW1pGo/4uz
   1V728KzCayqirJxSiSaRNGgZVEIou/D4NAcKgQPZ15X+dDaZotRc8Nba7
   A==;
X-CSE-ConnectionGUID: +Zt7EsOgQ8aFhdSxvHyidg==
X-CSE-MsgGUID: 0BwvzwlQQx+YCFV8tGZQOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30265468"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30265468"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:15:47 -0700
X-CSE-ConnectionGUID: O5pELUPfSdeP+n0yEBPT+w==
X-CSE-MsgGUID: se/5rftLQm+9b55fu3U2eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87184783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:15:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 12:15:38 +0200 (EET)
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
Subject: Re: [PATCH v3 10/22] ACPI: platform_profile: Use `scoped_cond_guard`
 for platform_profile_show()
In-Reply-To: <20241031040952.109057-11-mario.limonciello@amd.com>
Message-ID: <64f0b33b-3345-d9a6-d174-2a823adee216@linux.intel.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com> <20241031040952.109057-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Oct 2024, Mario Limonciello wrote:

> Migrate away from using an interruptible mutex to scoped_cond_guard.
> Also move the sysfs string match out of the mutex as it's not needed.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'd have expected all the mutex_lock_interruptible() -> 
scoped_cond_guard() changes in the same patch. Although this also moves 
the sysfs stuff out which in this smaller form is kind of okay but if it's 
part of larger patch merging all scoped guard conversions, it should be 
in a different change.

-- 
 i.

> ---
>  drivers/acpi/platform_profile.c | 36 ++++++++++++---------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index b48dd34301f13..63a5f5ac33898 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -75,35 +75,25 @@ static ssize_t platform_profile_store(struct device *dev,
>  {
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
> -	if (i < 0) {
> -		mutex_unlock(&profile_lock);
> +	if (i < 0)
>  		return -EINVAL;
> -	}
>  
> -	/* Check that platform supports this profile choice */
> -	if (!test_bit(i, cur_profile->choices)) {
> -		mutex_unlock(&profile_lock);
> -		return -EOPNOTSUPP;
> -	}
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
>  
> -	err = cur_profile->profile_set(cur_profile, i);
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +		/* Check that platform supports this profile choice */
> +		if (!test_bit(i, cur_profile->choices))
> +			return -EOPNOTSUPP;
>  
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> +		err = cur_profile->profile_set(cur_profile, i);
> +		if (err)
> +			return err;
> +	}
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  	return count;
>  }
>  
> 

