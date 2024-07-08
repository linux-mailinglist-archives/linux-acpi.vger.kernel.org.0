Return-Path: <linux-acpi+bounces-6803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E51929FF6
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319AD1F250CD
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229C76F1B;
	Mon,  8 Jul 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Asr93hDn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CE78C6B
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jul 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433607; cv=none; b=nXodLXWFAOWMkwok1HCBIItXccw8XjJa3i3nZpOcEnEJbm+c9vodNBuQlKo5h19xI78bth8AfJYTP0PMf+/rYvaYP38LcSJq+WpeIFfOoPa6iDGgbRt4gd58XUofreWkfNW0YXOK9jPpc7rjnBOFvUmzGI0uaGNJcuaGOr9Pg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433607; c=relaxed/simple;
	bh=y6dqBqOENd6UqWyt7+MMtufQwArRT0fZ1eNZ2YYAgSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGjwjQyJSt7jdbuEofHnlypKAsUjOY9xhrCinF6HVv5qjbxjLJ2+/GbgxuuT21Kd+fEEAEWhcJJ4aDfIgSVHq+/iKCiMxFmgkQ5sIqzt/0Ds6vC5wstfBuWLTgBMd+VhDlo1cXWXVzb7SyruO7se7V0RoaU3ek0w8j0c1AQihZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Asr93hDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720433601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq4i8tkGqnPmW+VQcfJOnDtTidOU14j4o+JFRh6Zy9k=;
	b=Asr93hDndFdyp+cIVuW93y4Mj8aOtwJagTmEV1CqGXmf7umsyAQ41sAAbRRUGf/yAy0pi/
	+GYZCMpky4L7Smq21VUp3EDXkZhFmItgOBIeUa9c2OJokAoo+nTMYqhbfx2Rgm4Puh+zSF
	oH/1ZQ/6GR6XhfVE744t1Z8OERg5IO4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-6svxzaNOMYaGrn1HfKvk8w-1; Mon, 08 Jul 2024 06:13:18 -0400
X-MC-Unique: 6svxzaNOMYaGrn1HfKvk8w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso31197081fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jul 2024 03:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433596; x=1721038396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq4i8tkGqnPmW+VQcfJOnDtTidOU14j4o+JFRh6Zy9k=;
        b=rXT+1IStmsCSMNKTEjHBKwoeghrZONZUKZvAYY3Hpb1oOTfHmMS05m568GTC9Ni1Q5
         1HTdBqG2A7nSdCPXsxSKN4xeYUQhEqJ+oIETciQtM29T/Ncd9gb9a4eCx4xFFbuXhA9P
         STunL/rZ97o5FBw8XZKfNpv+H8ax+qx/0RYNqa3M9R/BDtOU93VwuzMhOczUw7Znnt51
         EKeTO0Xx4vMZQBsOMPvPMQ87kl1taxFTVAyoFRAvuNedy//vJgHXrmPDrDusRm1Azure
         7i9XPJW0MgKpyJ/rKyAFDp0FWVDA8eN9RcUi9Ca6u8Cj/PvKqGiflawe8Vpbn91V7mPd
         XLrw==
X-Gm-Message-State: AOJu0YxnNP9hFg0QWPLRRFojoBBbHTjwb8sPdVH2mUMlenXYsrMoJDdz
	p/Tmu4h/zB9//xaIerM2fwrwsEAGXfQcpz1DyGD04w5griFzgawKfnW621o3VSZcqrdA3vMJUvp
	PAMmrZ3TqrlrF/7YwUXCvuqGHTQpmwmAkNQTFq45QVnHg5jhhTqJ9Ar08/ak=
X-Received: by 2002:a05:651c:114b:b0:2ec:3dd4:75f4 with SMTP id 38308e7fff4ca-2ee8edc23d3mr87781821fa.38.1720433596518;
        Mon, 08 Jul 2024 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGToWaHMDwnE+0LYJZlu71A2tXExVAesgAxkzanSdp2VXAZygrzzoU3ofCUOmJX18NzvdXxw==
X-Received: by 2002:a05:651c:114b:b0:2ec:3dd4:75f4 with SMTP id 38308e7fff4ca-2ee8edc23d3mr87781641fa.38.1720433596129;
        Mon, 08 Jul 2024 03:13:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58de4581536sm5537092a12.16.2024.07.08.03.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:13:15 -0700 (PDT)
Message-ID: <b2f69fb8-d87a-4cf4-8d45-11cf1a396e54@redhat.com>
Date: Mon, 8 Jul 2024 12:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi video: force native for some T2 macbooks
To: Aditya Garg <gargaditya08@live.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>
References: <3DA0EAE3-9EB7-492B-96FC-988503BBDCCC@live.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3DA0EAE3-9EB7-492B-96FC-988503BBDCCC@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/5/24 3:56 PM, Aditya Garg wrote:
> From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> 
> The intel backlight is needed for these, previously users had nothing in
> /sys/class/backlight.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 442396f6ed1f..baf7264d7b94 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -513,6 +513,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Apple MacBook Air 9,1 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
> +		},
> +	},
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>  	 .callback = video_detect_force_native,
> @@ -522,6 +530,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Apple MacBook Pro 16,2 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
> +		},
> +	},
>  	{
>  	 .callback = video_detect_force_native,
>  	 /* Dell Inspiron N4010 */


