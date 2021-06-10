Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3D3A2323
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJESh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 00:18:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:23380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhFJESg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 00:18:36 -0400
IronPort-SDR: MKUgkLDieUvqAMb7KreJRtlnubTmDn3TIdKEC/R0AqkQ5grzSQr1gNoFxY8/SFI2lPxQPqnURR
 vfRTrf3KPkPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202196868"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="202196868"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 21:16:41 -0700
IronPort-SDR: MMDSiqNe7S9WMOP56tZ1H72osM6ZCHK96AbXdpis1InvPyrvpYC7UZC/ELVALbUpGIUA4P22CX
 3i/K2QdmdU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="441064177"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2021 21:16:40 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 1/3] ACPICA: Add PRMT module header to facilitate parsing
Date:   Wed,  9 Jun 2021 20:41:51 -0700
Message-Id: <20210610034153.3882311-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210610034153.3882311-1-erik.kaneda@intel.com>
References: <20210610034153.3882311-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit bd46cb07e614fd85ea69e54c1f6f0ae0a5fb20ab

This structure is used in to parse PRMT in other Operating Systems
that relies on using subtable headers in order to parse ACPI tables.
Although the PRMT doesn't have "subtables" it has a list of module
information structures that act as subtables.

Link: https://github.com/acpica/acpica/commit/bd46cb07
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 05b086d4d94a..2069ac38a4e2 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1728,6 +1728,11 @@ struct acpi_table_prmt_header {
 	u32 module_info_count;
 };
 
+struct acpi_prmt_module_header {
+	u16 revision;
+	u16 length;
+};
+
 struct acpi_prmt_module_info {
 	u16 revision;
 	u16 length;
-- 
2.29.2

