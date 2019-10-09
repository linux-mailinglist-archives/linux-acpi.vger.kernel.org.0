Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7ECD0F8F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2019 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfJINEo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Oct 2019 09:04:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:5507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfJINEn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Oct 2019 09:04:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 06:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="223580524"
Received: from skassina-mobl.ccr.corp.intel.com (HELO caravaggio.ger.corp.intel.com) ([10.251.93.62])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 06:04:40 -0700
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 2/2] acpi: Always build evged in
Date:   Wed,  9 Oct 2019 15:04:33 +0200
Message-Id: <20191009130433.29134-3-sameo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009130433.29134-1-sameo@linux.intel.com>
References: <20191009130433.29134-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

Although the Generic Event Device is a Hardware-reduced platfom device,
it should not be restricted to ACPI_REDUCED_HARDWARE_ONLY.
Kernels supporting both fixed and hardware-reduced ACPI platforms should
be able to probe the GED when dynamically detecting that a platform is
hardware-reduced. For that, the driver must be unconditionally built in.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/acpi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..ef1ac4d127da 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -48,7 +48,7 @@ acpi-y				+= acpi_pnp.o
 acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
 acpi-y				+= power.o
 acpi-y				+= event.o
-acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
+acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
-- 
2.21.0

