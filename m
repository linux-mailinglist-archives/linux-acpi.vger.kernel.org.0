Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6A691ACC
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjBJJHX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJJGe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0091C2313F;
        Fri, 10 Feb 2023 01:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019974; x=1707555974;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+JhIpX+g9sjvv5ZiADOIwQseU67ppQ0dtunIobOaPU=;
  b=FoSVZzCpEuK93BjViEPsgOsWDT/V0KFsVcwyCVR6CBKAMDaTxb+C/h7a
   gZ0S78N3FUi59hasDyfFVACMrsfnkwDsh73jTTmKZRgmD9Dkjx4OHExop
   gSR57dlpmyHSy2BOcUz/NGxK7emo4RrAKaUNttBkIv+XJ2dxs78lWMmHG
   f05pycl7xkdf4l5ldFoxBq9TKIy5NZVffpioCmLywXS2U7C4J66+OCVUD
   7eW0paqHmG2DX76EckYUVhfICaB8+wDNcAY/Ac8AKmx5ND3U8MOxB10BS
   8v40f6XJ2NiL5f3PkuHxIkVHO6k521ZY4OG/GNbouBHuxWUVbhAnp4AIp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416600040"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416600040"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669930234"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669930234"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:04 -0800
Subject: [PATCH v2 07/20] cxl/region: Refactor attach_target() for
 autodiscovery
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:04 -0800
Message-ID: <167601996393.1924368.2202255054618600069.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Region autodiscovery is the process of kernel creating 'struct
cxl_region' object to represent active CXL memory ranges it finds
already active in hardware when the driver loads. Typically this happens
when platform firmware establishes CXL memory regions and then publishes
them in the memory map. However, this can also happen in the case of
kexec-reboot after the kernel has created regions.

In the autodiscovery case the region creation process starts with a
known endpoint decoder. Refactor attach_target() into a helper that is
suitable to be called from either sysfs, for runtime region creation, or
from cxl_port_probe() after it has enumerated all endpoint decoders.

The cxl_port_probe() context is an async device-core probing context, so
it is not appropriate to allow SIGTERM to interrupt the assembly
process. Refactor attach_target() to take @cxled and @state as arguments
where @state indicates whether waiting from the region rwsem is
interruptible or not.

No behavior change is intended.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e440db8611a4..040bbd39c81d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1422,31 +1422,25 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_region_rwsem);
 }
 
-static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
+static int attach_target(struct cxl_region *cxlr,
+			 struct cxl_endpoint_decoder *cxled, int pos,
+			 unsigned int state)
 {
-	struct device *dev;
-	int rc;
-
-	dev = bus_find_device_by_name(&cxl_bus_type, NULL, decoder);
-	if (!dev)
-		return -ENODEV;
-
-	if (!is_endpoint_decoder(dev)) {
-		put_device(dev);
-		return -EINVAL;
-	}
+	int rc = 0;
 
-	rc = down_write_killable(&cxl_region_rwsem);
+	if (state == TASK_INTERRUPTIBLE)
+		rc = down_write_killable(&cxl_region_rwsem);
+	else
+		down_write(&cxl_region_rwsem);
 	if (rc)
-		goto out;
+		return rc;
+
 	down_read(&cxl_dpa_rwsem);
-	rc = cxl_region_attach(cxlr, to_cxl_endpoint_decoder(dev), pos);
+	rc = cxl_region_attach(cxlr, cxled, pos);
 	if (rc == 0)
 		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
-out:
-	put_device(dev);
 	return rc;
 }
 
@@ -1484,8 +1478,23 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 
 	if (sysfs_streq(buf, "\n"))
 		rc = detach_target(cxlr, pos);
-	else
-		rc = attach_target(cxlr, buf, pos);
+	else {
+		struct device *dev;
+
+		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
+		if (!dev)
+			return -ENODEV;
+
+		if (!is_endpoint_decoder(dev)) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
+				   TASK_INTERRUPTIBLE);
+out:
+		put_device(dev);
+	}
 
 	if (rc < 0)
 		return rc;

