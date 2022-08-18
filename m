Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D638597E41
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiHRFwA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiHRFwA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 01:52:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4218D3FF
        for <linux-acpi@vger.kernel.org>; Wed, 17 Aug 2022 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660801919; x=1692337919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=asLX2sOvbrl8mZI3P167CjDFKIM3GosI4/UOYSp+kGo=;
  b=BqS24zssT1CCm2TXgiaBo/cp+6HpbIzbNoVRQHSshnsJyi5UZ3Bon5od
   /Y0JaGLRBlIyqCPCBEvwSLN8qSXAvx57n8725PInUki4qolKFpjFa+Yxc
   hM+/1je0euw/rrmC3DLSEaW4a/YcZah7pqlOCMRrD4AAwrhz7sciFmT2Z
   8p/DQWcVMcI2AMTk2r8gRz+/yEctuvrYrJhPE+WOl9s4xpsMd+0TqY0Ro
   7zGizQgpqmh90wbP3zoX2deTCHSk932Nebdmga0wcQZA2zrwQlfGSDh3G
   Yaz5qlsyo+juAIm/PK3UwXvj4BPaVx1ZLB2GJQJZZxqKxpxm1ZVjx447n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="318689854"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="318689854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 22:51:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="733934034"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 22:51:58 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DE6A620212;
        Thu, 18 Aug 2022 08:51:55 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oOYRg-0001x3-Ek; Thu, 18 Aug 2022 08:51:56 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org
Subject: [PATCH 1/1] ACPI: Fix acpi_dev_state_d0() documentation
Date:   Thu, 18 Aug 2022 08:51:56 +0300
Message-Id: <20220818055156.7456-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The documentation for acpi_dev_state_d0() referred to
Documentation/firmware-guide/acpi/low-power-probe.rst that does not exist,
the right file name is Documentation/firmware-guide/acpi/non-d0-probe.rst.
Fix this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 130b5f4a50a3d..fc5ffdb544cae 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1438,7 +1438,7 @@ EXPORT_SYMBOL_GPL(acpi_storage_d3);
  * not valid to ask for the ACPI power state of the device in that time frame.
  *
  * This function is intended to be used in a driver's probe or remove
- * function. See Documentation/firmware-guide/acpi/low-power-probe.rst for
+ * function. See Documentation/firmware-guide/acpi/non-d0-probe.rst for
  * more information.
  */
 bool acpi_dev_state_d0(struct device *dev)
-- 
2.30.2

