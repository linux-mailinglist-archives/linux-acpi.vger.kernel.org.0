Return-Path: <linux-acpi+bounces-13737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702DAB9224
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 00:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A829A20BD4
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 22:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88F28A414;
	Thu, 15 May 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OqPnX/pw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3321D3CD;
	Thu, 15 May 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346728; cv=none; b=ABevHs9AcpFWyOPEHu7ZsbVPmffW5pX2U5sIuVR2FY/lIlhghzAHjUtVXtTml8KHoH4noK8evyMuylusopxvOldDRy/JmWjS9aTPoou2KDZdjpO5XkIwCh79VRtPBVKpbFkjVatSMLuXP2+rs9ztR3NGcLpIwX/2OS6rlAGFEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346728; c=relaxed/simple;
	bh=utV4UbqIcfj3fLRtnbUakItH9tRWD8UFDUwlxeD08EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtlOO4iT+JcO2GAUG6kn7oY0k54nXWsGVi1eUgM2bodo40yb33zYeRosKM0Q1YUxX1STExngt7Nkj3AzzkWOasQsJtuam/eLmZWtQg3JbvWxIdx1QDv4vf3PN/+UoTXBAVN/5QFv//IPKaRWVvZJMDemo+CJdLxOdorY/cSqvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OqPnX/pw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747346713; x=1747951513; i=w_armin@gmx.de;
	bh=y+AvyreBxvEMr3n6KAhGPSvdF8El4XZ6FzvHqM20aQQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OqPnX/pwX68NhZ+Gqk95ENl1LVC02ncysilLYWz9kNJbRUjWyNGgGvz7uFmyXZkf
	 vV6A5NUqonVFAJkGEKTXr17ZItDQvbLAiABuCgS1ml3rpT8sChOidisWH9pMk2Dia
	 OV8H8kEPSuaLTGY5VRLsLrhjkW6M96lAPyOF+XQ+Pdoe+UZeP3gsYcMXy1RBNELY+
	 Gi8vXnoF1ZYtVbg7bwtbNN6oZ3OU8VBHjDGuho+vSpFcWFxQG9IQ1oIs88sCgHVKW
	 ksvkoqXBvz7IdAMEw1p3XzXsILkcC9GytdA0Tq9wETrjZaiQFnGEwh4wmIFik/im1
	 n49QretHvwTygg0cww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1utiLR3afh-00bb6q; Fri, 16
 May 2025 00:05:12 +0200
Message-ID: <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
Date: Fri, 16 May 2025 00:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
To: j@jannau.net, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Vishnu Sankar <vishnuocv@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tbB8hxfqNOHBiN6rDK63ZoKR4og/dN6oOjcpMwItUrsVujvSEU4
 ZRMRQ80A1B7QvdYKk4/quD2+WMdhVvDmmSojZuohMjwG9e2lzAaVpKsnJTD1AMLlkvN3W1T
 ih+/h5bmtrHAjC0V8+F8knR6HEz1B4jXYNtziKusE1mYlnl0N/m5pqAOfs/TTmQ0bE3dwl1
 STZuxiOapxO2BNyPhudQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SJZGd2TbucQ=;UDfm+YNDV2H0XZG852a1/7CMsM9
 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
 E2ZwNTxy1GSI52HC

Am 12.05.25 um 23:55 schrieb Janne Grunau via B4 Relay:

> From: Janne Grunau <j@jannau.net>
>
> Commit 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd
> Fn keys") added a dependency on ACPI_PLATFORM_PROFILE to cycle through
> power profiles. This breaks USB and Bluetooth keyboards on non-ACPI
> platforms since platform_profile_init() fails. See the warning below for
> the visible symptom but cause is the dependency on the platform_profile
> module.
>
> [  266.225052] kernel: usb 1-1.3.2: new full-speed USB device number 9 u=
sing xhci_hcd
> [  266.316032] kernel: usb 1-1.3.2: New USB device found, idVendor=3D17e=
f, idProduct=3D6047, bcdDevice=3D 3.30
> [  266.327129] kernel: usb 1-1.3.2: New USB device strings: Mfr=3D1, Pro=
duct=3D2, SerialNumber=3D0
> [  266.327623] kernel: usb 1-1.3.2: Product: ThinkPad Compact USB Keyboa=
rd with TrackPoint
> [  266.328096] kernel: usb 1-1.3.2: Manufacturer: Lenovo
> [  266.337488] kernel: ------------[ cut here ]------------
> [  266.337551] kernel: WARNING: CPU: 4 PID: 2619 at fs/sysfs/group.c:131=
 internal_create_group+0xc0/0x358
> [  266.337584] kernel: Modules linked in: platform_profile(+) nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rej=
ect_ipv6 nft_reject nft_ct nft>
> [  266.337685] kernel:  apple_sio spi_apple apple_dart soundcore spmi_ap=
ple_controller pinctrl_apple_gpio i2c_pasemi_platform apple_admac i2c_pase=
mi_core clk_apple_nco xhci_pla>
> [  266.337717] kernel: CPU: 4 UID: 0 PID: 2619 Comm: (udev-worker) Taint=
ed: G S      W          6.14.4-400.asahi.fc41.aarch64+16k #1
> [  266.337750] kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
> [  266.337776] kernel: Hardware name: Apple Mac mini (M1, 2020) (DT)
> [  266.337808] kernel: pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -=
SSBS BTYPE=3D--)
> [  266.337834] kernel: pc : internal_create_group+0xc0/0x358
> [  266.337860] kernel: lr : sysfs_create_group+0x20/0x40
> [  266.337886] kernel: sp : ffff800086f877a0
> [  266.337914] kernel: x29: ffff800086f877b0 x28: 0000000000000000 x27: =
ffffb66d0b338348
> [  266.337939] kernel: x26: ffffb66d0b338358 x25: ffffb66d528c7c50 x24: =
ffffb66d507e37b0
> [  266.337965] kernel: x23: 0000fffebf6708d8 x22: 0000000000000000 x21: =
ffffb66d0b370340
> [  266.337991] kernel: x20: ffffb66d0b370308 x19: 0000000000000000 x18: =
0000000000000000
> [  266.338029] kernel: x17: 554e514553007373 x16: ffffb66d4f8c2268 x15: =
595342555300656c
> [  266.338051] kernel: x14: 69666f72702d6d72 x13: 00353236353d4d55 x12: =
4e51455300737361
> [  266.338075] kernel: x11: ffff6adf91b80100 x10: 0000000000000139 x9 : =
ffffb66d4f8c2288
> [  266.338097] kernel: x8 : ffff800086f87620 x7 : 0000000000000000 x6 : =
0000000000000000
> [  266.338116] kernel: x5 : ffff6adfc896e100 x4 : 0000000000000000 x3 : =
ffff6adfc896e100
> [  266.338139] kernel: x2 : ffffb66d0b3703a0 x1 : 0000000000000000 x0 : =
0000000000000000
> [  266.338155] kernel: Call trace:
> [  266.338173] kernel:  internal_create_group+0xc0/0x358 (P)
> [  266.338193] kernel:  sysfs_create_group+0x20/0x40
> [  266.338206] kernel:  platform_profile_init+0x48/0x3ff8 [platform_prof=
ile]
> [  266.338224] kernel:  do_one_initcall+0x60/0x358
> [  266.338239] kernel:  do_init_module+0x94/0x260
> [  266.338257] kernel:  load_module+0x5e0/0x708
> [  266.338271] kernel:  init_module_from_file+0x94/0x100
> [  266.338290] kernel:  __arm64_sys_finit_module+0x268/0x360
> [  266.338309] kernel:  invoke_syscall+0x6c/0x100
> [  266.338327] kernel:  el0_svc_common.constprop.0+0xc8/0xf0
> [  266.338346] kernel:  do_el0_svc+0x24/0x38
> [  266.338365] kernel:  el0_svc+0x3c/0x170
> [  266.338385] kernel:  el0t_64_sync_handler+0x10c/0x138
> [  266.338404] kernel:  el0t_64_sync+0x1b0/0x1b8
> [  266.338419] kernel: ---[ end trace 0000000000000000 ]---
>
> Fixes: 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd =
Fn keys")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ------>8---------
> I don't see an easy solution to keep the functionality in generic HID
> code which is used on non-ACPI platforms. Solution for this are not
> trivial so remove the functionality for now.
> Cc-ing the ACPI maintainers in the case they can think of a solution for
> this issue.

Hi,

i think we can fix that. We just have to skip the compat stuff if acpi_kob=
j is NULL (means that ACPI is not used).
The modern platform profile interface is generic enough to also work on no=
n-ACPI systems.

Can you test a patch?

Thanks,
Armin Wolf

>
> ---
>   drivers/hid/Kconfig      | 1 -
>   drivers/hid/hid-lenovo.c | 5 +----
>   2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a503252702b7b43c332a12b14bc8b23b83e9f028..6b4445f54b2f2818d451ff28=
b3f7bcc2b1c7e99f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -596,7 +596,6 @@ config HID_LED
>   config HID_LENOVO
>   	tristate "Lenovo / Thinkpad devices"
>   	depends on ACPI
> -	select ACPI_PLATFORM_PROFILE
>   	select NEW_LEDS
>   	select LEDS_CLASS
>   	help
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index af29ba840522f99bc2f426d4753f70d442cef3af..cff4b5ddd9aa9bad0516f8c9=
beb58927c24477fc 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -32,8 +32,6 @@
>   #include <linux/leds.h>
>   #include <linux/workqueue.h>
>  =20
> -#include <linux/platform_profile.h>
> -
>   #include "hid-ids.h"
>  =20
>   /* Userspace expects F20 for mic-mute KEY_MICMUTE does not work */
> @@ -729,8 +727,7 @@ static int lenovo_raw_event_TP_X12_tab(struct hid_de=
vice *hdev, u32 raw_data)
>   				report_key_event(input, KEY_RFKILL);
>   				return 1;
>   			}
> -			platform_profile_cycle();
> -			return 1;
> +			return 0;
>   		case TP_X12_RAW_HOTKEY_FN_F10:
>   			/* TAB1 has PICKUP Phone and TAB2 use Snipping tool*/
>   			(hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB) ?
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250512-hid_lenovo_unbreak_non_acpi-c041f3cc13b6
>
> Best regards,

