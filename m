Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129D68E805
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 07:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjBHGHJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 01:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHGHI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 01:07:08 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 22:07:07 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A6F2CFDD
        for <linux-acpi@vger.kernel.org>; Tue,  7 Feb 2023 22:07:07 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6513D101C0227;
        Wed,  8 Feb 2023 06:59:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2CCA437E37; Wed,  8 Feb 2023 06:59:51 +0100 (CET)
Message-Id: <1bebe2a62539988a1b5fd26665ab5221a7eddbb2.1675835625.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Feb 2023 06:59:51 +0100
Subject: [PATCH] ACPICA: Fix typo in CDAT DSMAS struct definition
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 9d8bd58d5f3495ce76d1b9767ec0b92251cbc366

Link: https://github.com/acpica/acpica/commit/9d8bd58d5f34
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 72884ef..cdedccc 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -346,7 +346,7 @@ enum acpi_cdat_type {
 
 /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
 
-struct acpi_cadt_dsmas {
+struct acpi_cdat_dsmas {
 	u8 dsmad_handle;
 	u8 flags;
 	u16 reserved;
-- 
2.39.1

