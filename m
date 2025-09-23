Return-Path: <linux-acpi+bounces-17231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D0B96102
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 15:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E807177F0D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669717A2FB;
	Tue, 23 Sep 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcuNj27d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEB14A0BC
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635241; cv=none; b=V4U+1DWsuXAw3bILLPWQQ45HeG0zGCT886fjs5pL1XmnwP1D1BkwcvugZohFHPqNcg0Ubia8abeaYCKrSarEfCw15LDKTtQoCI2O7FgPqgfiiTu9+Y8BS7pcaj8PhmNfAEL/XqShdLC2mvQgUbEB+++WTBxtJWc2oUDv7hVIBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635241; c=relaxed/simple;
	bh=XWo7hc3W1G/XBFjknU5aEryQawaYEkTAiJoCF9UqAUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZUk9/ThDC9UF3tdjYju9/pFDiViA9se/FoQFGE0giDHw31lJqUEysyRY5U4EZn+L6FvjBDK8Ljdbm7qnCWsZpdkJicLeoG6lT7vIHAeB24Ae13vNzkEGEiMipQ+1eIEkojlCK+2XUcRkOpLkhLE8r3c/vZQm5VaBA2S4SHVEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcuNj27d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B49C116D0
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635240;
	bh=XWo7hc3W1G/XBFjknU5aEryQawaYEkTAiJoCF9UqAUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AcuNj27djzB3Wp1xn89y5x+86TJ++ogN+svUreeS5j7aGCMc1l/c8GzEE6u5Hkblz
	 mJbH2HiTXZVVfWlxk1bClhSX/WD1oHKATmRN9bX9PEuqvaSutxZ/a+AsDB+zr6ocU1
	 p2xzFvUSq8c4Ae6YQxy3js186B4sgPZM8iHwfECf8ZFMLQrIjiPhsca31ywkLcw5E3
	 8KfnXfJw6z6gioYNDcQN0DXi2CuqwEk6ACrM8hoqeD/CJxKuU/FQXf/Jn1R0uzFpMI
	 0yLw00BfPHTIeU4gzWeabuXCmUUULahgpcX3jxuf3Xn2hMWOUuqPaSTBVrHByuZ2dL
	 kYmrK6fP9iB2g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-34e5e27734cso371671fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 06:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9d7Q/KbWSKGDPjSgrwh6UAB8lZkCfHAU/KxrWZMbRAMuSs8wqkJ7khay4bihI4mA4roVgAtCrUSQF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Bc6oAEydZ9jyDNYib//MxtYM2C5Xay4TxQ91i1YZxFgGRtuw
	dixeTcrVoNYjm0CzaRl/dWRlFReob7jl+hQxRrh0aeGc72dDVe6ng+h9+7ASvUAVJZcxZcrW8OD
	WzkHVoNJ95kg1a0mdJucZ4RiORNE7CvQ=
X-Google-Smtp-Source: AGHT+IEfJM8dwOTqmEkoNBUPaVoWBiO4yfLM60G6zYhYl0+BLYg3dTYuG5OA9+KtSRHe8t2nMfT13OAguwsu3LPjS20=
X-Received: by 2002:a05:6808:6f87:b0:43d:2e87:5489 with SMTP id
 5614622812f47-43f2d344920mr1442103b6e.13.1758635240169; Tue, 23 Sep 2025
 06:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923013113.20615-1-a.jahangirzad@gmail.com>
In-Reply-To: <20250923013113.20615-1-a.jahangirzad@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 15:47:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpa_75Lfah3X+FTso5RMRJBnW6FOv0WDMVYK-4oiB+tQ@mail.gmail.com>
X-Gm-Features: AS18NWA7GKGdmIVaTde_9n69ZqkZmcA_1XhBcW_UpZM7UATs38g793bVlVhpoZk
Message-ID: <CAJZ5v0gpa_75Lfah3X+FTso5RMRJBnW6FOv0WDMVYK-4oiB+tQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: debug: fix signedness issues in read/write helpers
To: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:31=E2=80=AFAM Amir Mohammad Jahangirzad
<a.jahangirzad@gmail.com> wrote:
>
> In the ACPI debugger interface, the helper functions for read and write
> operations use an "int" type for the length parameter. When a large
> "size_t count" is passed from the file operations, this cast to "int"
> results in truncation and a negative value due to signed integer
> representation.
>
> Logically, this negative number propagates to the min() calculation,
> where it is selected over the positive buffer space value, leading to
> unexpected behavior. Subsequently, when this negative value is used in
> copy_to_user() or copy_from_user(), it is interpreted as a large positive
> value due to the unsigned nature of the size parameter in these functions=
,
> causing the copy operations to attempt handling sizes far beyond the
> intended buffer limits.
>
> Address the issue by:
> - Changing the length parameters in acpi_aml_read_user() and
>   acpi_aml_write_user() from "int" to "size_t", aligning with the
>   expected unsigned size semantics.
> - Updating return types and local variables in acpi_aml_read() and
>   acpi_aml_write() to "ssize_t" for consistency with kernel file
>   operation conventions.
> - Using "size_t" for the "n" variable to ensure calculations remain
>   unsigned.
> - Using min_t() for circ_count_to_end() and circ_space_to_end() to
>   ensure type-safe comparisons and prevent integer overflow.
>
> Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
> ---
>  drivers/acpi/acpi_dbg.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index d50261d05f3a1..0ec12007fad31 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -569,11 +569,11 @@ static int acpi_aml_release(struct inode *inode, st=
ruct file *file)
>         return 0;
>  }
>
> -static int acpi_aml_read_user(char __user *buf, int len)
> +static ssize_t acpi_aml_read_user(char __user *buf, size_t len)
>  {
> -       int ret;
> +       ssize_t ret;
>         struct circ_buf *crc =3D &acpi_aml_io.out_crc;
> -       int n;
> +       size_t n;
>         char *p;
>
>         ret =3D acpi_aml_lock_read(crc, ACPI_AML_OUT_USER);
> @@ -582,7 +582,7 @@ static int acpi_aml_read_user(char __user *buf, int l=
en)
>         /* sync head before removing logs */
>         smp_rmb();
>         p =3D &crc->buf[crc->tail];
> -       n =3D min(len, circ_count_to_end(crc));
> +       n =3D min_t(size_t, len, circ_count_to_end(crc));
>         if (copy_to_user(buf, p, n)) {
>                 ret =3D -EFAULT;
>                 goto out;
> @@ -599,8 +599,8 @@ static int acpi_aml_read_user(char __user *buf, int l=
en)
>  static ssize_t acpi_aml_read(struct file *file, char __user *buf,
>                              size_t count, loff_t *ppos)
>  {
> -       int ret =3D 0;
> -       int size =3D 0;
> +       ssize_t ret =3D 0;
> +       ssize_t size =3D 0;
>
>         if (!count)
>                 return 0;
> @@ -639,11 +639,11 @@ static ssize_t acpi_aml_read(struct file *file, cha=
r __user *buf,
>         return size > 0 ? size : ret;
>  }
>
> -static int acpi_aml_write_user(const char __user *buf, int len)
> +static ssize_t acpi_aml_write_user(const char __user *buf, size_t len)
>  {
> -       int ret;
> +       ssize_t ret;
>         struct circ_buf *crc =3D &acpi_aml_io.in_crc;
> -       int n;
> +       size_t n;
>         char *p;
>
>         ret =3D acpi_aml_lock_write(crc, ACPI_AML_IN_USER);
> @@ -652,7 +652,7 @@ static int acpi_aml_write_user(const char __user *buf=
, int len)
>         /* sync tail before inserting cmds */
>         smp_mb();
>         p =3D &crc->buf[crc->head];
> -       n =3D min(len, circ_space_to_end(crc));
> +       n =3D min_t(size_t, len, circ_space_to_end(crc));
>         if (copy_from_user(p, buf, n)) {
>                 ret =3D -EFAULT;
>                 goto out;
> @@ -663,14 +663,14 @@ static int acpi_aml_write_user(const char __user *b=
uf, int len)
>         ret =3D n;
>  out:
>         acpi_aml_unlock_fifo(ACPI_AML_IN_USER, ret >=3D 0);
> -       return n;
> +       return ret;
>  }
>
>  static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
>                               size_t count, loff_t *ppos)
>  {
> -       int ret =3D 0;
> -       int size =3D 0;
> +       ssize_t ret =3D 0;
> +       ssize_t size =3D 0;
>
>         if (!count)
>                 return 0;
> --

Applied with a few minor tweaks as 6.18 material, thanks!

