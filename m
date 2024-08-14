Return-Path: <linux-acpi+bounces-7585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310E95229E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F4C1C21AC0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3E1BE857;
	Wed, 14 Aug 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1//LuYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HQX0QJn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE61B1505;
	Wed, 14 Aug 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663539; cv=none; b=pY8lAwCCvTIehPbpo6lDxoMXZwfEOPrJwNMnzhL7D76zsfxFOPaqUN28XsWAmxEWrZlhm5yxOejhEuVbJQ2EMDGQFQ3IE1owQLfFbyetXtzVbpC1QW901d/0uW+KvXYNucGRiQhJx4YamSuGy+32ZcvpLz42BPMRoW2cM2Lzi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663539; c=relaxed/simple;
	bh=zUs3GOAzySbTdSc9thjDMsauHmm8D+weS9Iueso+rSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dnn4liexyq2l0ZtI+OGtUoSjHBH6+SGoAhk4OrvPoAhJIYf7skZuy4IdFg/VQwis7YmYT19wE3KGYv6p12cB1wLmSrNCNOvKydcOXgRincmoSykT4p11TLDlCF5JbWUUPe44X4O3aP+2+pTHTFnDv6cWOFq9hpJ/Bg+JRY1KRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1//LuYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2HQX0QJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723663536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUs3GOAzySbTdSc9thjDMsauHmm8D+weS9Iueso+rSc=;
	b=S1//LuYFu3oLHVIwz+8n75aOZTfk43TceWNsotzGY/CwmKLhvhQANbugBHW5KhazKNsvhY
	MHiUIf87o0Mwh2InpLePWQC28uHAwV59dv/V6GgO9eusJjtJfVCy0tA/S3zJB/zkwuI2VR
	kCUjMoZfUNPu8poLe7XZ972W6gv+sVQCaygaggn5+SJcgf7Yrkdcn2bABiIw0B2EMiI7v2
	+VwOpuL1F11/WJNxnUPG6Lnf3iv2Djuel4Ybv/5cjBN5lv4X0Rk5QNoDHshSfvn3ikMSlN
	DSxKmkKKio/ZbhNkj3dI1vft6QCqfPtjKd2fhYBL9pEwINh3zYKKqfB0stt7xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723663536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUs3GOAzySbTdSc9thjDMsauHmm8D+weS9Iueso+rSc=;
	b=2HQX0QJnorphyLQdzCuiqncEDoNPVHAO4W+9YxTbTIwt2+YPEWAJ9rUGs2mr21QFKPxXJt
	YfnVHkJR7oYOOVDQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Baoquan He
 <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson
 <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
In-Reply-To: <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
Date: Wed, 14 Aug 2024 21:25:35 +0200
Message-ID: <87cymaoqj4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 15:46, Kirill A. Shutemov wrote:
> Calculation of 'next' virtual address doesn't protect against wrapping
> to zero. It can result in page table corruption and hang. The
> problematic case is possible if user sets high x86_mapping_info::offset.

So this should have a Fixes tag, right?

> Replace manual 'next' calculation with p?d_addr_end() which handles
> wrapping correctly.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

