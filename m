Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF288300E04
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbhAVUqy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 15:46:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbhAVUlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 15:41:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16193AF54;
        Fri, 22 Jan 2021 20:40:46 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v2 0/1] AMD EPYC: fix schedutil perf regression (freq-invariance)
Date:   Fri, 22 Jan 2021 21:40:37 +0100
Message-Id: <20210122204038.3238-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Michael Larabel from Phoronix.com graciously tested v1, see results at:

AMD EPYC 7702 -
https://openbenchmarking.org/result/2101210-PTS-LINUX51178

AMD Ryzen 9 5950X - 
https://openbenchmarking.org/result/2101212-HA-RYZEN959566

The reported regression is recovered, and some workloads even report an
improvement over the v5.10 results.

Thanks Michael for the feedback!


v1 at https://lore.kernel.org/lkml/20210121003223.20257-1-ggherdovich@suse.cz/

Changes wrt v1:

- move code around so that it builds for non-x86 architectures too

Giovanni Gherdovich (1):
  x86,sched: On AMD EPYC set freq_max = max_boost in schedutil invariant
    formula

 drivers/cpufreq/acpi-cpufreq.c   | 64 +++++++++++++++++++++++++++++++-
 drivers/cpufreq/cpufreq.c        |  3 ++
 include/linux/cpufreq.h          |  5 +++
 kernel/sched/cpufreq_schedutil.c |  8 +++-
 4 files changed, 76 insertions(+), 4 deletions(-)

-- 
2.26.2

