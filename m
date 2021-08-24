Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6203B3F5C85
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Aug 2021 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhHXK5s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Aug 2021 06:57:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236413AbhHXK5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Aug 2021 06:57:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69BD213A1;
        Tue, 24 Aug 2021 03:57:04 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE12B3F66F;
        Tue, 24 Aug 2021 03:57:02 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] x86, ACPI: rename init_freq_invariance_cppc to arch_init_invariance_cppc
Date:   Tue, 24 Aug 2021 11:56:49 +0100
Message-Id: <20210824105651.28660-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210824105651.28660-1-ionela.voinescu@arm.com>
References: <20210824105651.28660-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
after CPU performance information and controls were populated from the
per-cpu _CPC objects.

But these _CPC objects provide information that helps with both CPU
(u-arch) and frequency invariance. Therefore, change the function name
to a more generic one, while adding the arch_ prefix, as this function
is expected to be defined differently by different architectures.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/x86/include/asm/topology.h | 2 +-
 drivers/acpi/cppc_acpi.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9239399e5491..61d73013cab8 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -220,7 +220,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
-#define init_freq_invariance_cppc init_freq_invariance_cppc
+#define arch_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..c211d77310e8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -660,8 +660,8 @@ static bool is_cppc_supported(int revision, int num_ent)
  *	}
  */
 
-#ifndef init_freq_invariance_cppc
-static inline void init_freq_invariance_cppc(void) { }
+#ifndef arch_init_invariance_cppc
+static inline void arch_init_invariance_cppc(void) { }
 #endif
 
 /**
@@ -826,7 +826,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	init_freq_invariance_cppc();
+	arch_init_invariance_cppc();
 
 	kfree(output.pointer);
 	return 0;
-- 
2.29.2.dirty

