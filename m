Return-Path: <linux-acpi+bounces-15282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33EB0E14E
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F6AA77B7
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04A27A451;
	Tue, 22 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NxYOh0wn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23C1E5B69;
	Tue, 22 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200585; cv=none; b=IF3OSXnq+3Zk+8bdOEocXigVm4r4XTapug9vqq1GZS76cIhZYndCLjwqlHBhtjkbSxb3N4N0WOixRa5aYtiJrMysker+vr2BmLpKXWjO2u1C/2A+z7XXaU1UKKm1HxatNq9yBBEfZ5Ke4PiHtwqIk5Hp5eGmaAP7QOjAApQUG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200585; c=relaxed/simple;
	bh=DNMSnCUpupSxBs2I5aWAsVBdwIy2uXQbv4wv/xdkf98=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gk2mIiR7ooGdFvgiCktfg56VfDTFQUeTgucFBoHCL1MCnuTbhc8h2DiOvKzKwNGK1DJz0DWKKwQPm1U3zl1evy77nByalMs2y46gSFNfucbwAUEYTFSRj2QkOrM3Okfcs7HdS0tgP9mMjMHusIW5peeE2UfXzIhHI8wLcmOWnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NxYOh0wn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753200579; x=1753805379; i=w_armin@gmx.de;
	bh=WQ2S25k3eRQ+d9qHupzJvo+pxYLzJFrIHbpZgH924og=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NxYOh0wngz9/esO+3CGUjE6NAOUHmOPwMX6d51uNnIr5BrpSOcj+R1fAplqlJJ8w
	 CMDk04GwIrDZJuoAnvhJrFtkC1abfBd6GmGlHJCoMZ+nF7j7NaaCcmE7O2HsQAetS
	 1PXfcymb4e3/JRTE9PYl1hkPMfFQRSQt0TVD68HNJ3xOrRGpwI3yFXmiTfcGJZTr7
	 Nqecmdmqs+TPGgMi7h7JXJsoMRZmSYqOmrHOvlmZRY55XsQNEhlRovhSypTrHMJlw
	 huU6LhH9725UebdUMCfKsFgzN8Ak6T4HmctTzJflkX6hPsIhyGUqyNJ8WCx4ElaRF
	 iFUILPondjniqPwrVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1uHTU00oZH-00LbpD; Tue, 22
 Jul 2025 18:09:39 +0200
Message-ID: <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
Date: Tue, 22 Jul 2025 18:09:37 +0200
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Scq8WI1nb8wnBmhwIyLj4+kc/Sl6hL1757rHz6Wf3XPvaR+s6ai
 3ZdleLYoeC7wt5utu8Y0jpC5Sdlci31s2WGSzjWEnazC6Y7gyNEMqLow2786aP5wUHLkKQ5
 ymYblf3v8a8RaMtahsGZdYwRthb96TNH0lKlwNMWmBUtV71Z2RB96TOytwY6tla7pJUM3WQ
 pDL9/4GU6vOgSAZ5lL/Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zYRX0oVDKKY=;0y4dghwAOa/CZ8rzZeh9MzwXLfe
 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

Am 22.07.25 um 14:48 schrieb Nikita Krasnov:

> On Mon, Jul 21, 2025 at 02:23:32AM +0300 Armin Wolf wrote:
>> please share the whole output of acpidump as the DSDT contains only two=
 unrelated
>> WMI devices.
> Sure! I've attached a ZIP archive with the output of the `acpidump -b`.
>
>> I think that we do not need another driver in this case, as the xiaomi-=
wmi driver
>> is responsible for handling WMI events on Xiaomi devices. I can check w=
hat needs
>> to be done in order to add support for those additional keyboard events=
, but for
>> that i need the full output of acpidump.
> Btw, I'd appreciate if you didn't patch the driver yourself and instead
> let me do it. This is a golden opportunity for me to gain some
> experience! :D

Sure, but you have to develop a new WMI driver for your device because aft=
er looking at the
ACPI tables (SSDT20 in particular) i came to the conclusion that the xiaom=
i-wmi driver cannot
be used in this case.

> If you may, there are some questions I have about this issue:
>
>   1. From what I saw on the internet, ACPI is a protocol
>      (specification?) for how the power management is done on the modern
>      hardware. What do keyboard events have to do with ACPI? Is it
>      because the keypress here is handled by the firmware?

The hotkey events cannot be delivered over the standard keyboard interface=
 as there are no scan codes
defined for all of those events. Because of this the platform firmware (in=
 this case ACPI) provides a
virtual device (the WMI device) for receiving those events from the (embed=
ded) keyboard controller.

>
>   2. Where in the kernel source tree can I seem some similar drivers?
>      Something to understand there general structure and internals.

Take a look at https://docs.kernel.org/wmi/driver-development-guide.html.

In your case you need to write a WMI event driver for the following WMI de=
vice:

class WMIEvent : __ExtrinsicEvent {
};

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x40A"), Description("Root=
 WMI HID_EVENT20"), guid("{46c93e13-ee9b-4262-8488-563bca757fef}")]
class HID_EVENT20 : WmiEvent {
   [key, read] string InstanceName;
   [read] boolean Active;
   [WmiDataId(1), read, write, Description("Package Data")] uint8 EventDet=
ail[32];
};

The event data of this WMI event device is a buffer with a size of 32 byte=
s. The "EV20" ACPI control method
is responsible for filling this buffer with information regarding hotkey e=
vents. I suggest that you write a
skeleton driver first that basically prints the content of this buffer to =
the kernel log using print_hex_dump_bytes().

This way you can determine the mapping between WMI event numbers and the h=
otkeys. In your case the event data seems
to be structured like this:

	1. byte: event class
	2. byte: event number
	3. byte: event payload

If you need further help just ask me :).

>   3. What is WMI? Primarily in the context of the Linux kernel, of
>      course There is Documentation/driver-api/wmi.rst, but it hard to
>      understand what exactly is it talking about if you had no prior
>      experience with writing drivers.

ACPI-WMI is a Windows-specific extension of the ACPI interface. It=20
allows the firmware to expose custom management interfaces (WMI objects)=
=20
of the Windows Management Interface (WMI). We implement a subset of the=20
WMI interface inside the Linux kernel to be able to control the various=20
platform-specific settings being exposed this way. Thanks, Armin Wolf


