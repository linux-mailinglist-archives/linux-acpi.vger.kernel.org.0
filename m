Return-Path: <linux-acpi+bounces-13717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3693AB6C2B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4F38C6058
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B800278772;
	Wed, 14 May 2025 13:07:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002F25D550;
	Wed, 14 May 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228055; cv=none; b=euipPEC45X/2PB40h5CrHHgeG8rCGCeBIcPa0Hgjzo8wl0S5lJHCRljUzpcB6s6rBzXTHfSYkUNfI2Q85NfR22YWklyL30SWMc76sB/L6Nd2NOF1NbgqkG/QGYfxq4Ve6AcB0FIXY3kDzo9QdX5WfS8BMmI29ueStiNUp3KQzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228055; c=relaxed/simple;
	bh=7x9OydtFeaYlX1Jn7YMnxF7uFDzBkwNknRkRlVSmkrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwBVX5wOzHeariwiGhgqosCGjcYCSXgogWNd/X4ce68EP3OzsBDjLjIFyJ1dNnGO51/IAP033j92R26kINmjFmSSHnUSiXYeayE+3YDDoU/b9Ddq9Tc5YsCd6W4ceFYwcu06SG7rPXAQfnE/40Okc7N/Pk4ge+oWOoqf3KRu5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE428150C;
	Wed, 14 May 2025 06:07:18 -0700 (PDT)
Received: from usa.arm.com (GTV29432L0-2.cambridge.arm.com [10.1.36.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D49C3F5A1;
	Wed, 14 May 2025 06:07:28 -0700 (PDT)
From: Aishwarya <aishwarya.tcv@arm.com>
To: jeremy.linton@arm.com
Cc: jmeurin@google.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mheyne@amazon.de,
	rafael@kernel.org,
	stable@vger.kernel.org,
	sudeep.holla@arm.com,
	yangyicong@hisilicon.com,
	ryan.roberts@arm.com
Subject: Re: [PATCH] ACPI: PPTT: Fix processor subtable walk
Date: Wed, 14 May 2025 14:07:27 +0100
Message-Id: <20250514130727.67734-1-aishwarya.tcv@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250508023025.1301030-1-jeremy.linton@arm.com>
References: <20250508023025.1301030-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jeremy,

Thanks for providing this fix. We've tested applying the patch on top
of v6.15-rc6 and would like to confirm that commit

  7ab4f0e37a0f4207e742a8de69be03984db6ebf0

was indeed the root cause of a severe performance regression observed
on Graviton3 bare-metal systems during the 6.15 development cycle.

After applying the patch, all regressions were fully resolved.

The degradation began in v6.15-rc2 and persisted through rc6. Through
bisection, we identified the above commit as introducing incorrect
handling in ACPI PPTT parsing. This likely caused malformed CPU
topology and broken scheduling domains.

As further evidence, we observed the following warning in the kernel
logs during affected runs. This was with: Linux version 6.15.0-rc6

[    0.511191] ------------[ cut here ]------------
[    0.511193] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2411 build_sched_domains+0x674/0x1204
[    0.511201] Modules linked in:
[    0.511205] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G S                  6.15.0-rc6 #1 PREEMPT
[    0.511209] Tainted: [S]=CPU_OUT_OF_SPEC
[    0.511211] pstate: 01400009 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    0.511214] pc : build_sched_domains+0x674/0x1204
[    0.511217] lr : build_sched_domains+0x354/0x1204
[    0.511220] sp : ffff80008021bce0
[    0.511222] x29: ffff80008021bd60 x28: ffff00010253e300 x27: ffff000100b74440
[    0.511226] x26: ffffdd63645167f8 x25: ffffdd636373aee8 x24: 0000000000001297
[    0.511229] x23: ffffdd6364aa4518 x22: 000000000000003f x21: 0000000000000000
[    0.511233] x20: ffffdd63644fb030 x19: ffff0001014e9270 x18: ffffffffff435f00
[    0.511236] x17: 4d52415120646574 x16: 6365746968637261 x15: 0000000000000001
[    0.511239] x14: 0000000000000000 x13: 0000000000000318 x12: 0000000000002000
[    0.511243] x11: ffff00815ff0e154 x10: ffffdd6364aa4518 x9 : ffffdd6364aa4510
[    0.511246] x8 : ffffdd6364aa8780 x7 : 0000000000000002 x6 : 7fffffffffffffff
[    0.511249] x5 : ffffffffffffffff x4 : 0000000000000002 x3 : 0000000000000001
[    0.511252] x2 : 0000000000000040 x1 : ffffdd6364aa8788 x0 : 0000000000000001
[    0.511256] Call trace:
[    0.511258]  build_sched_domains+0x674/0x1204 (P)
[    0.511262]  sched_init_domains+0xc8/0x104
[    0.511267]  sched_init_smp+0x40/0xc0
[    0.511270]  kernel_init_freeable+0x100/0x28c
[    0.511273]  kernel_init+0x20/0x1d8
[    0.511277]  ret_from_fork+0x10/0x20
[    0.511281] ---[ end trace 0000000000000000 ]---

Based on this, we believe the truncation of the PPTT was confusing the
scheduler about the system's CPU topology. This likely explains the
observed regressions.

Example impact (`pts/pgbench` with 100 clients / 1000 scale):
  - TPS dropped by up to -98.8%
  - Latency increased by over +8200%

Other workloads affected:
  - mmtests/sysbench-thread showed ~+600% increase in latency
  - mmtests/stressng-* (get, wait, vm-splice) regressed by -90%+
  - pts/memtier and nginx throughput dropped by ~98%

We’ve shared the full benchmark results in the thread below to support
these findings.
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| Benchmark                          | Result Class                                             |   6-14-0 (base) |   6-15-0-rc5 |   6-15-0-rc6-g28a90db81645 |
+====================================+==========================================================+=================+==============+============================+
| micromm/fork                       | fork: p:1, d:10 (seconds)                                |           0.00% |   (R) 24.31% |                      0.93% |
|                                    | fork: p:512, d:10 (seconds)                              |           0.00% |    (R) 5.45% |                     -1.39% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| micromm/munmap                     | munmap: p:1, d:10 (seconds)                              |           0.00% |       -0.04% |                      0.70% |
|                                    | munmap: p:512, d:10 (seconds)                            |           0.00% |    (R) 3.75% |                  (R) 2.93% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| micromm/vmalloc                    | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |           0.00% |        0.34% |                  (R) 5.04% |
|                                    | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |           0.00% |       -1.61% |                     -0.93% |
|                                    | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |           0.00% |        0.59% |                  (R) 3.98% |
|                                    | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |           0.00% |        3.96% |                  (R) 7.79% |
|                                    | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |           0.00% |    (R) 2.14% |                  (R) 7.48% |
|                                    | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |           0.00% |    (R) 3.50% |                  (R) 8.80% |
|                                    | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |           0.00% |    (R) 3.30% |                  (R) 8.76% |
|                                    | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |           0.00% |    (R) 3.86% |                  (R) 9.65% |
|                                    | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |           0.00% |    (R) 3.44% |                  (R) 9.68% |
|                                    | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |           0.00% |    (R) 3.37% |                  (R) 9.75% |
|                                    | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |           0.00% |    (R) 9.26% |                 (R) 17.75% |
|                                    | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |           0.00% |   (I) -6.70% |                      0.37% |
|                                    | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |           0.00% |   (R) 34.28% |                      0.02% |
|                                    | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |           0.00% |   (R) 35.93% |                      0.42% |
|                                    | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |           0.00% |        1.63% |                  (R) 2.36% |
|                                    | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |           0.00% |        2.09% |                     -1.19% |
|                                    | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |           0.00% |       -1.28% |                      1.91% |
|                                    | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |           0.00% |    (R) 2.93% |                  (R) 8.94% |
|                                    | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |           0.00% |       -1.86% |                      0.12% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/hackbench                  | process-pipes-1 (seconds)                                |           0.00% |              |                 (I) -7.13% |
|                                    | process-pipes-4 (seconds)                                |           0.00% |              |                 (I) -5.44% |
|                                    | process-pipes-7 (seconds)                                |           0.00% |              |                 (I) -6.24% |
|                                    | process-pipes-12 (seconds)                               |           0.00% |              |                 (I) -3.90% |
|                                    | process-pipes-21 (seconds)                               |           0.00% |              |                 (I) -8.26% |
|                                    | process-pipes-30 (seconds)                               |           0.00% |              |                 (I) -8.50% |
|                                    | process-pipes-48 (seconds)                               |           0.00% |              |                (I) -10.24% |
|                                    | process-pipes-79 (seconds)                               |           0.00% |              |                (I) -11.82% |
|                                    | process-pipes-110 (seconds)                              |           0.00% |              |                (I) -13.15% |
|                                    | process-pipes-141 (seconds)                              |           0.00% |              |                (I) -12.25% |
|                                    | process-pipes-172 (seconds)                              |           0.00% |              |                (I) -12.79% |
|                                    | process-pipes-203 (seconds)                              |           0.00% |              |                (I) -12.86% |
|                                    | process-pipes-234 (seconds)                              |           0.00% |              |                (I) -12.98% |
|                                    | process-pipes-256 (seconds)                              |           0.00% |              |                (I) -13.12% |
|                                    | process-sockets-1 (seconds)                              |           0.00% |              |                      0.11% |
|                                    | process-sockets-4 (seconds)                              |           0.00% |              |                     -0.22% |
|                                    | process-sockets-7 (seconds)                              |           0.00% |              |                      0.61% |
|                                    | process-sockets-12 (seconds)                             |           0.00% |              |                     -0.02% |
|                                    | process-sockets-21 (seconds)                             |           0.00% |              |                      0.57% |
|                                    | process-sockets-30 (seconds)                             |           0.00% |              |                     -0.10% |
|                                    | process-sockets-48 (seconds)                             |           0.00% |              |                     -0.63% |
|                                    | process-sockets-79 (seconds)                             |           0.00% |              |                      0.14% |
|                                    | process-sockets-110 (seconds)                            |           0.00% |              |                      0.43% |
|                                    | process-sockets-141 (seconds)                            |           0.00% |              |                      0.64% |
|                                    | process-sockets-172 (seconds)                            |           0.00% |              |                      1.04% |
|                                    | process-sockets-203 (seconds)                            |           0.00% |              |                     -0.11% |
|                                    | process-sockets-234 (seconds)                            |           0.00% |              |                      0.31% |
|                                    | process-sockets-256 (seconds)                            |           0.00% |              |                      0.60% |
|                                    | thread-pipes-1 (seconds)                                 |           0.00% |              |                (I) -11.54% |
|                                    | thread-pipes-4 (seconds)                                 |           0.00% |              |                 (I) -8.52% |
|                                    | thread-pipes-7 (seconds)                                 |           0.00% |              |                 (I) -9.90% |
|                                    | thread-pipes-12 (seconds)                                |           0.00% |              |                 (I) -6.03% |
|                                    | thread-pipes-21 (seconds)                                |           0.00% |              |                 (I) -8.68% |
|                                    | thread-pipes-30 (seconds)                                |           0.00% |              |                 (I) -9.16% |
|                                    | thread-pipes-48 (seconds)                                |           0.00% |              |                (I) -10.58% |
|                                    | thread-pipes-79 (seconds)                                |           0.00% |              |                (I) -14.23% |
|                                    | thread-pipes-110 (seconds)                               |           0.00% |              |                (I) -15.06% |
|                                    | thread-pipes-141 (seconds)                               |           0.00% |              |                (I) -14.22% |
|                                    | thread-pipes-172 (seconds)                               |           0.00% |              |                (I) -14.20% |
|                                    | thread-pipes-203 (seconds)                               |           0.00% |              |                (I) -13.78% |
|                                    | thread-pipes-234 (seconds)                               |           0.00% |              |                (I) -13.84% |
|                                    | thread-pipes-256 (seconds)                               |           0.00% |              |                (I) -13.80% |
|                                    | thread-sockets-1 (seconds)                               |           0.00% |              |                 (I) -3.70% |
|                                    | thread-sockets-4 (seconds)                               |           0.00% |              |                 (I) -2.95% |
|                                    | thread-sockets-7 (seconds)                               |           0.00% |              |                 (I) -2.81% |
|                                    | thread-sockets-12 (seconds)                              |           0.00% |              |                 (I) -2.31% |
|                                    | thread-sockets-21 (seconds)                              |           0.00% |              |                 (I) -2.33% |
|                                    | thread-sockets-30 (seconds)                              |           0.00% |              |                     -1.65% |
|                                    | thread-sockets-48 (seconds)                              |           0.00% |              |                     -0.93% |
|                                    | thread-sockets-79 (seconds)                              |           0.00% |              |                     -1.72% |
|                                    | thread-sockets-110 (seconds)                             |           0.00% |              |                      0.58% |
|                                    | thread-sockets-141 (seconds)                             |           0.00% |              |                      0.02% |
|                                    | thread-sockets-172 (seconds)                             |           0.00% |              |                      0.51% |
|                                    | thread-sockets-203 (seconds)                             |           0.00% |              |                      0.69% |
|                                    | thread-sockets-234 (seconds)                             |           0.00% |              |                      0.50% |
|                                    | thread-sockets-256 (seconds)                             |           0.00% |              |                      0.30% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/kernbench                  | elsp-64 (seconds)                                        |           0.00% |              |                      0.01% |
|                                    | syst-64 (seconds)                                        |           0.00% |              |                     -0.99% |
|                                    | user-64 (seconds)                                        |           0.00% |              |                     -0.10% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-af-alg            | 1 (ops/second)                                           |           0.00% |    (I) 3.53% |                      0.55% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -47.63% |                      0.51% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -73.57% |                      0.54% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -86.14% |                      0.54% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -92.06% |                      1.05% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -92.38% |                      0.29% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -91.09% |                      0.27% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -90.91% |                      0.09% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-bad-altstack      | 1 (ops/second)                                           |           0.00% |       -0.11% |                     -0.01% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -50.95% |                     -0.00% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -75.64% |                     -0.04% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -85.42% |                      1.59% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -97.55% |                  (I) 3.31% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -99.24% |                      0.45% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -99.60% |                      0.00% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -99.62% |                      0.40% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-class-io-parallel | stressng-aio-64 (ops/second)                             |           0.00% |  (I) 528.81% |                     -3.26% |
|                                    | stressng-hdd-64 (ops/second)                             |           0.00% |  (R) -18.32% |                     -0.60% |
|                                    | stressng-io-uring-64 (ops/second)                        |           0.00% |  (I) 434.84% |                      0.96% |
|                                    | stressng-readahead-64 (ops/second)                       |           0.00% |  (R) -98.97% |                     -1.17% |
|                                    | stressng-revio-64 (ops/second)                           |           0.00% |  (R) -98.92% |                    -13.03% |
|                                    | stressng-seek-64 (ops/second)                            |           0.00% |  (R) -99.90% |                     -7.53% |
|                                    | stressng-sync-file-64 (ops/second)                       |           0.00% |      -38.12% |                     76.58% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-context           | 1 (ops/second)                                           |           0.00% |   (R) -3.02% |                     -1.29% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -51.93% |                     -0.98% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -76.75% |                     -1.19% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -88.43% |                     -1.11% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -94.03% |                     -1.07% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -97.01% |                     -1.05% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -98.50% |                     -1.20% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -98.51% |                     -1.06% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-fork              | 1 (ops/second)                                           |           0.00% |   (I) 12.21% |                      4.11% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -46.26% |                      4.75% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -72.79% |                      2.21% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -85.88% |                  (I) 3.68% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -92.30% |                  (I) 2.55% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -94.87% |                     -0.15% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -95.43% |                     -6.86% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -95.79% |                     -2.29% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-get               | 1 (ops/second)                                           |           0.00% |       -0.01% |                      0.56% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -46.80% |                      0.33% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -72.05% |                      1.63% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -84.66% |                  (I) 2.15% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -88.22% |                      1.19% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -88.21% |                      0.92% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -88.16% |                      0.44% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -87.29% |                      1.39% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-getdent           | 1 (ops/second)                                           |           0.00% |   (R) -4.47% |                      0.67% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -42.27% |                      2.01% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -54.38% |                      0.97% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -57.53% |                      1.78% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -58.90% |                      1.98% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -64.26% |                  (I) 2.38% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -65.32% |                  (I) 3.37% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -36.72% |                     -0.36% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-madvise           | 1 (ops/second)                                           |           0.00% |              |                            |
|                                    | 2 (ops/second)                                           |           0.00% |   (I) 56.22% |                      0.13% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -46.94% |                 (R) -2.09% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -76.56% |                     -1.12% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -84.55% |                     -0.55% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -90.29% |                     -0.76% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -90.98% |                     -1.49% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -92.53% |                     -4.13% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-mmap              | 1 (ops/second)                                           |           0.00% |    (I) 2.70% |                  (I) 3.60% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -46.86% |                  (I) 4.02% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -71.48% |                  (I) 4.05% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -84.90% |                  (I) 4.67% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -91.47% |                  (I) 3.88% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -92.87% |                      1.35% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -92.04% |                      0.81% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -92.36% |                      1.03% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-vm-splice         | 1 (ops/second)                                           |           0.00% |    (I) 4.43% |                  (I) 2.93% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -49.04% |                  (I) 3.53% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -74.48% |                  (I) 3.94% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -88.44% |                  (I) 4.39% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -94.20% |                  (I) 4.84% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -96.99% |                  (I) 5.05% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -98.41% |                  (I) 4.91% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -98.38% |                  (I) 5.29% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-wait              | 1 (ops/second)                                           |           0.00% |  (R) -27.55% |                      0.29% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -40.45% |                      0.31% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -50.89% |                      0.30% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -61.05% |                      0.38% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -69.72% |                     -0.30% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -77.06% |                      0.25% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -63.69% |                  (I) 7.23% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -84.87% |                      1.74% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/stressng-zombie            | 1 (ops/second)                                           |           0.00% |  (R) -52.97% |                  (I) 4.73% |
|                                    | 2 (ops/second)                                           |           0.00% |  (R) -75.01% |                  (I) 6.02% |
|                                    | 4 (ops/second)                                           |           0.00% |  (R) -86.96% |                  (I) 5.61% |
|                                    | 8 (ops/second)                                           |           0.00% |  (R) -92.74% |                  (I) 3.33% |
|                                    | 16 (ops/second)                                          |           0.00% |  (R) -95.44% |                 (R) -2.01% |
|                                    | 32 (ops/second)                                          |           0.00% |  (R) -95.90% |                 (R) -5.48% |
|                                    | 64 (ops/second)                                          |           0.00% |  (R) -93.61% |                     -1.74% |
|                                    | 128 (ops/second)                                         |           0.00% |  (R) -92.37% |                     -0.38% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/sysbench-cpu               | sysbenchcpu-1 (ops/second)                               |           0.00% |       -0.04% |                      0.07% |
|                                    | sysbenchcpu-4 (ops/second)                               |           0.00% |  (R) -75.01% |                      0.04% |
|                                    | sysbenchcpu-7 (ops/second)                               |           0.00% |  (R) -85.72% |                      0.03% |
|                                    | sysbenchcpu-12 (ops/second)                              |           0.00% |  (R) -91.67% |                      0.04% |
|                                    | sysbenchcpu-21 (ops/second)                              |           0.00% |  (R) -95.24% |                      0.04% |
|                                    | sysbenchcpu-30 (ops/second)                              |           0.00% |  (R) -96.67% |                      0.04% |
|                                    | sysbenchcpu-48 (ops/second)                              |           0.00% |  (R) -97.92% |                      0.04% |
|                                    | sysbenchcpu-79 (ops/second)                              |           0.00% |  (R) -98.44% |                      0.06% |
|                                    | sysbenchcpu-110 (ops/second)                             |           0.00% |  (R) -98.44% |                      0.06% |
|                                    | sysbenchcpu-128 (ops/second)                             |           0.00% |  (R) -98.44% |                      0.06% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/sysbench-mutex             | sysbenchmutex-1 (usec)                                   |           0.00% |        0.23% |                     -0.03% |
|                                    | sysbenchmutex-4 (usec)                                   |           0.00% |  (R) 284.45% |                     -0.15% |
|                                    | sysbenchmutex-7 (usec)                                   |           0.00% |  (R) 567.27% |                     -0.19% |
|                                    | sysbenchmutex-12 (usec)                                  |           0.00% | (R) 1039.06% |                     -0.18% |
|                                    | sysbenchmutex-21 (usec)                                  |           0.00% | (R) 1875.29% |                     -0.17% |
|                                    | sysbenchmutex-30 (usec)                                  |           0.00% | (R) 2688.51% |                      0.03% |
|                                    | sysbenchmutex-48 (usec)                                  |           0.00% | (R) 3581.82% |                     -0.17% |
|                                    | sysbenchmutex-79 (usec)                                  |           0.00% | (R) 3955.59% |                      2.50% |
|                                    | sysbenchmutex-110 (usec)                                 |           0.00% | (R) 3765.79% |                     -0.74% |
|                                    | sysbenchmutex-128 (usec)                                 |           0.00% | (R) 3795.09% |                     -1.24% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| mmtests/sysbench-thread            | sysbenchthread-1 (usec)                                  |           0.00% |        2.25% |                      0.00% |
|                                    | sysbenchthread-4 (usec)                                  |           0.00% |  (R) 366.16% |                     -2.60% |
|                                    | sysbenchthread-7 (usec)                                  |           0.00% |   (R) 60.81% |                      2.94% |
|                                    | sysbenchthread-12 (usec)                                 |           0.00% |  (R) 650.47% |                      8.35% |
|                                    | sysbenchthread-21 (usec)                                 |           0.00% |  (R) 554.92% |                     -0.02% |
|                                    | sysbenchthread-30 (usec)                                 |           0.00% |  (R) 578.98% |                     -7.29% |
|                                    | sysbenchthread-48 (usec)                                 |           0.00% |  (R) 663.50% |                     -9.27% |
|                                    | sysbenchthread-79 (usec)                                 |           0.00% |  (R) 418.80% |                    -10.92% |
|                                    | sysbenchthread-110 (usec)                                |           0.00% |  (R) 415.17% |                     -2.99% |
|                                    | sysbenchthread-128 (usec)                                |           0.00% |  (R) 384.96% |                     -0.34% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/memtier-benchmark              | Protocol: Redis Clients: 50 Ratio: 1:1 (Ops/sec)         |           0.00% |  (R) -98.14% |                      0.69% |
|                                    | Protocol: Redis Clients: 50 Ratio: 1:5 (Ops/sec)         |           0.00% |  (R) -98.20% |                      0.87% |
|                                    | Protocol: Redis Clients: 50 Ratio: 5:1 (Ops/sec)         |           0.00% |  (R) -98.20% |                     -0.48% |
|                                    | Protocol: Redis Clients: 100 Ratio: 1:1 (Ops/sec)        |           0.00% |  (R) -98.38% |                      0.52% |
|                                    | Protocol: Redis Clients: 100 Ratio: 1:5 (Ops/sec)        |           0.00% |  (R) -98.04% |                     -1.36% |
|                                    | Protocol: Redis Clients: 100 Ratio: 5:1 (Ops/sec)        |           0.00% |  (R) -97.87% |                     -0.92% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/nginx                          | Connections: 200 (Requests Per Second)                   |           0.00% |  (R) -98.12% |                     -0.46% |
|                                    | Connections: 1000 (Requests Per Second)                  |           0.00% |  (R) -98.21% |                     -1.01% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/perl-benchmark                 | Test: Interpreter (Seconds)                              |           0.00% |       -0.84% |                     -1.55% |
|                                    | Test: Pod2html (Seconds)                                 |           0.00% |        0.23% |                     -0.67% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/pgbench                        | Scale: 1 Clients: 1 Read Only (TPS)                      |           0.00% |  (R) -23.37% |                     -0.47% |
|                                    | Scale: 1 Clients: 1 Read Only - Latency (ms)             |           0.00% |   (R) 32.35% |                      0.98% |
|                                    | Scale: 1 Clients: 1 Read Write (TPS)                     |           0.00% |   (R) -6.06% |                     -0.67% |
|                                    | Scale: 1 Clients: 1 Read Write - Latency (ms)            |           0.00% |    (R) 6.44% |                      0.63% |
|                                    | Scale: 1 Clients: 250 Read Only (TPS)                    |           0.00% |  (R) -98.64% |                     -1.03% |
|                                    | Scale: 1 Clients: 250 Read Only - Latency (ms)           |           0.00% | (R) 7260.00% |                      1.12% |
|                                    | Scale: 1 Clients: 250 Read Write (TPS)                   |           0.00% |  (R) -41.53% |                     -2.08% |
|                                    | Scale: 1 Clients: 250 Read Write - Latency (ms)          |           0.00% |   (R) 70.84% |                      2.04% |
|                                    | Scale: 1 Clients: 1000 Read Only (TPS)                   |           0.00% |  (R) -98.67% |                     -1.05% |
|                                    | Scale: 1 Clients: 1000 Read Only - Latency (ms)          |           0.00% | (R) 7430.55% |                      1.08% |
|                                    | Scale: 1 Clients: 1000 Read Write (TPS)                  |           0.00% |  (R) -68.90% |                     -2.96% |
|                                    | Scale: 1 Clients: 1000 Read Write - Latency (ms)         |           0.00% |  (R) 219.92% |                      3.16% |
|                                    | Scale: 100 Clients: 1 Read Only (TPS)                    |           0.00% |  (R) -22.88% |                     -1.63% |
|                                    | Scale: 100 Clients: 1 Read Only - Latency (ms)           |           0.00% |   (R) 28.07% |                      0.00% |
|                                    | Scale: 100 Clients: 1 Read Write (TPS)                   |           0.00% |   (R) -9.13% |                 (R) -3.42% |
|                                    | Scale: 100 Clients: 1 Read Write - Latency (ms)          |           0.00% |   (R) 10.10% |                  (R) 3.59% |
|                                    | Scale: 100 Clients: 250 Read Only (TPS)                  |           0.00% |  (R) -98.77% |                     -0.93% |
|                                    | Scale: 100 Clients: 250 Read Only - Latency (ms)         |           0.00% | (R) 8032.18% |                      0.92% |
|                                    | Scale: 100 Clients: 250 Read Write (TPS)                 |           0.00% |  (R) -60.82% |                     -4.45% |
|                                    | Scale: 100 Clients: 250 Read Write - Latency (ms)        |           0.00% |  (R) 155.11% |                      5.44% |
|                                    | Scale: 100 Clients: 1000 Read Only (TPS)                 |           0.00% |  (R) -98.80% |                     -1.77% |
|                                    | Scale: 100 Clients: 1000 Read Only - Latency (ms)        |           0.00% | (R) 8223.51% |                      1.85% |
|                                    | Scale: 100 Clients: 1000 Read Write (TPS)                |           0.00% |  (R) -73.95% |                     -0.80% |
|                                    | Scale: 100 Clients: 1000 Read Write - Latency (ms)       |           0.00% |  (R) 283.07% |                      1.18% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/pybench                        | Total For Average Test Times (Milliseconds)              |           0.00% |       -0.61% |                     -0.03% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/redis                          | Test: GET Connections: 50 (Requests Per Second)          |           0.00% |              |                     -0.34% |
|                                    | Test: GET Connections: 1000 (Requests Per Second)        |           0.00% |              |                      0.69% |
|                                    | Test: LPOP Connections: 50 (Requests Per Second)         |           0.00% |              |                      0.07% |
|                                    | Test: LPOP Connections: 1000 (Requests Per Second)       |           0.00% |              |                      0.10% |
|                                    | Test: LPUSH Connections: 50 (Requests Per Second)        |           0.00% |              |                      0.09% |
|                                    | Test: LPUSH Connections: 1000 (Requests Per Second)      |           0.00% |              |                      0.03% |
|                                    | Test: SADD Connections: 50 (Requests Per Second)         |           0.00% |              |                     -0.00% |
|                                    | Test: SADD Connections: 1000 (Requests Per Second)       |           0.00% |              |                     -0.63% |
|                                    | Test: SET Connections: 50 (Requests Per Second)          |           0.00% |              |                      0.03% |
|                                    | Test: SET Connections: 1000 (Requests Per Second)        |           0.00% |              |                     -1.39% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| pts/sqlite-speedtest               | Timed Time - Size 1,000 (Seconds)                        |           0.00% |        1.69% |                     -0.62% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| speedometer/v2.0                   | score (runs/min)                                         |           0.00% |  (R) -37.42% |                      0.11% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+
| speedometer/v2.1                   | score (runs/min)                                         |           0.00% |  (R) -38.41% |                      0.31% |
+------------------------------------+----------------------------------------------------------+-----------------+--------------+----------------------------+

Thanks,
Aishwarya


