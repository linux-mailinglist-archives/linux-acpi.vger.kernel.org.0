Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FA2AD16C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 09:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKJIjx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 03:39:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbgKJIjv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 03:39:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2430AEAA;
        Tue, 10 Nov 2020 08:39:49 +0000 (UTC)
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
Subject: [PATCH 3/3] x86: Print ratio freq_max/freq_base used in frequency invariance calculations
Date:   Tue, 10 Nov 2020 09:39:36 +0100
Message-Id: <20201110083936.31994-4-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110083936.31994-1-ggherdovich@suse.cz>
References: <20201110083936.31994-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The value freq_max/freq_base is a fundamental component of frequency
invariance calculations. It may come from a variety of sources such as MSRs
or ACPI data, tracking it down when troubleshooting a system could be
non-trivial. It is worth saving it in the kernel logs.

 # dmesg | grep 'Estimated ratio of average max'
 [   14.024036] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1289

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 1e6fed437b0c..ad0647b2d7c3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2110,6 +2110,7 @@ static void init_freq_invariance(bool secondary, bool cppc_ready)
 	if (ret) {
 		init_counter_refs(NULL);
 		static_branch_enable(&arch_scale_freq_key);
+		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
 	}
-- 
2.26.2

