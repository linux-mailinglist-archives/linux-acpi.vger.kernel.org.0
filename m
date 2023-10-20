Return-Path: <linux-acpi+bounces-800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF07D140D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C280AB213A1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC61EA85
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57C18E37
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 14:49:53 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811FD46;
	Fri, 20 Oct 2023 07:49:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 07b7436e091f0dc3; Fri, 20 Oct 2023 16:49:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1931B667008;
	Fri, 20 Oct 2023 16:49:48 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date: Fri, 20 Oct 2023 16:40:08 +0200
Message-ID: <3552598.iIbC2pHGDl@kreacher>
In-Reply-To: <2187487.irdbgypaU6@kreacher>
References: <2187487.irdbgypaU6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Find the "rotation" property value for devices with _CRS CSI-2 resource
descriptors and use it to add the "rotation" property to the software
nodes representing the CSI-2 connection graph.  That value typically
comes from the _PLD (Physical Location of Device) object if it is
present for the given device.

This way, camera sensor drivers that know the "rotation" property do not
need to care about _PLD on systems using ACPI.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[ rjw: Changelog edits, file rename ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/mipi-di.c  |   17 +++++++++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 18 insertions(+)

Index: linux-pm/drivers/acpi/mipi-di.c
===================================================================
--- linux-pm.orig/drivers/acpi/mipi-di.c
+++ linux-pm/drivers/acpi/mipi-di.c
@@ -586,6 +586,7 @@ static void init_crs_csi2_swnodes(struct
 	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
 	struct acpi_device_software_nodes *swnodes = csi2->swnodes;
 	acpi_handle handle = csi2->handle;
+	unsigned int prop_index = 0;
 	struct fwnode_handle *adev_fwnode;
 	struct acpi_device *adev;
 	acpi_status status;
@@ -605,6 +606,22 @@ static void init_crs_csi2_swnodes(struct
 
 	adev_fwnode = acpi_fwnode_handle(adev);
 
+	/*
+	 * If the "rotation" property is not present, but _PLD is there,
+	 * evaluate it to get the "rotation" value.
+	 */
+	if (!fwnode_property_present(adev_fwnode, "rotation")) {
+		struct acpi_pld_info *pld;
+
+		status = acpi_get_physical_device_location(handle, &pld);
+		if (ACPI_SUCCESS(status)) {
+			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
+					PROPERTY_ENTRY_U32("rotation",
+							   pld->rotation * 45U);
+			kfree(pld);
+		}
+	}
+
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(handle, "Unable to get the path name\n");
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -373,6 +373,7 @@ struct acpi_gpio_mapping;
 #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
 
 enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_ROTATION,
 	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
 	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
 };




