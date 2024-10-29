Return-Path: <linux-acpi+bounces-9062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF99B4657
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF11C223F7
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050B92040A9;
	Tue, 29 Oct 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4SvFlsR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F6202F60;
	Tue, 29 Oct 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196154; cv=none; b=hhCDnk+e0CStpo+g8nLhcx5uyWtbHRhdAjdMG9kxl5Oax1YYynqQMb2ozo35WEUdpghAM2lid6A0oxDKb+E4dYf62zKLbTKyACk6cWomar/xuS3JFTixbNrsn69SaPagf/Ef/jGA2Fkd+GwkziXXd0g3rFL3bQvE9/7ONz9sdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196154; c=relaxed/simple;
	bh=g9ZR9Ezt8kCYuxS/WaxVjYkpIMrorDHTgIdNQ40j2hE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sci7twDgdv0GK6ccvy/nVuBlnpP/PqlFGGkz4VayRJZS44ldPh+QpTNIb4CyOyveqlzaGj/3PXg74480TwsyriToT+vpLz/HF2WRueO4MJrZgMBrh26tXp3GxIvaMr+z+2J9Xs9eoHrEXRSHjcKufoRpyUJmBAk98Dc2JLWE5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4SvFlsR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196153; x=1761732153;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g9ZR9Ezt8kCYuxS/WaxVjYkpIMrorDHTgIdNQ40j2hE=;
  b=R4SvFlsRjDSQhCNSQO5UdY4bucQMqcDsJndLOir9gu1OGoQCEbKhDgnM
   Y2dqdlmISm0feFKQ1YY474YHqspXzqhp6C3m7oO1e0tsnw6e7X4McxUtg
   kXGP+ZSGWEo2syh1XedmSTCd7WFtQshx2nLuc/xAUm46rtS90FdrCWMyH
   KnkJtgj66qFA7XiZbVLTjtdkQJKX+CGJta4DGT4x3ydwqluXO4tRyYIic
   FEhuBeCV2KaLXVw7NcolCq2u6zbHT737hhnKWxdkfzOQwsTLCYHQ3x2Ak
   8O6pxETRnyUMmTP6HdszvXUnSRZjmtwq+Op20AKsFboXI3VtRocwWDjXg
   w==;
X-CSE-ConnectionGUID: /9ztBeH4R9yr2wpuyzee7g==
X-CSE-MsgGUID: 0+uyvX+7Q7SmQOOjI4lH9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29258073"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29258073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:02:32 -0700
X-CSE-ConnectionGUID: vAlrW39WRIGWp21SRP2voA==
X-CSE-MsgGUID: YNC1vL+CQGqImeu/WZH2MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82055051"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:02:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:02:23 +0200 (EET)
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
Subject: Re: [PATCH 5/8] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
In-Reply-To: <20241025193055.2235-6-mario.limonciello@amd.com>
Message-ID: <3bd91a7f-f9d4-fa00-f254-5caaddbbe18a@linux.intel.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com> <20241025193055.2235-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Mario Limonciello wrote:

> guard(mutex) can be used to automatically release mutexes when going
> out of scope.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 0c60fc970b6e8..81928adccfade 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -180,41 +180,34 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  	int err;
>  
> -	mutex_lock(&profile_lock);
> +	guard(mutex)(&profile_lock);
>  	/* We can only have one active profile */
> -	if (cur_profile) {
> -		mutex_unlock(&profile_lock);
> +	if (cur_profile)
>  		return -EEXIST;
> -	}
>  
>  	/* Sanity check the profile handler field are set */
>  	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> +		!pprof->profile_set || !pprof->profile_get)

Could you please also correct the misleading indentation here while 
touching the line.

>  		return -EINVAL;
> -	}
>  
>  	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> +	if (err)
>  		return err;
> -	}
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
>  
>  	cur_profile = pprof;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
>  
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +	guard(mutex)(&profile_lock);
> +
>  	list_del(&pprof->list);
>  
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> -	mutex_lock(&profile_lock);

Now this something I don't want to sneak in with a transformation change 
like this. What is a clear extension of the critical section should be in 
own patch with proper justification given.

If that was not intentional, you can sill place guard() where the original 
mutex_lock() was, it doesn't have to be on the first line of a function.

>  	cur_profile = NULL;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> 

-- 
 i.


