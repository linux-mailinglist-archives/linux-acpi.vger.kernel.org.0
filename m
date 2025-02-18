Return-Path: <linux-acpi+bounces-11272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F497A3A73A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 20:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBBD3A3C48
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84E17A30B;
	Tue, 18 Feb 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqGPTzyh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F321B9DF;
	Tue, 18 Feb 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906417; cv=none; b=JBresdI9NRDZgZzBsBUARvB8Qgz3Gdf4uwHNZKkOuubIWgsK3jvsDFTyGi8YBx81C6weoKIHLGdIGZzvjrgk5KFFefOv8ThftoHyhyzruxj3JFmKZ4h6756vbVvZEzF8tM+SoR+zcOrtx2y9qiOtsAVr5FB/fMyL34W5yGmMljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906417; c=relaxed/simple;
	bh=hD55sSpwhHslsVPUR0Ld9aCicTJdXolKzxaz1+Knj34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT15JWox44rgNW6NSuosTXlt19N+pDm0BGK3FB9MFV4Rq/H75nYNk8301BwvjuQVDDpkBNYCuqFTFICQZFvdSxtGgyI2rkSOHqZAG7WXgVDy1YR3zbzVipWDB1ALNhWclviw2ismyq1tc8g8xjrTg6+Ra2V09yNx+PeKRwzkkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqGPTzyh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso65708105e9.1;
        Tue, 18 Feb 2025 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739906414; x=1740511214; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hD55sSpwhHslsVPUR0Ld9aCicTJdXolKzxaz1+Knj34=;
        b=IqGPTzyhqjWopnglQmbLtJ8bjtjb6Z5t0Wk2vfunBgKB/IlYTAekfTpcdDtSycLLZ7
         yizA8sk1dqLS8rUv2/51szQrElgvQfyTlZXERrUSyMj2/2uyVR6l9iWhClfoUrc8gWJl
         QfSypEk8A+QBdHkg6NcYoU45zJ3h28AJxDJ+mdWzLTeEbrDtyN7vNdMStqWYx8S3zNFY
         PJK3vRP9nAtgiNyqJ649HRGIhV1mxdY90lShgnY8E2Lir9+2G0i5dU1Y9ezYbfOc/NOm
         dDF+KuLNGBPpGL8i5ZmILBRlMwQRsXB9PIGIzq9eS+wPi7XMwTtByrznvDVq0hpp+zvJ
         43PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906414; x=1740511214;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hD55sSpwhHslsVPUR0Ld9aCicTJdXolKzxaz1+Knj34=;
        b=FwZrA1OPSKPZzvab9N/0uKs8u+Ar4JxldWjtKtdfiMa12sAP6jIB9M6hPr3HkbrJ0H
         pQ2lVST6reoBrL5/iKdPwdPEMd5AJMYSf74n+jcKpe4UbuSv1ePiCxsod+Prgipyr2af
         556PLny+n4PpJfY2Ch//XBwzsgZTEL+INsO24C+qLDH9GfDnTPMo/DDzOtNKhZcKEOW+
         r2rtzsaAo7bdH+4N0lxoZmVuSx51JRUO7g0N27BCbA5hK1LgOkQWjj01wfjXthWq4ItN
         tRjT1fTwIqYw/hJRr7YoQyT9WGPbT59CDXMgzJYkhgdWcLb5B521++2TLWECmWEV2c8U
         WBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUVZyg5z3c06itfPZy83BHbjTC35xXeeVLlvb59NiU+3LlpTaF1CjeZCeTWUAH6JXcK0vjgps1GfEbDH+Mq@vger.kernel.org, AJvYcCVgjv7VXSGGrpaYj+I1DlqPqhLCoH3APngcdCDhXhcz/J/lq93gMhc0lnIeEs1XFNiDs3P+ABxWwevG@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkidBh/N4xf01AcqJ7rtqNTCkZ9d55ZuhYC0I7PyTrEX6BYmT
	5K3tJbzC3EZacl83hyjAwAC5AzkmVJF1Wuuv0jhVYheItRawIKok7MDRsJyG
X-Gm-Gg: ASbGncvubRbZmL5u/D0qbFDZmL8K/Pi3dO1R1f28SgsatnHEy0JBFAwOzU8yeDZfzQ0
	zXIZwBM1kYr80kqUCvLHwkMBp672tXVY0htRq8D6J5hUQaIDt6InRcpostfBjDV4K3jT0zkmTv0
	dNHDteIZV6W5jV5lXw0VqielPJ/K+FGkN8OuasO0FxcT52RQNrBqt3P2Ou1QEr11Zk+rHTqBqZA
	nlHuR5vH5/7u/iVY5gN7TkwL3/4JrBEefC/2GYCN9lNgA+lTF0mgVcGLKDHwydplKtmF8ZsWSLj
	Iuf44n5fxmfdJR1U21iIYu/c
X-Google-Smtp-Source: AGHT+IG5ogkquVmkIfkGUHuUvgsZtVmTespfyxQCxuChQ7Vk1qo4GtrtkPIefqBeoLlMQ/CZXV/UrA==
X-Received: by 2002:a05:600c:468f:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43994241ea8mr48133875e9.30.1739906413488;
        Tue, 18 Feb 2025 11:20:13 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43959d3d5f3sm191266205e9.0.2025.02.18.11.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:20:12 -0800 (PST)
Message-ID: <9844dd71-4969-4115-bc8c-63ced7d61bbf@gmail.com>
Date: Tue, 18 Feb 2025 19:19:43 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ACPI: OSL: ratelimit ACPICA kernel messages
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250213181610.718343-1-colin.i.king@gmail.com>
 <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wb2bl06WJJkL5zKi3pM4mtRs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wb2bl06WJJkL5zKi3pM4mtRs
Content-Type: multipart/mixed; boundary="------------6SeyVOvwW62QlbOK8vyPJSI2";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <9844dd71-4969-4115-bc8c-63ced7d61bbf@gmail.com>
Subject: Re: [PATCH][next] ACPI: OSL: ratelimit ACPICA kernel messages
References: <20250213181610.718343-1-colin.i.king@gmail.com>
 <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>

--------------6SeyVOvwW62QlbOK8vyPJSI2
Content-Type: multipart/mixed; boundary="------------sU8fh7n70SzzLuqYfDLh5O7R"

--------------sU8fh7n70SzzLuqYfDLh5O7R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTgvMDIvMjAyNSAxOToxMywgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ICtTYWtl
dCBEdW1icmUNCj4gDQo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDc6MTbigK9QTSBDb2xp
biBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSW4g
Y2FzZXMgd2hlcmUgdGhlIEFDUEkgQU1MIGNvbnRhaW5zIGVycm9ycyB0aGVyZSBjYW4gYmUg
cXVpdGUgYSBsYXJnZQ0KPj4gYW1vdW50IG9mIEFDUElDQSBrZXJuZWwgbG9nIHNwYW1taW5n
Lg0KPiANCj4gRXhjZXB0IHdoZW4gc29tZW9uZSB3YW50cyB0byBzZWUgdGhlbSBhbGwgd2hp
Y2ggYWxzbyBoYXBwZW5zLg0KPiANCj4gQW5kIHdvdWxkbid0IHRoaXMgYWxzbyByYXRlIGxp
bWl0IGRlYnVnIG1lc3NhZ2VzIGZyb20gQUNQSUNBDQo+IHNwZWNpZmljYWxseSBlbmFibGVk
IHZpYSB0aGUga2VybmVsIGNvbW1hbmQgbGluZT8NCj4gDQo+IElmIHNvLCBJJ2QgcmF0aGVy
IGZpbmQgYSB3YXkgdG8gdGVsbCBBQ1BJQ0EgdG8gYmUgbGVzcyB2ZXJib3NlLg0KDQpZZXAs
IG1ha2VzIHNlbnNlIFJhZmFlbC4gVGhlIGNydXggb2YgdGhlIG1hdHRlciBpcyB0aGF0IHRo
ZXJlIHNob3VsZCBiZSANCnNvbWUgd2F5IHRvIHJlZHVjZSByZXBlYXRlZCBpZGVudGljYWwg
IkFDUEkgQklPUyBFcnJvciIgbWVzc2FnZXMsIA0KZXNwZWNpYWxseSB3aGVuIHRoZSBBTUwg
aXMgdHJpZ2dlcmluZyB0aGlzIDEwKyB0aW1lcyBhIHNlY29uZCA6LSkNCg0KQ29saW4NCg0K
PiANCj4+IFJlZHVjZSB0aGlzIGJ5IHJhdGUgbGltaXRpbmcgdGhlIG1lc3NhZ2VzLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwu
Y29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYWNwaS9vc2wuYyB8IDIwICsrKysrKysrKysr
Ky0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvb3NsLmMgYi9k
cml2ZXJzL2FjcGkvb3NsLmMNCj4+IGluZGV4IDVmZjM0MzA5NmVjZS4uZDRlY2U2OGUwZmQ2
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9hY3BpL29zbC5jDQo+PiArKysgYi9kcml2ZXJz
L2FjcGkvb3NsLmMNCj4+IEBAIC0xNTksMTcgKzE1OSwyMSBAQCB2b2lkIF9fcHJpbnRmKDEs
IDApIGFjcGlfb3NfdnByaW50Zihjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJncykNCj4+
ICAgICAgICAgIGlmIChhY3BpX2luX2RlYnVnZ2VyKSB7DQo+PiAgICAgICAgICAgICAgICAg
IGtkYl9wcmludGYoIiVzIiwgYnVmZmVyKTsNCj4+ICAgICAgICAgIH0gZWxzZSB7DQo+PiAt
ICAgICAgICAgICAgICAgaWYgKHByaW50a19nZXRfbGV2ZWwoYnVmZmVyKSkNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHByaW50aygiJXMiLCBidWZmZXIpOw0KPj4gLSAgICAgICAg
ICAgICAgIGVsc2UNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0NP
TlQgIiVzIiwgYnVmZmVyKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAocHJpbnRrX3JhdGVs
aW1pdCgpKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocHJpbnRrX2dldF9s
ZXZlbChidWZmZXIpKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmlu
dGsoIiVzIiwgYnVmZmVyKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRrKEtFUk5fQ09OVCAiJXMi
LCBidWZmZXIpOw0KPj4gKyAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgIH0NCj4+ICAg
I2Vsc2UNCj4+ICAgICAgICAgIGlmIChhY3BpX2RlYnVnZ2VyX3dyaXRlX2xvZyhidWZmZXIp
IDwgMCkgew0KPj4gLSAgICAgICAgICAgICAgIGlmIChwcmludGtfZ2V0X2xldmVsKGJ1ZmZl
cikpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoIiVzIiwgYnVmZmVyKTsN
Cj4+IC0gICAgICAgICAgICAgICBlbHNlDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBw
cmludGsoS0VSTl9DT05UICIlcyIsIGJ1ZmZlcik7DQo+PiArICAgICAgICAgICAgICAgaWYg
KHByaW50a19yYXRlbGltaXQoKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHByaW50a19nZXRfbGV2ZWwoYnVmZmVyKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcHJpbnRrKCIlcyIsIGJ1ZmZlcik7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhL
RVJOX0NPTlQgIiVzIiwgYnVmZmVyKTsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAgICAg
ICAgICB9DQo+PiAgICNlbmRpZg0KPj4gICB9DQo+PiAtLQ0KDQo=
--------------sU8fh7n70SzzLuqYfDLh5O7R
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
bmdAaW50ZWwuY29tPsLBjgQTAQgAOBYhBHBi2qTwAbnGYWcAz2jCh9/GqAImBQJn
MiLBAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEGjCh9/GqAImQ0oP/AqO
rA08X6XKBdfSCNnqPDdjtvfQhzsO+1FYnuQmyJcXu6h07OmAdwDmN720lUT/gXVn
w0st3/1DqQSepHx0xRLMF7vHcH1AgicSLnS/YMBhpoBLck582FlBcHbKpyJPH/7S
iM5BAso0SpLwLzQsBNWZxl8tK8oqdX0KjmpxhyDUYlNCrCvxaFKuFDi9PmHOKghb
vdH9Zuagi9lM54GMrT9IfKsVmstzmF2jiFaRpuZWxNbsbxzUSPjXoYP+HguZhuNV
BwndS/atKIr8hm6W+ruAyHfne892VXE1sZlJbGE3N8gdi03aMQ+TIx5VLJfttudC
t0eFc50eYrmJ1U41flK68L2D+lw5b9M1+jD82CaPwvC/jY45Qd3NWbX8klnPUDT+
0foYLeBnu3ugKhpOnr4EFOmYDRn2nghRlsXnCKPovZHPD/3/iKU5G+CicRLv5ted
Y19zU0jX0o7gRTA95uny3NBKt93J6VsYMI+5IUd/1v2Guhdoz++rde+qYeZB/NJf
4H/L9og019l/6W5lS2j2F5Q6W+m0nf8vmF/xLHCu3V5tjpYFIFc3GkTV1J3G6479
4azfYKMNKbw6g+wbp3ZL/7K+HmEtE85ZY1msDobly8lZOLUck/qXVcw2KaMJSV11
ewlc+PQZJfgzfJlZZQM/sS5YTQBj8CGvjB6z+h5hzsFNBE6TJCgBEADF+hz+c0qF
0R58DwiM8M/PopzFu5ietBpl0jUzglaKhMZKKW7lAr4pzeE4PgJ4ZwQd0dSkx63h
RqM963Fe35iXrreglpwZxgbbGluRJpoeoGWzuUpXE6Ze0A2nICFLk79aYHsFRwnK
yol9M0AyZHCvBXi1HAdj17iXerCYN/ZILD5SO0dDiQl570/1Rp3d1z0l16DuCnK+
X3I7GT8Z9B3WAr6KCRiP0Grvopjxwkj4Z191mP/auf1qpWPXEAPLVAvu5oM7dlTI
xX7dYa6fwlcm1uobZvmtXeDEuHJ3TkbFgRHrZwuh50GMLguG1QjhIPXlzE7/PBQs
zh5zGxPj8cR81txs6K/0GGRnIrPhCIlOoTU8L+BenxZF31uutdScHw1EAgB6AsRd
wdd8a9AR+XdhHGzQel8kGyBp4MA7508ih0L9+MBPuCrSsccjwV9+mfsTszrbZosI
hVpBaeHNrUMphwFe9HbGUwQeS6tOr+pybOtNUHeiJ5aU3Npo3eZkWVGePP2O4vr8
rjVQ1xZMIWA18xUaLTvVSarV7/IqjLb0uMTz6Ng7SceqjsgxO4J35pPOCG8gy85T
md5NKe46K1xGsNG2zzfXQ6cNkofUyQFGVbLCtdfQyWV7+dgUnOnPhrTKpFfJ5lnW
pLpze0LfyW03CpWx9x4yMlwcvIFw2hLaOQARAQABwsFfBBgBCAAJBQJOkyQoAhsM
AAoJEGjCh9/GqAImeJYP/jdppMeb7AZnLGVXd8rN7CLBtfMOkXCWaOUhjMRAY7dV
IMiF1iPZc6SgiiMSsdG7JJhMjMuLTxA0kX2Z6P0+6dZlO4bDOKMIv4nNGhgSj9Nu
SKJPRiyiXKKD/wNnPXVFdBZsoHnEXGyAFGnidu4KLUJIiSm4tHJdoMk0ZaJSmwt0
dtytuC1IWH8eIaVo/Ah6FxCaznRzvGNFx+9Ofcc7+aMZ15dkg9XagOuiDZ1/r6Vu
Ew9ovnkDT4H5BAsysxo/qykX4XQ2RQSY/P3td9WNLeXLvt1aJNRcwcIEKgZ5AO3Y
QbEJt1dEfCU7TAKiRpsjnC/iQiQHGt2IvNci8oZmM3EQEi7yZqD07A6dpGTnRq9O
Q7fGhj0SS99yZvooH3fBIHA2LRuvhfDAgTrpbU0wLvkAIo0T2b9SoRCV8FEpHvR2
b86NbTU5WN4eqZQbAbnxC7tJp6kLx2Zn2uQMvfXRfnS9R1jaetvpk3h7F+r/RAAh
+EvgsPUNaiRJRRLvf9bxTQZhmNrw79eIFNsRIktniLyomJf2+WPOUECzh1lfLqe9
yiuUKv+m5uAalXdayhiPbp/JHs1EDRgSq3tiirOsKrh/KMpwz/22qGMRBjFwYBhf
6ozgujmPlO5DVFtzfwOydzNlXTky7t4VU8yTGXZTJprIO+Gs72Q1e+XVIoKl3MIx
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------sU8fh7n70SzzLuqYfDLh5O7R--

--------------6SeyVOvwW62QlbOK8vyPJSI2--

--------------wb2bl06WJJkL5zKi3pM4mtRs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAme03VAFAwAAAAAACgkQaMKH38aoAiZX
MhAAkVMh6uM0zBtYgOjHcUKPbIwKEkeG1A/REvcMoPWOUt+xGwehj4ocFXMZ1obiDXKWNUFqV3tE
rJ2pn/X4eTPSW3Y46cO7UucrXozLl7IOx43kg2N1ltGR/QWJxjDWzJPsz2psXszqKoo0BxM9hl/F
cC80t8DOPvl9/Iu2mZ/r0ZyCykHaCRNxXi5p/GK32/Tkurhe+n6ldN9PK2VwhspXinlldNXjl+m6
Rb5UQqbk421M9vWmouDxxT1a2uQt0/PjTKMzr3klvx+U2pOLac4MpyXmm3fYxryz1U0J3Qr7ILOu
eyjcNgpFhOcnJTxUozxWZOJKQQejgyyMzEknIFsNUrEyaej0ZKQC/3jQ5i2NXOY5ORYD6MZbKNlN
8O4BYLb/TjBrxI+uRIb62xbaiRA2f6y5Ty3Ensh6sC8yW2dZEnnFBlSQ6aNxMJrZjz6IaEyVxm21
AAN56EUQS9MIw6kki2DPUl+NdLHMDge1r9t2LJuXbMZtX1WFsqWfIfiEgZj4n3CwqyEU+BF018T1
Bq9u8379OFP69m8tsFRh7wuTg6OZjTsCKi/dvC4yjPyWKO2VxJ9IAOGW3r8VRNLkKYeIJNWhWs7g
i819BEkNV/EvzQRoY9SXIKusBBnsEmrqEsWhZnAWkHvFg2Fb11zyXuFwCWhXq0nT3vICsNcS2m+2
Okg=
=QwOn
-----END PGP SIGNATURE-----

--------------wb2bl06WJJkL5zKi3pM4mtRs--

