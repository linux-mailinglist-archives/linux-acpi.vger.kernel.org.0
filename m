Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4C59A3F1
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Aug 2022 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbiHSRHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Aug 2022 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350779AbiHSRGy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2022 13:06:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D697CCE26;
        Fri, 19 Aug 2022 09:27:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9071175A;
        Fri, 19 Aug 2022 09:26:25 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D06D23F66F;
        Fri, 19 Aug 2022 09:26:23 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 2/2] cpufreq: CPPC: Change FIE default
Date:   Fri, 19 Aug 2022 11:25:47 -0500
Message-Id: <20220819162547.141333-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220819162547.141333-1-jeremy.linton@arm.com>
References: <20220819162547.141333-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

FIE is mostly implemented as PCC mailboxes on arm machines.  This was
enabled by default without any data suggesting that it does anything
but hurt system performance. Lets change the default to 'n' until
hardware appears which clearly benefits.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..ad66d8f15db0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
 config ACPI_CPPC_CPUFREQ_FIE
 	bool "Frequency Invariance support for CPPC cpufreq driver"
 	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
-	default y
+	default n
 	help
 	  This extends frequency invariance support in the CPPC cpufreq driver,
 	  by using CPPC delivered and reference performance counters.
-- 
2.37.1

