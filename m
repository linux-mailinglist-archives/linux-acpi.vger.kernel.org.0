Return-Path: <linux-acpi+bounces-9452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1B09C24AE
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98BD1F21B36
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F0233D8A;
	Fri,  8 Nov 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VtrJr0wp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B2233D6B;
	Fri,  8 Nov 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089491; cv=none; b=OOuTCLELiBYqcU6Xx8OSCt5IBZAq38K9kWDaay9Np7NYZc6W5E+wIIZngixBBkFWrjg+DjRXGKfqoXqkR0B5Y6BqD16TOjzvTL++FDIqpWmQTY3IUXO4wnz7rArTc5IUhObCOxLzmC741lKvE8o4fe+43/iD6/njWPCNnZKp9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089491; c=relaxed/simple;
	bh=MKZMy4/m6Ynxjlm2TRtVe1K9RlORsn3BmBEJ9Cubqxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGQNi5sN82bgMmnsPtlcpXwomi6x4R4BZsPSKDllVs3qRL1JnEBJ+1bBcYovuhFFT2Cn+qzY7G3VXJ2U95fjQ1636xc24rHAWC1WrCKVXateM7ptSXikveYYY28D0EVxznI+sR8lyUI76eTMa0aqWfgxoYgvfLF/K5a2xEZByU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VtrJr0wp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731089405; x=1731694205; i=w_armin@gmx.de;
	bh=MKZMy4/m6Ynxjlm2TRtVe1K9RlORsn3BmBEJ9Cubqxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VtrJr0wpvZKLocQRTdsrWn5OSznL9tqNcGKuHSMAbEa3NvU8VPlIzzVPxDC47b8u
	 et+U7alT57wqw6dxOKvY1Q8AAsEHIaxyZPVmyiR5VEz/G1GVVYvunYiLiCom3N7C1
	 pfNvyVAbD75TTweAffoZLgt84VcuXl7K+lzn3mRwT9UEG3AZbzeI9p88s9vmRWs2d
	 Sh08iKAlZACNJH5ujpjXl3Nqf3TRISiim7jUzAGNTeP5rUTnIk0NEqP4vhMNjUACW
	 gypuFXUkDBKPWiPFqmUVD4+rypMCBp+z7gZOA99Ks3x6O4tFQth3W+Y71MX0szykK
	 tp5byLGnGeKe3ZYodQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1tGJxk2QXJ-00OGNK; Fri, 08
 Nov 2024 19:10:05 +0100
Message-ID: <79626508-d9da-45ae-947b-22fb8a62522d@gmx.de>
Date: Fri, 8 Nov 2024 19:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] ACPI: platform_profile: Check all profile
 handler to calculate next
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-18-mario.limonciello@amd.com>
 <989e7297-97f9-4d55-be28-78128572fed2@gmx.de>
 <cbdc6ff5-627e-4237-a053-bbf2e77499da@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cbdc6ff5-627e-4237-a053-bbf2e77499da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:myJGh482Z+YrBTYQad1jcozPin2+sMzpY+Nk9MnnWYERIr4+FFj
 W6MD1fuigoy7GbwdeqORzkhjvZQR1nXAP3ELaZ/rBdIaMye2mhsuEBzjdGg9jJx+3Uy+tGX
 8BVc3Qx29RDx5tQwYnhQQsVc1+kZrD67xa3m5j2f+vsJKiO9gS1dmUtyc63QV9hVHkXP2OR
 tqT8QPoPscEGpQ+qmIP8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rJPp5Jke6VQ=;0WKEAn8I3JbCSo2xgpbsFmnY9j2
 LPZKYo3p+nqZzg+Y8l0Ql8TznXEHpewSGVpwcSVqfU7WT4+q8cGsdRiytnJuoCQahmaeGGogg
 HVogQHI7wSU8LzG9rcVCPOUG0/8vSd6R8+NdrHcz1XX/n9N4EuZOVjfaJZeSQuaAyPPOpDqzS
 NVE4C65OfF8skY43BrhDJJQEJJf34BJFMUvIm95swQjktu/ojelHIU26vMbeFzMRG2aCP2upH
 GMAMtMTrxoCxwLBHhDbQtbMH3WvuiLtEdli2cU8ZHaarvfTf3WXwM1k/lxFGjl2oqzEn/ndhA
 NPCO1zEraGXNznLbcGkmBdrzPVHwoAPdXAhAicez0/PJw3BDxZhsg2w9k36OZgPJnZ50rRIM2
 JaAq2kmLSx4CiSFeamUPcDhwpbr/enWAjkUh3MtB1bT30/rNSLlIwMxxOPxsE26Op7y+4oiQA
 SEL4FgPGwvS4dULtlkCrZboex7vd+FpPoFLHRqw26p6jaGILFdMJFj7HrCE2EKCx8VUtAQ7D4
 8BvbcsY1Gz1SAE+Vpjupf1cPGowiEmrqVyuyR/1QPFAZWIB2RVx7jniRFOasz1YuqCfHT963l
 R7Ciw8rWfz3woK7I0/p+FD3FMTXLIQX32Egf2rSQbbqi6SrbjWMlnRV6zn8MeJpfeYToEndVd
 uQXOpyZoYIkr1kJKX8XZa4ocXX+dc59g0kfGWcNsRWngNSwoNfRLo8zsTx6msqRyyfIM42rR+
 oiv9nQ58QuyFPg2MR3+uUwASny58xq2kd1rVen71Jjw1rUsXAuMA3jFmLrvPqDCbhj34EbPe+
 lltvTARIn5ke6nvoDbwyifeg==

QW0gMDcuMTEuMjQgdW0gMjM6MDUgc2NocmllYiBNYXJpbyBMaW1vbmNpZWxsbzoNCg0KPiBPbiAx
MS83LzIwMjQgMDI6NTgsIEFybWluIFdvbGYgd3JvdGU6DQo+PiBBbSAwNy4xMS4yNCB1bSAwNzow
MiBzY2hyaWViIE1hcmlvIExpbW9uY2llbGxvOg0KPj4NCj4+PiBBcyBtdWx0aXBsZSBwbGF0Zm9y
bSBwcm9maWxlIGhhbmRsZXJzIG1pZ2h0IG5vdCBhbGwgc3VwcG9ydCB0aGUgc2FtZQ0KPj4+IHBy
b2ZpbGUsIGN5Y2xpbmcgdG8gdGhlIG5leHQgcHJvZmlsZSBjb3VsZCBoYXZlIGEgZGlmZmVyZW50
IHJlc3VsdA0KPj4+IGRlcGVuZGluZyBvbiB3aGF0IGhhbmRsZXIgYXJlIHJlZ2lzdGVyZWQuDQo+
Pj4NCj4+PiBDaGVjayB3aGF0IGlzIGFjdGl2ZSBhbmQgc3VwcG9ydGVkIGJ5IGFsbCBoYW5kbGVy
cyB0byBkZWNpZGUgd2hhdA0KPj4+IHRvIGRvLg0KPj4+DQo+Pj4gVGVzdGVkLWJ5OiBNYXJrIFBl
YXJzb24gPG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4g
djU6DQo+Pj4gwqAgKiBBZGp1c3QgbXV0ZXggdXNlDQo+Pj4gLS0tDQo+Pj4gwqAgZHJpdmVycy9h
Y3BpL3BsYXRmb3JtX3Byb2ZpbGUuYyB8IDIzICsrKysrKysrKysrKysrLS0tLS0tLS0tDQo+Pj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pj4N
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYyBiL2RyaXZl
cnMvYWNwaS8gDQo+Pj4gcGxhdGZvcm1fcHJvZmlsZS5jDQo+Pj4gaW5kZXggN2YzMDJhYzRkMzc3
OS4uMmM0NjZmMmQxNmI0MiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2FjcGkvcGxhdGZvcm1f
cHJvZmlsZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYw0KPj4+
IEBAIC00MTEsMzQgKzQxMSwzOSBAQCBFWFBPUlRfU1lNQk9MX0dQTChwbGF0Zm9ybV9wcm9maWxl
X25vdGlmeSk7DQo+Pj4NCj4+PiDCoCBpbnQgcGxhdGZvcm1fcHJvZmlsZV9jeWNsZSh2b2lkKQ0K
Pj4+IMKgIHsNCj4+PiArwqDCoMKgIGVudW0gcGxhdGZvcm1fcHJvZmlsZV9vcHRpb24gbmV4dCA9
IFBMQVRGT1JNX1BST0ZJTEVfTEFTVDsNCj4+PiDCoMKgwqDCoMKgIGVudW0gcGxhdGZvcm1fcHJv
ZmlsZV9vcHRpb24gcHJvZmlsZTsNCj4+PiAtwqDCoMKgIGVudW0gcGxhdGZvcm1fcHJvZmlsZV9v
cHRpb24gbmV4dDsNCj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgY2hvaWNlczsNCj4+PiDCoMKg
wqDCoMKgIGludCBlcnI7DQo+Pj4NCj4+PiDCoMKgwqDCoMKgIGlmICghY2xhc3NfaXNfcmVnaXN0
ZXJlZCgmcGxhdGZvcm1fcHJvZmlsZV9jbGFzcykpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRU5PREVWOw0KPj4+DQo+Pj4gwqDCoMKgwqDCoCBzY29wZWRfY29uZF9ndWFyZChtdXRl
eF9pbnRyLCByZXR1cm4gLUVSRVNUQVJUU1lTLCANCj4+PiAmcHJvZmlsZV9sb2NrKSB7DQo+Pj4g
LcKgwqDCoMKgwqDCoMKgIGlmICghY3VyX3Byb2ZpbGUpDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IGNsYXNzX2Zv
cl9lYWNoX2RldmljZSgmcGxhdGZvcm1fcHJvZmlsZV9jbGFzcywgTlVMTCwNCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcHJvZmlsZSwgX2FnZ3Jl
Z2F0ZV9wcm9maWxlcyk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChlcnIpDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCj4+Pg0KPj4+IC3CoMKgwqDCoMKgwqDCoCBl
cnIgPSBjdXJfcHJvZmlsZS0+cHJvZmlsZV9nZXQoY3VyX3Byb2ZpbGUsICZwcm9maWxlKTsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gY2xhc3NfZm9yX2VhY2hfZGV2aWNlKCZwbGF0Zm9ybV9w
cm9maWxlX2NsYXNzLCBOVUxMLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZjaG9pY2VzLCBfYWdncmVnYXRlX2Nob2ljZXMpOw0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBlcnI7DQo+Pj4NCj4+PiAtwqDCoMKgwqDCoMKgwqAgbmV4dCA9IGZpbmRfbmV4dF9iaXRf
d3JhcChjdXJfcHJvZmlsZS0+Y2hvaWNlcywgDQo+Pj4gUExBVEZPUk1fUFJPRklMRV9MQVNULA0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBuZXh0ID0gZmluZF9uZXh0X2JpdF93cmFwKCZjaG9pY2VzLA0K
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUExBVEZPUk1f
UFJPRklMRV9MQVNULA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHJvZmlsZSArIDEpOw0KPj4NCj4+IENvdWxkIGl0IGJlIHRoYXQgdGhpcyB3b3Vs
ZCBsZWFkIHRvIGJlICJjdXN0b20iIHByb2ZpbGUgYmVpbmcgDQo+PiBzZWxlY3RlZCB1bmRlciBz
b21lIGNvbmRpdGlvbnM/DQo+DQo+IFllYWgsIHlvdSdyZSByaWdodC7CoCBJZiBhbGwgZHJpdmVy
cyBzdXBwb3J0ZWQgY3VzdG9tIHRoZW4gdGhpcyBjb3VsZCANCj4gaGFwcGVuLsKgIEknbGwgY2xl
YXIgY3VzdG9tIGxpa2UgdGhpczoNCj4NCj4gwqDCoMKgwqDCoMKgwqAgY2hvaWNlcyAmPSB+QklU
KFBMQVRGT1JNX1BST0ZJTEVfQ1VTVE9NKTsNCj4NClNvdW5kIGdvb2QgdG8gbWUuDQoNCj4+IEFs
c28gX2FnZ3JlZ2F0ZV9wcm9maWxlcygpIGV4cGVjdHMgcHJvZmlsZSB0byBiZSBpbml0aWFsaXpl
ZCB3aXRoIA0KPj4gUExBVEZPUk1fUFJPRklMRV9MQVNULg0KPg0KPiBXaWxsIGNvcnJlY3QgaW5p
dGlhbGl6YXRpb24gaW4gcGxhdGZvcm1fcHJvZmlsZV9jeWNsZSgpIHRvIHRoaXMuDQo+DQo+IMKg
wqDCoMKgZW51bSBwbGF0Zm9ybV9wcm9maWxlX29wdGlvbiBwcm9maWxlID0gUExBVEZPUk1fUFJP
RklMRV9MQVNUOw0KPg0KPiBCdXQgdGhpcyBhbHNvIHJhaXNlcyBhIGdvb2QgcG9pbnQuwqAgSWYg
X2FnZ3JlZ2F0ZV9wcm9maWxlcygpIHJldHVybnMNCj4gY3VzdG9tIHRoZW4gdGhpcyBzaG91bGQg
YmUgYW4gZXJyb3IgYmVjYXVzZSBuZXh0IHByb2ZpbGUgaXMgdW5kZWZpbmVkLg0KPiBTbyBJJ2xs
IGNhdGNoIHRoYXQgbGlrZSB0aGlzLg0KPiDCoMKgwqDCoMKgwqDCoCBlcnIgPSBjbGFzc19mb3Jf
ZWFjaF9kZXZpY2UoKQ0KPiDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBlcnI7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChwcm9maWxlID09IFBM
QVRGT1JNX1BST0ZJTEVfQ1VTVE9NKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOw0KDQpHb29kIHBvaW50LCBwbGVhc2UgYWxzbyBjaGVjayBpZiBwcm9maWxlID09IFBM
QVRGT1JNX1BST0ZJTEVfTEFTVCBpbiBjYXNlIG5vIHBsYXRmb3JtIHByb2ZpbGUgaGFuZGxlcnMg
YXJlIGN1cnJlbnRseSBpbnN0YWxsZWQuDQoNClRoYW5rcywNCkFybWluIFdvbA0KDQo+Pg0KPj4g
VGhhbmtzLA0KPj4gQXJtaW4gV29sZg0KPj4NCj4+Pg0KPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAo
V0FSTl9PTihuZXh0ID09IFBMQVRGT1JNX1BST0ZJTEVfTEFTVCkpDQo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IGNs
YXNzX2Zvcl9lYWNoX2RldmljZSgmcGxhdGZvcm1fcHJvZmlsZV9jbGFzcywgTlVMTCwgDQo+Pj4g
Jm5leHQsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgX3N0b3JlX2NsYXNzX3Byb2ZpbGUpOw0KPj4+DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVyciA9
IGN1cl9wcm9maWxlLT5wcm9maWxlX3NldChjdXJfcHJvZmlsZSwgbmV4dCk7DQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChlcnIpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGVycjsNCj4+PiDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4+IMKgwqDCoMKgwqAgc3lzZnNfbm90
aWZ5KGFjcGlfa29iaiwgTlVMTCwgInBsYXRmb3JtX3Byb2ZpbGUiKTsNCj4+PiAtwqDCoMKgIHJl
dHVybiAwOw0KPj4+ICsNCj4+PiArwqDCoMKgIHJldHVybiBlcnI7DQo+Pj4gwqAgfQ0KPj4+IMKg
IEVYUE9SVF9TWU1CT0xfR1BMKHBsYXRmb3JtX3Byb2ZpbGVfY3ljbGUpOw0KPj4+DQo+DQo+DQo=

