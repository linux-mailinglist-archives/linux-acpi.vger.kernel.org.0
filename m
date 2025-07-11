Return-Path: <linux-acpi+bounces-15099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32148B01772
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C11C20ACE
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488527A134;
	Fri, 11 Jul 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBeqeZPu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A5279DC4;
	Fri, 11 Jul 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225439; cv=none; b=PHz/gxi3dmTd/nz2rBO+3+SrcKMaRVNHUA6IUCCUPpExNxl2uylQLzOAqX4lxtauTqFjpy93/2c2eS52SjCNsANVMfeEhfjwkiBrgiYxu4I1+d9U2EjTDOQA70PR9Xl99CahPcGAZId6gw4R0KXU3gVnbtJT6jGnKFCfYU6fW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225439; c=relaxed/simple;
	bh=qas8Ip1ScJCoaTrX3R4wMho9GVn9YvhmfmZhGegY6y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXi0+t0ptEtvOMiKBfjuI7UIN0LgHl8/EfPQJHuKtIpGrMNUnY92KgnpA/2tHzWBSK8/8SuV20So72F15sAY6G2F9B38hQexevUZZzGsa17eTxLmkU2QmRMwZj6D/bk3L8kR8EyxJCOWTtkuar0DfwmBRWyOF4G8MsU+PSIOkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBeqeZPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260B9C4CEF7;
	Fri, 11 Jul 2025 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752225439;
	bh=qas8Ip1ScJCoaTrX3R4wMho9GVn9YvhmfmZhGegY6y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RBeqeZPubBEdYJaX01TuP9sfqskbf+24alKEgQHHlfwzpXDPYH13GdNG/9daVpzut
	 6Z5c2CA24FoSfG5QtMzrmInM/3UgQHltjIQofwKJLoL0WhpwCkeR8CJnZO1yyYQws5
	 +oJl7GQh3HUHoSQ0zJGWT7w4WOrermHqrI5Zr5G2f27mMA+ppzoa+3wWk5/YDeghHn
	 dINzVt9dPXfhnk6xLqzpogDAo0Bw64EWPP5eEYvhpR5m3xGXi6pMb0gfQAC283rrSE
	 E5/Zhd3bEpqqHJcYqP/9Th4FxvHVM5NYK6dQChViW32ROjpNY1WZH7d0da/oz60kJn
	 I6MFV0pLFJdLQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61208b86da2so545397eaf.2;
        Fri, 11 Jul 2025 02:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaE3szyoHeclGyJ2Rc+etOYTa3LbrJhhdmyESQES+cWSANefbteqJZfTZOfeDh94f3CMYsStl0WhdUwqs=@vger.kernel.org, AJvYcCX6Ntb+wyEPwbYLKongjCGMje6z1xLtUQAEqi/MD1883NxEwK1NUN22h682r1yRHp+WykOUKoB2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5U/r8ItiVCLiefdyvRZ56vNy62hfc9GF6Yi/60g3bF61FVvWB
	xrnxaktX+iN3OZwyQ6CGGbrvmqVKOeJwpjLH2nB68ukDNHO/EgTMEo/4zh4SIWYpjxRoZlBA6wS
	50B0gqdVGRY5OPrtIHIFVihtc2a16Nws=
X-Google-Smtp-Source: AGHT+IG6Qc9Tz0KlmO4rhSB8sfe+y9NNQJCUb5S/z18RnmWf3Q0RSYE1jwDtNZ5pI/UhwhySpomDx6CThnX6pLkfGbk=
X-Received: by 2002:a05:6820:310b:b0:613:87ee:10e with SMTP id
 006d021491bc7-613e5fa3322mr1415729eaf.5.1752225438314; Fri, 11 Jul 2025
 02:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710170225.961303-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250710170225.961303-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 11:17:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0inCyNEJW-B0zppJv74t07paX3aG-OX=x20sqY3A3A26A@mail.gmail.com>
X-Gm-Features: Ac12FXxJy6F_7MoFjlhCsfzlsxOZ-2x76mgQjKJRIw6ts1IJAgYTKbEvzipZaEM
Message-ID: <CAJZ5v0inCyNEJW-B0zppJv74t07paX3aG-OX=x20sqY3A3A26A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: ACPI: Fix parent device references
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Yevhen Kondrashyn <e.kondrashyn@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The _CRS resources in many cases want to have ResourceSource field
> to be a type of ACPI String. This means that to compile properly
> we need to enclosure the name path into double quotes. This will
> in practice defer the interpretation to a run-time stage, However,
> this may be interpreted differently on different OSes and ACPI
> interpreter implementations. In particular ACPICA might not correctly
> recognize the leading '^' (caret) character and will not resolve
> the relative name path properly. On top of that, this piece may be
> used in SSDTs which are loaded after the DSDT and on itself may also
> not resolve relative name paths outside of their own scopes.
> With this all said, fix documentation to use fully-qualified name
> paths always to avoid any misinterpretations, which is proven to
> work.
>
> Fixes: 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
> Reported-by: Yevhen Kondrashyn <e.kondrashyn@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Rafael, I prefer, if no objections, to push this as v6.16-rc6 material si=
nce
> the reported issue was detected on old (v5.10.y) and still LTS kernel. Wo=
uld be
> nice for people to not trap to it in older kernels.
>
>  Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentat=
ion/firmware-guide/acpi/i2c-muxes.rst
> index 3a8997ccd7c4..f366539acd79 100644
> --- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
> +++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
> @@ -14,7 +14,7 @@ Consider this topology::
>      |      |   | 0x70 |--CH01--> i2c client B (0x50)
>      +------+   +------+
>
> -which corresponds to the following ASL::
> +which corresponds to the following ASL (in the scope of \_SB)::
>
>      Device (SMB1)
>      {
> @@ -24,7 +24,7 @@ which corresponds to the following ASL::
>              Name (_HID, ...)
>              Name (_CRS, ResourceTemplate () {
>                  I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> -                            AddressingMode7Bit, "^SMB1", 0x00,
> +                            AddressingMode7Bit, "\\_SB.SMB1", 0x00,
>                              ResourceConsumer,,)
>              }
>
> @@ -37,7 +37,7 @@ which corresponds to the following ASL::
>                      Name (_HID, ...)
>                      Name (_CRS, ResourceTemplate () {
>                          I2cSerialBus (0x50, ControllerInitiated, I2C_SPE=
ED,
> -                                    AddressingMode7Bit, "^CH00", 0x00,
> +                                    AddressingMode7Bit, "\\_SB.SMB1.CH00=
", 0x00,
>                                      ResourceConsumer,,)
>                      }
>                  }
> @@ -52,7 +52,7 @@ which corresponds to the following ASL::
>                      Name (_HID, ...)
>                      Name (_CRS, ResourceTemplate () {
>                          I2cSerialBus (0x50, ControllerInitiated, I2C_SPE=
ED,
> -                                    AddressingMode7Bit, "^CH01", 0x00,
> +                                    AddressingMode7Bit, "\\_SB.SMB1.CH01=
", 0x00,
>                                      ResourceConsumer,,)
>                      }
>                  }
> --

Applied as 6.17 material, thanks!

