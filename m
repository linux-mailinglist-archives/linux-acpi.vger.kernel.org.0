Return-Path: <linux-acpi+bounces-581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE67C4D4D
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 10:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE73928213D
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FC199D3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC3eIXGB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CA1A70E
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 08:34:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D49E;
	Wed, 11 Oct 2023 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013245; x=1728549245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9GeUK2SGN9OGtW6dMn16QDj8PfFEO9Do3zKwnp3cbpk=;
  b=CC3eIXGBDVnsQ2a/56YWAEhsevQciyUY/Nw6AUcwDf1XTrQvJ/+pgoO0
   2TfTAJWVZ4CVX3JfIvqTh9R5YIaDYXe+Y9Noy7xc4xV0ByzEbx4+rMEuS
   zoyCnjHP+xi46IVZq49Cv+shdPfXaikOGhgTTG4DN3kPjlpFmlKEHkBRi
   MJw/k0URAvCaCe/zNSb+B0wXl3+QvOGnasif2BkLxXktnEVNTsTzMsxvv
   fVGZB5Rr9/wEuHm8IhRAuTxTY8DIKtUFxhyK+tFWLeTYB54/Mu4C9twE1
   cuLNDhRXY30vR5IIU4QEIFpdunAF3J3xt/FYwW8Qp5DnKmR7ZE5o+/JLX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388480169"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388480169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897548199"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897548199"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:32:16 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 2/6] ACPI: AC: Use string_choices API instead of ternary operator
Date: Wed, 11 Oct 2023 11:33:30 +0300
Message-ID: <20231011083334.3987477-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011083334.3987477-1-michal.wilczynski@intel.com>
References: <20231011083334.3987477-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use modern string_choices API instead of manually determining the
output using ternary operator.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 83d45c681121..f809f6889b4a 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/string_choices.h>
 #include <linux/acpi.h>
 #include <acpi/battery.h>
 
@@ -243,8 +244,8 @@ static int acpi_ac_add(struct acpi_device *device)
 		goto err_release_ac;
 	}
 
-	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
-		acpi_device_bid(device), ac->state ? "on-line" : "off-line");
+	pr_info("%s [%s] (%s-line)\n", acpi_device_name(device),
+		acpi_device_bid(device), str_on_off(ac->state));
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
-- 
2.41.0


