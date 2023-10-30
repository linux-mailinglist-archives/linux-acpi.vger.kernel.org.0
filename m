Return-Path: <linux-acpi+bounces-1097-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E337DBBDD
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3597DB20CC3
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9A182A7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HG5UUtFd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QaOIDXiF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FC171DE
	for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 14:28:57 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807F9F;
	Mon, 30 Oct 2023 07:28:56 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698676134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGYwynunSWpp7MY0OO3XJkBFIC76kaNXkC48AoOrAVc=;
	b=HG5UUtFdFYt0Bica1QYIiuNSEnQMtxRj9w+bpsYb3AfvdlKXY7TY7mG0I7mfBNJ26Vb3vH
	ER4H+Nk6g/JJW+Vn/Oi13KEL6TEQLaGby5uQ6JqENOPTd6j2Jmflk+MxodDPQmZZD26+91
	GrnifWswkG3mK1wi/Ks+vRIrhC6i7fLlRRulZxfm8mzbuCumlthapIZTd8RtggLw0yswll
	XBp1pDDuxSh27lbtEBhVahhSXksr9sda76qTJ88Esg4Bwcj203d453C5XBKRoiR5vEavF3
	yZOr9uPr8SsPoXo2eSnlKfAuctUz5lgEeGQpqPKDtf9P6WaWZW8KRQacCl/P3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698676134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGYwynunSWpp7MY0OO3XJkBFIC76kaNXkC48AoOrAVc=;
	b=QaOIDXiFtF6jCGy9EsLrcRusyaTEH5L7V++quj7q1yHWGNZwm+B08xNgGMCk9CUXz1WMun
	3MLluabPLEJBK5DQ==
To: Sunil V L <sunilvl@ventanamicro.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Andrew
 Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Haibo Xu <haibo1.xu@intel.com>, Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set
 system wide MSI support
In-Reply-To: <20231025202344.581132-12-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com>
Date: Mon, 30 Oct 2023 15:28:53 +0100
Message-ID: <87a5s0yyje.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 26 2023 at 01:53, Sunil V. L. wrote:
> Like pci_no_msi() used to disable MSI support, add a function to enable
> system wide MSI support.

Why?

int pci_msi_enable = 1;

So this function makes it more one or what am I missing here?

Thanks,

        tglx

