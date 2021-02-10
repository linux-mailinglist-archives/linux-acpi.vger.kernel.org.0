Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0D31658D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBJLrt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:47:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:24123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhBJLpl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:41 -0500
IronPort-SDR: EKCXni8O5E4v4lFPfjAvwo8zyr922PfGLUXCGXxWxlGkuav/eFKW1IYvwezpB+xWTfHsvbC8yp
 Keh+ZL2yd/lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="246122912"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246122912"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:34 -0800
IronPort-SDR: Lc9PJZFDPYuC33GHRYjdu45H7Dxod7Lgb3mXlP+SgqcGO69J3AxZjp6z1CeS2tkEUDl8FlzEAV
 IZtFVVD/DOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="399136329"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2021 03:43:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 579CE35A; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] ACPI: property: Satisfy kernel doc validator (part 2)
Date:   Wed, 10 Feb 2021 13:43:17 +0200
Message-Id: <20210210114320.3478-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CHECK   drivers/acpi/property.c
 warning: Function parameter or member '__fwnode' not described in 'acpi_graph_get_remote_endpoint'
 warning: Excess function parameter 'fwnode' description in 'acpi_graph_get_remote_endpoint'
 warning: Excess function parameter 'endpoint' description in 'acpi_graph_get_remote_endpoint'

Fixes: 0ef7478639c5 ("ACPI: property: Make the ACPI graph API private")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a6b096575fc8..167338fe9b04 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1190,8 +1190,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
 
 /**
  * acpi_graph_get_remote_endpoint - Parses and returns remote end of an endpoint
- * @fwnode: Endpoint firmware node pointing to a remote device
- * @endpoint: Firmware node of remote endpoint is filled here if not %NULL
+ * @__fwnode: Endpoint firmware node pointing to a remote device
  *
  * Returns the remote endpoint corresponding to @__fwnode. NULL on error.
  */
-- 
2.30.0

