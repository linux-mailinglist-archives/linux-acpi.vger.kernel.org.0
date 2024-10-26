Return-Path: <linux-acpi+bounces-9005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567209B16E6
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1909028347C
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701B1D1E91;
	Sat, 26 Oct 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grn5zq3T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD21D0DE7
	for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937261; cv=none; b=pn3uxdfJYQuF91R/6xwEShXIZvfGe+VYpOU6XhXPA//FgThQiQfyJabYPo88MZwVpc6pDj0yvwNoaD0apRt2FVXGBrjyaKFiWLNzM5mgUq/WW9gw80mpEm6PweLhakTwuajCBhF+3WbBrAnRPx+CDD7EUQNV14rojzkQEyEfpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937261; c=relaxed/simple;
	bh=KBmP0nO8LLhW1rNmvh8diNerp2LuvfZNzwxEdjqWeho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmuYJ13cSwnryFjn6B3vuFa9FVwC+TAsiL2NhdT5LlZ1l3Fiel04DNcPubbKrrlF6uacuobg1tuHs0JC/vi9xNFkRF0hK0546mb3mUEfFHHxpfuglVI5f1y6NcE3wkmgyv5+tGBCa2ShagZZaAGYM3ARBCIlikWLy6yUCpd67y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grn5zq3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729937258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86pihVpFCTMFYss1/Iltby9/esixmfhGJjvS5+uk3X8=;
	b=Grn5zq3TPRQzst72tWSuS9rUuthMZF7xgF6BeE/ZeSew+pv3YWDoZX5JV7ay2tAwisEE48
	K4CR4Ofwxn5yYYkqhqmhzfIw7pXPEkrKDFTshn+E2aoh1hjUhGZ6sZrLQOF98S8x/bdd0h
	nE3Qjes4YwxzSRYiu0fCmLk3AUcYC/U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-4gvlDWXDPFGUAuV0dvbTow-1; Sat, 26 Oct 2024 06:07:37 -0400
X-MC-Unique: 4gvlDWXDPFGUAuV0dvbTow-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c91d498e4aso2018928a12.2
        for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 03:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937256; x=1730542056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86pihVpFCTMFYss1/Iltby9/esixmfhGJjvS5+uk3X8=;
        b=ZSPbgXCb1W71pBOT+01APjAyZFluLtfoMzNQMkHYNTXMvHq/EnFTZPa/mCuVm/ZNPa
         Du6f5tl1zod9A8Y72k+BNajTkagba20TwVyoloSt30wiFmujB3Gw1GPrhuAzhKWCyuil
         2lfpNBRoXR7Szp4oqkXOGDk+q5+uA7snhwQDVfooX5cxT7EHJ2a9pUvfZrdqJOkMS67s
         P6kDJoFocmKYJSVYz+t0rkrCxTZgS5iTr3iUhwDzfLFuvdbDG8nWMBYogfMyaX7l0Qnj
         Z+V4RuwTxen36lzR/M3E53lQ0PyW1d0cEQYwQgcceH0pyogGRdtiF0jOX/KZifbD52qR
         U/NA==
X-Forwarded-Encrypted: i=1; AJvYcCVzKI5wpRU5i3e+dkix9KgZKLQuoWReIbpMfmOF3oaa/COcDCDs+R2rVnx7wedvYo/6RgskptVD8ems@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+1+Cuckq72I2TvBBTgP/NfFIvBExpuwocAIlrF6OPTUbLsfe
	TTEz+dVX88osA76DkbGEEXBVlEMRw47w5ZfZ1ztqWTwR1/jJ+/wy/mR+RCRzzKpeKFUVLu+1LVl
	6s+Vf1EKMacaKKtTic20c5rXDD7vhaTij5DUWlnolRg4rHHOxrBSykOLsyvA=
X-Received: by 2002:a17:907:9727:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9de5f2226dmr168738066b.30.1729937256113;
        Sat, 26 Oct 2024 03:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGugRUzTiO3bQ3RT5C4neQOCWw/sRdC3diGmPwKsQoYtVGLDDEjNj2gnVCayaCXt7maanra6g==
X-Received: by 2002:a17:907:9727:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9de5f2226dmr168735166b.30.1729937255762;
        Sat, 26 Oct 2024 03:07:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298cfsm159302066b.74.2024.10.26.03.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:07:35 -0700 (PDT)
Message-ID: <e302a05d-cea1-4004-8727-8beee52dc112@redhat.com>
Date: Sat, 26 Oct 2024 12:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
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
 <20241025193055.2235-6-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
> guard(mutex) can be used to automatically release mutexes when going
> out of scope.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



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
>  	cur_profile = NULL;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);


