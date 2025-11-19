Return-Path: <linux-acpi+bounces-19109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E20C6E94B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 692054F5113
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD935F8AE;
	Wed, 19 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0BN6WHE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2D35F8A7
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555710; cv=none; b=H1XZUtrUJokjC7nazlVDq6CghIz2WMD/D3zb/Hmqywh/LpVEdtdFz5D2q8r34vtcOw/qWDfdYQQxqdwn8qM2FHvlwkxIiazmYfcC8Wcc4tEA3pP8T2ZLojQOX3kmZDOvQzrhQJGfgGMGQ8BcUFX87ANhzUQ0v3WRghLqPiJag5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555710; c=relaxed/simple;
	bh=j1rlv8XfDgLSGIQBRzeVLRjfYKobf1S6pgoVP38xJ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSuPnRf5D+tyAt674qqwQuf1tcDj8P9JyrMTJHWATSvMTgUgVP7VUeWp2UOfSE57BbT3CcF1zWNAsGw3BDAX1dgCAvnjG49bihXATwNMlg6yU0jWCoceDIIwlM0FEoXfXeviUdbiV78WNJkqCvjUYn1jmD9ZMecwiZ2cfRAxsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0BN6WHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBCCC4AF14
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763555710;
	bh=j1rlv8XfDgLSGIQBRzeVLRjfYKobf1S6pgoVP38xJ5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s0BN6WHEBh8cGmd1k804iBbTkuSKePtimxsglU++SHlrmQ5365l/f4Nz2giR0MLv4
	 DHTW7FpQbP+K2mY1JaTX3Ku0ST6jU1eBJZ40lildNofLIP0ZV3SbJbZW4xlwBon1fk
	 hrWK897j8k6bb6ZO6iDprVE+eSuiT1xkJdFQoGJfE2r0VwvykYuopo5Q+jC0Vagplu
	 IKvPvYmqFJe8Txx3A72L8Nr3md0DbrmZfuGaQH+6wKaVAYRAi+FFCfSEgrxW0BTXcC
	 YG8NTXus1t69Q7LxZhMcNMXJyyW7hqW0gvlk15eiKyI8UTsf1S2F03dhxURzenb/yZ
	 t6z8/73JwRbJA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4501b097976so3129917b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 04:35:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/GJGQ/IzqoRpx/KLI9bqrGNZDF7bdZsK8ZQun35L5MKgXYSrkhG+CdTJZqDCBTJpL4WQ0d2Y2KGTD@vger.kernel.org
X-Gm-Message-State: AOJu0YwBixqzG90dKwCu60PckPv432OZDvXn7IEN19u9SmakzL7Yhkqg
	WYAMMiAuI1Ex1YZSXjM5PFePKHXhfRdzg/vyUOAFdPX6c+cMVymPsO41wblBvvtzqKsv+rCI63m
	kNaK3I0zwgwa22nPIov1Zdz4QLbHBH6U=
X-Google-Smtp-Source: AGHT+IHwQh5tHLbjPd7SeHDteGF0mygwrtLkg8NXmtTJMBVp1WLLQ0Pfu84ieljcC5NrL0bW6iTzsrwaHqG1WmZK9Yc=
X-Received: by 2002:a05:6808:4f63:b0:450:bf48:8352 with SMTP id
 5614622812f47-450bf48860amr5152460b6e.11.1763555705973; Wed, 19 Nov 2025
 04:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119012712.178715-1-tony.luck@intel.com>
In-Reply-To: <20251119012712.178715-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Nov 2025 13:34:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxsqMFgseYkRvfvGeQ22FQRTniAjP8vwNWYsEfrbkA-g@mail.gmail.com>
X-Gm-Features: AWmQ_blu8v12adL4B9E8PBfVgF66ftMnizrq9Qc0KYEemmxozXEcp5T7oNqaps8
Message-ID: <CAJZ5v0hxsqMFgseYkRvfvGeQ22FQRTniAjP8vwNWYsEfrbkA-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix EINJV2 initialization and injection
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bp@alien8.de, guohanjun@huawei.com, lenb@kernel.org, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, yi1.lai@intel.com, 
	zaidal@os.amperecomputing.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:27=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
>
> ACPI 6.6 specification for EINJV2 appends an extra structure to
> the end of the existing struct set_error_type_with_address.
>
> Several issues showed up in testing.
>
> 1) Initialization was broken by an earlier fix[1] since is_v2 is only set
>    while performing an injection, not during initialization.
>
> 2) A buggy BIOS provided invalid "revision" and "length" for the extensio=
n
>    structure. Add several sanity checks.
>
> 3) When injecting legacy error types on an EINJV2 capable system don't
>    copy the component arrays.
>
> Fixes: 6c7058514991 ("ACPI: APEI: EINJ: Check if user asked for EINJV2 in=
jection") # [1]
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/einj-core.c | 64 ++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 3c87953dbd19..305c240a303f 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -182,6 +182,7 @@ bool einj_initialized __ro_after_init;
>
>  static void __iomem *einj_param;
>  static u32 v5param_size;
> +static u32 v66param_size;
>  static bool is_v2;
>
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
> @@ -283,6 +284,24 @@ static void check_vendor_extension(u64 paddr,
>         acpi_os_unmap_iomem(p, sizeof(v));
>  }
>
> +static u32 einjv2_init(struct einjv2_extension_struct *e)
> +{
> +       if (e->revision !=3D 1) {
> +               pr_info("Unknown v2 extension revision %u\n", e->revision=
);
> +               return 0;
> +       }
> +       if (e->length < sizeof(*e) || e->length > PAGE_SIZE) {
> +               pr_info(FW_BUG "Bad1 v2 extension length %u\n", e->length=
);
> +               return 0;
> +       }
> +       if ((e->length - sizeof(*e)) % sizeof(e->component_arr[0])) {
> +               pr_info(FW_BUG "Bad2 v2 extension length %u\n", e->length=
);
> +               return 0;
> +       }
> +
> +       return (e->length - sizeof(*e)) / sizeof(e->component_arr[0]);
> +}
> +
>  static void __iomem *einj_get_parameter_address(void)
>  {
>         int i;
> @@ -310,28 +329,21 @@ static void __iomem *einj_get_parameter_address(voi=
d)
>                 v5param_size =3D sizeof(v5param);
>                 p =3D acpi_os_map_iomem(pa_v5, sizeof(*p));
>                 if (p) {
> -                       int offset, len;
> -
>                         memcpy_fromio(&v5param, p, v5param_size);
>                         acpi5 =3D 1;
>                         check_vendor_extension(pa_v5, &v5param);
> -                       if (is_v2 && available_error_type & ACPI65_EINJV2=
_SUPP) {
> -                               len =3D v5param.einjv2_struct.length;
> -                               offset =3D offsetof(struct einjv2_extensi=
on_struct, component_arr);
> -                               max_nr_components =3D (len - offset) /
> -                                               sizeof(v5param.einjv2_str=
uct.component_arr[0]);
> -                               /*
> -                                * The first call to acpi_os_map_iomem ab=
ove does not include the
> -                                * component array, instead it is used to=
 read and calculate maximum
> -                                * number of components supported by the =
system. Below, the mapping
> -                                * is expanded to include the component a=
rray.
> -                                */
> +                       if (available_error_type & ACPI65_EINJV2_SUPP) {
> +                               struct einjv2_extension_struct *e;
> +
> +                               e =3D &v5param.einjv2_struct;
> +                               max_nr_components =3D einjv2_init(e);
> +
> +                               /* remap including einjv2_extension_struc=
t */
>                                 acpi_os_unmap_iomem(p, v5param_size);
> -                               offset =3D offsetof(struct set_error_type=
_with_address, einjv2_struct);
> -                               v5param_size =3D offset + struct_size(&v5=
param.einjv2_struct,
> -                                       component_arr, max_nr_components)=
;
> -                               p =3D acpi_os_map_iomem(pa_v5, v5param_si=
ze);
> +                               v66param_size =3D v5param_size - sizeof(*=
e) + e->length;
> +                               p =3D acpi_os_map_iomem(pa_v5, v66param_s=
ize);
>                         }
> +
>                         return p;
>                 }
>         }
> @@ -527,6 +539,7 @@ static int __einj_error_inject(u32 type, u32 flags, u=
64 param1, u64 param2,
>                                u64 param3, u64 param4)
>  {
>         struct apei_exec_context ctx;
> +       u32 param_size =3D is_v2 ? v66param_size : v5param_size;
>         u64 val, trigger_paddr, timeout =3D FIRMWARE_TIMEOUT;
>         int i, rc;
>
> @@ -539,11 +552,11 @@ static int __einj_error_inject(u32 type, u32 flags,=
 u64 param1, u64 param2,
>         if (acpi5) {
>                 struct set_error_type_with_address *v5param;
>
> -               v5param =3D kmalloc(v5param_size, GFP_KERNEL);
> +               v5param =3D kmalloc(param_size, GFP_KERNEL);
>                 if (!v5param)
>                         return -ENOMEM;
>
> -               memcpy_fromio(v5param, einj_param, v5param_size);
> +               memcpy_fromio(v5param, einj_param, param_size);
>                 v5param->type =3D type;
>                 if (type & ACPI5_VENDOR_BIT) {
>                         switch (vendor_flags) {
> @@ -601,7 +614,7 @@ static int __einj_error_inject(u32 type, u32 flags, u=
64 param1, u64 param2,
>                                 break;
>                         }
>                 }
> -               memcpy_toio(einj_param, v5param, v5param_size);
> +               memcpy_toio(einj_param, v5param, param_size);
>                 kfree(v5param);
>         } else {
>                 rc =3D apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
> @@ -1132,9 +1145,14 @@ static void einj_remove(struct faux_device *fdev)
>         struct apei_exec_context ctx;
>
>         if (einj_param) {
> -               acpi_size size =3D (acpi5) ?
> -                       v5param_size :
> -                       sizeof(struct einj_parameter);
> +               acpi_size size;
> +
> +               if (v66param_size)
> +                       size =3D v66param_size;
> +               else if (acpi5)
> +                       size =3D v5param_size;
> +               else
> +                       size =3D sizeof(struct einj_parameter);
>
>                 acpi_os_unmap_iomem(einj_param, size);
>                 if (vendor_errors.size)
> --

Applied as 6.18-rc material, thanks!

