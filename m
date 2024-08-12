Return-Path: <linux-acpi+bounces-7540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CF94F648
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3048D282512
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488E18953D;
	Mon, 12 Aug 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZooV+fEs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A9C156;
	Mon, 12 Aug 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486155; cv=none; b=gmSOiTpo28at3bABd/gn0Ry/02Op4l/M3M426ujVpinTiWkRj9hH9jpZA4gLNMtUyMGHq9kisxwEJMP6xWmNZ5ERYTHOx7OCI6CSSrDo1lb/MQfNALn+qp8gEpX3SeqcmHQouO5/8ESaQdW1kEIw+znYDBf5vR8Aeq2mbS9pF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486155; c=relaxed/simple;
	bh=QPpTyfopkmYil5jwSWXiMRdlVekdVghmXXPWM89UkF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FOiHsvDA0ZBAftn8cQFJ8gixvZYO0HMnWOzzMm6XI/CLVvRlqf3Chw+kZLyfRalxjOhWRQGmcTVOGgDPC5LteOBv13X0B8tgVVJIAlCwKgY0TCvfqkaJC4N8kgm+I8ivjbSdljIsGGSk5E+I/mnch/IMSHQR2PzfuYh1QoD2P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZooV+fEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A2BC32782;
	Mon, 12 Aug 2024 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486154;
	bh=QPpTyfopkmYil5jwSWXiMRdlVekdVghmXXPWM89UkF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZooV+fEsbgVhEFJoJTLjXisilpk/izLOGKQdSjbK6BsiT3Mb3o4FqzNVOdzJ40HNN
	 G7D9unrBKPh2vyCeE+R7ZrkvVbuAHrJGI0AJW4x7nruBcaMLB7xyzgDIY/4mOdQcVg
	 OmWfzCXHyb54ARdVK19hknVOBXnJst/6h6XsjmjYQR3WK4HGdnI5i0UVbvZeGOxfOE
	 mwjevX4IZAJiVv6AzW3NYqXJiL12WqWuQnPX+GhD4lyjwWJOZ3fH9gqTdC21LIUjCQ
	 YIhbpf9mjzpAqkvlPduYxsdOs6w2NMz7kK4qIsW5LZA160D5y/rWFqfya3aTWa58H4
	 TnydXrSnnR/YA==
Date: Mon, 12 Aug 2024 13:09:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <20240812180912.GA286962@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812005929.113499-2-sunilvl@ventanamicro.com>

On Mon, Aug 12, 2024 at 06:29:13AM +0530, Sunil V L wrote:
> The functions defined in arm64 for ACPI support are required
> for RISC-V also. To avoid duplication, move these functions
> to common location.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Will Deacon <will@kernel.org>
> Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>

Looks like "Björn Töpel" got corrupted somewhere along the line.

