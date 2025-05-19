Return-Path: <linux-acpi+bounces-13815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B646EABCAA1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B183BA487
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C92116F2;
	Mon, 19 May 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cxjTJBW8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEF20C469;
	Mon, 19 May 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692266; cv=none; b=KzdnB5MvT5RmVe2bnDX5WU9/wAWj7R8Wdeo3Y+7i32MNpskiMdaEqsu6huY6cx7oAlO4/UjXt8Fc6o7W4pzXj58pHcTpmKBwxT8omO5qBnJ3kGQnOtHBN+r876ZbwZSQVdNgHPyITn8CV5mzj+AWJxQVk9yRdFguNqkpzeJuwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692266; c=relaxed/simple;
	bh=DXwA8UFgNfFXtY527UnnRjD6K29J00NqX8kiX0PoSjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7s7uemFFDXWdoVlbY1k3Lgau6XHlP/UFOO7e57WV1F/q46DMFBdY8HxJGfhpWpx9fZgjjWu9og5hMtTpkben0UZlujmD9l4k5Zuk43axEm8yIg5T/oJZdzWOmdm2aimMSxSiogizculngiwQ/g6ZhLuhHhJ7x/onin+LvHMOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cxjTJBW8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747692253; x=1748297053; i=w_armin@gmx.de;
	bh=aZZ8Kdw0SSrAioneELRCMNno6OhCWBVK4rQrxwfaFcM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cxjTJBW8QMUM1PVtrGNM+Vs6zYr8gnS+IB2RU7wetwgnDV0scmW1glAyTpXujnJe
	 8yRHKb/3/6UqwRoH8bLh4gJnJzYNIiWRP/2fTVSM1fwQKIVV4TLKAf02BxyqaTlc5
	 Wh2WWqxzKlFaOT/q0Qr6SoWiA74HLp2/TCpE0SlHwman75SbEwhgBAzzE5tG3ArdJ
	 +RoA7SX1UG0eSOnl+C/JX1aD8X7fzy4AyvypxXySBdHSbIamPxtvxSj69H8UvIB+z
	 GAN8S01vBvkHwYeLl0vH1d41Yq0p22ugUimDgmwwzzd5GOvyX3asd2l3XRdO6479a
	 N/k4Wp9wYkUHMq/r8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1ukxEl3fsJ-00mons; Tue, 20
 May 2025 00:04:13 +0200
Message-ID: <4262d612-f929-4d62-baf3-c334ff46d30f@gmx.de>
Date: Tue, 20 May 2025 00:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: lenovo: Remove CONFIG_ACPI dependency
To: j@jannau.net, Arnd Bergmann <arnd@arndb.de>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250519-hid_lenovo_acpi_dependency-v2-1-124760ddd6f7@jannau.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250519-hid_lenovo_acpi_dependency-v2-1-124760ddd6f7@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zceLL4YByw2zsOGAXiWoGEV6MiDBNaCYGTjquHqdJew4CNGwLHX
 KV6OxX3VouvGJdzfV1SjKovbL+rmq4PkFNrxeyHLVxBR6XR66clkKn0vqu2zbeWd8w4SfgO
 xzlhxZRMEY353dZ6EgtPgGqhiMRIdl8ea9EWJItyGXFBWybUCSJbieWrNMG8wk9b3hnYV6V
 r0fEwvIhPFUyBrcsVKrDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+hj7UhviMPI=;TAWfrNWkz6K4cXv2nTlli5vjwL0
 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
 70yf2TAHsHf8mCJsR1uznzovM

Am 19.05.25 um 22:49 schrieb Janne Grunau via B4 Relay:

> From: Janne Grunau <j@jannau.net>
>
> The hid-lenovo driver supports external Bluetooth and USB devices which
> can be used with non-ACPI systems/kernels. Call platform_profile_cycle()
> only if CONFIG_ACPI_PLATFORM_PROFILE is enabled and select
> CONFIG_ACPI_PLATFORM_PROFILE only if ACPI is enabled.
> This should not affect functionality since only the detachable keyboard
> of a x86 tablet with a custom connector has an hotkey for cycling
> through power profiles.
>
> Fixes: 52572cde8b4a4 ("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE"=
)
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> hid-lenovo supports external generic USB and Bluetooth devices and
> should be buildable and usable on non-ACPI kernels and systems. Commit
> 84c9d2a968c82 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn
> keys") added a hot key to cycle through power profiles using ACPI's
> platform_profile. This resulted in adding a dependency on ACPI and
> selecting CONFIG_ACPI_PLATFORM_PROFILE to fix build an link errors in
> commit 52572cde8b4a ("HID: lenovo: select
> CONFIG_ACPI_PLATFORM_PROFILE"). This is undesirable for HID drivers
> supporting generic USB and Bluetooth devices. So instead call
> platform_profile_cycle() only CONFIG_ACPI_PLATFORM_PROFILE is enabled
> and select the latter only if ACPI is enabled.
>
> Supercedes with Armin Wolf's "ACPI: platform_profile: Add support for
> non-ACPI platforms" [1] the earlier removel in "HID: lenovo: Unbreak
> USB/BT keyboards on non-ACPI platforms" [2].
>
> [1]: https://lore.kernel.org/linux-acpi/20250518185111.3560-1-W_Armin@gm=
x.de/
> [2]: https://lore.kernel.org/linux-input/20250512-hid_lenovo_unbreak_non=
_acpi-v1-1-e9e37ecbfbfe@jannau.net/
> ---
> Changes in v2:
> - drop stub platform_profile_cycle()
> - call platform_profile_cycle() conditioanlly
> - drop 'depends on ACPI || !ACPI'
> - Link to v1: https://lore.kernel.org/r/20250518-hid_lenovo_acpi_depende=
ncy-v1-0-afdb93b5d1a6@jannau.net
> ---
>   drivers/hid/Kconfig      | 3 +--
>   drivers/hid/hid-lenovo.c | 6 ++++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a503252702b7b43c332a12b14bc8b23b83e9f028..1656bb1504f750d73011d3f0=
08e27b4436a58678 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -595,8 +595,7 @@ config HID_LED
>  =20
>   config HID_LENOVO
>   	tristate "Lenovo / Thinkpad devices"
> -	depends on ACPI
> -	select ACPI_PLATFORM_PROFILE
> +	select ACPI_PLATFORM_PROFILE if ACPI
>   	select NEW_LEDS
>   	select LEDS_CLASS
>   	help
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index af29ba840522f99bc2f426d4753f70d442cef3af..73c6a26638a22ad1c8368112=
e8ab185232a9df12 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -728,9 +728,11 @@ static int lenovo_raw_event_TP_X12_tab(struct hid_d=
evice *hdev, u32 raw_data)
>   			if (hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB) {
>   				report_key_event(input, KEY_RFKILL);
>   				return 1;
> +			} else if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)) {
> +				platform_profile_cycle();
> +				return 1;
>   			}

Please turn the "if else" into a single "if":

	if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)) {
		platform_profile_cycle();
		return 1;
	}

	return 0;

  With this being done:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thanks,
Armin Wolf

> -			platform_profile_cycle();
> -			return 1;
> +			return 0;
>   		case TP_X12_RAW_HOTKEY_FN_F10:
>   			/* TAB1 has PICKUP Phone and TAB2 use Snipping tool*/
>   			(hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB) ?
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250518-hid_lenovo_acpi_dependency-0ea78a6bd740
>
> Best regards,

