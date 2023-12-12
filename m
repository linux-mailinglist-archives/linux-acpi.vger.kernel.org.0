Return-Path: <linux-acpi+bounces-2324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C880F23B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84A01C20ACE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABE77F06;
	Tue, 12 Dec 2023 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgqOdJJF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeglcHbb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1B139;
	Tue, 12 Dec 2023 08:17:21 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702397839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=IsSxbOXO8kr3M3mwTOxm60Ib6/Sfb/2lPpnn+xrbANk=;
	b=MgqOdJJFmgzPMEDmG+KroROslkNprpfoHU74xiNAL7cVWSEF9uJx/H6xMOe1hs8M6JcdwV
	aqNSkjoGf1uosmtxiqs2VSeMecva1xF9ohVe1/8AsMuyNKiyOpNY2bIbV7BCRhIcsUquom
	IuKSQNHiskWf9tJxP147+l9C3l1fku1W9pQ632uCK7Iz5C/P5PpY7eEV6ZT0+9Vczshqjo
	hqWGAK4ro8IvWDXKsmwIH5VE7mcy3maKysqP3tTxlFS1d7ZYO9OILS/g02YRkyRQ3FsRal
	ifjF7ZlKESNL62q93CTHut2M1yyEM2Eb1LqeAmTcMfFWfz1uAefeaQ0snpWQpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702397839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=IsSxbOXO8kr3M3mwTOxm60Ib6/Sfb/2lPpnn+xrbANk=;
	b=NeglcHbbPQ8braZWOi4Mx9645ZHZGOKyVZxkWGpxfiHnZ3jr1m1CeS1es7HVy+nQvDXHiB
	BuoFLTTjevqVB+BA==
To: Andres Freund <andres@anarazel.de>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Zhang Rui
 <rui.zhang@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 rafael@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 02/17] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <20231206070423.wp7cxxnwfe3lidm3@awork3.anarazel.de>
Date: Tue, 12 Dec 2023 17:17:18 +0100
Message-ID: <8734w7qttd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 05 2023 at 23:04, Andres Freund wrote:
> On 2023-11-22 10:31:31 -0500, Sasha Levin wrote:
>> Currently, the kernel enumerates the possible CPUs by parsing both ACPI
>> MADT Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
>> even if they have duplicated APIC IDs in Local APIC and x2APIC, are always
>> enumerated.
>
> As just described in
> https://lore.kernel.org/all/20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de/
> and also previously described by John Sperbeck
> https://lore.kernel.org/all/20231122221947.781812-1-jsperbeck@google.com/
>
> this patch causes some machines to "loose" cpus. All but one in my
> case.

Sorry for the delay.

> Even if the commit didn't have these unintended consequences, it seems like a
> commit like this hardly is -stable material?

Shit happens. We are all human, right?

