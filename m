Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5C523499
	for <lists+linux-acpi@lfdr.de>; Wed, 11 May 2022 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiEKNrO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 May 2022 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbiEKNqi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2022 09:46:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B088B0A6;
        Wed, 11 May 2022 06:46:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E16ED1;
        Wed, 11 May 2022 06:46:37 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4FDC3F66F;
        Wed, 11 May 2022 06:46:34 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH v1 5/5] cpufreq: CPPC: Enable dvfs_possible_from_any_cpu
Date:   Wed, 11 May 2022 15:45:59 +0200
Message-Id: <20220511134559.1466925-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511134559.1466925-1-pierre.gondois@arm.com>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

The communication mean of the _CPC desired performance can be
PCC, System Memory, System IO, or Functional Fixed Hardware (FFH).

PCC, SystemMemory and SystemIo address spaces are available from any
CPU. Thus, dvfs_possible_from_any_cpu should be enabled in such case.
For FFH, let the FFH implementation do smp_call_function_*() calls.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 000a0c610c30..ad1535fbf389 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -558,6 +558,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->fast_switch_possible = cppc_allow_fast_switch();
+	policy->dvfs_possible_from_any_cpu = true;
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
-- 
2.25.1

