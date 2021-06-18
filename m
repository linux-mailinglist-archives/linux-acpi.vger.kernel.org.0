Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B83ACC73
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhFRNnW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 09:43:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:46601 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhFRNnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 09:43:21 -0400
IronPort-SDR: sHMXAt/QsUk9PYbpsKnPf2CaDKTpLCto1++f468hvtnKj1Dkz6kpdMDbzv9vVhi0tqQewe1/Um
 OqKJ1ZCNAlsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206505398"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="206505398"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:41:11 -0700
IronPort-SDR: iyygx+58mlC2GMejq+dIOom1L92eLlYbOy+LQFrubTG1ekPdi75Oqs/dTP3NVpKWiyFjRjFcGc
 1PLS8LlpS5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485691314"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2021 06:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23401516; Fri, 18 Jun 2021 16:41:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/2] ACPI: sysfs: Remove tailing return statement in void function
Date:   Fri, 18 Jun 2021 16:41:28 +0300
Message-Id: <20210618134128.59335-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618134128.59335-1-andriy.shevchenko@linux.intel.com>
References: <20210618134128.59335-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The tail return statement is redundant in void functions. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of bleeding-edge (Rafael)

 drivers/acpi/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 18e93c3c39cf..00c0ebaab29f 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -897,7 +897,6 @@ void acpi_irq_stats_init(void)
 
 fail:
 	delete_gpe_attr_array();
-	return;
 }
 
 static void __exit interrupt_stats_exit(void)
-- 
2.30.2

