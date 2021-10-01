Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5341F4DD
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355775AbhJASTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 14:19:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65310 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355750AbhJAST3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 14:19:29 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 54c70dff5dec9084; Fri, 1 Oct 2021 20:17:43 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 26FA766A7A3;
        Fri,  1 Oct 2021 20:17:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/4] ACPICA: ACPI 6.4 SRAT: add Generic Port Affinity type
Date:   Fri, 01 Oct 2021 20:15:35 +0200
Message-ID: <12886128.uLZWGnKmhe@kreacher>
In-Reply-To: <2236872.ElGaqSPkdT@kreacher>
References: <2236872.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

ACPICA commit 777e11b73e60f0eb606cf20142ef634702b09ba1

Add a new subtable type for SRAT Generic Port Affinity.
It uses the same subtable structure as the existing Generic
Initiator Affinity type.

Link: https://github.com/acpica/acpica/commit/777e11b7
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 actbl3.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -Nurp linux.before_name/include/acpi/actbl3.h linux.after_name/include/acpi/actbl3.h
--- linux.before_name/include/acpi/actbl3.h	2021-10-01 19:30:55.923584396 +0200
+++ linux.after_name/include/acpi/actbl3.h	2021-10-01 19:30:51.645655691 +0200
@@ -191,7 +191,8 @@ enum acpi_srat_type {
 	ACPI_SRAT_TYPE_GICC_AFFINITY = 3,
 	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
 	ACPI_SRAT_TYPE_GENERIC_AFFINITY = 5,	/* ACPI 6.3 */
-	ACPI_SRAT_TYPE_RESERVED = 6	/* 5 and greater are reserved */
+	ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY = 6,	/* ACPI 6.4 */
+	ACPI_SRAT_TYPE_RESERVED = 7	/* 7 and greater are reserved */
 };
 
 /*
@@ -272,7 +273,11 @@ struct acpi_srat_gic_its_affinity {
 	u32 its_id;
 };
 
-/* 5: Generic Initiator Affinity Structure (ACPI 6.3) */
+/*
+ * Common structure for SRAT subtable types:
+ * 5: ACPI_SRAT_TYPE_GENERIC_AFFINITY
+ * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
+ */
 
 struct acpi_srat_generic_affinity {
 	struct acpi_subtable_header header;



