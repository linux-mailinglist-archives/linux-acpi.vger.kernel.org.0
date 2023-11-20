Return-Path: <linux-acpi+bounces-1633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B37F1CCE
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9251C20931
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65A32189
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB079BE
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:54:40 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6cb552cf81dso190531b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499280; x=1701104080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jblkl8yKHQ2WkDfRJ44kp6B1ZEDxNOiUDhR4QFlMlL0=;
        b=Y/AUImlz4xTJ6jqU1U0nrccbLdtWHHPhToAUd1vN3JoJHAJtIdz1WK+Bj4+0Icptah
         l3u4kcZ3B+6ASURs7e3aTZaM8wX9EU8kmu1dsy3motqR2cgzycDkfAtGTqYCbQes7TWO
         1rdY0cN+U2Qfb3Ol9Nnef9ZiThBpxDRkpv0DYWLCBXnH8UT3wJEPOEpWLUdSFS8AhtoK
         R5GGYuNmqCBAugiBjpeUCmYk25u17G8Uu1dUHZJxqQM7zGEqNXcd/veDgHTGNYzkCrIf
         Ct5lu/ZAvhCpM7mNjN7A2agypp1n7+1zOUeTfvHDE8OqZoT0a/+67A0cueYb4wkVyhlY
         iI2Q==
X-Gm-Message-State: AOJu0YyL5qdJbSjB4izPn9K1ZZR6bnlPa5YZNw3jZz6F1A7nBo1kB6qs
	Fr9Q1dJyUFiez3sB/9pqKyCUeSFhRpkON0rAYFE=
X-Google-Smtp-Source: AGHT+IE1GGGNO+Ky+5v7GTn9jtPyqYDyGeE53IElbY/EDq7bbpmR2VV7t2RYhDMhHqFhzq3xwnmtbmyij2pIb+DQ95I=
X-Received: by 2002:a05:6a20:549d:b0:187:1e56:c153 with SMTP id
 i29-20020a056a20549d00b001871e56c153mr11632288pzk.2.1700499280203; Mon, 20
 Nov 2023 08:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114120611.128054-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20231114120611.128054-1-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:54:28 +0100
Message-ID: <CAJZ5v0iEt=GqEkVPp5iuBzKjKGxq9i7=W_L+NiOBk4oGiwyHdg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Run USB4 _OSC() first with query bit set
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	NaamaX Shachar <naamax.shachar@intel.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 1:06=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The platform can deny certain tunneling from the OS and it does that by
> clearing the control bits it does not want the OS to get and returning
> with OSC_CAPABILITIES_MASK_ERROR bit set. Currently we do not handle
> this properly so if this happens, for example when the platform denies
> PCIe tunneling, we just fail the whole negotiation and revert back to
> what the Thunderbolt driver is doing to figure out whether the
> controller is running firmware connection manager or not. However, we
> should honor what the platform returns.
>
> For this reason run the USB4 _OSC() first with query bit set, and then
> use the returned control double word (that may contain some of the bits
> cleared by the platform) and run it second time with query bit clear.
>
> While there, remove an extra space from the assignment of the control
> double word.
>
> Reported-by: NaamaX Shachar <naamax.shachar@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 72e64c0718c9..569bd15f211b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -408,7 +408,7 @@ static void acpi_bus_decode_usb_osc(const char *msg, =
u32 bits)
>  static u8 sb_usb_uuid_str[] =3D "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
>  static void acpi_bus_osc_negotiate_usb_control(void)
>  {
> -       u32 capbuf[3];
> +       u32 capbuf[3], *capbuf_ret;
>         struct acpi_osc_context context =3D {
>                 .uuid_str =3D sb_usb_uuid_str,
>                 .rev =3D 1,
> @@ -428,7 +428,12 @@ static void acpi_bus_osc_negotiate_usb_control(void)
>         control =3D OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
>                   OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
>
> -       capbuf[OSC_QUERY_DWORD] =3D 0;
> +       /*
> +        * Run _OSC first with query bit set, trying to get control over
> +        * all tunneling. The platform can then clear out bits in the
> +        * control dword that it does not want to grant to the OS.
> +        */
> +       capbuf[OSC_QUERY_DWORD] =3D OSC_QUERY_ENABLE;
>         capbuf[OSC_SUPPORT_DWORD] =3D 0;
>         capbuf[OSC_CONTROL_DWORD] =3D control;
>
> @@ -441,8 +446,29 @@ static void acpi_bus_osc_negotiate_usb_control(void)
>                 goto out_free;
>         }
>
> +       /*
> +        * Run _OSC again now with query bit clear and the control dword
> +        * matching what the platform granted (which may not have all
> +        * the control bits set).
> +        */
> +       capbuf_ret =3D context.ret.pointer;
> +
> +       capbuf[OSC_QUERY_DWORD] =3D 0;
> +       capbuf[OSC_CONTROL_DWORD] =3D capbuf_ret[OSC_CONTROL_DWORD];
> +
> +       kfree(context.ret.pointer);
> +
> +       status =3D acpi_run_osc(handle, &context);
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       if (context.ret.length !=3D sizeof(capbuf)) {
> +               pr_info("USB4 _OSC: returned invalid length buffer\n");
> +               goto out_free;
> +       }
> +
>         osc_sb_native_usb4_control =3D
> -               control &  acpi_osc_ctx_get_pci_control(&context);
> +               control & acpi_osc_ctx_get_pci_control(&context);
>
>         acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
>         acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
> --

Applied as 6.8 material, but if you want me to push this for 6.7-rc,
please let me know (in which case it would be nice to have a Fixes:
tag to put on it).

Thanks!

