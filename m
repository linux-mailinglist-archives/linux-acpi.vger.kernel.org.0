Return-Path: <linux-acpi+bounces-8541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866298E21F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EB1F22A29
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E31D1F57;
	Wed,  2 Oct 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRhTMiHK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F71D0F7F;
	Wed,  2 Oct 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892794; cv=none; b=ocsS1BWAJKYR+Eb7hi5FoMhfbLMoq2I7SFpx2MV90dhE33Kuk7E/89aAZ7XTYBhI6TS0azTatR0lQI6YPwJ0+XmDlz0epqdBwKfyZXEzkluNbk1BvqPnOnGqsV5zJdzla1u08l536BOniVETU100u5lsKfLle9PCzjIvp9CuIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892794; c=relaxed/simple;
	bh=grwSoWKPsOI8pRGhnuHfLCDv1R3IvWwGE3IGbB7BvHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuWQ5HN82ubjMDmZrZfKVxexUxI3JEk5Au94rlxHq45DMVagiIudUoR+vsqfNoG+93y2hJ0dPaPhN5/JHEFp6F9rcvTfqzAnQqbpq0GxEPRn+Wx+p0AJp34Efkiggk1a9EeMyLHEZEGGNGcpJ+Kwyno8/KX2YAhCXzrLGAcTv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRhTMiHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB1C4CED1;
	Wed,  2 Oct 2024 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727892794;
	bh=grwSoWKPsOI8pRGhnuHfLCDv1R3IvWwGE3IGbB7BvHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dRhTMiHKT1RnETVX+Hkwembxlg2VggFcKSlhr7s8hLH64V0gcLgNOkOL94eScWePu
	 1ayKicEl7qSutBlLWK62FYfrFnsvNPb4r4tQmgfUDpN4kNTESitrgO69FKGyYmuC7i
	 RguPCxczFsmZcwYOkOiRF3RCF+HuXZ0pCaeKZsXzx0FUzplX8tlMTqKAftYQsxmRIY
	 fufdEFLxriX1YYPRLtmoA6buicBoncwPsjKZkA8JL5awTdNeMihc7J4T46rvWrpGRp
	 mTZtEJ82tPztFo2qBNMjKBGPBmCXZ6dXdQ3AsBvafdqPHeS9XACFVkR2mMw5KWvMII
	 d7Mkw7mTba3SA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e039666812so101336b6e.1;
        Wed, 02 Oct 2024 11:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtAMjAcS5E4AS3lZZAhdLlTFO2bf0ZbdRc7M8dz/gkVLmoxo7sQShxuyY6oSrLaVhmD5qhVlRIDZaJIK6L@vger.kernel.org, AJvYcCX8JzoOH1IjC+k/1UgzWfVvbGRJSxLwOMAPng98L6d2HoJe/9uC7fVnvP1POi67SmZBXaTIt7PAGIbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2w1Hubi5YiOqcAzoDc6CYLR1zIdeUxcYXUzj9lk7+MSu3F7Z
	WUoR82FG+4IwE/sMReSKNTrCq+AHcXNNZFbQOI9FLo9jvmgMAOwWO+/z8FmvxmkWNHy7Or3xWXy
	oTSr9kvBNf6nJwe67S2JECeIqTIE=
X-Google-Smtp-Source: AGHT+IE3dupSoce4kYpZO3+6P99yFSc6BYr72zwY1Tqta07GNvTEYwGWWcgn1Fx1RxCjaVyg5dSaBYUyfRESgyNJPrY=
X-Received: by 2002:a05:6808:3196:b0:3e3:a7f2:1aa4 with SMTP id
 5614622812f47-3e3b40e5856mr3269526b6e.8.1727892793837; Wed, 02 Oct 2024
 11:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org> <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
In-Reply-To: <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 20:13:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
Message-ID: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com, rafael.j.wysocki@intel.com, 
	ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> Revision 3 supports specifying the UART input clock. This allows for
> proper computation of the UART divisor when the baud rate is specified.
>
> The earlycon code can accept the following format (See `parse_options`
> in `earlycon.c`.):
> * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
>
> This change makes it so the uartclk is passed along if it's defined in
> the SPCR table.
>
> Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> baud defined:
> [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,4800000=
0
> [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115=
200,48000000')
> [    0.028272] printk: legacy bootconsole [uart0] enabled
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>
> ---
>
>  drivers/acpi/spcr.c   | 5 ++++-
>  include/acpi/actbl3.h | 6 +++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2c7..67ae42afcc59ef 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, boo=
l enable_console)
>         if (!baud_rate) {
>                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype=
,
>                          table->serial_port.address);
> -       } else {
> +       } else if (table->header.revision <=3D 2 || !table->uartclk) {
>                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iot=
ype,
>                          table->serial_port.address, baud_rate);
> +       } else {
> +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart, =
iotype,
> +                        table->serial_port.address, baud_rate, table->ua=
rtclk);
>         }
>
>         pr_info("console: %s\n", opts);
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 8f775e3a08fdfb..afe45a2379866a 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h

The part of the patch below is outdated - SPCR v4 is supported already.

Please rebase on the current mainline kernel source.

> @@ -92,10 +92,10 @@ struct acpi_table_slit {
>  /***********************************************************************=
********
>   *
>   * SPCR - Serial Port Console Redirection table
> - *        Version 2
> + *        Version 3
>   *
>   * Conforms to "Serial Port Console Redirection Table",
> - * Version 1.03, August 10, 2015
> + * Version 1.08, October 7, 2021
>   *
>   ***********************************************************************=
*******/
>
> @@ -120,7 +120,7 @@ struct acpi_table_spcr {
>         u8 pci_function;
>         u32 pci_flags;
>         u8 pci_segment;
> -       u32 reserved2;
> +       u32 uartclk;
>  };
>
>  /* Masks for pci_flags field above */
> --
> 2.46.0.662.g92d0881bb0-goog
>

