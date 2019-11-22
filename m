Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8710648E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 07:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfKVGS2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 01:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfKVGNM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8B720707;
        Fri, 22 Nov 2019 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403191;
        bh=gcm9D1eUheQLlw2fc2wABD7hVL2JXYAau9rxESbVgN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=in7WL6mXX4UbhgStcFugnI5hcdkyPeRzabbDbtYg1zryWO8/lv8mE8vYmKHLqHkpl
         VDv/kX6rKMrOeexPeGCI1PkEQ8FnZdz+/aZOJghiYg+0DA8tHrbElbgmXx6WQh8AFD
         Ijd3R4IvSxscYurNq/BUnbEiKhCXNfj+WF3EDq6U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 09/68] ACPI / LPSS: Ignore acpi_device_fix_up_power() return value
Date:   Fri, 22 Nov 2019 01:12:02 -0500
Message-Id: <20191122061301.4947-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1a2fa02f7489dc4d746f2a15fb77b3ce1affade8 ]

Ignore acpi_device_fix_up_power() return value. If we return an error
we end up with acpi_default_enumeration() still creating a platform-
device for the device and we end up with the device still being used
but without the special LPSS related handling which is not useful.

Specicifically ignoring the error fixes the touchscreen no longer
working after a suspend/resume on a Prowise PT301 tablet.

This tablet has a broken _PS0 method on the touchscreen's I2C controller,
causing acpi_device_fix_up_power() to fail, causing fallback to standard
platform-dev handling and specifically causing acpi_lpss_save/restore_ctx
to not run.

The I2C controllers _PS0 method does actually turn on the device, but then
does some more nonsense which fails when run during early boot trying to
use I2C opregion handling on another not-yet registered I2C controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_lpss.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 572755e557d6a..e54e6170981b4 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -405,12 +405,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	 * have _PS0 and _PS3 without _PSC (and no power resources), so
 	 * acpi_bus_init_power() will assume that the BIOS has put them into D0.
 	 */
-	ret = acpi_device_fix_up_power(adev);
-	if (ret) {
-		/* Skip the device, but continue the namespace scan. */
-		ret = 0;
-		goto err_out;
-	}
+	acpi_device_fix_up_power(adev);
 
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
-- 
2.20.1

