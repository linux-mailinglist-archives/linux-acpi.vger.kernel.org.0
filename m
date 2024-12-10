Return-Path: <linux-acpi+bounces-10071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F399EBE6A
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFB1164E78
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDE23D407;
	Tue, 10 Dec 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hpe8Lr2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PJtkGAZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47034211286;
	Tue, 10 Dec 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871094; cv=none; b=OVPKQ5vPga9WnjHSBRlS66xsaXqDjFafx319K+Ez5yftbKPqGMnQMAUO/qkykj1yr3L0wccL/9MfcImP9tzckE1SnLPu0ltwQ75Ln+rubB9G8i6Jbxs3oYUe3cvlQcqxfn4XibYkEERhUr2/RJlerq8qw6FFhvwUfnLDyZzyOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871094; c=relaxed/simple;
	bh=K69Ux45BD8TVLDUfli+RAC+zkcPgZgSuvQUNWUWX1lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gt918CFVgYUFAKwJEN5DdmacWKFA1GTScNXrX7sG96zJQXUpONMZKRPD3Bs/FK96bcweCpuQV4PnsbAsspxctdGwM/Ad/6S0OLK8duw3wBsCgWJ9sp/8hyp2Hm+IhixkLVQ82vEdybWLJQJNX7nidN0Ct7Wpox4ZBxnQK5FhcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hpe8Lr2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PJtkGAZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733871091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6NdESGpM3LW08eQE9ohvVb9/KmGgoFA5HR70af0DFI=;
	b=Hpe8Lr2pqhN5bEO7kcJO7sOZItSdReaoaNgV6F5j8WhWdT3eaDR/xQppMNiL2yITKPSPKv
	cqq+JQPshlUJ6aifed1kH8yfSXAcjRuFpspC/47e8bWHGXNd0RIgL9Zb5eXHJ5TRga5MNE
	eZ2ErT5FfxGRenJ6UgtMJ+SSvxa1pkL4ww2MNGYt8Biyzfys+6XXYg6GzSyvG27vUJjA1i
	rx3/cHMfcG0FblIvVnQ7JE7aOZ0y+YyRDEABUJwBNJk9SRiGt5YrL0NZDJlYCsmjol/gLM
	Rj06wOplVtYRTYuAestyDOhMkZDkyDbr60Os8XLH6anIkOmhm5zsJOQ9vsRCjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733871091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6NdESGpM3LW08eQE9ohvVb9/KmGgoFA5HR70af0DFI=;
	b=3PJtkGAZWkH22/f2Of6bSYEXRv+PNFiMywj1UK2h1ZZWdlcsHgubHVg/Vee7wJBg5hcew6
	KMT5dvmrCQ8TjhCw==
To: Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org, lenb@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, jmattson@google.com
Subject: Re: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
In-Reply-To: <20241022001712.9218-1-rui.zhang@intel.com>
References: <20241022001712.9218-1-rui.zhang@intel.com>
Date: Tue, 10 Dec 2024 23:51:30 +0100
Message-ID: <87zfl3b18t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 22 2024 at 08:17, Zhang Rui wrote:
> On some systems, the same CPU (with the same APIC ID) is assigned a
> different logical CPU id after commit ec9aedb2aa1a ("x86/acpi: Ignore
> invalid x2APIC entries").
>
> This means that Linux enumerates the CPUs in a different order, which
> violates ACPI specification[1] that states:
>
>   "OSPM should initialize processors in the order that they appear in
>    the MADT"
>
> The problematic commit parses all LAPIC entries before any x2APIC
> entries, aiming to ignore x2APIC entries with APIC ID < 255 when valid
> LAPIC entries exist. However, it disrupts the CPU enumeration order on
> systems where x2APIC entries precede LAPIC entries in the MADT.
>
> Fix the problem by separately checking LAPIC entries before parsing any
> LAPIC or x2APIC entries.

I really had to stare at the change to understand how this fixes
anything. What you want to say is:

Fix this problem by:

    1) Parsing LAPIC entries first without registering them in the
       topology to evaluate whether valid LAPIC entries exist.

    2) Restoring the MADT in order parser which invokes either the LAPIC or
       the X2APIC parser function depending on the entry type.

       The X2APIC parser still ignores entries < 0xff in case that #1
       found valid LAPIC entries independent of their position in the
       MADT table.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

       

