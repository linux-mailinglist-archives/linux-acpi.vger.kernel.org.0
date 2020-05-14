Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA91D3F53
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 22:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgENUwp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 16:52:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35191 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENUwo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 May 2020 16:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589489562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q55k+NViBEr3XjFkn4cYhpApbbfsFdYvtgAG+Rf+WYU=;
        b=H1sVqOySobNG3L6yYIdbM7pjR+lwO341gWI0n5xwmPDHY4HFO8DhYVGRgw67CZBDBQ47m0
        dxAm2TOEk2eglheNrmfa2bH9OgaDeH7C1N0ftmiOhBP5AfzLk8jEover9jdqT+OASmGIDk
        Qt2pHXcHIKpRvkxOrDol3bCvyJGl4x4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-2ysGOGPQPVikkpGbkPiBtA-1; Thu, 14 May 2020 16:52:41 -0400
X-MC-Unique: 2ysGOGPQPVikkpGbkPiBtA-1
Received: by mail-wr1-f70.google.com with SMTP id d16so16802wrv.18
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q55k+NViBEr3XjFkn4cYhpApbbfsFdYvtgAG+Rf+WYU=;
        b=RiQ2Bbh2kNd2jRkfTs8n9nFa8O99aKB5oHMl5Bf4q/yG5E56cJGs/4DbohVum9JCDI
         SEmhjvfa0t2v8PXbAYqs+xqfoQJbPbHuL/V5Y/3p2qV8nqHGKdUol+ATeK7ZXcqCrHHB
         lkr9nFUK/T++J+FjTcsBP3g3HLtwnG/5KexZxtMxcQj0Otgsd11yKUDtdGO958B5FVs2
         N9lJ5oqL6NrnDCcBdGNrhLwgAK7vfxsAKVIN6K3DmOQ/vdwQw0dqEH1Le1d4rEhxkGN4
         L8XV0ZA9zqaP1AfvhPDylzAyXmx+q8DU9QGfgpPZVoGzxuHBrpHVEgtx5lpb5VsXI+OU
         gUpQ==
X-Gm-Message-State: AOAM533sNUquDDoQUYoMSEPIT6yiSotzD6pIIeXwU8Pku9QA+s2OOkT+
        GmW9bi2m5AcUMT835HuAE3rqu//oOf7qx63USuY3pCPcL97lrJbZflX5HmJojHgRVuZuC8s8k6Z
        WhNiRqc7A2eX7Bu7hnoQYDw==
X-Received: by 2002:adf:8005:: with SMTP id 5mr287463wrk.423.1589489559820;
        Thu, 14 May 2020 13:52:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtahtSTzZR5s3kD2mzB5noFu3QgzM7h/ym3uEImZ2BS+EMA9kFp0ogYToAXTjsXwIUT/ydMQ==
X-Received: by 2002:adf:8005:: with SMTP id 5mr287445wrk.423.1589489559564;
        Thu, 14 May 2020 13:52:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l13sm196990wrm.55.2020.05.14.13.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 13:52:39 -0700 (PDT)
Subject: Re: [PATCH] Input: soc_button_array - Add support for INT33D3
 tablet-mode switch devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
References: <20200514205134.136782-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e67205a-abfa-141c-ed74-d0359e5be0d8@redhat.com>
Date:   Thu, 14 May 2020 22:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200514205134.136782-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This should have been 2/2 of a set of 2, let me resend, sorry.

Regards,

Hans


On 5/14/20 10:51 PM, Hans de Goede wrote:
> According to the Microsoft documentation for Windows 8 convertible
> devices, these devices should implement a PNP0C60 "laptop/slate mode state
> indicator" ACPI device.
> 
> This device can work in 2 ways, if there is a GPIO which directly
> indicates the device is in tablet-mode or not then the direct-gpio mode
> should be used. If there is no such GPIO, but instead the events are
> coming from e.g. the embedded-controller, then there should still be
> a PNP0C60 ACPI device and event-injection should be used to send the
> events. The drivers/platform/x86/intel-vbtn.c code is an example from
> a standardized manner of doing the latter.
> 
> On various 2-in-1s with either a detachable keyboard, or with 360°
> hinges, the direct GPIO mode is indicated by an ACPI device with a
> HID of INT33D3, which contains a single GpioInt in its ACPI resource
> table, which directly indicates if the device is in tablet-mode or not.
> 
> This commit adds support for this to the soc_button_array code, as
> well as for the alternative ID9001 HID which some devices use
> instead of the INT33D3 HID.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/input/misc/soc_button_array.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index e3a22a61f5d9..837c787e9c4b 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -397,6 +397,15 @@ static const struct soc_device_data soc_device_PNP0C40 = {
>   	.button_info = soc_button_PNP0C40,
>   };
>   
> +static const struct soc_button_info soc_button_INT33D3[] = {
> +	{ "tablet_mode", 0, EV_SW, SW_TABLET_MODE, false, false, false },
> +	{ }
> +};
> +
> +static const struct soc_device_data soc_device_INT33D3 = {
> +	.button_info = soc_button_INT33D3,
> +};
> +
>   /*
>    * Special device check for Surface Book 2 and Surface Pro (2017).
>    * Both, the Surface Pro 4 (surfacepro3_button.c) and the above mentioned
> @@ -459,6 +468,8 @@ static const struct soc_device_data soc_device_MSHW0040 = {
>   
>   static const struct acpi_device_id soc_button_acpi_match[] = {
>   	{ "PNP0C40", (unsigned long)&soc_device_PNP0C40 },
> +	{ "INT33D3", (unsigned long)&soc_device_INT33D3 },
> +	{ "ID9001", (unsigned long)&soc_device_INT33D3 },
>   	{ "ACPI0011", 0 },
>   
>   	/* Microsoft Surface Devices (5th and 6th generation) */
> 

