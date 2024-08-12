Return-Path: <linux-acpi+bounces-7534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35A94EDDF
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 15:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CC61C219A1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD117C22A;
	Mon, 12 Aug 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="F7hi7hoe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345F179972;
	Mon, 12 Aug 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468612; cv=none; b=NcNxn6ppsVd5FdFhcIz1d4mhHtsRuXapZfa5MTkyNrI312DaLpJ9Zn/C466ZgKaxasMkST3451S/7aheZxs99/ND8ZGxexU5+s0SnnwO6rYl/lDr9cC/1q/BwVClBa1BJmbciI8lF39WTe9BOmJLZyrKXvh9tBaS5DjTyqw+YCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468612; c=relaxed/simple;
	bh=/qip14bgK8KxNn7UTj4sJvT4qOP3S+7SWb5webjkb2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9qQ9oXy99MbpWoZJEyIzJN98FztP6uJ5oUyrYwWe1FjV6Nch11iVWBvbFPdSYOIf9lEbQArBjojyBkqsq4A4zkro2cnuc2WiBu2ay8RvVRp6+EG6II0oWDu75iPR48qJlLNEKbpX0Q3onPTcd5vS5jDnUmU/AEU9X5sy8DMf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=F7hi7hoe reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b22c503f53192646; Mon, 12 Aug 2024 15:16:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8B86F6F0D95;
	Mon, 12 Aug 2024 15:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723468608;
	bh=/qip14bgK8KxNn7UTj4sJvT4qOP3S+7SWb5webjkb2I=;
	h=From:Subject:Date;
	b=F7hi7hoedMK39vYpQGEs0TSVc4fIOC1NaQgifPZzHcKCF1RWZM32mXiBgTpa/lJrs
	 QdVDlbV7OLORHAUFz5OwYK0EJ74i4/mOwqTvTV9TjD9y4v8SYm1zDbAFdc5TrSYLjI
	 gm826uRIVsO1v/q65q83Zbr2NShJKojTn0yGLbI7gTRSOi0NcoIHS/ELRfKEPw/vuK
	 6rPcGxM/s6YD9yXRg+t47RGquOP4A9iw8S/DGFAeu+CKQowugzgQA5pjJ80MdMdlLX
	 pAjlDW16Zz1KLAO9bUpaY/jY/bvQ80TVDEGXoHeaUOh9b7bOIkSbg7BSUL70semYER
	 7bbn2IvGN7/8A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 1/3] Revert "ACPI: EC: Evaluate orphan _REG under EC device"
Date: Mon, 12 Aug 2024 15:08:04 +0200
Message-ID: <3236716.5fSG56mABF@rjwysocki.net>
In-Reply-To: <22385894.EfDdHjke4D@rjwysocki.net>
References: <22385894.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifpggrrhhmihhnsehg
 mhigrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This reverts commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
_REG under EC device") because the problem addressed by it will be
addressed differenctly in what follows.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/acevents.h |  4 ---
 drivers/acpi/acpica/evregion.c |  6 +++-
 drivers/acpi/acpica/evxfregn.c | 54 ----------------------------------
 drivers/acpi/ec.c              |  3 --
 include/acpi/acpixf.h          |  4 ---
 5 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 2133085deda7..ddd072cbc738 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -191,10 +191,6 @@ void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id, u32 function);
 
-void
-acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
-				  acpi_adr_space_type space_id);
-
 acpi_status
 acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index dc6004daf624..18fdf2bc2d49 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -20,6 +20,10 @@ extern u8 acpi_gbl_default_address_spaces[];
 
 /* Local prototypes */
 
+static void
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
+				  acpi_adr_space_type space_id);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -814,7 +818,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
 				  acpi_adr_space_type space_id)
 {
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 624361a5f34d..3197e6303c5b 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -306,57 +306,3 @@ acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_execute_orphan_reg_method
- *
- * PARAMETERS:  device          - Handle for the device
- *              space_id        - The address space ID
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
- *              device. This is a _REG method that has no corresponding region
- *              within the device's scope.
- *
- ******************************************************************************/
-acpi_status
-acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
-{
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
-
-	/* Parameter validation */
-
-	if (!device) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Convert and validate the device handle */
-
-	node = acpi_ns_validate_handle(device);
-	if (node) {
-
-		/*
-		 * If an "orphan" _REG method is present in the device's scope
-		 * for the given address space ID, run it.
-		 */
-
-		acpi_ev_execute_orphan_reg_method(node, space_id);
-	} else {
-		status = AE_BAD_PARAMETER;
-	}
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-	return_ACPI_STATUS(status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a7b59a19f8d9..77db94ab5abe 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1550,9 +1550,6 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
 		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
-		if (scope_handle != ec->handle)
-			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
-
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 80dc36f9d527..94d0fc3bd412 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -662,10 +662,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_execute_reg_methods(acpi_handle device,
 						     acpi_adr_space_type
 						     space_id))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_execute_orphan_reg_method(acpi_handle device,
-							   acpi_adr_space_type
-							   space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_remove_address_space_handler(acpi_handle
 							      device,
-- 
2.43.0





