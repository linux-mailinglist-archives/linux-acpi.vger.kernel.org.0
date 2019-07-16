Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF16A123
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 06:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfGPEEy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 00:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfGPEEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jul 2019 00:04:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013E420693;
        Tue, 16 Jul 2019 04:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563249893;
        bh=++dKw1lhK39CNSlaPfQ8Gyeqk+cayF8swOEw8Z7CrnY=;
        h=From:To:Cc:Subject:Date:From;
        b=t0t5BeCHM4C3Lfmt0dzv+pEsJ5EI11b9O5FBD/eGQ1sA/24H+h3lZnYU8Ob8ELmpw
         mKeg+yNLzvyGiq7K6N+N63kYGFGr/ZQnr1cT5UHtZyDoEczSx07FfNhYFUA6VuKXe1
         n/+999HZed+RZqlwqRzBbfckAirxfkVVc50H+MzY=
From:   Sasha Levin <sashal@kernel.org>
To:     marc.zyngier@arm.com, will.deacon@arm.com, julien.thierry@arm.com,
        catalin.marinas@arm.com
Cc:     okaya@kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: [PATCH] ARM64/irqchip: Make ACPI_IORT depend on PCI again
Date:   Tue, 16 Jul 2019 00:04:41 -0400
Message-Id: <20190716040441.12101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_IORT lost it's explicit dependency on PCI in c6bb8f89fa6df
("ARM64/irqchip: Update ACPI_IORT symbol selection logic") where the
author has relied on the general dependency of ACPI on PCI.

However, that dependency was finally removed in 5d32a66541c4 ("PCI/ACPI:
Allow ACPI to be built without CONFIG_PCI set") and now ACPI_IORT breaks
when we try and build it without PCI support.

This patch brings back the explicit dependency of ACPI_IORT on PCI.

Fixes: 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a36ff61321ce..d6d93027196b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -4,7 +4,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
-	select ACPI_IORT if ACPI
+	select ACPI_IORT if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
-- 
2.20.1

