Return-Path: <linux-acpi+bounces-7847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46095FB83
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3471F23432
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953619ADA8;
	Mon, 26 Aug 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+dwtiMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SukSGpuF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536D19A285;
	Mon, 26 Aug 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707045; cv=none; b=oLFFO5/U4WjZaDeH3MObf34tHPm6i4QG7aJee3dU3MfumONLEIKx5IAWhWH/+PE0QzOXOK/Gjl/k6mr2n6dVontSIUJ+UblK2QCH/GB/BW99EO2xwSpf360NfFgRD2we/6PWV6SY1nvdGfosLJ2Dc+z9CHLEKa+96YcQ0w/0SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707045; c=relaxed/simple;
	bh=Wr96xlHde4Iq/q86Pq81lXt/DBJWo0l413IAUdj5WSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUVa6JiT/cYZUW6h4W51G4E0Ec7weoq8N+NrywGQBWGRiZsSk4bEbOkZTZpGLVxqn2PG02STLzkSHtWka/xmxP2Gjx9tSPRuKbZEQ3r+9W2iW+zA7BaQ42HkiGhM390/udN5FgbYF/GqOhfMlYp9UPw5FPv5V8RtnvUpbrjJtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+dwtiMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SukSGpuF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724707041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43rARpIabmoF/X4nl2L65kxlo3pcBgpwUNSnL7OF7ag=;
	b=f+dwtiMZsAypPINdPYjJMSxRgqTYYkRX8/ijDCkQoPWJ6wCDNuvx/uJBedUE8MdqIizpaW
	+ZvQkcpLq2EeLwe0n7+8+6nBpIlb37VvRw0BGg6VbLv3/TFfOkuSw3rDzL/GHCPAt4dGVM
	BpcDb5jbzqkvlc2LyidGKMP9Y/3pbPqzRITxCECELeSY5iCO3IWvgZz6qgJSyHhqQeLlj/
	vR9aVou0rW9G+a0AHY0ts5BGt9szTX/5GCABfbiR1OSlFuljxNlnyzBkJUU7p14T39I67m
	jO0jpSZXLqjYHuIFE+mo/WAeZpv5nyUxPYntSviUx32hXz79XZ1pUxDhl1a70A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724707041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43rARpIabmoF/X4nl2L65kxlo3pcBgpwUNSnL7OF7ag=;
	b=SukSGpuFtbwIxx+NKHCHDL12zE+JC0KFepVFOj288ZMYr7Gjw3F/W6yQ7GQ9sQxNW/LIH4
	rx+3Wq+dLNzvGhDQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Len Brown
 <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup Patel
 <anup@brainfault.org>, Samuel Holland <samuel.holland@sifive.com>, Robert
 Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>,
 Haibo Xu <haibo1.xu@intel.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Drew Fustini
 <dfustini@tenstorrent.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt
 controller support
In-Reply-To: <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop> <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
Date: Mon, 26 Aug 2024 23:17:20 +0200
Message-ID: <87jzg3c7bz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 7:22=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.c=
om> wrote:
>> There will be a conflict in PLIC irqchip driver due to a recent patch [1=
].
>> This patch is not in latest RC5 release but in linux-next. I usually bas=
e the
>> series on latest RC release. Should I rebase to linux-next in this case
>> and send the next revision of the series resolving the conflict?
>
> No, please don't.
>
> That will be resolved at the merge time.

Alternatively you can pull

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024=
-08-25

which I'm about to send to Linus latest tomorrow morning. That contains
the conflicting change.

Thanks,

        tglx

