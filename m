Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5063D354851
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbhDEVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:26877 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241688AbhDEVuI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:08 -0400
IronPort-SDR: e8LB7UoIuoi4sK+MQj/15YEDzFUrcc4xKmDVR6aIz39D+NdnF+rYSIJ+OirMn+Pmvry2GekTpL
 oDOY2rmIj//A==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278754"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:58 -0700
IronPort-SDR: bIxkh3ffuvQwdwFt8QIesxjz+CkFOvODgtUq6R+zsV1HDZQAv0mj6/OZH/hh5cEw4n3OCZ3XUQ
 WGQQEDbnhhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673585"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/22] ACPICA: ACPI 6.4: add CXL ACPI device ID and _CBR object
Date:   Mon,  5 Apr 2021 14:14:52 -0700
Message-Id: <20210405211510.484603-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

