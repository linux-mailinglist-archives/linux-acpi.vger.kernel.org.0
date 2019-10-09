Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13022D0F8C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2019 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfJINEk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Oct 2019 09:04:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:5507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfJINEk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Oct 2019 09:04:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 06:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="223580511"
Received: from skassina-mobl.ccr.corp.intel.com (HELO caravaggio.ger.corp.intel.com) ([10.251.93.62])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 06:04:37 -0700
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 1/2] acpi: Fail GED probe when not on hardware-reduced
Date:   Wed,  9 Oct 2019 15:04:32 +0200
Message-Id: <20191009130433.29134-2-sameo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009130433.29134-1-sameo@linux.intel.com>
References: <20191009130433.29134-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Generic Event Device (GED) is a hardware-reduced platform device.
Probing this driver on fixed platforms should fail.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/acpi/evged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index aba0d0027586..55de4b2d2fee 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -127,6 +127,9 @@ static int ged_probe(struct platform_device *pdev)
 	struct acpi_ged_device *geddev;
 	acpi_status acpi_ret;
 
+	if (!acpi_gbl_reduced_hardware)
+		return -ENODEV;
+
 	geddev = devm_kzalloc(&pdev->dev, sizeof(*geddev), GFP_KERNEL);
 	if (!geddev)
 		return -ENOMEM;
-- 
2.21.0

