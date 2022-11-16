Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD162B42E
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiKPHto (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiKPHtk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C7B12A98
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006CB1477;
        Tue, 15 Nov 2022 23:49:46 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F33843F73B;
        Tue, 15 Nov 2022 23:49:38 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 5/5] ACPI: processor: Silence missing prototype warnings
Date:   Wed, 16 Nov 2022 07:49:30 +0000
Message-Id: <20221116074930.3292121-6-sudeep.holla@arm.com>
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

 | CC   drivers/acpi/acpi_processor.c
 |      warning: no previous prototype for 'arch_register_cpu' [-Wmissing-prototypes]
 |              int __weak arch_register_cpu(int cpu)
 |                         ^
 | CC   drivers/acpi/acpi_processor.c
 |      warning: no previous prototype for 'arch_unregister_cpu' [-Wmissing-prototypes]
 |              void __weak arch_unregister_cpu(int cpu) {}
 |                          ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/acpi/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 3f34ebb27525..94181fe9780a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -465,4 +465,9 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
 extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
+#endif
+
 #endif
-- 
2.38.1

