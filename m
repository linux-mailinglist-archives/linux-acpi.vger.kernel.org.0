Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0178F73ABB7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFVVkB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFVVkB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:40:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D01FF2;
        Thu, 22 Jun 2023 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687470000; x=1719006000;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sHZ5t/CJlDxQ/VhbS29ah3TXA7eqcxmJ8g8pBXfnY08=;
  b=bTEeWgG2nHofz0QuHQZdM1hB0WuDnE8BOeT6K9DXOqPaxqAzXysNeVK7
   qmqfQTgAqF2I5DcfHepTDS92FwjO0EPx8KigQC/QHXIOKxM1wRQzMrj2+
   DyIujsYGIGQAl2bi7UGOlwwlExdKAdezkFmNxHakfDwEu+2OZa5+EeXU6
   lA/lDxJwP7hN5a9bFfARU9OLg/Is4z8+HpqlOxKjYB53g6bBv+3aQzzXo
   itSpT2Uvuqy30xLMvHh+iU1jN2MBCVgttAROqLNT9OeNfqFwFgVHTlhUy
   op3ef8XT2q2Y1ss+caNtGgQoG3zAEkPxVPBhYI2G1HZO6XxVjGdziyq6S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350383075"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350383075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="785080668"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="785080668"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:58 -0700
Subject: [PATCH v4 5/6] acpi: numa: Add setting of generic port system
 locality attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:39:58 -0700
Message-ID: <168746999799.4115467.1487303283396718524.stgit@djiang5-mobl3>
In-Reply-To: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
References: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It only
provides the system locality attributes from initator to the generic port
targets and is missing the rest of the data to the actual memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Update device_handle to gen_port_device_handle. (Jonathan)
- Reorder setting of access. (Jonathan)
v3:
- Drop continue after setting gen target access data. (Jonathan)
v2:
- Fix commit log runon sentence. (Jonathan)
- Add a check for memory type for skipping other access levels. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
---
 drivers/acpi/numa/hmat.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 957a38137c7e..aabd89c79e26 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -336,6 +337,10 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 		if (node_state(pxm_to_node(init_pxm), N_CPU))
 			hmat_update_target_access(target, type, value,
 						  NODE_ACCESS_CLASS_1);
+		/* Update access from generic port target */
+		if (*target->gen_port_device_handle)
+			hmat_update_target_access(target, type, value,
+						  NODE_ACCESS_CLASS_GENPORT_SINK);
 	}
 }
 


