Return-Path: <linux-acpi+bounces-2694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6CF82312E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB2C1F2263B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CF1B29B;
	Wed,  3 Jan 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoNd9N9g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D401B297
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704298878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKc7F3NOX6qbkqAwn6M1c8OTuwE/sCZUfO8rou+B0Ts=;
	b=HoNd9N9gbzRQ07QI8iW0kWg8n3v3vwde2rfnL/+vyQvxUutqP+p3wHYCO+BApd8gUppdWF
	qlTQDotRcAfM3f4PkpKi+bUejOF0e/Iy/ZpYDJzN7Droo9waPKkegfO46S5i3l+bTqv+X5
	Y668vgrdhGObI1yV9PGjnd3UxHGkSFE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-LDGFpOCPNTO-S-lwws_Cgg-1; Wed, 03 Jan 2024 11:21:16 -0500
X-MC-Unique: LDGFpOCPNTO-S-lwws_Cgg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e8b929997so3461977e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 08:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298875; x=1704903675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKc7F3NOX6qbkqAwn6M1c8OTuwE/sCZUfO8rou+B0Ts=;
        b=H18EkR8C97ZAhzxrhDwHm2BCCPJLuTQxwhRcjlHBYFychCJuq6Ao8waMsHcst+UQMq
         In2DCzjTdAm6+wUd0ZsdNOsRogQLnSWk11gnDW9pIvC0cdQzeJm+DpJi4QkI37kzS+dS
         4SREtRNfpOaahAdRsH3dy+zBdEWqHZbhiy4qd9V6fZxQtz4FwusUvnb6Qe2Zeo4QtoR0
         01+zSHmuBBzoaEEeRMGyC6PKWMZS9ZH8c/1UlGzDJxan323hNgJoKMQ2Iz8Cmync8OBS
         M9cYI2EOdMmC2iOxYeGF1BJdRwkkxhBfXlLkNd31FeDPpUzJ2RD/qHQtsbmasxwXyaON
         xPZg==
X-Gm-Message-State: AOJu0YxkNu3tLw/8qkjku0yllnIPUiov8T/gea57Jk4ou9aJ/mJIJV0C
	6H6L7BBC6hBxMlPnw8RGboZXVOOPRLKNuyG/40kH2LcvysM2alsH60J5z4U8h87HopsL8ELMzS6
	d7NYCJT4uGHTjLHeE5e8uUS4gdD7/fg==
X-Received: by 2002:a05:6512:400d:b0:50e:64b4:a266 with SMTP id br13-20020a056512400d00b0050e64b4a266mr5407866lfb.201.1704298875356;
        Wed, 03 Jan 2024 08:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrSX9BuJ1bhRdSzG/tc2yGc7Bi1y7vuqdLp76RUT09o73fxagBvf53E0cpnvoErfRHCLOq8g==
X-Received: by 2002:a05:6512:400d:b0:50e:64b4:a266 with SMTP id br13-20020a056512400d00b0050e64b4a266mr5407856lfb.201.1704298874907;
        Wed, 03 Jan 2024 08:21:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a2697984204sm12819268ejb.72.2024.01.03.08.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 08:21:14 -0800 (PST)
Message-ID: <fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com>
Date: Wed, 3 Jan 2024 17:21:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: resource: Force irq1 edge low override on
 Infinity laptops
To: David McFarland <corngood@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20231230150916.1843117-1-corngood@gmail.com>
 <CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
 <87il4a4ipc.fsf_-_@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87il4a4ipc.fsf_-_@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for your patch.

On 1/3/24 15:03, David McFarland wrote:
> A user reported a keyboard problem similar to ones reported with other
> Zen laptops, on an Infinity E15-5A165-BM.
> 
> Add board name matches for this model and one (untested) close relative
> to tonfang_gm_rg, due to the board names' similarity to GMxRGxx.
> 
> Link: https://lemmy.ml/post/9864736
> Link: https://www.infinitygaming.com.au/bios/
> Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com

This patch seems to be based on an older version of the kernel.

Please base this on the latest code from:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/?h=bleeding-edge

There is a single DMI match table there now for all AMD
laptops named irq1_edge_low_force_override[]

Which has a bunch of new entries, so your patch will not
apply cleanly as is.

Regards,

Hans




> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 297a88587031..6b64ea4e9c80 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -484,6 +484,18 @@ static const struct dmi_system_id tongfang_gm_rg[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>  		},
>  	},
> +	{
> +		/* Infinity E15-5A165-BM */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
> +		},
> +	},
> +	{
> +		/* Infinity E15-5A305-1M */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
> +		},
> +	},
>  	{ }
>  };
>  


