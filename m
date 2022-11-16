Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306662B42F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiKPHtp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiKPHtj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D84CD12A8A
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C0813D5;
        Tue, 15 Nov 2022 23:49:45 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8EF3F73B;
        Tue, 15 Nov 2022 23:49:38 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 4/5] ACPI: PM: Silence missing prototype warning
Date:   Wed, 16 Nov 2022 07:49:29 +0000
Message-Id: <20221116074930.3292121-5-sudeep.holla@arm.com>
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

Silence the following warning when built with W=1:

 | CC   drivers/acpi/device_pm.c
 |      warning: no previous prototype for function 'acpi_subsys_restore_early' [-Wmissing-prototypes]
 |              int acpi_subsys_restore_early(struct device *dev)
 |                  ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 78d72730ec65..5e6a876e17ba 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1137,6 +1137,7 @@ int acpi_subsys_freeze(struct device *dev);
 int acpi_subsys_poweroff(struct device *dev);
 void acpi_ec_mark_gpe_for_wake(void);
 void acpi_ec_set_gpe_wake_mask(u8 action);
+int acpi_subsys_restore_early(struct device *dev);
 #else
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
@@ -1145,6 +1146,7 @@ static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
 static inline int acpi_subsys_poweroff(struct device *dev) { return 0; }
+static inline int acpi_subsys_restore_early(struct device *dev) { return 0; }
 static inline void acpi_ec_mark_gpe_for_wake(void) {}
 static inline void acpi_ec_set_gpe_wake_mask(u8 action) {}
 #endif
-- 
2.38.1

