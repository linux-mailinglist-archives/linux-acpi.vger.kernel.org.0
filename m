Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16CA2D5D75
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbgLJOXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 09:23:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389034AbgLJOXg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 09:23:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607610169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AfFmYlDUq990VhRnxpYoKhCrY5/sWUQht2ol3RX6enI=;
        b=efS2DEQLXvjpbJOjGAuA0HZJSjkX/2Mpa31mqJ0QvF61sU1F3y01VtX2rhnXfmAcozOnVI
        fCg16UngQWUj5WjWgNTZR5yYZynUitY6kRkw7Ry50BXOTNoZi/dBJ3Hzy2s3WuZl1eL3eK
        UVajl02XKP9i1dJj0nZJDbScCWaJ6Pk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 983E3AC6A;
        Thu, 10 Dec 2020 14:22:49 +0000 (UTC)
From:   Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        ionela.voinescu@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>,
        Petr Cervinka <pcervinka@suse.com>
Subject: [PATCH 1/2] acpi: cppc: add cpufreq device
Date:   Thu, 10 Dec 2020 15:21:38 +0100
Message-Id: <20201210142139.20490-1-yousaf.kaukab@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Since commit 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with
lists"), cppc-cpufreq driver doesn't check availability of PSD data before
registering with cpufreq core. As a result on a ThunderX2 platform when
CPPC is disabled from BIOS, kernel log is spammed with following messages:

[  180.974166] CPPC Cpufreq: Error in acquiring _CPC/_PSD data for CPUxx

acpi_cppc_processor_probe() never succeed in this case because
acpi_evaluate_object_typed("_CPC") always returns AE_NOT_FOUND. When
cpufreq core calls cppc_cpufreq_cpu_init(), driver fails to obtain PSD data
and print error messages.

Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.

Fixes: 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with lists")
Reported-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/acpi/cppc_acpi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4e478f751ff7..adf9ca3be9fe 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,7 @@
 #include <linux/ktime.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/platform_device.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -606,6 +607,23 @@ static bool is_cppc_supported(int revision, int num_ent)
 	return true;
 }
 
+static void add_cppc_cpufreq_dev(void)
+{
+	static bool already_added;
+
+	if (!already_added) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_register_simple("cppc-cpufreq", -1,
+				NULL, 0);
+		if (IS_ERR(pdev))
+			pr_err("Couldn't register cppc-cpufreq err=%ld\n",
+					PTR_ERR(pdev));
+		else
+			already_added = true;
+	}
+}
+
 /*
  * An example CPC table looks like the following.
  *
@@ -815,6 +833,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 
 	kfree(output.pointer);
+
+	add_cppc_cpufreq_dev();
+
 	return 0;
 
 out_free:
-- 
2.26.2

