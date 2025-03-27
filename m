Return-Path: <linux-acpi+bounces-12498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65CA7322D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7556E179AE6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205C2135BB;
	Thu, 27 Mar 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iou1iE/b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EC4A21;
	Thu, 27 Mar 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743078443; cv=none; b=CC4ctFe5opelZ/kI8UnL/jqUImdHQ00rpeHPZ7ZPUxgGmdCgaZSio18J5UYxSnd7P892+TmdZBiMZ0Iol9MZzhLNp6AWRJk3gzsFrisJrOC3DG4G54aEXbJ9lMKe3ypdzaB/TkE+pVHze2dO+fmx3XPXoKFXKRNm5Yr4un3ibwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743078443; c=relaxed/simple;
	bh=OZ9rxuB4x3RLHW1CmVctbF2LvRnGDEszRtrPpN0vxws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKgjTaEZhhZ8GZwBHpxCHs7UC7n8w1HV81MpI2LzNJu5zmEW43AuPOZyEa0Z6x7kDSKqdFIa+kB+SH4aWQ/maVFuEiwieNtlKOIzmjYpca6LoB3UZ7/uHU2LD85UcELFEKfZWzO0OZsjHV9qp7T6mGeT7kLjVLFcVKdYtQlfVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iou1iE/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BEDC4CEED;
	Thu, 27 Mar 2025 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743078442;
	bh=OZ9rxuB4x3RLHW1CmVctbF2LvRnGDEszRtrPpN0vxws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iou1iE/bPbfeA3lW+MIuEHbqxl0k5ya4Ud2B/EhKMxjVG9ACdeVgoKbok+fN+VjPL
	 jSxAStWcS3TIcYnmg/9UyCkpY6yp4MoQt2VZKhnkrjRPnTXtA994X0okza+l423QB+
	 WZxB0E5ITW3PucK4r1qBZ8WxeROpNC/oMQqUzHgxhr1Az5UElc8uRpnHYroY51rX17
	 SHgKJP3+HPMoAHmXWA6+mbPB1ltyiu3wYuqugWLx9GMOlVK5Ra7KgiU+0a6+T//Ya8
	 iC2LF5ZR2OtXFUoh2ymZbSTRTLMOeRiIwKTuxjXkzcUq3lHe/ULNLmnlCmKMRQ52JX
	 bpdqfMeuZgW6A==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c47631b4cso615481a34.1;
        Thu, 27 Mar 2025 05:27:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHxut51j/N2eGdx8mLRjMvHD3v0BgoK/T18WWLlpDDS215iUXvrcD8aNuNmPRaSVus+J28q/9+VqT1fHzY@vger.kernel.org, AJvYcCWSmeOZEfXGysMMHt4jOukmt2BALWBh3qDGURUrht1eVMyUGl/peBHv9V+PS3k4kJNY8MF9V/XcktVX@vger.kernel.org
X-Gm-Message-State: AOJu0YynXNTLMrDFKrjYRNqsIPiEmXEgy+VWFSyvETOPot9SwyOgMVFv
	C60qYmGZnycGU1Z1QlWDkWosP7mdqu7qhcleFoamsy3cuUneSJxR/sDc+Vvvfu21WSN3IOrR2aj
	ho2y48sknWQVM/5jepW2w5VcY/Io=
X-Google-Smtp-Source: AGHT+IGIkTVovUnoJyFCBcf9YL5b2f7eJbB4jNMWymYAiKRjebHIL3Isk0MHar34rZllQRKtHvVNKqyLeFyUX4UragM=
X-Received: by 2002:a05:6870:a114:b0:29e:499d:1d33 with SMTP id
 586e51a60fabf-2c847fac409mr1868685fac.14.1743078441573; Thu, 27 Mar 2025
 05:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311114300.497657-1-thorsten.blum@linux.dev>
In-Reply-To: <20250311114300.497657-1-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 13:27:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=6Aa1oqkxEt1LOaF+YUuaB9i3jjy6RqhEfPm-3PVWyw@mail.gmail.com>
X-Gm-Features: AQ5f1JrowVhWd7ISGjyosoVgVwxWXqes8r2d8n6WkOLXGfyykgmxh27Wof8W3Ns
Message-ID: <CAJZ5v0h=6Aa1oqkxEt1LOaF+YUuaB9i3jjy6RqhEfPm-3PVWyw@mail.gmail.com>
Subject: Re: [RESEND PATCH] ACPI: NUMA: Use str_enabled_disabled() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Alison Schofield <alison.schofield@intel.com>, Robert Richter <rrichter@amd.com>, 
	Bruno Faccini <bfaccini@nvidia.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:43=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
>
> Acked-by: Bruno Faccini <bfaccini@nvidia.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/acpi/numa/srat.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..ac7045f3b85b 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -18,6 +18,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
>  #include <linux/numa_memblks.h>
> +#include <linux/string_choices.h>
>
>  static nodemask_t nodes_found_map =3D NODE_MASK_NONE;
>
> @@ -187,8 +188,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                         pr_debug("SRAT Processor (id[0x%02x] eid[0x%02x])=
 in proximity domain %d %s\n",
>                                  p->apic_id, p->local_sapic_eid,
>                                  p->proximity_domain_lo,
> -                                (p->flags & ACPI_SRAT_CPU_ENABLED) ?
> -                                "enabled" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_CPU_ENABLED));
>                 }
>                 break;
>
> @@ -200,8 +200,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                                  (unsigned long long)p->base_address,
>                                  (unsigned long long)p->length,
>                                  p->proximity_domain,
> -                                (p->flags & ACPI_SRAT_MEM_ENABLED) ?
> -                                "enabled" : "disabled",
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_MEM_ENABLED),
>                                  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)=
 ?
>                                  " hot-pluggable" : "",
>                                  (p->flags & ACPI_SRAT_MEM_NON_VOLATILE) =
?
> @@ -216,8 +215,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                         pr_debug("SRAT Processor (x2apicid[0x%08x]) in pr=
oximity domain %d %s\n",
>                                  p->apic_id,
>                                  p->proximity_domain,
> -                                (p->flags & ACPI_SRAT_CPU_ENABLED) ?
> -                                "enabled" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_CPU_ENABLED));
>                 }
>                 break;
>
> @@ -228,8 +226,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                         pr_debug("SRAT Processor (acpi id[0x%04x]) in pro=
ximity domain %d %s\n",
>                                  p->acpi_processor_uid,
>                                  p->proximity_domain,
> -                                (p->flags & ACPI_SRAT_GICC_ENABLED) ?
> -                                "enabled" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_GICC_ENABLED));
>                 }
>                 break;
>
> @@ -247,8 +244,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                                  *(u16 *)(&p->device_handle[0]),
>                                  *(u16 *)(&p->device_handle[2]),
>                                  p->proximity_domain,
> -                                (p->flags & ACPI_SRAT_GENERIC_AFFINITY_E=
NABLED) ?
> -                               "enabled" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_GENERIC_AFFINITY_ENABLED));
>                 } else {
>                         /*
>                          * In this case we can rely on the device having =
a
> @@ -258,8 +254,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                                 (char *)(&p->device_handle[0]),
>                                 (char *)(&p->device_handle[8]),
>                                 p->proximity_domain,
> -                               (p->flags & ACPI_SRAT_GENERIC_AFFINITY_EN=
ABLED) ?
> -                               "enabled" : "disabled");
> +                               str_enabled_disabled(p->flags & ACPI_SRAT=
_GENERIC_AFFINITY_ENABLED));
>                 }
>         }
>         break;
> @@ -271,8 +266,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_head=
er *header)
>                         pr_debug("SRAT Processor (acpi id[0x%04x]) in pro=
ximity domain %d %s\n",
>                                  p->acpi_processor_uid,
>                                  p->proximity_domain,
> -                                (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
> -                                "enabled" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_SRA=
T_RINTC_ENABLED));
>                 }
>                 break;
>
> --

Applied as 6.15-rc material, thanks!

