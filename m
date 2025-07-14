Return-Path: <linux-acpi+bounces-15147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DECB04634
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D2517DA0C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E8263C9B;
	Mon, 14 Jul 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jS/5Spj2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476281C28E;
	Mon, 14 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513065; cv=none; b=VQnTv3mSSP1iVdeRv6hW0GJcd9nOprPSaW29uvJ0528CPlXzK8PClg5mP8alBpCPRCk7JKDGLwX/8AEQs3jwzA2oElZI0XErZGSlFu14wb13o9UsWv/H5AQmjRIM48cTHG+s/6MhPsK0fLVyhiqVZQ/HUit7cmw7lr3oOVVFwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513065; c=relaxed/simple;
	bh=HrEik8OS/TomELtGnOcuXDGl/ZkDKHaioJAklEd7Hcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvm0h+/Ws4m+2XjBLHGDEBJHgdOahm4p640sN1yWnBLkDUGehGUiyf/jTiXMPykTYYe5EpztinD3gnyCOv9Uc+7z4Iev7YLhSY2ZrIaFzOCO7Pw6f9DehdYjanHVJHrZVH6c2Bo+lEbgp3o4VV4f5jxEV/g51lr/aXCkf9LAL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jS/5Spj2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 341A040E0213;
	Mon, 14 Jul 2025 17:11:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HU8HYa_y-qGl; Mon, 14 Jul 2025 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752513056; bh=H3LHvbA3luRk3OzAQbn3IeTQ0AzAwvKzHasVSRUwFyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jS/5Spj2fYjgTxALNG/evjM16wSmihOkego297u1qXLMdcgikGmi1iJyK5503wiLr
	 UQpwz2pH56HSGh5dh69VHqO6yhACoe/IJngx5ZKp1gGnABll4zCoAN+3/raXkLRQl9
	 T9vItKpJh/kS6zH/0FUcwKtqd61RP2J+066yS2X/ZnM1VQzSrPs6NkVPEY4e+GxaLY
	 gDpIDiO542tyTJuZaGw6ldn4XjeUpb/bqtO8et2WAYF/8ZPtHJ46F/7g+LCS2fjvg0
	 HRcHlkPtHF9rQDQ27NXuCcn5JHvAWzlJ0s6BPoeGFOkuFe82Vug7svwWb6ZpTQfVrq
	 0fmelAsIoDrN93rhyTFIM2B4mSZ/NM6a2mMV92J4BNRfAPhPWbZX502g454QaumgYw
	 0I8PV/PLLDf6poWSShlVZI0FXdsUC7wMHtLVhJX5bw05IIZIyiwjPyDqoPD8pu5S16
	 NpeUB8ybjs0Yd+H6jYiUO9ud5/JgXB7JC2xJoqAYVuvx9DuFwKkxD73MSmr7gujETe
	 RVyr/G/4SsUckKVq/6KoDCX1A+0nYdtOy43W5rlS4qVcr13KdOyn6tFw1Fmnl/20jN
	 ZXFM60aELrm9+jouGa8GzNGQcr5n+qe+RlmTRuW5J65dLWeSoNKJ3TvcxRCK+ycqlK
	 2++DAUMt9tbRPpBt3ozsw6MI=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EAB840E00CE;
	Mon, 14 Jul 2025 17:10:46 +0000 (UTC)
Date: Mon, 14 Jul 2025 19:10:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>

On Mon, Jul 14, 2025 at 09:57:29AM -0700, Breno Leitao wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f0584ccad4519..3735cfba17667 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -118,6 +118,12 @@ static inline bool is_hest_sync_notify(struct ghes *ghes)
>  	return notify_type == ACPI_HEST_NOTIFY_SEA;
>  }
>  
> +/* Count the number of hardware recovered errors, to be reported at
> + * crash/vmcore
> + */

Kernel comments style format is:

	/*
	 * A sentence ending with a full-stop.
	 * Another sentence. ...
	 * More sentences. ...
	 */

> +unsigned int ghes_recovered_erors;
> +EXPORT_SYMBOL_GPL(ghes_recovered_erors);

If you're going to do this, then you can perhaps make this variable always
present so that you don't need an export and call it "hardware_errors_count"
or so and all machinery which deals with RAS - GHES, MCE, AER, bla, can
increment it...

> @@ -223,6 +224,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(kallsyms_offsets);
>  	VMCOREINFO_SYMBOL(kallsyms_relative_base);
>  #endif /* CONFIG_KALLSYMS */
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	VMCOREINFO_NUMBER(ghes_recovered_erors);
> +#endif

... and then you can add it to the vmcore image unconditionally as a metric
telling that the machine has had so and so hw errors.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

