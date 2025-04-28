Return-Path: <linux-acpi+bounces-13333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D0A9F0C8
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F6D1890053
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E002690F9;
	Mon, 28 Apr 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VAa0YTtr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57D26980C;
	Mon, 28 Apr 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843504; cv=none; b=Ko7U0h1a32aToDBhNyti7ynT7sxcZYwazPwzd0TOMwEHo3Jrkn8Pr6LBZzMJwtglDvlmzbNdj+Liof1qRQP+c4e5UIQrhuYymjCW8vF8JYNCIYNCNz7kRTjCkRfoXa7TvwI1sCWroTgaRuGkxRGn8Kk6E6s3vbiRyvinlXf4jbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843504; c=relaxed/simple;
	bh=+MFy1w5ko1BnlhgwQggqrGmfo2TiEUrkCf7tpV8VbU8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dHbQ87kSB2R5CRiqHkkaXjeIqcL3WA+p2I70H+0FvCFMg8MpfAflNBhKOEEha6vIiawuSYqmmTbUdxgf5fNObASlXR8qk7skse6i+q6NMUChyo9+VKj5pk5ufF/DFVZhYCliSTAc+gJigGYPSRDt2yYzOjMc2X6nfVM0H62tsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VAa0YTtr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745843491; x=1746448291; i=w_armin@gmx.de;
	bh=4qp5WmomQxHRqjEXNzrGLpgiq2kVcm0cPmMJBTxzq8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VAa0YTtrLqDIncil+E5RO7AeOspXxgPUTrbgSf+pfhai0zBHVd5DBuLzfJS+JNN9
	 NpHoH/9jG7WPBhMDbX7R6yWk0+ydbG1LVRy5DnWe5VGfsAwpBUmjpXeWzj3US7fpW
	 9EdqoQ3DMWe0/ZJSpCHS+FvecRrO+x+4prJiVUzLGgbIvoq7ZGggfsCou+ukCijff
	 Mk5dgoRSlBr6u0ej/5z2hv45/kTAGG9aKIgMTN3WzeLJA+mx9WSNzABnJ82cl/Bxz
	 vvzS+rhe6zfX0FoGqqKKJD4gBkRd5VkahacRjdZ0ZUOVACIMoNM0oWJ5u/lXFZMad
	 Novdha7hgcMz4+weTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.16.87] ([141.76.8.183]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1uBpp742Xn-007oiQ; Mon, 28
 Apr 2025 14:31:31 +0200
Message-ID: <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
Date: Mon, 28 Apr 2025 14:31:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control
 method
From: Armin Wolf <W_Armin@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410165456.4173-1-W_Armin@gmx.de>
 <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
 <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de>
Content-Language: en-US
In-Reply-To: <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4uu09lOy+qLQjskvy0zMYaFJeYOLBuEBAIpdoNpk2y4MuOvlrEj
 bwBYB6xX7Qmy8DrT/hqeB0HR7iHhBcp2UG4JxYa2sEwtxHoyikTE9J49ibBpLUmUw3cTnVB
 Y+Gjgt2OjmfqiIStDI0xMu3sxCiLvITUIPmOEdZyODBWqcak2mmXpG+Q0UF1znQRYObA5lx
 znga07yZeM7u21U9rVd0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KhOOFIHrYP8=;Nma9kIm5rvY52i899ChaWACDRKq
 p63mgOayJNiAauoAgxNAqp6reIMXyrCxn1wHLlcdFCTj6L9fOF6p5i2oNuNTpDXwaCybkCi6S
 syrv7tRfPEn6BsFBACUW7hLRrVxGRmuGii2mNVx2gb3DpXXk66xqg5+5XZsKeCpEbLJtp2TyV
 14PTDJPxab8ZFt1IirakK6YEEvEV7cTHWLEoE6Bqcq7fusyZBt3+u5GgwopN0ofZBx6CApHLa
 LCSHjhKc2bcDl6t82/aevyE7fv/YYF04S7+uODqIXE3TnEg6PORm3h9LEYW3gIWg5FV8HBWUm
 gLJiGAzhOTxlPVNwobBXRhL9icZl9xULwjdV8bbXghxgAdJFRVj6KevqKi9vWhYNZ3cRxAxG4
 cALPrmLjpiAVPb5AyKBlIIAZXcOC3sKZr1ZTcqIqps60pwjFSAl+k2i7VBh7RSDRETNTkS/Qu
 HN/UaPd+5sSmTpL6ERZCXR3Cvow7J7M5vZYxRdzQkMkQNu29/qF75bECzFI7VvxcKALD0n5fV
 L/elQ9dDvnOjc/BJnMcyak9E5h1ft11Ez18SQvSub1eW7o/yUeOjnPPeX8MficFJYAQpf0APP
 c/1rfgvggfn6nqEAggwdu/cPspl1bT4XOpAZwWVb04xqS9xM87cMKNOehzCA6JkJyEg/RshYd
 UVHt/9iuAppPHeF8iXtPtogkJIxsFcskTcj0arr9XsSUT9YGQemOvYcmfpo91WQNsZTDtzQ9M
 9AvV+6d6ilhFIe7dm3ZRZHUDXhDot7uXNIJkxPNP2W4opPZ0bQsGA/FJRDRctjzlxBmf9bD+M
 EGiNQJfe63mMBP5L3mrUARSC+05r4LptKJy07MLxDNXmpmI2ZiG65U9IMx34CR1TNDySokLao
 cs9E8/gQR/Tce72EYazEtom1u/Lrtpq7oMMfxwuay82Fr3rgQrX5kveZBEUszVYcRcK+EuhYv
 WClt57stNT9+rI7WBnYUypJUiuMWE236uCwLYLpUF4jqqYgBNhoec92+x1h/MI4D7BtfdEDYG
 mF9xuP6HCmvlZW/quf+FwpDT42Wm+lsWONtDFawb5kVGhcgUvmgafApmQHfNHho/yk+7yE9YC
 LE5IxLky2Ljb0nNxvYsaymIgmNrxYKrVxUTGWIsdcOB8o5iSGD8fS0r5J1gT5UmC3o+jT/ZBv
 EeUtED+FYj87fUNvvnwmVmtJsG/xZgYWEnJMV+NuWLz5sI/XRuFwfR4a6IPbR2boOxKVtS17G
 LAZpdYe3hEivVOEaonZWyypXy7yovHFH5Q0BujTnnXa/5FU/okB9HnlwoglfaxItrHqHLKuMc
 mdLqE7+AwQNpcPJqmNfiYj8xMbN2EWsYx1wgFLciXP0MnLkcFC+E+FEkg+pVJ2GLvsPP7ockY
 XuyS024oxjBgrXBl2C3zhDMCZPbTbkuF9kM1ugEo6uruuk5nDuPQrz6Hrw/VAH+XH5DwepgZ9
 s7OtoKj4Q28c3kUh7nVN9mcQlW+gTvnGfAgig+wKj510fW+gmThp7/0laOiLm7qnL3L9OatYm
 FyHu67pbWOnPFo4ot2XwKzzOVLQVcDBdetBY1wyWI6+MlprmZrOEkRTA7cPsLeEK0jtu6Q10q
 uw9yJsWFgSx/L53Dzc6YWxhGJCzRJRa/m+AZ0e8XvhT8Neie85UkstFB7FNojrtzKyt2DgM0g
 3JjU/4GWqoOCJgRQgT7STKfLwhcJv9knnATCDn+wFP/kUO6W2x/thoUtBoK5AkUvI+ThBV1zD
 tLFmLcmeIJ7XtlY9dNSdrlDC11itDsc4w/pDEr0SEaBduXQayK70SJ8BboT4wqYePCAmxKk0b
 URjmyjB0EJlflZ6JvfLrXXLEe9/WMFmbZ4JsU8JF/8FoPvkC3aAmXzhDPAlCBe5pbHndnqr4H
 5eJ5rkfUJPFWkbq7B8Xu/nNfByQwXNApu9UWbOAlkzbNXSLcKrhWOnYVVm1+/q3TA1jjivUGK
 TtlmHNkuN4HFePBzFbG9GOjclxJ1C6LndKvyiSWZyHv9g/clVRAfBCkYtetUcRf7hImmynhF+
 0Xv/ArL491HTB1cG4phlxw+EXJY6vgIqlYB4rDqdBiOmomWXEo35VBJeLnffFuO8wh619MjHW
 oQdhHkf4fkCdXCSM3S7UJRCvGAvBH7bSp+EvQimkGN+7LnS8uWrhwvRbYsiqN/OgAOlwHbtn7
 vZUjvBSgxRSH2X/BOqTTCr5VC3f6aB3bkbqSFbcitzKrrfCQxo3HrNzaMA/DaqSp4ZLcdMA7O
 N7iD3DF3xooiiObc76c+NSSKEhs/njI02bv93h7Hji2wgGb4M7LF2hNGrMg8lIuxltNn+0r7a
 y+8thHJJ0gHi8bE2tg0WHtb8Tibrcbb8jNPmjrQIE4xzE82E6dWu241H/A2b8Snww/mfATJe/
 2E1ZjFJsGNJYDOkGV2GRZ/qyjm75iOb5w9TimQbHBs1Hho6XPzromJ1Vnrpzg7qX1wf7ibFov
 /53gK3LQiId/y+0Wqk/+bBaGTI63pCJrpB4upyuruNRIj2bHPrj9Ynr9yBjDkkShYU6a/Yro7
 NXZgHRlWEqLN5DyaKVSZ7TfT1PXFyyA5aX/nkeRGGjuoSmGqMCnwRClBsCJ8DpWDHIc7r+033
 GOO3Dfj5TEcA4IcYKa4wZwhZbuvl+Ub2UAp5lmNsz7oxmJNtbjGSw/wb5CkXPfAJjLQbTAtrC
 QvGb8AvrDyqIhNKf9r2XAog0DordHjgrmolg3JFzmSNxbSCMeLryBlCl0/Q5c/2Or7aAhYjZo
 xwldEBAVJj/0lY25zN7wbUXe0UFgoG1uu2/Yf4uPLKkKVegzMMLhcFT21+kuHx9BHnO41L1Wq
 Wvys/ZUXzXYLCBueZequwwIgl3xnzSS6z51sKckD0B2V7scNVDQjvVn7iSco65bBMSR7VOprW
 V4ggjYT3ZkWTg5sjNx8RwdRpmNw/RXUp34ejLq61LFxYQ4F5bowdBCVHZsujn9aOPNphSLrCj
 E82cBvHAJK2UOqc5AwW9CSStZpwrjVRY/WWJrOjA2gKSxQrz1l9b8NDlGTR5gLnBGKT+2tBX2
 m9oVTXMGIBrTwGlzHFHTWrZjAO9qjInAa5ClwSs8RzSNyjdNDCJlqHK9dELYvvzHA==

Am 27.04.25 um 00:52 schrieb Armin Wolf:

> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
>
>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>>>
>>>> The ACPI specification defines an interface for the operating system
>>>> to change the preferred cooling mode of a given ACPI thermal zone.
>>>> This interface takes the form of a special ACPI control method called
>>>> _SCP (see section 11.4.13 for details) and is already supported by th=
e
>>>> ACPI thermal driver.
>>>>
>>>> However this support as many issues:
>>>>
>>>> =C2=A0=C2=A0 - the kernel advertises support for the "3.0 _SCP Extens=
ions"=20
>>>> yet the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ACPI thermal driver does not support those e=
xtensions. This may
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 confuse the ACPI firmware.
>>>>
>>>> =C2=A0=C2=A0 - the execution of the _SCP control method happens after=
 the driver
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 retrieved the trip point values. This confli=
cts with the ACPI
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 specification:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "OSPM will automatically evaluat=
e _ACx and _PSV objects after
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 executing _SCP."
>>>>
>>>> =C2=A0=C2=A0 - the cooling mode is hardcoded to active cooling and ca=
nnot be
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 changed by the user.
>>>>
>>>> Those issues are fixed in this patch series. In the end the user
>>>> will be able to tell the ACPI firmware wether he prefers active or
>>>> passive cooling. This setting will also be interesting for
>>>> applications like TLP (https://linrunner.de/tlp/index.html).
>>>>
>>>> The whole series was tested on various devices supporting the _SCP
>>>> control method and on a device without the _SCP control method and
>>>> appears to work flawlessly.
>>> Any updates on this? I can proof that the new interface for setting=20
>>> the cooling mode
>>> works. Additionally the first two patches fix two issues inside the=20
>>> underlying code
>>> itself, so having them inside the mainline tree would be beneficial=20
>>> to users.
>> Sure.
>>
>> I'm going to get to them next week, probably on Monday.
>
> Ok, thanks.
>
> Armin Wolf
>
I am a bit ashamed of myself but i think we need to put this patch series =
on hold after all :(.

The reason of this is that i am confused by the ACPI specification regardi=
ng _SCP:

	11.1.2.1. OSPM Change of Cooling Policy

	When OSPM changes the platform=E2=80=99s cooling policy from one cooling =
mode to the other, the following occurs:

     	1. OSPM notifies the platform of the new cooling mode by running the=
 Set Cooling Policy (_SCP) control method in all thermal zones and invokin=
g the OS-specific Set Cooling Policy interface to all participating device=
s in each thermal zone.

     	2. Thresholds are updated in the hardware and OSPM is notified of th=
e change.

     	3. OSPM re-evaluates the active and passive cooling temperature trip=
 points for the zone and all devices in the zone to obtain the new tempera=
ture thresholds.

This section of the ACPI specification tells me that we need to evaluate t=
he _SCP control method of all ACPI thermal zones
at the same time, yet section 11.4.13. tells me that each _SCP control met=
hods belongs to the individual thermal zone.

The reason why i am concerned by this is because Windows adheres to sectio=
n 11.1.2.1. and only exposes this setting
as a global tunable. This might cause device manufacturers to depend on th=
is behavior and lead to strange things
should two thermal zones have different _SCP settings.

I will ask the UEFI mailing list which behavior is expected by the ACPI sp=
ecification. Until then i suggest that
we put this patch series on hold.

Thanks,
Armin Wolf


