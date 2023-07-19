Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D7758FE1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jul 2023 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGSIHK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jul 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSIHK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2023 04:07:10 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401309D
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 01:07:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="113128449"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; 
   d="scan'208";a="113128449"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 17:07:06 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4B255C53C0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 17:07:04 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B3A2D5CD3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 17:07:03 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B52F4216771;
        Wed, 19 Jul 2023 17:07:02 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org, lenb@kernel.org
Cc:     ruansy.fnst@fujitsu.com
Subject: [PATCH] nfit: remove redundant list_for_each_entry
Date:   Wed, 19 Jul 2023 16:05:26 +0800
Message-ID: <20230719080526.2436951-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27760.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27760.006
X-TMASE-Result: 10--0.411800-10.000000
X-TMASE-MatchedRID: IT0zHGwjLhXQMti10yO4NxF4zyLyne+ATJDl9FKHbrmZtziFUn+D+Wv9
        QzDsKb/X4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8hxKpvEGAbTDkE3xX7i3kriX0g
        ev3TPm7mL19MGbrk04kQzslkF5EIJEXWkFKkZrbLfO8sMavl2aHeZrgXTGbZeWezti4XgSbjEvD
        1R9OW/kluMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The first for_each only do acpi_nfit_init_ars() for NFIT_SPA_VOLATILE
and NFIT_SPA_PM, which can be moved to next one.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/acpi/nfit/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..4090a0a0505c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2971,14 +2971,6 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 		case NFIT_SPA_VOLATILE:
 		case NFIT_SPA_PM:
 			acpi_nfit_init_ars(acpi_desc, nfit_spa);
-			break;
-		}
-	}
-
-	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
-		switch (nfit_spa_type(nfit_spa->spa)) {
-		case NFIT_SPA_VOLATILE:
-		case NFIT_SPA_PM:
 			/* register regions and kick off initial ARS run */
 			rc = ars_register(acpi_desc, nfit_spa);
 			if (rc)
-- 
2.41.0

