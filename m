Return-Path: <linux-acpi+bounces-7244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC75946004
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9023F1C21033
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF542139C6;
	Fri,  2 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWB6ivEU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9F2101A0;
	Fri,  2 Aug 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611641; cv=none; b=Esgs/sI/xjXzDFyv5DKoLmq+8q4h9QiDo1Gv+WSTW/sQfO5FZvh+LUlkEBZs0q/Br7ZYrRRh9A67sMJuu2CFFNmmyO41YWUF9rY92guRf2uG8+pLg5KabmyYrYYyXWUcM3gOFphObTz12O4D5JpqSSpKfZKqSDfs+OtyMEC5y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611641; c=relaxed/simple;
	bh=ZbMK+mNmuq1p2SzgYsGBsSkD66aeog6KMnL9ACHlE1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+xLOqySv/mkPZM1nH7UI83up+JZMBm9Lk54k7pZtZ9rhNY4Jc9AAxqn4VclCozVnPrayaP5TOVVt/IBt1Nwq3JWF/8FrKGHaZsQTBNYDORIHS4HmxJAV7R9y6AuQs/+Gig2Gx1/yNarBkdDa1lppnOXu/j6JdzXmAt/XYEQsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWB6ivEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C21C32782;
	Fri,  2 Aug 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722611640;
	bh=ZbMK+mNmuq1p2SzgYsGBsSkD66aeog6KMnL9ACHlE1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FWB6ivEU1d6Qhec0mA21xhoI8qHBX4kpxtWMzhzD2Xr9LQ60sPNdmdaIJZ6YP/QFg
	 bzBsbUhZb2UX1oNkiorhgxL2pSsk1kiUAYZpRT32zGjM6N1jzonDU6c80Ak3SnjbSv
	 37oMDTf0av/u3un8n4qhC9X/vBZZYS3qeIv006bI4rkgOu8OObo3a1ARDMYzpUyrv/
	 ZYTSS/MGHCPJGiFfnNgRNKnglI2Iru70oRzojIvqXi4hw3hEi7h25ZqjPu8NqP61wP
	 Nj9kfHainIaMVEpGu2TlGVd0/kO3AWA4Y5hEQZIZg/Zh8IpjGAaGscImzPJpJmStSa
	 zRNlsPFWgqppA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db10d8830aso763140b6e.0;
        Fri, 02 Aug 2024 08:14:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8ij7aQIYPd0MloRrHdi5D9favtqHISWx78GpTZeF3oAKmyYdigAEb8I5UjbvviIyGo6gTrazJu0/tjc27Cfph6f/dXxzKSZOl4y7i2+TdqQL899LxG5BtZYAE+LM5IFG7ZfRXeKe20g==
X-Gm-Message-State: AOJu0Yyrc1LGaPPg3C6T6Qz/WifivOhYH0jisebfWiJwib8jhS7h3gJ4
	wiobb2a57FCaoGggKA2dFoVzJR32xL4/WtuQco7o5F5Go6dv7g1ntDMiPV331eKSATF77uHvWCR
	mvQMZa9pQxVNle73fjt6jgSTvCqY=
X-Google-Smtp-Source: AGHT+IFNZYcF3uqR4OY3lduSzRsUwT82PQ2KBtKL0cfFh3g065OHfuTDW8k5OxpDsvM1oPYD+S4AJUX3IMHPWwBAZzk=
X-Received: by 2002:a05:6870:7b4c:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-26891e1566emr2464668fac.6.1722611640121; Fri, 02 Aug 2024
 08:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715153336.3720653-1-cleger@rivosinc.com>
In-Reply-To: <20240715153336.3720653-1-cleger@rivosinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 17:13:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Message-ID: <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix MASK_VAL() usage
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 5:33=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> MASK_VAL() was added a way to handle bit_offset and bit_width for
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
>  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/cppc_acpi.h |  2 ++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d857978f5f4..2e99cf1842ee 100644
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
> +                       ret_val =3D -EFAULT;
> +                       goto out_unlock;

I would do

                      spin_unlock(&cpc_desc->rmw_lock);
                      return -EFAUL;

here to avoid the check below which is redundant in this path and the
label would not be necessary then.

LGTM otherwise.

> +               };
> +               val =3D MASK_VAL_WRITE(reg, prev_val, val);
> +               val |=3D prev_val;
> +       }
>
>         switch (size) {
>         case 8:
> @@ -1134,6 +1166,10 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 break;
>         }
>
> +out_unlock:
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
> 2.45.2
>

