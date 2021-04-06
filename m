Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F0355E60
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhDFWFT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhDFWFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:18 -0400
IronPort-SDR: 0PAoPbgSbK+WbdEF0v3SaYV1vnkG/HPjNstL5JHeNmlmLRgJQxqQVNqzOhh78DidY1vFGHJqCh
 Gya2xYFXVEJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640454"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640454"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:08 -0700
IronPort-SDR: 4Q+gVgbt+GbLgR2pab10ftWrUYcLciYn/uMfQOa4/q+yVkFOkCX/m72ibi9gzUpaGqUQXuTuWD
 ghmCGzeb4nRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581710"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 02/22] ACPICA: ACPI 6.4: Add new predefined objects _BPC, _BPS, and _BPT
Date:   Tue,  6 Apr 2021 14:30:08 -0700
Message-Id: <20210406213028.718796-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 3cfef24ae2d98babbbfbe4ba612a2f5d9014d3ba

The object definition for these can be found in the ACPI 6.4
specification.

Link: https://github.com/acpica/acpica/commit/3cfef24a
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 15cf904f0751..32af9c9d0b38 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -328,6 +328,17 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_BMS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
+	{{"_BPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
+
+	{{"_BPS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (5 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_BPT", METHOD_1ARGS(ACPI_TYPE_PACKAGE),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
 	{{"_BQC", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
-- 
2.29.2

