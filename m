Return-Path: <linux-acpi+bounces-13559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25BAADD62
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBC1B675D8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D871553AA;
	Wed,  7 May 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwW/YR+V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C121019C;
	Wed,  7 May 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617516; cv=none; b=kzF4tIakBF5Y7ZnwooULJYWiHvCPXQ9JOZYprBwa7+neUXi/pgmhKrVvceTHTe15WkOEp/cCGXCPM0G9UGAc6/1Vb0OQSt8WodryJHfkaDRruQLDPlIONRhfkm3z1DZwopSSLzqnvm2cjYRM8XBToC+S4Y4iVhwxIzQ8jluTd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617516; c=relaxed/simple;
	bh=Q0BXnembag2wEn8WKAYP21dxjoqS6jcuMUlO3cvcvKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfCMPYOnuxnWWi4X6h7fnotSPuWNhag88rpDflJMlg/pb33s1VSx9CgEitG9d4vGGQGQNwK6TAVrIhc8hqHOnsCRatJlS8vTpwvjFiFWsdMvYBIsGS/Vn+NGnHE+gWOqs6BX4ig5BlTNOStR53gZH4SY6EhGebVkXjHyvI8F1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwW/YR+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313BDC4CEF3;
	Wed,  7 May 2025 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617516;
	bh=Q0BXnembag2wEn8WKAYP21dxjoqS6jcuMUlO3cvcvKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pwW/YR+VZify0zPNZmiUA6GdvW6/4OgEelS60hqOXpn/AwWHL1FfKjZFvHf6I6uam
	 yydu/aSnsltgTz2YlEzSy01pcv0UWs09RlZ3KIMYl/A49HppUl9tn+TbNAXh72xxfC
	 uQ9kszD4HqpRgXfH5cN4sSfEJxSFX/zrqW5HM4/zlP62Eb6bieTRo2Pk1IZfnNYljn
	 4yLilqWk8ytRoMYLrNKGirIPB+uDX3ZCmbNSL4DFQebRe9SBteuTSWrZTOg8qWxAh7
	 0/XHDGqCIMVdpzoHC7r9UKw0CVOCtyENfePPNuozaEglcIwP4RJIlWa3KbeuBdT9Qb
	 arJHyAgOIcEvw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2db0217abe4so1594581fac.1;
        Wed, 07 May 2025 04:31:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAoBG/trGMOd2HM15AgNTmLHq1ycRHsxIlxFz1ZE6oUI42sv/EAICEtsJHLH56Lo0Orvkz5OWx3J2q@vger.kernel.org, AJvYcCWiPxdgD8B5kmX2rX2uaFdbjO4FkAGlk9TgwQUyVChqJIeporthe6SL/2WNlge+IbW2zvDzXbEIplQapbZa@vger.kernel.org
X-Gm-Message-State: AOJu0YyT02paQjaYvE5ZHwslFIRkr8vEFRHUU1h7f/j8n9ju9SZcgM1N
	6bb8AXtHbV+L5gusFyWqhiwbriczUcAR6bwP+vVlVLk1St622FvT38aKlqT3VC8pxLyHlUhoRZF
	JZthUjP129szFp9S8nHFYvbssPVg=
X-Google-Smtp-Source: AGHT+IGuTnGQdwMRXmF5kfEJfEQ059fLXzYkD+J55P3CG+MVRVdkK6cvLLUV8P9SvEq5QqZtbv7CVk6wSKx0vO3A3Mk=
X-Received: by 2002:a05:6870:4790:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2db5c15475fmr1664925fac.36.1746617515368; Wed, 07 May 2025
 04:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com> <20250506213814.2365788-4-zaidal@os.amperecomputing.com>
In-Reply-To: <20250506213814.2365788-4-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:31:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHJjP3BRWz0PZTT_fq24VC75YZLkyu7ovDkRPmKVVGuA@mail.gmail.com>
X-Gm-Features: ATxdqUGyC5GSvLF14p2zYaQzkUyLxUidagCI2e6hJ2buPvuAxboPkeLFjKCjbHE
Message-ID: <CAJZ5v0iHJjP3BRWz0PZTT_fq24VC75YZLkyu7ovDkRPmKVVGuA@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] ACPI: APEI: EINJ: Fix kernel test sparse warnings
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
> This patch fixes the kernel test robot warning reported here:
> Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

The Link: tag should be adjacent to the other tags.

Also, it is not sufficient to point to a problem report from a patch
changelog.  Please describe both the problem and the fix.

> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 04731a5b01fa..47abd9317fef 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
>   */
>  bool einj_initialized __ro_after_init;
>
> -static void *einj_param;
> +static void __iomem *einj_param;
>
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -214,24 +214,26 @@ static void check_vendor_extension(u64 paddr,
>                                    struct set_error_type_with_address *v5=
param)
>  {
>         int     offset =3D v5param->vendor_extension;
> -       struct  vendor_error_type_extension *v;
> +       struct  vendor_error_type_extension v;
> +       struct vendor_error_type_extension __iomem *p;
>         u32     sbdf;
>
>         if (!offset)
>                 return;
> -       v =3D acpi_os_map_iomem(paddr + offset, sizeof(*v));
> -       if (!v)
> +       p =3D acpi_os_map_iomem(paddr + offset, sizeof(*p));
> +       if (!p)
>                 return;
> -       get_oem_vendor_struct(paddr, offset, v);
> -       sbdf =3D v->pcie_sbdf;
> +       memcpy_fromio(&v, p, sizeof(v));
> +       get_oem_vendor_struct(paddr, offset, &v);
> +       sbdf =3D v.pcie_sbdf;
>         sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=3D%x device_id=3D%x re=
v_id=3D%x\n",
>                 sbdf >> 24, (sbdf >> 16) & 0xff,
>                 (sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
> -                v->vendor_id, v->device_id, v->rev_id);
> -       acpi_os_unmap_iomem(v, sizeof(*v));
> +                v.vendor_id, v.device_id, v.rev_id);
> +       acpi_os_unmap_iomem(p, sizeof(v));
>  }
>
> -static void *einj_get_parameter_address(void)
> +static void __iomem *einj_get_parameter_address(void)
>  {
>         int i;
>         u64 pa_v4 =3D 0, pa_v5 =3D 0;
> @@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
>                 entry++;
>         }
>         if (pa_v5) {
> -               struct set_error_type_with_address *v5param;
> +               struct set_error_type_with_address v5param;
> +               struct set_error_type_with_address __iomem *p;
>
> -               v5param =3D acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> -               if (v5param) {
> +               p =3D acpi_os_map_iomem(pa_v5, sizeof(*p));
> +               if (p) {
> +                       memcpy_fromio(&v5param, p, sizeof(v5param));
>                         acpi5 =3D 1;
> -                       check_vendor_extension(pa_v5, v5param);
> -                       return v5param;
> +                       check_vendor_extension(pa_v5, &v5param);
> +                       return p;
>                 }
>         }
>         if (param_extension && pa_v4) {
> -               struct einj_parameter *v4param;
> +               struct einj_parameter v4param;
> +               struct einj_parameter __iomem *p;
>
> -               v4param =3D acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> -               if (!v4param)
> +               p =3D acpi_os_map_iomem(pa_v4, sizeof(*p));
> +               if (!p)
>                         return NULL;
> -               if (v4param->reserved1 || v4param->reserved2) {
> -                       acpi_os_unmap_iomem(v4param, sizeof(*v4param));
> +               memcpy_fromio(&v4param, p, sizeof(v4param));
> +               if (v4param.reserved1 || v4param.reserved2) {
> +                       acpi_os_unmap_iomem(p, sizeof(v4param));
>                         return NULL;
>                 }
> -               return v4param;
> +               return p;
>         }
>
>         return NULL;
> @@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_=
parameter_region(
>  static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>                                 u64 param1, u64 param2)
>  {
> -       struct acpi_einj_trigger *trigger_tab =3D NULL;
> +       struct acpi_einj_trigger trigger_tab;
>         struct apei_exec_context trigger_ctx;
>         struct apei_resources trigger_resources;
>         struct acpi_whea_header *trigger_entry;
> @@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, =
u32 type,
>         u32 table_size;
>         int rc =3D -EIO;
>         struct acpi_generic_address *trigger_param_region =3D NULL;
> +       struct acpi_einj_trigger __iomem *p;
>
> -       r =3D request_mem_region(trigger_paddr, sizeof(*trigger_tab),
> +       r =3D request_mem_region(trigger_paddr, sizeof(trigger_tab),
>                                "APEI EINJ Trigger Table");
>         if (!r) {
>                 pr_err("Can not request [mem %#010llx-%#010llx] for Trigg=
er table\n",
>                        (unsigned long long)trigger_paddr,
>                        (unsigned long long)trigger_paddr +
> -                           sizeof(*trigger_tab) - 1);
> +                           sizeof(trigger_tab) - 1);
>                 goto out;
>         }
> -       trigger_tab =3D ioremap_cache(trigger_paddr, sizeof(*trigger_tab)=
);
> -       if (!trigger_tab) {
> +       p =3D ioremap_cache(trigger_paddr, sizeof(*p));
> +       if (!p) {
>                 pr_err("Failed to map trigger table!\n");
>                 goto out_rel_header;
>         }
> -       rc =3D einj_check_trigger_header(trigger_tab);
> +       memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
> +       rc =3D einj_check_trigger_header(&trigger_tab);
>         if (rc) {
>                 pr_warn(FW_BUG "Invalid trigger error action table.\n");
>                 goto out_rel_header;
>         }
>
>         /* No action structures in the TRIGGER_ERROR table, nothing to do=
 */
> -       if (!trigger_tab->entry_count)
> +       if (!trigger_tab.entry_count)
>                 goto out_rel_header;
>
>         rc =3D -EIO;
> -       table_size =3D trigger_tab->table_size;
> -       r =3D request_mem_region(trigger_paddr + sizeof(*trigger_tab),
> -                              table_size - sizeof(*trigger_tab),
> +       table_size =3D trigger_tab.table_size;
> +       r =3D request_mem_region(trigger_paddr + sizeof(trigger_tab),
> +                              table_size - sizeof(trigger_tab),
>                                "APEI EINJ Trigger Table");
>         if (!r) {
>                 pr_err("Can not request [mem %#010llx-%#010llx] for Trigg=
er Table Entry\n",
> -                      (unsigned long long)trigger_paddr + sizeof(*trigge=
r_tab),
> +                      (unsigned long long)trigger_paddr + sizeof(trigger=
_tab),
>                        (unsigned long long)trigger_paddr + table_size - 1=
);
>                 goto out_rel_header;
>         }
> -       iounmap(trigger_tab);
> -       trigger_tab =3D ioremap_cache(trigger_paddr, table_size);
> -       if (!trigger_tab) {
> +       iounmap(p);
> +       p =3D ioremap_cache(trigger_paddr, table_size);
> +       if (!p) {
>                 pr_err("Failed to map trigger table!\n");
>                 goto out_rel_entry;
>         }
> +       memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
>         trigger_entry =3D (struct acpi_whea_header *)
> -               ((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
> +               ((char *)&trigger_tab + sizeof(struct acpi_einj_trigger))=
;
>         apei_resources_init(&trigger_resources);
>         apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
>                            ARRAY_SIZE(einj_ins_type),
> -                          trigger_entry, trigger_tab->entry_count);
> +                          trigger_entry, trigger_tab.entry_count);
>         rc =3D apei_exec_collect_resources(&trigger_ctx, &trigger_resourc=
es);
>         if (rc)
>                 goto out_fini;
> @@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>
>                 apei_resources_init(&addr_resources);
>                 trigger_param_region =3D einj_get_trigger_parameter_regio=
n(
> -                       trigger_tab, param1, param2);
> +                       &trigger_tab, param1, param2);
>                 if (trigger_param_region) {
>                         rc =3D apei_resources_add(&addr_resources,
>                                 trigger_param_region->address,
> @@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, =
u32 type,
>  out_fini:
>         apei_resources_fini(&trigger_resources);
>  out_rel_entry:
> -       release_mem_region(trigger_paddr + sizeof(*trigger_tab),
> -                          table_size - sizeof(*trigger_tab));
> +       release_mem_region(trigger_paddr + sizeof(trigger_tab),
> +                          table_size - sizeof(trigger_tab));
>  out_rel_header:
> -       release_mem_region(trigger_paddr, sizeof(*trigger_tab));
> +       release_mem_region(trigger_paddr, sizeof(trigger_tab));
>  out:
> -       if (trigger_tab)
> -               iounmap(trigger_tab);
> +       if (p)
> +               iounmap(p);
>
>         return rc;
>  }
> @@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, =
u64 param1, u64 param2,
>                 return rc;
>         apei_exec_ctx_set_input(&ctx, type);
>         if (acpi5) {
> -               struct set_error_type_with_address *v5param =3D einj_para=
m;
> +               struct set_error_type_with_address *v5param, v5_struct;
>
> +               v5param =3D &v5_struct;
> +               memcpy_fromio(v5param, einj_param, sizeof(*v5param));
>                 v5param->type =3D type;
>                 if (type & ACPI5_VENDOR_BIT) {
>                         switch (vendor_flags) {
> @@ -490,15 +501,18 @@ static int __einj_error_inject(u32 type, u32 flags,=
 u64 param1, u64 param2,
>                                 break;
>                         }
>                 }
> +               memcpy_toio(einj_param, v5param, sizeof(*v5param));
>         } else {
>                 rc =3D apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>                 if (rc)
>                         return rc;
>                 if (einj_param) {
> -                       struct einj_parameter *v4param =3D einj_param;
> +                       struct einj_parameter v4param;
>
> -                       v4param->param1 =3D param1;
> -                       v4param->param2 =3D param2;
> +                       memcpy_fromio(&v4param, einj_param, sizeof(v4para=
m));
> +                       v4param.param1 =3D param1;
> +                       v4param.param2 =3D param2;
> +                       memcpy_toio(einj_param, &v4param, sizeof(v4param)=
);
>                 }
>         }
>         rc =3D apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
> --
> 2.43.0
>

