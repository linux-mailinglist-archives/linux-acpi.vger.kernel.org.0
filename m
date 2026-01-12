Return-Path: <linux-acpi+bounces-20211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A257FD14B7E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 19:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E36306F305
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F1387590;
	Mon, 12 Jan 2026 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QVJBk8YZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA745387568;
	Mon, 12 Jan 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241833; cv=none; b=b+GwP/v3c32+PLv955XBVQ+Z5+WXZkY9Qx0QaP/jr95Knj2oBN8xP5R0g8MV7Bh5MMutTlefhOugVh9mOcLW4Yrl74y7nCOqZ7/wR/SfcDfUyjGK44f5BJ8Ha5uHvl7KTwDN902qiw+McQyyDoBdqz3f5BlF6d8Q2NfDzny+CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241833; c=relaxed/simple;
	bh=e6oFFRQgJUYC6D4OBMUwhS+EehwF4cgz64/fy4PDz8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHh1lP8wXPpHH1POigEnFUtz6n0TeKpeBWNRrMln0Jyyr+2w8DjUcz6ZVZbdNHTng7YgRHBmZZqS2DaOaf+pfKZvZuP+iCvwpn3rBu0Tt5V+SfoBrpxTx0z9coYg2UOKRvEpQazljpzBVNsdfl4KbDi9luRrJNaU3oc6Q0Mf1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QVJBk8YZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768241818; x=1768846618; i=w_armin@gmx.de;
	bh=dDr4tipJ7k1sRf694vdrWqRqjWKUgyefV1KrOdrySKQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QVJBk8YZJE16QNZCopDtjp9g9R7iikfV+5BRbb4pna4r+QHMYHDB5xBEuMPEpXfR
	 NDMQX75/CKZkRz2kDPCa2WwO/cy82w1IxgNeJHBiw9vBXXGKHidm/p8Z+YFWnF1H6
	 f2G95h9p5IEr+v3gTodiUoshP2hUoCfCHXdehRBNeYbMQP91nO8j3zw5gvMB3SH0t
	 rSnVZEWxjLIMDCDOIVlGqfnd90KGdgBd/b4Ir6iszzsWpnTjx4Xy71hr76T7XcEaq
	 ExMYMtROM0lRFhnfQ44hUOAzSt1Wr7OSVgmiXTIGuPkCli63c7wtcGOgXUfb3J9PV
	 z9jdtqtkmVseMPusMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1veXWg3ZIt-004bqd; Mon, 12
 Jan 2026 19:16:58 +0100
Message-ID: <d7898ded-bde5-487e-a476-02ff01d94565@gmx.de>
Date: Mon, 12 Jan 2026 19:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rust: WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <cover.1768153572.git.foxido@foxido.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cover.1768153572.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Jsoe/v5Z2z/1MT401XY92OGVboytiYnmd4PO8vPxQ1SG0faP/4d
 b691G5JIoOtise4ua9Ll2aGnpfy0AYaYkP7KfdCHVcSM1e5Ad8zdTOBrSlfiR9+WxDPOeq5
 +K5wlSxTnvxf4WyQaMOYyGN8BaiOdh+YYychPkcQJjl2rZ3QLTjmRz1gZCG5S0wfSjnwklC
 Ps4WYv7sjFAeCoqb5Z2pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGue6/7mxb0=;4//UFwdc8htGPaNN0Va1sKSN8fx
 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
 JrUmm/tMQ9pcDvj9hVLReuMhQlmL9

Am 11.01.26 um 19:31 schrieb Gladyshev Ilya:

> Overview
> ========
> This patchset implements WMI abstractions for Rust drivers. It is the successor
> of the previous RFC posting [0]. These abstractions allow most WMI drivers to be
> implemented in Rust (provided other dependencies are abstracted as well).
>
> Currently, the only driver in existance is a reference driver (rewrite of redmi-wmi,
> Armin is OK with that [1]). While being fully functional, it depends on sparse-keyboard
> abstractions, which I am still polishing. You can view WIP abstractions & driver at [2].
>
> Notes
> =====
> I do not know how these abstractions should be handled in MAINTAINERS, so for now I have
> simply added them to the original WMI entry. I would be happy to be added as a reviewer
> to keep the Rust version 'synced'/valid though.
>
> [0]: https://lore.kernel.org/rust-for-linux/cover.1766331321.git.foxido@foxido.dev/
> [1]: https://lore.kernel.org/rust-for-linux/c7384f13-e286-45a4-95c6-24d389217185@gmx.de/
> [2]: https://git.foxido.dev/foxido/linux/-/commits/rust_wmi?ref_type=heads

Just a side note:

The patch series for the buffer-based WMI API (https://lore.kernel.org/platform-driver-x86/0914098e-e61b-40c1-9b6e-357832fef5a9@gmx.de/T/#mb8d1591e475a6c346421e8875a1307f3ed1528af)
was accepted into the pdx86 kernel tree and will soon show up on the for-next branch. If you want you can target this API instead because
it replaces the usage of ACPI objects with a plain buffer that might be easier to model in rust.

Thanks,
Armin Wolf

> ---
> Changes since v1:
> - Add lifetime to AcpiObject
> - Add forgotten `Sync` requirement to the WMI driver trait
> - Drop unsafe in DeviceId::new() (so no need for the const_intrinsic_copy feature)
> - Device<Core> -> Device<Bound> in notify
> - Small fixes (styling, missing safety comment)
> - Add link to the WIP reference driver
>
> I didn't touch AcpiObject::type_id() in v2 because it does its job for now. It's currently
> small (only one subtype, whereas both enum options would introduce a larger integration
> surface), and it would be an easy change if someone needs a more powerful solution.
>
> I've also played around with some other suggestions, but:
> - Suggested wrapping acpi_object instead of bindgen union subtypes will only introduce
>      unneeded unsafety in each subtype's operation. I decided it's better to expose the bindgen
>      type once than to validate a safety invariant each time.
> - Suggested implementation via a sealed trait didn't really provide any benefits; it just
>      raised code complexity a bit. Maybe I did it wrong, though...
>
> Link to v1: https://lore.kernel.org/rust-for-linux/cover.1767818037.git.foxido@foxido.dev/
> ---
>
> Gladyshev Ilya (2):
>    rust: implement wrapper for acpi_object
>    rust: add WMI abstractions
>
>   MAINTAINERS                     |   1 +
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/acpi.rs             |  97 +++++++++++
>   rust/kernel/lib.rs              |   2 +
>   rust/kernel/wmi.rs              | 286 ++++++++++++++++++++++++++++++++
>   5 files changed, 387 insertions(+)
>   create mode 100644 rust/kernel/wmi.rs
>
>
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb

