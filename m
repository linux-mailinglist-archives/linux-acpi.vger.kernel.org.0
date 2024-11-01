Return-Path: <linux-acpi+bounces-9246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C849B95DB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 17:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D91F23EEB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C7155324;
	Fri,  1 Nov 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HpLdezW8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BA1CA81;
	Fri,  1 Nov 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479718; cv=none; b=UBip6bz9orGZMb6D1Fme9CJ8VkyyKMoSlgEgjsuAy15dVCCxapi0Jji+9ReGsY3gbw2A8tYrE8HGgPoi/oAkwb7XJ6KPBgIKV+A4EF6tU6+pWQv0WzrGTr/DN49PMYh9qL6RAsepRUr/7Ne2j7BMSPhnlAsbh44JwsPBqoE430U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479718; c=relaxed/simple;
	bh=kBgcL3BfWWkILvcuUMtI4DpC5265s1HmZIUOzebuBTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImiXFZ4yYPObIc3QE6Owr0TH2frRJeOeV4t92xrnINN+JpFzhRP1fn3jodhqgww6b23MddjGoBv25MA2OxceEVr5KhKBjFEC9FuPWG4vfwUR7Gx10V6nQHv35xOxbFhLbdGFHkcu4GYjUAWyHOmhOicrP5v7rtxA7leTqDU4xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HpLdezW8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5E70740E021C;
	Fri,  1 Nov 2024 16:48:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e_X65bLd7ZEI; Fri,  1 Nov 2024 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730479708; bh=OMMDrgLOSB2qpzgDwcq8B2U0GznJU8oQ+4h52sCCWjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpLdezW89bcbIP48ARNiRiO1jZBz1adgCt9GZooz/jLAxxbfGeYjyAivPmbsqxd4c
	 UwsPIl2tUaVrJ/Wl297DPj87dHaec9g0HbXlGSYtIZznpW9Uc1ARsguRWeJhYJJPma
	 xJE/HibJR0GTPZv3gTluwzBLVNBM/bunsQWgQNrl+vB832YxnerRsP0+hhm+yhRYB3
	 H/9krU239yGIljkrH4zsWBswaPylNbIRfsVW/2MHdTQbc5TyFLoJ6BZuESHMsIY+Ya
	 9h1hCpGnf83g/HNH5Wk/9r4YcIa9DZSBvNhZknlROcuGzVAvOfrZ8z+CMg3gJCW7vM
	 LQCGC4SbXDfo9+PpraS07geDr8IVQtF2nL8i3VCn3ySw1IGQJxoi5u64ItE1GAifjO
	 LvRyxRv1LV7Vfe/MKJ0zhhJW9/0wkCuI8kk6JfvT/UnGOTauwjwQXmi8Vu7zg2kMTN
	 1cl6iINfWBRpdRj/5jaa/YydoLx464xbaPHkAVFFJXNqA+XEDzAakE7+54ozTe8JWd
	 ABl7ElLJnKQh9RVxIdg/IzNPwVYkotG+OidXRQLN2+t31YiY0YoiuffPuD6L/IgU/4
	 d2xUQRRc2lmTbkrBvBMie6B7Xd1kOkO7tHOhx9loF7N0nIUfZLyDfdJI8uXYIAXiwV
	 k50KPDzTo9HOBZfyqjC6tBq0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1085540E0219;
	Fri,  1 Nov 2024 16:48:02 +0000 (UTC)
Date: Fri, 1 Nov 2024 17:48:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v5 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <20241101164801.GDZyUGQbe6g4FqtPf6@fat_crate.local>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-3-gourry@gourry.net>
 <20241101155147.GBZyT5E190IxnQMzaP@fat_crate.local>
 <ZyT_fLBsVLlcnYNi@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyT_fLBsVLlcnYNi@PC2K9PVX.TheFacebook.com>

On Fri, Nov 01, 2024 at 12:19:08PM -0400, Gregory Price wrote:
> I don't personally understand the implications of this switch off hand,
> probably warrants a separate patch submission if you think it's important
> given the original logic is boot_cpu_has and I don't want to increase
> scope change here.

We want to switch the code to cpu_feature_enabled():

https://lore.kernel.org/r/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local

and it is not increasing the scope at all. You can simply say:

"Convert to cpu_feature_enabled() while at it."

in the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

