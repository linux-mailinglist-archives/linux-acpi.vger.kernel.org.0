Return-Path: <linux-acpi+bounces-1073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE17DA1D1
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4E228253C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34EA3FB02
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fztehdxZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pv7w3r2F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB263AC22;
	Fri, 27 Oct 2023 19:24:55 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036B1A6;
	Fri, 27 Oct 2023 12:24:53 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698434691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6gnZpsQuWc7QehQoZvEcvl+2gz1FD+UGg7ogB7c+Mw=;
	b=fztehdxZgXdYiuafxUo0BfgKIezeZzAeY128OpSvoDNhdoFlFLazsML0vZRHoiZJ40ArvJ
	qhAaZCKvSnVJFErH+aU9kf1ojRtZSV2wjicVOm6U+YExMn7l3Dp7PkgY1I4/IVur/tAvgw
	4qIM+LPr/fO9o0l9VDxjAUlLE46OLJ/0OibI2idTKI4CiDl8PG00saEEwtehr6/wPdUtnx
	J0xQVNOVZEmKVv9sTYKCWpGuB4UXrYQnO0KQQ4ERF1AztZBKy7w5zBZKEsLcH86cUtvUC6
	3M9ii5AywCRefRvANIAiT8DKV3Zz1Ox548hXrrjdTYNm7kfsUAZvrrEcTTDt8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698434691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6gnZpsQuWc7QehQoZvEcvl+2gz1FD+UGg7ogB7c+Mw=;
	b=pv7w3r2F7uuzJtN4Rc2L0gETerL1TJKOQDhA0+r2uQg45RN0nmClkiMNs/zJXDADeCU6L2
	2jym8hNyfoJFKeCA==
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
 <linux-pm@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 0/2] Fixes for s3 with parallel bootup
In-Reply-To: <20231026170330.4657-1-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
Date: Fri, 27 Oct 2023 21:24:51 +0200
Message-ID: <87zg0327i4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
> Parallel bootup on systems that use x2apic broke suspend to ram.
> This series ensures x2apic is re-enabled at startup and fixes an exposed
> pre-emption issue.

The PMU issue has absolutely nothing to do with parallel bootup.

Can you please describe stuff coherently?

