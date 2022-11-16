Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51662B42B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKPHti (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKPHth (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 421D2F5A4
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5668C1477;
        Tue, 15 Nov 2022 23:49:42 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5371E3F73B;
        Tue, 15 Nov 2022 23:49:35 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/5] ACPI: APEI: Silence missing prototype warnings
Date:   Wed, 16 Nov 2022 07:49:26 +0000
Message-Id: <20221116074930.3292121-2-sudeep.holla@arm.com>
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

Silence the following warnings when make W=1:

 | CC   drivers/acpi/apei/apei-base.c
 |      warning: no previous prototype for 'arch_apei_enable_cmcff' [-Wmissing-prototypes]
 |              int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
 |                         ^
 | CC   drivers/acpi/apei/apei-base.c
 |      warning: no previous prototype for 'arch_apei_report_mem_error' [-Wmissing-prototypes]
 |              void __weak arch_apei_report_mem_error(int sev,
 |                          ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/apei/apei-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 9b52482b4ed5..02196a312dc5 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -28,6 +28,7 @@
 #include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
+#include <acpi/apei.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
-- 
2.38.1

