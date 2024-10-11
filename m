Return-Path: <linux-acpi+bounces-8702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326B999AD8
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 05:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C548C28236E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BA1EABAF;
	Fri, 11 Oct 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waYg2olW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E1EBE
	for <linux-acpi@vger.kernel.org>; Fri, 11 Oct 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728615942; cv=none; b=ou558teDE6FUJv9jIuYOFyqRtuR6WHaI9GZ93WvrLjtJjvTauY1tJ3IZ++CuD+UuN21uxjCCIu0hmh9keeJm3meufEk6542Fju82u2uGE8xTsXvNndOB7Vm7jcGrGwiGnhVFV2qxD5UQYQD5Qj3+9L7roHDRFAoAMHH3BXu5h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728615942; c=relaxed/simple;
	bh=uxG69NmxwXJn6dIMqJdUT79VOiTA3apokYe0+eaEp2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLLhocjUj4wKRh5NXWMewEGZvDsrvNTUUzH6AcHiH67BK+skUFBG8CmQ1xdnDkyiWiDEvtaurdaUFUbFSBxX3Uzq1mrvLC9ZX+2X9HmvyVGiBhmdjfsvuF0fWKe2Xe1Emf/9cXn5I2n+Pqsl/Xxhsonqx7N9/Mv6WQp5/yAUvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waYg2olW; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso129195ab.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Oct 2024 20:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728615939; x=1729220739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meR1uwBZBpIrzRLj6OlVYNic8Q9h/wDJ9Kh8qWKcx/k=;
        b=waYg2olW/M0s88D22qwHkNFDu+QObi+7x1J/7amgvYfKg/rqqLr5RpLbNLzZkGNs48
         eIuJbb/MvTIH8WNi2IgTLdN3lcjdwCt13nZBUniiOc3m+T3gjR2kqYIF9MC/YG2Qp8Bi
         NDOJjHXnZKGSKRI/5nkxF+isUOTdpDaMqA8lYF9SEbrS08mMjeWaEaBuaoF59YKESYYg
         MLhfkzz2D2pe0OoERIk6OtmKed7Q4gEeBXR+e5VUwgdstj30EfC0AeXxgRNkEMWtHmAz
         QN/Z/73xQVu/5UN1pntMPt59pb6nYRpvMd6OVZnMOvfstnyDbEPziVSf0qJBMDtyMkYm
         jOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728615939; x=1729220739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meR1uwBZBpIrzRLj6OlVYNic8Q9h/wDJ9Kh8qWKcx/k=;
        b=scHSRewJc91WJuEEEYjG+lz+wmfC6+zXTXrNKATYN3fKPntv1UL4Gis1mO9C5TpcIY
         Nvwb1XsWnqtLbaSmJD9YptO5RdYCmZs/csURf23hhMYRLKKd1xcBnsZT60NTiBn/6AVC
         QmvDkZfbF8bstDuhsnUlV+bSohLY3jBQemPAqhhEgbi7Wb86s0cuD2dNIJtE4mc5Iepk
         5AzxNlOwAm5YiMRiWON30MBYuXXr8ilCrRlL7f7ai7dHfohAm7sIhK6CV0pjr7F66lk9
         o2nMlqpyfMwRCuogtlumj2VwDdqQXLKlFA8elf3J17rHdl33OwRQaignjAZ9GI2myyDP
         v9kg==
X-Forwarded-Encrypted: i=1; AJvYcCWoqVlVISE2/wGAbufypGq//LKmfyNuo3X0PK1gVGhbzWiAYAMWENqhqoksis5bG9L7IxHChFAfMGbu@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWDjYEc5P5CI2k8iH0WWKKef9oTOtgNCbdPQ3lLnoHRwVmYub
	fJYsbcSuNrSvzOppUmqqCRwNX0K92Mj6WUz474XbjFeNWLsNTFsn7SLBV89lqcyMDg61YBxuV0A
	j23qRG9UfVfsWdX+euZdxSX5Tl3kR3mrZQ3HC
X-Google-Smtp-Source: AGHT+IE+amfB8Te0J5PGDb8V4pRpzwOjn87J61zV9nlqijJi80RBuSL84acxhCOcutL6UqVBNkMmuyhe3c4KXqbwJok=
X-Received: by 2002:a92:cda4:0:b0:39f:3778:c896 with SMTP id
 e9e14a558f8ab-3a3b64f31d1mr1090755ab.5.1728615938651; Thu, 10 Oct 2024
 20:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230702162802.344176-1-rui.zhang@intel.com> <20241010213136.668672-1-jmattson@google.com>
 <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
In-Reply-To: <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 10 Oct 2024 20:05:25 -0700
Message-ID: <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com>
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

On Thu, Oct 10, 2024 at 6:37=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Thu, 2024-10-10 at 14:31 -0700, Jim Mattson wrote:
> > > Currently, kernel enumerates the possible CPUs by parsing both ACPI
> > > MADT
> > > Local APIC entries and x2APIC entries. So CPUs with "valid" APIC
> > > IDs,
> > > even if they have duplicated APIC IDs in Local APIC and x2APIC, are
> > > always enumerated.
> > >
> > > Below is what ACPI MADT Local APIC and x2APIC describes on an
> > > Ivebridge-EP system,
> > >
> > > [02Ch 0044   1]                Subtable Type : 00 [Processor Local
> > > APIC]
> > > [02Fh 0047   1]                Local Apic ID : 00
> > > ...
> > > [164h 0356   1]                Subtable Type : 00 [Processor Local
> > > APIC]
> > > [167h 0359   1]                Local Apic ID : 39
> > > [16Ch 0364   1]                Subtable Type : 00 [Processor Local
> > > APIC]
> > > [16Fh 0367   1]                Local Apic ID : FF
> > > ...
> > > [3ECh 1004   1]                Subtable Type : 09 [Processor Local
> > > x2APIC]
> > > [3F0h 1008   4]                Processor x2Apic ID : 00000000
> > > ...
> > > [B5Ch 2908   1]                Subtable Type : 09 [Processor Local
> > > x2APIC]
> > > [B60h 2912   4]                Processor x2Apic ID : 00000077
> > >
> > > As a result, kernel shows "smpboot: Allowing 168 CPUs, 120 hotplug
> > > CPUs".
> > > And this wastes significant amount of memory for the per-cpu data.
> > > Plus this also breaks
> > > https://lore.kernel.org/all/87edm36qqb.ffs@tglx/,
> > > because __max_logical_packages is over-estimated by the APIC IDs in
> > > the x2APIC entries.
> > >
> > > According to
> > > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.ht=
ml#processor-local-x2apic-structure
> > > ,
> > > "[Compatibility note] On some legacy OSes, Logical processors with
> > > APIC
> > > ID values less than 255 (whether in XAPIC or X2APIC mode) must use
> > > the
> > > Processor Local APIC structure to convey their APIC information to
> > > OSPM,
> > > and those processors must be declared in the DSDT using the
> > > Processor()
> > > keyword. Logical processors with APIC ID values 255 and greater
> > > must use
> > > the Processor Local x2APIC structure and be declared using the
> > > Device()
> > > keyword.".
> > >
> > > Enumerate CPUs from x2APIC enties with APIC ID values 255 or
> > > greater,
> > > when valid CPU from Local APIC is already detected.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > > I didn't find any clear statement in the ACPI spec about if a
> > > mixture of
> > > Local APIC and x2APIC entries is allowed or not. So it would be
> > > great if
> > > this can be clarified.
> >
> > Has this been clarified?
> >
> > The reason that I ask is that Google Cloud has a 360 vCPU Zen4 VM
> > occupying two virtual sockets, and the corresponding MADT table has a
> > mixture of Local APIC and X2APIC entries.
> >
> > All of the LPUs in virtual socket 0 have extended APIC IDs below 255,
> > and they have Local APIC entries. All of the LPUs in virtual socket 1
> > have extended APIC IDs above 255, and they have X2APIC entries.
> >
> > Prior to this change, Linux assigned CPU numbers to all even-numbered
> > LPUs on virtual socket 0, followed by all even-numbered LPUs on
> > virtual socket 1, followed by all odd-numbered LPUs on virtual socket
> > 0, followed by all odd-numbered LPUs on virtual socket 1.
> >
> > node  #0, CPUs:          #1   #2  ...   #87  #88  #89
> > node  #1, CPUs:    #90  #91  #92  ...  #177 #178 #179
> > node  #0, CPUs:   #180 #181 #182  ...  #267 #268 #269
> > node  #1, CPUs:   #270 #271 #272  ...  #357 #358 #359
> >
> > After this change, however, Linux assigns CPU numbers to all LPUs on
> > virtual socket 0 before assigning any CPU numbers to LPUs on virtual
> > socket 1.
> >
> > node  #0, CPUs:          #1   #2  ...   #87  #88  #89
> > node  #1, CPUs:   #180 #181 #182  ...  #267 #268 #269
> > node  #0, CPUs:    #90  #91  #92  ...  #177 #178 #179
> > node  #1, CPUs:   #270 #271 #272  ...  #357 #358 #359
> >
> > I suspect that this is because all Local APIC MADT entries are now
> > processed before all X2APIC MADT entries, whereas they may have been
> > interleaved before.
>
> agreed.
> can you attach the acpidump to confirm this?

I'm pretty sure LKML rejects attachments. Here's the parsed MADT:

ACPI: APIC (v005 Google GOOGAPIC 0x00000001 GOOG 0x00000001) @ 0x(nil)
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0c] enabled)
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0e] enabled)
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x10] enabled)
ACPI: LAPIC (acpi_id[0x12] lapic_id[0x12] enabled)
ACPI: LAPIC (acpi_id[0x14] lapic_id[0x14] enabled)
ACPI: LAPIC (acpi_id[0x16] lapic_id[0x16] enabled)
ACPI: LAPIC (acpi_id[0x18] lapic_id[0x18] enabled)
ACPI: LAPIC (acpi_id[0x1a] lapic_id[0x1a] enabled)
ACPI: LAPIC (acpi_id[0x1c] lapic_id[0x1c] enabled)
ACPI: LAPIC (acpi_id[0x20] lapic_id[0x20] enabled)
ACPI: LAPIC (acpi_id[0x22] lapic_id[0x22] enabled)
ACPI: LAPIC (acpi_id[0x24] lapic_id[0x24] enabled)
ACPI: LAPIC (acpi_id[0x26] lapic_id[0x26] enabled)
ACPI: LAPIC (acpi_id[0x28] lapic_id[0x28] enabled)
ACPI: LAPIC (acpi_id[0x2a] lapic_id[0x2a] enabled)
ACPI: LAPIC (acpi_id[0x2c] lapic_id[0x2c] enabled)
ACPI: LAPIC (acpi_id[0x2e] lapic_id[0x2e] enabled)
ACPI: LAPIC (acpi_id[0x30] lapic_id[0x30] enabled)
ACPI: LAPIC (acpi_id[0x32] lapic_id[0x32] enabled)
ACPI: LAPIC (acpi_id[0x34] lapic_id[0x34] enabled)
ACPI: LAPIC (acpi_id[0x36] lapic_id[0x36] enabled)
ACPI: LAPIC (acpi_id[0x38] lapic_id[0x38] enabled)
ACPI: LAPIC (acpi_id[0x3a] lapic_id[0x3a] enabled)
ACPI: LAPIC (acpi_id[0x3c] lapic_id[0x3c] enabled)
ACPI: LAPIC (acpi_id[0x40] lapic_id[0x40] enabled)
ACPI: LAPIC (acpi_id[0x42] lapic_id[0x42] enabled)
ACPI: LAPIC (acpi_id[0x44] lapic_id[0x44] enabled)
ACPI: LAPIC (acpi_id[0x46] lapic_id[0x46] enabled)
ACPI: LAPIC (acpi_id[0x48] lapic_id[0x48] enabled)
ACPI: LAPIC (acpi_id[0x4a] lapic_id[0x4a] enabled)
ACPI: LAPIC (acpi_id[0x4c] lapic_id[0x4c] enabled)
ACPI: LAPIC (acpi_id[0x4e] lapic_id[0x4e] enabled)
ACPI: LAPIC (acpi_id[0x50] lapic_id[0x50] enabled)
ACPI: LAPIC (acpi_id[0x52] lapic_id[0x52] enabled)
ACPI: LAPIC (acpi_id[0x54] lapic_id[0x54] enabled)
ACPI: LAPIC (acpi_id[0x56] lapic_id[0x56] enabled)
ACPI: LAPIC (acpi_id[0x58] lapic_id[0x58] enabled)
ACPI: LAPIC (acpi_id[0x5a] lapic_id[0x5a] enabled)
ACPI: LAPIC (acpi_id[0x5c] lapic_id[0x5c] enabled)
ACPI: LAPIC (acpi_id[0x60] lapic_id[0x60] enabled)
ACPI: LAPIC (acpi_id[0x62] lapic_id[0x62] enabled)
ACPI: LAPIC (acpi_id[0x64] lapic_id[0x64] enabled)
ACPI: LAPIC (acpi_id[0x66] lapic_id[0x66] enabled)
ACPI: LAPIC (acpi_id[0x68] lapic_id[0x68] enabled)
ACPI: LAPIC (acpi_id[0x6a] lapic_id[0x6a] enabled)
ACPI: LAPIC (acpi_id[0x6c] lapic_id[0x6c] enabled)
ACPI: LAPIC (acpi_id[0x6e] lapic_id[0x6e] enabled)
ACPI: LAPIC (acpi_id[0x70] lapic_id[0x70] enabled)
ACPI: LAPIC (acpi_id[0x72] lapic_id[0x72] enabled)
ACPI: LAPIC (acpi_id[0x74] lapic_id[0x74] enabled)
ACPI: LAPIC (acpi_id[0x76] lapic_id[0x76] enabled)
ACPI: LAPIC (acpi_id[0x78] lapic_id[0x78] enabled)
ACPI: LAPIC (acpi_id[0x7a] lapic_id[0x7a] enabled)
ACPI: LAPIC (acpi_id[0x7c] lapic_id[0x7c] enabled)
ACPI: LAPIC (acpi_id[0x80] lapic_id[0x80] enabled)
ACPI: LAPIC (acpi_id[0x82] lapic_id[0x82] enabled)
ACPI: LAPIC (acpi_id[0x84] lapic_id[0x84] enabled)
ACPI: LAPIC (acpi_id[0x86] lapic_id[0x86] enabled)
ACPI: LAPIC (acpi_id[0x88] lapic_id[0x88] enabled)
ACPI: LAPIC (acpi_id[0x8a] lapic_id[0x8a] enabled)
ACPI: LAPIC (acpi_id[0x8c] lapic_id[0x8c] enabled)
ACPI: LAPIC (acpi_id[0x8e] lapic_id[0x8e] enabled)
ACPI: LAPIC (acpi_id[0x90] lapic_id[0x90] enabled)
ACPI: LAPIC (acpi_id[0x92] lapic_id[0x92] enabled)
ACPI: LAPIC (acpi_id[0x94] lapic_id[0x94] enabled)
ACPI: LAPIC (acpi_id[0x96] lapic_id[0x96] enabled)
ACPI: LAPIC (acpi_id[0x98] lapic_id[0x98] enabled)
ACPI: LAPIC (acpi_id[0x9a] lapic_id[0x9a] enabled)
ACPI: LAPIC (acpi_id[0x9c] lapic_id[0x9c] enabled)
ACPI: LAPIC (acpi_id[0xa0] lapic_id[0xa0] enabled)
ACPI: LAPIC (acpi_id[0xa2] lapic_id[0xa2] enabled)
ACPI: LAPIC (acpi_id[0xa4] lapic_id[0xa4] enabled)
ACPI: LAPIC (acpi_id[0xa6] lapic_id[0xa6] enabled)
ACPI: LAPIC (acpi_id[0xa8] lapic_id[0xa8] enabled)
ACPI: LAPIC (acpi_id[0xaa] lapic_id[0xaa] enabled)
ACPI: LAPIC (acpi_id[0xac] lapic_id[0xac] enabled)
ACPI: LAPIC (acpi_id[0xae] lapic_id[0xae] enabled)
ACPI: LAPIC (acpi_id[0xb0] lapic_id[0xb0] enabled)
ACPI: LAPIC (acpi_id[0xb2] lapic_id[0xb2] enabled)
ACPI: LAPIC (acpi_id[0xb4] lapic_id[0xb4] enabled)
ACPI: LAPIC (acpi_id[0xb6] lapic_id[0xb6] enabled)
ACPI: LAPIC (acpi_id[0xb8] lapic_id[0xb8] enabled)
ACPI: LAPIC (acpi_id[0xba] lapic_id[0xba] enabled)
ACPI: LAPIC (acpi_id[0xbc] lapic_id[0xbc] enabled)
ACPI: X2APIC (apic_id[0x100] uid[0x100] enabled)
ACPI: X2APIC (apic_id[0x102] uid[0x102] enabled)
ACPI: X2APIC (apic_id[0x104] uid[0x104] enabled)
ACPI: X2APIC (apic_id[0x106] uid[0x106] enabled)
ACPI: X2APIC (apic_id[0x108] uid[0x108] enabled)
ACPI: X2APIC (apic_id[0x10a] uid[0x10a] enabled)
ACPI: X2APIC (apic_id[0x10c] uid[0x10c] enabled)
ACPI: X2APIC (apic_id[0x10e] uid[0x10e] enabled)
ACPI: X2APIC (apic_id[0x110] uid[0x110] enabled)
ACPI: X2APIC (apic_id[0x112] uid[0x112] enabled)
ACPI: X2APIC (apic_id[0x114] uid[0x114] enabled)
ACPI: X2APIC (apic_id[0x116] uid[0x116] enabled)
ACPI: X2APIC (apic_id[0x118] uid[0x118] enabled)
ACPI: X2APIC (apic_id[0x11a] uid[0x11a] enabled)
ACPI: X2APIC (apic_id[0x11c] uid[0x11c] enabled)
ACPI: X2APIC (apic_id[0x120] uid[0x120] enabled)
ACPI: X2APIC (apic_id[0x122] uid[0x122] enabled)
ACPI: X2APIC (apic_id[0x124] uid[0x124] enabled)
ACPI: X2APIC (apic_id[0x126] uid[0x126] enabled)
ACPI: X2APIC (apic_id[0x128] uid[0x128] enabled)
ACPI: X2APIC (apic_id[0x12a] uid[0x12a] enabled)
ACPI: X2APIC (apic_id[0x12c] uid[0x12c] enabled)
ACPI: X2APIC (apic_id[0x12e] uid[0x12e] enabled)
ACPI: X2APIC (apic_id[0x130] uid[0x130] enabled)
ACPI: X2APIC (apic_id[0x132] uid[0x132] enabled)
ACPI: X2APIC (apic_id[0x134] uid[0x134] enabled)
ACPI: X2APIC (apic_id[0x136] uid[0x136] enabled)
ACPI: X2APIC (apic_id[0x138] uid[0x138] enabled)
ACPI: X2APIC (apic_id[0x13a] uid[0x13a] enabled)
ACPI: X2APIC (apic_id[0x13c] uid[0x13c] enabled)
ACPI: X2APIC (apic_id[0x140] uid[0x140] enabled)
ACPI: X2APIC (apic_id[0x142] uid[0x142] enabled)
ACPI: X2APIC (apic_id[0x144] uid[0x144] enabled)
ACPI: X2APIC (apic_id[0x146] uid[0x146] enabled)
ACPI: X2APIC (apic_id[0x148] uid[0x148] enabled)
ACPI: X2APIC (apic_id[0x14a] uid[0x14a] enabled)
ACPI: X2APIC (apic_id[0x14c] uid[0x14c] enabled)
ACPI: X2APIC (apic_id[0x14e] uid[0x14e] enabled)
ACPI: X2APIC (apic_id[0x150] uid[0x150] enabled)
ACPI: X2APIC (apic_id[0x152] uid[0x152] enabled)
ACPI: X2APIC (apic_id[0x154] uid[0x154] enabled)
ACPI: X2APIC (apic_id[0x156] uid[0x156] enabled)
ACPI: X2APIC (apic_id[0x158] uid[0x158] enabled)
ACPI: X2APIC (apic_id[0x15a] uid[0x15a] enabled)
ACPI: X2APIC (apic_id[0x15c] uid[0x15c] enabled)
ACPI: X2APIC (apic_id[0x160] uid[0x160] enabled)
ACPI: X2APIC (apic_id[0x162] uid[0x162] enabled)
ACPI: X2APIC (apic_id[0x164] uid[0x164] enabled)
ACPI: X2APIC (apic_id[0x166] uid[0x166] enabled)
ACPI: X2APIC (apic_id[0x168] uid[0x168] enabled)
ACPI: X2APIC (apic_id[0x16a] uid[0x16a] enabled)
ACPI: X2APIC (apic_id[0x16c] uid[0x16c] enabled)
ACPI: X2APIC (apic_id[0x16e] uid[0x16e] enabled)
ACPI: X2APIC (apic_id[0x170] uid[0x170] enabled)
ACPI: X2APIC (apic_id[0x172] uid[0x172] enabled)
ACPI: X2APIC (apic_id[0x174] uid[0x174] enabled)
ACPI: X2APIC (apic_id[0x176] uid[0x176] enabled)
ACPI: X2APIC (apic_id[0x178] uid[0x178] enabled)
ACPI: X2APIC (apic_id[0x17a] uid[0x17a] enabled)
ACPI: X2APIC (apic_id[0x17c] uid[0x17c] enabled)
ACPI: X2APIC (apic_id[0x180] uid[0x180] enabled)
ACPI: X2APIC (apic_id[0x182] uid[0x182] enabled)
ACPI: X2APIC (apic_id[0x184] uid[0x184] enabled)
ACPI: X2APIC (apic_id[0x186] uid[0x186] enabled)
ACPI: X2APIC (apic_id[0x188] uid[0x188] enabled)
ACPI: X2APIC (apic_id[0x18a] uid[0x18a] enabled)
ACPI: X2APIC (apic_id[0x18c] uid[0x18c] enabled)
ACPI: X2APIC (apic_id[0x18e] uid[0x18e] enabled)
ACPI: X2APIC (apic_id[0x190] uid[0x190] enabled)
ACPI: X2APIC (apic_id[0x192] uid[0x192] enabled)
ACPI: X2APIC (apic_id[0x194] uid[0x194] enabled)
ACPI: X2APIC (apic_id[0x196] uid[0x196] enabled)
ACPI: X2APIC (apic_id[0x198] uid[0x198] enabled)
ACPI: X2APIC (apic_id[0x19a] uid[0x19a] enabled)
ACPI: X2APIC (apic_id[0x19c] uid[0x19c] enabled)
ACPI: X2APIC (apic_id[0x1a0] uid[0x1a0] enabled)
ACPI: X2APIC (apic_id[0x1a2] uid[0x1a2] enabled)
ACPI: X2APIC (apic_id[0x1a4] uid[0x1a4] enabled)
ACPI: X2APIC (apic_id[0x1a6] uid[0x1a6] enabled)
ACPI: X2APIC (apic_id[0x1a8] uid[0x1a8] enabled)
ACPI: X2APIC (apic_id[0x1aa] uid[0x1aa] enabled)
ACPI: X2APIC (apic_id[0x1ac] uid[0x1ac] enabled)
ACPI: X2APIC (apic_id[0x1ae] uid[0x1ae] enabled)
ACPI: X2APIC (apic_id[0x1b0] uid[0x1b0] enabled)
ACPI: X2APIC (apic_id[0x1b2] uid[0x1b2] enabled)
ACPI: X2APIC (apic_id[0x1b4] uid[0x1b4] enabled)
ACPI: X2APIC (apic_id[0x1b6] uid[0x1b6] enabled)
ACPI: X2APIC (apic_id[0x1b8] uid[0x1b8] enabled)
ACPI: X2APIC (apic_id[0x1ba] uid[0x1ba] enabled)
ACPI: X2APIC (apic_id[0x1bc] uid[0x1bc] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0d] enabled)
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0f] enabled)
ACPI: LAPIC (acpi_id[0x11] lapic_id[0x11] enabled)
ACPI: LAPIC (acpi_id[0x13] lapic_id[0x13] enabled)
ACPI: LAPIC (acpi_id[0x15] lapic_id[0x15] enabled)
ACPI: LAPIC (acpi_id[0x17] lapic_id[0x17] enabled)
ACPI: LAPIC (acpi_id[0x19] lapic_id[0x19] enabled)
ACPI: LAPIC (acpi_id[0x1b] lapic_id[0x1b] enabled)
ACPI: LAPIC (acpi_id[0x1d] lapic_id[0x1d] enabled)
ACPI: LAPIC (acpi_id[0x21] lapic_id[0x21] enabled)
ACPI: LAPIC (acpi_id[0x23] lapic_id[0x23] enabled)
ACPI: LAPIC (acpi_id[0x25] lapic_id[0x25] enabled)
ACPI: LAPIC (acpi_id[0x27] lapic_id[0x27] enabled)
ACPI: LAPIC (acpi_id[0x29] lapic_id[0x29] enabled)
ACPI: LAPIC (acpi_id[0x2b] lapic_id[0x2b] enabled)
ACPI: LAPIC (acpi_id[0x2d] lapic_id[0x2d] enabled)
ACPI: LAPIC (acpi_id[0x2f] lapic_id[0x2f] enabled)
ACPI: LAPIC (acpi_id[0x31] lapic_id[0x31] enabled)
ACPI: LAPIC (acpi_id[0x33] lapic_id[0x33] enabled)
ACPI: LAPIC (acpi_id[0x35] lapic_id[0x35] enabled)
ACPI: LAPIC (acpi_id[0x37] lapic_id[0x37] enabled)
ACPI: LAPIC (acpi_id[0x39] lapic_id[0x39] enabled)
ACPI: LAPIC (acpi_id[0x3b] lapic_id[0x3b] enabled)
ACPI: LAPIC (acpi_id[0x3d] lapic_id[0x3d] enabled)
ACPI: LAPIC (acpi_id[0x41] lapic_id[0x41] enabled)
ACPI: LAPIC (acpi_id[0x43] lapic_id[0x43] enabled)
ACPI: LAPIC (acpi_id[0x45] lapic_id[0x45] enabled)
ACPI: LAPIC (acpi_id[0x47] lapic_id[0x47] enabled)
ACPI: LAPIC (acpi_id[0x49] lapic_id[0x49] enabled)
ACPI: LAPIC (acpi_id[0x4b] lapic_id[0x4b] enabled)
ACPI: LAPIC (acpi_id[0x4d] lapic_id[0x4d] enabled)
ACPI: LAPIC (acpi_id[0x4f] lapic_id[0x4f] enabled)
ACPI: LAPIC (acpi_id[0x51] lapic_id[0x51] enabled)
ACPI: LAPIC (acpi_id[0x53] lapic_id[0x53] enabled)
ACPI: LAPIC (acpi_id[0x55] lapic_id[0x55] enabled)
ACPI: LAPIC (acpi_id[0x57] lapic_id[0x57] enabled)
ACPI: LAPIC (acpi_id[0x59] lapic_id[0x59] enabled)
ACPI: LAPIC (acpi_id[0x5b] lapic_id[0x5b] enabled)
ACPI: LAPIC (acpi_id[0x5d] lapic_id[0x5d] enabled)
ACPI: LAPIC (acpi_id[0x61] lapic_id[0x61] enabled)
ACPI: LAPIC (acpi_id[0x63] lapic_id[0x63] enabled)
ACPI: LAPIC (acpi_id[0x65] lapic_id[0x65] enabled)
ACPI: LAPIC (acpi_id[0x67] lapic_id[0x67] enabled)
ACPI: LAPIC (acpi_id[0x69] lapic_id[0x69] enabled)
ACPI: LAPIC (acpi_id[0x6b] lapic_id[0x6b] enabled)
ACPI: LAPIC (acpi_id[0x6d] lapic_id[0x6d] enabled)
ACPI: LAPIC (acpi_id[0x6f] lapic_id[0x6f] enabled)
ACPI: LAPIC (acpi_id[0x71] lapic_id[0x71] enabled)
ACPI: LAPIC (acpi_id[0x73] lapic_id[0x73] enabled)
ACPI: LAPIC (acpi_id[0x75] lapic_id[0x75] enabled)
ACPI: LAPIC (acpi_id[0x77] lapic_id[0x77] enabled)
ACPI: LAPIC (acpi_id[0x79] lapic_id[0x79] enabled)
ACPI: LAPIC (acpi_id[0x7b] lapic_id[0x7b] enabled)
ACPI: LAPIC (acpi_id[0x7d] lapic_id[0x7d] enabled)
ACPI: LAPIC (acpi_id[0x81] lapic_id[0x81] enabled)
ACPI: LAPIC (acpi_id[0x83] lapic_id[0x83] enabled)
ACPI: LAPIC (acpi_id[0x85] lapic_id[0x85] enabled)
ACPI: LAPIC (acpi_id[0x87] lapic_id[0x87] enabled)
ACPI: LAPIC (acpi_id[0x89] lapic_id[0x89] enabled)
ACPI: LAPIC (acpi_id[0x8b] lapic_id[0x8b] enabled)
ACPI: LAPIC (acpi_id[0x8d] lapic_id[0x8d] enabled)
ACPI: LAPIC (acpi_id[0x8f] lapic_id[0x8f] enabled)
ACPI: LAPIC (acpi_id[0x91] lapic_id[0x91] enabled)
ACPI: LAPIC (acpi_id[0x93] lapic_id[0x93] enabled)
ACPI: LAPIC (acpi_id[0x95] lapic_id[0x95] enabled)
ACPI: LAPIC (acpi_id[0x97] lapic_id[0x97] enabled)
ACPI: LAPIC (acpi_id[0x99] lapic_id[0x99] enabled)
ACPI: LAPIC (acpi_id[0x9b] lapic_id[0x9b] enabled)
ACPI: LAPIC (acpi_id[0x9d] lapic_id[0x9d] enabled)
ACPI: LAPIC (acpi_id[0xa1] lapic_id[0xa1] enabled)
ACPI: LAPIC (acpi_id[0xa3] lapic_id[0xa3] enabled)
ACPI: LAPIC (acpi_id[0xa5] lapic_id[0xa5] enabled)
ACPI: LAPIC (acpi_id[0xa7] lapic_id[0xa7] enabled)
ACPI: LAPIC (acpi_id[0xa9] lapic_id[0xa9] enabled)
ACPI: LAPIC (acpi_id[0xab] lapic_id[0xab] enabled)
ACPI: LAPIC (acpi_id[0xad] lapic_id[0xad] enabled)
ACPI: LAPIC (acpi_id[0xaf] lapic_id[0xaf] enabled)
ACPI: LAPIC (acpi_id[0xb1] lapic_id[0xb1] enabled)
ACPI: LAPIC (acpi_id[0xb3] lapic_id[0xb3] enabled)
ACPI: LAPIC (acpi_id[0xb5] lapic_id[0xb5] enabled)
ACPI: LAPIC (acpi_id[0xb7] lapic_id[0xb7] enabled)
ACPI: LAPIC (acpi_id[0xb9] lapic_id[0xb9] enabled)
ACPI: LAPIC (acpi_id[0xbb] lapic_id[0xbb] enabled)
ACPI: LAPIC (acpi_id[0xbd] lapic_id[0xbd] enabled)
ACPI: X2APIC (apic_id[0x101] uid[0x101] enabled)
ACPI: X2APIC (apic_id[0x103] uid[0x103] enabled)
ACPI: X2APIC (apic_id[0x105] uid[0x105] enabled)
ACPI: X2APIC (apic_id[0x107] uid[0x107] enabled)
ACPI: X2APIC (apic_id[0x109] uid[0x109] enabled)
ACPI: X2APIC (apic_id[0x10b] uid[0x10b] enabled)
ACPI: X2APIC (apic_id[0x10d] uid[0x10d] enabled)
ACPI: X2APIC (apic_id[0x10f] uid[0x10f] enabled)
ACPI: X2APIC (apic_id[0x111] uid[0x111] enabled)
ACPI: X2APIC (apic_id[0x113] uid[0x113] enabled)
ACPI: X2APIC (apic_id[0x115] uid[0x115] enabled)
ACPI: X2APIC (apic_id[0x117] uid[0x117] enabled)
ACPI: X2APIC (apic_id[0x119] uid[0x119] enabled)
ACPI: X2APIC (apic_id[0x11b] uid[0x11b] enabled)
ACPI: X2APIC (apic_id[0x11d] uid[0x11d] enabled)
ACPI: X2APIC (apic_id[0x121] uid[0x121] enabled)
ACPI: X2APIC (apic_id[0x123] uid[0x123] enabled)
ACPI: X2APIC (apic_id[0x125] uid[0x125] enabled)
ACPI: X2APIC (apic_id[0x127] uid[0x127] enabled)
ACPI: X2APIC (apic_id[0x129] uid[0x129] enabled)
ACPI: X2APIC (apic_id[0x12b] uid[0x12b] enabled)
ACPI: X2APIC (apic_id[0x12d] uid[0x12d] enabled)
ACPI: X2APIC (apic_id[0x12f] uid[0x12f] enabled)
ACPI: X2APIC (apic_id[0x131] uid[0x131] enabled)
ACPI: X2APIC (apic_id[0x133] uid[0x133] enabled)
ACPI: X2APIC (apic_id[0x135] uid[0x135] enabled)
ACPI: X2APIC (apic_id[0x137] uid[0x137] enabled)
ACPI: X2APIC (apic_id[0x139] uid[0x139] enabled)
ACPI: X2APIC (apic_id[0x13b] uid[0x13b] enabled)
ACPI: X2APIC (apic_id[0x13d] uid[0x13d] enabled)
ACPI: X2APIC (apic_id[0x141] uid[0x141] enabled)
ACPI: X2APIC (apic_id[0x143] uid[0x143] enabled)
ACPI: X2APIC (apic_id[0x145] uid[0x145] enabled)
ACPI: X2APIC (apic_id[0x147] uid[0x147] enabled)
ACPI: X2APIC (apic_id[0x149] uid[0x149] enabled)
ACPI: X2APIC (apic_id[0x14b] uid[0x14b] enabled)
ACPI: X2APIC (apic_id[0x14d] uid[0x14d] enabled)
ACPI: X2APIC (apic_id[0x14f] uid[0x14f] enabled)
ACPI: X2APIC (apic_id[0x151] uid[0x151] enabled)
ACPI: X2APIC (apic_id[0x153] uid[0x153] enabled)
ACPI: X2APIC (apic_id[0x155] uid[0x155] enabled)
ACPI: X2APIC (apic_id[0x157] uid[0x157] enabled)
ACPI: X2APIC (apic_id[0x159] uid[0x159] enabled)
ACPI: X2APIC (apic_id[0x15b] uid[0x15b] enabled)
ACPI: X2APIC (apic_id[0x15d] uid[0x15d] enabled)
ACPI: X2APIC (apic_id[0x161] uid[0x161] enabled)
ACPI: X2APIC (apic_id[0x163] uid[0x163] enabled)
ACPI: X2APIC (apic_id[0x165] uid[0x165] enabled)
ACPI: X2APIC (apic_id[0x167] uid[0x167] enabled)
ACPI: X2APIC (apic_id[0x169] uid[0x169] enabled)
ACPI: X2APIC (apic_id[0x16b] uid[0x16b] enabled)
ACPI: X2APIC (apic_id[0x16d] uid[0x16d] enabled)
ACPI: X2APIC (apic_id[0x16f] uid[0x16f] enabled)
ACPI: X2APIC (apic_id[0x171] uid[0x171] enabled)
ACPI: X2APIC (apic_id[0x173] uid[0x173] enabled)
ACPI: X2APIC (apic_id[0x175] uid[0x175] enabled)
ACPI: X2APIC (apic_id[0x177] uid[0x177] enabled)
ACPI: X2APIC (apic_id[0x179] uid[0x179] enabled)
ACPI: X2APIC (apic_id[0x17b] uid[0x17b] enabled)
ACPI: X2APIC (apic_id[0x17d] uid[0x17d] enabled)
ACPI: X2APIC (apic_id[0x181] uid[0x181] enabled)
ACPI: X2APIC (apic_id[0x183] uid[0x183] enabled)
ACPI: X2APIC (apic_id[0x185] uid[0x185] enabled)
ACPI: X2APIC (apic_id[0x187] uid[0x187] enabled)
ACPI: X2APIC (apic_id[0x189] uid[0x189] enabled)
ACPI: X2APIC (apic_id[0x18b] uid[0x18b] enabled)
ACPI: X2APIC (apic_id[0x18d] uid[0x18d] enabled)
ACPI: X2APIC (apic_id[0x18f] uid[0x18f] enabled)
ACPI: X2APIC (apic_id[0x191] uid[0x191] enabled)
ACPI: X2APIC (apic_id[0x193] uid[0x193] enabled)
ACPI: X2APIC (apic_id[0x195] uid[0x195] enabled)
ACPI: X2APIC (apic_id[0x197] uid[0x197] enabled)
ACPI: X2APIC (apic_id[0x199] uid[0x199] enabled)
ACPI: X2APIC (apic_id[0x19b] uid[0x19b] enabled)
ACPI: X2APIC (apic_id[0x19d] uid[0x19d] enabled)
ACPI: X2APIC (apic_id[0x1a1] uid[0x1a1] enabled)
ACPI: X2APIC (apic_id[0x1a3] uid[0x1a3] enabled)
ACPI: X2APIC (apic_id[0x1a5] uid[0x1a5] enabled)
ACPI: X2APIC (apic_id[0x1a7] uid[0x1a7] enabled)
ACPI: X2APIC (apic_id[0x1a9] uid[0x1a9] enabled)
ACPI: X2APIC (apic_id[0x1ab] uid[0x1ab] enabled)
ACPI: X2APIC (apic_id[0x1ad] uid[0x1ad] enabled)
ACPI: X2APIC (apic_id[0x1af] uid[0x1af] enabled)
ACPI: X2APIC (apic_id[0x1b1] uid[0x1b1] enabled)
ACPI: X2APIC (apic_id[0x1b3] uid[0x1b3] enabled)
ACPI: X2APIC (apic_id[0x1b5] uid[0x1b5] enabled)
ACPI: X2APIC (apic_id[0x1b7] uid[0x1b7] enabled)
ACPI: X2APIC (apic_id[0x1b9] uid[0x1b9] enabled)
ACPI: X2APIC (apic_id[0x1bb] uid[0x1bb] enabled)
ACPI: X2APIC (apic_id[0x1bd] uid[0x1bd] enabled)
ACPI: IOAPIC (id[0x00] address[0xfec00000] global_irq_base[0x0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])

> >
> > TBH, I'm not sure that there is actually anything wrong with the new
> > numbering scheme.
> >  The topology is reported correctly (e.g. in
> > /sys/devices/system/cpu/cpu0/topology/thread_siblings_list). Yet, the
> > new enumeration does seem to contradict user expectations.
> >
>
> Well, we can say this is a violation of the ACPI spec.
> "OSPM should initialize processors in the order that they appear in the
> MADT." even for interleaved LAPIC and X2APIC entries.

Ah. Thanks. I didn't know that.

> Maybe we need two steps for LAPIC/X2APIC parsing.
> 1. check if there is valid LAPIC entry by going through all LAPIC
> entries first
> 2. parse LAPIC/X2APIC strictly following the order in MADT. (like we do
> before)

That makes sense to me.

Thanks,

--jim

