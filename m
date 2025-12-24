Return-Path: <linux-acpi+bounces-19838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03686CDB20C
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 03:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AC363029C7E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 02:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB827057D;
	Wed, 24 Dec 2025 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DIYZBHup"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF337273F9;
	Wed, 24 Dec 2025 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541977; cv=none; b=kkvHJ9gX9sJjb3FOOaeoNgh7q801MEDwmXA46jhqfKJBaaNeWqccx3BGA9MFtCOAbxsgVEMe7o2dHdTLX9dzIHp5popU+ODCYXEKdGl02d10eqNnadXCfrIT28xYXHRC75KrtUd7UnhX+bYEg6wvjYW2TzD1E+RPd7enTFGJn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541977; c=relaxed/simple;
	bh=1iaX5ih95yB+kO0SCSf9xE8YOY6V/dB8BzBIPCtUk7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evuogHnZLJlob7xe1CUWf3HXrrrsxujolL/fMNEjIU8v1lFdUbrc30CVSLXwE/67fUbFkGeXyzw2u/0f+1iU/Boo8D5hd1aF+dFrcxDtIGx6K6iUpt8kT9HbN2Me2C14NBMZuBX02jiSu6eEznEPoDuAG25xfP6hpPEUmoRWgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DIYZBHup; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC7AA40E00DE;
	Wed, 24 Dec 2025 02:06:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E5N88FexquTl; Wed, 24 Dec 2025 02:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1766541957; bh=bbBi2A9sGDF2J1/EZxmQP2hmkCPTh1i0daegUSLwnko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIYZBHupEXkgijdEcr8WWVbGwxwwax5V5zSmnQ9ZWr0Z10pejR6HwmZ7gXU6zjWRi
	 Zb17gVmOw4AHe6XOXujcAZq3E5KekDtw+hHlVzItT2iLnxOEp/KiR5r3iA180/VIx7
	 9amF9OrvmXJS/lRArWRQyqMh5wQG0t3TkPki/LZm2eIcR9pjs2/w0A4jG+yWMYmQoL
	 82m+dZgum6Fh9VhWYVQP5Y4EDgZuIG8nEAcCZ+NLrfH11+EBc956TSMFojG9lbMcnh
	 3a21H5p1oQsA7dnOBZJ8v0+XZDF0Qk5cVn1+xoM/knmawdszg0wR9domtstSQ+0j7i
	 nm9QOgCiZuYqZrwlAkMQkUjO3QATIpUWE00Lc48GTylFItTqHU2NesWrcW0jIwe1qt
	 mzljeSYBskoxTOy2aw0i7XytniV1I2z55b874iaTqHcCMOXpSv4DZTE/cgl/kNsFN9
	 ATBc2LnahPb5tF1ddGeVK/Mp/qfLlNAmYe99HuiVaY8LD/JlaHjL3+7FFHSckft3I+
	 RwDdNVTTxSXe4eq9ja8x5KjV9CxO1tBIq6oPX6MrnOpnfeEuWnP6SW63wIvI8wRbAn
	 OqER92GB1szuOXgBPJilPJha1r7DLPnXHMYWmwhkfr6r/AstzNpYY02y+XQEAHUltV
	 L+6oqvfYZrnl3q/ViNt/TWPE=
Received: from rn.tnic (unknown [160.86.253.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1F56840E0252;
	Wed, 24 Dec 2025 02:05:41 +0000 (UTC)
Date: Wed, 24 Dec 2025 03:05:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, AmandeepKaur.Longia@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
Message-ID: <20251224020532.GAaUtKbE7vA4ian0LU@renoirsky.local>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223100914.2407069-1-lihuisong@huawei.com>

On Tue, Dec 23, 2025 at 06:09:08PM +0800, Huisong Li wrote:
> Huisong Li (4):
>   ACPI: processor: idle: Optimize ACPI idle driver registration
>   ACPI: processor: Remove unused empty stubs of some functions
>   ACPI: processor: idle: Rearrange declarations in header file
>   ACPI: processor: Do not expose global variable acpi_idle_driver
> 
> Rafael J. Wysocki (2):
>   ACPI: processor: Update cpuidle driver check in
>     __acpi_processor_start()
>   ACPI: processor: idle: Redefine two functions as void
> 
>  drivers/acpi/processor_driver.c |  13 +++-
>  drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-------------
>  include/acpi/processor.h        |  34 ++--------
>  3 files changed, 86 insertions(+), 77 deletions(-)

I'll run them on the affected machine once I get to it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

