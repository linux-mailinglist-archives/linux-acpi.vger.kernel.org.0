Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68D59F8ED
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiHXMAH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiHXMAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:00:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A435F99
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661342404; x=1692878404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MBP4w9jMSdM+17hreP0BHnGTaQ6EC34BqAkNx8Aobrk=;
  b=PPxHcpcP+8axJikeQOQqxG0RrDUOXoWFLNh7WlJ6H9WJYBan0RNWI7c2
   T5F1m1DCgPcwO7pMs7xxU+4437VPpbfbsESuJBB4z7lIfwnbyw6Ptf0nF
   YkCITiwcnjA4hPlD9FQ0QioI8MefQ/s4GE/QsD7pUVR4GUhbPSK2dYCBs
   Y36sN8akLz0NTOTw8lE5XHZMb0PA/flHkDc5of6pShu78Lx01ImDLl6Ll
   ACQ/Q+erxy4oisWfOa/N7hhxHO2S+aiIlPJ5i/nPd93Hq2JmM7P5FUSol
   c0cbPY3q1N9+bJGlfnswxNe6l/kGi2ovIHM6SdfRsic1KGsyl8a2XzWnw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294729812"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="294729812"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 04:59:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="642831474"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 04:59:47 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 4AF8D202AC;
        Wed, 24 Aug 2022 14:59:45 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oQp36-008Gns-TR; Wed, 24 Aug 2022 14:59:56 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Subject: [PATCH 1/1] ACPI: property: Ignore already existing data node tags
Date:   Wed, 24 Aug 2022 14:59:56 +0300
Message-Id: <20220824115956.1971171-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI node pointers are attached to data node handles, in order to resolve
string references to them. _DSD guide allows the same node to be reached
from multiple parent nodes, leading the node enumeration algorithm to each
such nodes more than once. As attached data already already exists,
attaching data with the same tag will fail. Address this problem by
ignoring nodes that have been already tagged.

Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7b3ad8ed2f4e6..fa97b31214a83 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -370,7 +370,7 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
 		bool ret;
 
 		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
-		if (ACPI_FAILURE(status)) {
+		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			acpi_handle_err(dn->handle, "Can't tag data node\n");
 			return false;
 		}
-- 
2.30.2

