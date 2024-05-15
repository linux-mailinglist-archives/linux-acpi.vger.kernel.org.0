Return-Path: <linux-acpi+bounces-5849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11D8C6CF1
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AAD1C20987
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5615B0E4;
	Wed, 15 May 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RNiUM1Oc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858481591FD;
	Wed, 15 May 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802296; cv=none; b=HBoYKoxMxLhuIj3V+ch3L3rA1Cu43PN0SbA4DztS593Lgw3Z5x53B2BpOeAiX0rv73MpmkO6gAal7GyhCSpX7YlAdZzlaxneSOW2fnEbJaJt3/1ljc8FREI583417rj+TEsNHW48Mld454Mbg/xRZQaVnTM7P/prMED3qXwym1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802296; c=relaxed/simple;
	bh=TMK7XYFOwGpI2tibX1qJGKRE8Dz9v/IWK3fkwHN4K8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hu6/s/ASdJi8DCiL5kBVJSXhgCtUtmSKg9yCRjTqYepxnEnbgCyOrPb6OIzrKSaGMrQbGEhtGe4Xp70apxHI+HN+ITSUuAuvP5hS5emr3P7V2QSIXTQx8lhJmJ6FRMy2E/5XV1BfWl/AoI+0hDYBOe4bUn9BiLE9Xkwz7SbcmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RNiUM1Oc reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 4f98022ef8249373; Wed, 15 May 2024 21:44:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A7BAC7F3A73;
	Wed, 15 May 2024 21:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715802285;
	bh=TMK7XYFOwGpI2tibX1qJGKRE8Dz9v/IWK3fkwHN4K8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNiUM1Ocg4+PuvcTUCwIGZXLatrMkdNxS/ZkWMN1aDyh3DTWEhGMHmcTmxrnrvzxg
	 BFKOLDdBhYOUxNfGWC2nmJY27+IO56X1ig7Ulh0Ur+Pg3B7UeE5WAIjiRX8idNTHd7
	 rdeptmrV9SJcIYsoNMRsujx7Gug3p36+3W9mHkwRBHW3RVT1kqaJ3zwRwBqQZbGRHW
	 R85VHNagHp2KCrjieffmsQGc0i/KZrh9wXovVkkgkuMA59IR04YK2L0GCiDrecys1N
	 2b4Qym7xmA6RNameQyAbsa6ZdMrXysFd/7AZ+QlVEM+up0ebg2J7NCl+FBaAuIj2p1
	 Ina7lBIuqoS4A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject:
 [PATCH v2 1/2] ACPI: EC: Install address space handler at the namespace root
Date: Wed, 15 May 2024 21:40:54 +0200
Message-ID: <6046110.lOV4Wx5bFT@kreacher>
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
References: <12437901.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeufeegveeufffgheejheetkeefhfehueffvefgfeehtdegfffhveetffetteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhuvghfihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtgho
 mhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
---

v1 -> v2:
   * Update the changelog to correctly cover the driver behavior
     when ECDT is present
   * Install the address space handler at the namespace root for
     first_ec only
   * Set first_ec before calling ec_install_handlers() in
     acpi_ec_setup() (Hans)

---
 drivers/acpi/ec.c       |   25 ++++++++++++++++---------
 drivers/acpi/internal.h |    1 -
 2 files changed, 16 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1482,13 +1482,14 @@ static bool install_gpio_irq_event_handl
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
@@ -1497,11 +1498,10 @@ static int ec_install_handlers(struct ac
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
 
@@ -1553,10 +1553,13 @@ static int ec_install_handlers(struct ac
 
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
@@ -1595,14 +1598,18 @@ static int acpi_ec_setup(struct acpi_ec
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
 
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -186,7 +186,6 @@ enum acpi_ec_event_state {
 
 struct acpi_ec {
 	acpi_handle handle;
-	acpi_handle address_space_handler_holder;
 	int gpe;
 	int irq;
 	unsigned long command_addr;




