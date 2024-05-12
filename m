Return-Path: <linux-acpi+bounces-5778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B78C372E
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C76E1C20908
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2E2A1D7;
	Sun, 12 May 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0faHKEc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EA134A9
	for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529489; cv=none; b=GwOk9p40XLx64JNlH5FM9UXMJJpbVgS8ktFSJ2fGDkXBhlPdVw6apEUZF2CqQWx6vTwAw508F8J7WoRNgBKixxtfIwWgHfuugq1fFR1SY9YpuoW0nBvs4CEhslYM3cbwufMlDis79KR/n2nO/dAi7jbqYHWYOya+hUcrUU/rBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529489; c=relaxed/simple;
	bh=6DbYnzIFGrbTOFOk8pgrtEKJWoUwQ5I7d7RCwvP5NtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxEVb/U31rvbrPxIeMYcLT+OYkElolvi6yL+ttMLK5VCtkR+SZ0ZScsvJwkE2LKJeT3/Al7mgdxZKc08asam7lXnlPN85ngVA67XfswOTNn1kVazEkdkI1BmXrY06Bas9si3MM91I7CTiynwKt8PNZIgRdoMtNZXv49STDghx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0faHKEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715529486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZBZiOcNe8EIgu+CG7qX8ktQnD/prtftZY6a4rTKYoU=;
	b=a0faHKEcR0zq77gLVwcvaUTNHs184c2Gd8H4whDufe049ScJQGnBrA2HkztR5u0OaVx77X
	dmAxFNfyOyIeJwRqchS+qxb4yY0iSBa2XD+ynQZow3gpPcHlTfQ3y7o1Q4Dx4vS0gK1FPs
	2b0HpBf2wb98GwEzFVY1UPciHxV5l7s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-DrtHhNTUPJ-Pb5DhrfQ5lw-1; Sun, 12 May 2024 11:58:05 -0400
X-MC-Unique: DrtHhNTUPJ-Pb5DhrfQ5lw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a59fbf2bacaso242582766b.0
        for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 08:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529484; x=1716134284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZBZiOcNe8EIgu+CG7qX8ktQnD/prtftZY6a4rTKYoU=;
        b=ttEgUMtggvgfHj6w0WQTKztdp8fWUOgMO6S9PO8iaYJriLQbOTjZxx6lygZp7PwamU
         SMJx4TCdqiS2rJkuVeiTaKral1WyHpfsgGwdLo5GHo/XZ3p9h1/fSvNIsbUQ5+d5cL9F
         0iu7Nu561iw6bK7xm+uzcuSNal63JbSz/XTHi/nBMkPoSoXKyIzWlrzYPvxrkPYjf486
         9IJQ7xiqTwCpCO+g3LEmCCPkx/eIezxuGlC81CwRPvqRMCtp/yUv0z6xi7vUhrDHiv8J
         uRqAUFCdkF6zy8FsqnMnWpAwn4vHaPX5omtV7w5frStDZfLFCH05PiTZwBAPXWg+oKjq
         3CWA==
X-Forwarded-Encrypted: i=1; AJvYcCVhQP2cWott9qWWT923HOsikwWE+MERnSY7I93uGqpXuceiktNWj+7rivqfCv1O9xZU62/ql4UGxh6aqJf//h7iB6SqC+uBOPveVw==
X-Gm-Message-State: AOJu0YyicpVPOGSzQ+irvp5S7D2gWqtPpYxrbu5rWXIPgB3TCAkuKpdL
	0aCORC2TNzOBrfqxCYKTbI95lCKajAX1gKDVe2pzauFAC7wEDSdJZHSg53jCXb8wcWpqwMRlfci
	XwFWklVY9dmeK/GbuGajxzhmfPMX3t43Tx6hddvw8P5CHPloKobm1gJ6likfNryaVVyoxOA==
X-Received: by 2002:a17:906:f59a:b0:a55:6602:e3a9 with SMTP id a640c23a62f3a-a5a2d53b27fmr896402266b.1.1715529483859;
        Sun, 12 May 2024 08:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrjVpdmxpALEGXwArig0xYma2vQiZH4M4cGOIEe4AlT5uAvS19H+rQCflSqKKY5pAyU9cSQ==
X-Received: by 2002:a17:906:f59a:b0:a55:6602:e3a9 with SMTP id a640c23a62f3a-a5a2d53b27fmr896400266b.1.1715529483347;
        Sun, 12 May 2024 08:58:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01472sm468985166b.159.2024.05.12.08.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 08:58:02 -0700 (PDT)
Message-ID: <3fdb7491-5073-4145-9874-a038e1c4b76a@redhat.com>
Date: Sun, 12 May 2024 17:58:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
 AceLan Kao <acelan.kao@canonical.com>
References: <20240218151533.5720-1-hdegoede@redhat.com>
 <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
 <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com>
 <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kai-Heng Feng,

On 5/8/24 6:42 AM, Kai-Heng Feng wrote:
> [+Cc AceLan]
> 
> Hi Hans,
> 
> On Wed, Apr 24, 2024 at 5:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Kai-Heng Feng,
>>
>> On 4/24/24 10:04 AM, Kai-Heng Feng wrote:
>>> Hi Hans,
>>>
>>> On Sun, Feb 18, 2024 at 11:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> I recently learned that some Dell AIOs (1) use a backlight controller board
>>>> connected to an UART. Canonical even submitted a driver for this in 2017:
>>>> https://lkml.org/lkml/2017/10/26/78
>>>>
>>>> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
>>>> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
>>>> with an UartSerialBusV2() resource to model the backlight-controller.
>>>>
>>>> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration()
>>>> to still create a serdev for this for a backlight driver to bind to
>>>> instead of creating a /dev/ttyS0.
>>>>
>>>> Like other cases where the UartSerialBusV2() resource is missing or broken
>>>> this will only create the serdev-controller device and the serdev-device
>>>> itself will need to be instantiated by the consumer (the backlight driver).
>>>>
>>>> Unlike existing other cases which use DMI modaliases to load on a specific
>>>> board to work around brokeness of that board's specific ACPI tables, the
>>>> intend here is to have a single driver for all Dell AIOs using the DELL0501
>>>> HID for their UART, without needing to maintain a list of DMI matches.
>>>>
>>>> This means that the dell-uart-backlight driver will need something to bind
>>>> to. The original driver from 2017 used an acpi_driver for this matching on
>>>> and binding to the DELL0501 acpi_device.
>>>>
>>>> AFAIK you are trying to get rid of having drivers bind directly to
>>>> acpi_device-s so I assume that you don't want me to introduce a new one.
>>>> So to get a device to bind to without introducing a new acpi_driver
>>>> patch 2/2 if this series creates a platform_device for this.
>>>>
>>>> The creation of this platform_device is why this is marked as RFC,
>>>> if you are ok with this solution I guess you can merge this series
>>>> already as is. With the caveat that the matching dell-uart-backlight
>>>> driver is still under development (its progressing nicely and the
>>>> serdev-device instantation + binding a serdev driver to it already
>>>> works).
>>>
>>> I was about to work on this and found you're already working on it.
>>>
>>> Please add me to Cc list when the driver is ready to be tested, thanks!
>>
>> I hope you have access to actual hw with such a backlight device ?
>>
>> The driver actually has been ready for testing for quite a while now,
>> but the person who reported this backlight controller not being
>> supported to me has been testing this on a AIO of a friend of theirs
>> and this has been going pretty slow.
>>
>> So if you can test the driver (attached) then that would be great :)
>>
>> I even wrote an emulator to test it locally and that works, so
>> assuming I got the protocol right from the original posting of
>> the driver for this years ago then things should work.
>>
>> Note this depends on the kernel also having the patches from this
>> RFC (which Rafael has already merged) applied.
> 
> There are newer AIO have UID other than 0, like "SIOBUAR2".
> 
> Once change the "0" to NULL in 'get_serdev_controller("DELL0501", "0",
> 0, "serial0");', everything works perfectly.
> 
> With that change,
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Great thank you for testing. Luck has it that the user for who's
Dell AOI I started working on this also just reported back that
the driver works for them :)

So I'm going to send out the patch series for this now with
the following diff squashed in vs what I send you:

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index da4a640c0d88..3882bb7d6c71 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -352,7 +352,7 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	struct device *ctrl_dev;
 	int ret;
 
-	ctrl_dev = get_serdev_controller("DELL0501", "0", 0, "serial0");
+	ctrl_dev = get_serdev_controller("DELL0501", NULL, 0, "serial0");
 	if (IS_ERR(ctrl_dev))
 		return PTR_ERR(ctrl_dev);
 
Regards,

Hans


