Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E739C31F
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhFDWCt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:62958 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhFDWCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:47 -0400
IronPort-SDR: c+ukZEJ6IJqp7TpfpjgDJu0rITXlDFMP6RHiYNS/S8wpIuQYxOKssT+zWxOLk1ZASPjdteqorE
 z/5r5wMU9Ybw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539945"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:55 -0700
IronPort-SDR: qua0nGrHeB9vmcns8iwR3QK42Gij+7gth4BcpA9bI2ES02zMup3wOAehaSqifKUMxRveUOTtBR
 22p30SkyGy/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146710"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 05/14] ACPICA: iASL: Add support for the SVKL table
Date:   Fri,  4 Jun 2021 14:25:59 -0700
Message-Id: <20210604212608.2604267-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Includes the table compiler, the disassembler and the template
generator.

ACPICA commit 27a434379e3ecafea5340c0c384789ea2062c4fb

Link: https://github.com/acpica/acpica/commit/27a43437
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 42c78fecca7c..d042341e8ba9 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1923,6 +1923,8 @@ struct acpi_sdev_pcie_path {
 /*******************************************************************************
  *
  * SVKL - Storage Volume Key Location Table (ACPI 6.4)
+ *        From: "Guest-Host-Communication Interface (GHCI) for Intel
+ *        Trust Domain Extensions (Intel TDX)".
  *        Version 1
  *
  ******************************************************************************/
@@ -1932,7 +1934,7 @@ struct acpi_table_svkl {
 	u32 count;
 };
 
-struct acpi_svkl_header {
+struct acpi_svkl_key {
 	u16 type;
 	u16 format;
 	u32 size;
-- 
2.29.2

