Return-Path: <linux-acpi+bounces-9013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833649B2153
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209F828142D
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Oct 2024 23:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8D188CC6;
	Sun, 27 Oct 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIhHuoX3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C1161;
	Sun, 27 Oct 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070637; cv=none; b=fjH+cJCoFcrcsDlFSVtw0bp0xeEyuP/NrVmZKZGhNQg8KsNkUaJx0t23q1gDoEtxrcyuSuDdZ8Z6dSifOr4pCEZEahIT3sFs3CGDUoYG7JSaEX6nyCeoj7pZh1iEmu5PjA/XsehNq9yvU50t8x+BV5X/1LIlNUmZKf1xQwHlzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070637; c=relaxed/simple;
	bh=useqysxUEcLQ2aMXTgKfsuhB1B/otftxIG5Fs/y2k3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS1MMfcOej+sP7k//nt7+kUadMFNM35Mz1KCcniuDGHg9xgy0nv2SLyhOH7LRuV1C/BRrUkPCHFDUfau0Mln7IEb36dSzm7u7HY6MgU3YazS2DZJhzg0EjU0bhTMP/ylPdeF/10tt/hSYlgN23qTBZxSgo9WBHKTuqucVUNHhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIhHuoX3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso38538575e9.0;
        Sun, 27 Oct 2024 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730070634; x=1730675434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFeZ965nAQAUdBsdbWiwD7ivDZutozPpLb7/lBQkTLY=;
        b=KIhHuoX3UoFER1dXIYgVASuGaozJponHR7Q5XovQRb/h7Rw4URbd3R8ojNybos8cKK
         DsGmu9JZFPA0HqgrDAuf3RtAsKCnIhwecOqxlFywQydQI/JJl8r4l1Z6wiaZNMVu1e5k
         v7HVkVFtBvosXl+/XUP9LF8qiClkslvH62phSjw2DtGCQoqLt3UmVjwO7v7k8E0EvYXu
         48T6CwAPax8YqguDeYgJNMnGSO2ZuiMCW5y4kBo54ntTjkbE5zblfeimeuWksJ2vsIUR
         TlaHWbnAu+5/wvEOcEb3RVePN7KUfdnEBg5LhoTwRyS2he1MavD1xxYLWk5qhEkf3uC+
         xaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730070634; x=1730675434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFeZ965nAQAUdBsdbWiwD7ivDZutozPpLb7/lBQkTLY=;
        b=qWkQ0IP9hl3ZJ0x8PQraIZ/rJb6EwPlHyhnaA1aNbbow6iIzE6OTc9fCPvUcKB91u5
         maGZDcDg6MEw3N3KTXrqT6TNSPKbhZ42SaMAmvgribqNKIBbX0hsGQP8z0bWkNkNdo22
         3SRp177qsTrBGs6GRFnkMLcmbmvBqsNIPl2hkbMGnCSzVvt56ApXVXoFijpZaIwwBNb5
         ilB7HiBU9I2SZfLF1lgHNe1xlPX7Cvfgj78lHJKxTnxJovVTa3XWjHo0yjiEUD1uaddV
         lvAV5DvXO9BvNnG3Q1822oRySGjiDjuXZgn90e64PZ7KVeqRhII8KPVaYKpuMm8PAXtu
         QtZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtfxFfXbhAfn2dm7PMIHVHWs6Ggd6n8Xv2cS1jCP7B0HnE2LUS5iAfsx9Hw4D9fnKOVi8UR8oGLbHQHCd44J3kaA6X0g==@vger.kernel.org, AJvYcCVZDyjxhcIMTXi5AoZFtcpHSP7adeOx9v3NUVQg+jjgyUhdI99J27tVhuL5/h9Ee6qBtGvyxy54zr6c@vger.kernel.org, AJvYcCWCcpM18i1tFbQQTeY3MZawLwEJYjno93K/H2S9Gi4+XLtTRjUhyKsYmg07MIMCxZyT0gH3y8ukqgHk+Lqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvx44sr0pYE6N9KAkm859iz7iTJBMCSNjIb8N9Jt0CjgobtbW
	h+wKrQrxSfBAFmOtKp7i8P4/p7tCxPZmXyXbNUaS0WvgD2ge1MvyIf6ujQ==
X-Google-Smtp-Source: AGHT+IF9C2sepihkCo09FcSIB2MaX2p26yqSY+v+9+AQuuAMZdKvr4i/LMnsTh7IFenX+G1hoozDAA==
X-Received: by 2002:a05:600c:1d8c:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-4319ac94a2emr53822605e9.8.1730070633657;
        Sun, 27 Oct 2024 16:10:33 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579613sm119223815e9.38.2024.10.27.16.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 16:10:32 -0700 (PDT)
Message-ID: <14053a51-3101-4d76-8947-2f74e1ee6c58@gmail.com>
Date: Mon, 28 Oct 2024 00:10:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] platform/surface: aggregator: Add platform handler
 pointer to device
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
 <20241025193055.2235-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20241025193055.2235-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 9:30 PM, Mario Limonciello wrote:
> To be able to reference the platform handler in remove, add
> a pointer to `struct ssam_device`.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   include/linux/surface_aggregator/device.h           | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 61aa488a80eb5..958afd7bce223 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   		return -ENOMEM;
>   
>   	tpd->sdev = sdev;
> +	sdev->tpd = tpd;
>   
>   	tpd->handler.name = "Surface Platform Profile";
>   	tpd->handler.profile_get = ssam_platform_profile_get;
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 8cd8c38cf3f30..6a72b5bdc8782 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -164,6 +164,7 @@ enum ssam_device_flags {
>    * @dev:   Driver model representation of the device.
>    * @ctrl:  SSAM controller managing this device.
>    * @uid:   UID identifying the device.
> + * @tpd:   Platform profile device data.
>    * @flags: Device state flags, see &enum ssam_device_flags.
>    */
>   struct ssam_device {
> @@ -171,6 +172,7 @@ struct ssam_device {
>   	struct ssam_controller *ctrl;
>   
>   	struct ssam_device_uid uid;
> +	struct ssam_platform_profile_device *tpd;

Do we really need to introduce a new field in the main SSAM device struct? I
only had time for a brief look, but IIUC you could just use ssam_device_set_drvdata()
and ssam_device_get_drvdata().

>   	unsigned long flags;
>   };

Best regards,
Max

