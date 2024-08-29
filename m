Return-Path: <linux-acpi+bounces-7955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99D9642F3
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C6B2145A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB81917CC;
	Thu, 29 Aug 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKbG4lhl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377222339;
	Thu, 29 Aug 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930896; cv=none; b=Difqg17OQChNtL61/MdssnjV0a4s9nvHtb+uL2AmpSY/dUpMke/yf9ALXKk1pkWzdwihMUAp41bEu09JwOJ9pM/oVb+8fvqigFGIlfwVgcApwQ82xM3WRIlh66M5V1G/915crypdIaGt780qss3uRAO/g+wzSfdwhR/d89c0QuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930896; c=relaxed/simple;
	bh=CW83ZEIpkPz52PNovqYIVdDMJHBmM0F3hp75/bBTlUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TebuVoE1c0IoumT2aYEbf+rgt8fnerJrCZ1HQ8S3g1zr9OOjFcowTYkFxaMjPF0sjzhbiiNuIDbxHBs/wjcG64uUlv0f64oNV/3NYZPFVuaV6Unax+oxcXutzL+WR50zybI2hQxdKQsG8gBUsjlHNXYBbhc+lubV7Aeaf2v0hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKbG4lhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BEEC4CEC6;
	Thu, 29 Aug 2024 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724930895;
	bh=CW83ZEIpkPz52PNovqYIVdDMJHBmM0F3hp75/bBTlUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKbG4lhlp7ELKxPWqB5DcmWwqaLwt0frVjrqzpKPRXfymI1MhZiP0G5nCBGJ5Bg4t
	 sgnbUPzCNBrw/sz7rxcT9Ltnh6RwgkHVzO2Qv0Ty53i/hKu4/lztP+bdk1PgeQ3ofK
	 kY9psR6NhY4hxdYyNwbas4HdFeXTjosHu2ugl2msQMUcbqHFA81Bde23EUc/n+DNdy
	 oEjtEbg1QYtlvh8p6jVEjzQiaEXTc5QFNh3/LSXCN2ZFnuXnwofPkJQh1u08BelvAH
	 9B43XWN4HC4/0mJFPQEvrHOI8eNuH3Wy7btmLmKgRJkiZmlG5P4e7OEDNFpuHPNcmp
	 QXcoqUC6l+fdA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db157d3bb9so325542b6e.2;
        Thu, 29 Aug 2024 04:28:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU18bKe8/yDyyl8zizpCp+HoemfksCcAsCv+uUpdyUybAMaLJMVVFlBUfEr7+KDr5IRNlJimtmtQ3/P@vger.kernel.org, AJvYcCVx4QTcQ6BnC7bKiV1cPyQDnZWFLzYFn0P29/4tAcvTO3Bl29ABjhVelmGALmf4egUgb6eTV1dVtYHA5qmr@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUhqlzWyKyGsGb7M4U1MuU5wBdaBBgFQCkSGbZlMj90+e55jG
	si3mAiErrheKw8SgPbemY95xg0cV69pcDj3V5eOazh0bDI0x1Mp5UwGh30oiOUmw4kJUxJf0a6g
	9qYPxh1VN6qvQ9v+nPqARqnGdqGQ=
X-Google-Smtp-Source: AGHT+IGz5F+qmlvaiKD6trNVX8aBlX43dl81V4HoKG0dddBlHdfJlg7ZRaq9zYgsOxqBnmAWOCmUVysjX+v1FckoXUU=
X-Received: by 2002:a05:6808:169e:b0:3dd:4376:db2c with SMTP id
 5614622812f47-3df05db003emr2649869b6e.9.1724930894959; Thu, 29 Aug 2024
 04:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826101648.95654-1-cleger@rivosinc.com>
In-Reply-To: <20240826101648.95654-1-cleger@rivosinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 13:28:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jDzZDhorU+zE+dh+wd0cim9n2XQYZbMUDhyQ=DgDhNYw@mail.gmail.com>
Message-ID: <CAJZ5v0jDzZDhorU+zE+dh+wd0cim9n2XQYZbMUDhyQ=DgDhNYw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Fix MASK_VAL() usage
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:32=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> MASK_VAL() was added as a way to handle bit_offset and bit_width for
> registers located in system memory address space. However, while suited
> for reading, it does not work for writing and result in corrupted
> registers when writing values with bit_offset > 0. Moreover, when a
> register is collocated with another one at the same address but with a
> different mask, the current code results in the other registers being
> overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
> should actually read the value, mask it, update it and write it with the
> updated value. Moreover, since registers can be located in the same
> word, we must take care of locking the access before doing it. We should
> potentially use a global lock since we don't know in if register
> addresses aren't shared with another _CPC package but better not
> encourage vendors to do so. Assume that registers can use the same word
> inside a _CPC package and thus, use a per _CPC package lock.
>
> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for sys=
tem memory accesses")
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> ---
> v2:
>  - Remove label and unlock the spinlock earlier.
>
>  drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/cppc_acpi.h |  2 ++
>  2 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d857978f5f4..4a47e08704d9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs=
, wraparound_time);
>  #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_w=
idth - 1)) : (reg)->bit_width)
>
>  /* Shift and apply the mask for CPC reads/writes */
> -#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) &              =
       \
> +#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &         =
                       \
>                                         GENMASK(((reg)->bit_width) - 1, 0=
))
> +#define MASK_VAL_WRITE(reg, prev_val, val)                              =
               \
> +       ((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offs=
et) |          \
> +       ((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_=
offset)))      \
>
>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
>                 struct kobj_attribute *attr, char *buf)
> @@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>
>         /* Store CPU Logical ID */
>         cpc_ptr->cpu_id =3D pr->id;
> +       spin_lock_init(&cpc_ptr->rmw_lock);
>
>         /* Parse PSD data for this CPU */
>         ret =3D acpi_get_psd(cpc_ptr, handle);
> @@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_re=
source *reg_res, u64 *val)
>         }
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -               *val =3D MASK_VAL(reg, *val);
> +               *val =3D MASK_VAL_READ(reg, *val);
>
>         return 0;
>  }
> @@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>  {
>         int ret_val =3D 0;
>         int size;
> +       u64 prev_val;
>         void __iomem *vaddr =3D NULL;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
> +       struct cpc_desc *cpc_desc;
>
>         size =3D GET_BIT_WIDTH(reg);
>
> @@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 return acpi_os_write_memory((acpi_physical_address)reg->a=
ddress,
>                                 val, size);
>
> -       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -               val =3D MASK_VAL(reg, val);
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +               if (!cpc_desc) {
> +                       pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +                       return -ENODEV;
> +               }
> +
> +               spin_lock(&cpc_desc->rmw_lock);
> +               switch (size) {
> +               case 8:
> +                       prev_val =3D readb_relaxed(vaddr);
> +                       break;
> +               case 16:
> +                       prev_val =3D readw_relaxed(vaddr);
> +                       break;
> +               case 32:
> +                       prev_val =3D readl_relaxed(vaddr);
> +                       break;
> +               case 64:
> +                       prev_val =3D readq_relaxed(vaddr);
> +                       break;
> +               default:
> +                       spin_unlock(&cpc_desc->rmw_lock);
> +                       return -EFAULT;
> +               };
> +               val =3D MASK_VAL_WRITE(reg, prev_val, val);
> +               val |=3D prev_val;
> +       }
>
>         switch (size) {
>         case 8:
> @@ -1134,6 +1166,9 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                 break;
>         }
>
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               spin_unlock(&cpc_desc->rmw_lock);
> +
>         return ret_val;
>  }
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 930b6afba6f4..e1720d930666 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -64,6 +64,8 @@ struct cpc_desc {
>         int cpu_id;
>         int write_cmd_status;
>         int write_cmd_id;
> +       /* Lock used for RMW operations in cpc_write() */
> +       spinlock_t rmw_lock;
>         struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>         struct acpi_psd_package domain_info;
>         struct kobject kobj;
> --

Applied as 6.12 material, thanks!

