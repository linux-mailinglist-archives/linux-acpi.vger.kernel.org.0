Return-Path: <linux-acpi+bounces-13561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF28AADD87
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E936D3BBB36
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD0233704;
	Wed,  7 May 2025 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcCDH8q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3E23315A;
	Wed,  7 May 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617943; cv=none; b=AFCC5ik8yZgYHhde1S3FlNqLcjA60qFT3YAPOFQJMn6gHqGz7uYhB9ju16yieVf/tH2Ei461wez5sLOLAwK19gwM9g37ObswQy/kQHM7CC95pdgorEncexrUDxe4vpu5da6gcnoXySHYtll0BFNuP1lOtj8LHipZ8/Jwdp3GMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617943; c=relaxed/simple;
	bh=Hg6l6V9O/4wtXYDdTgCPzwnNnEBa8OCBsehc8OvrrqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXzCDYjokVgbe4o1f0qEtgJiOIDJdvpauMCyiY2cboMN1900TZIGL+yGdNUyFzx9yZ0FiLUImcDh7fCmIOIJA97ludKxHmK7D3GuNbum/QQHQVoTfoSzkB7InDrgs3wEaE/T67NBR6v39K1VwlKo37rSSSgw3nEpBvtTLO1rmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcCDH8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0709C4AF0B;
	Wed,  7 May 2025 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617942;
	bh=Hg6l6V9O/4wtXYDdTgCPzwnNnEBa8OCBsehc8OvrrqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DxcCDH8qx/q6v1LR8JboomoBFDhoa1gA+AZYhADwXOQoAShTQMj3Ox8tMI+/RxeJA
	 OI6EqRypC18VcI8R0AsLAA6YhQSjprYEfBUQfiEkuBRcb0zk6hPyBIOp7I1fqxaR/G
	 J80oA9b3ek2D2P2OBhDSPTxTU9fZbeUT17yh8bAUcwskixojQljCuDTu06bGf8LODZ
	 sJVMv9JvzDbKwzU76CLgnle18qHBhvxmc1A68+VVU/B7YabbKrOVTl7lIfhgZcwyYJ
	 prSEy0Bu0uZ6l8444DVysssxEGG81hwWIhctQtwWLrtORx2oNC6R9AvYGvg8Rt9j4r
	 3rM7gYMqXzMZA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c76a1b574cso2125320fac.2;
        Wed, 07 May 2025 04:39:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAkXtVde/Xko/zEr7rLeO1iHnozLF/He3Bi7PD+nQVGn34Bekv/SSzjwybYZl+r5W7P7wd35FmnEzdZ+jg@vger.kernel.org, AJvYcCXpZzml6u725UKquCCfy4fGlb5+wXxZ6urqZbin4BZBHIe979MptovBjRgkYgu1VsfmWBpLSzuXlzd1@vger.kernel.org
X-Gm-Message-State: AOJu0YxV17pmmZH8oWkBdrZEsQveHkbt5B909Ek4kPtKBrKiogsB4usp
	OhF42dIFvf7tBj6h5WKLxL0C03Ymtu8OtVPcBRk7eFG4k9TDE5gqz/jsJtA2gYb7e6iyykPOxnY
	pmeBWeRrHHP2Za/1Y8sgTHMpArKQ=
X-Google-Smtp-Source: AGHT+IFaSvdYyurc08EQzE/f5lxzhMMtC8SjK5DkN1Oux0A085DrUh3IgQugzwZfSDEB0LFsg/5XTZkvMW78zYzqS4k=
X-Received: by 2002:a05:6870:95a0:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2db5bd5c524mr1481924fac.1.1746617941915; Wed, 07 May 2025
 04:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com> <20250506213814.2365788-6-zaidal@os.amperecomputing.com>
In-Reply-To: <20250506213814.2365788-6-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:38:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hr74LKfz+8EzAeR59_2RYKCNAxh0_MSRvfA+nJakyfHw@mail.gmail.com>
X-Gm-Features: ATxdqUF_NwJ81TANR2N1xhJiUnotNJZzTryt9AripfXwdoa0owKuov1zAn95eDc
Message-ID: <CAJZ5v0hr74LKfz+8EzAeR59_2RYKCNAxh0_MSRvfA+nJakyfHw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
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
> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

While the tag provided by Jonathan is appreciated, patches [5-9/9]
need to be reviewed by one of the reviewers listed in the APEI entry
in MAINTAINERS.

> ---
>  drivers/acpi/apei/apei-internal.h |  2 +-
>  drivers/acpi/apei/einj-core.c     | 75 +++++++++++++++++++++++++------
>  drivers/acpi/apei/einj-cxl.c      |  2 +-
>  3 files changed, 63 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-i=
nternal.h
> index cd2766c69d78..77c10a7a7a9f 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_g=
eneric_status *estatus)
>
>  int apei_osc_setup(void);
>
> -int einj_get_available_error_type(u32 *type);
> +int einj_get_available_error_type(u32 *type, int einj_action);
>  int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 p=
aram3,
>                       u64 param4);
>  int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param=
2,
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index ada1d7026af5..ee26df0398fc 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -33,6 +33,7 @@
>  #define SLEEP_UNIT_MAX         5000                    /* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT       (1 * USEC_PER_SEC)
> +#define ACPI65_EINJV2_SUPP     BIT(30)
>  #define ACPI5_VENDOR_BIT       BIT(31)
>  #define MEM_ERROR_MASK         (ACPI_EINJ_MEMORY_CORRECTABLE | \
>                                 ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>
>  static u32 available_error_type;
> +static u32 available_error_type_v2;
>
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> @@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_con=
text *ctx)
>                            EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
>  }
>
> -static int __einj_get_available_error_type(u32 *type)
> +static int __einj_get_available_error_type(u32 *type, int einj_action)
>  {
>         struct apei_exec_context ctx;
>         int rc;
>
>         einj_exec_ctx_init(&ctx);
> -       rc =3D apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
> +       rc =3D apei_exec_run(&ctx, einj_action);
>         if (rc)
>                 return rc;
>         *type =3D apei_exec_ctx_get_output(&ctx);
> @@ -174,17 +176,34 @@ static int __einj_get_available_error_type(u32 *typ=
e)
>  }
>
>  /* Get error injection capabilities of the platform */
> -int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type, int einj_action)
>  {
>         int rc;
>
>         mutex_lock(&einj_mutex);
> -       rc =3D __einj_get_available_error_type(type);
> +       rc =3D __einj_get_available_error_type(type, einj_action);
>         mutex_unlock(&einj_mutex);
>
>         return rc;
>  }
>
> +static int einj_get_available_error_types(u32 *type1, u32 *type2)
> +{
> +       int rc;
> +
> +       rc =3D einj_get_available_error_type(type1, ACPI_EINJ_GET_ERROR_T=
YPE);
> +       if (rc)
> +               return rc;
> +       if (*type1 & ACPI65_EINJV2_SUPP) {
> +               rc =3D einj_get_available_error_type(type2,
> +                                                  ACPI_EINJV2_GET_ERROR_=
TYPE);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +
>  static int einj_timedout(u64 *t)
>  {
>         if ((s64)*t < SLEEP_UNIT_MIN) {
> @@ -646,6 +665,7 @@ static u64 error_param2;
>  static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
> +static char einj_buf[32];
>  static struct { u32 mask; const char *str; } const einj_error_type_strin=
g[] =3D {
>         { BIT(0), "Processor Correctable" },
>         { BIT(1), "Processor Uncorrectable non-fatal" },
> @@ -662,6 +682,12 @@ static struct { u32 mask; const char *str; } const e=
inj_error_type_string[] =3D {
>         { BIT(31), "Vendor Defined Error Types" },
>  };
>
> +static struct { u32 mask; const char *str; } const einjv2_error_type_str=
ing[] =3D {
> +       { BIT(0), "EINJV2 Processor Error" },
> +       { BIT(1), "EINJV2 Memory Error" },
> +       { BIT(2), "EINJV2 PCI Express Error" },
> +};
> +
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
>
> @@ -669,17 +695,22 @@ static int available_error_type_show(struct seq_fil=
e *m, void *v)
>                 if (available_error_type & einj_error_type_string[pos].ma=
sk)
>                         seq_printf(m, "0x%08x\t%s\n", einj_error_type_str=
ing[pos].mask,
>                                    einj_error_type_string[pos].str);
> -
> +       if (available_error_type & ACPI65_EINJV2_SUPP) {
> +               for (int pos =3D 0; pos < ARRAY_SIZE(einjv2_error_type_st=
ring); pos++) {
> +                       if (available_error_type_v2 & einjv2_error_type_s=
tring[pos].mask)
> +                               seq_printf(m, "V2_0x%08x\t%s\n", einjv2_e=
rror_type_string[pos].mask,
> +                                          einjv2_error_type_string[pos].=
str);
> +               }
> +       }
>         return 0;
>  }
>
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>
> -static int error_type_get(void *data, u64 *val)
> +static ssize_t error_type_get(struct file *file, char __user *buf,
> +                               size_t count, loff_t *ppos)
>  {
> -       *val =3D error_type;
> -
> -       return 0;
> +       return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen=
(einj_buf));
>  }
>
>  bool einj_is_cxl_error_type(u64 type)
> @@ -712,9 +743,23 @@ int einj_validate_error_type(u64 type)
>         return 0;
>  }
>
> -static int error_type_set(void *data, u64 val)
> +static ssize_t error_type_set(struct file *file, const char __user *buf,
> +                               size_t count, loff_t *ppos)
>  {
>         int rc;
> +       u64 val;
> +
> +       memset(einj_buf, 0, sizeof(einj_buf));
> +       if (copy_from_user(einj_buf, buf, count))
> +               return -EFAULT;
> +
> +       if (strncmp(einj_buf, "V2_", 3) =3D=3D 0) {
> +               if (!sscanf(einj_buf, "V2_%llx", &val))
> +                       return -EINVAL;
> +       } else {
> +               if (!sscanf(einj_buf, "%llx", &val))
> +                       return -EINVAL;
> +       }
>
>         rc =3D einj_validate_error_type(val);
>         if (rc)
> @@ -722,11 +767,13 @@ static int error_type_set(void *data, u64 val)
>
>         error_type =3D val;
>
> -       return 0;
> +       return count;
>  }
>
> -DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set=
,
> -                        "0x%llx\n");
> +static const struct file_operations error_type_fops =3D {
> +       .read           =3D error_type_get,
> +       .write          =3D error_type_set,
> +};
>
>  static int error_inject_set(void *data, u64 val)
>  {
> @@ -783,7 +830,7 @@ static int __init einj_probe(struct platform_device *=
pdev)
>                 goto err_put_table;
>         }
>
> -       rc =3D einj_get_available_error_type(&available_error_type);
> +       rc =3D einj_get_available_error_types(&available_error_type, &ava=
ilable_error_type_v2);
>         if (rc)
>                 return rc;
>
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index 78da9ae543a2..e70a416ec925 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file =
*m, void *v)
>         int cxl_err, rc;
>         u32 available_error_type =3D 0;
>
> -       rc =3D einj_get_available_error_type(&available_error_type);
> +       rc =3D einj_get_available_error_type(&available_error_type, ACPI_=
EINJ_GET_ERROR_TYPE);
>         if (rc)
>                 return rc;
>
> --
> 2.43.0
>

