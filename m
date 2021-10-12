Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31D842AB28
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhJLRxO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 13:53:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65156 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhJLRxN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 13:53:13 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 3fae2874a0632811; Tue, 12 Oct 2021 19:51:10 +0200
Received: from kreacher.localnet (unknown [213.134.187.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F2F3466A819;
        Tue, 12 Oct 2021 19:51:09 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 7/7] perf: qcom_l2_pmu: ACPI: Use ACPI_COMPANION() directly
Date:   Tue, 12 Oct 2021 19:50:28 +0200
Message-ID: <3338400.QJadu78ljV@kreacher>
In-Reply-To: <4369779.LvFx2qVVIh@kreacher>
References: <4369779.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.88
X-CLIENT-HOSTNAME: 213.134.187.88
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdekkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrghhrohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhdrrghnuggvrhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqmhhs
 mhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Modify l2_cache_pmu_probe_cluster() accordingly (no intentional
functional impact).

While at it, rename the ACPI device pointer to adev for more
clarity.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/perf/qcom_l2_pmu.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/perf/qcom_l2_pmu.c
===================================================================
--- linux-pm.orig/drivers/perf/qcom_l2_pmu.c
+++ linux-pm/drivers/perf/qcom_l2_pmu.c
@@ -840,17 +840,14 @@ static int l2_cache_pmu_probe_cluster(st
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct platform_device *sdev = to_platform_device(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct l2cache_pmu *l2cache_pmu = data;
 	struct cluster_pmu *cluster;
-	struct acpi_device *device;
 	unsigned long fw_cluster_id;
 	int err;
 	int irq;
 
-	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
-		return -ENODEV;
-
-	if (kstrtoul(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
+	if (!adev || kstrtoul(adev->pnp.unique_id, 10, &fw_cluster_id) < 0) {
 		dev_err(&pdev->dev, "unable to read ACPI uid\n");
 		return -ENODEV;
 	}



