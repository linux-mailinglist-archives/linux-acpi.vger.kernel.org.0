Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01287355E62
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbhDFWFV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239613AbhDFWFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:18 -0400
IronPort-SDR: 8dhPRsW59PArNPsEf3VWF3qeqbz6v35Co9ovWn6F3g+emDqi8P6R26E57YQkk1ABCrAJmyrn2Y
 go/DiQ6/VTNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640456"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640456"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: 7YSICPLuq0q+zCZ9VUFPZ3XgWZLzCDmWbP43tlQnBl5ptSFgCRIgK2Haxs1yKCLT+qUWDXaB+9
 RkxmFwAf/0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581720"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 04/22] ACPICA: ACPI 6.4: add CXL ACPI device ID and _CBR object
Date:   Tue,  6 Apr 2021 14:30:10 -0700
Message-Id: <20210406213028.718796-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 7f634ac53fe1e480c01ceff7532cd8dc6430f1b9

The ACPI device ID represents the CXL host bridge. _CBR objects gets
the memory location of CXL Host Bridge Registers.

Link: https://github.com/acpica/acpica/commit/7f634ac5
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 32af9c9d0b38..5951b433c304 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -358,6 +358,10 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_CBA", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See PCI firmware spec 3.0 */
 
+	{{"_CBR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (3 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0, 0, 0),
+
 	{{"_CCA", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 5.1 */
 
-- 
2.29.2

