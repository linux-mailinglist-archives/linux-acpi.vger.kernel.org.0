Return-Path: <linux-acpi+bounces-19944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBCCF1D95
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 06:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 680413000913
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 05:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787C32548B;
	Mon,  5 Jan 2026 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnm3+zyN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865B31B100
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589937; cv=none; b=U2FVTU8toeGAoOWmN26hvrvUZpgg3VZqVRN9vId/qZdE8iDbxUSNEG7F5exZNDXimnInc1Xmb3egRzuFZKB2NSHU+58gjEZIPshlHYlpmo1rDjiCkRC/iBM1Sas8AtTkfaj6u5E0yPle6+jq7BP/LG7fyQVPv8WVZ96sUU4jF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589937; c=relaxed/simple;
	bh=b1XYOKoe6FdPiivr9BeR/pLBi3nNEFeJH4uCGr2/+MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqJlieiGyCGtxK5cz5VfzFH+4cC99dmsY9CmPxUh3FijifvQBoko/dB1Bsa/o1fdY9AutqR8TkiVFWue7aYY16IfexCWwhbiwP77HC6lIml/04a4rKht3o2seob5sIlmnqHj54z8ws/Haoxd60kwdBrIGetH+q5lzGnImAUMZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnm3+zyN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324204so1966801466b.0
        for <linux-acpi@vger.kernel.org>; Sun, 04 Jan 2026 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767589934; x=1768194734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKlIxjUKVBjzIbRR+kt3GqxsEQVSOw8kgLFjzSzVRQM=;
        b=Dnm3+zyNc1I9CPnihG2BpOFP2+4VXoIngjL9y2V2mHAhz3JDXQc/Cd/F1JgqFoaZiZ
         LE5rQC5+DC1AAIz+zJLEhCTO6QgzOqlrSa3KCGVyBciafgwsGI2OFCckyTASP02ure+d
         +oDs06mFcDMFYoZcM0IP0TgHSfzYZoNXFdUMwHzDlTke3vRvp+pi0qm45ekPaR7olbtu
         qRv3Ct0kolxjafoFBD/vMfXNc/Adw2G6RHSgJvlH/a/wGwVjsaNE7OZab3sDVD4ABwoP
         Gi9+cbDeYCN/0x5CpZvwvz8JpQ3sWteAD2ZrOr6YvbbT8gpHF3ENoCoKjuz4Bm7uB7I+
         IFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589934; x=1768194734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKlIxjUKVBjzIbRR+kt3GqxsEQVSOw8kgLFjzSzVRQM=;
        b=a5U5iI3cTyZ3YXEpBpPRetOogp1MNcwf25+8jn68QcYuIHb/P+LS63PUiIe3AaM+eE
         //DlzcBKjUvNgVeCkMyzL+Ea6QE0UwI7wFX+8wibwUEsAW9in7ePXmDYXwaiStCBrhLb
         YWl+aKTNsZuCgssb3hiLDeYVEARiHKbhSr0B7uOUiDlnH/rZWr3/rYIp5Rp53IzaVdzw
         ZDMp+/6xkZpJTwaAOJQ86yBpu1NH3BRosjokFPbxEhp743rNBmOPj4gbTmRwuMlL0vFn
         yw3d6vbI3+/sG0+S9qZA9p42t6tI1f3FIgWuihafQzz9QGR2Emcwqs4hhP9uYuiDhzha
         OaKw==
X-Forwarded-Encrypted: i=1; AJvYcCWpcpLx1uZXWh402pdEOMxo1itPh2SHZ6uAZeVWJv2PTJZKQO5U9ac79udaDFDR+lHZrUubsafYuk5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNcGeRKQzPrPlC6IIZCCAaTZGJAzjpEZIBL8O7sCvLduqWmhk
	V+4+Ag4KA+7gF9B9/8I7/SobbBOE9zzq4SMACsY7eZY810r2SzPod1J668tfqZNIclUYVSrRe1q
	qpi8cgq+tOy5ObOpIc9UjnMgf52jav+8=
X-Gm-Gg: AY/fxX7h0RB/lLnWO+opjASb0v1qjSNmHwHPp3dIatp5biPMQEJuIAxj9K54rLvklCS
	t37QHF/oL10tPlPhOJCUEu4cHa83gYUiwGYYKnD8UGJEfw4bjJSGcOAwmH6btMArnWAJMN46RAJ
	7aqRuIgCLIe9VxzDbxTzOojXi2TVOvk5zGdiBgOGC/79h+BC2shui1MXVpMwm8lHBGL0RuE608l
	2DdmkNCoCl2EqgyY4zBtlk1nyqQ2o0bdYMHrYF9CQq4AJJPy1qWkdUh1YP7tI5xkgeiCC0g
X-Google-Smtp-Source: AGHT+IGB4d/jWdDUapgkYpYYhKPPJkcZEL4rgCwoWKuIF7DFQAYZz95Lgha44r5qxoZEoVPs8gUEeAAIf2GLongEolg=
X-Received: by 2002:a17:906:dc90:b0:b73:21af:99d4 with SMTP id
 a640c23a62f3a-b8036f96725mr4610529266b.24.1767589933376; Sun, 04 Jan 2026
 21:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com> <20260104120405.51555-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20260104120405.51555-3-xueshuai@linux.alibaba.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 5 Jan 2026 13:12:01 +0800
X-Gm-Features: AQt7F2pe0mjRLFTmRBz2CJZnfV8XA7A9ejtEdpZcTvSEpCrHLPNlc_fwRrERjPA
Message-ID: <CAErzpmvQqv6S-XkTf46bzTRQuv3h1LGXFixX-D_bCho-bD+upg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: APEI: GHES: Extract helper functions for
 error status handling
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org, 
	yazen.ghannam@amd.com, dave.jiang@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, leitao@debian.org, 
	pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com, 
	benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com, 
	james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 8:05=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.co=
m> wrote:
>
> Refactors the GHES driver by extracting common functionality into
> reusable helper functions:
>
> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>    have active errors
> 2. ghes_map_error_status() - Maps error status address to virtual address
> 3. ghes_unmap_error_status() - Unmaps error status virtual address
>
> These helpers eliminate code duplication in the NMI path and prepare for
> similar usage in the SEA path in a subsequent patch.
>
> No functional change intended.
>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 93 +++++++++++++++++++++++++++++++---------
>  1 file changed, 72 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0e97d50b0240..7600063fe263 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1406,6 +1406,75 @@ static int ghes_in_nmi_spool_from_list(struct list=
_head *rcu_list,
>         return ret;
>  }
>
> +/**
> + * ghes_has_active_errors - Check if there are active errors in error so=
urces
> + * @ghes_list: List of GHES entries to check for active errors
> + *
> + * This function iterates through all GHES entries in the given list and
> + * checks if any of them has active error status by reading the error
> + * status register.
> + *
> + * Return: true if at least one source has active error, false otherwise=
.
> + */
> +static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes=
_list)
> +{
> +       bool active_error =3D false;
> +       struct ghes *ghes;
> +
> +       rcu_read_lock();

Nit: Use `guard(rcu)()` instead of explicit
`rcu_read_lock()`/`rcu_read_unlock()`.

Thanks,
Donglin

> +       list_for_each_entry_rcu(ghes, ghes_list, list) {
> +               if (ghes->error_status_vaddr &&
> +                   readl(ghes->error_status_vaddr)) {
> +                       active_error =3D true;
> +                       break;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return active_error;
> +}
> +
> +/**
> + * ghes_map_error_status - Map error status address to virtual address
> + * @ghes: pointer to GHES structure
> + *
> + * Reads the error status address from ACPI HEST table and maps it to a =
virtual
> + * address that can be accessed by the kernel.
> + *
> + * Return: 0 on success, error code on failure.
> + */
> +static int __maybe_unused ghes_map_error_status(struct ghes *ghes)
> +{
> +       struct acpi_hest_generic *g =3D ghes->generic;
> +       u64 paddr;
> +       int rc;
> +
> +       rc =3D apei_read(&paddr, &g->error_status_address);
> +       if (rc)
> +               return rc;
> +
> +       ghes->error_status_vaddr =3D
> +               acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status=
));
> +       if (!ghes->error_status_vaddr)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/**
> + * ghes_unmap_error_status - Unmap error status virtual address
> + * @ghes: pointer to GHES structure
> + *
> + * Unmaps the error status address if it was previously mapped.
> + */
> +static void __maybe_unused ghes_unmap_error_status(struct ghes *ghes)
> +{
> +       if (ghes->error_status_vaddr) {
> +               iounmap(ghes->error_status_vaddr);
> +               ghes->error_status_vaddr =3D NULL;
> +       }
> +}
> +
>  #ifdef CONFIG_ACPI_APEI_SEA
>  static LIST_HEAD(ghes_sea);
>
> @@ -1456,20 +1525,9 @@ static LIST_HEAD(ghes_nmi);
>  static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  {
>         static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
> -       bool active_error =3D false;
>         int ret =3D NMI_DONE;
> -       struct ghes *ghes;
> -
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
> -               if (ghes->error_status_vaddr && readl(ghes->error_status_=
vaddr)) {
> -                       active_error =3D true;
> -                       break;
> -               }
> -       }
> -       rcu_read_unlock();
>
> -       if (!active_error)
> +       if (!ghes_has_active_errors(&ghes_nmi))
>                 return ret;
>
>         if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> @@ -1486,18 +1544,12 @@ static int ghes_notify_nmi(unsigned int cmd, stru=
ct pt_regs *regs)
>
>  static int ghes_nmi_add(struct ghes *ghes)
>  {
> -       struct acpi_hest_generic *g =3D ghes->generic;
> -       u64 paddr;
>         int rc;
>
> -       rc =3D apei_read(&paddr, &g->error_status_address);
> +       rc =3D ghes_map_error_status(ghes);
>         if (rc)
>                 return rc;
>
> -       ghes->error_status_vaddr =3D acpi_os_ioremap(paddr, sizeof(ghes->=
estatus->block_status));
> -       if (!ghes->error_status_vaddr)
> -               return -EINVAL;
> -
>         mutex_lock(&ghes_list_mutex);
>         if (list_empty(&ghes_nmi))
>                 register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes=
");
> @@ -1515,8 +1567,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
>                 unregister_nmi_handler(NMI_LOCAL, "ghes");
>         mutex_unlock(&ghes_list_mutex);
>
> -       if (ghes->error_status_vaddr)
> -               iounmap(ghes->error_status_vaddr);
> +       ghes_unmap_error_status(ghes);
>
>         /*
>          * To synchronize with NMI handler, ghes can only be
> --
> 2.39.3
>
>

