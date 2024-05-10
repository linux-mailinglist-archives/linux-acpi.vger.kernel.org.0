Return-Path: <linux-acpi+bounces-5750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50288C2970
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6A21F22A85
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E418E25;
	Fri, 10 May 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cpSn01bR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD131C68D;
	Fri, 10 May 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362840; cv=none; b=Wm6CrPPwPhdr8HLuTl5xSXjsxumRE03d+p798UwuanlQ0SRx2c4wvuoldmo/SYK4TsdDU/eCyoq3t86XNUZtnkN2G/xF+eU4tW0C/fKI598GXsTTmG/+ieBpI6091vUZN8/1CvZgLiOItfajRxdbk9jg5f5TExjMJbFQoxeNyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362840; c=relaxed/simple;
	bh=ObWbmJdfzk15/jDOtllfPtSvyWp8b01uXGk4zbMPq2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQwfwY0LtSPPnMSf5Kya9rl5jPDRX/8ataBMtQGKdM4m3XfQAPnAd2mMWCFDGLCBm9XJ79AVNHyJT70E+RXTWJmNhjA1YbCBsKY4ja0BW96VqUbMbLEyAl4d4tnr4hKkUC92fMvEZBrhWEjvvIJKW1OVjng8iYvIN/Pzdwdw/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cpSn01bR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715362828; x=1715967628; i=w_armin@gmx.de;
	bh=jOXX5byxEe18bz0YwJf9w+QbmDWtpuKFFdmwLvWm9yo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cpSn01bRXinT3RpPDzBj+/bIFnyqGFQa9nDmFSIUrpm89gcPPBaF3AuuSRCgk+j1
	 ok+CUbrC6Faj2Wka6fw+AhGC/7W/o+i8MLj3yynTpkbAz0guyv0QZwwAynPv7hJri
	 h9LYXQnI0wjwl2uz0LNRaGZpOtx+tbB1dGvmqEWySpr6eyMKQyeWZ52YP7vxBjnem
	 IUand5gefM0WkGTjjIwFLVGVp46tiSAy6AqKVoUmWOvhbLimh2OKDeMj7lN42A5z9
	 Y+pa6u4VZ8NPedqrqdU6RqgXHZ43WZOZN9DC/7zDL+BbxIDW2yfkaE4jwWvdszsI7
	 zEAoHfgPZvwK0NCJ6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1sWXqs0a4M-00ebZj; Fri, 10
 May 2024 19:40:28 +0200
Message-ID: <dc64a811-3e33-4d5c-ab42-a5c2e8a79c50@gmx.de>
Date: Fri, 10 May 2024 19:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] platform/x86: wmi: Remove custom EC address space
 handler
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <2332870.ElGaqSPkdT@kreacher>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2332870.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QDd3E+DAJSyHABXbMK64G5eOa6kKTlpFdhvrdSzXk93WckfBivN
 KeypSRreKchFAe3LTNWDDic843VxT75AWzeRbtRkJCwVyfie5M4V4+C7OGkIJLkc7KM50xN
 DRyeb5txhAf0R/uwKVPVS3gCT5DT3EkgFe1bgVO7Z7xPj0kTb+h/VXz/mlfgZvQvoohBCF5
 3oMX6Sz4KnVpaZXTt7BcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u81cezJJvhY=;qWfFEO3cN8PrxOrzwdMWcUWEKc8
 fk0tJrFWx/wbLy4IzJqk0dbXOjXNYEIFZxtvQ8eoaRvbzT+EWcamKlQLPchpoCa8kwzsheXiG
 Ya1+jjiWxtOlvRB/7WeuswOB86tqgseDV/nCXnIevnMRgdf2lq+GM/ebAWWmKZh0oYdPi2TB8
 45JytlKAQRcbmXUErWcoAJH3q0CpwwFIECcr3SArvE2Kbe2vFq9irNfvWB+wJi5Aa/toUzk9Q
 EDENv5b78tq0mUn4XCcXE2wokU0mJZjIqseZPEIv5/R3J1NGUcgzh9KvbXvU7/FhkQVBeFtBG
 kxy7SqZ6RShkgf60s5R4KDYa1+X2caWMNqTc6TjrpsZZtRnwB1MZEMeeLsKKnv0RggpxnkVha
 aT5Z2R9dbJ3qVVGjz9b0++UbbMvEgc4v9+J9RusX8VJTH30q6QvYKYSjaGCYIgGCNpwMyKYxR
 DhtUjeNLBfoA0CY++KlB0tBEhXJHTRBO9CHiYiYMczKcboxmleUSRdhLZBfX38qJN4gJNztVl
 IeTKIvaHuRSg6z3I12Ec3jG0EthjzRjQejh8vr2El62uHtUhlAOY6TILJ9pJ41JH+m0wffyv9
 7rFJK+6oN3ABINuRl9/rUgIAwJucuvzpOy+BO2fyPvbZGKXsFZxA41XfmpeoF8xVqzEZWnROH
 gnyCf0mj/QflXwFQfcTLGLUTv/OtgCIbYzAXjeW14P/B5+4RXnxPZaBGAm27tZFCM+vkLewB7
 MaAXQKBnvi4WBOTflTRxv/kSjYxggwLKF1a3xMS9tAhvJrBPJBde5PlvHa9BbYUqgOHdI2lIi
 LbOXDB69YasmkUukaQGZyh8i1RqOXTnfz1hNXrvw6l1Bw=

Am 10.05.24 um 16:04 schrieb Rafael J. Wysocki:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The custom EC address space handler in the WMI driver was only needed
> because the EC driver did not install its address space handler for
> EC operation regions beyond the EC device scope in the ACPI namespace.
>
> That has just changed, so the custom EC address handler is not needed
> any more and it can be removed.

The patch seems ok to me, but it might conflict with pdx86/for-next.

Other than that:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/platform/x86/wmi.c |   62 ------------------------------------=
---------
>   1 file changed, 62 deletions(-)
>
> Index: linux-pm/drivers/platform/x86/wmi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/platform/x86/wmi.c
> +++ linux-pm/drivers/platform/x86/wmi.c
> @@ -1153,47 +1153,6 @@ static int parse_wdg(struct device *wmi_
>   	return 0;
>   }
>
> -/*
> - * WMI can have EmbeddedControl access regions. In which case, we just =
want to
> - * hand these off to the EC driver.
> - */
> -static acpi_status
> -acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
> -			  u32 bits, u64 *value,
> -			  void *handler_context, void *region_context)
> -{
> -	int result =3D 0;
> -	u8 temp =3D 0;
> -
> -	if ((address > 0xFF) || !value)
> -		return AE_BAD_PARAMETER;
> -
> -	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
> -		return AE_BAD_PARAMETER;
> -
> -	if (bits !=3D 8)
> -		return AE_BAD_PARAMETER;
> -
> -	if (function =3D=3D ACPI_READ) {
> -		result =3D ec_read(address, &temp);
> -		*value =3D temp;
> -	} else {
> -		temp =3D 0xff & *value;
> -		result =3D ec_write(address, temp);
> -	}
> -
> -	switch (result) {
> -	case -EINVAL:
> -		return AE_BAD_PARAMETER;
> -	case -ENODEV:
> -		return AE_NOT_FOUND;
> -	case -ETIME:
> -		return AE_TIME;
> -	default:
> -		return AE_OK;
> -	}
> -}
> -
>   static int wmi_get_notify_data(struct wmi_block *wblock, union acpi_ob=
ject **obj)
>   {
>   	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -1308,14 +1267,6 @@ static void acpi_wmi_remove_notify_handl
>   	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi=
_wmi_notify_handler);
>   }
>
> -static void acpi_wmi_remove_address_space_handler(void *data)
> -{
> -	struct acpi_device *acpi_device =3D data;
> -
> -	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_=
EC,
> -					  &acpi_wmi_ec_space_handler);
> -}
> -
>   static void acpi_wmi_remove_bus_device(void *data)
>   {
>   	struct device *wmi_bus_dev =3D data;
> @@ -1347,19 +1298,6 @@ static int acpi_wmi_probe(struct platfor
>
>   	dev_set_drvdata(&device->dev, wmi_bus_dev);
>
> -	status =3D acpi_install_address_space_handler(acpi_device->handle,
> -						    ACPI_ADR_SPACE_EC,
> -						    &acpi_wmi_ec_space_handler,
> -						    NULL, NULL);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(&device->dev, "Error installing EC region handler\n");
> -		return -ENODEV;
> -	}
> -	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_addre=
ss_space_handler,
> -					 acpi_device);
> -	if (error < 0)
> -		return error;
> -
>   	status =3D acpi_install_notify_handler(acpi_device->handle, ACPI_ALL_=
NOTIFY,
>   					     acpi_wmi_notify_handler, wmi_bus_dev);
>   	if (ACPI_FAILURE(status)) {
>
>
>

