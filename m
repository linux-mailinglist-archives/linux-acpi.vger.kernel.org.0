Return-Path: <linux-acpi+bounces-11153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276DA34881
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A9A18879AE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071A6F073;
	Thu, 13 Feb 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQRuXCVk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733626B087;
	Thu, 13 Feb 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461629; cv=none; b=aDftfEpbRX5xvV6gT6IZFUlpoHM5sg9AUFHDVWpA6MYYioRY1tSytd+IPs1XPeQmxzeVoULkrKYA+tpc/x2B7P0hFwaENEGRJd555+pwVCIlMlEUVulnsAz2S9sBYoJ1P1AXtLQXMuZWiSTTdRek38/4Smp2q2DJif6rZottZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461629; c=relaxed/simple;
	bh=E1GUjYdJqoBRJw9tQ+cO3lASHQVBixZzsUVVWG/US9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dpq7mKp6sBksUNIzOxPT5llIyH2Xh6C7M1SDOXCFDGbFvsJetEpbfQOD33NJ2YuUcxMEc75UflR1sE+jY/sd4e+GuF73vgGugGhtO5k/kU9rL8GifTsJ0yIQ4Q0qJcf2bXj0OvOBh8InQvLF802txodUVyxnEqBTW3g1TDs26cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQRuXCVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B11C4CEE7;
	Thu, 13 Feb 2025 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739461629;
	bh=E1GUjYdJqoBRJw9tQ+cO3lASHQVBixZzsUVVWG/US9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQRuXCVkRSWCBtQvf8cddg/93v7kQ+kuCtzjriKQugqc/0tlw0wQ+lIuQ+ZNvuUui
	 p989xGxi/7Y76OximxiGTexZmIoEu0Qqh0mV1GJrL7YebEkeKO+ONuJC4BLSzj3zEt
	 k7FQlW+OmTWLVP38lXqSwNRvy05DPdkEWCawW0RzmokqoJAzBa8qcKBHiBdS1hE7Yz
	 j2NU9vHZr5dTlHD8NfJbR5hV+HdZYWNbYQboBTxSMDv8cU4979M+RoP5MzPeHCs1hf
	 nFoem2hcaQUbq9+wKv/G1MrPqT5/cgzZBWODqdaqF62d9Cy7/GHRbrgqmJEQh5MJsB
	 e37j2V26OErgw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1049438e87.1;
        Thu, 13 Feb 2025 07:47:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCIJYYBa2uFuAZieZXncUfLyjT1IxROfSOzMkH9uyxErgboq9peoxk4c5RLda81dpfExd97VIxNJpvH8Fo@vger.kernel.org, AJvYcCXbbBbEFKyktRqPVDEBMQRcBL7NIN1L0RiIqJTBgLuHAl6VaQ+uOsUdU0ONawe3tdLKK86EnmWXIT+z@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3XKMmPO71Y1/8IL6qJBFRws8Hr/3n05YSvYqHLSjR2KknT1F
	pu0+/JnNSxH5GPtX54DSfbMAMvfkaPI2yff8TU/mftd6e1EkCRAXbN1LvOzTP9Hsz7RSXSIBWbS
	lk0ZnnlWU0renUDv0Q+zguhSqgK0=
X-Google-Smtp-Source: AGHT+IGv5cDKLfiKWM0AbqmdVhU4cj+YxJl2cKveWSLPMNHSkmFWQco2+fFaxe83V+KevVsWhgrCg8aeW9stFG6GeqA=
X-Received: by 2002:a05:6512:10d2:b0:545:16ef:d5fa with SMTP id
 2adb3069b0e04-5451dfdbf37mr1109497e87.12.1739461627368; Thu, 13 Feb 2025
 07:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121214219.1455896-1-brahmajit.xyz@gmail.com>
In-Reply-To: <20250121214219.1455896-1-brahmajit.xyz@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Feb 2025 16:46:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGvgad183WbUHPGduXHEahfoWasued-LdJ+Tkhc=z-9GA@mail.gmail.com>
X-Gm-Features: AWEUYZkFY2PYa8gfx6hGCdnL0CMJypnzzWYdPRULOd_DTaJ2LhpwBLnko3b9nkQ
Message-ID: <CAMj1kXGvgad183WbUHPGduXHEahfoWasued-LdJ+Tkhc=z-9GA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 at 22:42, Brahmajit Das <brahmajit.xyz@gmail.com> wrote=
:
>
> Building with GCC 15 results in the following build error:
>
> ...
>   CC      drivers/acpi/tables.o
> In file included from ./include/acpi/actbl.h:371,
>                  from ./include/acpi/acpi.h:26,
>                  from ./include/linux/acpi.h:26,
>                  from drivers/acpi/tables.c:19:
> ./include/acpi/actbl1.h:30:33: error: initializer-string for array of =E2=
=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializati=
on]
>    30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Tabl=
e */
>       |                                 ^~~~~~
> drivers/acpi/tables.c:400:9: note: in expansion of macro =E2=80=98ACPI_SI=
G_BERT=E2=80=99
>   400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECD=
T,
>       |         ^~~~~~~~~~~~~
> ./include/acpi/actbl1.h:31:33: error: initializer-string for array of =E2=
=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializati=
on]
>    31 | #define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphics Resource=
 Table */
>       |                                 ^~~~~~
> drivers/acpi/tables.c:400:24: note: in expansion of macro =E2=80=98ACPI_S=
IG_BGRT=E2=80=99
>   400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECD=
T,
>       |                        ^~~~~~~~~~~~~
> ./include/acpi/actbl1.h:34:33: error: initializer-string for array of =E2=
=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializati=
on]
>    34 | #define ACPI_SIG_CPEP           "CPEP"  /* Corrected Platform Err=
or Polling table */
> ...
>
> This is due to GCC having enabled
> -Werror=3Dunterminated-string-initialization[0] by default. To work aroun=
d
> this build time error we're modifying the size of table_sigs from
> table_sigs[][ACPI_NAMESEG_SIZE] to table_sigs[][ACPI_NAMESEG_SIZE + 1].
> This ensures space for NUL, thus satisfying GCC.
>
> [0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-un=
terminated-string-initialization
>
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9e1b01c35070..5a6524eb79d8 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 =
length)
>  }
>
>  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst =3D {
> +static const char table_sigs[][ACPI_NAMESEG_SIZE + 1] __initconst =3D {
>         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
>         ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
>         ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,

Please add the __nonstring attribute instead.

