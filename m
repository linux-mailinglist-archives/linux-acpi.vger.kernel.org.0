Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820D51B593
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiEECCA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiEECB7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:01:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5CF473BD;
        Wed,  4 May 2022 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715901; x=1683251901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VDPDVStC+kmpJjWbHPX1nYEBC4CzD4iAHbBoI2lYF40=;
  b=S7CSAI395cnCMlK6SZK3GuAHKJvQFM+MSCxkj9RLf898IJqbBe1eeV45
   RnNO2bMjpz4Olm9kDxXP/pQ4FNN8WEi5nG5e7ykDJVv0f7laHSb1ReA2k
   lChA1W7vElfu7/Y0jb5dORr6YOtkHHYU17BzM2BBCVEKhJjEdn8SmtxLP
   fs0gZtJM3ahQFiryC5071AM3ETFdSjG4v1ygk60NSVcn8nxFRTWCM/Vlp
   3FQkJC/F7LhYkSece2uvAT7htPkapbknv3oXbO/02eA/Ul8aBOd4wBf0i
   uqGj/gc9k4emOdujoivTEBWt/NEazxWk3U4SXTABxULXqYDNP++1GSGv/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153451"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153451"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537105986"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:18 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 2/7] thermal: intel: pch: enhance overheat handling
Date:   Thu,  5 May 2022 09:58:09 +0800
Message-Id: <20220505015814.3727692-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505015814.3727692-1-rui.zhang@intel.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
temperature above threshold") introduces delay loop mechanism that allows
PCH temperature to go down below threshold during suspend so it won't
block S0ix. And the default overall delay timeout is 1 second.

However, in practice, we found that the time it takes to cool the PCH down
below threshold highly depends on the initial PCH temperature when the
delay starts, as well as the ambient temperature.
And in some cases, the 1 second delay is not sufficient. As a result, the
system stays in a shallower power state like PCx instead of S0ix, and
drains the battery power, without user' notice.

To make sure S0ix is not blocked by the PCH overheating, we
1. expand the default overall timeout to 60 seconds.
2. make sure the temperature is below threshold rather than equal to it.
3. move the delay to .suspend_noirq phase instead, in order to
   a) do cooling delay with a more quiescent system
   b) be aware of wakeup events during the long delay, because some wakeup
      events (ACPI Power button Press, USB mouse, etc) become valid only
      in .suspend_noirq phase and later.

This may introduce longer suspend time, but only in the cases when the
system overheats and Linux used to enter a shallower S2idle state, say,
PCx instead of S0ix.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 527c91f5960b..b7b32e2f5ae2 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -70,8 +70,8 @@ static unsigned int delay_timeout = 100;
 module_param(delay_timeout, int, 0644);
 MODULE_PARM_DESC(delay_timeout, "amount of time delay for each iteration.");
 
-/* Number of iterations for cooling delay, 10 counts by default for now */
-static unsigned int delay_cnt = 10;
+/* Number of iterations for cooling delay, 600 counts by default for now */
+static unsigned int delay_cnt = 600;
 module_param(delay_cnt, int, 0644);
 MODULE_PARM_DESC(delay_cnt, "total number of iterations for time delay.");
 
@@ -193,10 +193,11 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 	return 0;
 }
 
+/* Cool the PCH when it's overheat in .suspend_noirq phase */
 static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
-	u8 pch_delay_cnt = 1;
+	int pch_delay_cnt = 1;
 	u16 pch_thr_temp, pch_cur_temp;
 
 	/* Shutdown the thermal sensor if it is not enabled by BIOS */
@@ -233,7 +234,10 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 	 * which helps to indentify the reason why S0ix entry was rejected.
 	 */
 	while (pch_delay_cnt <= delay_cnt) {
-		if (pch_cur_temp <= pch_thr_temp)
+		if (pch_cur_temp < pch_thr_temp)
+			break;
+
+		if (pm_wakeup_pending())
 			break;
 
 		dev_warn(&ptd->pdev->dev,
@@ -245,7 +249,7 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 		pch_delay_cnt++;
 	}
 
-	if (pch_cur_temp > pch_thr_temp)
+	if (pch_cur_temp >= pch_thr_temp)
 		dev_warn(&ptd->pdev->dev,
 			"CPU-PCH is hot [%dC] even after delay, continue to suspend. S0ix might fail\n",
 			pch_cur_temp);
@@ -455,7 +459,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int intel_pch_thermal_suspend(struct device *device)
+static int intel_pch_thermal_suspend_noirq(struct device *device)
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
@@ -495,7 +499,7 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
 
 static const struct dev_pm_ops intel_pch_pm_ops = {
-	.suspend = intel_pch_thermal_suspend,
+	.suspend_noirq = intel_pch_thermal_suspend_noirq,
 	.resume = intel_pch_thermal_resume,
 };
 
-- 
2.17.1

