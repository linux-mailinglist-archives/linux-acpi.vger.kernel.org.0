Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFD51B578
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiEECCW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiEECCS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:02:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B1517D7;
        Wed,  4 May 2022 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715913; x=1683251913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4y+SqlpkERJz24KIBdtwYj/W11USKE8UV94SQY//KAI=;
  b=O9PMPZAKmqpVI4n5s2+vg6bRtUe4ZqDf7yCNr88Zz6MoXx8XjiN2texa
   pIrX/H/zd9N9LEl8e0oSl3sK4i4BU5Dfd/sms6hv0kJtQD3LSE3hjL7pc
   oq409nS2WD+U1lMvtFbVHBemhrCwAdQtzzdR1whvzg3v7QB0o/MCbrHXx
   qhPKUbIDuLi9gSIpquxpz8toNKzp6R9q/U6R4iECwL7ZyH0fOX7WKdEnd
   0Q2SnO/vpZf4p3Xt8AYvlSwrrcwc+/Vz9uCYizhxZPGeJmCCVPkH14996
   8/wHXJWbBNIeU+w52OJHYtqPj7EQe1yUNsD1k4uDGm00dKm76f9GOBMts
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153497"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153497"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537106028"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:30 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 6/7] PM: suspend: introduce PM_SUSPEND_LATE event
Date:   Thu,  5 May 2022 09:58:13 +0800
Message-Id: <20220505015814.3727692-7-rui.zhang@intel.com>
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

In some cases, special handling is needed after the .suspend_noirq phase.

Introduce a new suspend event PM_SUSPEND_LATE and call the notifier chain
for this purpose.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 include/linux/suspend.h | 1 +
 kernel/power/suspend.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 300273ff40cc..01ec171e8f60 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -477,6 +477,7 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
+#define PM_SUSPEND_LATE		0x0007 /* Late suspend phase */
 
 extern struct mutex system_transition_mutex;
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6fcdee7e87a5..3c662acc908f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -415,6 +415,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
+	pm_notifier_call_chain(PM_SUSPEND_LATE);
+
 	if (state == PM_SUSPEND_TO_IDLE) {
 		s2idle_loop();
 		goto Platform_wake;
-- 
2.17.1

