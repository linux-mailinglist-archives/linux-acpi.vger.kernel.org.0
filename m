Return-Path: <linux-acpi+bounces-372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5127B6BBF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4D1ED2816F4
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB631A96
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D326E0B
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:26:53 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD09BD;
	Tue,  3 Oct 2023 06:26:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id fee7940ee958ee86; Tue, 3 Oct 2023 15:26:49 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id C63456659AF;
	Tue,  3 Oct 2023 15:26:48 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/6] ACPI: thermal: Move get_active_temp()
Date: Tue, 03 Oct 2023 15:18:31 +0200
Message-ID: <2913298.e9J7NaK4W3@kreacher>
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

Put the get_active_temp() function next to the analogous
get_passive_temp() one to allow subsequent changes to be easier to
follow.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -189,6 +189,29 @@ static long get_passive_temp(struct acpi
 	return tmp;
 }
 
+static long get_active_temp(struct acpi_thermal *tz, int index)
+{
+	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return THERMAL_TEMP_INVALID;
+
+	/*
+	 * If an override has been provided, apply it so there are no active
+	 * trips with thresholds greater than the override.
+	 */
+	if (act > 0) {
+		unsigned long long override = celsius_to_deci_kelvin(act);
+
+		if (tmp > override)
+			tmp = override;
+	}
+	return tmp;
+}
+
 static void acpi_thermal_update_passive_trip(struct acpi_thermal *tz)
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
@@ -250,29 +273,6 @@ static void acpi_thermal_update_trip_dev
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static long get_active_temp(struct acpi_thermal *tz, int index)
-{
-	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
-	unsigned long long tmp;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return THERMAL_TEMP_INVALID;
-
-	/*
-	 * If an override has been provided, apply it so there are no active
-	 * trips with thresholds greater than the override.
-	 */
-	if (act > 0) {
-		unsigned long long override = celsius_to_deci_kelvin(act);
-
-		if (tmp > override)
-			tmp = override;
-	}
-	return tmp;
-}
-
 static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;




