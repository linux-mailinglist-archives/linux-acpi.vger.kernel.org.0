Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFB444277
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 14:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhKCNgd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 09:36:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:11312 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhKCNgc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 09:36:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="255121452"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="255121452"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="489565772"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:49 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1D54A2067A;
        Wed,  3 Nov 2021 15:33:45 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1miGP0-002lae-La; Wed, 03 Nov 2021 15:34:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH 1/3] ACPI: Make acpi_fwnode_handle safer
Date:   Wed,  3 Nov 2021 15:34:04 +0200
Message-Id: <20211103133406.659542-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Check that the fwnode argument passed to acpi_fwnode_handle is non-NULL,
and return NULL if it is, otherwise the fwnode. Thus the caller doesn't
have to ensure the argument is a valid non-NULL fwnode.

Cc: stable@vger.kernel.org # v5.15 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 53b6e9f9de7b4..c34d94521d40c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -445,7 +445,7 @@ static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 {
-	return &adev->fwnode;
+	return adev ? &adev->fwnode : NULL;
 }
 
 static inline void *acpi_driver_data(struct acpi_device *d)
-- 
2.30.2

