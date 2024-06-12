Return-Path: <linux-acpi+bounces-6332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8B9054DB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D0B1F21D35
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1617BB27;
	Wed, 12 Jun 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vLGjfrze"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84889537F8;
	Wed, 12 Jun 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201761; cv=none; b=cIcgiK4wms7t0Oti9R1hBIEzzr4fV4bgvaygfinbKmBh13Sks8dvisWtT1c2Y1RyMrhlianDe9P+qwQ8Z7Cs/nU7UYx8fkDAcfhbv++cw8NfFva2yalhsHFGy1Bz3ikzs8gGTiPtOUUHTZFFCMJl/KYuwYB6I/S0FMhW+fzcbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201761; c=relaxed/simple;
	bh=a7tUhYjiqLZU8zUWY/eYD/rqkbmZxRpeJhLUl3rEhpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkDxl3DTPi0yXFjBy6mWbKV1azepvq95PIY6jDtbamPWBRyJ6RT2yoNxZme9tlHrDPdkV2XdGtndV2b/akhvg+snXfbhHh/GTx7trZKuC4pxCFDu1JHglKGW8etBXRwBE8JabaCDMUnRaA24GFunoc+HMKadUFNCShQD/VKFrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vLGjfrze; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id acc0cc71f5bd0f36; Wed, 12 Jun 2024 16:15:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7614617B72DA;
	Wed, 12 Jun 2024 16:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718201756;
	bh=a7tUhYjiqLZU8zUWY/eYD/rqkbmZxRpeJhLUl3rEhpc=;
	h=From:To:Cc:Subject:Date;
	b=vLGjfrzeyuLfhlrGPFqxu1ZypOV6O1GMUiXfAiz944xlkIUkOUoKVlrxVlcaZvbGb
	 oov+KKFTwMwIyVWoL6K9WTqCqKv/YvlV7EDhq1DpCGXQl5D6E2Tsw9Xyb9PAMyObaq
	 m6U6021xoFYiGTLAY4pxlrOx1hJRFvZHVCNZprO3+SQrFjWnji6YP1pxN/6TQFdowa
	 nMefWinnGXNSOfXADCc2aZHj7LisRcFW8/ujdh7+WriJh4yHnwoRv8oyTsSUw8YERn
	 C0JTqhWAx+sgTdHGdGRJx6U2mFMJJ4+C/hljtLj6QOZkTZIFq+71lGv06Nuchfq3xb
	 0MOqH3BwKR4DA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, VitaliiT <vitaly.torshyn@gmail.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1] ACPI: EC: Evaluate orphan _REG under EC device
Date: Wed, 12 Jun 2024 16:15:55 +0200
Message-ID: <12466682.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggv
 ghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhithgrlhihrdhtohhrshhhhihnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigprghrmhhinhesghhmgidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After starting to install the EC address space handler at the ACPI
namespace root, if there is an "orphan" _REG method in the EC device's
scope, it will not be evaluated any more.  This breaks EC operation
regions on some systems, like Asus gu605.

To address this, use a wrapper around an existing ACPICA function to
look for an "orphan" _REG method in the EC device scope and evaluate
it if present.

Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218945
Reported-by: VitaliiT <vitaly.torshyn@gmail.com>
Tested-by: VitaliiT <vitaly.torshyn@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Yes, this includes ACPICA changes that are obviously not upstream
and I am going to take care of pusing them to upstream, but for
now there is a regression to fix and it is relatively late in the
cycle.

---
 drivers/acpi/acpica/acevents.h |    4 +++
 drivers/acpi/acpica/evregion.c |    6 ----
 drivers/acpi/acpica/evxfregn.c |   54 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/ec.c              |    3 ++
 include/acpi/acpixf.h          |    4 +++
 5 files changed, 66 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/acpica/evxfregn.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
+++ linux-pm/drivers/acpi/acpica/evxfregn.c
@@ -306,3 +306,57 @@ acpi_execute_reg_methods(acpi_handle dev
 }
 
 ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_execute_orphan_reg_method
+ *
+ * PARAMETERS:  device          - Handle for the device
+ *              space_id        - The address space ID
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
+ *              device. This is a _REG method that has no corresponding region
+ *              within the device's scope.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
+
+	/* Parameter validation */
+
+	if (!device) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Convert and validate the device handle */
+
+	node = acpi_ns_validate_handle(device);
+	if (node) {
+
+		/*
+		 * If an "orphan" _REG method is present in the device's scope
+		 * for the given address space ID, run it.
+		 */
+
+		acpi_ev_execute_orphan_reg_method(node, space_id);
+	} else {
+		status = AE_BAD_PARAMETER;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -663,6 +663,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 						     acpi_adr_space_type
 						     space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_execute_orphan_reg_method(acpi_handle device,
+							   acpi_adr_space_type
+							   space_id))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_remove_address_space_handler(acpi_handle
 							      device,
 							      acpi_adr_space_type
Index: linux-pm/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acevents.h
+++ linux-pm/drivers/acpi/acpica/acevents.h
@@ -191,6 +191,10 @@ void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id, u32 function);
 
+void
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
+				  acpi_adr_space_type space_id);
+
 acpi_status
 acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
 
Index: linux-pm/drivers/acpi/acpica/evregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evregion.c
+++ linux-pm/drivers/acpi/acpica/evregion.c
@@ -20,10 +20,6 @@ extern u8 acpi_gbl_default_address_space
 
 /* Local prototypes */
 
-static void
-acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
-				  acpi_adr_space_type space_id);
-
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -818,7 +814,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-static void
+void
 acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
 				  acpi_adr_space_type space_id)
 {
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1507,6 +1507,9 @@ static int ec_install_handlers(struct ac
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
 		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
+		if (scope_handle != ec->handle)
+			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
+
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 




