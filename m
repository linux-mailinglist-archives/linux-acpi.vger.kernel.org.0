Return-Path: <linux-acpi+bounces-21272-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPWHLSsgo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21272-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:04:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157F1C4AF6
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C480301F493
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4A3112AB;
	Sat, 28 Feb 2026 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+80QtgC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122772E3AF1
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298278; cv=none; b=VXU6TNM7t2yWMVgBaPSbgZcm73GRGbQ0052Vp5w6yXFAN1CtS6K1vYmo5DEAUcwCxEvZk2/VTTXqXLhAGT2ishpj/qdmOsQeSxTXGk64WTlaQay3o1fbiF2iGnUNgKYAliTzlREpKpbTDq8jX6a7MJS57q8qUn5w+3uDzzXv6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298278; c=relaxed/simple;
	bh=vfk5oWr6+MC3tbftUpoDnEcCStih+EdR8IGYQq3G6+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNQGwuudyk0JtX90dAtGd4DtZ/06l9Cwf2vi5wLCCYrFE4YR2mhQJXzQkzilgvxWlGV+4438d/W9prF/yZLAHg539hUFRx89kveWo4erOlzQzR/A5rTDgKGO2bH0ZbSmhpkq5q6aEKdgWl88W/QX9CDTC0ZLWOqetAyUMo9VWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+80QtgC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so35640265e9.1
        for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772298275; x=1772903075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipIyvKGS8RA5V5Uwrv0KbmHM1BtJzJk2sHameAMPWss=;
        b=g+80QtgCIOmHLcCi8YxMfoEbT6hlVCTHChygTphK/D/NxqiOsjebfEYmQ8ecoIKYCa
         4x60B4Dq9Q+cnn8YIMiSPoUyCyda+zC7F/VhtPo88jWQUcFkft1Dy6f2dRL4u8TsjY3J
         yWK6YkKaRLn9nEpKWHLQCCu4DGAsKQVAKmXvnANmYuWUSvnbop4d0v0OgcyhTnv2GqwP
         4hCRl0PEDDBNVrkIbkPN1rJvfPV9i8243EAiqKbTGJuC5WKQWaYHaZ5L2jO7UgLedwge
         S6yDNYHtOJPoaOTOS4ZnnM8sf7P/eO3PktT+XOstwvdzNXs9j/WkJE2tsEg31NFogFI1
         gC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772298275; x=1772903075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipIyvKGS8RA5V5Uwrv0KbmHM1BtJzJk2sHameAMPWss=;
        b=Irwhf7UqfPJbpFf7S8N4AH5ff0KfS8TY0nKAnGTYuJxlkweV2yqwy6SZKAKS0lupyc
         7GZqdzYpe+gxZ0VodwpRcevJ/rSdcjR2VLnbQDPBccu5EMFTXERkY7Jp8RoWr00yRuDO
         /M9e6RwGgB4lnUm8nlxwCd/LNhgdTRXPyr7+brcgQ/EfhWSgbLD3I5Zyp//GzRxYitDY
         nw8E3UzcQO5t/7t6Z+gtyaxQOYIoGJY0QdiCDK4HcAdThzZ0FUIJhqfd4ORx1a1QokGi
         KDMIt888MJrtZKdMoy4fZQoPMpI0dpFh4eIc3TZDqLVBAEhtuT0OEi6V/tVgOOc/VBoS
         KHBg==
X-Forwarded-Encrypted: i=1; AJvYcCXL3x+Ndc1e+TT7WU3Xp2cnoYH+/6U2K250PFaKr3ywEA/lLG1Am7u2vDeJ/me12KdGWxqvylnV6lkN@vger.kernel.org
X-Gm-Message-State: AOJu0YxBH+Mh2hEJFY7hglH/2aU5xEez8p/1f7NxggwyZpoDzAKDwfV7
	vWHyfnsYbPITTr4xvVAPCz9PpDcyNn56ouClJR7tDrm9WMPDyjh1ihmi
X-Gm-Gg: ATEYQzzyhuus0SQC0PGSl6nmIMCoUA/r46Kbg1wy/7mESMlvBxvJD4Bz21yjgpeV3WY
	oEqLJrLJsatdnLE/NKHvam3qNjH6W6lxpUcK4H8tK3q5ns5GqKdclufVeZxsyJmsIBG9RYxEts4
	V0gDEJmFoKnnaL2QtUzsltVu1k32kVCCgpZ/fV2s89YKCK7lSFsbXvfVRjnVRxuF1ESjfzhBQMY
	ehSz1U01ryqW5ioK189xsMIq069CfaGEaFKSF2jBvrylHAhm7dzNehpE1VckUPCDrdPcqDY8ADb
	uPXeGoADDbaGpDjA7ppvG1NIoZ8602YR0mB/5yV8HKXlc0+gailZ+FjGNGQzEnBzAMCHJ63+orS
	0r83RVUihwPgXNxs/HeSpH6P6M+Jvou0RDF+tQCOLE+Ysrv+hb+NKc2O/ZRo7f0AxZh1Zkls4J4
	qoRUBQ4DmzuGNH8/8m+9BWcecW2hV/JiN+T1I=
X-Received: by 2002:a05:600c:3b02:b0:483:6fe1:c057 with SMTP id 5b1f17b1804b1-483c9c02efcmr116143755e9.21.1772298275197;
        Sat, 28 Feb 2026 09:04:35 -0800 (PST)
Received: from [192.168.1.121] ([151.95.146.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3474dsm167336535e9.1.2026.02.28.09.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:04:34 -0800 (PST)
Message-ID: <14eae871-5cb0-4847-963f-e3d382a3fc2b@gmail.com>
Date: Sat, 28 Feb 2026 18:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] platform/x86: eeepc-laptop: Convert ACPI driver to
 a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>
References: <7916328.EvYhyI6sBW@rafael.j.wysocki>
 <3329436.5fSG56mABF@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <3329436.5fSG56mABF@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21272-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benatodenis96@gmail.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3157F1C4AF6
X-Rspamd-Action: no action


On 2/28/26 16:22, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the EEEPC laptop ACPI driver to a platform
> one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/platform/x86/eeepc-laptop.c | 32 +++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 626a99a71fce..02a71095920e 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1361,8 +1361,9 @@ static void eeepc_enable_camera(struct eeepc_laptop *eeepc)
>  
>  static bool eeepc_device_present;
>  
> -static int eeepc_acpi_add(struct acpi_device *device)
> +static int eeepc_acpi_probe(struct platform_device *pdev)
>  {
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	struct eeepc_laptop *eeepc;
>  	int result;
>  
> @@ -1373,9 +1374,10 @@ static int eeepc_acpi_add(struct acpi_device *device)
>  	eeepc->handle = device->handle;
>  	strscpy(acpi_device_name(device), EEEPC_ACPI_DEVICE_NAME);
>  	strscpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
> -	device->driver_data = eeepc;
>  	eeepc->device = device;
>  
> +	platform_set_drvdata(pdev, eeepc);
> +
>  	eeepc->hotplug_disabled = hotplug_disabled;
>  
>  	eeepc_dmi_check(eeepc);
> @@ -1448,11 +1450,12 @@ static int eeepc_acpi_add(struct acpi_device *device)
>  	return result;
>  }
>  
> -static void eeepc_acpi_remove(struct acpi_device *device)
> +static void eeepc_acpi_remove(struct platform_device *pdev)
>  {
> -	struct eeepc_laptop *eeepc = acpi_driver_data(device);
> +	struct eeepc_laptop *eeepc = platform_get_drvdata(pdev);
>  
> -	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY, eeepc_acpi_notify);
> +	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
> +				       ACPI_ALL_NOTIFY, eeepc_acpi_notify);
>  	eeepc_backlight_exit(eeepc);
>  	eeepc_rfkill_exit(eeepc);
>  	eeepc_input_exit(eeepc);
> @@ -1469,13 +1472,12 @@ static const struct acpi_device_id eeepc_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
>  
> -static struct acpi_driver eeepc_acpi_driver = {
> -	.name = EEEPC_LAPTOP_NAME,
> -	.class = EEEPC_ACPI_CLASS,
> -	.ids = eeepc_device_ids,
> -	.ops = {
> -		.add = eeepc_acpi_add,
> -		.remove = eeepc_acpi_remove,
> +static struct platform_driver eeepc_acpi_driver = {
> +	.probe = eeepc_acpi_probe,
> +	.remove = eeepc_acpi_remove,
> +	.driver = {
> +		.name = EEEPC_LAPTOP_NAME,
> +		.acpi_match_table = eeepc_device_ids,
>  	},
>  };
>  
> @@ -1488,7 +1490,7 @@ static int __init eeepc_laptop_init(void)
>  	if (result < 0)
>  		return result;
>  
> -	result = acpi_bus_register_driver(&eeepc_acpi_driver);
> +	result = platform_driver_register(&eeepc_acpi_driver);
>  	if (result < 0)
>  		goto fail_acpi_driver;
>  
> @@ -1500,7 +1502,7 @@ static int __init eeepc_laptop_init(void)
>  	return 0;
>  
>  fail_no_device:
> -	acpi_bus_unregister_driver(&eeepc_acpi_driver);
> +	platform_driver_unregister(&eeepc_acpi_driver);
>  fail_acpi_driver:
>  	platform_driver_unregister(&platform_driver);
>  	return result;
> @@ -1508,7 +1510,7 @@ static int __init eeepc_laptop_init(void)
>  
>  static void __exit eeepc_laptop_exit(void)
>  {
> -	acpi_bus_unregister_driver(&eeepc_acpi_driver);
> +	platform_driver_unregister(&eeepc_acpi_driver);
>  	platform_driver_unregister(&platform_driver);
>  }
>  

