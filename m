Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D856752E4CF
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiETGLm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiETGLj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EDE75218
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027098; x=1684563098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoOjvt6ZWy+Epk5pxRi/nkuhj8uwUo7L7f23DdSGlTE=;
  b=dUGr1SF1hS2h+hkRSwXLh6uPPWSAvKFDtmape7OcGWINe5A0KLSgnYC4
   l19qrhRLKchgRO9bwMdoEAguJjk18eppCqAbtJygirOQ1eBmobAtyZf1+
   96q7RD5iy4C6cNe16zB7vycyUHTaA8tQki+mKNVV0I9TLwy61iocyHZr8
   slqWBxObVV8ccNbSHm/YxWi9UhesjhaofbbVxpQDEfJBmBB0Js5w6hgcF
   SkI2KfVQ7hVAoqYW2aUIQudt+8g42PI4Zh4SJXt5Z7sUFS+ugcPbM3kjt
   1t5qeAnVXj30Zf9dNoPYLy+QvuAbXRxoQVrd1xqEhkNb1gPk+gmNl2kn4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="260084995"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="260084995"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="606876155"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:37 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 0C3C220BAD;
        Fri, 20 May 2022 09:11:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005Zf-6q; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 3/8] ACPI: property: Use acpi_object_type consistently in property ref parsing
Date:   Fri, 20 May 2022 09:11:43 +0300
Message-Id: <20220520061148.21366-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

