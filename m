Return-Path: <linux-acpi+bounces-20374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D05D245C3
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07BFB3020B39
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550E352925;
	Thu, 15 Jan 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EC9VvLD6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F418024;
	Thu, 15 Jan 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478494; cv=none; b=ZCGkkYVyoEXrtYDX3Ir3vT1+lTv1ZJxOOaXbWUnThCoYmZQOgMFOYYIsyMusX2+0Zk+lPFxhFKHEG3/Q7e+q5BXzxYzbrArtkikIPQF5Id10OlkWh+zyWAxX9R8S7S8m6L95g08zux0/JNxtfOuqjQlURxjaxcC0980sSyg/blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478494; c=relaxed/simple;
	bh=VWg9tkWooAwTyDYbBBH3VW10anfovUgwUzjPjFnkxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFLRJyOKpZOlUhL9N8nNXlnN9XU5YYGQ3XWxgVk2Z59tyfFZs36meadNeTHMNbakDXZu0gtHoi/5B70DDxuQs/XqUAVddJiC3SxPeRSpcZy0i0YLOk2IejYXOUZAc+j9UTvBEIIVK3B9cW0BVTcmXtWcb524BJcEon7oP0E+1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EC9VvLD6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 93FD940E0252;
	Thu, 15 Jan 2026 12:01:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fIkZKrXH-6Ud; Thu, 15 Jan 2026 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768478481; bh=EHXXD1og8jlFQ9XvOYhFi/5ELaOn5f8KORiwXzjZrQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EC9VvLD6qRCSk8VAYVc6w0Mqczo//dPyeBqvAdgByrGFTu5GELOXEhU+2J1PtdUbd
	 qZKHqfCT8zVgXt2edJvSOs7x/pNPTGu0nBH+QyzBaWWh/VLfqo3posK6TtzQ0PwFKx
	 tpY/4rGN8uakiPCs9/2zvTghvjMYkbJF+q/fY4z65e+4+rp1fmxtLNEqiYvv/chH6A
	 150wv3FYn29WS9oyGXBgYq7iGqCwBcs1hmNNnprYkKbqxdxR3Nn/rn27LjfCuH4epj
	 he4lhNR/BJAh6ain0yOTCBuFF+f6YI+iFUzJVJtFbkzhhZtjFlLh7hRCFfzk2CmKnu
	 gu9WkQAtUUSXQZCciPHRl5occNXtvQ13YUoIoIYbtq/ouGyDe+Kaj9oRLGkGTHSuev
	 TKgEoQ57KSkGwN/0HUJRGJoergzDF2+rdJvZdGTQEMg8rEDBMFxaUeWJyAAF1JaX9Y
	 wimf/aCqUXPQwTV8Q+WNmLl+y1AuFbqwqNzI1NiHEX9JbUxBrCMFD7YL/WP1z85HQ7
	 RdD8MJjoEOUEChm0VvAR22dinY3kzQTj+U7Zuz7SBTQ1rSezb15BmGkKNDF154JNCM
	 waWtXJ1VNvv0ggO6uRCeCCrpt3d4PiC8rnFvXy4PK+h2vG6TXR0Tp7uWUSbTqBlOuk
	 q7j+LiQGnMatEPS5wIP6NiCM=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1B3F540E0173;
	Thu, 15 Jan 2026 12:01:09 +0000 (UTC)
Date: Thu, 15 Jan 2026 13:00:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: Add acpi=spcr to use SPCR-provided default
 console
Message-ID: <20260115120058.GCaWjW-sT7eBr94SEr@fat_crate.local>
References: <20251228092222.130954-1-me@shenghaoyang.info>
 <20260114154656.GDaWe6cFCruAGbJbhe@fat_crate.local>
 <b5d54942-f280-40ab-b445-00b6dc610a8e@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5d54942-f280-40ab-b445-00b6dc610a8e@shenghaoyang.info>

On Thu, Jan 15, 2026 at 01:09:40AM +0800, Shenghao Yang wrote:
> We've been inserting the dumped config into the kernel command 
> line and rebooting on first boot (e.g. console=uart,io,0x3f8,115200),
> but would love to avoid this loop.

Yah, put that in your v2 pls. That's much more understandable.

> It's easier this way for larger fleets - we don't want to manage
> hardware specific serial console settings on the kernel command line
> if the firmware is already capable of telling us the correct ones.

Should also be in the commit message.

> If earlycon is specified on the command line the console from SPCR
> is used, but only as a boot console. It's not present in
> /proc/consoles.
> 
> It is possible to retain it with keep_bootcon, but that uses the
> less efficient (in the 8250 case) 8250_early driver.

Also for the commit message.

> In 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86") the SPCR
> console is only added as an option for earlycon but not as an ordinary
> console so users don't see console output changes.  
> 
> The patch adds an opt in so we can get the SPCR console added as
> an ordinary console.

Yap, your explanations make much more sense, thanks.

Please structure your v2 something like this boilerplate guidance below:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

