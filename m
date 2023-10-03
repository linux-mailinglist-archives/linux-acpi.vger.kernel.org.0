Return-Path: <linux-acpi+bounces-370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE397B6BBB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 410CD281844
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B3328A8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1E2137C
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:26:52 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5AAB;
	Tue,  3 Oct 2023 06:26:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id a243c055453c96a8; Tue, 3 Oct 2023 15:26:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id F01D96659AF;
	Tue,  3 Oct 2023 15:26:47 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/6] ACPI: thermal: Combine passive and active trip update functions
Date: Tue, 03 Oct 2023 15:21:30 +0200
Message-ID: <8288399.T7Z3S40VBb@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Combine acpi_thermal_update_passive_trip() and
acpi_thermal_update_active_trip() into one common function called
acpi_thermal_update_trip(), so as to reduce code duplication and
prepare the code in question for subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -212,14 +212,25 @@ static long get_active_temp(struct acpi_
 	return tmp;
 }
 
-static void acpi_thermal_update_passive_trip(struct acpi_thermal *tz)
+static void acpi_thermal_update_trip(struct acpi_thermal *tz,
+				     int index)
 {
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
+	struct acpi_thermal_trip *acpi_trip;
 
-	if (!acpi_thermal_trip_valid(acpi_trip) || psv > 0)
+	acpi_trip = index == ACPI_THERMAL_TRIP_PASSIVE ?
+			&tz->trips.passive.trip : &tz->trips.active[index].trip;
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	acpi_trip->temp_dk = get_passive_temp(tz);
+	if (index == ACPI_THERMAL_TRIP_PASSIVE) {
+		if (psv > 0)
+			return;
+
+		acpi_trip->temp_dk = get_passive_temp(tz);
+	} else {
+		acpi_trip->temp_dk = get_active_temp(tz, index);
+	}
+
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
@@ -273,18 +284,6 @@ static void acpi_thermal_update_trip_dev
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
-{
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
-
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		return;
-
-	acpi_trip->temp_dk = get_active_temp(tz, index);
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
-}
-
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
@@ -308,9 +307,9 @@ static void acpi_thermal_adjust_thermal_
 	int i;
 
 	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
-		acpi_thermal_update_passive_trip(tz);
+		acpi_thermal_update_trip(tz, ACPI_THERMAL_TRIP_PASSIVE);
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_active_trip(tz, i);
+			acpi_thermal_update_trip(tz, i);
 	} else {
 		acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)





