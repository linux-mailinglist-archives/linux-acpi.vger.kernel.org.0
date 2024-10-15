Return-Path: <linux-acpi+bounces-8795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2299ED74
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 15:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A31287C15
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C01D515D;
	Tue, 15 Oct 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVgeDOS6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BB1D514C
	for <linux-acpi@vger.kernel.org>; Tue, 15 Oct 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998793; cv=none; b=h1/1Q+KY4/24BSVlB31mjey0SfBWtkM997fc3y6xmKhOjqLCFgNgFrhW1rpfQiBlKayr3uAE6sJqtwPA7ZU9zIKUjyomzs9qdmqGvQ+maAxp1XTxJAwoCbKQav3+eqZiLTeVGekl2YA6LVQPcMB5rxsUnMZYAbNN7BHqHmG4ZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998793; c=relaxed/simple;
	bh=qKh5mQ2YBQ4Sc6FtlfABWkNt9dQ/qxctRcvKuQHjIqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNjei1VLpDTHwAaoAeixZph4w86nD5phrhZkhMXro9+879AXEkDUKrUslZYy0SxSwg2sM08p8EXXOyjxjzoISWCaC9LdA775We/Oca6OHGoVZXX6GuMhRo+Kp6VeSkGoJ7cuo+s9etDqkV8ik9ybqNp2IcCvCw1XqWhJW+I64Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVgeDOS6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca4877690so456395ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Oct 2024 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998791; x=1729603591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZrZO9mYN60oTnls9qOvmYYHcHUYs3X1nSZh3U6AiPc=;
        b=qVgeDOS6xVouIQKuvEOUyDWuNjU5FIxKbf/vvL/AD1sB6vgTGmsw5BwU9Ua1caym8k
         6Mhmt/O3dSHx1WHsQfhX5A9RDa8itH6QHQYC2HVoGlCa0W2Z8odeZzpuNFmH7aRd7XjF
         rUfrzYeI8iZPiUNPuEUxl49kzpJq+0n2AqlbzN6PQgCLtTVnlhot7r1Mxc+wC5z2H8VA
         Ds63B1TFGkJBBhRtg3NKVKDKq2Stvqx4U07LYBFjarpnOt1Bd5sklTk9hQ1wVl4ArYDi
         +a7p2Rpv50FU5KNVHsiXprXHBmQx6Wxly9pNzBhMVdDvSQWt2Jg1G+8kChRTVnEGxGd+
         tyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998791; x=1729603591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZrZO9mYN60oTnls9qOvmYYHcHUYs3X1nSZh3U6AiPc=;
        b=WYC0ZShLVA3ojkg4Wr/60pQb4LDv9YJlhAz1QxHq8HuyVzxwtUMMcH7CIsjma8CIfa
         uNhHqN2L2jr479bnvQ1vnrm0mHohE3YV99bdLtNEfX6mIsbqhjR9vYezSZKiR8KBpt9y
         MNg8EC5Z4xeYEVuC9Qb8ibhZm0/OOFAz7damUULhVaFfe1NTDSYQDsDyCVGSsqEz3+Mt
         UUM8YfI3AvzxT1/hMpwuKIrAztEpW9xy9UM+W5NmpuRjyjcpIlfpkHVhKeXu2NZo/Koe
         SCV2wCgteLdAbdCPdxx+JicD9HYLVqYj+9sDDBE53BAiRAsPkfjeXA7eIsBGsPME9xK5
         +crA==
X-Forwarded-Encrypted: i=1; AJvYcCWH2zlR82EUfeLtcimjEFeGrbs4gzEewEzika46am03ZePDZZ7P/j8UpBCkC2yZeTSgCGwJwrHgVU91@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0iUBWF5OvQexy0yMxd03bFFKH6BtwbLgLJpquditVVCPMVEO
	St4y2RvnfPcnB2l//fwURRvbz/yUVZ/+vPoLPPuo79tuPWU7Q5xyaFORFdsNzc2nB7Q+81O+DkR
	SVm4wlvSgE9txVJ9Z9p0ERk23fB64JTBNUDV1
X-Google-Smtp-Source: AGHT+IHHDflKcIxlAz2F8QROFOEpfrBi0nJ5tNzpMcFd27A+4Cj0cS5+ojoVYv9d6bYuYnZiWhofTdazcMJW8Ttdu2Q=
X-Received: by 2002:a17:903:182:b0:205:8ceb:79a7 with SMTP id
 d9443c01a7336-20cc02d7070mr6051425ad.23.1728998791131; Tue, 15 Oct 2024
 06:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230702162802.344176-1-rui.zhang@intel.com> <20241010213136.668672-1-jmattson@google.com>
 <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
 <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com>
 <f590669a7fa8d3e3f4d24ae3ed2d864ac14fbef8.camel@intel.com>
 <CALMp9eQRsQ7hs9vhDGzbyRaqyOuaHDFFgc6VSr9Ui1=J_4s9Nw@mail.gmail.com> <ac85fe73b3d7f46ce96d5033f8cf58a1b6b001f3.camel@intel.com>
In-Reply-To: <ac85fe73b3d7f46ce96d5033f8cf58a1b6b001f3.camel@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 15 Oct 2024 06:26:18 -0700
Message-ID: <CALMp9eRm+SZce73ujt2eLeHTa4C_i15izmjH9mL_NCgZtuY57Q@mail.gmail.com>
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

On Mon, Oct 14, 2024 at 8:23=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Mon, 2024-10-14 at 11:00 -0700, Jim Mattson wrote:
> > On Mon, Oct 14, 2024 at 6:05=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com=
>
> > wrote:
> > >
> > > > > >
> > > > > > TBH, I'm not sure that there is actually anything wrong with
> > > > > > the
> > > > > > new
> > > > > > numbering scheme.
> > > > > >  The topology is reported correctly (e.g. in
> > > > > > /sys/devices/system/cpu/cpu0/topology/thread_siblings_list).
> > > > > > Yet,
> > > > > > the
> > > > > > new enumeration does seem to contradict user expectations.
> > > > > >
> > > > >
> > > > > Well, we can say this is a violation of the ACPI spec.
> > > > > "OSPM should initialize processors in the order that they
> > > > > appear in
> > > > > the
> > > > > MADT." even for interleaved LAPIC and X2APIC entries.
> > > >
> > > > Ah. Thanks. I didn't know that.
> > > >
> > > > > Maybe we need two steps for LAPIC/X2APIC parsing.
> > > > > 1. check if there is valid LAPIC entry by going through all
> > > > > LAPIC
> > > > > entries first
> > > > > 2. parse LAPIC/X2APIC strictly following the order in MADT.
> > > > > (like
> > > > > we do
> > > > > before)
> > > >
> > > > That makes sense to me.
> > > >
> > > > Thanks,
> > > >
> > > > --jim
> > >
> > > Hi, Jim,
> > >
> > > Please check if below patch restores the CPU IDs or not.
> > >
> > > thanks,
> > > rui
> > >
> > > From ec786dfe693cad2810b54b0d8afbfc7e4c4b3f8a Mon Sep 17 00:00:00
> > > 2001
> > > From: Zhang Rui <rui.zhang@intel.com>
> > > Date: Mon, 14 Oct 2024 13:26:55 +0800
> > > Subject: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
> > >
> > > On some systems, the same CPU (with same APIC ID) is assigned with
> > > a
> > > different logical CPU id after commit ec9aedb2aa1a ("x86/acpi:
> > > Ignore
> > > invalid x2APIC entries").
> > >
> > > This means Linux enumerates the CPUs in a different order and it is
> > > a
> > > violation of
> > > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.ht=
ml#madt-processor-local-apic-sapic-structure-entry-order
> > > ,
> > >
> > >   "OSPM should initialize processors in the order that they appear
> > > in
> > >    the MADT"
> > >
> > > The offending commit wants to ignore x2APIC entries with APIC ID <
> > > 255
> > > when valid LAPIC entries exist, so it parses all LAPIC entries
> > > before
> > > parsing any x2APIC entries. This breaks the CPU enumeration order
> > > for
> > > systems that have x2APIC entries listed before LAPIC entries in
> > > MADT.
> > >
> > > Fix the problem by checking the valid LAPIC entries separately,
> > > before
> > > parsing any LAPIC/x2APIC entries.
> > >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Jim Mattson <jmattson@google.com>
> > > Closes:
> > > https://lore.kernel.org/all/20241010213136.668672-1-jmattson@google.c=
om/
> > > Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  arch/x86/kernel/acpi/boot.c | 50
> > > +++++++++++++++++++++++++++++++++----
> > >  1 file changed, 45 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/acpi/boot.c
> > > b/arch/x86/kernel/acpi/boot.c
> > > index 4efecac49863..c70b86f1f295 100644
> > > --- a/arch/x86/kernel/acpi/boot.c
> > > +++ b/arch/x86/kernel/acpi/boot.c
> > > @@ -226,6 +226,28 @@ acpi_parse_x2apic(union acpi_subtable_headers
> > > *header, const unsigned long end)
> > >         return 0;
> > >  }
> > >
> > > +static int __init
> > > +acpi_check_lapic(union acpi_subtable_headers *header, const
> > > unsigned long end)
> > > +{
> > > +       struct acpi_madt_local_apic *processor =3D NULL;
> > > +
> > > +       processor =3D (struct acpi_madt_local_apic *)header;
> > > +
> > > +       if (BAD_MADT_ENTRY(processor, end))
> > > +               return -EINVAL;
> > > +
> > > +       /* Ignore invalid ID */
> > > +       if (processor->id =3D=3D 0xff)
> > > +               return 0;
> > > +
> > > +       /* Ignore processors that can not be onlined */
> > > +       if (!acpi_is_processor_usable(processor->lapic_flags))
> > > +               return 0;
> > > +
> > > +       has_lapic_cpus =3D true;
> > > +       return 0;
> > > +}
> > > +
> > >  static int __init
> > >  acpi_parse_lapic(union acpi_subtable_headers * header, const
> > > unsigned long end)
> > >  {
> > > @@ -257,7 +279,6 @@ acpi_parse_lapic(union acpi_subtable_headers *
> > > header, const unsigned long end)
> > >                                processor->processor_id, /* ACPI ID
> > > */
> > >                                processor->lapic_flags &
> > > ACPI_MADT_ENABLED);
> > >
> > > -       has_lapic_cpus =3D true;
> > >         return 0;
> > >  }
> > >
> > > @@ -1029,6 +1050,8 @@ static int __init
> > > early_acpi_parse_madt_lapic_addr_ovr(void)
> > >  static int __init acpi_parse_madt_lapic_entries(void)
> > >  {
> > >         int count, x2count =3D 0;
> > > +       struct acpi_subtable_proc madt_proc[2];
> > > +       int ret;
> > >
> > >         if (!boot_cpu_has(X86_FEATURE_APIC))
> > >                 return -ENODEV;
> > > @@ -1037,10 +1060,27 @@ static int __init
> > > acpi_parse_madt_lapic_entries(void)
> > >                                       acpi_parse_sapic,
> > > MAX_LOCAL_APIC);
> > >
> > >         if (!count) {
> > > -               count =3D
> > > acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
> > > -                                       acpi_parse_lapic,
> > > MAX_LOCAL_APIC);
> > > -               x2count =3D
> > > acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
> > > -                                       acpi_parse_x2apic,
> > > MAX_LOCAL_APIC);
> >
> > The point is moot now, but I don't think the previous code did the
> > right thing when acpi_table_parse_madt() returned a negative value
> > (for errors).
>
> Previous and current code checks for the negative value later after
> parsing both LAPIC and x2APIC.
> so what is the problem you're referring to?
> Do you mean we should error out immediately when parsing LAPIC fails?

My mistake. I should have looked at the full context rather than just
the context of the patch.

> >
> > > +               /* Check if there are valid LAPIC entries */
> > > +               acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
> > > acpi_check_lapic, MAX_LOCAL_APIC);
> >
> > Two comments:
> >
> > 1) Should we check for a return value < 0 here, or just wait for one
> > of the later walks to error out?
>
> I'm okay with both.
>
> > 2) It seems unfortunate to walk the entire table when the first entry
> > may give you the answer, but perhaps modern systems have only X2APIC
> > entries, so we will typically have to walk the entire table anyway.
>
> yeah. There are systems with invalid LAPIC entries first, and
> acpi_parse_entries_array() doesn't support graceful early termination,
> so we have to check all the entries.
>
> >
> > Reviewed-and-tested-by: Jim Mattson <jmattson@google.com>
>
> Thanks. I will submit the current version to keep your tags.
>
> -rui

Thanks!

--jim

