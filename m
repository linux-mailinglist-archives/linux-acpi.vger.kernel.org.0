Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39051D85A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiEFNCQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbiEFNCP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57263383
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841912; x=1683377912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoOjvt6ZWy+Epk5pxRi/nkuhj8uwUo7L7f23DdSGlTE=;
  b=bryyFBZ5Kgh6p/HnyHS2KgP9NWmiS88/wBaNSb4o7+ppWjjBgviyJGHJ
   QgrKMvwTxn8+DH5QoIlbQIynDV88Rxa8aany38coqrnLWaQHf9bFbzVLa
   eNGzo4RaPcesQX/LNKmrSrTNB7q8OxhLZFjsXZn7gdRcbsy+b7vImi2VM
   jM9eymIY8m7YOEoHFTnplxlPBHyIx7a+pXRiwSP2aABcEf8I+Zf0DQk0m
   g++nlxOFvNBN7LHeKSGiJ8qt7m0Q+he+EaQX9muhWUH8NiP467U80EGbC
   YbszlRv502mEbl0ttuZgfjAbWG08lhz6DnsVWHY5XaL1WOYwjnggdyi3o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="329004152"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="329004152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709452094"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:30 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id BABF320D40;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480X-Bn; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 04/11] ACPI: property: Use acpi_object_type consistently in property ref parsing
Date:   Fri,  6 May 2022 16:00:18 +0300
Message-Id: <20220506130025.984026-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

