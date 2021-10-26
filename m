Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01743BA12
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbhJZTCv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:02:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48810 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhJZTCs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 15:02:48 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id db9042bec48cd122; Tue, 26 Oct 2021 21:00:18 +0200
Received: from kreacher.localnet (unknown [213.134.187.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C30BF66A9F8;
        Tue, 26 Oct 2021 21:00:17 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: scan: Do not add device IDs from _CID if _HID is not valid
Date:   Tue, 26 Oct 2021 20:57:31 +0200
Message-ID: <5768704.lOV4Wx5bFT@kreacher>
In-Reply-To: <11860508.O9o76ZdvQC@kreacher>
References: <11860508.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.81
X-CLIENT-HOSTNAME: 213.134.187.81
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefkedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteffueegudelgeeikeelffeftdettedvkedvtdeijeeuffegheevteduheejffeinecuffhomhgrihhnpehuvghfihdrohhrghenucfkphepvddufedrudefgedrudekjedrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrkedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Section 6.1.2 of ACPI 6.4 explicitly requires _HID to be present for
_CID to be defined, so don't add device IDs from _CID to the device
IDs list of a device if _HID is not valid.

Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#cid-compatible-id
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1338,11 +1338,11 @@ static void acpi_set_pnp_ids(acpi_handle
 		if (info->valid & ACPI_VALID_HID) {
 			acpi_add_id(pnp, info->hardware_id.string);
 			pnp->type.platform_id = 1;
-		}
-		if (info->valid & ACPI_VALID_CID) {
-			cid_list = &info->compatible_id_list;
-			for (i = 0; i < cid_list->count; i++)
-				acpi_add_id(pnp, cid_list->ids[i].string);
+			if (info->valid & ACPI_VALID_CID) {
+				cid_list = &info->compatible_id_list;
+				for (i = 0; i < cid_list->count; i++)
+					acpi_add_id(pnp, cid_list->ids[i].string);
+			}
 		}
 		if (info->valid & ACPI_VALID_ADR) {
 			pnp->bus_address = info->address;



