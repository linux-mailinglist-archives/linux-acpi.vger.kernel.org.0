Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21E551449
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiFTJ05 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiFTJ0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 05:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CF5C12D20
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ur5MB6H6X1AzZ5Mbx517O+R9fAKbfOLE5DULzj1Aag=;
        b=XtwWk5CDYOidY7yp0nSguhZX+CZqu59SQ/+cyBMNCIOli+AzTs9/uXVBHDBL8xEgB+imMs
        FJZugtbMszSQBeFfZNEhHQeK8Luu7zpgyfdpLTG2/ov5YLtG/hWgpqXhZumfp4L3d9wo/v
        VvhZAWdcjop8GHsdUz5pH30xEiYQe9A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-GemSygC3M2yXn86RfRNNsA-1; Mon, 20 Jun 2022 05:26:45 -0400
X-MC-Unique: GemSygC3M2yXn86RfRNNsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A978929ABA39;
        Mon, 20 Jun 2022 09:26:44 +0000 (UTC)
Received: from x1.nl (unknown [10.39.195.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74FD71415109;
        Mon, 20 Jun 2022 09:26:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [PATCH 3/4] ACPI: EC: Re-use boot_ec when possible even when EC_FLAGS_TRUST_DSDT_GPE is set
Date:   Mon, 20 Jun 2022 11:25:45 +0200
Message-Id: <20220620092546.8298-4-hdegoede@redhat.com>
In-Reply-To: <20220620092546.8298-1-hdegoede@redhat.com>
References: <20220620092546.8298-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

EC_FLAGS_TRUST_DSDT_GPE only does anything when the:

	if (boot_ec && ec->command_addr == boot_ec->command_addr &&
	    ec->data_addr == boot_ec->data_addr)

conditions are all true. Normally acpi_ec_add() would re-use the boot_ec
struct acpi_ec in this case. But when the EC_FLAGS_TRUST_DSDT_GPE flag was
set the code would continue with a newly allocated (second) struct acpi_ec.

There is no reason to use a second struct acpi_ec if all the above checks
match. Instead just change boot_ec->gpe to ec->gpe, when the flag is set,
similar to how this is already one done for boot_ec->handle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this has not been tested by me on the one laptop model which uses
this quirk. This is purely based on my reading of the code.
Please review carefully.
---
 drivers/acpi/ec.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b1316aba844d..a4c16b8540e5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1618,15 +1618,18 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 
 		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
-		    ec->data_addr == boot_ec->data_addr &&
-		    !EC_FLAGS_TRUST_DSDT_GPE) {
+		    ec->data_addr == boot_ec->data_addr) {
 			/*
-			 * Trust PNP0C09 namespace location rather than
-			 * ECDT ID. But trust ECDT GPE rather than _GPE
-			 * because of ASUS quirks, so do not change
-			 * boot_ec->gpe to ec->gpe.
+			 * Trust PNP0C09 namespace location rather than ECDT ID.
+			 * But trust ECDT GPE rather than _GPE because of ASUS
+			 * quirks. So do not change boot_ec->gpe to ec->gpe,
+			 * except when the TRUST_DSDT_GPE quirk is set.
 			 */
 			boot_ec->handle = ec->handle;
+
+			if (EC_FLAGS_TRUST_DSDT_GPE)
+				boot_ec->gpe = ec->gpe;
+
 			acpi_handle_debug(ec->handle, "duplicated.\n");
 			acpi_ec_free(ec);
 			ec = boot_ec;
-- 
2.36.0

