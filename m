Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9268B382
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFBCs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBFBCr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:02:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7C2738;
        Sun,  5 Feb 2023 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645366; x=1707181366;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yb8ZrYfywa+KhatYaUiHluR1JdOlK0Jjr6L/f1PwJLc=;
  b=e7t2nDwoNb+uIEsh993w0izEa8mmYBvCqYCqwTBSq4PDXkOy/vxOB6oU
   wpd21Z4fF/iH0hBdxWocp3LViKoQDIMX3lXnJpj6gZHRjHB2ubl8TVBvt
   XOFMcPKyyp/DKBzzlyosbg4HVpjX5vTvG8J2AQ/rwbV6SD9NGB/gGYd3B
   jhrca1sILgvOUYmSpDrd8X0UREgYGTEQW31ik5RgQ6vlTqETADsRN2UJb
   wukBZvCO+XMkiZBJUYGJP6yelijxsi6DtaUixEbC8US5XT7NxlxKtr7me
   Cr2EKOXvWCKh2m9Y+xAZxE8M9+w/hjY41ON/80xpfzZveEE8EacckMD1V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="331243790"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331243790"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:02:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="643855738"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="643855738"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:02:46 -0800
Subject: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:02:45 -0800
Message-ID: <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
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

Shipping versions of the cxl-cli utility expect all regions to have a
'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
attribute to return an empty string which satisfies the current
expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
presence of regions with the 'uuid' attribute missing. Force the
attribute to be read-only as there is no facility or expectation for a
'ram' region to recall its uuid from one boot to the next.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
 drivers/cxl/core/region.c               |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index 17d2d0c12725..c9e7f05caa0f 100644
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
@@ -301,7 +304,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 
 	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
-		return 0;
+		return 0444;
 	return a->mode;
 }
 

