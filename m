Return-Path: <linux-acpi+bounces-15326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB4B12F51
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9F162967
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40B1FBEB0;
	Sun, 27 Jul 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8HMBCXx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5CE72614;
	Sun, 27 Jul 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753615405; cv=none; b=mB2pbn7iE1YRpdwTz253C87/INaVNQfksC0wRgMersUQfO5hW2wSFuMNCu6b4hJuBc9uQgy7OZplAIZpkmcA2xd5ctdM7uNwYp845vUM4yd8WaoiMOBTamRpJ+MGJOQGsP7XVzEzJ/q/mJ6MAMfx/UILEv2bAJSPk0NcdVpUIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753615405; c=relaxed/simple;
	bh=mH+hF6X7oXw4ClxhQYds/xBqemneYofiqs4R9ZE4QJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FDf+EC5tRtHf7+avokWZjEGoyKsXcqBy0YJOJ5466yq/ind2VUPKulbqK4/nlx36wp0goeMk++6m0Dzm4ga6SVR2BiiN2USipChFBO7RUBjJ/ggqhTV+crktMTi3HFX+Us6fn14GA23YhTYqMnZOW8/DpEoUkFHiTrogLPtLFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8HMBCXx; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso3709343e87.2;
        Sun, 27 Jul 2025 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753615401; x=1754220201; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH+hF6X7oXw4ClxhQYds/xBqemneYofiqs4R9ZE4QJg=;
        b=a8HMBCXxw+0WVP6QnOsGWXbsDj2HynwrvDL2rOK8v4cgjscr4QQ8weUJgpP1GJ3/Uq
         TWxPbsl2pRuo3AkTQgK8cAivLTTfO1ExgapOFLwFofm9lkRSEcv2Zb4I60wECT+qjly1
         zrJwof7fivBMkIhHiU2Wujf71FAdKWb+tTaHGKU81uLqmMqC7GLQVzmf5oeR63tEGe9d
         0kbiiHe9aNjEHdvMmRx2+orqC0z3sDYnBY2uVs5qocUq9RZs67SLwUhFORo2/4z7+NHU
         2GkliW0lGpRlkdYSedzrI9Z476igz7jVqrTpT0RNkCC2R2bWfTUva0DHiy8rM54GLVEH
         L9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753615401; x=1754220201;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mH+hF6X7oXw4ClxhQYds/xBqemneYofiqs4R9ZE4QJg=;
        b=BFbmTSlqpTYUKbK0xKAZorXDtCng/MaXLkGR02PeOLoOAIMPZ4rPRgySit0vTQh3VV
         YiH4VtnDHOZ6jeWI5k8RkdCPiEgegb1PVEW/hSPF7axuYKxRn0hedpJySM2kdishHpY+
         wXNCaKwgn3ctKAvYgcfWkZC2mSAQXBdMdKhOlCdwaHcxEc3HfS5TdffljOPqCWCdCaVj
         t5ro9xYpqoMNkrGEx00Tfu6QT+GSNiipBaIwhMXd/YQBTJ8cGva4206OQ/f46/NHycci
         aRjvdW8Lpy4e85hMUQBCFTvcBuAA2fINznjX4kpWAjDJ9I29mTAwVaYJlWz209VZftdZ
         QjXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ty/4wRaPa+R1UIp3kmUAP2bqXQDpMLXElvvnjJsHh7TEyaDuHxVb2m9ExzqHYAyTC3/hqkL6ZDY7uRg=@vger.kernel.org, AJvYcCWkeq40sj89YCUQDbFgAy+pCP9uG+u9wmVOFcNPCELXED3IgdflihSSjRPEPjko4lNErwnvznllBkZhL147YB4JSJ+kbA==@vger.kernel.org, AJvYcCXPy7EB5ORlDsHDiIdX9OPFuR1e8iBx9BWjgggjjbqeQ2jhihRjgvXdGyQAa5oFENyHR6CwZKdNPdo3@vger.kernel.org
X-Gm-Message-State: AOJu0YyfA7AR02JCe7gRUE4+N/iob6LPTnulas7HUlw/7Dpemc2ice9o
	GegUmpEAbg7a3KcpEoerc4KK9+BlOt6CLevJDBnO3koj4h9cEaahj9wY
X-Gm-Gg: ASbGncuesHh5Tg0wZu5sZNt1X5WrT+5UG64SDBD54lrFbMl/bQ1FxMsqwR8krKaoo2h
	r1rlHczGoPLNgZs7So3RYfZ8DvQge2ZwUNhZeM9eDrfkCFwTHPT/mV6Yraq/KFPlFbjwPD79ih7
	PpWf8unUjXkN1kZCwCi0Ej6RExhvi9LHXGu5Eo7IXc/H5USMPYZe0TicaAC5huSQ8hjc5jB5K0F
	/kcs1TpbMqtezEsqXYcPrq4+AsiQtTzsUcycN3evTgawoMOoCbVB6H6uMfrqeJfMgas5OAGFzuR
	k1LKVrXMZYd5UOgrBuvBHUUVgdxIACP39Gysgktz+CxsI2gKbAZLmFkyV0XNYSNnXAVly76bPpN
	dEuerMtE6qqR1lf+pRWuP/Fg7NJXlf22HZUuj5argUltAwp32Ix0lhvE4iKxD3cJv8tiX/dciut
	O/NiM=
X-Google-Smtp-Source: AGHT+IHopIfhDlCt4QLYGtHSzYsr+aJoUp1Wa68f3AaigkojxxjdA5LjMsUmRy5/8QStkRnbhnC/1A==
X-Received: by 2002:a05:6512:39d2:b0:553:2e92:2c98 with SMTP id 2adb3069b0e04-55b5f4aae0emr2359536e87.42.1753615400538;
        Sun, 27 Jul 2025 04:23:20 -0700 (PDT)
Received: from [192.168.0.122] (broadband-5-228-80-49.ip.moscow.rt.ru. [5.228.80.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316dbacsm815540e87.2.2025.07.27.04.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 04:23:19 -0700 (PDT)
Message-ID: <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
Date: Sun, 27 Jul 2025 14:23:18 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
To: Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux@weissschuh.net, fengwk94@gmail.com
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
 <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
 <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
Content-Language: en-US, ru
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
Autocrypt: addr=nikita.nikita.krasnov@gmail.com; keydata=
 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
 sXwISql2dLWvF4EeopUcuqEmcKFKXR+Ifbxj7A==
In-Reply-To: <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eH6SkTG0AdnNbgu7dAuAWro9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eH6SkTG0AdnNbgu7dAuAWro9
Content-Type: multipart/mixed; boundary="------------TglQFD0RCa0vksso3qE9Sr0F";
 protected-headers="v1"
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux@weissschuh.net, fengwk94@gmail.com
Message-ID: <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
 <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
 <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
In-Reply-To: <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>

--------------TglQFD0RCa0vksso3qE9Sr0F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello again!

Sorry for taking so long. Real life stuff gets in the way :(

On Tue, Jul 22, 2025 at 07:09:37PM +0300 Armin Wolf wrote:
> Take a look at https://docs.kernel.org/wmi/driver-development-guide.htm=
l.

Thanks! Coupled with articles [1] and [2] this was a very good
introduction to WMI and ACPI.

> Sure, but you have to develop a new WMI driver for your device because =
after looking at the
> ACPI tables (SSDT20 in particular) i came to the conclusion that the xi=
aomi-wmi driver cannot
> be used in this case.

Why is that? Is it because xiaomi-wmi is using deprecated GUID-based WMI
interface?

Btw, it's so weird for me that there are many laptop models, but only
one *-wmi.c file per manufacturer (be it Xiaomi, ThinkPad, MSI or Asus).
Is it because most of the time we write a driver for a specific piece of
hardware that may be reused in different laptop models?

> I suggest that you write a skeleton driver first that basically prints
> the content of this buffer to the kernel log using print_hex_dump_bytes=
().

About that... Would you be okay with me implementing this driver in
Rust? I assume it's you, an ACPI WMI DRIVER maintainer, whose permission
needs to be granted to green-light this?

[1]: https://lwn.net/Articles/391230/
[2]: https://lwn.net/Articles/367630/

--
Nikita Krasnov

--------------TglQFD0RCa0vksso3qE9Sr0F--

--------------eH6SkTG0AdnNbgu7dAuAWro9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEpkOhtFujpzRWyb0a4A5zBMF+d4YFAmiGDCcFAwAAAAAACgkQ4A5zBMF+d4YW
tBAAhBc+McB4cxT6NHvHlJJ+092CBWv2LpUJiwObGckAvT8CkSRMR6XJ2Ubch60DCLz6GjzOZbOI
lEkurg7YJL5hOmNXsYaytCDKVMq626W5eSwx+Bana4rrHFQklqRIUtVXmFlPl8qGbErBMb03CKAx
r2kVFQUFuiRAN+/vc/Mt2KK6XDi4b4qEWWt3vV7AY4EGsIWR+wvX/GpWxIJEtQquLwsQr7XOA4KH
1ujoXkxvG63BgNGO84yecUztEffQe0PJ6FMTvoCqilV9+/2ux47wsa4309K7+reycd1h5I4C0yul
F6jVbZz6VMENM/B5pdEV0InRfi/nGWgHbsa8P+EGzgwdrdl8lADpbzycR97rHZz/4kkJrEu6YV8+
BfCnCjmLn1B1wba2wW/GgwDI9zJO6GEk1SljTKP+pZvdD0ubu1IJHJguYaIML0v2ROKi1whJpaMl
Ebruc3tzUJcA29q3Lp1/+T5AT7Azi9o4bI30Zedzx8Yec3LnlLVv/OnugiiJ9QhMzy+0wHuqTH+w
jerVuX//yGmhAVjtMeUeNug96q8zNHuMss9X3M+te0LohNaqCWXA7Fm+4yjujWnfKNdrfD+EXmvF
brAzMUvoPTgWsF7rcMHSJXPI7mNzshokL3SHQ0R2D7mu8Ka4+rs87PnRVq79ozfsgGJ4UNwCH6fm
bcU=
=X/uL
-----END PGP SIGNATURE-----

--------------eH6SkTG0AdnNbgu7dAuAWro9--

