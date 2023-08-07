Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F4772D9F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjHGSU7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHGSU5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 14:20:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B78F;
        Mon,  7 Aug 2023 11:20:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 94dc6781b6e2d306; Mon, 7 Aug 2023 20:20:53 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 095486625B2;
        Mon,  7 Aug 2023 20:20:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 11/11] thermal: core: Eliminate code duplication from acpi_thermal_notify()
Date:   Mon, 07 Aug 2023 20:20:18 +0200
Message-ID: <23175634.6Emhk5qWAg@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the acpi_bus_generate_netlink_event() invocation into
acpi_thermal_trips_update() which allows the code duplication in
acpi_thermal_notify() to be cleaned up, but for this purpose the
event value needs to be passed to acpi_thermal_trips_update() and
from there to acpi_thermal_adjust_thermal_zone() which has to
determine the flag value for __acpi_thermal_trips_update() by
itself.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5: Rebase.

New patch in v4.

---
 drivers/acpi/thermal.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -419,8 +419,10 @@ static void acpi_thermal_adjust_thermal_
 					     unsigned long data)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
+	int flag = data == ACPI_THERMAL_NOTIFY_THRESHOLDS ?
+				ACPI_TRIPS_THRESHOLDS : ACPI_TRIPS_DEVICES;
 
-	__acpi_thermal_trips_update(tz, data);
+	__acpi_thermal_trips_update(tz, flag);
 
 	for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);
 }
@@ -431,8 +433,10 @@ static void acpi_queue_thermal_check(str
 		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
 }
 
-static void acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+static void acpi_thermal_trips_update(struct acpi_thermal *tz, u32 event)
 {
+	struct acpi_device *adev = tz->device;
+
 	/*
 	 * Use thermal_zone_device_adjust() to carry out the trip points
 	 * update, so as to protect thermal_get_trend() from getting stale
@@ -440,8 +444,10 @@ static void acpi_thermal_trips_update(st
 	 * invoked from acpi_thermal_check_fn() from producing inconsistent
 	 * results.
 	 */
-	thermal_zone_device_adjust(tz->thermal_zone, flag);
+	thermal_zone_device_adjust(tz->thermal_zone, event);
 	acpi_queue_thermal_check(tz);
+	acpi_bus_generate_netlink_event(adev->pnp.device_class,
+					dev_name(&adev->dev), event, 0);
 }
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
@@ -812,14 +818,8 @@ static void acpi_thermal_notify(acpi_han
 		acpi_queue_thermal_check(tz);
 		break;
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
-		acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						dev_name(&device->dev), event, 0);
-		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
-		acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						dev_name(&device->dev), event, 0);
+		acpi_thermal_trips_update(tz, event);
 		break;
 	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",



