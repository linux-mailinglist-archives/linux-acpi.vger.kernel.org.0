Return-Path: <linux-acpi+bounces-15391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391EB143C7
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 23:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A700A7A63E2
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78225A32E;
	Mon, 28 Jul 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kde020aV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0622FE11;
	Mon, 28 Jul 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737754; cv=none; b=iWPNM+kB/e0LURAtHeT61U0m42RHmXgniNRSFQxOib40ltMfXZBX4AdKUdWK0qtJI6m5gmQoW2zM/QtaWhoDn4MPleOuyBgxCsIwgJixlFrnkUDxDaxczFQWlOwMWRuvMn/cyY4ioUDaa7cv+kKArs8Nm7Fik7D/MyAltddWgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737754; c=relaxed/simple;
	bh=g5k4XJg4Boule9D+mxMC+LTqplO4dUpw3hifPKcmTjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pSkn4Pu5XrwuqdsucnM0VeIzntpDHh5WZUP9ZKD/NfQOy/GlN/9XaYfOg8jq+8tKOi/XDv1IMsyC08ZloE7SV6YtK42gfwMtxfBi7BFeb5d32AfABezzzWlwTb01Pimt371VgCT21kKbu9sPtFV9AoZ1nnLQH955kUryivQcqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kde020aV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753737750; x=1754342550; i=w_armin@gmx.de;
	bh=XHnpiW53J1iv25UmgZMpwKSNqYKtQ8DyF4rqypvLezo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kde020aVzbWKqAn/wvE6clGkpRLf8+gWNC3tNvb/dexYzINbHukrjM21K+T4K/op
	 KMfu5/oVoIN07moLBjjswkSS+aSEiedLqgPoWxKBIVl95mvVUGUY9k+gIR25PQJsq
	 VS1P0jlMKy8gJ8RIpH0uMTzqV6ErxPeuE9WGTkaFdu4VLt4yHYVtdHFWMKP0yL0wc
	 CEAu1HgXHXWShze3lZWQXBklMG9ncV3nn8/rEXc1ZrvmxSVdN42KuG4RuEWVcuZrv
	 TWuR6akYghU7NN4K7t30Hun/5dbP3WMFR8wv/KlY9u/Ou3oHyiL6nJIMBXwxrBFB+
	 hncCk05v56NF4YNAIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1umHnC3e2N-001sCL; Mon, 28
 Jul 2025 23:22:30 +0200
Message-ID: <35144cc0-9718-47b6-b182-592d208dc24c@gmx.de>
Date: Mon, 28 Jul 2025 23:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
To: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux@weissschuh.net, fengwk94@gmail.com
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
 <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
 <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
 <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
 <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>
 <103ed888-ec6c-4b46-b03e-f2803850eec2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <103ed888-ec6c-4b46-b03e-f2803850eec2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oJv4wdo+w5A6YlsN9q3Hg3zOjgQlzyx9wQqp0QwowF2SDRugV4g
 XcLeuCDC3Zz0AI4jJtUpf5Dy0FDYZQI6ElyvUZVwoFB4UtT4xCDXblzaIWt9hsVWMuDaCon
 ahNQSOV647UVPWBh6ew5PytLAm5uqiRx+X093rManBUrN4k8Hie8RbkE4Tg97aetyVRgyLO
 e1XBkcgbojOy5NMehWhVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SXMEV/gw4sA=;hAj9u9k29jR8AkywF49F6Upkbja
 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
 bugVt41Bb+Su8RBdj4cjKi59xOBb5ork=

Am 28.07.25 um 01:36 schrieb Nikita Krasnov:

>> No, it is because your device is using a different WMI interface for de=
livering events. Device manufacturers
>> are not exactly known for using the same WMI interfaces for a long time=
 :(.
> By the way, how would we call this driver? xiaomi-2-wmi?

Another user just submitted a WMI driver for this WMI event device called =
"redmi-wmi". I think that
name sounds good enough.

>> Personally i have no problem with you writing a WMI driver in Rust, but=
 currently we have
>> no suitable bindings for the WMI driver API. Additionally i am currentl=
y designing a new
>> WMI driver API that will make it easier to implement the necessary Rust=
 bindings, so the
>> whole thing might take some time.
> Well, I am fine with having to implement the missing Rust bindings =E2=
=80=94 no
> problem there. I was actually looking forward to it. But if the API's
> going to change... Oof.
>
>   * Would the API change be _that_ drastic?

Not really. Basically all usages of acpi_object would be replaced with a s=
truct wmi_buffer that
acts like a sized buffer containing binary data. The big changes happen in=
side the underlying
WMI subsystem itself.

>   * Do you have any expectations on when would that API be released?

I plan to submit the patch series in a couple of weeks, but it might take =
some time before said
patch series is accepted upstream.

>   * Would the new API deprecate the previous one?

Yes, but the old API would not be removed until all existing drivers have =
migrated to the new API.

> Maybe I could do this in Rust right now and then simply update the
> bindings to the new API? That way it would be possible to write the
> driver in Rust. If the API is going to change =E2=80=94 the C code would=
 have to
> be updated either way, right? Maybe updating C driver versus updating
> Rust bindings+driver is not that big of a difference. What do you think?

The old API uses a data structure called acpi_object that might be difficu=
lt to safely
use inside Rust, so only developing bindings for the new API would avoid t=
his.

> I doubt there are going to be so many Rust WMI users that it would get
> really difficult to move anyone to the bindings with a new API..? How
> active is the WMI submodule (is it actually a submodule or just a
> component of ACPI) really is?

The WMI submodule itself is not that active, but the drivers using it are =
different in that regard.

>> Would it be possible for you to implement the WMI driver in C?
> Yea, absolutely! I'm totally fine with writing this in C. I just really
> don't want to miss the opportunity to use Rust here (is it's actually
> feasible)!

Since another user recently submitted a WMI driver for the WMI event devic=
e in question i suggest
that you instead focus on bringing this driver into the mainline kernel. Y=
ou could for example test
this driver on your device and report back if everything works.

Thanks,
Armin Wolf

> --
> Nikita Krasnov

