Return-Path: <linux-acpi+bounces-12553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6717A7652D
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902D1169F22
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01471E25F9;
	Mon, 31 Mar 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIv1oXhp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775273FFD;
	Mon, 31 Mar 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421808; cv=none; b=XqSJYNN8IkzYOgY5Rd7Mp+krjXgLbguEhlrgGQad4E55NbA3e1oKW+EbhjwOHnBo4To3OLyVVw42kWRjc2OvrZq0IMziNK02vYUAUTRy1wXtCG4Eu7AOUwbtJKal6Wgjzd4d4IM/dWtsWtbmm87Da1o9LSZQZk0INumCAtXmhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421808; c=relaxed/simple;
	bh=MYEy3KUt4Vziuf3JPdcDXA+dmtuT4BAZ42zdVk0TC14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/gwcur3ewuB8W/avkVKo7heo9SaQWVAtmHVlLTTvKwnC9X4wm19TWEEHJmp8uZS4EjCWP8DEOn4lsnk+reOODjj2S4PX68c5zeoQ2my1NT4/Dj1P12Kyca7ap0upWVbQbSOnTTRmgTkQlAvKrVyjaS2raq+Asmt3TeMiFkGadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIv1oXhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB235C4CEE3;
	Mon, 31 Mar 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743421806;
	bh=MYEy3KUt4Vziuf3JPdcDXA+dmtuT4BAZ42zdVk0TC14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIv1oXhpvZPPeMxx1R1IeY1UAUPFP1ksGYI8b0mXkOCBRaefEFq9mYIbkEtwxLjpt
	 kzWcQ3CgI8V9qFWbWVaqgXawe7YNn3jirf2OuHFY+3TkNIFVL2StoXfcsmFTCJv/Xn
	 8cyGIK1Jcnp8JAQEFg8VHTVsGhYYvucgEYR08ljSWmrYJRk5t76KKklxQdKjbqjn1c
	 nPHdLSz/zmn1UPwS7DVnYU8XtTboaCBNbG4+vHFPUgB3ZrdFpVHtb5EWKEDlftwW6O
	 gfSwlejDBacF8HKsphvoHEEg3TzHdmJllUiWDfStS7DCKIuikFdHjd5bSScoFy8S3W
	 YzA2E/pN75Lbg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso2682936fac.0;
        Mon, 31 Mar 2025 04:50:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvf9/ixt/t0gdkJY+12G9zUts2MantV9DDFEGrFUqsnk5iTrRSlFjHfOFpUY0mmlTDv9Y/YZf7ixB2@vger.kernel.org, AJvYcCXJVwMMgX7mYxX6YaXtPQaFS1OVk5wUylI4DNdQTxbGFGlEkDUgg3xJjfudc5nREJO0zPJMxy4H5ssVNuF8@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtAxUFjO+DUXnX3RDiHU243gXbOyrTftEe//VTg58oyRYKj9T
	350mmQUZvmDck/np+rKDOhojorTY+hqijs4RCT+hGBWGRDBmIlPld8D59knBjK3ar2oMeXTl33x
	lwnpwaDS+KTcLt5m+pWJii5//5J4=
X-Google-Smtp-Source: AGHT+IGAS5yDWFEFJD3s+MA6DWL9PmQhkyiwCFUbwNJ1LDK8hbKi0POX4g+kLtMf+P6LdYYnbqoxQmFDip0J8SyPyPk=
X-Received: by 2002:a05:6870:330a:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2cbcf7e09acmr5225647fac.36.1743421805209; Mon, 31 Mar 2025
 04:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743313252.git.x0rw3ll@gmail.com> <a9bd2a1b490b4305c18f8473aab21c97e8902fb8.1743313252.git.x0rw3ll@gmail.com>
In-Reply-To: <a9bd2a1b490b4305c18f8473aab21c97e8902fb8.1743313252.git.x0rw3ll@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 13:49:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUO-7t4F09TjpX_Ea-U8i61N=9DWwB3urJ6KQGzFX_-g@mail.gmail.com>
X-Gm-Features: AQ5f1JpRv_w6bLxRrGY0x0g8SVq3IMWuvsT4Jt1SrCNg-I2JCv7dvVmBcx274Ns
Message-ID: <CAJZ5v0jUO-7t4F09TjpX_Ea-U8i61N=9DWwB3urJ6KQGzFX_-g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] ACPI: mark ACPI_COPY_NAMESEG destinations with
 __nonstring attribute
To: Ahmed Salem <x0rw3ll@gmail.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 7:54=E2=80=AFAM Ahmed Salem <x0rw3ll@gmail.com> wro=
te:
>
> strncpy(), which ACPI_COPY_NAMESEG currently uses, is deprecated[1].
>
> This patch is the first of two, ultimately replacing strncpy() with
> strtomem(), avoiding future compiler warnings about truncation.
>
> [1] https://github.com/KSPP/linux/issues/90
>
> Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

ACPICA material is primarily handled by the upstream ACPICA project on
GitHub, so please avoid mixing ACPICA code changes with changes to the
other code in one patch.

Also, ACPICA changes should first be submitted to upstream ACPICA, as
indicated on this list for many times, see for instance:

https://lore.kernel.org/linux-acpi/CAJZ5v0gUDxrAn4W+Rf3ifjrg8Z9ZzTTOZjPFSSN=
5488mPqzXeA@mail.gmail.com/

> ---
>  drivers/acpi/acpica/acdebug.h                            | 2 +-
>  drivers/acpi/prmt.c                                      | 2 +-
>  drivers/acpi/sysfs.c                                     | 4 ++--
>  include/acpi/actbl.h                                     | 6 +++---
>  tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
>  tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.=
h
> index 911875c5a5f1..2b56a8178f43 100644
> --- a/drivers/acpi/acpica/acdebug.h
> +++ b/drivers/acpi/acpica/acdebug.h
> @@ -37,7 +37,7 @@ struct acpi_db_argument_info {
>  struct acpi_db_execute_walk {
>         u32 count;
>         u32 max_count;
> -       char name_seg[ACPI_NAMESEG_SIZE + 1];
> +       char name_seg[ACPI_NAMESEG_SIZE + 1] __nonstring;
>  };
>
>  #define PARAM_LIST(pl)                  pl
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..ca70f01c940c 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -40,7 +40,7 @@ struct prm_buffer {
>  };
>
>  struct prm_context_buffer {
> -       char signature[ACPI_NAMESEG_SIZE];
> +       char signature[ACPI_NAMESEG_SIZE] __nonstring;
>         u16 revision;
>         u16 reserved;
>         guid_t identifier;
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a48ebbf768f9..a05d4032d4f1 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
>
>  struct acpi_table_attr {
>         struct bin_attribute attr;
> -       char name[ACPI_NAMESEG_SIZE];
> +       char name[ACPI_NAMESEG_SIZE] __nonstring;
>         int instance;
> -       char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
> +       char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] __nonstring;
>         struct list_head node;
>  };
>
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..8aa60281e7db 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -66,12 +66,12 @@
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
> -       char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
> -       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];      /* ASCII OEM tabl=
e identification */
> +       char oem_id[ACPI_OEM_ID_SIZE] __nonstring;      /* ASCII OEM iden=
tification */
> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] __nonstring;  /* ASCII =
OEM table identification */
>         u32 oem_revision;       /* OEM revision number */
>         char asl_compiler_id[ACPI_NAMESEG_SIZE];        /* ASCII ASL comp=
iler vendor ID */
>         u32 asl_compiler_revision;      /* ASL compiler version */
> diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/t=
ools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> index 9d70d8c945af..52026b9e389e 100644
> --- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> +++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> @@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
>  typedef struct osl_table_info {
>         struct osl_table_info *next;
>         u32 instance;
> -       char signature[ACPI_NAMESEG_SIZE];
> +       char signature[ACPI_NAMESEG_SIZE] __nonstring;
>
>  } osl_table_info;
>
> diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi=
/tools/acpidump/apfiles.c
> index 13817f9112c0..5a39b7d9351d 100644
> --- a/tools/power/acpi/tools/acpidump/apfiles.c
> +++ b/tools/power/acpi/tools/acpidump/apfiles.c
> @@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
>
>  int ap_write_to_binary_file(struct acpi_table_header *table, u32 instanc=
e)
>  {
> -       char filename[ACPI_NAMESEG_SIZE + 16];
> +       char filename[ACPI_NAMESEG_SIZE + 16] __nonstring;
>         char instance_str[16];
>         ACPI_FILE file;
>         acpi_size actual;
> --
> 2.47.2
>
>

