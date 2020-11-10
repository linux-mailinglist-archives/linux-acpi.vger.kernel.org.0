Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059082AE068
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKJUFe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 15:05:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:53080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJUFd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 15:05:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BAD6AB93;
        Tue, 10 Nov 2020 20:05:32 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v3 0/3] Add support for frequency invariance to AMD EPYC Zen2
Date:   Tue, 10 Nov 2020 21:05:16 +0100
Message-Id: <20201110200519.18180-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v2 at https://lore.kernel.org/lkml/20201110183054.15883-1-ggherdovich@suse.cz/

Changes wrt v2:

- "code golf" on the function function init_freq_invariance_cppc().
  Make better use of the "secondary" argument to init_freq_invariance(),
  which was introduced at b56e7d45e807 ("x86, sched: Don't enable static key
  when starting secondary CPUs") to deal with CPU hotplug.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cover Letter from v2:

v1 at https://lore.kernel.org/lkml/20201110083936.31994-1-ggherdovich@suse.cz/

Changes wrt v1:

- made initialization safe under CPU hotplug.
  The function init_freq_invariance_cppc now lets only the first caller
  into init_freq_invariance().

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cover Letter from v1:

This series adds support for frequency invariant accounting on AMD EPYC Zen2
(aka "Rome"). The first patch by Nathan lays out the foundation by querying
ACPI infrastructure for the max boost frequency of the system. Specifically,
this value is available via the CPPC machinery; the previous EPYC generation,
namely Zen aka "Naples", doesn't implement that and frequency invariance won't
be supported.

The second patch sets the estimate for freq_max to be the midpoint between
max_boost and max_P, as that works slightly better in practice.

A side effect of this series is to provide, with the invariant schedutil
governor, a suitable baseline to evaluate a (still work-in-progress)
CPPC-based cpufreq driver for the AMD platform (see
https://lore.kernel.org/lkml/cover.1562781484.git.Janakarajan.Natarajan@amd.com
if/when it will resubmitted.


Giovanni Gherdovich (2):
  x86, sched: Use midpoint of max_boost and max_P for frequency
    invariance on AMD EPYC
  x86: Print ratio freq_max/freq_base used in frequency invariance
    calculations

Nathan Fontenot (1):
  x86, sched: Calculate frequency invariance for AMD systems

 arch/x86/include/asm/topology.h |  8 ++++
 arch/x86/kernel/smpboot.c       | 79 ++++++++++++++++++++++++++++++---
 drivers/acpi/cppc_acpi.c        |  3 ++
 3 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.26.2

