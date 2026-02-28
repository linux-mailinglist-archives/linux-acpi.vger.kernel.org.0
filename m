Return-Path: <linux-acpi+bounces-21268-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EuHNJcfo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21268-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:02:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E52481C49C8
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 372C230015BB
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476126ED25;
	Sat, 28 Feb 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B5othWjQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9D2DA76F;
	Sat, 28 Feb 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298129; cv=none; b=Nh5vqLo9VdpM0Ak6S7kxwb9LWm39mYSK7zaLezkLYvgz3IK4Yp1SLJynqjp32CJYCnmD25ZpumIGNko+k3OFXPtzWarZ1zkTg8+NaNiOq50beKxP97RGOMg8hfCeTSgcEbih+Ju9Gn8P/mXxWUEUKCRufwuuIbEbrOIfnpR4Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298129; c=relaxed/simple;
	bh=1Zmoe7KTw+dHQINnsvafHx9BYQ93yBePTvJWnSabeKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDsDX983tB7iMuEU5/aDgFymjAl+iOvWGQw/yhgakCAxL0W4fTNTy9BRVy7y3cZGAABWn/q4EMrbCRTvCSuM3YqhlgVkDDilumAfQWA8JhygkLDzJ1cZcdxQaCUPhILmtQakyLe+/Xajy3+2ny1+2KpTevDgTqhliIadddOq01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B5othWjQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772298116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LenEUBQ0NkEZoIo2rjfTgSjz49CNYQTmftfJQFrn2GA=;
	b=B5othWjQEN8ETB6YM4LnFyPDWsOmSDLyAgLTx21mTYM5DSWQc0VqPUzxIGahCvTBvHLpjT
	WW+3YBkDvRlA2aW0oZ+2mXnCokNlLqUHPXVRA2u6aBWqgVb8Qqvwx7KgbXqvfEPkTAAGSz
	IftNYp32iU+3H371g1oVlLgq4SRwxGo=
Date: Sat, 28 Feb 2026 18:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver to
 a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
 <2402539.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <2402539.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TAGGED_FROM(0.00)[bounces-21268-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[denis.benato@linux.dev,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email,intel.com:email]
X-Rspamd-Queue-Id: E52481C49C8
X-Rspamd-Action: no action


On 2/28/26 16:11, Rafael J. Wysocki wrote:
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
> ACPI companions, so convert the Asus laptop ACPI driver to a platform
> one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
Alright I will take a look if asus-linux software is affected and act accordingly.
How much time do I have?

Thanks. 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/platform/x86/asus-laptop.c | 35 +++++++++++++++---------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index c927665dfa96..dbbb6292cd11 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1824,8 +1824,9 @@ static void asus_dmi_check(void)
>  
>  static bool asus_device_present;
>  
> -static int asus_acpi_add(struct acpi_device *device)
> +static int asus_acpi_probe(struct platform_device *pdev)
>  {
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	struct asus_laptop *asus;
>  	int result;
>  
> @@ -1837,7 +1838,6 @@ static int asus_acpi_add(struct acpi_device *device)
>  	asus->handle = device->handle;
>  	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
>  	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
> -	device->driver_data = asus;
>  	asus->device = device;
>  
>  	asus_dmi_check();
> @@ -1846,6 +1846,8 @@ static int asus_acpi_add(struct acpi_device *device)
>  	if (result)
>  		goto fail_platform;
>  
> +	platform_set_drvdata(pdev, asus);
> +
>  	/*
>  	 * Need platform type detection first, then the platform
>  	 * device.  It is used as a parent for the sub-devices below.
> @@ -1907,11 +1909,12 @@ static int asus_acpi_add(struct acpi_device *device)
>  	return result;
>  }
>  
> -static void asus_acpi_remove(struct acpi_device *device)
> +static void asus_acpi_remove(struct platform_device *pdev)
>  {
> -	struct asus_laptop *asus = acpi_driver_data(device);
> +	struct asus_laptop *asus = platform_get_drvdata(pdev);
>  
> -	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acpi_notify);
> +	acpi_dev_remove_notify_handler(asus->device, ACPI_DEVICE_NOTIFY,
> +				       asus_acpi_notify);
>  	asus_backlight_exit(asus);
>  	asus_rfkill_exit(asus);
>  	asus_led_exit(asus);
> @@ -1930,15 +1933,13 @@ static const struct acpi_device_id asus_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, asus_device_ids);
>  
> -static struct acpi_driver asus_acpi_driver = {
> -	.name = ASUS_LAPTOP_NAME,
> -	.class = ASUS_LAPTOP_CLASS,
> -	.ids = asus_device_ids,
> -	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> -	.ops = {
> -		.add = asus_acpi_add,
> -		.remove = asus_acpi_remove,
> -		},
> +static struct platform_driver asus_acpi_driver = {
> +	.probe = asus_acpi_probe,
> +	.remove = asus_acpi_remove,
> +	.driver = {
> +		.name = ASUS_LAPTOP_NAME,
> +		.acpi_match_table = asus_device_ids,
> +	},
>  };
>  
>  static int __init asus_laptop_init(void)
> @@ -1949,7 +1950,7 @@ static int __init asus_laptop_init(void)
>  	if (result < 0)
>  		return result;
>  
> -	result = acpi_bus_register_driver(&asus_acpi_driver);
> +	result = platform_driver_register(&asus_acpi_driver);
>  	if (result < 0)
>  		goto fail_acpi_driver;
>  	if (!asus_device_present) {
> @@ -1959,7 +1960,7 @@ static int __init asus_laptop_init(void)
>  	return 0;
>  
>  fail_no_device:
> -	acpi_bus_unregister_driver(&asus_acpi_driver);
> +	platform_driver_unregister(&asus_acpi_driver);
>  fail_acpi_driver:
>  	platform_driver_unregister(&platform_driver);
>  	return result;
> @@ -1967,7 +1968,7 @@ static int __init asus_laptop_init(void)
>  
>  static void __exit asus_laptop_exit(void)
>  {
> -	acpi_bus_unregister_driver(&asus_acpi_driver);
> +	platform_driver_unregister(&asus_acpi_driver);
>  	platform_driver_unregister(&platform_driver);
>  }
>  

