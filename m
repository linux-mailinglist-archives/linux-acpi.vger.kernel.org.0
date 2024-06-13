Return-Path: <linux-acpi+bounces-6376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE37907BB6
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C220B22915
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DB14C5A1;
	Thu, 13 Jun 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slHlJzqb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AE14B064;
	Thu, 13 Jun 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304323; cv=none; b=oLJuM2yfty/LEINP7NB3vFngvh2zBZStKRIim63RjGEn71FS8+TaMxSzKgGKhrMQTsgXs0M1qxMlC64Jt8pQgQf8cG8VyavG8JsxUWF9p262GthoOsNzWVFrOgkqce151itUp1Oj0Npd/LTaOmuQ4yRR9hsNjyaqkw46Sqyfwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304323; c=relaxed/simple;
	bh=dz3zCI6YU82Uz1XNh9X86evbYeMdgc0eAQiDS3r8yeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjLshg8NyzeKT7d33Zy3Hz94cm3BR06o9MUS3ufPtz3zofZQq//71mi/fwUulc46sZQPo/WVOeyHhi6E6QN48t63jxK6ogGqRM1SVlB81lls7qavMIC1QdOnUgd0xfWEOGbbE0LLZVQCfpk5qCf7f40aAspeO+P16QyDAFh9bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slHlJzqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B252C2BBFC;
	Thu, 13 Jun 2024 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718304323;
	bh=dz3zCI6YU82Uz1XNh9X86evbYeMdgc0eAQiDS3r8yeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=slHlJzqb/VD5LS6AbpVu+kzEtYBKZGf1lP4Ri+UZxf997hWgQuDwSPb+48C6oYjLT
	 wlBveHe9GHb0WR1TwNk0rjL4KEbaEkuPxOagAk1KLfRggjYERsgabY1HJ23021jKnI
	 Na1C2griN1EC+3HKIYH/S70cm2Tx1/n1nh8ybWRC9CEoyrN0A+AKxxGJ1aqF3cas9+
	 ekrI++w9YmKvcK/NUqN1SINGHvw3O7Hl+L2Stdn9TD38XH1dhWyVCkmcb7VpPuN/sV
	 n5kNQ+hV85Izi/p2yItT6Ng99ds/K8UJrDYdsbHUydooIZabhol8l7eSlRDWclv0CR
	 6dSSvNn+jHGvA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b335681e82so96148eaf.2;
        Thu, 13 Jun 2024 11:45:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2yM6ic+hll2LS42DB/7ECQq2mD2cuzbwH7OirYyHOU1M8+Av69c4QylmNRtw4j98FD2+b2Z3hx/mK@vger.kernel.org, AJvYcCU3vDEmExA98MMFso32xlZ8MrDLfRWb9Fk6ke+a+C5M6uL99k1GQxsgxU95MxoNrgj/32NDWbSmA9p+s9wi@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpgnD8Bb1k59bUa0K8PNY7SkomLJzZFqfRUVPQ3iVl9iKdQDO
	zzqsBmimXq1x4oNmatzbsFGs6FnBM9npc0ZGzBDyOaiX3WUBX5hO9tfVK1Qfotr6BOAdybrAMdZ
	EosG5Kj0CsFmW9PjM3Q3t1ckK2sw=
X-Google-Smtp-Source: AGHT+IEf3ibou8q8QUHaRg6DKML72TQnww09CbFOBVqdsxneWB5Bgglh69QTQRdkZIumGXvFGZTtz9fOmiHsswIGb9U=
X-Received: by 2002:a4a:d027:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5bdadc10d0amr583155eaf.1.1718304322656; Thu, 13 Jun 2024
 11:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611172528.352782-1-tony.luck@intel.com>
In-Reply-To: <20240611172528.352782-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 20:45:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjxnsLQRXk0meuTVv_pO9KXrGZLpnetB=EmfzSw1ydEQ@mail.gmail.com>
Message-ID: <CAJZ5v0gjxnsLQRXk0meuTVv_pO9KXrGZLpnetB=EmfzSw1ydEQ@mail.gmail.com>
Subject: Re: [PATCH v6 41/49 RESEND] ACPI: x86: Switch to new Intel CPU model defines
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:25=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> Rafael: I missed this one when picking out ACPI/pm patches to send
> to you from the patch bomb. Can you check it over and apply please?
>
> -Tony
>
>  drivers/acpi/x86/utils.c | 44 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 7dca73417e2b..e628d969d613 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -45,37 +45,37 @@ struct override_status_id {
>         unsigned long long status;
>  };
>
> -#define ENTRY(status, hid, uid, path, cpu_model, dmi...) {             \
> +#define ENTRY(status, hid, uid, path, cpu_vfm, dmi...) {               \
>         { { hid, }, {} },                                               \
> -       { X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },            \
> +       { X86_MATCH_VFM(cpu_vfm, NULL), {} },                           \
>         { { .matches =3D dmi }, {} },                                    =
 \
>         uid,                                                            \
>         path,                                                           \
>         status,                                                         \
>  }
>
> -#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
> -       ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_model, dmi)
> +#define PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
> +       ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_vfm, dmi)
>
> -#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
> -       ENTRY(0, hid, uid, NULL, cpu_model, dmi)
> +#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
> +       ENTRY(0, hid, uid, NULL, cpu_vfm, dmi)
>
> -#define PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
> -       ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_model, dmi)
> +#define PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
> +       ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_vfm, dmi)
>
> -#define NOT_PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
> -       ENTRY(0, "", NULL, path, cpu_model, dmi)
> +#define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
> +       ENTRY(0, "", NULL, path, cpu_vfm, dmi)
>
>  static const struct override_status_id override_status_ids[] =3D {
>         /*
>          * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
>          * but Linux uses a separate PWM driver, harmless if not used.
>          */
> -       PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
> -       PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
> +       PRESENT_ENTRY_HID("80860F09", "1", INTEL_ATOM_SILVERMONT, {}),
> +       PRESENT_ENTRY_HID("80862288", "1", INTEL_ATOM_AIRMONT, {}),
>
>         /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control =
*/
> -       PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>               }),
> @@ -84,18 +84,18 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * The INT0002 device is necessary to clear wakeup interrupt sour=
ces
>          * on Cherry Trail devices, without it we get nobody cared IRQ ms=
gs.
>          */
> -       PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
> +       PRESENT_ENTRY_HID("INT0002", "1", INTEL_ATOM_AIRMONT, {}),
>         /*
>          * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
>          * the touchscreen ACPI device until a certain time
>          * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
>          * *and* _STA has been called at least 3 times since.
>          */
> -       PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
> +       PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>               }),
> -       PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
> +       PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
>               }),
> @@ -104,7 +104,7 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * The Dell XPS 15 9550 has a SMO8110 accelerometer /
>          * HDD freefall sensor which is wrongly marked as not present.
>          */
> -       PRESENT_ENTRY_HID("SMO8810", "1", SKYLAKE, {
> +       PRESENT_ENTRY_HID("SMO8810", "1", INTEL_SKYLAKE, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9550"),
>               }),
> @@ -121,19 +121,19 @@ static const struct override_status_id override_sta=
tus_ids[] =3D {
>          * was copy-pasted from the GPD win, so it has a disabled KIOX000=
A
>          * node which we should not enable, thus we also check the BIOS d=
ate.
>          */
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>                 DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
>               }),
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>                 DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
>               }),
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> @@ -146,7 +146,7 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * method sets a GPIO causing the PCI wifi card to turn off.
>          * See above remark about uniqueness of the DMI match.
>          */
> -       NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", ATOM_AIRMONT, {
> +       NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", INTEL_ATOM_AIRMON=
T, {
>                 DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
> @@ -158,7 +158,7 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * as both ACCL0001 and MAGN0001. As we can only ever register an
>          * i2c client for one of them, ignore MAGN0001.
>          */
> -       NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
> +       NOT_PRESENT_ENTRY_HID("MAGN0001", "1", INTEL_ATOM_SILVERMONT, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
>               }),
> --

Applied as 6.11 material, thanks!

