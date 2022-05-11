Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41CC523B74
	for <lists+linux-acpi@lfdr.de>; Wed, 11 May 2022 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiEKRYm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 May 2022 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbiEKRYl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2022 13:24:41 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 10:24:38 PDT
Received: from smtp1.emailarray.com (smtp1.emailarray.com [65.39.216.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA722B3A4
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:24:38 -0700 (PDT)
Received: (qmail 67552 invoked by uid 89); 11 May 2022 17:17:56 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuNQ==) (POLARISLOCAL)  
  by smtp1.emailarray.com with SMTP; 11 May 2022 17:17:56 -0000
Date:   Wed, 11 May 2022 10:17:54 -0700
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        linux-acpi@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH]: Revert "ACPI: Remove side effect of partly creating a node
 in acpi_get_node()"
Message-ID: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.

The change calls pxm_to_node(), which ends up returning -1
(NUMA_NO_NODE) on some systems for the pci bus, as opposed 
to the prior call to acpi_map_pxm_to_node(), which returns 0.

The default numa node is then inherited by all pci devices, and is
visible in /sys/bus/pci/devices/*/numa_node

The prior behavior shows:
 # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
     122 0

While the new behavior has:
 # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
       1 0
     121 -1

While arguably NUMA_NO_NODE is correct on single-socket systems which
have only one numa domain, this breaks scripts that attempt to read the
NIC numa_node and pass that to numactl in order to pin memory allocation
when running applications (like iperf).  E.g.:

  # numactl -p -1 iperf3
  libnuma: Warning: node argument -1 is out of range
  <-1> is invalid

Reverting this change restores the prior behavior.

Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 3b818ab186be..f150c5c1d0a8 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -564,6 +564,6 @@ int acpi_get_node(acpi_handle handle)
 
 	pxm = acpi_get_pxm(handle);
 
-	return pxm_to_node(pxm);
+	return acpi_map_pxm_to_node(pxm);
 }
 EXPORT_SYMBOL(acpi_get_node);
-- 
2.30.2

