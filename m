Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F338068D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 11:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhENJzq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 05:55:46 -0400
Received: from foss.arm.com ([217.140.110.172]:46172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhENJzo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 05:55:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0185D1763;
        Fri, 14 May 2021 02:54:33 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 656E43F719;
        Fri, 14 May 2021 02:54:31 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64, topology: enable use of init_cpu_capacity_cppc()
Date:   Fri, 14 May 2021 10:53:39 +0100
Message-Id: <20210514095339.12979-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210514095339.12979-1-ionela.voinescu@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that the arch topology driver provides a method of setting CPU
capacity values based on information on highest performance from CPPC,
use this functionality on arm64 platforms.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/topology.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index ec2db3419c41..c6ae6b55789c 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -24,6 +24,10 @@ void update_freq_counters_refs(void);
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#define arch_init_invariance_cppc init_cpu_capacity_cppc
+#endif
+
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
-- 
2.29.2.dirty

