Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01A38ECEB
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhEXP37 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 11:29:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52510 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhEXP3I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 11:29:08 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 463d994eb97b68af; Mon, 24 May 2021 17:27:38 +0200
Received: from kreacher.localnet (89-64-80-49.dynamic.chello.pl [89.64.80.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BD9D666971F;
        Mon, 24 May 2021 17:27:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Olsthoorn <dave@bewaar.me>, Shujun Wang <wsj20369@163.com>
Subject: [PATCH v1 1/3] ACPI: power: Use u8 as the power resource state data type
Date:   Mon, 24 May 2021 17:24:16 +0200
Message-ID: <2786380.e9J7NaK4W3@kreacher>
In-Reply-To: <2074778.irdbgypaU6@kreacher>
References: <2074778.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.49
X-CLIENT-HOSTNAME: 89-64-80-49.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedtrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrgeelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgessggvfigrrghrrdhmvgdprhgtphhtthhopeifshhjvddtfeeileesudeifedrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use u8 as the data type for representing the state of an ACPI
power resource.

It is s not necessary to use int for that and because subsequent
changes are going to use ACPI_POWER_RESOURCE_STATE_UNKNOWN, it is
better to adjust the data type so that the "unknown" state is
represented by the "all ones" value.

While at it, clean up acpi_power_get_state() somewhat.

No intentional functional impact.

Tested-by: Dave Olsthoorn <dave@bewaar.me>
Tested-by: Shujun Wang <wsj20369@163.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -182,10 +182,11 @@ int acpi_extract_power_resources(union a
 	return err;
 }
 
-static int acpi_power_get_state(acpi_handle handle, int *state)
+static int acpi_power_get_state(acpi_handle handle, u8 *state)
 {
 	acpi_status status = AE_OK;
 	unsigned long long sta = 0;
+	u8 cur_state;
 
 	if (!handle || !state)
 		return -EINVAL;
@@ -194,25 +195,24 @@ static int acpi_power_get_state(acpi_han
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
-			      ACPI_POWER_RESOURCE_STATE_OFF;
+	cur_state = sta & ACPI_POWER_RESOURCE_STATE_ON;
 
 	acpi_handle_debug(handle, "Power resource is %s\n",
-			  *state ? "on" : "off");
+			  cur_state ? "on" : "off");
 
+	*state = cur_state;
 	return 0;
 }
 
-static int acpi_power_get_list_state(struct list_head *list, int *state)
+static int acpi_power_get_list_state(struct list_head *list, u8 *state)
 {
 	struct acpi_power_resource_entry *entry;
-	int cur_state;
+	u8 cur_state = ACPI_POWER_RESOURCE_STATE_OFF;
 
 	if (!list || !state)
 		return -EINVAL;
 
 	/* The state of the list is 'on' IFF all resources are 'on'. */
-	cur_state = 0;
 	list_for_each_entry(entry, list, node) {
 		struct acpi_power_resource *resource = entry->resource;
 		acpi_handle handle = resource->device.handle;
@@ -592,7 +592,7 @@ int acpi_power_wakeup_list_init(struct l
 		struct acpi_power_resource *resource = entry->resource;
 		acpi_handle handle = resource->device.handle;
 		int result;
-		int state;
+		u8 state;
 
 		mutex_lock(&resource->resource_lock);
 
@@ -789,8 +789,8 @@ int acpi_disable_wakeup_device_power(str
 
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 {
+	u8 list_state = ACPI_POWER_RESOURCE_STATE_OFF;
 	int result = 0;
-	int list_state = 0;
 	int i = 0;
 
 	if (!device || !state)
@@ -919,7 +919,8 @@ struct acpi_device *acpi_add_power_resou
 	union acpi_object acpi_object;
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 	acpi_status status;
-	int state, result = -ENODEV;
+	int result;
+	u8 state;
 
 	acpi_bus_get_device(handle, &device);
 	if (device)
@@ -979,7 +980,8 @@ void acpi_resume_power_resources(void)
 	mutex_lock(&power_resource_list_lock);
 
 	list_for_each_entry(resource, &acpi_power_resource_list, list_node) {
-		int result, state;
+		int result;
+		u8 state;
 
 		mutex_lock(&resource->resource_lock);
 
@@ -1012,7 +1014,8 @@ static void acpi_power_turn_off_if_unuse
 		if (resource->users > 0)
 			return;
 	} else {
-		int result, state;
+		int result;
+		u8 state;
 
 		result = acpi_power_get_state(resource->device.handle, &state);
 		if (result || state == ACPI_POWER_RESOURCE_STATE_OFF)



