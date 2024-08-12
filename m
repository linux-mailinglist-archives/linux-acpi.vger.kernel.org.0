Return-Path: <linux-acpi+bounces-7533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8494EDDC
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F561C215F0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABC17C20F;
	Mon, 12 Aug 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PFJMvzu8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB526ADD;
	Mon, 12 Aug 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468611; cv=none; b=EmECNPOtOSb+Hj9Im8GLc6wYcgR8JASSsW2dXl9dZlLy5+hdkyhq+AdyIeo8TpuljIi+tGSQsZM0KlJQTsoFoQ/saY3uprXybBTAg4yhq1qAd2Du6iAY0y8+3ULHjWbPr9WrkgouBdb+dtDok0sd1bhC2LQdFlqmmD9QoQ5Kps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468611; c=relaxed/simple;
	bh=bqoLUjuCMk9fxeoBbXgZNEX2LC/x5VVMmJQapGpCxAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kosNaHPeyOisO8LveCapUYq+8DoJ3IK8syVpTjD49bvVYsoZG2o/3nMLLZhtqPHavPFnNfqQOyjcUIvyQaUj6Cov/PHTywRRqQD/TmyQS1tJObR7E9+3NJBGMjqg6uWf34yfs+qRLioNKbhoy2Atxv7Ubmih2LgyI4e3r0LzAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PFJMvzu8 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 36a6f37c0b61aed0; Mon, 12 Aug 2024 15:16:47 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B5F496F0D96;
	Mon, 12 Aug 2024 15:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723468607;
	bh=bqoLUjuCMk9fxeoBbXgZNEX2LC/x5VVMmJQapGpCxAk=;
	h=From:Subject:Date;
	b=PFJMvzu87jAcLtFOwLw/Gj6dyawggyR5/zWuAwBBvLOmHi0wA81G5yUzPPLtvA1eI
	 zKzO0W7+a+0LW4y5rfZkvud1jen8qXwW7a7pJMqDbzjejKXZJCjJ3BhhvaxvUMcCDs
	 LhCxGoRw4Vs/lfJc+Xt4zVI87pRd2ee6y0eQ40BabLddA+gfQ0tqwYk3d1bSCxa09K
	 7vnxOBk+Z1DWo+1Of8W0cxQwXxse1x2CcpvgZXI/k22y/7SOKMq4wP1JLOAJ89XNB1
	 2h2BQjywE/oV0SvJ4D10R1NaABXW0JyfsrpMJC56YkF09UeD/fQHwPWhyMzzyKPueD
	 AJBn/vvKeXZxQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 2/3] ACPICA: Add a depth argument to acpi_execute_reg_methods()
Date: Mon, 12 Aug 2024 15:11:42 +0200
Message-ID: <8451567.NyiUUSuA9g@rjwysocki.net>
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

A subsequent change will need to pass a depth argument to
acpi_execute_reg_methods(), so prepare that function for it.

No intentional functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

This is mostly an ACPICA change, but because it is specifically related
to the EC and it is part of a regression fix, it will be backported to
upstream ACPICA after receiving enough testing coverage in Linux.

---
 drivers/acpi/acpica/acevents.h |    2 +-
 drivers/acpi/acpica/evregion.c |    6 ++++--
 drivers/acpi/acpica/evxfregn.c |   10 +++++++---
 drivers/acpi/ec.c              |    3 ++-
 include/acpi/acpixf.h          |    1 +
 5 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acevents.h
+++ linux-pm/drivers/acpi/acpica/acevents.h
@@ -188,7 +188,7 @@ acpi_ev_detach_region(union acpi_operand
 		      u8 acpi_ns_is_locked);
 
 void
-acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
+acpi_ev_execute_reg_methods(struct acpi_namespace_node *node, u32 max_depth,
 			    acpi_adr_space_type space_id, u32 function);
 
 acpi_status
Index: linux-pm/drivers/acpi/acpica/evregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evregion.c
+++ linux-pm/drivers/acpi/acpica/evregion.c
@@ -65,6 +65,7 @@ acpi_status acpi_ev_initialize_op_region
 						acpi_gbl_default_address_spaces
 						[i])) {
 			acpi_ev_execute_reg_methods(acpi_gbl_root_node,
+						    ACPI_UINT32_MAX,
 						    acpi_gbl_default_address_spaces
 						    [i], ACPI_REG_CONNECT);
 		}
@@ -672,6 +673,7 @@ cleanup1:
  * FUNCTION:    acpi_ev_execute_reg_methods
  *
  * PARAMETERS:  node            - Namespace node for the device
+ *              max_depth       - Depth to which search for _REG
  *              space_id        - The address space ID
  *              function        - Passed to _REG: On (1) or Off (0)
  *
@@ -683,7 +685,7 @@ cleanup1:
  ******************************************************************************/
 
 void
-acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
+acpi_ev_execute_reg_methods(struct acpi_namespace_node *node, u32 max_depth,
 			    acpi_adr_space_type space_id, u32 function)
 {
 	struct acpi_reg_walk_info info;
@@ -717,7 +719,7 @@ acpi_ev_execute_reg_methods(struct acpi_
 	 * regions and _REG methods. (i.e. handlers must be installed for all
 	 * regions of this Space ID before we can run any _REG methods)
 	 */
-	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
+	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, max_depth,
 				     ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run, NULL,
 				     &info, NULL);
 
Index: linux-pm/drivers/acpi/acpica/evxfregn.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
+++ linux-pm/drivers/acpi/acpica/evxfregn.c
@@ -85,7 +85,8 @@ acpi_install_address_space_handler_inter
 	/* Run all _REG methods for this address space */
 
 	if (run_reg) {
-		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+		acpi_ev_execute_reg_methods(node, ACPI_UINT32_MAX, space_id,
+					    ACPI_REG_CONNECT);
 	}
 
 unlock_and_exit:
@@ -263,6 +264,7 @@ ACPI_EXPORT_SYMBOL(acpi_remove_address_s
  * FUNCTION:    acpi_execute_reg_methods
  *
  * PARAMETERS:  device          - Handle for the device
+ *              max_depth       - Depth to which search for _REG
  *              space_id        - The address space ID
  *
  * RETURN:      Status
@@ -271,7 +273,8 @@ ACPI_EXPORT_SYMBOL(acpi_remove_address_s
  *
  ******************************************************************************/
 acpi_status
-acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
+acpi_execute_reg_methods(acpi_handle device, u32 max_depth,
+			 acpi_adr_space_type space_id)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -296,7 +299,8 @@ acpi_execute_reg_methods(acpi_handle dev
 
 		/* Run all _REG methods for this address space */
 
-		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+		acpi_ev_execute_reg_methods(node, max_depth, space_id,
+					    ACPI_REG_CONNECT);
 	} else {
 		status = AE_BAD_PARAMETER;
 	}
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -660,6 +660,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     void *context))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_execute_reg_methods(acpi_handle device,
+						     u32 nax_depth,
 						     acpi_adr_space_type
 						     space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1549,7 +1549,7 @@ static int ec_install_handlers(struct ac
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(scope_handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 




