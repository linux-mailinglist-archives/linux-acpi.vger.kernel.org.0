Return-Path: <linux-acpi+bounces-8779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4359F99D607
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D89B21891
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2881B4F14;
	Mon, 14 Oct 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRJwSusF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B713C3D5
	for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928831; cv=none; b=SqbIv02ZSOqnNnAwk3Iqp8Mh6+UWN7zQPcMWaDm9mPKrduMaO3MjJ3w/xKXDkY0cvcsNMikjOpqR/E7iQkzdfFrsb8t+DkK/6BadHU543gEuB3a6iwlp/fvDiMbCKwthm92G8JSTHkOTYRlsLxmwLcEgpX7PfgLZT6UV7OCZf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928831; c=relaxed/simple;
	bh=6ypbiWY7RkIhAY9hAwnSo+2ObiE6j/TmJ9Qd68+F5mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBGDTXnoGHh3dNMF2WqnW7kjSszE0oPylvaWjB6EkWld3YNur9D4lXa3z7ZWbGbub9Ghgra0xnvzHFW1sm3e14iGGc/kEPlm4Joxrcl+paMQWZlX7ghnqcVK/4Uv6MIAJHYslnInIlkEJuGPxAH07W7TYqC+7UnUctDNx19D5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aRJwSusF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8ac50b79so297345ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728928829; x=1729533629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pnjkA95iFybcKenTZmU5eArykaIZKWLZ28X9WicnPs=;
        b=aRJwSusF/8/C1XHmW8ifrN8dQ0xt3d+rzZkeB+bUdbqwUlFaTuzUUTLxgxRmkvETq3
         uG28y/osBd+hOGCDnMwrMi8ENYUJa8+CLdYGQngooQAe63LOMOmS3jPAq+kfFqkm4pRP
         misU8T5lSfM8d1w2wIHLkfDa6OG9UyNCaThlV5bZzXugYxxAKkNDw+JfULAyxUz5LH6W
         ZlOK2gh/5zjugh0qtQxZvg6gFBp3qHop56i74EW0+vFhUdyIuk76Ts9L+mnz2FYnO1ca
         EKz+P/zWp/uBVaSzwWJW24LCufiPuwpVqbpaJ3iDFTM7T0KjxjL5K8bC5VLwQNtjkUqa
         qjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928829; x=1729533629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pnjkA95iFybcKenTZmU5eArykaIZKWLZ28X9WicnPs=;
        b=RYGNFPjiubcCB490V+DJFpPKILL3kPZDRzkyf7IrDb2noJ7jQCbWl9gAMjHK6u6CG7
         wPdab5LsexAN2hSBSzbAXfwLxxZnBXdBwcQIIDfeTsoF2EWvvif5WgQZU8d+jPuNXHNM
         twik28EoXiNPww9CEX4uoZwzX9bMcX5Pg/aChEhjgI/1/OWh3GMfwIsefecD5ncaeeoQ
         9uOIU8UW19IjWfyRJjmNxRhF/slPV9b6ZoVRZcPReE+CnIcNgqyTZebbIaGVsp95cWW/
         b2/eihf+TJ06RMjjaL3RGiKwDyj1/eFIb6KqIpFmT5i1/rerkVVLY6t4bUvpZryBQLuE
         NJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUf65TEm0UDk7yCKuBdDTBxb/tO6drlq58ZuyGHKSNbgaTWJvN4klrninkB+OEt3GQF9Qrfwb0aJTSR@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6oerQK0/iE0J6og+bKgqH+YASYwqzZO/0L8ISiKPQLxBCYsV
	DYmLeXJhtehkW6bAAa+VntvdbzEXvoJ9v/nof0urBngecCXlR4xceM1SO1i3sLDRdBHmwV6ZFbj
	MHSwihOTGib+bz3Pwsmf309A1Gc1QJ94q7acq
X-Google-Smtp-Source: AGHT+IEL9/egI4VD2wpxU61jHzSMOredQkaD8p7xEj3VgfwJm+nI+dKW1a74faga41znD8nTiMgxJcc+n83f0Ntv7b4=
X-Received: by 2002:a17:902:c407:b0:206:b7b2:4876 with SMTP id
 d9443c01a7336-20cbced4be2mr3936015ad.20.1728928827087; Mon, 14 Oct 2024
 11:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230702162802.344176-1-rui.zhang@intel.com> <20241010213136.668672-1-jmattson@google.com>
 <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
 <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com> <f590669a7fa8d3e3f4d24ae3ed2d864ac14fbef8.camel@intel.com>
In-Reply-To: <f590669a7fa8d3e3f4d24ae3ed2d864ac14fbef8.camel@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Oct 2024 11:00:14 -0700
Message-ID: <CALMp9eQRsQ7hs9vhDGzbyRaqyOuaHDFFgc6VSr9Ui1=J_4s9Nw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "ajorgens@google.com" <ajorgens@google.com>, "myrade@google.com" <myrade@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Tang, Feng" <feng.tang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jay.chen@amd.com" <jay.chen@amd.com>, 
	"vladteodor@google.com" <vladteodor@google.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:05=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> > > >
> > > > TBH, I'm not sure that there is actually anything wrong with the
> > > > new
> > > > numbering scheme.
> > > >  The topology is reported correctly (e.g. in
> > > > /sys/devices/system/cpu/cpu0/topology/thread_siblings_list). Yet,
> > > > the
> > > > new enumeration does seem to contradict user expectations.
> > > >
> > >
> > > Well, we can say this is a violation of the ACPI spec.
> > > "OSPM should initialize processors in the order that they appear in
> > > the
> > > MADT." even for interleaved LAPIC and X2APIC entries.
> >
> > Ah. Thanks. I didn't know that.
> >
> > > Maybe we need two steps for LAPIC/X2APIC parsing.
> > > 1. check if there is valid LAPIC entry by going through all LAPIC
> > > entries first
> > > 2. parse LAPIC/X2APIC strictly following the order in MADT. (like
> > > we do
> > > before)
> >
> > That makes sense to me.
> >
> > Thanks,
> >
> > --jim
>
> Hi, Jim,
>
> Please check if below patch restores the CPU IDs or not.
>
> thanks,
> rui
>
> From ec786dfe693cad2810b54b0d8afbfc7e4c4b3f8a Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Mon, 14 Oct 2024 13:26:55 +0800
> Subject: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
>
> On some systems, the same CPU (with same APIC ID) is assigned with a
> different logical CPU id after commit ec9aedb2aa1a ("x86/acpi: Ignore
> invalid x2APIC entries").
>
> This means Linux enumerates the CPUs in a different order and it is a
> violation of https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming=
_Model.html#madt-processor-local-apic-sapic-structure-entry-order,
>
>   "OSPM should initialize processors in the order that they appear in
>    the MADT"
>
> The offending commit wants to ignore x2APIC entries with APIC ID < 255
> when valid LAPIC entries exist, so it parses all LAPIC entries before
> parsing any x2APIC entries. This breaks the CPU enumeration order for
> systems that have x2APIC entries listed before LAPIC entries in MADT.
>
> Fix the problem by checking the valid LAPIC entries separately, before
> parsing any LAPIC/x2APIC entries.
>
> Cc: stable@vger.kernel.org
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@goog=
le.com/
> Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
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

The point is moot now, but I don't think the previous code did the
right thing when acpi_table_parse_madt() returned a negative value
(for errors).

> +               /* Check if there are valid LAPIC entries */
> +               acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC, acpi_che=
ck_lapic, MAX_LOCAL_APIC);

Two comments:

1) Should we check for a return value < 0 here, or just wait for one
of the later walks to error out?
2) It seems unfortunate to walk the entire table when the first entry
may give you the answer, but perhaps modern systems have only X2APIC
entries, so we will typically have to walk the entire table anyway.

Reviewed-and-tested-by: Jim Mattson <jmattson@google.com>

