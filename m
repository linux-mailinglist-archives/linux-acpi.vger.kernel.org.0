Return-Path: <linux-acpi+bounces-15043-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BBAFB88E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11FE4A0EE9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD91218AAF;
	Mon,  7 Jul 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALcttH4c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED61FDA89;
	Mon,  7 Jul 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905481; cv=none; b=GppcnZnfEhkmM984bwdZsX0Il3CsjUYboGDKCN8kgG42cHRTPtD9h+0v5brH6ef9Js6yYPgLouAdBUikFa/7fS2KuDddCYbZrSNu30V1HHDqm5QOWlTnuadf6KYPaER1Xdp1DHPpzVF2GkTF8GVXGVILhJxvoUlw+eleK7lLjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905481; c=relaxed/simple;
	bh=OpmyrXOuF4jR4bZNera3upeRfyWBtD4Q83PmUjU3BNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHf31wcw4w8dpuFodTB7RBGdo4ZxXmDMMqd9IM/9P5DYFk+Te/pzT9C7vP3ajdThAgYEkk8/LF1K6eEHF2tTVYzHunUYfGbYnbBy/4TEAhlgeqsPV/r5WxhTWol4A1eEuWTZBOScxzHcUc5JN6wsSxXpl+V7boVes17F6QmB3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALcttH4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593CFC4CEFE;
	Mon,  7 Jul 2025 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751905480;
	bh=OpmyrXOuF4jR4bZNera3upeRfyWBtD4Q83PmUjU3BNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ALcttH4cG9A2K1BBkm8ys8YUSE47jLbp5os6hgEYlhBdrWhO9VFLkz7ce1HKi94Ca
	 OrduFoIT5H7oPgJQwiRU4A1E5+PUfVEfRMhZOTTtp6PS76cnc/H2henSD6CaR7SQQf
	 qLP7fW+iUrbKgJTZoV7SUrxb5WhaVEcQ7ZKSCKrEBkrXaY58It7tOaoEok5AMbT8T5
	 sq2h+7UphZcmo1J7ZfEqettB7kuAzedYDoC8+AKnIUZhFRXQiHKkBvR4VTrf+rg3Xo
	 jHrWsGmguqdlJWzHAeWB89gkAhnxV4G8HXfJ38Fa1mYBgft+7II1l3j5rT2plnUaOF
	 CK6Fu3hcKlKBA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-611b246727cso1727951eaf.0;
        Mon, 07 Jul 2025 09:24:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2dUAsXg664J8tOcqwFwKGHUUm53MvHgyTAhwvbNX7YXujqRK2y3WtYiKYqqPFY5R9+bUF5pfksknw7QLC@vger.kernel.org, AJvYcCUa0okTO+ofbZXbzAMG97i5vSWXuYTkohLOxGrp9RR2muGM5mgLCnJSN7DaHzR8xWbHo2hnMCZ7yRs0@vger.kernel.org, AJvYcCV2pUgLcuF1cAki/AExxgZW/iOY8BgHOXhBSt9UrXZxx7Ft7DW4lj+4J9Xd1TZLii8BSTYRGokf3prHCnPBWepf@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2Dvye16HbAl+haB2B9e7eqzHWQidGqcwepL4vFso5vBZbaTN
	DDlSU50uh8dx6HbaDzwPUIW1SAHYOpKwqgoMHb08eN2orJZl0eCfaBXkBgDXB8ZZ0X179DQgUcl
	/ifJJrE52a8VfBU0eiylOvBb1P2xD/Ls=
X-Google-Smtp-Source: AGHT+IFIZ8qOs8Pm/+IV5MuhnNkBENBQdeA61oaUw7+T17KFde9U9DvX8b/3cdiugQtl6zk43g7gUEblenbbZYlrgKY=
X-Received: by 2002:a05:6820:1792:b0:612:c547:7984 with SMTP id
 006d021491bc7-613928f68f4mr8474137eaf.1.1751905479504; Mon, 07 Jul 2025
 09:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617193026.637510-2-zaidal@os.amperecomputing.com> <20250703200421.28012-1-tony.luck@intel.com>
In-Reply-To: <20250703200421.28012-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:24:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4seRkBsgPXj+rJCmJ6k4NgRM5gMGNyi9c1coJ6axmhA@mail.gmail.com>
X-Gm-Features: Ac12FXz3c7AVNX0dMtWvIOJ6ZrTzqnZyWNlOeY507TwiCsLOS7rxt5uADmk3-Ao
Message-ID: <CAJZ5v0h4seRkBsgPXj+rJCmJ6k4NgRM5gMGNyi9c1coJ6axmhA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix trigger actions
To: Tony Luck <tony.luck@intel.com>
Cc: zaidal@os.amperecomputing.com, Jonathan.Cameron@huawei.com, 
	benjamin.cheatham@amd.com, bp@alien8.de, dan.carpenter@linaro.org, 
	dan.j.williams@intel.com, dave.jiang@intel.com, gregkh@linuxfoundation.org, 
	gustavoars@kernel.org, ira.weiny@intel.com, james.morse@arm.com, 
	jonathanh@nvidia.com, kees@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, rafael@kernel.org, 
	sthanneeru.opensrc@micron.com, sudeep.holla@arm.com, viro@zeniv.linux.org.uk, 
	Yi1 Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 10:05=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> The trigger events are in BIOS memory immediately following the
> acpi_einj_trigger structure. These were not copied to regular
> kernel memory for use by apei_exec_ctx_init() so injections in
> "notrigger=3D0" mode failed with a message like this:
>
>   APEI: Invalid action table, unknown instruction type: 123
>
> Fix by allocating a "table_size" block of memory and copying the whole
> table for use in the rest of the trigger flow.
>
> Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
> Reported-by: Yi1 Lai <yi1.lai@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/einj-core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 3d37978418e8..bf8dc92a373a 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -394,6 +394,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>                                 u64 param1, u64 param2)
>  {
>         struct acpi_einj_trigger trigger_tab;
> +       struct acpi_einj_trigger *full_trigger_tab;
>         struct apei_exec_context trigger_ctx;
>         struct apei_resources trigger_resources;
>         struct acpi_whea_header *trigger_entry;
> @@ -430,6 +431,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>
>         rc =3D -EIO;
>         table_size =3D trigger_tab.table_size;
> +       full_trigger_tab =3D kmalloc(table_size, GFP_KERNEL);
> +       if (!full_trigger_tab)
> +               goto out_rel_header;
>         r =3D request_mem_region(trigger_paddr + sizeof(trigger_tab),
>                                table_size - sizeof(trigger_tab),
>                                "APEI EINJ Trigger Table");
> @@ -437,7 +441,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>                 pr_err("Can not request [mem %#010llx-%#010llx] for Trigg=
er Table Entry\n",
>                        (unsigned long long)trigger_paddr + sizeof(trigger=
_tab),
>                        (unsigned long long)trigger_paddr + table_size - 1=
);
> -               goto out_rel_header;
> +               goto out_free_trigger_tab;
>         }
>         iounmap(p);
>         p =3D ioremap_cache(trigger_paddr, table_size);
> @@ -445,9 +449,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>                 pr_err("Failed to map trigger table!\n");
>                 goto out_rel_entry;
>         }
> -       memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
> +       memcpy_fromio(full_trigger_tab, p, table_size);
>         trigger_entry =3D (struct acpi_whea_header *)
> -               ((char *)&trigger_tab + sizeof(struct acpi_einj_trigger))=
;
> +               ((char *)full_trigger_tab + sizeof(struct acpi_einj_trigg=
er));
>         apei_resources_init(&trigger_resources);
>         apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
>                            ARRAY_SIZE(einj_ins_type),
> @@ -469,7 +473,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>
>                 apei_resources_init(&addr_resources);
>                 trigger_param_region =3D einj_get_trigger_parameter_regio=
n(
> -                       &trigger_tab, param1, param2);
> +                       full_trigger_tab, param1, param2);
>                 if (trigger_param_region) {
>                         rc =3D apei_resources_add(&addr_resources,
>                                 trigger_param_region->address,
> @@ -500,6 +504,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>  out_rel_entry:
>         release_mem_region(trigger_paddr + sizeof(trigger_tab),
>                            table_size - sizeof(trigger_tab));
> +out_free_trigger_tab:
> +       kfree(full_trigger_tab);
>  out_rel_header:
>         release_mem_region(trigger_paddr, sizeof(trigger_tab));
>  out:
> --

Applied, thanks!

