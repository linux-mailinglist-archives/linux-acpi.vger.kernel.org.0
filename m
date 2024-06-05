Return-Path: <linux-acpi+bounces-6194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929838FCB9A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 14:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C85B1C20D5A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106C1A2FBA;
	Wed,  5 Jun 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgz/BxL3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3061A2FB3;
	Wed,  5 Jun 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588318; cv=none; b=ePNCxOQtwn4mbRerobLDC+a6RMBh9d6ehbRg58E+D9Sqc0/h19NdFPEdM97ce7aj0sAn3PRovGf1MfWTDSQ94o6IQlj3r2g1OvsXNUuzHq+tWfq1smUhq3trtIf6DSdzD8nMBdMnXud8/PD66heX1nbLXNm6dMooEozBl6HXfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588318; c=relaxed/simple;
	bh=ygbrL8SHL8c4+z+jKOhdq7/B1cK4xywxAADGwNROxQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFjBqCvEhuM/gQHYyD/Sxgi/44t1ZeVBdeIiyXHyjKbmtNAAzM6Feh/dVemPWlPf3rj30dpRaMNVTUkMSxptCfuM7DiADVaj6gcaRTgW/TdhwaiiarAQ+8tUvIGi3cboliDuTji7V7uqv5mfFvolBM2CCtSWQR3BRLCWjze5sLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgz/BxL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F266C32786;
	Wed,  5 Jun 2024 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588318;
	bh=ygbrL8SHL8c4+z+jKOhdq7/B1cK4xywxAADGwNROxQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgz/BxL31xJmnR+vghFWZY6dR56JdDomUQat2fvgrhkMT8A12IdwyrMp3UKRM4EBG
	 t/bFGH5+Xtmbf+k3grdS9b1sxPvJVMGLA910+oVTtBoC4OgUF4+kER8CsFbdJLYghF
	 h8RLl5xyNMTqLOk6lmXd0CVc95lJUt1iEobFo46LT9ZfR//h2S0B845yNbK/UvaIPs
	 M6Iy0aeeROC1KjxT8ghr3Tp0qboDVgYpdPFR9kBJ6G5rc4mEG5AQbPCGOYKEi72ySu
	 k1uI1DeNOeY2tqoDIU8HHNPcUBd8ne5+fZ3pa51QzZlst436nqxLr7gbidjMUqKBOH
	 3hOtBmNVYrR0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	webcaptcha <webcapcha@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 22/24] ACPI: EC: Install address space handler at the namespace root
Date: Wed,  5 Jun 2024 07:50:32 -0400
Message-ID: <20240605115101.2962372-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 60fa6ae6e6d09e377fce6f8d9b6f6a4d88769f63 ]

It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
IdeaPad Pro 5 due to a missing address space handler for the EC address
space:

 ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)

This happens because if there is no ECDT, the EC driver only registers
the EC address space handler for operation regions defined in the EC
device scope of the ACPI namespace while the operation region being
accessed by the _DSM in question is located beyond that scope.

To address this, modify the ACPI EC driver to install the EC address
space handler at the root of the ACPI namespace for the first EC that
can be found regardless of whether or not an ECDT is present.

Note that this change is consistent with some examples in the ACPI
specification in which EC operation regions located outside the EC
device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
so the current behavior of the EC driver is arguably questionable.

Reported-by: webcaptcha <webcapcha@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218789
Link: https://uefi.org/specs/ACPI/6.5/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#example-asl-code
Link: https://lore.kernel.org/linux-acpi/Zi+0whTvDbAdveHq@kuha.fi.intel.com
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c       | 25 ++++++++++++++++---------
 drivers/acpi/internal.h |  1 -
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 02255795b800d..e7793ee9e6498 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1482,13 +1482,14 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
 static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 			       bool call_reg)
 {
+	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
 	acpi_status status;
 
 	acpi_ec_start(ec, false);
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		acpi_ec_enter_noirq(ec);
-		status = acpi_install_address_space_handler_no_reg(ec->handle,
+		status = acpi_install_address_space_handler_no_reg(scope_handle,
 								   ACPI_ADR_SPACE_EC,
 								   &acpi_ec_space_handler,
 								   NULL, ec);
@@ -1497,11 +1498,10 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
-		ec->address_space_handler_holder = ec->handle;
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
@@ -1553,10 +1553,13 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
+
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_address_space_handler(
-					ec->address_space_handler_holder,
-					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
+						scope_handle,
+						ACPI_ADR_SPACE_EC,
+						&acpi_ec_space_handler)))
 			pr_err("failed to remove space handler\n");
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
@@ -1595,14 +1598,18 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
 {
 	int ret;
 
-	ret = ec_install_handlers(ec, device, call_reg);
-	if (ret)
-		return ret;
-
 	/* First EC capable of handling transactions */
 	if (!first_ec)
 		first_ec = ec;
 
+	ret = ec_install_handlers(ec, device, call_reg);
+	if (ret) {
+		if (ec == first_ec)
+			first_ec = NULL;
+
+		return ret;
+	}
+
 	pr_info("EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n", ec->command_addr,
 		ec->data_addr);
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6588525c45efa..5749fbee96d92 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -184,7 +184,6 @@ enum acpi_ec_event_state {
 
 struct acpi_ec {
 	acpi_handle handle;
-	acpi_handle address_space_handler_holder;
 	int gpe;
 	int irq;
 	unsigned long command_addr;
-- 
2.43.0


