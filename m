Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788754D3FD7
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 04:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiCJDuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 22:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCJDuX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 22:50:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FFF6D946
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 19:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646884161; x=1678420161;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01uk1STa+uanKsxMHNVT1kNKcSTu9PKVe8HwVPVDqRs=;
  b=nGnNZFG8Mi7theFu20BJ6DoZ+fkscs6hkhwB2VpH1eru2zfDCN4/HMdq
   m5bl6nGtzkJSqm/vBDjl8FajBL5HFZrSNU3NRADjFYVYsFGaV7kLfBTFf
   w4lLfJJAefeGZ5XFAX5OU99O3OQR8RxZJ+lNjAqQHuWqdGgU++CzkSG+b
   3hOU6FglZcPbGEqhaYa2PQsnULKdGifJWxBz4QjH74AIzZpDlDwNS8uxg
   2uZQL5vLWhKs9jlHePUHHvLa46VdNwQ0ZbdcbjtFfwDWwrZhCNAknwPgK
   23IbmMUtyd+44nF9reD6fIsEIuhznrV6RUXHvUYaQsv71v2nZK0UqCKHx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279887037"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="279887037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:21 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="781317744"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:21 -0800
Subject: [PATCH 1/6] nvdimm/region: Fix default alignment for small regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     robert.hu@linux.intel.com, vishal.l.verma@intel.com, hch@lst.de,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 19:49:21 -0800
Message-ID: <164688416128.2879318.17890707310125575258.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for removing BLK aperture support the NVDIMM unit tests
discovered that the default alignment can be set higher than the
capacity of the region. Fall back to PAGE_SIZE in that case.

Given this has not been seen in the wild, elide notifying -stable.

Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region_devs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 9ccf3d608799..70ad891a76ba 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1025,6 +1025,9 @@ static unsigned long default_align(struct nd_region *nd_region)
 		}
 	}
 
+	if (nd_region->ndr_size < MEMREMAP_COMPAT_ALIGN_MAX)
+		align = PAGE_SIZE;
+
 	mappings = max_t(u16, 1, nd_region->ndr_mappings);
 	div_u64_rem(align, mappings, &remainder);
 	if (remainder)

