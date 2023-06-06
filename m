Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331737248C5
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjFFQRD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjFFQRC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 12:17:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B111736
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686068205; x=1717604205;
  h=from:to:subject:date:message-id:mime-version;
  bh=rJ6wMNYd/dibcosl3/T6avvH5DX77AR3Ln4lnPAmo+0=;
  b=DMticJrQLd8ZKpceksjHT6QBJDfNGBBzvLXkL84sJCdH2Gf5GhelktdU
   ZEm3vvfpzZuRnwhANypn1bk7wvvXrCaxK8tkZScQanABEI07iqVPM6U95
   jAztFtSyuYfmhdRUaXhqr53w/8wISg7cdbi1IyWGgDxqgwuo9JJ9Tl5IH
   AdIU8oEtjFHF4ZQngkLy3XVQDTMjiDxFDJTmQ67AJDwPWJwWIz0svh+1C
   6Jk2GOFJM44mqf3gAz/0jhTNAyFqVZhSHyUEbMFUCrCSnvXCehbTls5cE
   yS7YSrM63OXzsoTD57Ee/FQ9nLShPyOjSSTDKngH8sA6lVeFaNejlTgRT
   w==;
IronPort-Data: A9a23:0VyBTaDqPh1AyRVW/3Diw5YqxClBgxIJ4kV8jS/XYbTApG92gWQFy
 WZKUGuGO/jfYWX0e9xzady1pBwGupXXmNdhTANkpHpgcSl2pJueD7x1DKtR0wB+jCHnZBs/t
 63yv/GZdJhcoln0+En1atANilEljf7THdIQMMadZmYrA1UMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPa4T5jcyqlFOZH4hDfDpR5fHatQMdgKKb
 76r5K20+Grf4yAsBruN+losWhZSKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nVKtio27hc+ZZk
 4wR6MPqGW/FCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZX7I0Er6BIAahihZa07FdRwxwp5PY1B3
 fk2Cy0vfErYvsnog7mgadI915sBFda+aevzulk4pd3YJfgjWpXMSv2SuZlW2XExgNxDGbDVY
 M9xhThHNUyGOUAUfA1LTs5u9AurriCXnzlwql+PqK8mpWPUyRR2y6TgNN7cUt2MWchR2E2fo
 woq+kyiX09Fb4LBmWDtHnSE2/HT3iDWZb0oTayzztU7hV3PzUExB0hDPbe8ibzj4qKkYPpbK
 koJ6m8nprAz3FKkQ8O7XBCipnOA+BkGVLJt//YS5gSWz6Xdu17FQGYBCD9HdNEi8sQxQFTGy
 2O0oj8gPhQ32JX9dJ5X3ufJ8Fte5QB9wbc+WBI5
IronPort-HdrOrdr: A9a23:aZ736Ky68fC68Ht+vxD4KrPwJb1zdoMgy1knxilNoH1uA6ulfq
 +V/MjzuSWatN9zYgBFpTnjAtjifZoNz+8R3WB5B97LMDUO01HIEGgN1+XfKnHbak/DH6lmvp
 uIdZIVZeHNMQ==
X-Talos-CUID: 9a23:CbvDHW13HCQSxHyv2d2QgrxfH+4Gb1/PlizpCBH7An1Kc+zEFn2p5/Yx
X-Talos-MUID: 9a23:6wF6AwmGcMqTHntHjsvxdno/Ktsr4ImTN3pUgJ4+kJiBNXB7FhWS2WE=
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356736682"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="356736682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 09:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="779038409"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="779038409"
Received: from samueldu-mobl1.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.117.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 09:13:24 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <linux-acpi@vger.kernel.org>
Subject: [PATCH v2] ACPI: EC: Clear GPE on interrupt handling only
Date:   Tue, 06 Jun 2023 09:13:23 -0700
Message-ID: <875y80lgbg.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
        95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On multiple devices I work on, we noticed that
/sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
over time.

It turns out that there is a race condition between servicing a GPE
interrupt and handling task driven transactions.

If a GPE interrupt is received at the same time ec_poll() is running,
the advance_transaction() clears the GPE flag and the interrupt is not
serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
handler. As a result, `sci_not' is increased.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 drivers/acpi/ec.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 928899ab9502..8569f55e55b6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -662,21 +662,6 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
 
-	/*
-	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
-	 * changes to always trigger a GPE interrupt.
-	 *
-	 * GPE STS is a W1C register, which means:
-	 *
-	 * 1. Software can clear it without worrying about clearing the other
-	 *    GPEs' STS bits when the hardware sets them in parallel.
-	 *
-	 * 2. As long as software can ensure only clearing it when it is set,
-	 *    hardware won't set it in parallel.
-	 */
-	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
-		acpi_clear_gpe(NULL, ec->gpe);
-
 	status = acpi_ec_read_status(ec);
 
 	/*
@@ -1287,6 +1272,22 @@ static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ec->lock, flags);
+
+	/*
+	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
+	 * changes to always trigger a GPE interrupt.
+	 *
+	 * GPE STS is a W1C register, which means:
+	 *
+	 * 1. Software can clear it without worrying about clearing the other
+	 *    GPEs' STS bits when the hardware sets them in parallel.
+	 *
+	 * 2. As long as software can ensure only clearing it when it is set,
+	 *    hardware won't set it in parallel.
+	 */
+	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
+		acpi_clear_gpe(NULL, ec->gpe);
+
 	advance_transaction(ec, true);
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
-- 
2.40.1

