Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10732549E7C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jun 2022 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350031AbiFMUHS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jun 2022 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiFMUGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jun 2022 16:06:39 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266885A14D;
        Mon, 13 Jun 2022 11:40:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 6919db4401a1fb40; Mon, 13 Jun 2022 20:40:55 +0200
Received: from kreacher.localnet (unknown [213.134.187.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6A2CF66C81D;
        Mon, 13 Jun 2022 20:40:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 12/16] platform/x86/thinkpad_acpi: Use acpi_dev_for_each_child()
Date:   Mon, 13 Jun 2022 20:30:19 +0200
Message-ID: <2091400.OBFZWjSADL@kreacher>
In-Reply-To: <2653857.mvXUDI8C0e@kreacher>
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.64
X-CLIENT-HOSTNAME: 213.134.187.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekjedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhhmhheshhhmhhdrvghnghdrsghrpdhrtghpthhtohepmhgrrhhkghhrohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgsmhdqrggtphhiqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Eliminate unnecessary branch (Andy).

---
 drivers/platform/x86/thinkpad_acpi.c |   53 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/platform/x86/thinkpad_acpi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/thinkpad_acpi.c
+++ linux-pm/drivers/platform/x86/thinkpad_acpi.c
@@ -6841,6 +6841,31 @@ static const struct backlight_ops ibm_ba
 
 /* --------------------------------------------------------------------- */
 
+static int __init tpacpi_evaluate_bcl(struct acpi_device *adev, void *not_used)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int rc;
+
+	status = acpi_evaluate_object(adev->handle, "_BCL", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
+		acpi_handle_info(adev->handle,
+				 "Unknown _BCL data, please report this to %s\n",
+				 TPACPI_MAIL);
+		rc = 0;
+	} else {
+		rc = obj->package.count;
+	}
+	kfree(obj);
+
+	return rc;
+}
+
 /*
  * Call _BCL method of video device.  On some ThinkPads this will
  * switch the firmware to the ACPI brightness control mode.
@@ -6848,37 +6873,13 @@ static const struct backlight_ops ibm_ba
 
 static int __init tpacpi_query_bcl_levels(acpi_handle handle)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	struct acpi_device *device, *child;
-	int rc;
+	struct acpi_device *device;
 
 	device = acpi_fetch_acpi_dev(handle);
 	if (!device)
 		return 0;
 
-	rc = 0;
-	list_for_each_entry(child, &device->children, node) {
-		acpi_status status = acpi_evaluate_object(child->handle, "_BCL",
-							  NULL, &buffer);
-		if (ACPI_FAILURE(status)) {
-			buffer.length = ACPI_ALLOCATE_BUFFER;
-			continue;
-		}
-
-		obj = (union acpi_object *)buffer.pointer;
-		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-			pr_err("Unknown _BCL data, please report this to %s\n",
-				TPACPI_MAIL);
-			rc = 0;
-		} else {
-			rc = obj->package.count;
-		}
-		break;
-	}
-
-	kfree(buffer.pointer);
-	return rc;
+	return acpi_dev_for_each_child(device, tpacpi_evaluate_bcl, NULL);
 }
 
 



