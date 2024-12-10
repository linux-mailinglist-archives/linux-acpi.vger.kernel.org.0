Return-Path: <linux-acpi+bounces-10026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277D9EB428
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9248E18885AE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5571B3F30;
	Tue, 10 Dec 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MB+i4OiZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE51B0F2C
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842792; cv=none; b=OKenEgbt+mzmAhjqwkPAEMjCAZK6HdyzwlRgTynkVJXBL9Pw7FWmN9m0iuaK9BzOKJybdEdz2ezYPLwaZih/mT9qkzzxEllO9DQgoXXo3MqrmD9Jz5IecuVp7QTrzdeJ7uAAGQqvXQdj4+/LwTEBvg4LIqLJa+QeCNHwem/Lv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842792; c=relaxed/simple;
	bh=shPyI2dySTMutp1ANP3EGvaVLrk95ZBKYUsanzim5Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOBw/PQnSe4za2yfyy/Q6Fkbf2lTmG+fOKvc5cMZrE0ULsgsPsRm2K1FFbh7J1mDRgoe8bDtENRLT/VPXdApxyKiFWDGo2vv8Of12n5DeZ+ThK71uom0ojP1RNZ9ZD7dA+OhDiHnOx9KbrMHZCMnQScicAO4Tq/9iaruI2zPyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MB+i4OiZ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso118825ab.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733842790; x=1734447590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpDnUVi0ep8YRkyvnKylzOSzQ7B19aMh70gDsd17VKM=;
        b=MB+i4OiZ+/LiKaSgXuDfjteWMaeY+GaNzRMtf9QoQtXo+zyL8RjFG+jolqBjER0Wnh
         H8MxKxLZo23RfU2DSv9Iz/QTtZyzbwwXf/F8wZoZxboIIJZKCds4YXVhNVIUw6sjXUJ/
         BbbzK0hMyafKUgoxjCaZCyx/c4vPXVhJVjhbHrHBeEXDMSAD1921qlgaMxBd6yOdD10k
         GpYNO1i3lBbANtsr/zD4Wt25/JKJ5LCFbtBbUfR5dEhgd+uRLkyyOU7L0chrbPC52Wye
         /TsFGJOXfqgdwk8VGnsTW48U+BqBpMSBq6ofdthqfYpx1tXQjsTr8xut8YVagBwRUiFL
         vXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842790; x=1734447590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpDnUVi0ep8YRkyvnKylzOSzQ7B19aMh70gDsd17VKM=;
        b=efQdDMibEiVtnOzWhg5Dsz7KzKY43y1Xihpv1NaBTKVwmAPF/h+6zp/gK8yeSE/eLN
         lLrUEbRpRDJKPC6NmP5sxdo4yG3XtPZGAkjUG3c62AsBXZakswtCu4umDRsVu2yn7VSR
         7yuGLLgl0T8ZNSAx0HhlZPXK9vMWGQ8zI6iO8ajPLBUkxHMncZYWx0wqKE/8prMWy/8V
         0AbF4WC3auXGGsTgocDkLCB5ym7nI8pJ3aIfcKTaPbk/Pv7ePAyR2SElJoemsEA8qxl3
         nHCPeAU36vLPgXi/mazmDtrMr10BzV5CuNnR4HC8dWhY8hE9QxEWba0HmYi5fjUXUVX6
         Qeaw==
X-Forwarded-Encrypted: i=1; AJvYcCXkVcUtoAgaZdTHpf0PmIkYz9rhT0J4zVvXahmt9/h2naecXpfXBYIk3imbe2+p4hu1DSgc0/ka+8hS@vger.kernel.org
X-Gm-Message-State: AOJu0YykU+eDh/1BlAphl0MvVK614Va1rdp40gWyEdVQKYSmnhNMepVD
	880LWRHPnjEDDJeRTvuDmAvFOvBA4ONxRch1xru0XDvR1ZF0ahPNhGgrnRCAHax91U4zYGlejHF
	UjHyaaWTv1/HCU39CByrTQB59yLUtpX0S+cLc
X-Gm-Gg: ASbGncsa7MbPwTIObyTjfG4Fx/mI3ZzLpQ4GkrKffNE2H7h1Ps2qA5sTs1y7M3vcIhp
	wJ6yLZllijg9aFoOWe928zkWa8unGnFjxcg==
X-Google-Smtp-Source: AGHT+IGPpczO1OTll30ttPkCvNvahDxxrTH8u5MAveOnjYrxQ1Ncel+PQfF4kviCb27+mPyb7cfYx2jUVqKLO5pT82s=
X-Received: by 2002:a05:6e02:3f86:b0:3a7:ab4c:115b with SMTP id
 e9e14a558f8ab-3a9dda4cca0mr3548625ab.10.1733842790104; Tue, 10 Dec 2024
 06:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022001712.9218-1-rui.zhang@intel.com>
In-Reply-To: <20241022001712.9218-1-rui.zhang@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 10 Dec 2024 06:59:39 -0800
Message-ID: <CALMp9eRfairiqHrRj_Woc4udd6toFpv+nxFVtVWBUarcHyhrXQ@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:17=E2=80=AFPM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> On some systems, the same CPU (with the same APIC ID) is assigned a
> different logical CPU id after commit ec9aedb2aa1a ("x86/acpi: Ignore
> invalid x2APIC entries").
>
> This means that Linux enumerates the CPUs in a different order, which
> violates ACPI specification[1] that states:
>
>   "OSPM should initialize processors in the order that they appear in
>    the MADT"
>
> The problematic commit parses all LAPIC entries before any x2APIC
> entries, aiming to ignore x2APIC entries with APIC ID < 255 when valid
> LAPIC entries exist. However, it disrupts the CPU enumeration order on
> systems where x2APIC entries precede LAPIC entries in the MADT.
>
> Fix the problem by separately checking LAPIC entries before parsing any
> LAPIC or x2APIC entries.
>
> 1. https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.htm=
l#madt-processor-local-apic-sapic-structure-entry-order
>
> Cc: stable@vger.kernel.org
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@goog=
le.com/
> Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Tested-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 50 +++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 4efecac49863..c70b86f1f295 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -226,6 +226,28 @@ acpi_parse_x2apic(union acpi_subtable_headers *heade=
r, const unsigned long end)
>         return 0;
>  }
>
> +static int __init
> +acpi_check_lapic(union acpi_subtable_headers *header, const unsigned lon=
g end)
> +{
> +       struct acpi_madt_local_apic *processor =3D NULL;
> +
> +       processor =3D (struct acpi_madt_local_apic *)header;
> +
> +       if (BAD_MADT_ENTRY(processor, end))
> +               return -EINVAL;
> +
> +       /* Ignore invalid ID */
> +       if (processor->id =3D=3D 0xff)
> +               return 0;
> +
> +       /* Ignore processors that can not be onlined */
> +       if (!acpi_is_processor_usable(processor->lapic_flags))
> +               return 0;
> +
> +       has_lapic_cpus =3D true;
> +       return 0;
> +}
> +
>  static int __init
>  acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned lo=
ng end)
>  {
> @@ -257,7 +279,6 @@ acpi_parse_lapic(union acpi_subtable_headers * header=
, const unsigned long end)
>                                processor->processor_id, /* ACPI ID */
>                                processor->lapic_flags & ACPI_MADT_ENABLED=
);
>
> -       has_lapic_cpus =3D true;
>         return 0;
>  }
>
> @@ -1029,6 +1050,8 @@ static int __init early_acpi_parse_madt_lapic_addr_=
ovr(void)
>  static int __init acpi_parse_madt_lapic_entries(void)
>  {
>         int count, x2count =3D 0;
> +       struct acpi_subtable_proc madt_proc[2];
> +       int ret;
>
>         if (!boot_cpu_has(X86_FEATURE_APIC))
>                 return -ENODEV;
> @@ -1037,10 +1060,27 @@ static int __init acpi_parse_madt_lapic_entries(v=
oid)
>                                       acpi_parse_sapic, MAX_LOCAL_APIC);
>
>         if (!count) {
> -               count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC=
,
> -                                       acpi_parse_lapic, MAX_LOCAL_APIC)=
;
> -               x2count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2=
APIC,
> -                                       acpi_parse_x2apic, MAX_LOCAL_APIC=
);
> +               /* Check if there are valid LAPIC entries */
> +               acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC, acpi_che=
ck_lapic, MAX_LOCAL_APIC);
> +
> +               /*
> +                * Enumerate the APIC IDs in the order that they appear i=
n the
> +                * MADT, no matter LAPIC entry or x2APIC entry is used.
> +                */
> +               memset(madt_proc, 0, sizeof(madt_proc));
> +               madt_proc[0].id =3D ACPI_MADT_TYPE_LOCAL_APIC;
> +               madt_proc[0].handler =3D acpi_parse_lapic;
> +               madt_proc[1].id =3D ACPI_MADT_TYPE_LOCAL_X2APIC;
> +               madt_proc[1].handler =3D acpi_parse_x2apic;
> +               ret =3D acpi_table_parse_entries_array(ACPI_SIG_MADT,
> +                               sizeof(struct acpi_table_madt),
> +                               madt_proc, ARRAY_SIZE(madt_proc), MAX_LOC=
AL_APIC);
> +               if (ret < 0) {
> +                       pr_err("Error parsing LAPIC/X2APIC entries\n");
> +                       return ret;
> +               }
> +               count =3D madt_proc[0].count;
> +               x2count =3D madt_proc[1].count;
>         }
>         if (!count && !x2count) {
>                 pr_err("No LAPIC entries present\n");
> --
> 2.34.1
>

Does anyone have any thoughts on this patch?

