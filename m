Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F551B577
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiEECCF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiEECCD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:02:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864924C788;
        Wed,  4 May 2022 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715905; x=1683251905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WMMQI6LaG8XnQdWUmuMOfgF6HNdtWI8KYOOxX5jpl9E=;
  b=dfW6c0HPJeDYtd2hBUO+cJ8lUtyNQsTCEF8DI29+7Z1BXpdPiMArB1WU
   MiGJGpex74DvZ/EuB52mq9n3N5hUm0pYrBJz3myMspxFG6bwrFB1Iy8ic
   kKqlO5ItGQuB21qcidqSJKdZ4TU4K46zufie3lP1VXXxXb5BEffTxGy2Q
   d3O3IU6dMKuItJ8DYgSRl0aoK5Z29iIciamID5O2IoqpfzXYuei9pQDlG
   uDtQz14cuq7YEwh8UEdlajorYekWn5nrocjNHkKWuoqK6xw9yxEs8WqL7
   d2O4RmfrSl6+2J7I726qCI4XEw7ATylTctGP+A5FB/IFyky5jM0TGIpqT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153468"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537105992"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:21 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 3/7] thermal: intel: pch: improve the cooling delay log
Date:   Thu,  5 May 2022 09:58:10 +0800
Message-Id: <20220505015814.3727692-4-rui.zhang@intel.com>
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

Previously, during suspend, intel_pch_thermal driver logs for every
cooling iteration, about the current PCH temperature and number of cooling
iterations that have been tried, like below

[  100.955526] intel_pch_thermal 0000:00:14.2: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 1 times for 100 ms duration
[  101.064156] intel_pch_thermal 0000:00:14.2: CPU-PCH current temp [53C] higher than the threshold temp [50C], sleep 2 times for 100 ms duration

After changing the default delay_cnt to 600, in practice, it is common to
see tens of the above messages if the system is suspended when PCH
overheats. Thus, change this log message from dev_warn to dev_dbg because
it is only useful when we want to check the temperature trend.

At the same time, there is always a one-line message given by the driver
with the patch applied, with below four possibilities.

1. PCH is cool, no cooling delay needed
[ 1791.902853] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [48C]

2. PCH overheats and becomes cool after the cooling delays
[ 1475.511617] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C] after 30700 ms delay

3. PCH still overheats after the overall cooling timeout
[ 2250.157487] intel_pch_thermal 0000:00:12.0: CPU-PCH is hot [60C] after 60000 ms delay. S0ix might fail

4. PCH aborts cooling because of wakeup event detected during the delay
[ 1933.639509] intel_pch_thermal 0000:00:12.0: Wakeup event detected, abort cooling

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 31 +++++++++++++++--------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index b7b32e2f5ae2..c1fa2b29b153 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -197,7 +197,7 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
-	int pch_delay_cnt = 1;
+	int pch_delay_cnt = 0;
 	u16 pch_thr_temp, pch_cur_temp;
 
 	/* Shutdown the thermal sensor if it is not enabled by BIOS */
@@ -233,29 +233,38 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 	 * temperature stays above threshold, notify the warning message
 	 * which helps to indentify the reason why S0ix entry was rejected.
 	 */
-	while (pch_delay_cnt <= delay_cnt) {
+	while (pch_delay_cnt < delay_cnt) {
 		if (pch_cur_temp < pch_thr_temp)
 			break;
 
-		if (pm_wakeup_pending())
-			break;
+		if (pm_wakeup_pending()) {
+			dev_warn(&ptd->pdev->dev, "Wakeup event detected, abort cooling\n");
+			return 0;
+		}
 
-		dev_warn(&ptd->pdev->dev,
+		pch_delay_cnt++;
+		dev_dbg(&ptd->pdev->dev,
 			"CPU-PCH current temp [%dC] higher than the threshold temp [%dC], sleep %d times for %d ms duration\n",
 			pch_cur_temp, pch_thr_temp, pch_delay_cnt, delay_timeout);
 		msleep(delay_timeout);
 		/* Read the PCH current temperature for next cycle. */
 		pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
-		pch_delay_cnt++;
 	}
 
 	if (pch_cur_temp >= pch_thr_temp)
 		dev_warn(&ptd->pdev->dev,
-			"CPU-PCH is hot [%dC] even after delay, continue to suspend. S0ix might fail\n",
-			pch_cur_temp);
-	else
-		dev_info(&ptd->pdev->dev,
-			"CPU-PCH is cool [%dC], continue to suspend\n", pch_cur_temp);
+			"CPU-PCH is hot [%dC] after %d ms delay. S0ix might fail\n",
+			pch_cur_temp, pch_delay_cnt * delay_timeout);
+	else {
+		if (pch_delay_cnt)
+			dev_info(&ptd->pdev->dev,
+				"CPU-PCH is cool [%dC] after %d ms delay\n",
+				pch_cur_temp, pch_delay_cnt * delay_timeout);
+		else
+			dev_info(&ptd->pdev->dev,
+				"CPU-PCH is cool [%dC]\n",
+				pch_cur_temp);
+	}
 
 	return 0;
 }
-- 
2.17.1

