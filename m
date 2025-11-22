Return-Path: <linux-acpi+bounces-19188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530BC7C12B
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Nov 2025 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD44E06D6
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Nov 2025 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2DD288505;
	Sat, 22 Nov 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOCCUXDK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC8285CAE;
	Sat, 22 Nov 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774066; cv=none; b=WUDuOD6oXPjU7ClPOAxWj+t9X3IJaWuSHkNDEXNKD64Ch1J1OM2LxuMTIP/JsnNUDc2NsYCaPbRvAwtFHBLyihCkGzp4ux55q/PcgILHVuGeyGZGWuXfod+rqV3Rzkiw3YsmtayAxDrbXHzW/P4GcPq+3VtBC16u0uwJnPPWPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774066; c=relaxed/simple;
	bh=TmK0ymaRbGnYFBwWDPKvoufQniChA4/p5HNSW5rwn4k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lhZP2BDbL/Ilk+IMPAuA+0IlYs+iinNKIltD01gfJ+1GYBA3CSTjLmAmC0lQlAom4z8oxhIu9usIgyDeIueagoeH1JmQIajJ4gxutZVQDH1Y6Szigp2/9rWaUdDEHuuyQhQeFvKn6WKQbGQrk+xmvX2nZgRf907lr7HcWNLh1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOCCUXDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2BDC4CEF1;
	Sat, 22 Nov 2025 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763774066;
	bh=TmK0ymaRbGnYFBwWDPKvoufQniChA4/p5HNSW5rwn4k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DOCCUXDK6NRPvEW7WVjqDqRvikLNZETxp14lEvjXrEOexGVnJH5y6gk0Z+olezdx8
	 4EshyvU5rLYqAlq84lgdS6MouZYFhL+q2fvWLIxnFc7zqz2CSNMSrhraclcdPg4jRS
	 unLYvOiCD/w4CABgMBmXum9x7DnFD3jGUqhKK6d3W1LiwqTyKPiE3y/sOoVCY8Eua9
	 yZeM/aBkwqJmXgXWDZl+XwWtf7eXckoFGU9Aza5brimVrD3fwG00I0GmVhWB5tN3J3
	 OZJODR9xGQq7Fo2W34AgrGfyIAcU1NjUgIN75TmMKBwRRs/GBSyuKdCDwXCkP0eKUo
	 sGpN4++AqfYXg==
Date: Fri, 21 Nov 2025 18:14:24 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <anup@brainfault.org>
cc: Paul Walmsley <pjw@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
    Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Atish Patra <atish.patra@linux.dev>, Atish Patra <atishp@rivosinc.com>, 
    linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Nutty Liu <nutty.liu@hotmail.com>, linux-riscv@lists.infradead.org, 
    Andrew Jones <ajones@ventanamicro.com>, Will Deacon <will@kernel.org>, 
    Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 1/1] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
In-Reply-To: <CAAhSdy0iwq_ZPzFY5_x_wsbM_H+npSDVv1F=wP=O-_25VChh6Q@mail.gmail.com>
Message-ID: <60f4c500-6e22-ed4b-912b-c9368bad7c9a@kernel.org>
References: <20251014132106.181155-1-apatel@ventanamicro.com> <20251014132106.181155-2-apatel@ventanamicro.com> <012aaa39-a37b-e682-0e34-9b7d7cd87f75@kernel.org> <CAAhSdy0iwq_ZPzFY5_x_wsbM_H+npSDVv1F=wP=O-_25VChh6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-284714384-1763774066=:3073511"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-284714384-1763774066=:3073511
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Oct 2025, Anup Patel wrote:

> On Thu, Oct 30, 2025 at 12:35 AM Paul Walmsley <pjw@kernel.org> wrote:
> > On Tue, 14 Oct 2025, Anup Patel wrote:
> >
> > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > number via register so add common csr_read_num() and csr_write_num()
> > > functions which allow accessing certain CSRs by passing CSR number
> > > as parameter. These common functions will be first used by the
> > > ACPI CPPC driver and RISC-V PMU driver.
> >
> > This patch also (silently) removes the CSR number filtering, e.g.
> >
> > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > index 42c1a9052470..fe491937ed25 100644
> > > --- a/drivers/acpi/riscv/cppc.c
> > > +++ b/drivers/acpi/riscv/cppc.c
> > > @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
> > >  static void cppc_ffh_csr_read(void *read_data)
> > >  {
> > >       struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> > > +     int err;
> > >
> > > -     switch (data->reg) {
> > > -     /* Support only TIME CSR for now */
> > > -     case CSR_TIME:
> > > -             data->ret.value = csr_read(CSR_TIME);
> > > -             data->ret.error = 0;
> > > -             break;
> > > -     default:
> > > -             data->ret.error = -EINVAL;
> > > -             break;
> > > -     }
> >
> > ... the above code, and:
> 
> The switch case is incomplete for cppc_ffh_csr_read().
> Also, csr_read_num() already does appropriate filtering
> so the switch case over here is now redundant.
> 
> >
> > >  /*
> > >   * Read the CSR of a corresponding counter.
> > >   */
> > >  unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
> > >  {
> > > -     if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> > > -        (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> > > -             pr_err("Invalid performance counter csr %lx\n", csr);
> > > -             return -EINVAL;
> >
> > ... the above code.
> >
> > I'm thinking that we probably want to keep the CSR number filtering code
> > in; at least, I can't think of a good reason to remove it.  Care to add it
> > back in?
> 
> We can potentially have custom CSRs as hardware counters
> hence the CSR filtering over here is already incomplete. Plus,
> csr_read_num() already does the CSR filtering and returns
> failure for inappropriate CSR number.

OK.  To me, the most notable changes in this patch are the changes in the 
filters for both reads and writes for the two different call sites, ACPI 
FFH and PMU.  It would be good to document these filter changes directly 
in the patch description, along with the rationale.

I'm also not yet completely convinced that we should allow both of these 
call sites to read and write any custom CSR.  But maybe the updated patch 
description might be convincing...


- Paul
--8323329-284714384-1763774066=:3073511--

