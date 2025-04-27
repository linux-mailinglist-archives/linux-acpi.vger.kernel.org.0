Return-Path: <linux-acpi+bounces-13329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC833A9E431
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB63B3BC237
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214271E834C;
	Sun, 27 Apr 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmcUrxDz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A70A945;
	Sun, 27 Apr 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745779073; cv=none; b=Bg7guZTBDFfAEvb67T7HmNDrYf62nmghR8czHVnWwFJ/8m4lz+VrRx2gY158IGHknSEoCK/eHlM0ZFIDmyHjH5pwIooqlMnkM9yDuMPRLFJfQIPfbbIYkU+aoXLN8DRGtfg7O5w7izOS7GWLvneF+ouyj70CaNj1kmeDmPTaXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745779073; c=relaxed/simple;
	bh=1+9fUzlaqv/rlrbbuJ/DO7VoFxDE9fLh4K7z1mIjSTs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kXmVgSeDq/nYtpeXQAkTl93K1eGNifaPck6T2+qNdoBa3lb4yjfzw9vVm+RY8te7ccNG8Gm4Z2Inu2tjmCx3CRfWiKwNKD/L1m0QZtjZ6xY7TwMoe3boyht+nrhjoGx7QBUatIOWM9WEp1uqSrQHc3wIneTx6vVhx9gERb662qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmcUrxDz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c062b1f5so3304096b3a.0;
        Sun, 27 Apr 2025 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745779070; x=1746383870; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+9fUzlaqv/rlrbbuJ/DO7VoFxDE9fLh4K7z1mIjSTs=;
        b=XmcUrxDzBLf+MEzOJLLTMXrev7lIjBzVK5rEZ+wCeosQ5gB1DQUORMkyGZRvl2QVnf
         ch/6xgxb3D4z1rPMGJ36a6DjfB9q4a/VOokSPBui0LH8gtNU0T8xCY+TB3eDJxkNXn/2
         Cn2DtDQQO/U7IQVtSsw84oj3gFLcw5iml9L8/7yKffzDv7ZcsgTTpaQedxhcKd//EHej
         K4GSqOirY/RLS6uF0+aiAeaZyGajnXe2Rju6WLvWu17PCpEbedDlAlvdq7VKwB6ET2u0
         RE1B5Be2qwOrSGHSxglz5qHSiXhXjKZU8m4EsX9YNjgxI7jklgDmpHEg2Ya5VuJLkMSn
         XQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745779070; x=1746383870;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+9fUzlaqv/rlrbbuJ/DO7VoFxDE9fLh4K7z1mIjSTs=;
        b=Yjvdw+QRixSKM5Ipev+cV6cFEI3MZ+ekCN4NjY/nF6mufzZ1+YETQNSbK/S6Z/ulhu
         kxCTSZ37wPGNBnTG7NW4jEn31i1mnXrT5fBVUPdQvf6IVwInUMHKxfZp1sPqIDF7sBil
         XsCsgBi5lFFzNKnM0MWcurzCf4WPac6ep0FsYAYeFKEa8cCNeIUWCnr3qiQNy1jSY93G
         rO2MJ4ah0reMC92FRZ1s0pxtBhNREdjW+79K1uMQfq9oqeSslr4T9H5fzNxCFhMUUSSv
         QND6cn+ZMiGsfWnR0XE7XvNAN+HjwKlRI2GfSwEC1JAlmXi0Ur8Xh/rYbb0cpijsQQrr
         AxUw==
X-Forwarded-Encrypted: i=1; AJvYcCV7hoBrklxmsw9/HsYA8HudhcXpMhNxQPiPBSEuc2HhVUN1gSfY+Yiet2gm5edHusMeLLmEgrVTNWrGEo7iGAoVUfZn@vger.kernel.org
X-Gm-Message-State: AOJu0YyadsTB5Y8YuZpKxYQsbvl3X3732TmDDGbyQj1MUyP02ofKyKuk
	bnPvIKG+SYGvvr4MQG8ai6XrKdCQ9xJlyBLmGnEXc/NBpE6bXx3BDzcJfrgfmJI=
X-Gm-Gg: ASbGncu7ayEEoNLuJ8H70F+kgdB4YEC1OnqFyzMCvCBtR0gcjuE2p3AC8cNMezSZAxL
	p7rBh1sYW5RivMY0PKyraKonQMnRCume5MEBlJOG9cwnpPpdwtwpKgBNqiD8hoDsGUS6YRaxSrf
	h6hYAvYcipOzB+WMLaGz7rXfOEAAsp3CBiOn21UvkefbXPKNEbVWYFW1DFGTx96LcP5dvquXwwy
	VO6NC1wp+b/satQMnpte5Cse9HM7dZjNuv1iLT5dIxvPLp5qjqpn2gOg2y22tckNzLlxkpw56ln
	o6BTaVid7TIE9b/micmhjf2T+kU6bk3Huwpes1V0P4Kg178HHgraGic62jHIipWnjfF7mxPgbes
	wt9o31g28huv9UoE=
X-Google-Smtp-Source: AGHT+IFcMaJbLmkhbRuTFTxbysndZvIRXDXoQ90n+GJlEe+S6fxPZQsPItbddViZI8/UayvRovzKSQ==
X-Received: by 2002:a05:6a00:888:b0:737:6d4b:f5f8 with SMTP id d2e1a72fcca58-73fd876d90dmr10385760b3a.17.1745779069962;
        Sun, 27 Apr 2025 11:37:49 -0700 (PDT)
Received: from ?IPV6:2804:14d:5cd1:5e16:9c54:6114:336a:bbaf? ([2804:14d:5cd1:5e16:9c54:6114:336a:bbaf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a655sm6647258b3a.101.2025.04.27.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 11:37:48 -0700 (PDT)
Message-ID: <7f846a4d-5da4-4eae-a3b2-a3ea1fe7a61c@gmail.com>
Date: Sun, 27 Apr 2025 15:37:45 -0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms after
 suspend/resume
From: "M. Bergo" <marcusbergo@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 mark.pearson@lenovo.com, rafael@kernel.org, lenb@kernel.org
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
Content-Language: en-US
Autocrypt: addr=marcusbergo@gmail.com; keydata=
 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
In-Reply-To: <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D0Grbtbmv0yDBjKfZOicnqSj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D0Grbtbmv0yDBjKfZOicnqSj
Content-Type: multipart/mixed; boundary="------------0M3XLetXsP07pdCu6s0NsajP";
 protected-headers="v1"
From: "M. Bergo" <marcusbergo@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 mark.pearson@lenovo.com, rafael@kernel.org, lenb@kernel.org
Message-ID: <7f846a4d-5da4-4eae-a3b2-a3ea1fe7a61c@gmail.com>
Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms after
 suspend/resume
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
In-Reply-To: <445f6320-698f-4d29-8556-665366668e4d@gmail.com>

--------------0M3XLetXsP07pdCu6s0NsajP
Content-Type: multipart/mixed; boundary="------------34oRWFyMgbJ14H3pdT3uVTtI"

--------------34oRWFyMgbJ14H3pdT3uVTtI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U2V2ZXJhbCBBTUQtYmFzZWQgbGFwdG9wIG1vZGVscyAoTGVub3ZvIFAxNXYgR2VuIDMsIFAx
NnYgR2VuIDEsIEhQDQpFbGl0ZUJvb2sgODQ1IEcxMCkNCg0KZXhwZXJpZW5jZSBhIENQVSBm
cmVxdWVuY3kgbGltaXRhdGlvbiBpc3N1ZSB3aGVyZSB0aGUgcHJvY2Vzc29yIGdldHMNCnN0
dWNrIGF0DQoNCmFwcHJveGltYXRlbHkgNTQ0TUh6IGFmdGVyIHJlc3VtaW5nIGZyb20gc3Vz
cGVuZCB3aGVuIHRoZSBwb3dlciBjb3JkIGlzDQp1bnBsdWdnZWQNCg0KZHVyaW5nIHNsZWVw
LiBUaGlzIGlzc3VlIG1ha2VzIHRoZSBzeXN0ZW1zIHByYWN0aWNhbGx5IHVudXNhYmxlIHVu
dGlsIGEgZnVsbA0KDQpwb3dlciBjeWNsZSBpcyBwZXJmb3JtZWQuDQoNCg0KDQpUaGUgcm9v
dCBjYXVzZSB3YXMgdHJhY2VkIHRvIGNvbW1pdCBiNTUzOWViNWVlNzAgKCJBQ1BJOiBFQzog
Rml4DQoNCmFjcGlfZWNfZGlzcGF0Y2hfZ3BlKCkiKSB3aGljaCByZXN0b3JlZCB0aGUgYmVo
YXZpb3Igb2YgY2xlYXJpbmcgdGhlIEdQRQ0KDQppbiBhY3BpX2VjX2Rpc3BhdGNoX2dwZSgp
IGZ1bmN0aW9uIHRvIHByZXZlbnQgR1BFIHN0b3Jtcy4gV2hpbGUgdGhpcyBmaXggaXMNCg0K
bmVjZXNzYXJ5IGZvciBtb3N0IHBsYXRmb3JtcyB0byBwcmV2ZW50IGV4Y2Vzc2l2ZSBwb3dl
ciBjb25zdW1wdGlvbiBkdXJpbmcNCg0Kc3VzcGVuZC10by1pZGxlLCBpdCBjYXVzZXMgcHJv
YmxlbXMgb24gY2VydGFpbiBBTUQgcGxhdGZvcm1zIGJ5IGludGVyZmVyaW5nDQoNCndpdGgg
dGhlIEVDJ3MgYWJpbGl0eSB0byBwcm9wZXJseSByZXN0b3JlIHBvd2VyIG1hbmFnZW1lbnQg
c2V0dGluZ3MNCmFmdGVyIHJlc3VtZS4NCg0KDQoNClRoaXMgcGF0Y2ggaW1wbGVtZW50cyBh
IHRhcmdldGVkIHdvcmthcm91bmQgdGhhdDoNCg0KMS4gQWRkcyBETUktYmFzZWQgZGV0ZWN0
aW9uIGZvciBhZmZlY3RlZCBBTUQgcGxhdGZvcm1zDQoNCjIuIEFkZHMgYSBmdW5jdGlvbiB0
byBjaGVjayBpZiB3ZSdyZSBpbiBzdXNwZW5kLXRvLWlkbGUgbW9kZQ0KDQozLiBNb2RpZmll
cyB0aGUgYWNwaV9lY19kaXNwYXRjaF9ncGUoKSBmdW5jdGlvbiB0byBoYW5kbGUgQU1EIHBs
YXRmb3Jtcw0Kc3BlY2lhbGx5Og0KDQogwqAgwqAtIEZvciBhZmZlY3RlZCBBTUQgcGxhdGZv
cm1zIGR1cmluZyBzdXNwZW5kLXRvLWlkbGUsIGl0IGFkdmFuY2VzIHRoZQ0KDQogwqAgwqAg
wqB0cmFuc2FjdGlvbiB3aXRob3V0IGNsZWFyaW5nIHRoZSBHUEUgc3RhdHVzIGJpdA0KDQog
wqAgwqAtIEZvciBhbGwgb3RoZXIgcGxhdGZvcm1zLCBpdCBtYWludGFpbnMgdGhlIGV4aXN0
aW5nIGJlaGF2aW9yIG9mDQpjbGVhcmluZw0KDQogwqAgwqAgwqB0aGUgR1BFIHN0YXR1cyBi
aXQNCg0KDQoNClRlc3Rpbmcgd2FzIHBlcmZvcm1lZCBvbiBhIExlbm92byBQMTZ2IEdlbiAx
IHdpdGggQU1EIFJ5emVuIDcgUFJPIDc4NDBIUyBhbmQNCg0KY29uZmlybWVkIHRoYXQ6DQoN
CjEuIFdpdGhvdXQgdGhlIHBhdGNoLCB0aGUgQ1BVIGZyZXF1ZW5jeSBpcyBsaW1pdGVkIHRv
IDU0NE1IeiBhZnRlciB0aGUNCg0KIMKgc3VzcGVuZC91bnBsdWcvcmVzdW1lIHNlcXVlbmNl
DQoNCjIuIFdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIHRoZSBDUFUgcHJvcGVybHkgc2NhbGVz
IHVwIHRvIGl0cyBtYXhpbXVtDQpmcmVxdWVuY3kNCg0KIMKgIMKgKDUuMUdIeikgYWZ0ZXIg
dGhlIHNhbWUgc2VxdWVuY2UNCg0KMy4gTm8gcmVncmVzc2lvbnMgd2VyZSBvYnNlcnZlZCBp
biBvdGhlciBFQyBmdW5jdGlvbmFsaXR5IChiYXR0ZXJ5IHN0YXR1cywNCg0KIMKgIMKga2V5
Ym9hcmQgYmFja2xpZ2h0LCBldGMuKQ0KDQo0LiBNdWx0aXBsZSBzdXNwZW5kL3Jlc3VtZSBj
eWNsZXMgd2l0aCBkaWZmZXJlbnQgcG93ZXIgc3RhdGVzIHdlcmUgdGVzdGVkDQoNCiDCoCDC
oHdpdGhvdXQgaXNzdWVzDQoNCg0KDQpUaGUgcGF0Y2ggd2FzIGFsc28gdmVyaWZpZWQgbm90
IHRvIGFmZmVjdCB0aGUgYmVoYXZpb3Igb24gSW50ZWwtYmFzZWQNCnN5c3RlbXMsDQoNCmVu
c3VyaW5nIHRoYXQgdGhlIEdQRSBzdG9ybSBwcmV2ZW50aW9uIHJlbWFpbnMgZWZmZWN0aXZl
IHdoZXJlIG5lZWRlZC4NCg0KDQoNCkZpeGVzOiBiNTUzOWViNWVlNzAgKCJBQ1BJOiBFQzog
Rml4IGFjcGlfZWNfZGlzcGF0Y2hfZ3BlKCkiKQ0KDQpCdWd6aWxsYTogaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg1NTcNCg0KUmVwb3J0ZWQtYnk6
IE1hcmsgUGVhcnNvbiA8bWFyay5wZWFyc29uQGxlbm92by5jb20+DQoNClNpZ25lZC1vZmYt
Ynk6IE1hcmN1cyBCZXJnbyA8bWFyY3VzYmVyZ29AZ21haWwuY29tPg0KDQotLS0NCg0KIMKg
ZHJpdmVycy9hY3BpL2VjLmMgfCA2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KDQogwqAxIGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KDQoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9lYy5j
IGIvZHJpdmVycy9hY3BpL2VjLmMNCg0KaW5kZXggM2M1ZjM0ODkyNzM0Li5mMzY5OGYzYzEw
MGYgMTAwNjQ0DQoNCi0tLSBhL2RyaXZlcnMvYWNwaS9lYy5jDQoNCisrKyBiL2RyaXZlcnMv
YWNwaS9lYy5jDQoNCkBAIC0yOSw2ICsyOSw3IEBADQoNCiDCoCNpbmNsdWRlIDxsaW51eC9h
Y3BpLmg+DQoNCiDCoCNpbmNsdWRlIDxsaW51eC9kbWkuaD4NCg0KIMKgI2luY2x1ZGUgPGFz
bS9pby5oPg0KDQorI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4NCg0KIMKgI2luY2x1ZGUg
ImludGVybmFsLmgiDQoNCkBAIC0yMTM5LDYgKzIxNDAsNTkgQEAgc3RhdGljIGJvb2wgYWNw
aV9lY193b3JrX2luX3Byb2dyZXNzKHN0cnVjdA0KYWNwaV9lYyAqZWMpDQoNCiDCoCDCoCDC
oCDCoCByZXR1cm4gZWMtPmV2ZW50c19pbl9wcm9ncmVzcyArIGVjLT5xdWVyaWVzX2luX3By
b2dyZXNzID4gMDsNCg0KIMKgfQ0KDQorLyogTGlzdCBvZiBBTUQgcGxhdGZvcm1zIHdpdGgg
Q1BVIGZyZXF1ZW5jeSBpc3N1ZXMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUgKi8NCg0KK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhY3BpX2VjX2FtZF9mcmVxX3F1aXJrW10g
PSB7DQoNCivCoCDCoCDCoCDCoHsNCg0KKyDCoC5tYXRjaGVzID0gew0KDQorIMKgIMKgRE1J
X01BVENIKERNSV9TWVNfVkVORE9SLCAiTEVOT1ZPIiksDQoNCisgwqAgwqBETUlfTUFUQ0go
RE1JX1BST0RVQ1RfTkFNRSwgIlAxNXYgR2VuIDMiKSwNCg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfSwNCg0KK8KgIMKgIMKgIMKgfSwNCg0KK8KgIMKgIMKgIMKgew0KDQorIMKgLm1h
dGNoZXMgPSB7DQoNCisgwqAgwqBETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJMRU5PVk8i
KSwNCg0KKyDCoCDCoERNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiUDE2diBHZW4gMSIp
LA0KDQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9LA0KDQorwqAgwqAgwqAgwqB9LA0KDQor
wqAgwqAgwqAgwqB7DQoNCisgwqAubWF0Y2hlcyA9IHsNCg0KKyDCoCDCoERNSV9NQVRDSChE
TUlfU1lTX1ZFTkRPUiwgIkhQIiksDQoNCisgwqAgwqBETUlfTUFUQ0goRE1JX1BST0RVQ1Rf
TkFNRSwgIkhQIEVsaXRlQm9vayA4NDUgMTQgaW5jaCBHMTAgTm90ZWJvb2sNClBDIiksDQoN
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0sDQoNCivCoCDCoCDCoCDCoH0sDQoNCivCoCDC
oCDCoCDCoHsgfSwNCg0KK307DQoNCisNCg0KKy8qIENoZWNrIGlmIHdlJ3JlIGluIHN1c3Bl
bmQtdG8taWRsZSBtb2RlICovDQoNCitzdGF0aWMgYm9vbCBwbV9zdXNwZW5kX3ZpYV9zMmlk
bGUodm9pZCkNCg0KK3sNCg0KKyNpZmRlZiBDT05GSUdfUE1fU0xFRVANCg0KK8KgIMKgIMKg
IMKgcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlID09IFBNX1NVU1BFTkRfVE9fSURM
RTsNCg0KKyNlbHNlDQoNCivCoCDCoCDCoCDCoHJldHVybiBmYWxzZTsNCg0KKyNlbmRpZg0K
DQorfQ0KDQorDQoNCisvKiBDaGVjayBpZiB0aGUgc3lzdGVtIGlzIGFuIEFNRCBwbGF0Zm9y
bSB3aXRoIHRoZSBmcmVxdWVuY3kgcXVpcmsgKi8NCg0KK3N0YXRpYyBib29sIGlzX2FtZF9m
cmVxX3F1aXJrX3N5c3RlbSh2b2lkKQ0KDQorew0KDQorwqAgwqAgwqAgwqBzdGF0aWMgaW50
IGlzX3F1aXJrX3N5c3RlbSA9IC0xOw0KDQorDQoNCivCoCDCoCDCoCDCoGlmIChpc19xdWly
a19zeXN0ZW0gPT0gLTEpIHsNCg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ2hlY2sg
aWYgaXQncyBhbiBBTUQgQ1BVICovDQoNCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChi
b290X2NwdV9kYXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9BTUQpIHsNCg0KKyDCoCDC
oGlzX3F1aXJrX3N5c3RlbSA9IDA7DQoNCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxz
ZSB7DQoNCisgwqAgwqAvKiBDaGVjayBpZiBpdCdzIGluIHRoZSBETUkgcXVpcmsgbGlzdCAq
Lw0KDQorIMKgIMKgaXNfcXVpcmtfc3lzdGVtID0gZG1pX2NoZWNrX3N5c3RlbShhY3BpX2Vj
X2FtZF9mcmVxX3F1aXJrKSA/IDEgOiAwOw0KDQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
DQoNCivCoCDCoCDCoCDCoH0NCg0KKw0KDQorwqAgwqAgwqAgwqByZXR1cm4gaXNfcXVpcmtf
c3lzdGVtID09IDE7DQoNCit9DQoNCisNCg0KKw0KDQorDQoNCiDCoGJvb2wgYWNwaV9lY19k
aXNwYXRjaF9ncGUodm9pZCkNCg0KIMKgew0KDQogwqAgwqAgwqAgwqAgYm9vbCB3b3JrX2lu
X3Byb2dyZXNzID0gZmFsc2U7DQoNCkBAIC0yMTcyLDcgKzIyMjYsMTcgQEAgYm9vbCBhY3Bp
X2VjX2Rpc3BhdGNoX2dwZSh2b2lkKQ0KDQogwqAgwqAgwqAgwqAgaWYgKGFjcGlfZWNfZ3Bl
X3N0YXR1c19zZXQoZmlyc3RfZWMpKSB7DQoNCnBtX3ByX2RiZygiQUNQSSBFQyBHUEUgc3Rh
dHVzIHNldFxuIik7DQoNCi0gwqBjbGVhcl9ncGVfYW5kX2FkdmFuY2VfdHJhbnNhY3Rpb24o
Zmlyc3RfZWMsIGZhbHNlKTsNCg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyoNCg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICogU3BlY2lhbCBoYW5kbGluZyBmb3IgQU1EIHBsYXRm
b3JtcyB3aXRoIENQVSBmcmVxdWVuY3kNCmlzc3Vlcw0KDQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgKiBhZnRlciBzdXNwZW5kL3Jlc3VtZS4gT24gdGhlc2UgcGxhdGZvcm1zLCB3ZSBu
ZWVkIHRvDQphZHZhbmNlIHRoZQ0KDQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB0cmFu
c2FjdGlvbiBidXQgTk9UIGNsZWFyIHRoZSBHUEUgc3RhdHVzIGJpdCB3aGVuIGluDQpzdXNw
ZW5kLXRvLWlkbGUNCg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogc3RhdGUgdG8gcHJl
dmVudCBDUFUgZnJlcXVlbmN5IGxpbWl0YXRpb24gaXNzdWVzLg0KDQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKi8NCg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlzX2FtZF9m
cmVxX3F1aXJrX3N5c3RlbSgpICYmIHBtX3N1c3BlbmRfdmlhX3MyaWRsZSgpKSB7DQoNCisg
wqAgwqBhZHZhbmNlX3RyYW5zYWN0aW9uKGZpcnN0X2VjLCBmYWxzZSk7DQoNCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7DQoNCisgwqAgwqBjbGVhcl9ncGVfYW5kX2FkdmFu
Y2VfdHJhbnNhY3Rpb24oZmlyc3RfZWMsIGZhbHNlKTsNCg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfQ0KDQp3b3JrX2luX3Byb2dyZXNzID0gYWNwaV9lY193b3JrX2luX3Byb2dyZXNz
KGZpcnN0X2VjKTsNCg0KIMKgIMKgIMKgIMKgIH0NCg0K
--------------34oRWFyMgbJ14H3pdT3uVTtI
Content-Type: application/pgp-keys; name="OpenPGP_0xC071F235B991FCBF.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC071F235B991FCBF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
TQ=3D=3D
=3DS/6M
-----END PGP PUBLIC KEY BLOCK-----

--------------34oRWFyMgbJ14H3pdT3uVTtI--

--------------0M3XLetXsP07pdCu6s0NsajP--

--------------D0Grbtbmv0yDBjKfZOicnqSj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEsfTwLYfur7WreUkWwHHyNbmR/L8FAmgOeXkFAwAAAAAACgkQwHHyNbmR/L/q
Gw/+Icu5/Cu03Wpe0Xtvv+vO92Pk8v8utfPyndoLgbHktUk0/S8eIc1JXLFt1q7C3/Vuavm97J3K
vr7QnIsd16be2vXzYSjkStn+fkkrYnGB9r8roXCyrV4+CtbX0O7gnshqtaiCsXPvZi0EOfcc/vrk
AS1FH47uoPWl7Rkqzje2Zt/+pK/cGOGuNAd+3wgd7uUi7CzqqL54t7oGM2O0yG/DBzSNUGqAEph/
+3iC5SmP9f9izFg9mS4KEYrh9CU2igW+qV9afIduk6OeDPy+kyhGOjEjEs6AdqkPR8R8dqje5dvj
zNAvEUhDqpt+RNwrk4yiv495zlekTukh/KPC4wnVQEyYXpas6ZflLtGbEp5kv8774mf6lyCOySgD
tkxa+Kwn5FZxLAZlwbouvJwuEilJ+MTpnszA7o6p38IPQH0M0zgjllmOXIAVrDbaltbo/RgdxRxH
Zy9IIBjey1Ic3OsHdIhuKTA0NfBLbi1buwSYIqzv0gKp3SV7Sj48p+17MBtSABLLbgUqNe+duZeX
ziVHSX/2sNkVdPWgS6znMk5BSyyzlRj4vFv5owIf2qVtk5CORcNlblpVbomgMsKFykdL79i5c6kZ
8Tc6D9wtH7tgRF0Q8YmsVF8BXn3/1KapIe8V73o+TTSnxBkFr6EiNKaFnTeszfVd3OXszCf+zjMX
lNY=
=Ouve
-----END PGP SIGNATURE-----

--------------D0Grbtbmv0yDBjKfZOicnqSj--

