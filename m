Return-Path: <linux-acpi+bounces-13063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD13A8A8CA
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79C81894EB9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30D250C13;
	Tue, 15 Apr 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YxXSNTpc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1455227BAA;
	Tue, 15 Apr 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747560; cv=none; b=oGmHeMq/LiueOMFmGRrGLnQ13cKwdJ77w/T/uFN3mTAGYDwxDgZllQ4Ui9OUDyVXMQxgUDvATU3O2t1XYusIth2uOydAxexwJtOJMkdoaLGiXQZOXuDJm7RVNN9wJCEQYygzksDvU9fWv3wgg8fudZ+taWa2VLV6xNYHEsiI01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747560; c=relaxed/simple;
	bh=cDVB313I6ctAp9aPCnjZWpGOuAJObbuleUvYXF/aSBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X05I9R0bNunGXvD4cE5Yr+5B4Hx+RAOd3fE48+JeWphYKihlD8IPPHD9SGsZw6UtJLv3n5Z2BXZOvXrL7u4T+IijXTLLaDPiDSH/EnghjJjabAjeaAQ2B8uj4TYIRGHuDH5n8x0q+0kBM85+Xefd9FjJu+ITTWMbNJ8wmbsRNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YxXSNTpc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE17240E0200;
	Tue, 15 Apr 2025 20:05:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mk4w7mzXCncv; Tue, 15 Apr 2025 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744747550; bh=4bM3ezGutVm5YLRMBhVeBIqHC2Z19IfnWaXa4ro9pD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxXSNTpczFCu4Z4ByThX7i5fQrqI2ZTC4kIRQQ0AZ8vZC7LS8Ti7FZYN9o45orxW+
	 OSS9py1IC4ND7VmhIyUDgCRytyB8oArJJzKab91+hCmbCDned2AWzlE6FVvh8g90eb
	 l38JLT2fYwSDeL1Fw4buYauPm3RMWn6K5uBVySmzqj6jZT9p8T5iRYIK05O8Yz9Gzy
	 EKijTryf7UNsAh7iFnDfXDw+8LpJc04H2G11NSe8or5jkEQFAx+VfGgkzasnnK/rUZ
	 cAE7B634Wh34NeZe9k9XezaEVq1MxYYlWUmbWBSrIQyXa/ritcfOleeB134jNSLzIM
	 V9UM3FoiDqRJj6/fnFOfJTVOmRpDLuG1MiGlEsyDovVKu74Ds++Jmf/1CcyXevB4Up
	 ZaA/74gTyBVgFdWFRaGoTGwfUIwE5Lu1X4EK/RV0xgjNHdXU9rTiFa6mHoIFl7ymA+
	 X9AAuUa+c7fbz1VnthwHlaOc6B7/wUqTSnr95aIkFS+RRRk7L9V5V0S6/OIuwnqhYA
	 L/WFj97kiMLbHEcS3q8+xOOV6IdWIfGXSxaeNTN6RMiZkv/r8TiPlDfBHzTy7iJXPt
	 x2iaZrt5QGWbT2tPqSfxvqW93BH9YP3/9pv/XV/XYmLQuItyRIewvAIuRxOFW9uqK4
	 IkuQ0WiJNx1N3gVDkxzNihhg=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDCBC40E0196;
	Tue, 15 Apr 2025 20:05:36 +0000 (UTC)
Date: Tue, 15 Apr 2025 22:05:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 2/3] x86/cpufeatures: Shorten
 X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to X86_FEATURE_CLEAR_BHB_LOV
Message-ID: <20250415200529.GKZ_68Cb_jaUblKmTS@fat_crate.local>
References: <20250415175410.2944032-1-xin@zytor.com>
 <20250415175410.2944032-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415175410.2944032-3-xin@zytor.com>

On Tue, Apr 15, 2025 at 10:54:09AM -0700, Xin Li (Intel) wrote:
> Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to X86_FEATURE_CLEAR_BHB_LOV

Yeah _LOV is too cryptic. I've called the flag X86_FEATURE_CLEAR_BHB_VMEXIT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

