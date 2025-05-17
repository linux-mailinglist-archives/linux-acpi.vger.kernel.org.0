Return-Path: <linux-acpi+bounces-13764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF09ABA89F
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 09:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8195B7A5D09
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBBC1C5F14;
	Sat, 17 May 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIST7hY2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BED17E4;
	Sat, 17 May 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747465973; cv=none; b=nAbW/OsCqLTsyTZ8RuTi6nJYJ/82FsjXVF54ivjC8cRa69Job0WMPfYJjY/lFExM1JbJr4Ji+jvQaWJ0TEPhrMm04/8Xcx4C3n+GE8NjxpXWkvuONd6GJiYENFM3rqYYQzEgoYuWhXgRx53SMzbh4XppaCPXnYflFc5ojOqoqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747465973; c=relaxed/simple;
	bh=Kfh7EworHewU7d8WTF/gnxLsAf6Ep1ThneG8fXa6LWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsb4rupYqbH65Vao3zHr/QE+YkJw+0yUzOE8r6qLNdLpijeiJs/ZapU5ZKV6YXbvmr03WInry7Ye+YvfaEuRLtUjHbdQH3kNAYC8gBTxZgxLX0Ucvvm1K+uNe+BkLQ3TOR1UYExWRTvqOti9+JnHHZjQcjo1X40tqdywY7XVSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIST7hY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20BEC4CEE3;
	Sat, 17 May 2025 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747465972;
	bh=Kfh7EworHewU7d8WTF/gnxLsAf6Ep1ThneG8fXa6LWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIST7hY2mns6caxm2l+fYdD6IU7MQuJBJkZEwNhVsa5Nn71ygw3JR2TRGxkVcSTSt
	 j2HV07l10mW9NJHYPka+W8SchEy/SmWalEIWVdkC6j4qIYR8mbtT1ewXIuKN5IV7Fz
	 XMyxO3b+fkcytYiPpTfD5PxJnLdtoYGMlZjS1nAtOVBODvtEPqwwiqn53yj5ndxFaL
	 aFOpFWQ77LCrXZIp5MtL8dAwasyMKvR0goYWhQ7JevULSEUm7m9RbPq+pUxzv8GQg0
	 73Qm4cNKm82Zz+AvqFoeGNm5CbCQrkQl1iLgEgnwr2P0JQmRXGqgWIrfX8OJBjt6/J
	 7KrceZdHuPsAg==
Date: Sat, 17 May 2025 09:12:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to
 native_wrmsrq()
Message-ID: <aCg27zLhBM5d0dAI@gmail.com>
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-4-xin@zytor.com>
 <aCYH0UQzO_Ek27js@gmail.com>
 <68dba45c-a677-4f6d-b7ec-e896aef3d27b@zytor.com>
 <b8f741d6-47a1-4cc8-a5b2-45ee86fcb773@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8f741d6-47a1-4cc8-a5b2-45ee86fcb773@zytor.com>


* Xin Li <xin@zytor.com> wrote:

> On 5/15/2025 10:54 AM, Xin Li wrote:
> > On 5/15/2025 8:27 AM, Ingo Molnar wrote:
> > > 
> > > * Xin Li (Intel) <xin@zytor.com> wrote:
> > > 
> > > > Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
> > > > conversions when a u64 MSR value is splitted into two u32.
> > > > 
> > > 
> > > BTW., at this point we should probably just replace
> > > sev_es_wr_ghcb_msr() calls with direct calls to:
> > > 
> > >     native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...);
> > > 
> > > as sev_es_wr_ghcb_msr() is now basically an open-coded native_wrmsrq().
> > > 
> > 
> > I thought about it, however it looks to me that current code prefers not
> > to spread MSR_AMD64_SEV_ES_GHCB in 17 callsites.  And anyway it's a
> > __always_inline function.
> > 
> > But as you have asked, I will make the change unless someone objects.
> 
> Hi Ingo,
> 
> I took a further look and found that we can't simply replace
> sev_es_wr_ghcb_msr() with native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...).
> 
> There are two sev_es_wr_ghcb_msr() definitions.  One is defined in
> arch/x86/boot/compressed/sev.h and it references boot_wrmsr() defined in
> arch/x86/boot/msr.h to do MSR write.

Ah, indeed, it's also a startup code wrapper, which wrmsrq() doesn't 
have at the moment. Fair enough.

Thanks,

	Ingo

