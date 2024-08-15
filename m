Return-Path: <linux-acpi+bounces-7598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C91952D10
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4801C23269
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB11AC8A0;
	Thu, 15 Aug 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNHIL7NF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBt6hR7X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756D1AC88C;
	Thu, 15 Aug 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719473; cv=none; b=Aa7nJxkSeTJs1frqjhxik73BPzkPbYcr18TbPEM083kpS9iQTyr/oSoc6FarAMb0axCf1/ILT5K60Fz2kF/TCW7w0dAvNUJnDuWTqXUFlMsmYbesDPgQoHGPC7hYg1uAmlLTPpSa/DUY0RqQMGgkleBJ+DjihfgX+k0w9BzdfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719473; c=relaxed/simple;
	bh=OR897adyomGx6ta2gTUOROeKGS/AwcNG/7KEA8caKhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+eFr3wld2MLRXK+RpIWVS1IGm5xkBZlVbLM7k2K60B8foNcTsrqOqndrmKfgkSNQ9e4N1ABexoU62Zvw7r9Q7tZBYVrGOFIZU+o0tf2bBm1O7giEGifYXC4mUI6kQ5oD8m5hEiHJIg03tYte9MEYz/VKSZb5ctJ5jQGBKCvf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNHIL7NF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBt6hR7X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723719470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8ebSU8/6XZn/8ULIh3Q/WZP2fvFGkPefnWFmwKN9UM=;
	b=fNHIL7NFy3j+g1DPbddkuRqf4tichpEWQzTSwt6b6rliU183ZQD9rSaVnUWWNOHOw8HxGJ
	iNfUp5aUvemQt+MO8csAQlcO/EouyMWWMrhOHxQxgZqSGyI21RRhRlKOGB6L8eglJt8euy
	+M8zDp1lPZV9eHiatQ5k9ufmnewcYyd9ieo5ztSsqKES9aDTHfwZop0zV7//44hr42pGB4
	ODsD2FgLM95i76U73TJXduX/DDhMthuu/wAsnrmo6N9rSJgXUXMt3jlw7UtT+bM5Hdok9D
	WJw1vKd1TQOHi+MbRI28f63aV51DOu2xsi1ZvYbNT1CKY23Dt2Yg3DGp5OqdvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723719470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8ebSU8/6XZn/8ULIh3Q/WZP2fvFGkPefnWFmwKN9UM=;
	b=hBt6hR7XhsC4/kP0g8rbOg1cvUe/nPv9tT3CbjPUmAXR2oeyPOnkbfwScKFrED+4Dc/IcZ
	VDvjKRn8LLEx34CA==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Baoquan He
 <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson
 <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
In-Reply-To: <5iijyqzxd3ccranzvmfgvf3mvkesfbjsuggtuppa5wf6z444dd@ft5h2m6u2ggw>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
 <87cymaoqj4.ffs@tglx>
 <5iijyqzxd3ccranzvmfgvf3mvkesfbjsuggtuppa5wf6z444dd@ft5h2m6u2ggw>
Date: Thu, 15 Aug 2024 12:57:49 +0200
Message-ID: <87wmkim4sy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 12:15, Kirill A. Shutemov wrote:
> On Wed, Aug 14, 2024 at 09:25:35PM +0200, Thomas Gleixner wrote:
>> On Wed, Aug 14 2024 at 15:46, Kirill A. Shutemov wrote:
>> > Calculation of 'next' virtual address doesn't protect against wrapping
>> > to zero. It can result in page table corruption and hang. The
>> > problematic case is possible if user sets high x86_mapping_info::offset.
>> 
>> So this should have a Fixes tag, right?
>
> Well, I guess we can add
>
> Fixes: e4630fdd4763 ("x86/power/64: Always create temporary identity mapping correctly")
>
> but the bug is not triggirable with current upstream code.
>
> It only wraps to zero if you touch top PGD entry. There's no such users in
> upstream. Only hibernate_64.c uses x86_mapping_info::offset and it works
> on direct mapping range which is not top PGD entry.

Fair enough, but please mention that in the change log.

