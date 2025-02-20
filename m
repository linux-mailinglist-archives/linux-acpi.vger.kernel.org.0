Return-Path: <linux-acpi+bounces-11340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3BA3D161
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 07:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269E0178D24
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFD1DFE20;
	Thu, 20 Feb 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XsKVkrEV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6041DFE32;
	Thu, 20 Feb 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032795; cv=none; b=jWxTydeMIYEPD0rHTRiDi46SfpoeJlaunzrzqIf/hJVjjwm67bsP4m2Co+eJZYF58Kg7oWt0qnqyK51x9/3tpeYh6l6womFi6DZvSDTFnihQAUwB9sosIpCc6WJzahcmHa7gIiAF/U42pNU9JzH44RpSlwAdjlnogqLR8bqwAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032795; c=relaxed/simple;
	bh=IlmwQnZ9eJ6+YruXTK4RZVqHu2Zggr5FCcSosA+gYC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ej/Z2wbCzj4pRT0j5iZkse+z9VzGQip5tg4Q6aot1PyXRSEFGCv7o1bbH1bCBpdvVL0hChuVkjjsL8hKUiCctR/8gZ9KUofbN5QxmXVzt7Rd3OuWN3W+aluKIWKtj+jHRXJPbu0CFkPAjchkgFNxUUvBCkqIbDDqi09NC4Yfvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XsKVkrEV; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740032749;
	bh=IlmwQnZ9eJ6+YruXTK4RZVqHu2Zggr5FCcSosA+gYC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XsKVkrEVmnIUB9K5RPoPwBUQxwbCdt7Xh8WH5YMsNyCbFqlyw/yB6XKxRE9m3w6iQ
	 QTsU76hKsYnM8GKt5Ioo4k7HfGHpUWCtGsw4MGRsLSDf0hmHYN45pF0s14ylJTcw6h
	 i1fanXXSN/xlfO/2zSF8NrDs3a7WYvaYjDwGqWrE=
X-QQ-mid: bizesmtpip2t1740032736tufnqrx
X-QQ-Originating-IP: q5kOyWnSAVN2XSxq8Dr39ImKWXv99DR1JJSXtBsmihw=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Feb 2025 14:25:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16861979310175025258
Message-ID: <13526D98D27F6E36+705ff063-e7f6-49ff-a29a-0f5e5101c000@uniontech.com>
Date: Thu, 20 Feb 2025 14:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: Move get_numa_distances_cnt() helper to
 needed location
To: Mike Rapoport <rppt@kernel.org>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
 lenb@kernel.org, maobibo@loongson.cn, guanwentao@uniontech.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
 dave.jiang@intel.com, haibo1.xu@intel.com, linux-acpi@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, chenlinxuan@uniontech.com
References: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>
 <Z7bHPVUH4lAezk0E@kernel.org>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Z7bHPVUH4lAezk0E@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4Xf1bFP4e7EOaVC4MwmhhiXF"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of/FyW07GPBTIGvQgbxpV03kkw25lnI4+WhcYZeqBlBRrF0iafPV43wJ
	qRoIewfLFVGMW9zti25ZhnPtEFeqSgyYMz0jGItiAmqyd0hbDPSS4xV+brpuGEaHrjxVM9h
	keJTcQeGCOxEL6aWGFNlbiHqHFZWdaCv6dEkfqCZwqEExxF0MXFVD0BQXQmEUe8cMBc++0w
	n3Hx6T0fQOH94JMKNZ7Bp2CW9vsVRavWwOjVeZKqa0ueS5u3hJGqj66sVuVHL9c4Yu2KTNe
	1iVmT7HfrG8KpPztCke1sgWOLsV2TKZuDhhpPFh94nHuPWdi2kXr8pVshyuDSuJbgleoN73
	ADTm+K3ey4CVOigZEs8P3vLC6zCASWm64PGPLl6PUeDPdTCanJg3NkXvOBy1TZjWReoGI7M
	Aw53ldWStoI/7iURKDMVy8ibFi3eMddHZ1X3wT2QFZ9AHTcEHYfra+OjWr2qr8uAKdZ1FyI
	r9CaQikAdcyq8kD6tITeFA1VJdSWqSCZ2f84ReHdbR0BjFOnazar+WQ6o3kMZGCBTTHphZz
	a8j8LUB8/mSOpPlsOuKR0aw346ODwQuHlZptOVM5cc96LpE5TebSgpAzz9CGFLdW0f6Twqi
	FHCpWf6M2JFFXV76vejJxVY588Iar6aN44Ynef2Ipn5YSIy2z457NYNCzDPmgQJCVEH6bdL
	SweCuwTssAvSaTuVbi7Ns4L78iz52apuht3RZgNnrCSygonkG1rKLOXgC4mHp7GQU14sLXD
	GBWNSOpds9m9yjwt+ySsixLP+huBnNt9CU/R7S4uVCDwYm4+jFPWYAMzv9I7jO83gVLjdVg
	s5UelftN7A4LCGWfeGSquSKgvnbvboElKZ+TDSWmOaJoSqjfAnXBFU2BW3qKL1OrGsPeM+v
	g4cEuWRkBO6EXI7ZGC9R9FQ2jrjmGduqchhOVelutlS6XCSzsgt0JPR1csTDwXWqcWZudZQ
	wLZ43p736r8OQSzCjGqHN6gjiYlyyQb1ki1MfojKUz9DI6YaeNVY9EnBE1e6g5scCXPLpWY
	aukFcs2DqWfLGeWSk4tjiAYkNOrbt+B5GGFitxKKeH9Ov8fqeuMVc/zTXga3a3EhaWm3pTf
	q1/XtUpQCV7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4Xf1bFP4e7EOaVC4MwmhhiXF
Content-Type: multipart/mixed; boundary="------------xNIKrkDhRc6nFHBYmEtPaU4Y";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
 lenb@kernel.org, maobibo@loongson.cn, guanwentao@uniontech.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
 dave.jiang@intel.com, haibo1.xu@intel.com, linux-acpi@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, chenlinxuan@uniontech.com
Message-ID: <705ff063-e7f6-49ff-a29a-0f5e5101c000@uniontech.com>
Subject: Re: [PATCH] ACPI: NUMA: Move get_numa_distances_cnt() helper to
 needed location
References: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>
 <Z7bHPVUH4lAezk0E@kernel.org>
In-Reply-To: <Z7bHPVUH4lAezk0E@kernel.org>

--------------xNIKrkDhRc6nFHBYmEtPaU4Y
Content-Type: multipart/mixed; boundary="------------WQssjZ2nzYFwkYfyO8RDeWq6"

--------------WQssjZ2nzYFwkYfyO8RDeWq6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWlrZSwNCg0KT24gMjAyNS8yLzIwIDE0OjEwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBUaGVyZSdzIG5vIG5lZWQgZm9yIHJlbG9jYXRpb24sIGp1c3QgZHJvcCB0aGUgdW51c2Vk
IGZ1bmN0aW9uLg0KDQpPa2F5Lg0KDQpCdXTCoCBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgbGlu
ZSAyOTUgb2YgdGhlIG9yaWdpbmFsIHNyYXQuYy4gU2hvdWxkIHRoZSANCnR5cGUgb2YgdmFy
aWFibGUgJ2QnIHRoZXJlIGJlIGNoYW5nZWQgdG8gdTY0LCBhcyBtZW50aW9uZWQgaW4gdGhl
IGNvbW1pdCANCm1lc3NhZ2U/DQoNCklmIHllcywgSSBjYW4gcXVpY2tseSBwdXQgdXAgYW5v
dGhlciBjb21taXQganVzdCB0byB0d2VhayB0aGlzIG9uZSBwbGFjZS4NCg0KVGhhbmtzLA0K
DQotLSANCldhbmdZdWxpDQo=
--------------WQssjZ2nzYFwkYfyO8RDeWq6
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------WQssjZ2nzYFwkYfyO8RDeWq6--

--------------xNIKrkDhRc6nFHBYmEtPaU4Y--

--------------4Xf1bFP4e7EOaVC4MwmhhiXF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ7bK3QUDAAAAAAAKCRDF2h8wRvQL7jZf
AQCFIqI4kZJxF0oUMvbXmVizZXKBnNcdw+kRxdO3KtiuWQD8DRbWry4c0K4Fd9QOvvSQr1tSEFXS
KNZVM5Weo3GxDgs=
=TlKM
-----END PGP SIGNATURE-----

--------------4Xf1bFP4e7EOaVC4MwmhhiXF--


