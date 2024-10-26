Return-Path: <linux-acpi+bounces-9004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B59B16E3
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 12:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DFC1F2294F
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9381D27BF;
	Sat, 26 Oct 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGlO7bOX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539F1D1F70
	for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937248; cv=none; b=cpqeYuZlzHE5Zg7V5WHpNnGksO9hPTJheNCcziVpggNG5/112h/X8qU8Srp/6gNFTV0NpeqXPzJyF0F5DjekXQbGDBx/vmzyJspYFVV8FHKFBezKUhvvEOiZQKC6xnK3N+IahxpEtkXxQXedxQPNkOJq+6RsgyrD1VK1taB3Skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937248; c=relaxed/simple;
	bh=VO9AbrOdA0msDkWqGRKaTRapJpiYZcNyx8a1W9Z6wr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBBCeNFDkTplBhaKF2IQb07c0nr+mR4pk8of928of+NshDMPbiBavapqmOAeocEcjwIn3lfQ8WzmsEAlZWlPrwibFu/vKJzcuunM/lPOExbV4hlwhH9JO2GihRh5FppbJtbv0TR02WNPaRspMDdWVfSid/Rq2oRHxh35iSR1LyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGlO7bOX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729937244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJlGYIZ2ZF/J/o37/9Owky4ZqndhKDqZ37hsXKaaOtI=;
	b=TGlO7bOXDnp5m1M2Rb6qgPHN+GykjAIDFhVmD+MrsViWuaB8PZqL2PWCNV4pcuE6ePDTqU
	uywWebwDgb5swoefxxsnTr7zmGmPfihfcX7nFPSVMl5F4qKZQDJHuG+38g5LKj1V/z0QQN
	c2/Ka2wwLx1N9Qq6lZgwCt8olnTPKuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-IvLasM1POhyEugOVtya53A-1; Sat, 26 Oct 2024 06:07:22 -0400
X-MC-Unique: IvLasM1POhyEugOVtya53A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43159c07193so25567625e9.0
        for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 03:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937241; x=1730542041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJlGYIZ2ZF/J/o37/9Owky4ZqndhKDqZ37hsXKaaOtI=;
        b=R1mSTERPjRXiCphD/m6BWf91VV7ppgRvWCVyA85aDR10AHLiyDp5OmzNNCzi2Sm//0
         x6Fx/XRp/8ZV3eeEnJTLRBwQX1PWa3BgiEIxI9GC0ymCqAbivWH10lfPS6hvf/rZvu92
         RxDyW/00a/yK7djJJGXPM9bff74HVrQPhkqzgXkILR8u8HcFuYsQQbOE2cCAtP4dryVV
         H6vWumcwogwpTX3diJdgAvDoc80oV7+n2ze6YdmG0z/fr+fkTE41rrw6gPT65Lm07B/n
         Ki9ApdySJaqJvNLUrJpt8OHiPRYEv110KyU6QJNjJv36S2hzp29Pvo0Qakq8jNgrOaaU
         0eIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGM6IQvxPqUBeCq7OPl9gP66ypYd2Vf20Ot+KRD1CORN8rb1RPJQyB6wMAIrBok4xh7AKggplQkC+B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EOBKP8zd/70Dyf0RWy/VeqyTa3F0R8gNytWJoRg0lLP99mEK
	SOQYGZC1X9v5hJ9nxPC/2rBccJh8/QgrZ8hs8r7qa1DA1FELTZVgxf6pcdI3G4mQdOgEfzac/zy
	5Fl/2OYvzm0A/JsL0TBHzA4D2zCZPBWkHevzAe0GwSPmxZr4FIiG4VYMGrOU=
X-Received: by 2002:adf:ff86:0:b0:37c:d2e3:1298 with SMTP id ffacd0b85a97d-380612475d5mr2002241f8f.55.1729937241350;
        Sat, 26 Oct 2024 03:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWz8jQCbczQY1pIa/BTZuS+AN8DQuG9MqmGw6yTkV5fY3mqJbhjU3xrUt8/z0htouCksMjtQ==
X-Received: by 2002:adf:ff86:0:b0:37c:d2e3:1298 with SMTP id ffacd0b85a97d-380612475d5mr2002195f8f.55.1729937240932;
        Sat, 26 Oct 2024 03:07:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0277b7sm160237066b.50.2024.10.26.03.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:07:19 -0700 (PDT)
Message-ID: <dc490fa5-c02b-46d9-a9ef-271181756407@redhat.com>
Date: Sat, 26 Oct 2024 12:07:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ACPI: platform_profile: Add a list to platform
 profile handler
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-5-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
> In order to prepare for having support for multiple platform handlers
> a list will be needed to iterate over them for various platform
> profile handler calls.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/platform_profile.c  | 5 ++++-
>  include/linux/platform_profile.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c24744da20916..0c60fc970b6e8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,6 +10,7 @@
>  #include <linux/sysfs.h>
>  
>  static struct platform_profile_handler *cur_profile;
> +static LIST_HEAD(platform_profile_handler_list);
>  static DEFINE_MUTEX(profile_lock);
>  
>  static const char * const profile_names[] = {
> @@ -198,6 +199,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  		mutex_unlock(&profile_lock);
>  		return err;
>  	}
> +	list_add_tail(&pprof->list, &platform_profile_handler_list);
>  
>  	cur_profile = pprof;
>  	mutex_unlock(&profile_lock);
> @@ -207,8 +209,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>  
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	list_del(&pprof->list);
>  
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	mutex_lock(&profile_lock);
>  	cur_profile = NULL;
>  	mutex_unlock(&profile_lock);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 58279b76d740e..9ded63a9ae6f1 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -29,6 +29,7 @@ enum platform_profile_option {
>  struct platform_profile_handler {
>  	const char *name;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	struct list_head list;
>  	int (*profile_get)(struct platform_profile_handler *pprof,
>  				enum platform_profile_option *profile);
>  	int (*profile_set)(struct platform_profile_handler *pprof,


