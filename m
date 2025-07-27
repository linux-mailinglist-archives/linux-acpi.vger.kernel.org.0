Return-Path: <linux-acpi+bounces-15331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F01B1327A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 01:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FA9174A6B
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71625179A;
	Sun, 27 Jul 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIU8YH9p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29C21D3D6;
	Sun, 27 Jul 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753659419; cv=none; b=KhmzJAqQK1sMMMxxi1ZNB9EV7GWgIMeJF/sMDhfBrFnqc1l7BaeM4jKKgE1vf7V9OPqfiUDSt8kQLQs5YqcOetzZ1YnkhcZFJgxyHmTY+zEw4aQP9uLPtY4gPgptgtg634aHCBHfYvPEP2Bwp2PTUEoT2gQfjojpXcmN0Fa2P9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753659419; c=relaxed/simple;
	bh=bgYEbEdpntujI+0+tlLZJOXL9xpeAhwVbORxH1eHGs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VKvoGowxpr+00IfM5zGB3FLar+FAaYboj7tOnCKoUlKkolrx9WWpmE5lYfZAzKAHT7mJzPP5m/fidkKXI3FAoL6TVqJXOB9heBKuyAyPQVle23OftjqmdqsTa5O0fnDC75Sa7EOsZyzJneusacZ1Hoo7BJQgww4p0+jMmSx3pC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIU8YH9p; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-558f7fda97eso3228854e87.2;
        Sun, 27 Jul 2025 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753659415; x=1754264215; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgYEbEdpntujI+0+tlLZJOXL9xpeAhwVbORxH1eHGs0=;
        b=aIU8YH9pdpjP+vDI9OF17RAuacs/UYEfPn+x4uLmuundgRsPk1ucgEb9ggxxJ+Vy0D
         ++IAD0Kt35B270ZsIifPosol/h8rqVBCg8Wipe1wv2bBoxjodm9cLSHhrHU6EcW+wr5O
         18akPem07fCfOynmTCdTskohAPgboUKodxLnNMXliI9yyhxQm33rBJzuGlVpnFFLofms
         2mahnYpwUC1qYlIBFDhO2+fVc39iHX30jzpinl2XI3uDEcjGxeZEoUDbMbJcxe5iyWVh
         bmuMYRgsEdgXpL+YWr3JXD13Og/yu3l5cLWotDNbva/cO86JxF4DFFacN8aHxS6TqWhZ
         3CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753659415; x=1754264215;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bgYEbEdpntujI+0+tlLZJOXL9xpeAhwVbORxH1eHGs0=;
        b=gR8KNF9qvin6upDIyW7QtIBvju9XPlIFjAOZeGrANENf5mCIMGYF5o0GQzZpcNUBeP
         zcRMUWzM7M+I92sIGJ5o3o7N6hPs+FGu9hCfQf390cso7tTdshe+O8xM8Se1sUiizVz0
         gpiI0yB4ULRUVkEZ4zGukrIcVBgiKEnum6XRX4pnhdrXv+nvDLeFjLLpAjWpRHCZ3X98
         9baoNcL8z3zP+dZ6sHjAHDaCjL5zzp+rjazcdwqfzhWPKQ8Tl/OBNoEpoDIW7jJUFRJK
         BkWIGUbl3Ynf4kT8ly8XrFfBGjJIuYdkLHOFsyBXP6cwQM9vk1WSY0LG2b+oHbjC3siN
         BJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUKtshDTwt/t63w205EpSrT4Xhe2mC05qunPDtbOJM4vkxTneKaI6ymViavUqxsS8ocTYq40ZorU6kNlQY=@vger.kernel.org, AJvYcCVUjfj1tcdZ/mKJM7quO1AmmRICp4APRvI96vzDq5NqZ6NjeBwQV9YaBjqxh/bZLCIR1fcqE5YFJWcL@vger.kernel.org, AJvYcCXr/zgzDxJzc4PryjuqBu7AmDVywSlUmbuMorf2erEjEl543K1zQeztR8NZ6mQ9PM0NsTAkIBSvpr/V8eufsemSQ6cyVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7zmTIa0Qrb223WudF+tFkl//OfAsBfeCvoH+TvR+2rZT0k3A
	uX88CIEHNYVt8eUfIYgdMXVJ2q1ccvyFGWHQ2ph/z+vcsgiu3n1d8g5p
X-Gm-Gg: ASbGncvGloRTIh6QvXEYLi6PVfFcyw+1fggfZddPldkCXTcZ1IPdNr/8cf2k9B31nLQ
	56+GFOCIR7MpmAQgTy3zjUi3IbOIE+jC7UBjLTMc8wtJtct1ij63F72GjhzvcyDocCHPDVEARYl
	PyxBX7/DoRldS0XS2U0aW//jafy/m8G/2w4wXHC1i8rAfurUYH+IRthj86wUxJHSr/pFFtiBetT
	1m2XdxaM07iwBl0NepQrRTuUIgXSX2ATqeho4sCgSVFahUYrXktqJePvkEFBVGPeWUlcm51gCHD
	DUki2SjXQEPywRLWp63RLYtkHfh6XbmEpOFS9cgwLWlK3PDpZ6V1IZQj1i8Gw9vYsnjMGygh1Yg
	oWeNu0N4hmEvv04Eb0YD+f/U6/XC8dz7pxGIJHZMf17QSVIw7ThB7UtUNpHLoNI/yGWi1SDoXcZ
	/7FaMV
X-Google-Smtp-Source: AGHT+IG7rNsveIL5z9vdCFnAV2R5yM3MZs576IAup5sZaIbjDEpKj7RlkHeUOMQ2741hgPG4PVCqyw==
X-Received: by 2002:a05:6512:3d8b:b0:553:a4a8:b860 with SMTP id 2adb3069b0e04-55b5f30da89mr2932829e87.0.1753659415019;
        Sun, 27 Jul 2025 16:36:55 -0700 (PDT)
Received: from [192.168.0.122] (broadband-5-228-80-49.ip.moscow.rt.ru. [5.228.80.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b631860cdsm989537e87.58.2025.07.27.16.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 16:36:54 -0700 (PDT)
Message-ID: <103ed888-ec6c-4b46-b03e-f2803850eec2@gmail.com>
Date: Mon, 28 Jul 2025 02:36:52 +0300
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
 <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
 <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>
Content-Language: en-US, ru
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
Autocrypt: addr=nikita.nikita.krasnov@gmail.com; keydata=
 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
 sXwISql2dLWvF4EeopUcuqEmcKFKXR+Ifbxj7A==
In-Reply-To: <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IHwopb0YNHAHkCQcBilIbn6Q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IHwopb0YNHAHkCQcBilIbn6Q
Content-Type: multipart/mixed; boundary="------------71hwXFVIohIZZBIGJmzT0R3U";
 protected-headers="v1"
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux@weissschuh.net, fengwk94@gmail.com
Message-ID: <103ed888-ec6c-4b46-b03e-f2803850eec2@gmail.com>
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
 <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
 <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
 <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
 <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>
In-Reply-To: <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>

--------------71hwXFVIohIZZBIGJmzT0R3U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> No, it is because your device is using a different WMI interface for de=
livering events. Device manufacturers
> are not exactly known for using the same WMI interfaces for a long time=
 :(.

By the way, how would we call this driver? xiaomi-2-wmi?

> Personally i have no problem with you writing a WMI driver in Rust, but=
 currently we have
> no suitable bindings for the WMI driver API. Additionally i am currentl=
y designing a new
> WMI driver API that will make it easier to implement the necessary Rust=
 bindings, so the
> whole thing might take some time.

Well, I am fine with having to implement the missing Rust bindings =E2=80=
=94 no
problem there. I was actually looking forward to it. But if the API's
going to change... Oof.

 * Would the API change be _that_ drastic?
 * Do you have any expectations on when would that API be released?
 * Would the new API deprecate the previous one?

Maybe I could do this in Rust right now and then simply update the
bindings to the new API? That way it would be possible to write the
driver in Rust. If the API is going to change =E2=80=94 the C code would =
have to
be updated either way, right? Maybe updating C driver versus updating
Rust bindings+driver is not that big of a difference. What do you think?

I doubt there are going to be so many Rust WMI users that it would get
really difficult to move anyone to the bindings with a new API..? How
active is the WMI submodule (is it actually a submodule or just a
component of ACPI) really is?

> Would it be possible for you to implement the WMI driver in C?

Yea, absolutely! I'm totally fine with writing this in C. I just really
don't want to miss the opportunity to use Rust here (is it's actually
feasible)!

--
Nikita Krasnov

--------------71hwXFVIohIZZBIGJmzT0R3U--

--------------IHwopb0YNHAHkCQcBilIbn6Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEpkOhtFujpzRWyb0a4A5zBMF+d4YFAmiGuBQFAwAAAAAACgkQ4A5zBMF+d4bW
Fg/+LbPRztBE5oBbkEbZYSl0NUlc9YuoE7BxoXzxUJgGIkdbCvMWUHfMTQxq+Sgyv3C8hwgx/ujV
vBY2A4dXJKCMR303i23aT+M5c84OrYXmo1o3X0Y1rNwQOuvS0LLD6B+igvYA0ryoGdW0M8Dd53Yg
frN0dnX61mK4rJaF7XRZn/zulNoy2hjYtycAhiNIdzpEYqW1Wy6Tx2Zi6vlcFO341BfNOXOY67cY
oA2q8ahjCiy+HstTQs2V3trhpYM90cjb/tlRBTpvkJIYse6hLlSjwLBmwpinvpnI4mUZlTsKYjTv
DmTIlh+vDMn/PFSKL/2Ot2CtWQ2hfVigF5ONR9vOOr6ylUXEQ8Uo/GyUjTQvt0oyjn8S+cxZ5MTq
bviarFnvYZVNrrimcJygHceutHj7fGHQX6VQEfFjLwEn6RO2q9Kt44hJi2APKx/Ze/RGOb+Bp6eK
CGUkq8Jp7I3/mW+AOxF9uO3xgzABNvy6LI1oFd8YG9jfSycS2qAGn7/o7XwyQda3axqOl9U/RWO4
0YVotwmolcJg+zH/x8frBLlxF9SxC9ak64yMnWTeCQLnu9HYnuA9Nz6pUUHvrvb0h8c9us5ctSZQ
BUUlHvCRtDrx4ZgFxLYY4cHOWfyEqXRZYsPWnwpkprzXKENvc0k0/IzMljc10snk+/907kD3rsnD
XLU=
=GGOc
-----END PGP SIGNATURE-----

--------------IHwopb0YNHAHkCQcBilIbn6Q--

