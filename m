Return-Path: <linux-acpi+bounces-9534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662BC9C6A5C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103451F2696F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D1189BA3;
	Wed, 13 Nov 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ERnhJVt9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8617C22E;
	Wed, 13 Nov 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485519; cv=none; b=NvHuVChJ/qsNCYOQM3zcSxj1/S5oD5T6ZGgz86WMnIU4o/N5NynnBxWoR1KicQ6tCmfHvT32nApiCzAbuOUobMUcEu0WYSrjS/gH1GLuq/iYK1bVDBh4+sWnKUrfX3+u2uhkTnUd0weOpd8SYKHwVfcjGYWmITLUs7+HMLp1Myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485519; c=relaxed/simple;
	bh=kL8BEddGxGjH0DpB/eYrS+fgIjTmq8xsQ61kbgnAESI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcfjmJIBVN9EP69oUOLiJOT4yyK2PHb9uUZOecDobcDStUp5lhXpUDOC8Q+4fY1XI3srmQkOJf6vNd0LNaRwICaE2y4BtA1zs5PJ0NTFiBsTHOq6eIVSq7YCoi94P4uiepOmgW4W5y1pCg9z204hPBgIfz/uzmM+yBS5bnzb5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ERnhJVt9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0A1540E0274;
	Wed, 13 Nov 2024 08:11:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sDRDGvMn3k-t; Wed, 13 Nov 2024 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731485507; bh=ntDhYIuR89H0HGdl+nPO/Nsn3+rUYjQTq2I7rdXCSQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERnhJVt9iW3AjjhQodEB2KxxnYxzDg70j3Hooccs0RBjPqABlCiAPGwE0jCF+fVO1
	 WoUXbNe5zqlWNACBJnpz0Ev/9Nx//ERUuefLnOuPi+5m6yep6j8zp1NgjulgTmi07H
	 DrusJydoazWq9qGyGdvYTvcgdtdMxYraraYfJgXnyc4jxS8J7s+x1QRKKTJ0TgbCKT
	 GT6vBfCOZ+zwPuMurJ1ofeIo4NIySbuneT+B/mDNp925UXwZfyqfoJS2OZD+Wfok4E
	 U7b7AoDL3oMnKMz9SY9CXTi9dqoZTmaOyy+Rc2BtS3/5eboghRagQemEE5FJeq7BVQ
	 4O+dn3aHm9+plfMrSVeU5CFy6RfnC0JJY+zSs936oRzcR60ujIPVmjlFIoiziIRUT3
	 MK+8jQOsQQZvYYT+CxwbKvXB0O0pOs5vR/BmROB44ImqKesGU86Nm9c8t/ulb6mYjd
	 6lgdU0TKLhz8b+6TZ1ctJn46SAEDto4hLRWfx+2bB0ziXgkZwEyC7f171eClG6kbe0
	 vqP+1fhH2xFAntRxupF2saULxYjLYlqSp8+DZiS9/YWLPTN8vWoyLnm1vSR4sso1Fq
	 qFqKDHp8g8DLUAS/4Sl539DxEao7vlCF3is1oinTz8P54qmLQDonxzvZTK7R90vOFq
	 Gv/6GkPicP9f9zJeDHZc/J2E=
Received: from zn.tnic (p200300ea973a3157329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:3157:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18E7D40E015F;
	Wed, 13 Nov 2024 08:11:37 +0000 (UTC)
Date: Wed, 13 Nov 2024 09:11:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 5/5] cxl: Add mce notifier to emit aliased address
 for extended linear cache
Message-ID: <20241113081128.GAZzRfMIuLpzwHY_R7@fat_crate.local>
References: <20241112221335.432583-1-dave.jiang@intel.com>
 <20241112221335.432583-6-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112221335.432583-6-dave.jiang@intel.com>

On Tue, Nov 12, 2024 at 03:12:37PM -0700, Dave Jiang wrote:
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 3b9970117a0f..a8ad140d5692 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>  	MCE_PRIO_NFIT,
>  	MCE_PRIO_EXTLOG,
>  	MCE_PRIO_UC,
> +	MCE_PRIO_CXL,
>  	MCE_PRIO_EARLY,
>  	MCE_PRIO_CEC,
>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC

Why this priority exactly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

