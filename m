Return-Path: <linux-acpi+bounces-13224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAAA99920
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C9461278
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A880269806;
	Wed, 23 Apr 2025 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFIS7+7v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0725139566;
	Wed, 23 Apr 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438659; cv=none; b=DSisdWlDxxWBUFN7qFbqgb+V34RMPG9yV2drxZ2a7/9J2xHvZBnj6gCqOS+/hWlxViA4rmj4Po4+NpFn9idGbC16iYsK+anZ0sgQSB9Gg0OrD9e6Vpbxvu8D6tb3ec83oymxwuqXX81E0mUtJZJIWoUpjAfLteFI0WqyGNwlQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438659; c=relaxed/simple;
	bh=cxaMvVcBVtdfwqKCy8tAu7BZLGaLreXc/92Wi3OWRRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxHnCUTUM1EW+c7kWVJVI9DNub4Kj/nTDijtgWCYd7/VG9ZXmsVdONpRs0FESO+iSPLe9d6HRHbDBZAhlPW/1gQLTf2i57Ru4XB0wM7XeLiY/Bk3zT2ro683SDAf+0JFEG7gH9TFdTFs4zvuZSfcv20Z6EFbMI8bKhtWtfozGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFIS7+7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C0C4CEEC;
	Wed, 23 Apr 2025 20:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745438658;
	bh=cxaMvVcBVtdfwqKCy8tAu7BZLGaLreXc/92Wi3OWRRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QFIS7+7vOH3mbByJthVS5BZpFzinoka2fvXZ7pReRxqDjEFvnruht/1pgcQtrj4NL
	 wUAC4kiXVPAwiDSuhxUjFsBKFGPa3YDb2cJ8AFSGYdb2POvVcY6rslkUSYzGJhIIfb
	 /SzT8Ga4winbAy6Q+XRK0yRw1iK1f3OXcVCyygrZ9KJB/KTEM2OeGpr4nTA8fDNxJr
	 k3S8r7ELcpWP9HUuXetm/XFS0U9cyr9UQ+8Fd2d9bpCOrla/lGqviFe6gIcXXfVSOe
	 OeSqw94ylOqgR0YIsH6LjAer6E0kBh3ZE+W80E2Un8uRxgwxohSl6loATz43ojoXPl
	 GO3rFI+HCnxjQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2504fa876so46830fac.0;
        Wed, 23 Apr 2025 13:04:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsIGG2Y58HojE90CfQlOvghnSIjN+J/gb4iS41obdqa6bbuwRdajY2vzoKxImPVmfLL0r98JJ5knpfL1kA16Yz@vger.kernel.org, AJvYcCWvWC6rQc6LmZrdfA+DbSVrME0XVmLvttKmCqQL4EKaZNPuxeycI6sMm8+NUv3G+x6t0haiM0E1RI1y@vger.kernel.org, AJvYcCXDrfSLZQyhwGO+Sp7N/G6746uOKtwXpUNEq+nfZqkV2E54QUhoFZrp+OKGKN0aJooLhevo7gdWgyccAscn@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnyV2YCGxWeh/wni2Pbw/lJC8hDjGBCFwgre13w8P6naVnmRM
	X2sLHiXbYse+aZK0WTO/sfZsD65CkW0wwAf9C33n2q14CIE4AOYo9HdknMPhvDpf3c90qSRTata
	NIXi5j7kn2UctVR734Al7wV1MGTk=
X-Google-Smtp-Source: AGHT+IGNdK95WXoJNH2YFoPShvcuAWCN+P/w+m/y1K2Oby12AFZZkHdCKndMaq8lzZJIhc5cb8euX9kuVjrYL073DuA=
X-Received: by 2002:a05:6870:9127:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2d96e19b0camr50460fac.5.1745438657751; Wed, 23 Apr 2025
 13:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415232028.work.843-kees@kernel.org>
In-Reply-To: <20250415232028.work.843-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 22:04:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9xA0rj3QFD6jv+vabRtgFqa2nza_RFjq=c5=ds9yCNg@mail.gmail.com>
X-Gm-Features: ATxdqUHRYTqya0acLc4Hb2cQFkwS76MbdgHgn_ewJ3DBhKc43JCe7GYCZZj2Vbg
Message-ID: <CAJZ5v0j9xA0rj3QFD6jv+vabRtgFqa2nza_RFjq=c5=ds9yCNg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: Add __nonstring annotations for
 unterminated strings
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 1:20=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the 4-byte
> ACPI identifier arrays with __nonstring (and the new __nonstring_array)
> to correctly identify the char arrays as "not C strings" and thereby
> eliminate the many warnings like this:
>
> In file included from include/acpi/actbl.h:371,
>                  from include/acpi/acpi.h:26,
>                  from include/linux/acpi.h:26,
>                  from drivers/acpi/tables.c:19:
> include/acpi/actbl1.h:30:33: warning: initializer-string for array of 'ch=
ar' truncates NUL terminator but destination lacks 'nonstring' attribute (5=
 chars into 4 available) [-Wunterminated-string-initialization]
>    30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Tabl=
e */
>       |                                 ^~~~~~
> drivers/acpi/tables.c:400:9: note: in expansion of macro 'ACPI_SIG_BERT'
>   400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECD=
T,
>       |         ^~~~~~~~~~~~~
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> ---
>  drivers/acpi/tables.c | 2 +-
>  include/acpi/actbl.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2295abbecd14..0a9ade7117bd 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 =
length)
>  }
>
>  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst =3D {
> +static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __in=
itconst =3D {
>         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
>         ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
>         ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..2fc89704be17 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -66,7 +66,7 @@
>   ***********************************************************************=
*******/
>
>  struct acpi_table_header {
> -       char signature[ACPI_NAMESEG_SIZE];      /* ASCII table signature =
*/
> +       char signature[ACPI_NAMESEG_SIZE] __nonstring;  /* ASCII table si=
gnature */
>         u32 length;             /* Length of table in bytes, including th=
is header */
>         u8 revision;            /* ACPI Specification minor version numbe=
r */
>         u8 checksum;            /* To make sum of entire table =3D=3D 0 *=
/
> --

Applied as 6.16 material.

I've rebased it on top of

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9d7a0577c9db35c4cc52db90bc415ea248446472

so basically the hunk in actbl.h is gone.  Please see

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dbleeding-edge&id=3D18eb45b67544b995a8a6f48a72b816fd75776f52

Thanks!

