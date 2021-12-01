Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6D464E4F
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbhLANCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:14072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349435AbhLANCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:02:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236395262"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236395262"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="512008569"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 62A1E2036B;
        Wed,  1 Dec 2021 14:58:34 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCw-003vl7-Rl; Wed, 01 Dec 2021 14:59:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 2/7] device property: Fix documentation for FWNODE_GRAPH_DEVICE_DISABLED
Date:   Wed,  1 Dec 2021 14:59:30 +0200
Message-Id: <20211201125934.936953-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

FWNODE_GRAPH_DEVICE_DISABLED flag was meant for also returning endpoints
connected to disabled devices, but it also may return endpoints that are
not connected. Fix this in documentation. Also
fwnode_graph_get_endpoint_by_id() was affeced by this.

Also improve the language a little bit.

Fixes: 0fcc2bdc8aff ("device property: Add fwnode_graph_get_endpoint_by_id()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 4 ++--
 include/linux/property.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6df99e526ab0f..ecc4e2eb10678 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1111,8 +1111,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
  * has not been found, look for the closest endpoint ID greater than the
  * specified one and return the endpoint that corresponds to it, if present.
  *
- * Do not return endpoints that belong to disabled devices, unless
- * FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
+ * Does not return endpoints that belong to disabled devices or endpoints that
+ * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
  *
  * The returned endpoint needs to be released by calling fwnode_handle_put() on
  * it when it is not needed any more.
diff --git a/include/linux/property.h b/include/linux/property.h
index 88fa726a76df7..af5a7e512c86f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,7 +418,8 @@ static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
  *				one.
  * @FWNODE_GRAPH_DEVICE_DISABLED: That the device to which the remote
  *				  endpoint of the given endpoint belongs to,
- *				  may be disabled.
+ *				  may be disabled, or that the endpoint is not
+ *				  connected.
  */
 #define FWNODE_GRAPH_ENDPOINT_NEXT	BIT(0)
 #define FWNODE_GRAPH_DEVICE_DISABLED	BIT(1)
-- 
2.30.2

