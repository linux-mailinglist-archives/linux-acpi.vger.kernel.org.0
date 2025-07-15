Return-Path: <linux-acpi+bounces-15159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205DB057A3
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573541891E3C
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BE2D6614;
	Tue, 15 Jul 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iVMgwS2f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E428F4;
	Tue, 15 Jul 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574746; cv=none; b=ZW5qoiQ/f1kBRgcia/L7ZasP8sm6B2W52t6uJLdqJ1NTzFKVpyF93gD+jvv1IQBlxqMdZCT55G/u5na1aAJYva6sMNjB0goky2CqvzaUfSlIkkOwVBNjYPriad0tLyM2PM7eTXAf1TT33siADItnYbN8yWYSpQ7xNXTdPqs3bCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574746; c=relaxed/simple;
	bh=JwTn+js22wSKjCG4zHc5wIB1/7QyM+1uvR3jU8j82zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5RlWQHXHDKwChatbGWx0ZRZ2Qetw1FpFiTb10j98UeG4xVrhscJ4byHS6pNtLG2VgleEz7nqtNqreV/QlDFGEx2/c/DgB2XkwNYnsIviS+hqax6uMSxBgP5mAvR4Hbc29ns48eV+Gp4jZwqG0LLOhpLpD6XYjCN93BXgfTOgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iVMgwS2f; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2267540E00DE;
	Tue, 15 Jul 2025 10:19:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uypXlsET2J0M; Tue, 15 Jul 2025 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752574739; bh=QKoLKYw9lnujFTl5EUQy6sm0Ni2fS/FYcFpyqD/WohQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVMgwS2fZvs1uFmfKnBk8o0z9gjnpZRBEy01FH/2rMKmjjXAKk5E6mEYVw/GYNsvI
	 CzM5U8BQudkd7R+chZQ7UHfRNbDW7hXzthNbizoh1MWG9fAoRP2ZJKUMu4/iXAgTM6
	 ss2TZkWnGPvjik0vkCHJ9pFtREnYFKAPIZmQzsf8ySayC7J8eNgVoZj+w74UB/zgHn
	 BEGDtd17tar1oKfDO5YCLZkeklrVwgOD0mbm8pwZBAPOMisumzSeKqfw7EbF0bU09T
	 njrzK3POOEchPel1Wzv6nOxWyJisN/ZfPpf4pzir2ryyfL6W3B0XnlmZnuIgZIerqQ
	 hGVL+q/rCrHxBV80eg9cX3ckI72O2Vlx34Y6YGoXo0tvIa9vGqbFjTkDBzINYWCwVm
	 qrCs8P4xrxV9FkNLlRuABE3HFvfb71wLUTUyWuo8hLV5jcgE4RnDs1UlvHqk8TpH/G
	 gjkAlLF4DmGZpOf6e5Ev59aDasf/uY7yRo+k/gt3yubCO+AZoH/TGz+5Pa5+UwcfYP
	 8rneQgPDtxwdWj1iAWskEMQ1K/6D8pTneiJR1x181D5zZ53PPJ9pn1s9tN1/uEtw++
	 N4yvzt2WonxJtKaySPIXajQh1oE4wAJVt3+Bru2r3Jg2+Ykt2w1RyZrEPKsz4KBxMv
	 hq+1dCnvcO0x5TW6Rz+1V0i0=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C68840E0213;
	Tue, 15 Jul 2025 10:18:49 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:18:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250715101844.GEaHYrBJQzLKBsQCTS@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <cw6miesl6kwlpf4p4zjbeemam47n5sljtwbut6qpsadmfykwym@x55nztp5e7ln>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cw6miesl6kwlpf4p4zjbeemam47n5sljtwbut6qpsadmfykwym@x55nztp5e7ln>

On Tue, Jul 15, 2025 at 03:07:15AM -0700, Breno Leitao wrote:
> That's precisely the aim: I want to streamline the process without
> duplicating detailed error reports, since we already have specialized
> tools for in-depth analysis.
> 
> Even a brief value in the crash dump alerting the reader that errors
> occurred would be a valuable aid for anyone diagnosing the issue.

And what's stopping you from examining dmesg from the core dump?

I'm sure you have to look at that anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

