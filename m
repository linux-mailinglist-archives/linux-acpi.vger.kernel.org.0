Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B546742AB37
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJLRx3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 13:53:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54182 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhJLRxX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 13:53:23 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 6bc65ade955083a8; Tue, 12 Oct 2021 19:51:18 +0200
Received: from kreacher.localnet (unknown [213.134.187.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0739766A819;
        Tue, 12 Oct 2021 19:51:17 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v1 2/7] nouveau: ACPI: Use the ACPI_COMPANION() macro directly
Date:   Tue, 12 Oct 2021 19:44:21 +0200
Message-ID: <21245442.EfDdHjke4D@kreacher>
In-Reply-To: <4369779.LvFx2qVVIh@kreacher>
References: <4369779.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.88
X-CLIENT-HOSTNAME: 213.134.187.88
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrdekkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdekkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshhkvghgghhssehrvgguhhgrthdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepnhhouhhvvggr
 uheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
macro and the ACPI handle produced by the former comes from the
ACPI device object produced by the latter, so it is way more
straightforward to evaluate the latter directly instead of passing
the handle produced by the former to acpi_bus_get_device().

Modify nouveau_acpi_edid() accordingly (no intentional functional
impact).

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/gpu/drm/nouveau/nouveau_acpi.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ linux-pm/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -364,7 +364,6 @@ void *
 nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 {
 	struct acpi_device *acpidev;
-	acpi_handle handle;
 	int type, ret;
 	void *edid;
 
@@ -377,12 +376,8 @@ nouveau_acpi_edid(struct drm_device *dev
 		return NULL;
 	}
 
-	handle = ACPI_HANDLE(dev->dev);
-	if (!handle)
-		return NULL;
-
-	ret = acpi_bus_get_device(handle, &acpidev);
-	if (ret)
+	acpidev = ACPI_COMPANION(dev->dev);
+	if (!acpidev)
 		return NULL;
 
 	ret = acpi_video_get_edid(acpidev, type, -1, &edid);



