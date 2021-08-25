Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAD3F7C3E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhHYSeO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 14:34:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56878 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhHYScI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 14:32:08 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id bd8eaabcade34f46; Wed, 25 Aug 2021 20:31:12 +0200
Received: from kreacher.localnet (unknown [213.134.181.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 899F566A28D;
        Wed, 25 Aug 2021 20:31:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: power: Drop name from struct acpi_power_resource
Date:   Wed, 25 Aug 2021 20:31:10 +0200
Message-ID: <2616419.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.157
X-CLIENT-HOSTNAME: 213.134.181.157
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukedurdduheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddrudehjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the name field (that only is used in diagnostic messages) from
struct acpi_power_resource and use the name of the power resource
device object instead of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -48,7 +48,6 @@ struct acpi_power_dependent_device {
 struct acpi_power_resource {
 	struct acpi_device device;
 	struct list_head list_node;
-	char *name;
 	u32 system_level;
 	u32 order;
 	unsigned int ref_count;
@@ -70,6 +69,11 @@ static DEFINE_MUTEX(power_resource_list_
                              Power Resource Management
    -------------------------------------------------------------------------- */
 
+static inline const char *resource_dev_name(struct acpi_power_resource *pr)
+{
+	return dev_name(&pr->device.dev);
+}
+
 static inline
 struct acpi_power_resource *to_power_resource(struct acpi_device *device)
 {
@@ -264,7 +268,8 @@ acpi_power_resource_add_dependent(struct
 
 	dep->dev = dev;
 	list_add_tail(&dep->node, &resource->dependents);
-	dev_dbg(dev, "added power dependency to [%s]\n", resource->name);
+	dev_dbg(dev, "added power dependency to [%s]\n",
+		resource_dev_name(resource));
 
 unlock:
 	mutex_unlock(&resource->resource_lock);
@@ -283,7 +288,7 @@ acpi_power_resource_remove_dependent(str
 			list_del(&dep->node);
 			kfree(dep);
 			dev_dbg(dev, "removed power dependency to [%s]\n",
-				resource->name);
+				resource_dev_name(resource));
 			break;
 		}
 	}
@@ -381,7 +386,7 @@ static int __acpi_power_on(struct acpi_p
 
 	list_for_each_entry(dep, &resource->dependents, node) {
 		dev_dbg(dep->dev, "runtime resuming because [%s] turned on\n",
-			resource->name);
+			resource_dev_name(resource));
 		pm_request_resume(dep->dev);
 	}
 
@@ -953,7 +958,6 @@ struct acpi_device *acpi_add_power_resou
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
-	resource->name = device->pnp.bus_id;
 	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;



