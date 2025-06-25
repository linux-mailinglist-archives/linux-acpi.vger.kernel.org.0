Return-Path: <linux-acpi+bounces-14654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412DAE904C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7495B7A5123
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32825486D;
	Wed, 25 Jun 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lraYxEZR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B02522B5;
	Wed, 25 Jun 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887833; cv=none; b=QRbEkGSpacJFUjqZGRdIa0xecVGHE7j+K7bdcPo+A3TZGDpgXv1Ev4ttPYd6i0QyIwr4lE3vQt07zZwFfFMuf+90IVqaj5uYs6HVwY/HrX2dWgTf5ZG1OhDoaubpWmSWKbwhhx7qo1sIgYBBLxWVFoS3U3G88ZLiDyeEaDyU7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887833; c=relaxed/simple;
	bh=2SZExfbBxCdjXT3nXpaLibbqwNAS9/9Pw/pMGO0q3qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBeCujn754X/96TScnPTmGnXC7TumN0piwMEGP9oTbFMNinoNZeurjUbjM0o1AvygM0ml/kBvyjLeLoHtMBsIMRZNfGYMR9jzoCzjwY+8wu4b/bMC2IfCkoFlXrrCk/2dlgtkXLt0Luz9kfUWzbofaTlhLWoU5wuGKARD2TLMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lraYxEZR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso2634705e9.3;
        Wed, 25 Jun 2025 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750887830; x=1751492630; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2SZExfbBxCdjXT3nXpaLibbqwNAS9/9Pw/pMGO0q3qM=;
        b=lraYxEZRK1qbw6hBxA0rtmbhauOKzs1LtzfjNgUetafzH29PhaNipcfhcHHUzumJR1
         b1K60o5jT4DPHRYOiU+4B5iKOk+4Q4rs2qCDAS4tSvES99rc58d67BgjpwbC6ZUwcSDf
         CwNQXoGTV0y54ybVKBdgIUHhPlRW8GGIyqfqx3PCgv4Nggz0T0GLBWXGLwI28vd4PqT/
         YjJ2k8tyNb+xCjR0rOwYQwISrUWOuJg4KeQkFmdAjinao3x0ZdHKEfDIBD7Ne8f4+MXn
         rhdCS3WgW+uOWUVd11N43dnKv08AFWMJsLIQZ7J40pV19j24b310r6Fwz1g/bP2TX2+/
         BqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887830; x=1751492630;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SZExfbBxCdjXT3nXpaLibbqwNAS9/9Pw/pMGO0q3qM=;
        b=j3jsPY4GPO0qcpYmKf2caN+zjBe54E0Zl637275Vubnz1MqSqFUjui7nBSxudFRfcV
         ufa4+W3cn6HyOgkVCz86aB1Xg2gyaKD1Zanp9dIqMPZ+ixcW9NISio4chKLQ8tAVJF2h
         +dH37XBHuf2MM7/i1jqGIK/7qzSQOMRL0DE70cBZXqjJ8MMOeO/M67qFR/Sra7OQ/HPd
         9I72JhkYg86kXsQkokDNx8tOmtxkc/J7apfpfEqeTcEKvY50zsewbZNAzQuksaK8jdgO
         cQE6/iHzQbqkeFWIfRo/wsGPPAFiXYlWXImdhDf3RdXt6+iZrpYZ2XEo1yaZgia4Yayj
         d2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUXIROtm3Icf7gAO5DHP3GU/VkL2A27ZzCn7GP4z1RUYKZH9bDeYiUSr09NTilu6qrXCW0ZgI3Mhe5Yakq1@vger.kernel.org, AJvYcCVzhYBglRkYcVrwXk22vMzCm4hrD6OnDQfrh6rGiFBqN3K2NsqfkaX1tBgQsupVWAX2bRqeKF4MQ92t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5i2LaxlFBDLiZUr3em63KZyKokdbrZ/DONVkhM0/i2ak0pquK
	0fS25AglQLF+RMvhA0CVOJoY1V5f1NPpopxqN4t282t6JxFCZ28H3AjM
X-Gm-Gg: ASbGncv4rC6mAo7pUARndMgp/rSOGz++7M4aMlZRci2fLdERG9lbcyvFxQJpzqilrPm
	CYx8SmONtFvOC3ZUN2Ty4RPgjb4PF66UkJaD7RnrLAdWu/eQl7OkN9MeYGLslGlT9LSagX9Ai9i
	JZuE20Nqq+sL+oVfLpR3A+zmTL6VGkFOaHlV8LnivEeqjKJG17Bl4k40rIIuyecXxxH87tX7vKI
	FmLtBfc6PnaWiDLkcYSUyiRrqc5GmM2yh4y41luXpZZD0n1LfHmdY2v3GJf8fPY98Z7pyxL015D
	2+MAWvQvlq4H+niB7ZjP4q7Pw8RdZUUEQ2VYKkM/vwrVbOG7fYtYUp3zJ5K2/wEFee1s
X-Google-Smtp-Source: AGHT+IFB8SzJYKZUPjP0PWCFwfbAYdzIsdaPfSfA8LsMxqALSWVgQLKV6sqPz9X3ekPTOpjgWzuxww==
X-Received: by 2002:a05:600c:608e:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45381b0f384mr44222385e9.18.1750887829596;
        Wed, 25 Jun 2025 14:43:49 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm7952265e9.21.2025.06.25.14.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 14:43:48 -0700 (PDT)
Message-ID: <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
Date: Wed, 25 Jun 2025 22:43:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
To: Ira Weiny <ira.weiny@intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624202937.523013-1-colin.i.king@gmail.com>
 <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------P6U6XF6hdvXUhpfBAg0ydKSF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------P6U6XF6hdvXUhpfBAg0ydKSF
Content-Type: multipart/mixed; boundary="------------Nc6u78Mr0hUTBjyuvtzFXzB1";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Ira Weiny <ira.weiny@intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
References: <20250624202937.523013-1-colin.i.king@gmail.com>
 <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>
In-Reply-To: <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>

--------------Nc6u78Mr0hUTBjyuvtzFXzB1
Content-Type: multipart/mixed; boundary="------------W1eyTsla8yMZ8uYWQm8LvK0u"

--------------W1eyTsla8yMZ8uYWQm8LvK0u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUvMDYvMjAyNSAyMjo0MCwgSXJhIFdlaW55IHdyb3RlOg0KPiBDb2xpbiBJYW4gS2lu
ZyB3cm90ZToNCj4+IEluIHRoZSBjYXNlIHdoZXJlIGEgcmVxdWVzdF9tZW1fcmVnaW9uIGNh
bGwgZmFpbHMgYW5kIHBvaW50ZXIgciBpcyBudWxsDQo+PiB0aGUgZXJyb3IgZXhpdCBwYXRo
IHZpYSBsYWJlbCAnb3V0JyB3aWxsIGNoZWNrIGZvciBhIG5vbi1udWxsIHBvaW50ZXINCj4+
IHAgYW5kIHRyeSB0byBpb3VubWFwIGl0LiBIb3dldmVyLCBwb2ludGVyIHAgaGFzIG5vdCBi
ZWVuIGFzc2lnbmVkIGENCj4+IHZhbHVlIGF0IHRoaXMgcG9pbnQsIHNvIGl0IG1heSBwb3Rl
bnRpYWxseSBjb250YWluIGFueSBnYXJiYWdlIHZhbHVlLg0KPj4gRml4IHRoaXMgYnkgZW5z
dXJpbmcgcG9pbnRlciBwIGlzIGluaXRpYWxpemVkIHRvIE5VTEwuDQo+Pg0KPj4gRml4ZXM6
IDFhMzVjODgzMDJhMyAoIkFDUEk6IEFQRUk6IEVJTko6IEZpeCBrZXJuZWwgdGVzdCBzcGFy
c2Ugd2FybmluZ3MiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
Lmkua2luZ0BnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9hY3BpL2FwZWkvZWlu
ai1jb3JlLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYXBlaS9l
aW5qLWNvcmUuYyBiL2RyaXZlcnMvYWNwaS9hcGVpL2VpbmotY29yZS5jDQo+PiBpbmRleCA3
OTMwYWNkMWQzZjMuLmZjODAxNTg3ZGY4ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYWNw
aS9hcGVpL2VpbmotY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL2FjcGkvYXBlaS9laW5qLWNv
cmUuYw0KPj4gQEAgLTQwMSw3ICs0MDEsNyBAQCBzdGF0aWMgaW50IF9fZWlual9lcnJvcl90
cmlnZ2VyKHU2NCB0cmlnZ2VyX3BhZGRyLCB1MzIgdHlwZSwNCj4+ICAgCXUzMiB0YWJsZV9z
aXplOw0KPj4gICAJaW50IHJjID0gLUVJTzsNCj4+ICAgCXN0cnVjdCBhY3BpX2dlbmVyaWNf
YWRkcmVzcyAqdHJpZ2dlcl9wYXJhbV9yZWdpb24gPSBOVUxMOw0KPj4gLQlzdHJ1Y3QgYWNw
aV9laW5qX3RyaWdnZXIgX19pb21lbSAqcDsNCj4+ICsJc3RydWN0IGFjcGlfZWlual90cmln
Z2VyIF9faW9tZW0gKnAgPSBOVUxMOw0KPiANCj4gQXBwYXJlbnRseSBteSByZXZpZXcgb2Yg
dGhlc2Ugd2FzIHByZXR0eSB3ZWFrLi4uICA6LS8NCj4gDQo+IFRoYXQgc2FpZDsgV2h5IG5v
dCBza2lwIGEgZ290byBhcyB3ZWxsPw0KDQpCZWNhdXNlIHRoZSBnb3RvIHVzZXMgYSBzaGFy
ZWQgcmV0dXJuIHBhdGggYW5kIGhlbmNlIHJlZHVjZXMgdGhlIGFtb3VudCANCm9mIHJldHVy
biBlcGlsb2d1ZSB1c2VkIGluIHRoZSBnZW5lcmF0ZWQgY29kZS4NCg0KQ29saW4NCg0KPiAN
Cj4gSXJhDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FwZWkvZWluai1jb3Jl
LmMgYi9kcml2ZXJzL2FjcGkvYXBlaS9laW5qLWNvcmUuYw0KPiBpbmRleCBkNmQ3ZTM2ZTM2
NDcuLmZhZTAxNzk1ZTdmNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL2FwZWkvZWlu
ai1jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZWluai1jb3JlLmMNCj4gQEAg
LTQxMCw3ICs0MTAsNyBAQCBzdGF0aWMgaW50IF9fZWlual9lcnJvcl90cmlnZ2VyKHU2NCB0
cmlnZ2VyX3BhZGRyLCB1MzIgdHlwZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKHVu
c2lnbmVkIGxvbmcgbG9uZyl0cmlnZ2VyX3BhZGRyLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAodW5zaWduZWQgbG9uZyBsb25nKXRyaWdnZXJfcGFkZHIgKw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZih0cmlnZ2VyX3RhYikgLSAxKTsNCj4gLSAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+
ICAgICAgICAgIH0NCj4gICAgICAgICAgcCA9IGlvcmVtYXBfY2FjaGUodHJpZ2dlcl9wYWRk
ciwgc2l6ZW9mKCpwKSk7DQo+ICAgICAgICAgIGlmICghcCkgew0KPiBAQCAtNTAyLDcgKzUw
Miw2IEBAIHN0YXRpYyBpbnQgX19laW5qX2Vycm9yX3RyaWdnZXIodTY0IHRyaWdnZXJfcGFk
ZHIsIHUzMiB0eXBlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFibGVfc2l6
ZSAtIHNpemVvZih0cmlnZ2VyX3RhYikpOw0KPiAgIG91dF9yZWxfaGVhZGVyOg0KPiAgICAg
ICAgICByZWxlYXNlX21lbV9yZWdpb24odHJpZ2dlcl9wYWRkciwgc2l6ZW9mKHRyaWdnZXJf
dGFiKSk7DQo+IC1vdXQ6DQo+ICAgICAgICAgIGlmIChwKQ0KPiAgICAgICAgICAgICAgICAg
IGlvdW5tYXAocCk7DQo+ICAgDQoNCg==
--------------W1eyTsla8yMZ8uYWQm8LvK0u
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------W1eyTsla8yMZ8uYWQm8LvK0u--

--------------Nc6u78Mr0hUTBjyuvtzFXzB1--

--------------P6U6XF6hdvXUhpfBAg0ydKSF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmhcbX4FAwAAAAAACgkQaMKH38aoAibj
rQ/5AfP91zZC0u39MPWm/eBgThTRUtIG93fQqU9I7Df2ANtuXU4t3fZ/SC2HzUXcQfGVDniDiNw7
hoFa2KDgr+1Pnt9ME5DMxmsDHg7HIMN1UglCmJP8au+6au5YbI+Txn5yVOw/vHn/XKfXux6KPo60
lHAsT11HUVUmaDX2kZ38EPc4yCIa+WTrR3EoqcDvgSlk6EenFtgDmLEccyiLgpiTL8yOiJG2SUMU
6Wv3LzHS5yWhaf4Camd/RBbYqZz6jEUeVOJIRTPMWdvq2CpvDfZsnzWT6foxLEX+tZI2a1c4OrJS
XF7vTc/HnnxG5doZQH+fVcds6wVW13aBNWpRu/cMCckXWcdi4GQKqIiA4jDljRm7bWeFfbCxO6Xz
tZyy03LA1K3tggeNH2PTqa1+lH7RbCn2pzr/ZCxvZw8SxSir5z/4woPmiYE62YyGzhM1ZiyL1yEE
o/GQXWyXIVXfbpUXZVUcZuqyWnLH328kJOX9IyTt4UQYdj/txrCLrSvqnLQANqC+yvISEJlvI5/i
s1FALy8QnPRdlogKeqiUTGbgybAMDz3ZPm5OgcSvUHL6KDu8Qi/DHChRdHXA2CMCGYNHSClkiIzc
QcIYUuwhUazRapjBb9G52xmHeGErun5O5JyS7HHHC72ZURQpxohny0jbIDO2wraq7iYaUeuF5uwI
H8k=
=/sWh
-----END PGP SIGNATURE-----

--------------P6U6XF6hdvXUhpfBAg0ydKSF--

