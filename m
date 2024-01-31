Return-Path: <linux-acpi+bounces-3117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1D7843EE0
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 12:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B7B285160
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 11:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC3762E0;
	Wed, 31 Jan 2024 11:54:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7A762DC
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702073; cv=none; b=jT8Md30imJHMkk+lCKDnyeipNpgqoGg8AY9ae31aIzQBSTjSWhJB6xwcY19Wxq8z7BRzWqMGEnFd39UIqrNfrHMivhyuVtBC4egN6kHq9eY/sbsUtYecEgE7S60OVuFae92aukiziMzh67dF167MD8RcONeEAv9ixXJVp9JmgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702073; c=relaxed/simple;
	bh=e/UscuKZTOiMuRJCyvxigjJsP+9x9mdyejgJTx+Cbho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U75mKbVhyMdXC1pKud0xuOaWJTX5nsW7o+5xGRVGp8tBix/oBTeiFp8bOl8lrMSLoeMKt83byIc5uf9oiI4gz9KDoKTAby2lWVanTWu8YDQNHoeMBXAvsnLRzJK8WxpdyPWvbtSUlQNsWhK+4FHhgo1Nv1XtrIdxJI/16uhP+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a1f85923aso365257eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 03:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706702071; x=1707306871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQYbszXiVtbeNentNuy5/IaxGfWuDrK8hPRCB418EpI=;
        b=lvoer2JLVT6IPaKxRJZomyQ+9wUFSvMjF5ppQkBlGiK8oFQnA6z0IHkqXp7wYxARou
         ApEO0V6byQr2lBzd3RJg3xBS59pY/rzWfe5I8wtVcDoty0r/pFRKgFdu4wMgUKn8Q5Ul
         uoLDXrKcKa6NNNTDsbavuvZw8ZUUcFeHpX86BExHBuzjhfBn1Eg1qmGTlJz8PZDG0Vxw
         Hig5tF1l0DhOysswesB2Rtii/DaxxBfN7Cs9xmmFFiDb9SQJTElnL3/D38JqvKNQyGct
         oN2oj0XHjjYSkTKGd+YmVTFW/BU0qJdyO47+zSqFdgkknzxSjIaf05N8wxvJ4u3JEir4
         CRbQ==
X-Forwarded-Encrypted: i=0; AJvYcCWdy07keyRWq0ivCSGsAXJbQSfRzseDUx4A3rXqP95mm/PyWkKRxI6Khk1tIkB+02xrXyBPgGQzIcTGwXZGYACN6SBTEiuPMrDR2Q==
X-Gm-Message-State: AOJu0YxNba4E4BPIPz8Rjw8uJGTpab9qEO2um2Hd4+vghVlidiTyqigB
	cDqJCNNYikcY1zeCobmayBcYmZ9sWaWm3Y+urf95VvwdnMgcB12lbxa3ntOc8sTwa2sb+XdSZFP
	4xar9/YYLYFgoXbvjxkmVyhmy76w+smfJ
X-Google-Smtp-Source: AGHT+IEYQRx4ACAj4H/Ee7aaapS2spOCP45jZ2AOgL/3umRcDOd3blPhZC8uMnT/7j+4tIuvkANrOT1wmMcZG3doG6E=
X-Received: by 2002:a05:6820:139:b0:599:9e03:68da with SMTP id
 i25-20020a056820013900b005999e0368damr1293193ood.0.1706702071046; Wed, 31 Jan
 2024 03:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 12:54:18 +0100
Message-ID: <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
To: Dan Williams <dan.j.williams@intel.com>
Cc: rafael@kernel.org, Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:30=E2=80=AFAM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> The HMAT messages printed at boot, beyond being noisy, can also print
> details for nodes that are not yet enabled. The primary method to
> consume HMAT details is via sysfs, and the sysfs interface gates what is
> emitted by whether the node is online or not. Hide the messages by
> default by moving them from "info" to "debug" log level.
>
> Otherwise, these prints are just a pretty-print way to dump the ACPI
> HMAT table. It has always been the case that post-analysis was required
> for these messages to map proximity-domains to Linux NUMA nodes, and as
> Priya points out that analysis also needs to consider whether the
> proximity domain is marked "enabled" in the SRAT.
>
> Reported-by: Priya Autee <priya.v.autee@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/hmat.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d6b85f0f6082..5331abc7c956 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -409,9 +409,9 @@ static __init int hmat_parse_locality(union acpi_subt=
able_headers *header,
>                 return -EINVAL;
>         }
>
> -       pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target=
 Domains:%u Base:%lld\n",
> -               hmat_loc->flags, hmat_data_type(type), ipds, tpds,
> -               hmat_loc->entry_base_unit);
> +       pr_debug("Locality: Flags:%02x Type:%s Initiator Domains:%u Targe=
t Domains:%u Base:%lld\n",
> +                hmat_loc->flags, hmat_data_type(type), ipds, tpds,
> +                hmat_loc->entry_base_unit);
>
>         inits =3D (u32 *)(hmat_loc + 1);
>         targs =3D inits + ipds;
> @@ -422,9 +422,9 @@ static __init int hmat_parse_locality(union acpi_subt=
able_headers *header,
>                         value =3D hmat_normalize(entries[init * tpds + ta=
rg],
>                                                hmat_loc->entry_base_unit,
>                                                type);
> -                       pr_info("  Initiator-Target[%u-%u]:%u%s\n",
> -                               inits[init], targs[targ], value,
> -                               hmat_data_type_suffix(type));
> +                       pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
> +                                inits[init], targs[targ], value,
> +                                hmat_data_type_suffix(type));
>
>                         hmat_update_target(targs[targ], inits[init],
>                                            mem_hier, type, value);
> @@ -452,9 +452,9 @@ static __init int hmat_parse_cache(union acpi_subtabl=
e_headers *header,
>         }
>
>         attrs =3D cache->cache_attributes;
> -       pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\=
n",
> -               cache->memory_PD, cache->cache_size, attrs,
> -               cache->number_of_SMBIOShandles);
> +       pr_debug("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d=
\n",
> +                cache->memory_PD, cache->cache_size, attrs,
> +                cache->number_of_SMBIOShandles);
>
>         target =3D find_mem_target(cache->memory_PD);
>         if (!target)
> @@ -513,9 +513,9 @@ static int __init hmat_parse_proximity_domain(union a=
cpi_subtable_headers *heade
>         }
>
>         if (hmat_revision =3D=3D 1)
> -               pr_info("Memory (%#llx length %#llx) Flags:%04x Processor=
 Domain:%u Memory Domain:%u\n",
> -                       p->reserved3, p->reserved4, p->flags, p->processo=
r_PD,
> -                       p->memory_PD);
> +               pr_debug("Memory (%#llx length %#llx) Flags:%04x Processo=
r Domain:%u Memory Domain:%u\n",
> +                        p->reserved3, p->reserved4, p->flags, p->process=
or_PD,
> +                        p->memory_PD);
>         else
>                 pr_info("Memory Flags:%04x Processor Domain:%u Memory Dom=
ain:%u\n",
>                         p->flags, p->processor_PD, p->memory_PD);
>

