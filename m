Return-Path: <linux-acpi+bounces-1077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CC7DA3A0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 00:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7850F280DAE
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F969405E3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KI86MEfE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xcZk7Apx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF71772B;
	Fri, 27 Oct 2023 21:50:37 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60451B5;
	Fri, 27 Oct 2023 14:50:35 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698443434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkILUqwqrraMqZjxG6n6efB1Hqc2b1hkA5CpetbdHWk=;
	b=KI86MEfEM4VXKns1K+hOAvzMDzwY0Z7KduIurPmGv74uYAz8Wj6pr4LMGKMZ12wBKAyA69
	genCcOSpV8EcqEk/YqaMbH+skffgSwgXznlk4+33cl/bq8Kh0hFa4ohvR6TCCdydaOP1e7
	r42MNuXZSMt11NKYvOOWjjBCsJbOHSSjRo1grwvAGjsS9qb6mKTz8AgUTbVM0bjOMI9LxX
	imo4GABJWUjo6Qw/nfJsT9nq4MwLgYR3DSjwP04kHMxlJN80bvVmpt3heAwcSbVIRyAwtq
	dgwJk1Y3sCLBVXwAJOpzQweT4vWRIZk3iWXRb0th6stOqv/6beZ1yJY6drRF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698443434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkILUqwqrraMqZjxG6n6efB1Hqc2b1hkA5CpetbdHWk=;
	b=xcZk7Apxiyk+Poe14k36DHbPGxwC4I61RejgcN6QurYm3dvvgCmkzqRwHDgft9ncStH4Cd
	AW8UZd9HvNf1duCA==
To: Mario Limonciello <mario.limonciello@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <x86@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel
 Machek <pavel@ucw.cz>, David Woodhouse <dwmw@amazon.co.uk>, Sandipan Das
 <sandipan.das@amd.com>, "open list:PERFORMANCE EVENTS SUBSYSTEM"
 <linux-perf-users@vger.kernel.org>, "open list:PERFORMANCE EVENTS
 SUBSYSTEM" <linux-kernel@vger.kernel.org>, "open list:SUSPEND TO RAM"
 <linux-pm@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fixes for s3 with parallel bootup
In-Reply-To: <de56ddad-ee57-4ff0-b384-522c05e88c91@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <87zg0327i4.ffs@tglx> <de56ddad-ee57-4ff0-b384-522c05e88c91@amd.com>
Date: Fri, 27 Oct 2023 23:50:33 +0200
Message-ID: <87r0lf20ra.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 27 2023 at 14:29, Mario Limonciello wrote:
> On 10/27/2023 14:24, Thomas Gleixner wrote:
>> On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
>>> Parallel bootup on systems that use x2apic broke suspend to ram.
>>> This series ensures x2apic is re-enabled at startup and fixes an exposed
>>> pre-emption issue.
>> 
>> The PMU issue has absolutely nothing to do with parallel bootup.
>> 
>> Can you please describe stuff coherently?
>
> They are both issues found with S3 testing.
> The PMU issue wasn't being observed with cpuhp.parallel=0.

It does not matter whether you cannot observe it under a certain
conditions. What matters is the proper analysis of the root cause and
that is clearly neither related to suspend nor cpuhp.parallel=0.

Stop this 'fix the symptom' approach before it becomes a habit.

Thanks,

        tglx

