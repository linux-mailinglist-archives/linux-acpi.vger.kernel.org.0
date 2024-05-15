Return-Path: <linux-acpi+bounces-5838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC818C6B74
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDDC1C22111
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3538DE9;
	Wed, 15 May 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGtv2OOY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8A28680
	for <linux-acpi@vger.kernel.org>; Wed, 15 May 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794164; cv=none; b=t0djVvoNeQyV2VRRv9m359O2lvTcXRBPZYBff18igLa19FzplmOQ0eajb95Sb3+psWML9xxdvYzUW86n73XUl31msIEF31LFLT33rRAZtfLs3of1qREdEEuWl7a7cZoVajX0dq86EUebEe2/WeE6UehbtMkuBbb3d7BIiAnBQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794164; c=relaxed/simple;
	bh=f/iuzZMlmH508xLuK+c3POd1uCl01loh39/9JbXRo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWbU4Kml8BargfQNkiuVsqj3v/9Cy1D1omQ5HFXiKngtRrPBaATz5+1w3b2EUEw7fvVIGoydr7JAC1yrpXlIu3WLcMF3c+ISycYQeZgL3wPpxVtcxXCV+dYv60KjFolFKdN78O0R1gnOvC0lYnCfSoL5eO6tEYHW+MiB32qapCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGtv2OOY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAfbkl7wDlhHLUu1WDwZPQgfI6VIwQuAvbx4geCCHEk=;
	b=ZGtv2OOYdX2SgeHyPNUzrG53O7s1GZ0CkRSMqAIUowVhJul7DyqE+fMRnjjb3bMl0aLV6R
	OP7/uM9pngRdoJaQ7D1Jlpuw1c7S/2mYP6tPPVFgCGWNoebt79hFw7k6dl0wUfHIijkhsv
	Aq8oH1gYAqWDM1x4ZILB+nN9b8AFH9A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-tyCpk38ENLa-1Yumi6LGuw-1; Wed, 15 May 2024 13:29:19 -0400
X-MC-Unique: tyCpk38ENLa-1Yumi6LGuw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5222a0800f0so5829098e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 May 2024 10:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794158; x=1716398958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAfbkl7wDlhHLUu1WDwZPQgfI6VIwQuAvbx4geCCHEk=;
        b=aOdFUMe7+hRcF18YIX5iBMZoy3b1luNLyZRv7WTZBJmQrr9n8vBOXXuSiF2jXJsdSE
         OiVIhVgt3m8J118svWNay253des/kxckC+4kXaGD16LMDnaLQ2R66p6wYC3T1xsVLao2
         X5ZJzS8VMvsRktGH9A/C5LAmhi6Ic5wtWSZHwiY35W/gKkGMdr9srplJjnnM5clapP9x
         Danx4c6bzDOwaf+Bd+XdImD2oBpwBtiKPFi+xahhJy4SkuGvoB8LvjXjWpF7dlCt4nV7
         AMaS6lwf8vhIjOqzseKMblSkSi67EfKYWs+X7C06Y8+qkIeGkToUEXfdfbW4WQVKMI8d
         N0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVLgrH+rrv/UV/nJ3J/WSAv3wv/6QYvA9sIas7KQEBKC/0rgk2hiXenoIUliv7a9eAvUR4gCUX4rbkcPd0L90kuAHbLKQJ1BLsKQw==
X-Gm-Message-State: AOJu0YzzzwItTgzJNJk9kQXuSS1FZC26q71kzsXujXXS24zQr4MdUvp7
	EBbmlnWJk9/dA9M04c08fyvgxI0hr+MnqccCwtx7usvvTYSb/MgZtUOyhJlZnTDDAmBhSxiE/Ar
	6Tva3q04TwL5o/6Ng8b7maK+CdwLyDsDg24R3uSxAPTFbSiebdGa7ksqWaRo=
X-Received: by 2002:ac2:4e11:0:b0:516:d232:2516 with SMTP id 2adb3069b0e04-5220fc7c59amr15507428e87.6.1715794158254;
        Wed, 15 May 2024 10:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDrCwDGj4XtoQfDTNZCsTDx1LFrxlRKr0DQD3VjW8RoHfkTcT7e3ifieXQ/Csi1JyJ3zpPXg==
X-Received: by 2002:ac2:4e11:0:b0:516:d232:2516 with SMTP id 2adb3069b0e04-5220fc7c59amr15507407e87.6.1715794157745;
        Wed, 15 May 2024 10:29:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17844sm879836966b.190.2024.05.15.10.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 10:29:17 -0700 (PDT)
Message-ID: <04271fb5-cca3-4bca-b98e-3fab8a78c724@redhat.com>
Date: Wed, 15 May 2024 19:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Use vendor backlight on Lenovo X1 Carbon.
To: dengxiang <dengxiang@nfschina.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 prime.zeng@hisilicon.com, rafael@kernel.org, tony.luck@intel.com,
 wanghuiqiang@huawei.com
References: <20240515034501.12772-1-dengxiang@nfschina.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240515034501.12772-1-dengxiang@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi dengxian,

On 5/15/24 5:45 AM, dengxiang wrote:
> Hi Hans,
> 
>> A couple of remarks / questions:
> 
>> 1. Looking at the strings you match on this is not for a Lenovo X1 Carbon,
>> but rather for a Lenovo Kaitan model ?  So it seems that the commit message
>> and the comment for the quirk need some work.
> 
> ok, I will add DMI_PRODUCT_VERSION & DMI_BOARD_NAME to make a distinction between  X1 Carbon and other kaitian models.
> 
>> 2. I have never heard of a zx_backlight interface before and there certainly
>> is no upstream driver providing this. I believe you need to explain what
>> is going on in a bit more detail here and then we can see if this really is
>> the best way to fix this. It seems that these Lenovo Kaitan laptops are
>> using Zhaoxin Kaixian x86 processors with integrate graphics. I would expect
>> the zx_backlight interface to be provided by the driver for the Zhaoxin Kaixian
>> integrated graphics in this case. And if that is the case then the integrated
>> graphics driver should use BACKLIGHT_RAW (aka native) for the backlight type
>> and with that change this quirk should not be necessary .
> 
> Yes, zx_backlight interface has been provided by the driver for the Zhaoxin Kaixian integrated graphics. Also use backlight_device_register("zx_backlight",...).
> Strangely enough, X1 Carbon laptops will generate two native acpi_video as belows:
>  
> lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video0
> lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video1 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video1
> 
> As you see, it will conflict with the same pci bus, then zx_blacklight interface can't be shown on the path /sys/class/backlight/.
> That is to say, zhaoxin driver contain key code as belows:
> #if DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
>     if(acpi_video_get_backlight_type() != acpi_backlight_vendor)
>     {
>         return ret;
>     }
> #endif
> 
> If i remove the key code, this laptops will generate two native acpi_video and zx_backlight on the sys backlight patch. Once add acpi_backlight=vendor parameter into kernel cmdline, 
> just zx_backlight interface has been left on the sys path, which mean that both acpi_video0 and acpi_video1 interface can not be found.

Ok, so the way this is supposed to work is as follows, there is a single
acpi_video_get_backlight_type() function which all backlight drivers are
supposed to use (and all in tree drivers do use).

This looks like this (simplified a bit, see drivers/acpi/video_detect.c):

enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto_detect)
{
	...

        /* Use ACPI video if available, except when native should be preferred. */
        if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
             !(native_available && prefer_native_over_acpi_video()))
                return acpi_backlight_video;

        /* Use native if available */
        if (native_available)
                return acpi_backlight_native;

	/* ... long comment explaining this ... */
        if (acpi_osi_is_win8())
                return acpi_backlight_none;

        /* No ACPI video/native (old hw), use vendor specific fw methods. */
        return acpi_backlight_vendor;
}

as you can see here acpi_backlight_video is only returned if available
(which it is in this case) *and* there is no native GPU backlight
driver or prefer_native_over_acpi_video() returns false.

Since there is no way for this function to know a native GPU driver
is supported it uses the native parameter passed to it for this,
so native backlight drivers, like the Zhaoxin Kaixian integrated graphics
driver must call a special helper, which internally calls the above
function with native=true. I think not calling that special helper
is why you see the acpi_video backlight devices, assuming you are
using a recent mainline kernel.

So that:

#if DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
    if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
    {
        return ret;
    }
#endif

block you quoted should look like this when using recent upstream
kernels:

    if (!acpi_video_backlight_use_native())
    {
        return ret;
    }

Although that return ret looks weird, maybe hardcode 0 for success
(not registering is on purpose, so success ?)

Or to keep things compatible with multiple kernel versions use:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 1, 0)
    if (!acpi_video_backlight_use_native())
    {
        return ret;
    }
#elif DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
    if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
    {
        return ret;
    }
#endif

Please give this a try, I believe you will not need a quirk
when the Zhaoxin Kaixian integrated graphics driver does
the right thing.

Regards,

Hans



