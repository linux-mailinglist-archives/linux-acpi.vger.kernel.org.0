Return-Path: <linux-acpi+bounces-1076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D905D7DA39F
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 00:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157691C21159
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F8405E9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JeCfrHiP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6YOjVs+C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD91772B;
	Fri, 27 Oct 2023 21:47:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26791BF;
	Fri, 27 Oct 2023 14:47:16 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698443235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFlGYGD96K+5LkGjpYByN6tWVT7HSksJ2vFMkU/hCVk=;
	b=JeCfrHiP2URhMWgqY2LRJ3yKPlrz+LtQdJaiJtOhcev0MmT4dMSpgHagCq9PkzmlifoXfk
	yEaFKvVFPGg7hmjbM8LGxncodNCdAe6R5E0MXZeDhavYvXjnnEMhjbN1p/U01vq1bH1pcq
	bCmPepD936IfMqCpeG5xCvPECVbgmZylJtUfz79tz2YIKTAPwzlSVIyyIGvg1BiCz78lKs
	/R2RDcQNvy31L1mbdIoC5YBs3a6dPscIhhNTGbvO+pla7cdYiOVVqMV4rqZRyhWwUGC5wX
	JQCwROPkA4uZCmiAnejX+JKGZ+4oqfFZWT1f79agg5bFTC1rBf8J9CGKAqjNvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698443235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFlGYGD96K+5LkGjpYByN6tWVT7HSksJ2vFMkU/hCVk=;
	b=6YOjVs+CWd3e07l5jHIA3i1LafzO49eA6loOma8U+G7v57V4zNB+fGVi1G/cVvmu5MkAmG
	p3EsIAo3PwkSeSCQ==
To: Mario Limonciello <mario.limonciello@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <x86@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, David Woodhouse
 <dwmw@amazon.co.uk>, Sandipan Das <sandipan.das@amd.com>, "open
 list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open
 list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, "open
 list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/2] perf/x86/amd: Stop calling amd_pmu_cpu_reset()
 from amd_pmu_cpu_dead()
In-Reply-To: <20231026170330.4657-3-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <20231026170330.4657-3-mario.limonciello@amd.com>
Date: Fri, 27 Oct 2023 23:47:15 +0200
Message-ID: <87ttqb20ws.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:

> During suspend testing on a workstation CPU a preemption BUG was
> reported.

How is this related to a workstation CPU? Laptop CPUs and server CPUs
are magically not affected, right?

Also how is this related to suspend?

This clearly affects any CPU down operation whether in the context of
suspend or initiated via sysfs, no?

Just because you observed it during suspend testing does not magically
make it a suspend related problem....

> BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
> caller is amd_pmu_lbr_reset+0x19/0xc0
> CPU: 104 PID: 2960 Comm: rtcwake Not tainted 6.6.0-rc6-00002-g3e2c7f3ac51f
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x44/0x60
>  check_preemption_disabled+0xce/0xf0
>  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>  amd_pmu_lbr_reset+0x19/0xc0
>  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>  amd_pmu_cpu_reset.constprop.0+0x51/0x60
>  amd_pmu_cpu_dead+0x3e/0x90
>  x86_pmu_dead_cpu+0x13/0x20
>  cpuhp_invoke_callback+0x169/0x4b0
>  ? __pfx_virtnet_cpu_dead+0x10/0x10
>  __cpuhp_invoke_callback_range+0x76/0xe0
>  _cpu_down+0x112/0x270
>  freeze_secondary_cpus+0x8e/0x280
>  suspend_devices_and_enter+0x342/0x900
>  pm_suspend+0x2fd/0x690
>  state_store+0x71/0xd0
>  kernfs_fop_write_iter+0x128/0x1c0
>  vfs_write+0x2db/0x400
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x59/0x90
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? count_memcg_events.constprop.0+0x1a/0x30
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? handle_mm_fault+0x1e9/0x340
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? preempt_count_add+0x4d/0xa0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? up_read+0x38/0x70
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? do_user_addr_fault+0x343/0x6b0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? exc_page_fault+0x74/0x170
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7f32f8d14a77
> Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa
> 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff
> 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffdc648de18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f32f8d14a77
> RDX: 0000000000000004 RSI: 000055b2fc2a5670 RDI: 0000000000000004
> RBP: 000055b2fc2a5670 R08: 0000000000000000 R09: 000055b2fc2a5670
> R10: 00007f32f8e1a2f0 R11: 0000000000000246 R12: 0000000000000004
> R13: 000055b2fc2a2480 R14: 00007f32f8e16600 R15: 00007f32f8e15a00
>  </TASK>

How much of that backtrace is actually substantial information?

At max 5 lines out of ~50. See:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces

> This bug shows that there is a mistake with the flow used for offlining

This bug shows nothing than a calltrace. Please explain the context and
the fail in coherent sentences. The bug backtrace is just for
illustration.

> a CPU.  Calling amd_pmu_cpu_reset() from the dead callback is
> problematic

It's not problematic. It's simply wrong.

> because this doesn't run on the actual CPU being offlined.  The intent of
> the function is to reset MSRs local to that CPU.
>
> Move the call into the dying callback which is actually run on the local
> CPU.

...

> +static void amd_pmu_cpu_dying(int cpu)
> +{
> +	amd_pmu_cpu_reset(cpu);
> +}

You clearly can spare that wrapper which wraps a function with the signature

     void fn(int)

into a function with the signature

     void fn(int)

by just assigning amd_pmu_cpu_reset() to the cpu_dying callback, no?

Thanks,

        tglx

