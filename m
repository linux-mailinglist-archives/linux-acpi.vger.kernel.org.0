Return-Path: <linux-acpi+bounces-19438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D57CA77E8
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E33F30F74EF
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743B31A056;
	Fri,  5 Dec 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToGCcFvz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361452F39AF;
	Fri,  5 Dec 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926396; cv=none; b=S+v6rUVLdKtmuBeGN8M/jPnVB92pL/WJdcXdlii0NrpkpYf3LgcIZiceE4efFZXOI4aoIfH+rBGFXyLr+xdzinVjTtTh7llOS6A9mC77zfBSRqB9A176osM/yjn3a35ahoTfWqqzhiey38v7jyFAnUb0AUGxe9WJwDfG3xGSd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926396; c=relaxed/simple;
	bh=lT/pcudMAAKNEf3hMBI+w8LvgOnpEyMVbtlvH+s44TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJTCrT9BjTGCNTi+bdHu+fwJ8Q5a0VF0glNsXicTxcYX6RO3BTAMdGKEbOej0uIGdqhDWCI0Cyci8X+p4S46XTmZSnB5vVXYAWaB4oBHJ4gyXvx2eY+mo07WWFR2K1Ubs2lgIcVqruEavqEwYP6uCHI6J5vxbn7v1FvmXLniOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToGCcFvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA1DC4CEF1;
	Fri,  5 Dec 2025 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764926393;
	bh=lT/pcudMAAKNEf3hMBI+w8LvgOnpEyMVbtlvH+s44TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToGCcFvzkGWEjf2WJrzAPi48BHo5sW+oO10ov29Xjq4vN/ZF8PCrHJvpdiDYdcdI5
	 itHqws2a1iC2oG3SEzu3f4+0VFoOEC9xEptcaK1gBUnkZKLQ3uGZ324GgqpDKtFtPv
	 XPCl6w1vJ+A3L9MXpe2g/ugniYzZwjJavraDR5RzI4ybXo7APdYBy+VNPiYHFIRYf1
	 B04f4yNrafui7+Ggka6n9kZa0cEJlc/2EiEPliSwoEJiXJzCb2KDEijZXLajkpcGhX
	 bCWwmv7Fyw6WqG94t+oEJRP14ruHt7vj5smyheFyQlLoj+vPHiDcV6kshed8uDk9+j
	 RRpYvoRDO6shQ==
Date: Fri, 5 Dec 2025 09:19:47 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/26] genirq: Allow per-cpu interrupt sharing for
 non-overlapping affinities
Message-ID: <aTKjsz4TkqmPN678@aspen.lan>
References: <20251020122944.3074811-1-maz@kernel.org>
 <20251020122944.3074811-17-maz@kernel.org>
 <aTFozefMQRg7lYxh@aspen.lan>
 <867bv2pbsw.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867bv2pbsw.wl-maz@kernel.org>

On Thu, Dec 04, 2025 at 02:21:51PM +0000, Marc Zyngier wrote:
> On Thu, 04 Dec 2025 10:56:13 +0000,
> Daniel Thompson <danielt@kernel.org> wrote:
> > CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == ffffffff801c2398, ra == ffffffff801bab00
> > Oops[#1]:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-next-20251204 #20 NONE
> > Hardware name: mti,malta
> > $ 0   : 0000000000000000 0000000000000001 0000000000000000 0000000000000000
> > $ 4   : 0000000000000001 a8000000020e8008 0000000000000000 ffffffff80c23b80
> > $ 8   : 0000000000000004 0000000000000000 0000000000000000 000000000000002f
> > $12   : a8000000020f4000 0000000000003ff0 0000000000003000 0000000000000003
> > $16   : ffffffff80d095c0 ffffffff80ceb410 0000000000000019 ffffffff80c378c0
> > $20   : ffffffff80c4bec8 0000000000000000 ffffffff80e00000 ffffffff80de0000
> > $24   : 0000000000000000 0000000000000010
> > $28   : ffffffff80c20000 a8000000020f7ec0 a800000000e12fcd ffffffff801bab00
> > epc   : ffffffff801c2398 handle_percpu_devid_irq+0xb8/0x250
> > ra    : ffffffff801bab00 handle_irq_desc+0x48/0x88
> > Status: 1400a4e2	KX SX UX KERNEL EXL
> > Cause : 00800408 (ExcCode 02)
> > BadVA : 0000000000000000
> > PrId  : 0001a900 (MIPS I6400)
> > Modules linked in:
> > Process swapper/0 (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
> > Stack : ffffffff80c35a2c 0000000000000002 ffffffff80e00000 0fffffffffffffff
> >         ffffffff80c50000 0000000000000001 0000000000000003 ffffffff801bab00
> >         0000000000000000 ffffffff805d82a8 0000000000000000 0000000000000008
> >         0000000000000000 0000000000000000 0000000000000000 5189d95a7a4f4800
> >         a800000002014300 0000000000000002 0000000000000001 000000000000001f
> >         ffffffff80e00000 0000000000000004 0000000000000000 ffffffff801bab00
> >         0000000000000000 ffffffff809ec128 0000000000000001 fffffffffffffffb
> >         0000000000000001 ffffffff805d7ebc 0000000000000000 0000000000000000
> >         ffffffff80c23c80 ffffffff80c50000 ffffffff80de0000 ffffffff80db0000
> >         0000000000000000 ffffffff80112f10 ffffffff80c23c80 0000000000000000
> > Call Trace:
> > [<ffffffff801c2398>] handle_percpu_devid_irq+0xb8/0x250
> > [<ffffffff801bab00>] handle_irq_desc+0x48/0x88
> > [<ffffffff805d82a8>] gic_irq_dispatch+0xc0/0x288
> > [<ffffffff801bab00>] handle_irq_desc+0x48/0x88
> > [<ffffffff809ec128>] do_domain_IRQ+0x28/0x40
> > [<ffffffff805d7ebc>] plat_irq_dispatch+0x64/0xe8
> > [<ffffffff80112f10>] handle_int+0x134/0x140
> > [<ffffffff80110dc8>] calibrate_delay+0x158/0x290
> > [<ffffffff80d58e48>] start_kernel+0x754/0x7a4
>
> This hack fixes it for me, but really, mips needs to grow up and stop
> using these antiquated APIs.

I can't comment on that. Literally the only thing I ever do on MIPS is
test kgdb ;-) .


> Can please you give it a go?

Looks good to me.

Local testing on MIPS worked nicely and I got a successful build back
for the kgdb tests:
https://gitlab.com/daniel-thompson/linux/-/pipelines/2196473049


Daniel.

