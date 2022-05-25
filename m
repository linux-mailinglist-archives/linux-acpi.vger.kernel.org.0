Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8E533D1E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiEYNBC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiEYNBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A218A5AB4
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483661; x=1685019661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoOjvt6ZWy+Epk5pxRi/nkuhj8uwUo7L7f23DdSGlTE=;
  b=bZAy3VArBEmntzCIoNZBqXeMuN2XXDo9SSJFrmTbfgh/edQQoK6xi2fM
   pwQCxqwQ6czoxGHyPSmnC3SEL2hRA45XFdhbDy6uplF+J9kIr2XQFQicP
   gE111iVIGYWWrHxX82+fQ5D34ezTwCsJDF5nVc6zfSc5v+ZdirJFlHKhM
   SbhLWO/SL0G6j9UUvHHTsbvU/SRI0v/v11mVTSZRe2vHeHp3i0XUoDOf2
   X/BPKFm9teLD5OAczdjM7PRJsEAE4f+A6MtNyB43D28Rbr13mxFEaI6Lh
   vcf7b7vTtQakaVRuv39PMbxNA/Bli8QhwZY+6XedCD5ZvKJSJ1mT9Nw23
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273532423"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273532423"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="573225761"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:00:59 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 90CE920772;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003Ded-FD; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 3/8] ACPI: property: Use acpi_object_type consistently in property ref parsing
Date:   Wed, 25 May 2022 16:01:18 +0300
Message-Id: <20220525130123.767410-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The type of union acpi_object field type is acpi_object_type. Use that
instead of int.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f8c83ee6c8d59..b36cb7e36e420 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -793,7 +793,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 			 * nor integer, return an error, we can't parse it.
 			 */
 			for (i = 0; element + i < end && i < num_args; i++) {
-				int type = element[i].type;
+				acpi_object_type type = element[i].type;
 
 				if (type == ACPI_TYPE_LOCAL_REFERENCE)
 					break;
-- 
2.30.2

