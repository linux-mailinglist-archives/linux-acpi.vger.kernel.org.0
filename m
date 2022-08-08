Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7858C08E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Aug 2022 03:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiHHBwi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Aug 2022 21:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiHHBvS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Aug 2022 21:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C719293;
        Sun,  7 Aug 2022 18:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C5E860EBD;
        Mon,  8 Aug 2022 01:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F62C433D6;
        Mon,  8 Aug 2022 01:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659922694;
        bh=Dh52KnD97w+Gecy8qufCmrnrAosl6/m7vL5CLxzUWeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egTyFH0ghh8Ni3ptbWcK/lOkWVIRuIRo+nhGOvV0qHB+X9SDQFK46rfS03QrUmgOZ
         aFRqQJyxXAIhl5Ts98eqw2nKx/FhZ9+aL7Om05MDlWo4cGhO3pkTDOkxuxgjeH0tav
         Ej4QxaTjKIR1VpflJnHrfb4wy8g1wmWurVlSE+DPiHDVa4zIZaRHTKqoHbT6IPHFFW
         gZbhEcqtJNXyrV/igzc2wQBw6WpORXIuoJB/EuC9ZEMlKXuAR9GZOboSFAFwTMbYNs
         pwChSMiL/jYg0gGVuwjVQTup1KhjsxkOQk7+KrpBQDWQxcZOmG31bnsUeHrGxYmhgn
         e112Dl5MiUjow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Drake <drake@endlessos.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/29] ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
Date:   Sun,  7 Aug 2022 21:37:30 -0400
Message-Id: <20220808013741.316026-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808013741.316026-1-sashal@kernel.org>
References: <20220808013741.316026-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f7090e0ef360d674f08a22fab90e4e209fb1f658 ]

It seems that these quirks are no longer necessary since
commit 69b957c26b32 ("ACPI: EC: Fix possible issues related to EC
initialization order"), which has fixed this in a generic manner.

There are 3 commits adding DMI entries with this quirk (adding multiple
DMI entries per commit). 2/3 commits are from before the generic fix.

Which leaves commit 6306f0431914 ("ACPI: EC: Make more Asus laptops
use ECDT _GPE"), which was committed way after the generic fix.
But this was just due to slow upstreaming of it. This commit stems
from Endless from 15 Aug 2017 (committed upstream 20 May 2021):
https://github.com/endlessm/linux/pull/288

The current code should work fine without this:

 1. The EC_FLAGS_IGNORE_DSDT_GPE flag is only checked in ec_parse_device(),
    like this:

	if (boot_ec && boot_ec_is_ecdt && EC_FLAGS_IGNORE_DSDT_GPE) {
		ec->gpe = boot_ec->gpe;
	} else {
		/* parse GPE */
	}

 2. ec_parse_device() is only called from acpi_ec_add() and
    acpi_ec_dsdt_probe()

 3. acpi_ec_dsdt_probe() starts with:

	if (boot_ec)
		return;

    so it only calls ec_parse_device() when boot_ec == NULL, meaning that
    the quirk never triggers for this call. So only the call in
    acpi_ec_add() matters.

 4. acpi_ec_add() does the following after the ec_parse_device() call:

	if (boot_ec && ec->command_addr == boot_ec->command_addr &&
	    ec->data_addr == boot_ec->data_addr &&
	    !EC_FLAGS_TRUST_DSDT_GPE) {
		/*
		 * Trust PNP0C09 namespace location rather than
		 * ECDT ID. But trust ECDT GPE rather than _GPE
		 * because of ASUS quirks, so do not change
		 * boot_ec->gpe to ec->gpe.
		 */
		boot_ec->handle = ec->handle;
		acpi_handle_debug(ec->handle, "duplicated.\n");
		acpi_ec_free(ec);
		ec = boot_ec;
	}

The quirk only matters if boot_ec != NULL and EC_FLAGS_TRUST_DSDT_GPE
is never set at the same time as EC_FLAGS_IGNORE_DSDT_GPE.

That means that if the addresses match we always enter this if block and
then only the ec->handle part of the data stored in ec by ec_parse_device()
is used and the rest is thrown away, after which ec is made to point
to boot_ec, at which point ec->gpe == boot_ec->gpe, so the same result
as with the quirk set, independent of the value of the quirk.

Also note the comment in this block which indicates that the gpe result
from ec_parse_device() is deliberately not taken to deal with buggy
Asus laptops and all DMI quirks setting EC_FLAGS_IGNORE_DSDT_GPE are for
Asus laptops.

Based on the above I believe that unless on some quirked laptops
the ECDT and DSDT EC addresses do not match we can drop the quirk.

I've checked dmesg output to ensure the ECDT and DSDT EC addresses match
for quirked models using https://linux-hardware.org hw-probe reports.

I've been able to confirm that the addresses match for the following
models this way: GL702VMK, X505BA, X505BP, X550VXK, X580VD.
Whereas for the following models I could find any dmesg output:
FX502VD, FX502VE, X542BA, X542BP.

Note the models without dmesg all were submitted in patches with a batch
of models and other models from the same batch checkout ok.

This, combined with that all the code adding the quirks was written before
the generic fix makes me believe that it is safe to remove this quirk now.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Daniel Drake <drake@endlessos.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 75 ++++++-----------------------------------------
 1 file changed, 9 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7305cfc8e146..4707d1808ca5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -183,7 +183,6 @@ static struct workqueue_struct *ec_wq;
 static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
-static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
 static int EC_FLAGS_TRUST_DSDT_GPE; /* Needs DSDT GPE as correction setting */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 
@@ -1405,24 +1404,16 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	if (ec->data_addr == 0 || ec->command_addr == 0)
 		return AE_OK;
 
-	if (boot_ec && boot_ec_is_ecdt && EC_FLAGS_IGNORE_DSDT_GPE) {
-		/*
-		 * Always inherit the GPE number setting from the ECDT
-		 * EC.
-		 */
-		ec->gpe = boot_ec->gpe;
-	} else {
-		/* Get GPE bit assignment (EC events). */
-		/* TODO: Add support for _GPE returning a package */
-		status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
-		if (ACPI_SUCCESS(status))
-			ec->gpe = tmp;
+	/* Get GPE bit assignment (EC events). */
+	/* TODO: Add support for _GPE returning a package */
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
+	if (ACPI_SUCCESS(status))
+		ec->gpe = tmp;
+	/*
+	 * Errors are non-fatal, allowing for ACPI Reduced Hardware
+	 * platforms which use GpioInt instead of GPE.
+	 */
 
-		/*
-		 * Errors are non-fatal, allowing for ACPI Reduced Hardware
-		 * platforms which use GpioInt instead of GPE.
-		 */
-	}
 	/* Use the global lock for all EC transactions? */
 	tmp = 0;
 	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
@@ -1860,60 +1851,12 @@ static int ec_honor_dsdt_gpe(const struct dmi_system_id *id)
 	return 0;
 }
 
-/*
- * Some DSDTs contain wrong GPE setting.
- * Asus FX502VD/VE, GL702VMK, X550VXK, X580VD
- * https://bugzilla.kernel.org/show_bug.cgi?id=195651
- */
-static int ec_honor_ecdt_gpe(const struct dmi_system_id *id)
-{
-	pr_debug("Detected system needing ignore DSDT GPE setting.\n");
-	EC_FLAGS_IGNORE_DSDT_GPE = 1;
-	return 0;
-}
-
 static const struct dmi_system_id ec_dmi_table[] __initconst = {
 	{
 	ec_correct_ecdt, "MSI MS-171F", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
 	{
-	ec_honor_ecdt_gpe, "ASUS FX502VD", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "FX502VD"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUS FX502VE", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "FX502VE"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUS GL702VMK", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "GL702VMK"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BA", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X505BA"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BP", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X505BP"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BA", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X542BA"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BP", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X542BP"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUS X550VXK", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
-	{
-	ec_honor_ecdt_gpe, "ASUS X580VD", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
-	{
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=209989 */
 	ec_honor_dsdt_gpe, "HP Pavilion Gaming Laptop 15-cx0xxx", {
 	DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-- 
2.35.1

