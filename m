Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9001E51B58F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiEECCS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiEECCI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:02:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7A4ECD5;
        Wed,  4 May 2022 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715911; x=1683251911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5C/etphdoBTSvNC1EwNHN7GPLjVZkwPRthfMpXUb+xQ=;
  b=cLuIPwoHkWx2m2TT0hBfYdjynRIJJOJmdjnKiPpJAP5uvPyf2ygg6+b7
   b1LPUV2Kc2xAeJkK/KkXspgqR0F8o+/MKlTtj7OIVqId9UEw90DHUO7/I
   HU6wEwm77ZJIUSxubj138oCiSpKZeXxgRTpaSpue5xXZVEfT0ycEme507
   AtBdTaDvBB7n9Nx0nG+ZOGxI/4YKgkzv/wW7InOnKCXC7KCdlXKR7l20G
   5ujM/4AYUORVB3zPyicXkjyoKQE9EeZcF75n4I6Jyk2OlNqL1nwWpZI/1
   Hl3d2FwRaHIEGkV6WsXNs/0v0w0OD/tnJG6h8Q61Ct0Xlrj0R6BFnEU66
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153484"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153484"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537106016"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:27 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 5/7] wil6210: remove debug message for unsupported PM event
Date:   Thu,  5 May 2022 09:58:12 +0800
Message-Id: <20220505015814.3727692-6-rui.zhang@intel.com>
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

Remove the useless debug message for unsupported PM event because it is
noop in current code, and it gives a warning when a new event is
introduced, which it doesn't care.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/net/wireless/ath/wil6210/pcie_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index ce40d94909ad..1d6c4e926004 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -600,7 +600,6 @@ static int wil6210_pm_notify(struct notifier_block *notify_block,
 						      evt);
 		break;
 	default:
-		wil_dbg_pm(wil, "unhandled notify mode %ld\n", mode);
 		break;
 	}
 
-- 
2.17.1

