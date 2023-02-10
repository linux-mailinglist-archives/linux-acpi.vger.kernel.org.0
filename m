Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA2691AC7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBJJGv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjBJJGL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D96635B6;
        Fri, 10 Feb 2023 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019947; x=1707555947;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rEeQZ+8vrd28/mihuN4IYSQYwRcfCWFNTCZHITf2LM=;
  b=i5B0I8eyEIDoGagokInkwn0BdPZtLE36BYpumMl6Kvrr0Cn+KN5I7mhL
   uWHWJriKPE17kWR3v8LdZWjhRVmldpErAlyljvwgraZfqTUMzXWkTz497
   U5ehOXzyrzN9KpGBjqoaxe2t62EcUBVjN0/1Z0HH1uSbN6S8gGxf4GOYK
   fvJ+HZ4Tgibt5pA8Rx3TKa12ukdJDCHybGRTdU6+W2x2fL3me1TOn+7Ug
   Du34dRfmdGTwYzwhkmu4cmy+9I4Qo+573vT5StJWr/YZE09n5c4Se1sfe
   MXormz8SAeyxFCuaYJcb/6/tN96qDQotkDg8lXPO/oDs1FQj4grZjtKQZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331677059"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331677059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="698364566"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="698364566"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:45 -0800
Subject: [PATCH v2 04/20] cxl/region: Support empty uuids for non-pmem
 regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:45 -0800
Message-ID: <167601994558.1924368.12612811533724694444.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Shipping versions of the cxl-cli utility expect all regions to have a
'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
attribute to return an empty string which satisfies the current
expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
presence of regions with the 'uuid' attribute missing. Force the
attribute to be read-only as there is no facility or expectation for a
'ram' region to recall its uuid from one boot to the next.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
 drivers/cxl/core/region.c               |   11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 058b0c45001f..4c4e1cbb1169 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -317,7 +317,8 @@ Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a unique identifier for the region. This field must
 		be set for persistent regions and it must not conflict with the
-		UUID of another region.
+		UUID of another region. For volatile ram regions this
+		attribute is a read-only empty string.
 
 
 What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 17d2d0c12725..0fc80478ff6b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
+	if (cxlr->mode != CXL_DECODER_PMEM)
+		rc = sysfs_emit(buf, "\n");
+	else
+		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
 	up_read(&cxl_region_rwsem);
 
 	return rc;
@@ -300,8 +303,12 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_region *cxlr = to_cxl_region(dev);
 
+	/*
+	 * Support tooling that expects to find a 'uuid' attribute for all
+	 * regions regardless of mode.
+	 */
 	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
-		return 0;
+		return 0444;
 	return a->mode;
 }
 

