Return-Path: <linux-acpi+bounces-33-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5397A9C6A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3E5B2179D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2F259FB0
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F53D39B
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A72AF957;
	Thu, 21 Sep 2023 11:07:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id bfbd3e583f736223; Thu, 21 Sep 2023 20:07:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 2DCAD664EBE;
	Thu, 21 Sep 2023 20:07:30 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 03/13] ACPI: thermal: Collapse trip devices update function wrappers
Date: Thu, 21 Sep 2023 19:50:08 +0200
Message-ID: <3198428.5fSG56mABF@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to reduce code duplicationeve further, merge
acpi_thermal_update_passive/active_devices() into one function
called acpi_thermal_update_trip_devices() that will be used for
updating both the passive and active trip points.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -233,14 +233,16 @@ static bool update_trip_devices(struct a
 	return true;
 }
 
-static void acpi_thermal_update_passive_devices(struct acpi_thermal *tz)
+static void acpi_thermal_update_trip_devices(struct acpi_thermal *tz, int index)
 {
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
+	struct acpi_thermal_trip *acpi_trip;
 
+	acpi_trip = index == ACPI_THERMAL_TRIP_PASSIVE ?
+			&tz->trips.passive.trip : &tz->trips.active[index].trip;
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	if (update_trip_devices(tz, acpi_trip, ACPI_THERMAL_TRIP_PASSIVE, true)) {
+	if (update_trip_devices(tz, acpi_trip, index, true)) {
 		return;
 	}
 
@@ -283,20 +285,6 @@ static void acpi_thermal_update_active_t
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static void acpi_thermal_update_active_devices(struct acpi_thermal *tz, int index)
-{
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
-
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		return;
-
-	if (update_trip_devices(tz, acpi_trip, index, true))
-		return;
-
-	acpi_trip->temperature = THERMAL_TEMP_INVALID;
-	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
-}
-
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
@@ -324,9 +312,9 @@ static void acpi_thermal_adjust_thermal_
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
 			acpi_thermal_update_active_trip(tz, i);
 	} else {
-		acpi_thermal_update_passive_devices(tz);
+		acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_active_devices(tz, i);
+			acpi_thermal_update_trip_devices(tz, i);
 	}
 
 	for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);




