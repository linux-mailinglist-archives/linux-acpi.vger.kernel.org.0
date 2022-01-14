Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB28748E936
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jan 2022 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiANLeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jan 2022 06:34:24 -0500
Received: from retiisi.eu ([95.216.213.190]:57592 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbiANLeX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jan 2022 06:34:23 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jan 2022 06:34:22 EST
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 8DCFB634C90;
        Fri, 14 Jan 2022 13:26:09 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org
Subject: [PATCH 1/1] ACPI: Consistently return -ENOENT if there are no more references
Date:   Fri, 14 Jan 2022 13:24:49 +0200
Message-Id: <20220114112449.322048-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

__acpi_node_get_property_reference() is documented to return -ENOENT if
the caller requests a property reference at an index that does not exist,
not -EINVAL which it actually does.

Fix this by returning -ENOENT consistenly, independently of whether the
property value is a plain reference or a package.

Fixes: c343bc2ce2c6 ("ACPI: properties: Align return codes of __acpi_node_get_property_reference()")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2366f54d8e9c..e8f56448ca01 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -685,7 +685,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	 */
 	if (obj->type == ACPI_TYPE_LOCAL_REFERENCE) {
 		if (index)
-			return -EINVAL;
+			return -ENOENT;
 
 		ret = acpi_bus_get_device(obj->reference.handle, &device);
 		if (ret)
-- 
2.30.2

