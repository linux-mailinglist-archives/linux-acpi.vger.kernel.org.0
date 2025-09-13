Return-Path: <linux-acpi+bounces-16839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D012B55E8F
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951521C27A59
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE332E266E;
	Sat, 13 Sep 2025 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3KoHn/r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED727874A
	for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757741075; cv=none; b=U3IyRg5QieUb6B5GZzk0nFvgjFZOgLjoaEvlu+ADMSDbiNqBX3eaXdKw4+T4zXwrZM1FCEaPxOVoI3IuQ4b1I7oNebyfMgJBAPMxWyLeBGiK1UUsQcGmNw4KpESp1u+3wp4h/a062cbYrJR5teIfI+LAKTg0ElLkVpD110zLQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757741075; c=relaxed/simple;
	bh=ndtaFZkPNDUgMTuk/DI+nRVkfYYyHV/1NbW/hy/UTiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6OfHGVeDJdyGqNKlAkKwFWydcNF1bb5TYvCP+McML7fbAYj0+JMH91HXGDDdvKy+YDFoaaIZqk0l+QvRs0A767+eNWJA+Wbv8YMDrupvR04Sd4IV9sWwpxVpx9XpH/z9u4puk+GjuH9CHI51W//y1aCIUNCLZJT2SDK8W43pOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3KoHn/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7EFC4CEEB
	for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 05:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757741074;
	bh=ndtaFZkPNDUgMTuk/DI+nRVkfYYyHV/1NbW/hy/UTiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3KoHn/rdLOt+mwg8ydl/A0WLdKYmDgNZMpnI4hNMDc+UFSPaBnKljSvTIaLAoBFp
	 Gg3KVWV17pnz92Q7VaHsNozXE9n+M0NA056WEUVKx2UtWFfVY6DgTZqElCMJOEpFOM
	 aZchZls4kgvdorKioIbpC+0CoWWA4CI4YU9GRTurOCcMqkJl0ZulkilArUmnC6Kfnn
	 sDMdilCWPgdgOd02n4Yi2pu6jHtwieHSVCY/f85+6neXlbqzbA01mjjvb9ObXiWOqi
	 G5COk8OFx8gwKtv/PvwOohPmhRCaY9oWPLSIS+89L3xbxGXawgwUdKQ9i3oljyOTtx
	 YTP6/39cXIWMA==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e76766a172so1130656f8f.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 22:24:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJesCTxzfMNOZ5RGNYn3e2kYMByWknjMdtesc/G7Bka73UCo1FGjGMKIggnsnlhvZCsnOgqSG2JNA0@vger.kernel.org
X-Gm-Message-State: AOJu0YztdWsvoeLMGMQlYoTaqBZfwYfBBrMLocizmtn/XjryYE3zmQnw
	xFTv9gdCioJnsJJeHWA128WG2+LGp/qnXhDHU++XYZKsARGyYDZhPUBxEI5QIeJrWvkG4/vSWEv
	fKOHiz+3VZ/zPuzuVFfSoA4G4S2A5b68=
X-Google-Smtp-Source: AGHT+IGYTlvCo1WvcEHh91h2ZDsn0VW1EcDF9c5qsObu2X+gkm2UWwxkRXm7fnuygodN0nywuj843j1eBkLjOQTn8hY=
X-Received: by 2002:a5d:4d81:0:b0:3e7:bbaf:6a07 with SMTP id
 ffacd0b85a97d-3e7bbbeb55cmr2183699f8f.6.1757741073221; Fri, 12 Sep 2025
 22:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122514.2303-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250912122514.2303-1-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 13 Sep 2025 13:24:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTn6PhqjOPAxVfSy_8avb1_7BAeqOsFxPnvmZ3KF8sqog@mail.gmail.com>
X-Gm-Features: AS18NWDOH5r854UR2hS_3wx8Jmy2rJ-1fVmoABF8wvrbI9Y09wJRDu310WBBPi8
Message-ID: <CAJF2gTTn6PhqjOPAxVfSy_8avb1_7BAeqOsFxPnvmZ3KF8sqog@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: SPCR: Support Precise Baud Rate filed
To: cp0613@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, jeeheng.sia@starfivetech.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:25=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> The Microsoft Serial Port Console Redirection (SPCR) specification
> revision 1.09 comprises additional field: Precise Baud Rate [1].
>
> It is used to describe non-traditional baud rates (such as those
> used by high-speed UARTs).
>
> It contains a specific non-zero baud rate which overrides the value
> of the Configured Baud Rate field. If this field is zero or not
The spec states that it would "override" the baud rate. That means it
should happen behind the table->baud_rate or firmware still needs to
give out a legal Configured Baud Rate for precise_baudrate.

Then, we move these:
+       if (table->precise_baudrate)
+               baud_rate =3D table->precise_baudrate;
behind the "switch (table->baud_rate) {}".

Right?

> present, Configured Baud Rate is used.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table # 1
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/acpi/spcr.c | 54 ++++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2..a97b02ee5538 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -146,29 +146,37 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
ol enable_console)
>                 goto done;
>         }
>
> -       switch (table->baud_rate) {
> -       case 0:
> -               /*
> -                * SPCR 1.04 defines 0 as a preconfigured state of UART.
> -                * Assume firmware or bootloader configures console corre=
ctly.
> -                */
> -               baud_rate =3D 0;
> -               break;
> -       case 3:
> -               baud_rate =3D 9600;
> -               break;
> -       case 4:
> -               baud_rate =3D 19200;
> -               break;
> -       case 6:
> -               baud_rate =3D 57600;
> -               break;
> -       case 7:
> -               baud_rate =3D 115200;
> -               break;
> -       default:
> -               err =3D -ENOENT;
> -               goto done;
> +       /*
> +        * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
> +        * non-zero baud rate which overrides the value of the Configured
> +        * Baud Rate field. If this field is zero or not present, Configu=
red
> +        * Baud Rate is used.
> +        */
> +       if (table->precise_baudrate)
> +               baud_rate =3D table->precise_baudrate;
> +       else switch (table->baud_rate) {
> +               case 0:
> +                       /*
> +                        * SPCR 1.04 defines 0 as a preconfigured state o=
f UART.
> +                        * Assume firmware or bootloader configures conso=
le correctly.
> +                        */
> +                       baud_rate =3D 0;
> +                       break;
> +               case 3:
> +                       baud_rate =3D 9600;
> +                       break;
> +               case 4:
> +                       baud_rate =3D 19200;
> +                       break;
> +               case 6:
> +                       baud_rate =3D 57600;
> +                       break;
> +               case 7:
> +                       baud_rate =3D 115200;
> +                       break;
> +               default:
> +                       err =3D -ENOENT;
> +                       goto done;
>         }
>
>         /*
> --
> 2.49.0
>


--=20
Best Regards
 Guo Ren

