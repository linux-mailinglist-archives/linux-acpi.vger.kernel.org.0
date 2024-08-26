Return-Path: <linux-acpi+bounces-7826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F5195F4E9
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7AF0B21CA8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53771192594;
	Mon, 26 Aug 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3t4b3Od";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbhSekJ2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC1186E48;
	Mon, 26 Aug 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685938; cv=none; b=j+KcWFuSOgDK02k71jW/i5txvN5ZNFtojQ2GCpaDlFNULgCHyOIXBaXLQZgdxRXCb7yWSnbYKShWMszBey5VXxwarg63xlo9f+K9GvMRSklSKZqCYZrQ1PEo3xo616gu3iSu3hGUpN3YVi+4d5DxVTLAYWvNoSg6iRYtRde/rMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685938; c=relaxed/simple;
	bh=JAzFcT8pBUv5FDzzhZgD0LlS/oqOvRD410hvJXG7SG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GSytWJV3A8MsOd/nNiRvbvlXvDK7ZGerjdbypniMnUkr3pPos/0kN79rJ6JmovR7fpqhcCmsXOa4RPp61/jrL2GHbMjxTArX32ROzcpdgRPZcubz5flvSJoTIXoLOxbydsZjJMIbLuX/ua6C8rsPoN3ubxGpgvILNLmiqKTKAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3t4b3Od; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbhSekJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtqBVIjvewMJmwGbbGrtzP9wseneIF0JG8Xv5MYH9sg=;
	b=U3t4b3OdLu+GAFgNF+W13RPfUi9UpqJlkWXQo/rbtxrF5v3F/xRQunKmlWVgSEBMTg6p9H
	SnfM3j34lgAwsP+QxdwgsSCcglS3v9IpKrJ+A1OKiEqv2VnnbqvJ13QcQaMjWzLSnyLkPb
	8YX+HBqyP/evDscLCNv1QU6RgC0lXWa9ptOHqu9VfLENdJWaHjvQKm9/FyAMM/FTEh4Jj3
	2tmQsmzx0MyFVH3JkiSJxhhpuh/cynV1rX+yM8iV8fZ2hJAFIjVxwKgppVsfP9y06WdQYW
	VwSsRLNnEJPLAS0yNUrXAyAsezewrT8q5YP9MnQhb+9f9zA09h1hQd8jpE5nAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtqBVIjvewMJmwGbbGrtzP9wseneIF0JG8Xv5MYH9sg=;
	b=LbhSekJ2kImTjTpI5qKezEgJdoF+OYa4K93qQL/ngQ9HbLWQbGvavIRCL9Qq9RBtd5Pbvi
	jsetTuVjOe5BLaAA==
To: Sunil V L <sunilvl@ventanamicro.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup
 Patel <anup@brainfault.org>, Samuel Holland <samuel.holland@sifive.com>,
 Robert Moore <robert.moore@intel.com>, Conor Dooley
 <conor.dooley@microchip.com>, Haibo Xu <haibo1.xu@intel.com>, Andrew Jones
 <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, Drew
 Fustini <dfustini@tenstorrent.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt
 controller support
In-Reply-To: <ZrlgVUXC_dCW9ISM@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
Date: Mon, 26 Aug 2024 17:25:28 +0200
Message-ID: <87mskzcnmf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 06:37, Sunil V. L. wrote:
> On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
>> This series adds support for the below ECR approved by ASWG.
>> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
>> 
>> The series primarily enables irqchip drivers for RISC-V ACPI based
>> platforms.
>
> This series has spent quite a bit of time now on the list. As you are
> aware, few clarifications like _PIC codes are also done now. There is
> no major change after you had agreed for the design. So, can this be
> considered for the next release please?

Rafael, if you want to take it through the ACPI tree, then for the
irqchip parts please add:

  Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

        tglx

