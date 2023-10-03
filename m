Return-Path: <linux-acpi+bounces-395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A887B7282
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 769A728108D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4673D962
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06835D2EB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 18:50:54 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CF9B;
	Tue,  3 Oct 2023 11:50:53 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bc9353be9bso168644a34.1;
        Tue, 03 Oct 2023 11:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359053; x=1696963853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtmU+2BPb9XNUrXvybi5wLHb9uDgJzpyWhEvJ9afzl0=;
        b=kkDvJWOKsIZaw7BuUvwrkkE6qucbSDNbfIS4AKXQ/IlGi2mAN+ehvsTaIG/5W3kgN8
         WqhJsQGokrxFoSBYEuo6uHSc9LKH2D2D+G3pewe8C/FzxpIVRSyS1v8lP8flTzKGa4zn
         xRx76TYQeI1p0odAsZ+WIHeLFoLhr5Sk2J+cgXos+wARWJsCET25t+ZOKBUqksN9FA1U
         VVzWw/VMO4FBgLcge9cRw1/K4kWfUbWsIiL33uHuWtejGxzQCeKg8t1/mHkesfVge2Ua
         vTVn7bmHLKf3GeLFQepwK6GdBdpJFq+KGyUq7y79/KKHGLn2pn8NH8LqQfFQeF2xFLcn
         m8tA==
X-Gm-Message-State: AOJu0YzQpQF8uKR1kSZQWKhzmNfEwBhzISWhGQ4MgnouHMTkPP/sJdSX
	Q8zi2w9HFmtYaAsB3LYpjDRlhSJAFTm+zFvFdu9zZqM8/EU=
X-Google-Smtp-Source: AGHT+IFYN5h5648JxSFBF0rPTdkQtq207jLp+ThdPn4mk/HwNfd3j0kRgAzA1sxYc+qinsdz2c6Zg/AjeM7zYGfba0M=
X-Received: by 2002:a05:6808:309b:b0:3a9:e8e2:579d with SMTP id
 bl27-20020a056808309b00b003a9e8e2579dmr473542oib.2.1696359052777; Tue, 03 Oct
 2023 11:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
In-Reply-To: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 20:50:41 +0200
Message-ID: <CAJZ5v0iHJcZzF=hGLRH+tT6uqCrfHbLw_KJD5dSRRTrsbeVMUQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: Use access_width over register_width for system
 memory accesses
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 8:06=E2=80=AFPM Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we canno=
t
> depend on it being always on a clean 8b boundary. Instead, use access_wid=
th
> to determine the size and use the offset and width to shift and mask the
> bit swe want to read/write out. Make sure to add a check for system memor=
y
> since pcc redefines the access_width to subspace id.

This is fine, but what if there are systems in the field where
bit_width is invalid, but they just happen to work because of the way
it is currently handled?

> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> ---
>  drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..07619b36c056 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -777,6 +777,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                         } else if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_=
SYSTEM_MEMORY) {
>                                 if (gas_t->address) {
>                                         void __iomem *addr;
> +                                       size_t access_width;
>
>                                         if (!osc_cpc_flexible_adr_space_c=
onfirmed) {
>                                                 pr_debug("Flexible addres=
s space capability not supported\n");
> @@ -784,7 +785,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                                                         goto out_free;
>                                         }
>
> -                                       addr =3D ioremap(gas_t->address, =
gas_t->bit_width/8);
> +                                       access_width =3D ((8 << (gas_t->a=
ccess_width - 1)) / 8);

The 8 << (gas_t->access_width - 1) is duplicated twice below.  There
could be an inline function doing that computation.

And the outer parens above are not needed AFAICS.

> +                                       addr =3D ioremap(gas_t->address, =
access_width);
>                                         if (!addr)
>                                                 goto out_free;
>                                         cpc_ptr->cpc_regs[i-2].sys_mem_va=
ddr =3D addr;
> @@ -980,6 +982,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *=
reg, u64 val)
>  static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 =
*val)
>  {
>         void __iomem *vaddr =3D NULL;
> +       int size;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
> @@ -1015,7 +1018,12 @@ static int cpc_read(int cpu, struct cpc_register_r=
esource *reg_res, u64 *val)
>                 return acpi_os_read_memory((acpi_physical_address)reg->ad=
dress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               size =3D (8 << (reg->access_width - 1));

Code duplication, outer perens not needed.

> +       else
> +               size =3D reg->bit_width;
> +
> +       switch (size) {
>         case 8:
>                 *val =3D readb_relaxed(vaddr);
>                 break;
> @@ -1034,12 +1042,16 @@ static int cpc_read(int cpu, struct cpc_register_=
resource *reg_res, u64 *val)
>                 return -EFAULT;
>         }
>
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               *val =3D (*val >> reg->bit_offset) & GENMASK((reg->bit_wi=
dth) - 1, 0);

The formula on the right-hand side of this is duplicated below.
Again, there could be an inline function doing this.

> +
>         return 0;
>  }
>
>  static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64=
 val)
>  {
>         int ret_val =3D 0;
> +       int size;
>         void __iomem *vaddr =3D NULL;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
> @@ -1067,7 +1079,13 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 return acpi_os_write_memory((acpi_physical_address)reg->a=
ddress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               size =3D (8 << (reg->access_width - 1));
> +               val =3D (val >> reg->bit_offset) & GENMASK((reg->bit_widt=
h) - 1, 0);
> +       } else
> +               size =3D reg->bit_width;

Missing braces (as per the kernel coding style).

> +
> +       switch (size) {
>         case 8:
>                 writeb_relaxed(val, vaddr);
>                 break;
> --
> 2.34.1
>

