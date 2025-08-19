Return-Path: <linux-acpi+bounces-15825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56DB2B84D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 06:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FEA7A2ABE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2730F55A;
	Tue, 19 Aug 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JsD7IzuZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D32877CB;
	Tue, 19 Aug 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576822; cv=none; b=U1XFeAhNhWH/piiPm8GYTVuRmHlJFjivBQaVC37hDXjQWCkavqqGDGgFp0EsbAS0Pl4dmRIH3oEDXyfdcp++VNfjzrUT8RV4plugPx6BwOP1tPlqgm4/aW1Vfr/KRlyEKoPTCvJmo93kjyCyF+9+xAdp1VNrBBqvvNmWYK4YFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576822; c=relaxed/simple;
	bh=DhIsH4a4nwX9+RwiotdBhF0SwVQjZJAUqYd/yZv69vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4jVFs6ueDo+r0qCc5mdFXemhnQZNk/0V9o3NqmdoenyArPA/CgKGXcZF5Y1RbcR7DbUXvFIXt5YCR6/joj/uI1YbPNat62wOGD6QodygmiB1mRR4kaL9fsBnIX+Mkm/H4MQRdXgpzL+9EiUHSJLqq41ZCn8e3IL9XUUy3Z2KAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JsD7IzuZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D078020231;
	Tue, 19 Aug 2025 06:13:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSk0OFjhhhF4; Tue, 19 Aug 2025 06:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755576817; bh=DhIsH4a4nwX9+RwiotdBhF0SwVQjZJAUqYd/yZv69vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JsD7IzuZeXU2/yFlG8pvtEdg+GtGdWqUU7nxLoo7TjykKicbf4mp6zk/KXK75jnTC
	 nO+8sglKM2rGWBWpT9ZO0H4p1mqYacMreelmx7fHdYEPn1xTHuBDQXD2znGXYd1utI
	 yyxh+SwtjDbRZHeyZAUCtRUghd8WbUdAEfUuzow9qpN1b8NeH/nQP66x9LwhSTk7jf
	 8ogvZnxdnhWn8gt1bXkthvdzkdQjeMs/rhPzRWWwJgWrlRpKr2J0eUk3VrahJIRNGo
	 /XT5I7XnKGzNFYSGRy6R3GfIqxmJZtCUOi6GUZ+UNgB3M6M54n2ET/Xa081Td3mAcy
	 kboUcTnk31PeQ==
Date: Tue, 19 Aug 2025 04:13:27 +0000
From: Yao Zi <ziyao@disroot.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>,
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <aKP553e1S5RCYNhU@pie>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com>
 <aKPu2g1MOZBBzQbV@pie>
 <CAK9=C2XmDGOz9_euC4vtchOxr+8f+m+9zZYVewCc2s7GZhd4Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2XmDGOz9_euC4vtchOxr+8f+m+9zZYVewCc2s7GZhd4Pw@mail.gmail.com>

On Tue, Aug 19, 2025 at 09:00:03AM +0530, Anup Patel wrote:
> On Tue, Aug 19, 2025 at 8:56 AM Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Mon, Aug 18, 2025 at 08:06:00PM +0530, Anup Patel wrote:
> > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > number via register so add common csr_read_num() and csr_write_num()
> > > functions which allow accessing certain CSRs by passing CSR number
> > > as parameter. These common functions will be first used by the
> > > ACPI CPPC driver and RISC-V PMU driver.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/csr.h |   3 +
> > >  arch/riscv/kernel/Makefile   |   1 +
> > >  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
> > >  drivers/acpi/riscv/cppc.c    |  17 ++--
> > >  drivers/perf/riscv_pmu.c     |  54 ++----------
> > >  5 files changed, 184 insertions(+), 56 deletions(-)
> > >  create mode 100644 arch/riscv/kernel/csr.c
> > >
> > > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > > index 6fed42e37705..1540626b3540 100644
> > > --- a/arch/riscv/include/asm/csr.h
> > > +++ b/arch/riscv/include/asm/csr.h
> > > @@ -575,6 +575,9 @@
> > >                             : "memory");                      \
> > >  })
> > >
> > > +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
> > > +extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
> >
> > I think it's more consistent to directly return the error code, and for
> > csr_read_num, we could pass out the read value by a pointer. e.g.
> >
> >         int csr_read_num(unsigned long csr_num, unsigned long *val);
> >         int csr_write_num(unsigned long csr_num, unsigned long val);
> >
> > This allows the caller to eliminate a variable for temporarily storing
> > the error code if they use it just after the invokation, and fits the
> > common convention of Linux better.
> 
> Drew had similar comments so see my response in the previous
> patch revision. (Refer, https://www.spinics.net/lists/kernel/msg5808113.html)

Thanks for the reference.

> I had considered this but the problem with this approach is that
> individual switch cases in csr_read_num() become roughly 4
> instructions because value read from CSR has to written to a memory
> location.

You could return a structure smaller than or equal to 2 * XLEN from
csr_read_num(), according to the ABI it could be passed in a0 and a1 and
thus should require no memory operation.

Let's assume we have

	struct __csr_read_ret {
		long error;
		unsigned long value;
	};

	struct __csr_read_ret __csr_read_num(unsigned long csr_num);

Then a wrapper like

	/* piece of untested code */
	static inline int csr_read_num(unsigned long csr_num,
				       unsigned long *val)
	{
		struct __csr_read_ret ret = __csr_read_num(csr_num);
		*val = ret.value;
		return ret.error;
	}

could provide an interface that I've talked about earlier, and it
follows the kernel's convention.

> The current approach results in just 2 instructions for each
> switch-case. Additionally, the current prototypes of csr_read_num()
> and csr_write_num() are closer to csr_read() and csr_write()
> respectively.

But csr_read() and csr_write() never directly raise errors that is
expected to be handled by the caller. I don't think it's a fair
comparison.

> Regards,
> Anup

Best regards,
Yao Zi

