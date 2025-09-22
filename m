Return-Path: <linux-acpi+bounces-17206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F0B92691
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1E03B4B5C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77AB313E3B;
	Mon, 22 Sep 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbr5NpMh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A88313E0D
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561940; cv=none; b=EKWlS1A1z4hS/pRba/jtmrkVdMBLRhqKncZObc7m2KSTJ/q0E4sCbUmtXbytYSjHKCxqmwKbKV4i/u/xkNWrSxftcP/3np/V7eDMhj7pWHef/DHLdv+lH39RkgbF7NrxLO65TmLQDV+k6Y8FOn7A0dMmMwdZz2+21NboPX0uwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561940; c=relaxed/simple;
	bh=9UTJYhngwTX4OcNuNjPaeMmaGryOpl+uEyIlezKAg+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB+EAf2EJzVGcdX5PNxbjWbm/lfwcqHUNbCd8509yvWjwYf0TSJtsuPuD/0zsIWmhSgt5ZQTWAmBPeGs/5/Vp7Az5sU85UABiyMGxFkEE4j5DtGlz+2kFqFrwhAswlD0yUdQ2RzmERsfx6q8vFEkbjiE2pQm0MVpUWYIE1YmMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbr5NpMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274AC4CEF0
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561940;
	bh=9UTJYhngwTX4OcNuNjPaeMmaGryOpl+uEyIlezKAg+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xbr5NpMh/Mwu7bcW4s72QRbgAUaHyrOdYIPDYCyKQDCZqR7/A2qIC5jbdzfLwgZJ1
	 OAVop5BfnbDIDK3uetvtJE2scWe/YBDDt08JXSA8qfhpzBs4Z58qVNVQXCwJHBlynJ
	 yCyusPsP2mKEglriRKnnz0E8DQIZh3kM92J/7mQnKAaCzXOFqQCOzzGj/BOuQATIYH
	 8DYNqnwWtPVBbZjMALPbTPFY93gRR4/DudgUI2zi26pUs8Xydveo4Dn1z5KNADAPCk
	 7VOK5oJ5sn50s6BBACCz1qSolJz1TsRp3ECh3MUJ2WTAm11UUSs+zfWDoBDRDwN6yS
	 c46RgzgUNLwcQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-786e9b51248so356470a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:25:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUc66zw/XEiDd6T1wZfDuSJuMNuUbTJYwbtM3Qi1HD/VFWHvwVYkK5yt2/59yv0hhFIqo2IG3/cINe@vger.kernel.org
X-Gm-Message-State: AOJu0YxQRugMfO7EErcvltnbZe63uEUDHAZTzRubYlmR1mB5OeQKdRU9
	l3m6pEw0oOYj+p/eIZ2E9HmuW4+5nIsJ2J0gSPB3RDaTx/jSa5Y8rwyeJECnWhW2w4AMTc+2/jL
	pXEE8l2/2fnMUxZ9f987A5tN/iDo1m4o=
X-Google-Smtp-Source: AGHT+IGevYc0Cjky5Fo70RXjuSv4ZxzjBma/yLe/MuVyw/IyNPLXKEdEEkMVmIcV+GoSg2VFRVyl7D9VdPXgn0KjBOc=
X-Received: by 2002:a05:6808:2189:b0:43b:252e:f7aa with SMTP id
 5614622812f47-43d6c1d5116mr6519936b6e.21.1758561939579; Mon, 22 Sep 2025
 10:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915172119.5303-1-a.jahangirzad@gmail.com>
In-Reply-To: <20250915172119.5303-1-a.jahangirzad@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:25:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsG=s37mSkcxbTqhmE_i-6skHPn+OpmCUhmJf27V+yzA@mail.gmail.com>
X-Gm-Features: AS18NWA_flde3oqxc9oluH3gWfzXRVKRBOgC-j2GEqQCuSEekHCTMfBM5SSkKjI
Message-ID: <CAJZ5v0hsG=s37mSkcxbTqhmE_i-6skHPn+OpmCUhmJf27V+yzA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: debug: fix signedness issues in read/write helpers
To: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:21=E2=80=AFPM Amir Mohammad Jahangirzad
<a.jahangirzad@gmail.com> wrote:
>
> In the ACPI debugger interface the helper functions for read and write
> operations use an `int` type for the length parameter. When a large

There's no need to escape data types in patch changelog and generally
please use double quotes for escaping.

> `size_t count` is passed from the file operations, this cast to `int`
> results in truncation and a negative value due to signed integer
> representation.
>
> Logically, this negative number value propagates to the `min` calculation=
,
> where it's selected over the positive buffer space value, leading to an
> unexpected behavior. Subsequently, when this negative value is used in
> `copy_to_user` or `copy_from_user`, it is interpreted as a large positive

Function names need not be escaped too, but please add () at the end
of each function name.

> value due to the unsigned nature of the size parameter in these functions
> causing the copy operations to attempt handling sizes far beyond the
> intended buffer limits.
>
> This patch addresses the issue by:

Please change the phrase above to "Address the issue by:"

> - Changing the length parameters in `acpi_aml_read_user` and
>   `acpi_aml_write_user` from `int` to `size_t`, aligning with the expecte=
d
>   unsigned size semantics.
> - Updating return types and local variables in acpi_aml_read() and
>   acpi_aml_write() to 'ssize_t' for consistency with kernel file operatio=
n
>   conventions.
> - Using 'size_t' for the 'n' variable to ensure calculations remain
>   unsigned.
> - Adding explicit casts to 'size_t' for circ_count_to_end() and
>   circ_space_to_end() to align types in the min() macro.

min_t() can be used instead.

>
> Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
> ---
>  drivers/acpi/acpi_dbg.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index d50261d05f3a1..72878840b4b75 100644
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
> +       n =3D min(len, (size_t)circ_count_to_end(crc));

Use min_t() here.

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
> +       n =3D min(len, (size_t)circ_space_to_end(crc));

And here.

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

