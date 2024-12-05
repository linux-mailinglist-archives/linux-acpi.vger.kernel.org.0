Return-Path: <linux-acpi+bounces-9945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86E9E5868
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8A281CFE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102421A425;
	Thu,  5 Dec 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7L4gMkV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE341B59A;
	Thu,  5 Dec 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408592; cv=none; b=UbZWPXIg+vv2NqwnklP1O2/TRFXgwIpYreF0ksc/MYHSFb5gcmPLJ4uuIFvfHGWb/BThFz2ww5rXUDCRx6/bSeysReTfLMOktQkRhwS2MSpcCQY/I6ZRX3DJW3r+uztairQ5TUpZpNF+vhMfxkocCYRgY4dbazaeoolMuGWgcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408592; c=relaxed/simple;
	bh=KV0cBHy/QqFDgX3uFP6QgbhHS3lUE5VEmKJ05QIhPEI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BjNdQulewL1FOnIq2+yOfOnqmaS8oLWZ+pdHTC250vwAlWm8K5BsBeYlcpXo2gSHuyMJXKYNVD5xr+vgLpw0CrQJaToTRZMmAn6yum3l5HO1VUGuX0tlrwwEPDL0vqthGDH3NBx4qxPTZndRfkGHVoHkd+0c5b9iqJbSqpmgkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7L4gMkV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733408591; x=1764944591;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KV0cBHy/QqFDgX3uFP6QgbhHS3lUE5VEmKJ05QIhPEI=;
  b=D7L4gMkVWhw3ETMmxGXwRuw44Rqk1TLKeCBqO4o9nUtyo96gx7Vrr1Ve
   w5I2jQPBUd45q2LycVKsVdnQlAcWaWcfPQz1vRMuhvocf7Cv4JQMHSxSJ
   mGA6wD3ytWwMXmJA66gYl6IOpX6b1MPDtb4ynC9OjC4xhaeqBPBlQutG5
   3cnsUYWte19bjUw22GmjMiAmT/mC1LMl/g86gZW+O7Jl4HgwozYhze6nt
   N5eQKSPnaDLeAwyhbhzATtZrdZKUA76ZKlcifb6PWLwX3HIujTCCTllVO
   uqr95wi29U0Pzo2x0Xqp51DwJD1iljOTqHMbcjqp/KDGBNqvdxDziHPuR
   g==;
X-CSE-ConnectionGUID: I9hgzMASRlOlY/LWgTG9dQ==
X-CSE-MsgGUID: jVG0HtapTJKGtPEMF9UPdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="21308541"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="21308541"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:23:10 -0800
X-CSE-ConnectionGUID: PmBgtXJ7Rr6Xz8L0Q3KGPw==
X-CSE-MsgGUID: iowx0A/aQ0yUaXxZzCnpPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94302147"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:23:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:22:59 +0200 (EET)
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
    Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v9 18/22] ACPI: platform_profile: Check all profile
 handler to calculate next
In-Reply-To: <20241202055031.8038-19-mario.limonciello@amd.com>
Message-ID: <fc57acd9-396c-e047-12c1-14836e477d14@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-19-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
> 
> Check what is active and supported by all handlers to decide what
> to do.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d5f0679d59d50..16746d9b9aa7c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -407,25 +407,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>  
>  int platform_profile_cycle(void)
>  {
> -	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> +	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	int err;
>  
> +	set_bit(PLATFORM_PROFILE_LAST, choices);
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +		err = class_for_each_device(&platform_profile_class, NULL,
> +					    &profile, _aggregate_profiles);
> +		if (err)
> +			return err;
>  
> -		err = cur_profile->profile_get(cur_profile, &profile);
> +		if (profile == PLATFORM_PROFILE_CUSTOM ||
> +		    profile == PLATFORM_PROFILE_LAST)
> +			return -EINVAL;
> +
> +		err = class_for_each_device(&platform_profile_class, NULL,
> +					    choices, _aggregate_choices);
>  		if (err)
>  			return err;
>  
> -		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> +		/* never iterate into a custom if all drivers supported it */
> +		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);

I'm confused by the comment. I was under impression the custom "profile" 
is just a framework construct when the _framework_ couldn't find a 
consistent profile? How can a driver decide to "support it"? It sounds 
like a driver overstepping its intended domain of operation.

If the intention really is for the driver to "support" or "not support" 
custom profile, then you should adjust the commit message of the patch
which introduced it.

-- 
 i.

> +		next = find_next_bit_wrap(choices,
> +					  PLATFORM_PROFILE_LAST,
>  					  profile + 1);
>  
> -		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
> -			return -EINVAL;
> +		err = class_for_each_device(&platform_profile_class, NULL, &next,
> +					    _store_and_notify);
>  
> -		err = cur_profile->profile_set(cur_profile, next);
>  		if (err)
>  			return err;
>  	}
> 

