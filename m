Return-Path: <linux-acpi+bounces-13560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF83AADD72
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708689A0C74
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51981231A3B;
	Wed,  7 May 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC5YO2Zw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E221019C;
	Wed,  7 May 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617698; cv=none; b=dvoF2B3FzVAlHmIP+9bENpdV4YG1CtHs1iGUBa3krgtF+jtXclPV5iJsiJ/8pLcbm0TX5qPUlyLWwn1ZvsxVfSuNaZc/trpL1ftB4OvCpgQQe2pW7fWbZsKMcTYKfp9XWpcet712DF9ZOVhLooODB8Z3OIt5fYmg2qRgNTZp+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617698; c=relaxed/simple;
	bh=SC0HTXn/LkVgrR8Tndvl49zyehmbitAVQKEPvqIXjkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMFKtrHfrdABWlgxHrzzsaQymgG29NW5REodDWbm/1i/jeXtMwkA98T9XM6pjoQMOtawOdZe+HIqLUOA0FHmQjWaANg2AZTHYCeAloENYvGBucr79ZHKp10aO7uB26WphNJ90pDBF4HlUdBPfdY9nW4g/5W5ddyPxIRVg8ToTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC5YO2Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919A8C4CEEB;
	Wed,  7 May 2025 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617697;
	bh=SC0HTXn/LkVgrR8Tndvl49zyehmbitAVQKEPvqIXjkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DC5YO2ZwSDGb9fivcalZdqyqqNNA1m8gKt9lE4jASbZQhX+WebeCim3aE71z+U4LL
	 sCJ8Iupf3HJ6mpXNjvqOwNQYgB6esf0kJpPkXE/ud9VXpGJQfqO+OVjYcZpvExiHlS
	 5IlzpDomxriyVSZRX7S3qtY/sxY+mWVNY6zyOREknDAvDShluFrW4JQMbjM7A+unHs
	 3N16RCx5Eeb+N0X9RHd4suMFIOgSMSuW18+EyorY6ovTiTXjCxs/Z3Eag571O7eo/2
	 XBjfoFv20heuW2N9yuvD3P9vD8CSCRrVA0hLNP+MwW+wuhwHhPWXN0XYAdUzwNOSnd
	 r7MPzD9eLgxyA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-403407e998eso3363192b6e.0;
        Wed, 07 May 2025 04:34:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY4ZReXttkFAN5P73BRuAKHnhHbPtOZzh1j9k8+DzLmLgeLZxVHlLv3u449Bdrt035hMdtSNz34UWYdAWM@vger.kernel.org, AJvYcCXlP1Pk13+P5n7xVqRurl0QmmZK4GETVmPKXdOt18kRrLIfBuXjG7qj3GVtjJl8Iqt+u59oevhqFq73@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3bXXGmBMCkvoY4JRFPv01bnc0/VksXWlqEE+96LYyrlHueDq
	LygxS8rNA2EjXZvfJyN6M4ECSh8rjBlEP7AnY61ot7Zwp9YR+RxwBm8xmSQRK1Ro420NqBWN8HJ
	hDKJYMloRbbcMytZ2AY+51cpwAZo=
X-Google-Smtp-Source: AGHT+IF4YK67tIpkwsZswLnC9nszcTGZb0WX1YzzFw8/i8GM8voajrlh579SmjmLL7VCIfEf+DqGnxNahUO6cTWsDj8=
X-Received: by 2002:a05:6808:19aa:b0:403:31a4:f3fa with SMTP id
 5614622812f47-4036f0da2cbmr1833792b6e.35.1746617686660; Wed, 07 May 2025
 04:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com> <20250506213814.2365788-5-zaidal@os.amperecomputing.com>
In-Reply-To: <20250506213814.2365788-5-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:34:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
X-Gm-Features: ATxdqUFo9t00Y08Bqt8BJZ0VScpKVfjmIqHn29yfFbbnRTEorhLPCSwW2nP9xUw
Message-ID: <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:38=E2=80=AFPM Zaid Alali
<zaidal@os.amperecomputing.com> wrote:
>
> A single call to einj_get_available_error_type in init function is
> sufficient to save the return value in a global variable to be used
> later in various places in the code. This commit does not introduce
> any functional changes, but only removing unnecessary redundant
> function calls.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Does this patch depend on patches [1-3/7]?  If not, I can pick it up
as an optimization.

> ---
>  drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 47abd9317fef..ada1d7026af5 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -83,6 +83,8 @@ static struct debugfs_blob_wrapper vendor_blob;
>  static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>
> +static u32 available_error_type;
> +
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
>   * EINJ table through an unpublished extension. Use with caution as
> @@ -662,14 +664,9 @@ static struct { u32 mask; const char *str; } const e=
inj_error_type_string[] =3D {
>
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
> -       int rc;
> -       u32 error_type =3D 0;
>
> -       rc =3D einj_get_available_error_type(&error_type);
> -       if (rc)
> -               return rc;
>         for (int pos =3D 0; pos < ARRAY_SIZE(einj_error_type_string); pos=
++)
> -               if (error_type & einj_error_type_string[pos].mask)
> +               if (available_error_type & einj_error_type_string[pos].ma=
sk)
>                         seq_printf(m, "0x%08x\t%s\n", einj_error_type_str=
ing[pos].mask,
>                                    einj_error_type_string[pos].str);
>
> @@ -692,8 +689,7 @@ bool einj_is_cxl_error_type(u64 type)
>
>  int einj_validate_error_type(u64 type)
>  {
> -       u32 tval, vendor, available_error_type =3D 0;
> -       int rc;
> +       u32 tval, vendor;
>
>         /* Only low 32 bits for error type are valid */
>         if (type & GENMASK_ULL(63, 32))
> @@ -709,13 +705,9 @@ int einj_validate_error_type(u64 type)
>         /* Only one error type can be specified */
>         if (tval & (tval - 1))
>                 return -EINVAL;
> -       if (!vendor) {
> -               rc =3D einj_get_available_error_type(&available_error_typ=
e);
> -               if (rc)
> -                       return rc;
> +       if (!vendor)
>                 if (!(type & available_error_type))
>                         return -EINVAL;
> -       }
>
>         return 0;
>  }
> @@ -791,6 +783,10 @@ static int __init einj_probe(struct platform_device =
*pdev)
>                 goto err_put_table;
>         }
>
> +       rc =3D einj_get_available_error_type(&available_error_type);
> +       if (rc)
> +               return rc;
> +
>         rc =3D -ENOMEM;
>         einj_debug_dir =3D debugfs_create_dir("einj", apei_get_debugfs_di=
r());
>
> --
> 2.43.0
>

