Return-Path: <linux-acpi+bounces-10802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0EA1AA1A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62063AB942
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEE1917ED;
	Thu, 23 Jan 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQabyT8k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22C157487;
	Thu, 23 Jan 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659577; cv=none; b=Ml6XR/gphd4cJ0LK7x44ypkTtPCLfSavUF/H1WMpVC7TTkoMf+MoHyIMo1DAiNTaPMolWouJOD+/+DwSOQZxFXO+0hV4koHSxV2ucFuuj4g5idlvuCi3iMGa4psJV0zXMH991+IusnRE8Gj9eFO8wiJVUmRJgMKZjcHohusPk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659577; c=relaxed/simple;
	bh=wYbKKuIZ2G3zMIM74aM2HvFaQ6xMc/VW7wywV2A8/jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6pawBeUJOfAUzC+ahiGcuVCuAj70CkFNwyKuhzeshhB+GQoWaT1Vf2srw2dDF1hvhlHqOYB8k5oEUuE6yjmyAFMgqJ+T2KVXp9+D4skOnYiAUlngjvJdhwx4wALkHEIcNyIJioJgn7AWkdOWbwtNjZZVPmz9EMPLBH3gmtvb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQabyT8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C9C4CEE1;
	Thu, 23 Jan 2025 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737659577;
	bh=wYbKKuIZ2G3zMIM74aM2HvFaQ6xMc/VW7wywV2A8/jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FQabyT8keG7v4dX6iuGGVI+pV1amjdMh/4lkZ6Ql60zsqnY6dfZr53LKXLFcHdglJ
	 cIoaAY0/l+DuwyxD5T3PekDkQIzSr64muOsa2FgvIoR/EqfXrLFSiSwXd7CX+67bbw
	 fAVqTmjfpFYsA2ccgyCVgHvMwkJFPBUTFKWSBVNZXHpYt2gfGbl5mxeTbSe+JVekdb
	 mgUZm5s2I1W5iGNuDSx3gNUjEGY+ncmfWGhLOOF8i4w3n6BOsXCCHs0nwualMqrPXH
	 d3ma/C26OzILgqr2MQmEq78N7YEjKpCCvlwJFFcAcGIco9AscHV5u4UQ4/KoGRj8zq
	 qWs2J/kuYSx0Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29fb5257e05so453764fac.0;
        Thu, 23 Jan 2025 11:12:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuJOutUig4s07oMsIT6BbrhAscFRlKCQ+HJjCBHkmm3bH2ptmRFFmVjswyg1LRWAx3wM0AWsnMSoPY@vger.kernel.org, AJvYcCW7ietJTo8uUDUiaf+KLhEXS3ydR+tpvUxDRvBk8RheCqPLB/6jnL+KX4/zc92KRJVUiO9/BAbO89GEU13m@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHcKzjDtWJKJR3najFsq8jZOIxJzyllsAS4XcvwcEExs9ecbZ
	Dx1drhUNqfqjBRZ1OAFS7vbji+GojWbaeawFX+v0k3GJYNCEPc18/GpdOA6Szo9DISCCfHz7zB1
	zvQLcKuLTbXQiEZ62P0lZv/Yeql0=
X-Google-Smtp-Source: AGHT+IGAUD3noTn2WTvndikjSXGoRk8TYYdvyZrN6O430+fe4CKxB08gnLvM6XIVi0hI5MnB91QkzgOo//ChmTm5vGo=
X-Received: by 2002:a05:6871:62c2:b0:29f:97af:a1a0 with SMTP id
 586e51a60fabf-2b1c0c552eemr14289970fac.24.1737659576354; Thu, 23 Jan 2025
 11:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117081420.4046737-1-rui.zhang@intel.com>
In-Reply-To: <20250117081420.4046737-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:12:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iy63VakygnMqV4b5yYR2rwGbJ4zM4PbPYX2oH-ry9Evw@mail.gmail.com>
X-Gm-Features: AWEUYZnTTVFi88lflzpC5S7AsRDIWBPwn-nsWByvPUDr9cdKAuZKfp2w91ZNdvY
Message-ID: <CAJZ5v0iy63VakygnMqV4b5yYR2rwGbJ4zM4PbPYX2oH-ry9Evw@mail.gmail.com>
Subject: Re: [PATCH V2] x86/acpi: Fix LAPIC/x2APIC parsing order
To: Zhang Rui <rui.zhang@intel.com>, dave.hansen@linux.intel.com, bp@alien8.de
Cc: rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jmattson@google.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 9:13=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
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
> Fix this problem by:
>     1) Parsing LAPIC entries first without registering them in the
>        topology to evaluate whether valid LAPIC entries exist.
>     2) Restoring the MADT in order parser which invokes either the LAPIC
>        or the X2APIC parser function depending on the entry type.
>
> The X2APIC parser still ignores entries < 0xff in case that #1 found
> valid LAPIC entries independent of their position in the MADT table.
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
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

x86 folks, should I apply this?

> ---
> Changes in V2:
>  - Add Reviewed-by tag from Thomas
>  - Improve changelog based on Thomas' comment
> ---
>  arch/x86/kernel/acpi/boot.c | 50 +++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3a44a9dc3fb7..18485170d51b 100644
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

