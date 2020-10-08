Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4581286D22
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgJHDWE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:29865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgJHDWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:03 -0400
IronPort-SDR: RgCSVfm1zGoqk2FP+pukSdkNoshZvKLEHXyWu1fsiZ8goMmclvFQ9OzcsGXa4bttJNi06AHNkf
 McgMaQkve2Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613658"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:03 -0700
IronPort-SDR: gCWvr/hj31D1E5nIS2fME8dnUJb6Fvj2m8OhI/rXBF/myY1X2HRGDODMYKVm2qnGJJ25EMaWMC
 qi/YNNRCi/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229355"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:03 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 8/9] ACPICA: Remove unnecessary semicolon
Date:   Wed,  7 Oct 2020 19:54:02 -0700
Message-Id: <20201008025403.2401736-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 02ffcba2af123a891eefbaed4d37780ba1e36ccc

Reported by: Zou Wei.

Link: https://github.com/acpica/acpica/commit/02ffcba2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/nsalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index fe9b3639a87d..83d26abcf448 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -294,7 +294,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 		node_to_delete = next_node;
 		next_node = next_node->peer;
 		acpi_ns_delete_node(node_to_delete);
-	};
+	}
 
 	/* Clear the parent's child pointer */
 
-- 
2.25.1

