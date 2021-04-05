Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BE35484D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhDEVuJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:26877 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241691AbhDEVuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:06 -0400
IronPort-SDR: CczkhH9e2Ly3r7LNu7elHnnZVkI+/tqVvpi02ec2yWfzbIGm7ybCBvLkbXlI77HindMd+PCGQM
 i4xaBWBlx4WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278751"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278751"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:58 -0700
IronPort-SDR: EpK9cHS2k7EOiYaBh7FJTlok8JdcZUwu/iAXcaJHN7+IqzdseRXup9wW9PnzfrNl90b0Kz+TG+
 Wb5WEMO6/CRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673576"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 02/22] ACPICA: ACPI 6.4: Add new predefined objects _BPC, _BPS, and _BPT
Date:   Mon,  5 Apr 2021 14:14:50 -0700
Message-Id: <20210405211510.484603-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

