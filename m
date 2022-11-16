Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685C762B42C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKPHti (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiKPHti (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D35912A8A
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C69150C;
        Tue, 15 Nov 2022 23:49:43 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40AC33F73B;
        Tue, 15 Nov 2022 23:49:36 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/5] ACPI: processor_idle: Silence missing prototype warnings
Date:   Wed, 16 Nov 2022 07:49:27 +0000
Message-Id: <20221116074930.3292121-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116074930.3292121-1-sudeep.holla@arm.com>
References: <20221116074930.3292121-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Silence the following warnings when built with W=1:

 | CC   drivers/acpi/processor_idle.c
 |      warning: no previous prototype for 'acpi_processor_ffh_lpi_probe' [-Wmissing-prototypes]
 |		int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
 |                         ^
 | CC   drivers/acpi/processor_idle.c
 |      warning: no previous prototype for 'acpi_processor_ffh_lpi_enter' [-Wmissing-prototypes]
 |              int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 |                         ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/acpi/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 9fa49686957a..3f34ebb27525 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -460,4 +460,9 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 }
 #endif	/* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
+extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
+extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
+#endif
+
 #endif
-- 
2.38.1

