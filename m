Return-Path: <linux-acpi+bounces-19877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82FCE576C
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4C73003067
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2127FD45;
	Sun, 28 Dec 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="biWcu8ue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECA21FF3B;
	Sun, 28 Dec 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766955748; cv=none; b=ohOjc2WPzS0v428Z+AGd02+3OyO0j00GedKlrYPFANlQTvknNKMNeyrZcvk4D8utUuY2rQzxGbYDuo9hAlNuNWSa13amc5TF7C/5vbZROIWjno4nxucuK2kS0lYIBsh+dDPz9k4vGX3bGbRUXE6VbbyWzaMWHB1biUWQs9m4mrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766955748; c=relaxed/simple;
	bh=8H7v2uuZ49awReYY81SKPLJnX3kf5SzGsOXd1jxiDbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdxGHLEar+yTk+JW6oCjseJoANrXnGbZWS+5LPA51io88W9I1O0VUMx5xuyVJoVpmSN7gIkHzeKKGEjG+ac+TNEutaFyz7kJGcSyXp4zTPe6atdpcETENOEL+W+TxwoNBAsoVqv7KQ5DveltyI+5h3l8b4ll7ycpdJI+6b4NEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=biWcu8ue; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766955728; x=1767560528; i=w_armin@gmx.de;
	bh=8H7v2uuZ49awReYY81SKPLJnX3kf5SzGsOXd1jxiDbw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=biWcu8uepb2a5jRItLjmfqr6YfnbFri5Jc9uMRy5VOv58ovLhJCDINkiToxf1l0f
	 5J5cHEG72YyGBtv+NDFSmnT919+O9D7G8a7GznkQ26YvHh3lwyTX3tupjREWuWefl
	 XkIX9YNCNqf401jBSwuRQplH0IGLD0bBZUFLVrPl84JZScJTafhhDglN63o05CS3s
	 E9zn6oG8XCH97z8whHeMrJqQ4h1nB6mFARpOOobNJnSLyaKb8TZt68HUtMmkxROOf
	 bqUGlSY8DFmbbZ8T0ihTrwVN25BHbXGxf6V/l+0y30goYzZa0B4/cmLqF9Ebl2A6+
	 Izn6Ij0pfSiY43Ut0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.142.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1wF5ss0JE6-00iHc0; Sun, 28
 Dec 2025 22:02:08 +0100
Message-ID: <ebfacf87-ce3a-49a0-90b3-74574eca0cec@gmx.de>
Date: Sun, 28 Dec 2025 22:02:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] rust: introduce WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
 <854b4448-3ff1-4fb4-b58f-21136f5ec3e4@gmx.de>
 <d8033c40-9cac-4827-9d8a-5cb3d727ec5b@foxido.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <d8033c40-9cac-4827-9d8a-5cb3d727ec5b@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:iZdHejSknhz8Aa+CMU7c81mZPZDfVYwPASm30Y2Qx8erB/4+Src
 4rmG/sCFkZXRPtsDBq4E5H5Epnjkia8XsTQF1bXlXoUIQCbUpDxG/DanbRZ8NjKoR9HT/wZ
 n7HCcCCbHu/zetuuBNKVNl3dM9diFMJyCmLWmrH3FmuIoTx1hZnRyQCFIvUSfQ8PvLTRr1S
 zRvOIPXsee22+2OT2bdmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WNieFu5tYjQ=;zlXkoVABPSje0rB70xa+XUULva0
 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
 BIJPi3SZXgj+8WGNJMOrPUy2I4jfx210ZGvj/h

QW0gMjUuMTIuMjUgdW0gMjE6Mzcgc2NocmllYiBHbGFkeXNoZXYgSWx5YToNCg0KPiBPbiAxMi8y
NS8yNSAyMTowNiwgQXJtaW4gV29sZiB3cm90ZToNCj4+PiArLy8gU0FGRVRZOiBBIGNhbGwgdG8g
YHVucmVnaXN0ZXJgIGZvciBhIGdpdmVuIGluc3RhbmNlIG9mIGBSZWdUeXBlYCANCj4+PiBpcyBn
dWFyYW50ZWVkIHRvIGJlIHZhbGlkIGlmDQo+Pj4gKy8vIGEgcHJlY2VkaW5nIGNhbGwgdG8gYHJl
Z2lzdGVyYCBoYXMgYmVlbiBzdWNjZXNzZnVsLg0KPj4+ICt1bnNhZmUgaW1wbDxUOiBEcml2ZXIg
KyAnc3RhdGljPiBkcml2ZXI6OlJlZ2lzdHJhdGlvbk9wcyBmb3IgDQo+Pj4gQWRhcHRlcjxUPiB7
DQo+Pj4gK8KgwqDCoCB0eXBlIFJlZ1R5cGUgPSBiaW5kaW5nczo6d21pX2RyaXZlcjsNCj4+PiAr
DQo+Pj4gK8KgwqDCoCB1bnNhZmUgZm4gcmVnaXN0ZXIoDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHdk
cnY6ICZPcGFxdWU8U2VsZjo6UmVnVHlwZT4sDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG5hbWU6ICYn
c3RhdGljIENTdHIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1vZHVsZTogJidzdGF0aWMgVGhpc01v
ZHVsZSwNCj4+PiArwqDCoMKgICkgLT4gUmVzdWx0IHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgbWFj
cm9fcnVsZXMhIG1hcF9jYWxsYmFjayB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKCRm
bGFnOmlkZW50IC0+ICRjYWxsYmFjazppZGVudCkgPT4gew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgVDo6JGZsYWcgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBTb21lKFNlbGY6OiRjYWxsYmFjaykNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5vbmUNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9
DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAvLyBTQUZFVFk6IEl0J3Mgc2FmZSB0byBzZXQg
dGhlIGZpZWxkcyBvZiBgc3RydWN0IA0KPj4+IHdtaV9kcml2ZXJgIG9uIGluaXRpYWxpemF0aW9u
Lg0KPj4+ICvCoMKgwqDCoMKgwqDCoCB1bnNhZmUgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICgqd2Rydi5nZXQoKSkuZHJpdmVyLm5hbWUgPSBuYW1lLmFzX2NoYXJfcHRyKCk7DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKCp3ZHJ2LmdldCgpKS5kcml2ZXIucHJvYmVfdHlwZSA9
IA0KPj4+IGJpbmRpbmdzOjpwcm9iZV90eXBlX1BST0JFX1BSRUZFUl9BU1lOQ0hST05PVVM7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKCp3ZHJ2LmdldCgpKS5pZF90YWJsZSA9IFQ6OlRB
QkxFLmFzX3B0cigpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgqd2Rydi5nZXQoKSku
cHJvYmUgPSBtYXBfY2FsbGJhY2shKEhBU19QUk9CRSAtPiANCj4+PiBwcm9iZV9jYWxsYmFjayk7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKCp3ZHJ2LmdldCgpKS5ub3RpZnkgPSBtYXBf
Y2FsbGJhY2shKEhBU19OT1RJRlkgLT4gDQo+Pj4gbm90aWZ5X2NhbGxiYWNrKTsNCj4+DQo+PiBJ
IHRoaW5rIGl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byBoYW5kbGUgV01JIGRyaXZlcnMgcmVxdWly
aW5nIA0KPj4gLm5vX25vdGlmeV9kYXRhIHRvIGJlIHNldC4gSXMgdGhlcmUNCj4+IGEgd2F5IHRv
IGRlY2xhcmUgdGhlIFdNSSBldmVudCBkYXRhIHBhc3NlZCB0byB0aGUgbm90aWZ5KCkgY2FsbGJh
Y2sgDQo+PiBhcyBvcHRpb25hbD8gSWYgeWVzLCB0aGVuIGkgc3VnZ2VzdA0KPj4gdGhhdCB3ZSBh
bHdheXMgc2V0IC5ub19ub3RpZnlfZGF0YSBhbmQgc2ltcGx5IHJlcXVpcmUgdGhlIFdNSSBkcml2
ZXJzIA0KPj4gdGhlbXNlbHZlcyB0byB2ZXJpZnkgdGhhdCBhIGdpdmVuDQo+PiBXTUkgZXZlbnQg
ZG9lcyBjb250YWluIGFkZGl0aW9uYWwgZXZlbnQgZGF0YS4NCj4NCj4gWWVzLCBJIGNhbiBjaGFu
Z2UgdGhlIG5vdGlmeSBBUEkgdG8gcmVjZWl2ZSBPcHRpb25hbDwmQWNwaUJ1ZmZlcj4gDQo+IGlu
c3RlYWQgb2YgJkFjcGlCdWZmZXIsIHNvIGV2ZXJ5IGRyaXZlciB3aWxsIGJlIGZvcmNlZCB0byB2
ZXJpZnkgDQo+IHBheWxvYWQgZXhpc3RlbmNlIGJ5IFJ1c3QncyB0eXBlIHN5c3RlbS4NCj4NCj4g
SUlSQywgY2FzdGluZyByYXcgKEMpIHBvaW50ZXIgdG8gT3B0aW9uYWw8JlQ+IGlzIGFjdHVhbGx5
IGEgbm8tb3AgaW4gDQo+IFJ1c3QsIHNpbmNlIE5VTEwgaXMgYXV0b21hdGljYWxseSBtYXBwZWQg
dG8gTm9uZSAoZW1wdHkgT3B0aW9uYWwpLCBzbyANCj4gaXQgd2lsbCBiZSBhIHplcm8tY29zdCB0
eXBlc3lzdGVtIHdpbiA6KQ0KDQpOaWNlLCB0aGVuIGkgc3VnZ2VzdCB5b3UgYWx3YXlzIHNldCAu
bm9fbm90aWZ5X2RhdGEgYW5kIHBhc3MgdGhlIGV2ZW50IGRhdGEgaW5zaWRlIHNhaWQgT3B0aW9u
YWwuDQoNClRoYW5rcywNCkFybWluIFdvbGYNCg0K

