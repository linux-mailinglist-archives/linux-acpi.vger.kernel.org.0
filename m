Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D139BD42
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFDQgQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:36:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:34980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:36:16 -0400
IronPort-SDR: q0xh436Dm9/WvCRyRho+/cNQfA/z+32953fUI+/P6/tGQ+b3hah/JOvjMJhRk0eDgfZIuZQ+K5
 ZSPed+tEGhaw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="204137265"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="204137265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:34:21 -0700
IronPort-SDR: Q5/SpKk3xY3A5tq/DArA1BOZKEJJvawdKMrqzzHj/eQp0/VIrlDeqA5PzKpZjcGzCEesRGPqRS
 KGtAk3EofKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="439240957"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Jun 2021 09:34:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8EC451C8; Fri,  4 Jun 2021 19:34:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] ACPI: bus: Constify stubs for CONFIG_ACPI=n case
Date:   Fri,  4 Jun 2021 19:34:32 +0300
Message-Id: <20210604163433.12707-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is a few stubs that left untouched during constification of
the fwnode related APIs. Constify three more stubs here.

Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new fix
 include/linux/acpi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..40657f220f8b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -765,7 +765,7 @@ static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
+static inline struct acpi_device *to_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
@@ -775,12 +775,12 @@ static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
+static inline struct acpi_data_node *to_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
 
-static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 					const char *name)
 {
 	return false;
-- 
2.30.2

