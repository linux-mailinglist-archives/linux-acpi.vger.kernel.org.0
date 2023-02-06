Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2F68B385
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBFBDG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFBDE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF7144B4;
        Sun,  5 Feb 2023 17:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645383; x=1707181383;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxV5boq5z7i+vQyYxApsVbkxX+I+JHzPNbJoiDtgews=;
  b=XNfxh7Guj5o3I0pbrQJOsQxMwAt3pCT5WR46zYQtPuCaoX/yVq6Y6SlZ
   H6CT1JC/gqRaXGS2ue+gybJReMgZLe/KDnbR3rICH/CNE5s7J3a5TD15/
   9tri7gck7nODENbdi7l5O1Y8VHjsCPcQP8SOVB95IRTL1w/zhzjz/6Sh9
   it/UhQt05OXiih7Nvr5TUf+QNxfAl+i5pCiFnnymFSncQROqjkMLtdiDM
   /I5YB6ogI+6tp8Is5moLM4h8gYn88XRdNulRgduUiu1XvtJIaEcdmgp8I
   Q1Yl9ORP8KCfl9DYCYR0YX1mBNynCRlVCez4DJAAuLY0VI23JtiV9yXDo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312763180"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312763180"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="616291294"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616291294"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:02 -0800
Subject: [PATCH 06/18] cxl/region: Refactor attach_target() for autodiscovery
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:02 -0800
Message-ID: <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8dea49c021b8..97eafdd75675 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1418,31 +1418,25 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
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
 
@@ -1480,8 +1474,23 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 
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

