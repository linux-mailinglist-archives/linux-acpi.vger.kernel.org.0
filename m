Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4597C3C18E8
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGHSLn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:43 -0400
Received: from foss.arm.com ([217.140.110.172]:35974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhGHSLn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BEE6D6E;
        Thu,  8 Jul 2021 11:09:01 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 261283F66F;
        Thu,  8 Jul 2021 11:09:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 02/13] ACPI: CPPC: Fix doxygen comments
Date:   Thu,  8 Jul 2021 19:08:40 +0100
Message-Id: <20210708180851.2311192-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Clang complains about doxygen comments too with W=1 in the build.

  | drivers/acpi/cppc_acpi.c:560: warning: Function parameter or member
  |	'pcc_ss_id' not described in 'pcc_data_alloc'
  | drivers/acpi/cppc_acpi.c:1343: warning: Function parameter or member
  |	'cpu_num' not described in 'cppc_get_transition_latency'

Fix it.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/cppc_acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..eb5685167d19 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -562,6 +562,8 @@ bool __weak cpc_ffh_supported(void)
 /**
  * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
  *
+ * @pcc_ss_id: PCC Subspace channel identifier
+ *
  * Check and allocate the cppc_pcc_data memory.
  * In some processor configurations it is possible that same subspace
  * is shared between multiple CPUs. This is seen especially in CPUs
@@ -1347,10 +1349,15 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
  *
+ * @cpu_num: Logical index of the CPU for which latencty is requested
+ *
  * ACPI CPPC does not explicitly specify how a platform can specify the
  * transition latency for performance change requests. The closest we have
  * is the timing information from the PCCT tables which provides the info
  * on the number and frequency of PCC commands the platform can handle.
+ *
+ * Returns: frequency transition latency on success or CPUFREQ_ETERNAL on
+ * failure
  */
 unsigned int cppc_get_transition_latency(int cpu_num)
 {
-- 
2.25.1

