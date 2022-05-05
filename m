Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6409751B57B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiEECB6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiEECB4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:01:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE709496BA;
        Wed,  4 May 2022 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715898; x=1683251898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3ZZxLXW0g++7yQ4TCcNc5rHJLllJ4ihW+EZESk4M/k=;
  b=IghTVzWkpKU/e+63p3N1STkgvuJkh5mHrV4daiOf6mULUsrm5zktQrBt
   LlDKsQf412fM9MrohkOgNrvTar/rjDGWIpt14DP8rfR8m+RumQnPwwpm6
   blwGC1955HoUOhDF9QqloFGTv/YXXcKhJQgiJDrrQgvz0ACeZ37lTTAwd
   rmH3y7gRRASlH+nrKWLpkdA5aqja4nt2as6n+lmbtXM5zjLSrSzdvDTlK
   q9D5qd4jylIVt4PhphnoVdPLidkffKjtO7vvYgV3UrjUCGu9onrhiJLsL
   GibUX/CWpSrdM71LfNhyqOcUkf5KF/Lsvkp9O+RzvpCSGEyIjXdIOZKcn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153440"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153440"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537105979"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:15 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 1/7] PM: wakeup: expose pm_wakeup_pending to modules
Date:   Thu,  5 May 2022 09:58:08 +0800
Message-Id: <20220505015814.3727692-2-rui.zhang@intel.com>
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

intel_pch_thermal driver needs a long delay to cool itself (60 seconds
in maximum) during suspend. When a wakeup event occures during the
delay, it is better for the intel_pch_thermal driver to detect this and
quit cooling because the suspend is likely to abort anyway.

Thus expose pm_wakeup_pending to modules so that intel_pch_thermal
driver can be aware of the wakeup events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a57d469676ca..11a4ffe91367 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -930,6 +930,7 @@ bool pm_wakeup_pending(void)
 
 	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
+EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 
 void pm_system_wakeup(void)
 {
-- 
2.17.1

