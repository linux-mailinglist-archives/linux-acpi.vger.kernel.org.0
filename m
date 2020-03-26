Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2F194175
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Mar 2020 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgCZO3b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Mar 2020 10:29:31 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37563 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgCZO3a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Mar 2020 10:29:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TthONLz_1585232950;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TthONLz_1585232950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Mar 2020 22:29:18 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / CPPC: clean up acpi_get_psd_map
Date:   Thu, 26 Mar 2020 22:29:10 +0800
Message-Id: <1585232950-123704-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch cleans up acpi_get_psd_map function. If got here,
variable all_cpu_data[] can't be NULL. Variable match_cpc_ptr has been
checked before, no need check again at the end of the funchtion. Then
some code logic should be optimized.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/acpi/cppc_acpi.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a1a858a..8b2e89c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -438,13 +438,10 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
-		pr = all_cpu_data[i];
-		if (!pr)
-			continue;
-
 		if (cpumask_test_cpu(i, covered_cpus))
 			continue;
 
+		pr = all_cpu_data[i];
 		cpc_ptr = per_cpu(cpc_desc_ptr, i);
 		if (!cpc_ptr) {
 			retval = -EFAULT;
@@ -495,44 +492,28 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
 			cpumask_set_cpu(j, pr->shared_cpu_map);
 		}
 
-		for_each_possible_cpu(j) {
+		for_each_cpu(j, pr->shared_cpu_map) {
 			if (i == j)
 				continue;
 
 			match_pr = all_cpu_data[j];
-			if (!match_pr)
-				continue;
-
-			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
-			if (!match_cpc_ptr) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
-
-			match_pdomain = &(match_cpc_ptr->domain_info);
-			if (match_pdomain->domain != pdomain->domain)
-				continue;
-
 			match_pr->shared_type = pr->shared_type;
 			cpumask_copy(match_pr->shared_cpu_map,
 				     pr->shared_cpu_map);
 		}
 	}
+	goto out;
 
 err_ret:
 	for_each_possible_cpu(i) {
 		pr = all_cpu_data[i];
-		if (!pr)
-			continue;
 
 		/* Assume no coordination on any error parsing domain info */
-		if (retval) {
-			cpumask_clear(pr->shared_cpu_map);
-			cpumask_set_cpu(i, pr->shared_cpu_map);
-			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-		}
+		cpumask_clear(pr->shared_cpu_map);
+		cpumask_set_cpu(i, pr->shared_cpu_map);
+		pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 	}
-
+out:
 	free_cpumask_var(covered_cpus);
 	return retval;
 }
-- 
1.8.3.1

