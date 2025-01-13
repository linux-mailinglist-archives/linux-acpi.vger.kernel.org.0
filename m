Return-Path: <linux-acpi+bounces-10549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E556A0B77E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A861643D7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12B233D85;
	Mon, 13 Jan 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gZAuXuQQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9781CAA94;
	Mon, 13 Jan 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772665; cv=none; b=dcjBCi8oncJ7ehTHPx/WENAswosoT93+2nvpDjz7hoM/pCP4wZW7wNpYNwg5QmZAzpiG4zl8PivAzl1UGwYTRjt6gLESGCbpbc1g6yqYQnFoPPYn6jMZNDQDuJeXpwuFPJf4m9cW7z/+vJuCCuKvN73GhpJ4Trksnan2RP/Y+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772665; c=relaxed/simple;
	bh=xmuJEHbzKx2Ewy3hz9GAsvpIb+AQNYPsv4qspSltbh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW2MQYD2xD7G3XmkDpcQlB14hyenMAbJpvkTdvmH6gR7MTKFXL618RhRMd3h9U9ghEARacp39cwQphZdTJIsIOKx2TrTnZ7hizADDu+KMV9/pSyEr4evOs1cNAnppK807fEPsIH33GNZDaMqKAUJYjKNg1+HJYsjtXxP+hdPqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gZAuXuQQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 860C240E0163;
	Mon, 13 Jan 2025 12:51:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xbEicsve7YXt; Mon, 13 Jan 2025 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736772657; bh=gh1AJ5p8OkXQHUsIR9YibeFO+Bge/KzQk76jBDTfYsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZAuXuQQDy11HvCIjKFqjTG4TjGcp/vpwL28jsUhGHYae83H9j8bte7kAVjLnIwRS
	 qbyi/z7j75LzRwwU9BiW3hQxqVAFIQKCPmaueiQx3TMh2AzLkahNOLLdskD2bGb9aq
	 CZW5odq6IdNpxa5sulT0iOkEgYFWSduh2sJfMNjAaZGZc+LA7S2XthEXbPnv5JaOT7
	 6tiV5kfyyyeZ0YxAyzbvW2d8ylPKIPvlXoGVrhmdMp3sixltsJZfm0r773lMn3FtNi
	 Yuqp1bIxgXKDhDn0ynWxiabbQCTIDHnxggGKgDCJ76JoKVfovn0r1X3KAqAsGqqyf7
	 OTWO1UxbZbuXTGUQBzyZy2qMYYruf2RYQ2ScBzoL1Ou8D6N1UmDdCnvg/pjNXpU96S
	 363abVT0oNOVplc0Kfqu8SwBQ7eEtonz45IJ0fVKe91GuMc03qgFpofKo6a5RhVjzI
	 l8sVWz9qJtO4v48k7v7yXCXDJqBORVDTXGFmCFuDZpY/PmB9wG2/xORU85fXm67JdZ
	 Dx5sjCI2f8xHgFMAluFunI+9Xx8VBgSmwK5VZgt4JEr16I38KVpvMA/RyldqEnc/6a
	 8T0RnGfLunESEA0/zJkUVpTprg+sW80Z9q7a2XVhY3LhWWX3kmwRmoxG2L5ZxHElmE
	 o3Qbi7bhewzjx96vFCKIQnss=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E356F40E0269;
	Mon, 13 Jan 2025 12:50:44 +0000 (UTC)
Date: Mon, 13 Jan 2025 13:50:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <20250113125039.GEZ4UMH770bbNF9KFM@fat_crate.local>
References: <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
 <Z3_TjYzeQVIZirpK@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3_TjYzeQVIZirpK@U-2FWC9VHC-2323.local>

On Thu, Jan 09, 2025 at 09:47:57PM +0800, Feng Tang wrote:
> Also, is it worth including this patch into stable tree?

Only if this fixes a regression. Which this is not, AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

