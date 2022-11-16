Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D562B42D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiKPHtn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiKPHtj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 192B9F5A4
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311291516;
        Tue, 15 Nov 2022 23:49:44 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CC633F73B;
        Tue, 15 Nov 2022 23:49:37 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/5] ACPI: FFH: Silence missing prototype warnings
Date:   Wed, 16 Nov 2022 07:49:28 +0000
Message-Id: <20221116074930.3292121-4-sudeep.holla@arm.com>
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

 | CC   drivers/acpi/acpi_ffh.c
 |      warning: no previous prototype for 'acpi_ffh_address_space_arch_setup' [-Wmissing-prototypes]
 |              int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
 |                         ^
 | CC   drivers/acpi/acpi_ffh.c
 |      warning: no previous prototype for 'acpi_ffh_address_space_arch_handler' [-Wmissing-prototypes]
 |              int __weak acpi_ffh_address_space_arch_handler(acpi_integer *value,
 |                         ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c026c1129cba..78d72730ec65 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1491,6 +1491,10 @@ static inline void acpi_init_pcc(void) { }
 
 #ifdef CONFIG_ACPI_FFH
 void acpi_init_ffh(void);
+extern int acpi_ffh_address_space_arch_setup(void *handler_ctxt,
+					     void **region_ctxt);
+extern int acpi_ffh_address_space_arch_handler(acpi_integer *value,
+					       void *region_context);
 #else
 static inline void acpi_init_ffh(void) { }
 #endif
-- 
2.38.1

