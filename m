Return-Path: <linux-acpi+bounces-1121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8237DDA14
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 01:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691871C20C78
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 00:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85ED10EF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnNetGtU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtxTAzZT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599101DFCD;
	Tue, 31 Oct 2023 23:20:08 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C5B9;
	Tue, 31 Oct 2023 16:20:06 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698794404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/p/v8DdsTAZhW4x3hK+e7JbziGQicpp1+UHXRj/vRA=;
	b=BnNetGtUP9ff8iPafgQ0VEqe6AlCzxod9HOd2S9FMBZZkDmTfyffLejEYXASGuzM2nm+LD
	4Ze3LU6JN8EJCZD4lYllj6x04CC7Hvbuh2UmWkn+QO/aXwAaQzcmWjR7qZUiBRYeDFqrcq
	5yxuA6w3Xxj812med+rzWFF5NNtWbpp9bIuw6eyjNkQdIe79t4klfKrby5Gj+jnJmekldx
	H+GiejPioQLRadAEx5eE8H6LW3s+VQG463dJROp2HEbnr6Ufv55Q1IG+p6pONcBqG7LEbw
	pxSj0lwtrX+PDIh2mrkOFyL4ueMmqOG5zIGNahjCxvpzSVxiUJkM1mbxRuNQhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698794404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/p/v8DdsTAZhW4x3hK+e7JbziGQicpp1+UHXRj/vRA=;
	b=ZtxTAzZTLE9riytuBh2qcv66tw7avJVdutgXfFYtV3iiwCG0lUneDYQHOW7Gb7uoAC7jl7
	NrgeDp7OsHRQNeAg==
To: Mario Limonciello <mario.limonciello@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <x86@kernel.org>, Linux kernel regressions list
 <regressions@lists.linux.dev>
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
Subject: Re: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if
 used previously
In-Reply-To: <d7c3a03e-6f52-4bcf-aaae-668f6601ceb8@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <20231026170330.4657-2-mario.limonciello@amd.com> <87wmv721nm.ffs@tglx>
 <d7c3a03e-6f52-4bcf-aaae-668f6601ceb8@amd.com>
Date: Wed, 01 Nov 2023 00:20:03 +0100
Message-ID: <878r7imlb0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 31 2023 at 13:53, Mario Limonciello wrote:
> Thank you for looking this over.  I've reviewed it with the internal 
> team and confirmed there was a BIOS bug where the MSR wasn't restored 
> after the S3 cycle completed.  The BIOS team has fixed it.

Why am I not surprised?

Thanks for the heads up!

       tglx

