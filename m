Return-Path: <linux-acpi+bounces-15244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915EB0B552
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAE189BA91
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14762239085;
	Sun, 20 Jul 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdFSrr1Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD14238C3D;
	Sun, 20 Jul 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009128; cv=none; b=o1BYmLR7u4odTqGaKSy4PEOR79pTrjap/aPN2PkT/0XThQy5twvS7iPUi9Jlj0PP4xXZTe5WTpRM7xHzN+5HdXF0Np0V6+jGCTiGikgDqEr50FLS5kbS5A8/gKl3wYN1Rq96zKMGRohMJwRgl/ZzTVd6zAgkS0Zfmolt76yFtec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009128; c=relaxed/simple;
	bh=9ptC9Oay+7k5YUyyg7+s52P+/MPYZ/5s9RwW2MPvLR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=F5KaADGSnWFGqGyTBe57eUB2gxUnDqW026DEVNNdYwFs529VWXDu3Z2CdCKUDX4jNBitQuRYhRuljGuMYPii5/wUDD6PiBmnSz4kN1oHW8PUuy9XrY5eQVdj+w17GbD/DC9luBVvqk1VdfXFBozv2ub+HkVEkSzAe1rgHQQVyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdFSrr1Z; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-556373661aaso2950321e87.2;
        Sun, 20 Jul 2025 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753009122; x=1753613922; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ptC9Oay+7k5YUyyg7+s52P+/MPYZ/5s9RwW2MPvLR0=;
        b=SdFSrr1ZjiBMIP/0V2zwbGXIn+NIoBOb2MjLNgcm9xgCuPbH9HF2ZjSI8SvY53VgOC
         XT4pc/vIB4fEC5DfjWeeH/tKSpQC1pADnXj0majp+yJLaCm4U2ujBGkAbrmNayPIMv5R
         wt7xm5s+4FqlZ1+WG8iYjq2/F1xuUqKxyeZQstsLyjDD+I2TaPPupJJgEyl6Jmsg+lUp
         stp9H31/rKW9jqBwK2QKuLBGN1HbhnieBSkiDt+QqmS4l+2l0u2AazPv5ckB852ookPU
         9CcqeQ7pMPtu12KfQX76ffNY408ffV7IbGNQzvnVJrlyZohrK51UkVl/YYgg2AXOQ1z+
         j+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753009122; x=1753613922;
        h=in-reply-to:autocrypt:content-language:references:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ptC9Oay+7k5YUyyg7+s52P+/MPYZ/5s9RwW2MPvLR0=;
        b=H5YkMq1uP2EvIvc1CYMCu6/XeZPNDTn1laTGAOc+7VeDdTGb1RXBEhdP/g3J+X6127
         74XqJDYt1XkugHWjjDxopViGwHMDM/974frIonYRfLnEWFQKP6BWcgdnR7wIl1dhnJW2
         WC3Qu39cCD6VrynaixijYAaUGielL5M2EaPnZvnZFDttAMmhTuOo8DNM53bmXogtTk5K
         4S0272BCrGQXmWhW8CHURBGYPSA7CsGWxNbADFfEVd1c7M00rPbqrZuAzhKHHPXZJzsa
         ulkNxEH2vtYdC8W0rAcfxzmX+9bAUAvl4K1jqbU/3ZUOK79Xq8WUkZARoKkMu9zrIo4W
         idBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBnrYTFbsxbdTyAdzSN7VBAIrQ0UeQPmx3zIZq1QsjFUfoBZ2MlLB6bMnpf7ZY5jCy9lhCfbqfRHRm4Q==@vger.kernel.org, AJvYcCVGh1vjW+lKMnBknE/EK1bEQ6sbX7c/yZNzdQLSYJqosS5L6DXUMjB55jbEowUYpa0Q0YRueW+eichE1fw7a7vwbogykw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWCug2ZeKCcUb3nBvu2crAGwYTWAw2iKlhjA436Jz/AR2zxR7
	fp0ZF9ht+PRNjATaePs2N7Yc+jTIBAtCFPMPFEvOpzQMVG1oAuqksmIJLX8YW8Eufh4aLAyA
X-Gm-Gg: ASbGncuq3iA4bey0YkH33BvgoYOL9g25YESef/nqA4P29HrxBXeYeeL9wX2wQHWPr12
	LHnnDVtIsMCy/nFGfIAqbeq1mEpFAYTODVt8CBv4iVR62+VnJc/UlqrvVYibGokmdP+NsVF0rBf
	IaAOBAp0MxeVbOz+rlbO8CS2M3metcJuby8oUHWtszkCNoiVtmc5NQtRzNEdefFf7TThjjUsugd
	2+L8ZV+NiRX1yIdgdtifP//4eourBo5UCFU+K34Vv23CmhvbJtaSfIVUhMp3ZsmaIyqJo4k9IHX
	gBl9wL99tTRahwTDWgMxp3hVCCh5ArGc5m+hQl1JwDo0oE1niHfh/bmwXi49lAoMeQIe6BKST7d
	mRQ/N6X/LFKlnm8f3ejSDXntod3ujzRS60OgmEOJTDZps/7e5km+hex6VRtknJAzFPbS0EQZ4I+
	bzkGA=
X-Google-Smtp-Source: AGHT+IGmz5QJsafo95dE2Ss2O5KXN7/avbZdVPvzNvXR3sCtmfj82RhavZp6xnsnd+ciUpFKi1cbBQ==
X-Received: by 2002:a05:6512:31d6:b0:553:af02:78db with SMTP id 2adb3069b0e04-55a23301158mr5372411e87.5.1753009121599;
        Sun, 20 Jul 2025 03:58:41 -0700 (PDT)
Received: from [192.168.0.122] (broadband-5-228-80-49.ip.moscow.rt.ru. [5.228.80.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da2eedsm1081962e87.187.2025.07.20.03.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 03:58:41 -0700 (PDT)
Message-ID: <08a8e2ad-591c-4f2b-86f5-16ac2df1b17c@gmail.com>
Date: Sun, 20 Jul 2025 13:58:40 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, linux@weissschuh.net,
 fengwk94@gmail.com
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
Content-Language: en-US, ru
Autocrypt: addr=nikita.nikita.krasnov@gmail.com; keydata=
 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
 sXwISql2dLWvF4EeopUcuqEmcKFKXR+Ifbxj7A==
In-Reply-To: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dulKLqqXvU9cpxV9vADseYtR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dulKLqqXvU9cpxV9vADseYtR
Content-Type: multipart/mixed; boundary="------------FraTRrDnNE6YhD4WbN9bO8HD";
 protected-headers="v1"
From: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, linux@weissschuh.net,
 fengwk94@gmail.com
Message-ID: <08a8e2ad-591c-4f2b-86f5-16ac2df1b17c@gmail.com>
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
In-Reply-To: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>

--------------FraTRrDnNE6YhD4WbN9bO8HD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I wonder if this should have also been CC'ed to linux-kernel in case
there is someone with the same hardware, who might be interested in this
(I bet this also affects RedmiBooks 14 an 15).

I'm not subscribed to that list, so I'm not really sure what belongs
there.

--=20
Nikita Krasnov

--------------FraTRrDnNE6YhD4WbN9bO8HD--

--------------dulKLqqXvU9cpxV9vADseYtR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEpkOhtFujpzRWyb0a4A5zBMF+d4YFAmh8y+AFAwAAAAAACgkQ4A5zBMF+d4bL
xBAAqhrthPi9YBc0z4htc+CPmup0E8STwv3eVmqG701iV0x7SyOi36HzlGzXrjy5VKgFvwim3ScL
LWcHbib8s8UbymB2RZD6rHExDIqeGoROh7n7FU9hGfKY78Qrv1nepOVsSuJul6OUx6DmGZ2dH4LA
8jUATMu0apTXVZDyieQJJJ5n3HD6DGbdUs6GQ1gyGqNj3inr6UUs8jv8lAIqjW+NxsTmLtNBXk1x
/MwGZV6uSPmco5zDenFdalCs1luE0AgZ9i2PgkNCh3lCSs5U8Pw1oNgqkLVWVezOeZGZSqNMR5H+
ovYVf5IJE0SZrp/RkjCIyAaloLVXTJRM5pslxPhOVdQAggZgzDJepnfMLtlGxw1a0gGgrR2dujpC
lV7UFv3MYpNQOUfsy07wlcU44f/ZxDs3MvveZKYgw8+a8EqPrzJbS3R+ZXtAy5YwqgQMtF521G98
jhhgpkJ0HwiGsiYWf/SYh3a5t4Z2fZ+DbjQ9bXINMYGXe82RFY76p8k8z2/wNPU3em9TlTOMUuNS
NgXNzmdSO4mvXAX795lK+wzsLEtwBJ4u+FmE2AooxDN+DfcWlcU5ERsHvpVc+QRMit43D9IeeZJI
rV/Xylw1MZAPtvI+LiacTnoTZuGf8ELBhaeFzEzIvg/CaUVNiVLTuZ2I+KDT4C5F1JY/m1+SgK+I
dQc=
=jAfZ
-----END PGP SIGNATURE-----

--------------dulKLqqXvU9cpxV9vADseYtR--

