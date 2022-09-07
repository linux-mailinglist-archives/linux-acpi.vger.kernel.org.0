Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E885B01EC
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Sep 2022 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIGK35 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Sep 2022 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIGK34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2022 06:29:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404E22B18;
        Wed,  7 Sep 2022 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662546594; x=1694082594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jIShqri1pu6w44wIq+yVdEEpJL1KbDbI/l4jaclyJCg=;
  b=HTj2b8E9+BonSkotoRdrUu9gOwL13FvFgwnvp/IRl2VE+/2VK2GwLSi1
   dXjRjgPFHXndIShPj5m/PHhrgq9Uhj6E3RWDxOSFeG/jenlaMkLedTnvl
   3MHgSijkJMYUg1/w66sz9g4BMEgrdy7Z84or1qChltNE6vb9IB7i0pQ3o
   /ZRARy9gr+yVxVn2Q9A8iMmRJe7bXrqei3qJr6Cal9+kGLGUmxzvzxs5g
   pq9akctqc2LfVxz7HIYTGFDYmOgOB8vYz2d61f5GM5Bv/gzpV9PLfw/VP
   a8xE0ZODKponss6nL6owtRGXF32kxBUFEjpn7d8DmCWd3MQOL5gnR5tZH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297621608"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="297621608"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 03:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="756720762"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 03:29:51 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: intel_pmc_mux: Use the helper acpi_dev_get_memory_resources()
Date:   Wed,  7 Sep 2022 13:30:07 +0300
Message-Id: <20220907103007.12954-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It removes the need to check the resource data type
separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi Rafael,

Now resending this [1]. It applies on top of -rc4 (not -rc3). The
other patches from that series you already picked.

thanks,

[1] https://lore.kernel.org/linux-acpi/20220816101629.69054-7-heikki.krogerus@linux.intel.com/
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index a8e273fe204ab..e1f4df7238bf4 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -569,15 +569,6 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 	return ret;
 }
 
-static int is_memory(struct acpi_resource *res, void *data)
-{
-	struct resource_win win = {};
-	struct resource *r = &win.res;
-
-	return !(acpi_dev_resource_memory(res, r) ||
-		 acpi_dev_resource_address_space(res, &win));
-}
-
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
 static const struct acpi_device_id iom_acpi_ids[] = {
 	/* TigerLake */
@@ -611,7 +602,7 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, is_memory, NULL);
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		return ret;
 
-- 
2.35.1

