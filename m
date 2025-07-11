Return-Path: <linux-acpi+bounces-15108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F65B0230F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656293A6D1F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB12F2C6B;
	Fri, 11 Jul 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHIV7VU8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28F2F0E5E;
	Fri, 11 Jul 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255917; cv=none; b=IyNgk+o1gJaAxUNzE1npamj+feIGxoNPrxern0TJ8uAf9ICCNw/Pdnr0mlAMcIBsji4YD5nBoMjGmswruaSJczdlGy39bx4skMFzxnhceV4Gc+uBZNfq2OwNOgAMV74vYSg1FY/ERbq/cr9K28G+tp/QxqeZ7rvg0JqztIdvCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255917; c=relaxed/simple;
	bh=gTiT/0NnpWkrulw6wrxpgViH2cVPSMHzQqrkNhk5evM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/VTrcZWXYxAS4LlcBxckTbTaKbP6+uFqv/puUac4mvGIpKlZ+2Lr/8wriIovbJT4JiuVOnX5jEDC4bD/hmioAK8CJt54xsLOkyXaAEpRHWxnyBlZyFwiRC5qhqBzGLWqSm7KNrppiF1dB0AwksPG7H0XkUSqquCfci2F21A994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHIV7VU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA8C4CEED;
	Fri, 11 Jul 2025 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255916;
	bh=gTiT/0NnpWkrulw6wrxpgViH2cVPSMHzQqrkNhk5evM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHIV7VU86yQ8onOtR4vxjTJWigHw9S/Ly/U0j3sd0XZTpgcPH0P8DPRSuEazjO2O9
	 mL3HcO8hpMlf6bxngmynfsXFBv3NQlAFaFVCZo8Ed/yPXky0rsMSWq59xioGBFtlNa
	 QroVdcwgX5T9LX/igutq7/JENA+b+U6+l+ldvSMjwsKyATgbWAyR8y+lwSNWT/kNxY
	 PThoJ5JxVNmR/76PnSUP3uMI3SVfEg7AlnRwRuZZYyZRZcRx3SMojthOPhL+wi5wJN
	 LlnkS6JwUh76i6eJdIzCieNBY7uXZyfSiReOnxlmUOuVCmV58B53XXh1sdgNTbkJSm
	 GYJY1dKOwCqQw==
Date: Fri, 11 Jul 2025 10:45:14 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
Message-ID: <aHFNqhfZG+VQQzTv@x1>
References: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711140013.3043463-1-sunilvl@ventanamicro.com>

On Fri, Jul 11, 2025 at 07:30:13PM +0530, Sunil V L wrote:
> The presence or absence of the CPPC SBI extension is currently logged
> on every boot. This message is not particularly useful and can clutter
> the boot log. Remove this debug message to reduce noise during boot.
> 
> This change has no functional impact.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks, I'm pleased to no longer see the "NOT dectected!!" when testing
defconfig on systems which don't have the CPPC extension.

Tested-by: Drew Fustini <fustini@kernel.org>

