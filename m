Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9638ECEA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhEXP36 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 11:29:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51496 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhEXP3H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 11:29:07 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id c768bedd6e9807ac; Mon, 24 May 2021 17:27:37 +0200
Received: from kreacher.localnet (89-64-80-49.dynamic.chello.pl [89.64.80.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4433766971F;
        Mon, 24 May 2021 17:27:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Olsthoorn <dave@bewaar.me>, Shujun Wang <wsj20369@163.com>
Subject: [PATCH v1 2/3] ACPI: power: Save the last known state of each power resource
Date:   Mon, 24 May 2021 17:25:23 +0200
Message-ID: <3126947.44csPzL39Z@kreacher>
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

Currently, there are two ways to check the state of an ACPI power
resource and they may not be consistent with each other.  The first
one is to evaluate the power resource's _STA object and the other one
is to check its reference counter value.  However, on some systems
the value returned by _STA may not be consistent with the value of
the power resource's reference counter (for example, on some systems
it returns the same value every time for certain power resources).

Moreover, evaluating _STA is unnecessary overhead for a power
resource for which it has been evaluated already or whose state is
otherwise known, because either the _ON or the _OFF method has been
executed for it.

For this reason, save the state of each power resource in its
struct acpi_power_resource object and use the saved value whenever
its state needs to be checked, except when its stats is unknown, in
which case the _STA method is evaluated for it and the value
returned by that method is saved as the last known state of
the power resource.

Moreover, drop the power resource _STA method evaluation from
acpi_add_power_resource(), so as to avoid doing that unnecessarily
for power resources that will never be used.

Tested-by: Dave Olsthoorn <dave@bewaar.me>
Tested-by: Shujun Wang <wsj20369@163.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -52,6 +52,7 @@ struct acpi_power_resource {
 	u32 order;
 	unsigned int ref_count;
 	unsigned int users;
+	u8 state;
 	bool wakeup_enabled;
 	struct mutex resource_lock;
 	struct list_head dependents;
@@ -177,15 +178,12 @@ int acpi_extract_power_resources(union a
 	return err;
 }
 
-static int acpi_power_get_state(acpi_handle handle, u8 *state)
+static int __get_state(acpi_handle handle, u8 *state)
 {
 	acpi_status status = AE_OK;
 	unsigned long long sta = 0;
 	u8 cur_state;
 
-	if (!handle || !state)
-		return -EINVAL;
-
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -199,6 +197,20 @@ static int acpi_power_get_state(acpi_han
 	return 0;
 }
 
+static int acpi_power_get_state(struct acpi_power_resource *resource, u8 *state)
+{
+	if (resource->state == ACPI_POWER_RESOURCE_STATE_UNKNOWN) {
+		int ret;
+
+		ret = __get_state(resource->device.handle, &resource->state);
+		if (ret)
+			return ret;
+	}
+
+	*state = resource->state;
+	return 0;
+}
+
 static int acpi_power_get_list_state(struct list_head *list, u8 *state)
 {
 	struct acpi_power_resource_entry *entry;
@@ -210,11 +222,10 @@ static int acpi_power_get_list_state(str
 	/* The state of the list is 'on' IFF all resources are 'on'. */
 	list_for_each_entry(entry, list, node) {
 		struct acpi_power_resource *resource = entry->resource;
-		acpi_handle handle = resource->device.handle;
 		int result;
 
 		mutex_lock(&resource->resource_lock);
-		result = acpi_power_get_state(handle, &cur_state);
+		result = acpi_power_get_state(resource, &cur_state);
 		mutex_unlock(&resource->resource_lock);
 		if (result)
 			return result;
@@ -347,8 +358,12 @@ static int __acpi_power_on(struct acpi_p
 	acpi_status status = AE_OK;
 
 	status = acpi_evaluate_object(resource->device.handle, "_ON", NULL, NULL);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 		return -ENODEV;
+	}
+
+	resource->state = ACPI_POWER_RESOURCE_STATE_ON;
 
 	pr_debug("Power resource [%s] turned on\n", resource->name);
 
@@ -400,8 +415,12 @@ static int __acpi_power_off(struct acpi_
 
 	status = acpi_evaluate_object(resource->device.handle, "_OFF",
 				      NULL, NULL);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 		return -ENODEV;
+	}
+
+	resource->state = ACPI_POWER_RESOURCE_STATE_OFF;
 
 	pr_debug("Power resource [%s] turned off\n", resource->name);
 
@@ -585,13 +604,12 @@ int acpi_power_wakeup_list_init(struct l
 
 	list_for_each_entry(entry, list, node) {
 		struct acpi_power_resource *resource = entry->resource;
-		acpi_handle handle = resource->device.handle;
 		int result;
 		u8 state;
 
 		mutex_lock(&resource->resource_lock);
 
-		result = acpi_power_get_state(handle, &state);
+		result = acpi_power_get_state(resource, &state);
 		if (result) {
 			mutex_unlock(&resource->resource_lock);
 			return result;
@@ -915,7 +933,6 @@ int acpi_add_power_resource(acpi_handle
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 	acpi_status status;
 	int result;
-	u8 state;
 
 	acpi_bus_get_device(handle, &device);
 	if (device)
@@ -942,13 +959,9 @@ int acpi_add_power_resource(acpi_handle
 
 	resource->system_level = acpi_object.power_resource.system_level;
 	resource->order = acpi_object.power_resource.resource_order;
+	resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 
-	result = acpi_power_get_state(handle, &state);
-	if (result)
-		goto err;
-
-	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
-		acpi_device_bid(device), state ? "on" : "off");
+	pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
 
 	device->flags.match_driver = true;
 	result = acpi_device_add(device, acpi_release_power_resource);
@@ -980,7 +993,8 @@ void acpi_resume_power_resources(void)
 
 		mutex_lock(&resource->resource_lock);
 
-		result = acpi_power_get_state(resource->device.handle, &state);
+		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
+		result = acpi_power_get_state(resource, &state);
 		if (result) {
 			mutex_unlock(&resource->resource_lock);
 			continue;



