Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488C851D85D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392210AbiEFNCW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392204AbiEFNCR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313B4D607
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7XVeH0r5WwHTiYdbtNFmO0ns5N0Qls0Px20YK1i/T8=;
  b=RdzZ9gvsNDnF+qBAuYYWzXcDzY7IKPEoEeLHgnbjq/xO0vcB0P8kvJfP
   FE1dZ5cZxUAXq/Wh/QuFawZyg7lVPv0YqcfCu8tDIZ4UIeYmK2ec7vgUP
   /cqppa5oDBNTzhd1AyUewKGwf2NxoSLtSQepUc4aD1myl2q8Mv/NhTC2R
   3ROyAzl48dbbP+Gv9VqScbAEki6slu2RiteSr0r71GVO5SwTIeEkpkHyE
   RJUgfJt2wAO1zGMJqQ3BEbKTkWsr8x2MyBAjtZC1aFgdaiLn1xQnMGFUm
   K3EaokZqVCgZZAQNOMd7ei8reTHrZCD2eMBzQSvtRB74NgJwh9yB70hUl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266051618"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266051618"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812381458"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:33 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DA48320E1C;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480h-GO; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 07/11] ACPI: Initialise device child list early to access data nodes early
Date:   Fri,  6 May 2022 16:00:21 +0300
Message-Id: <20220506130025.984026-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The properties, including data nodes, are initialised in
acpi_init_device_object(). Traversing the data nodes also requires the
device's child list to be initialised which happens much later in
__acpi_device_add(). The function also makes the device visible in the
system, so setting up its properties and nodes is too late by then.

To address this, move the child list initialisation before
acpi_init_properties() in acpi_init_device_object().

Note that this is currently not an issue as the properties will only be
accessed by drivers. In the near future accessing the properties will be
done in the ACPI framework itself, and doing so requires this change.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 762b61f67e6c6..86c4e9a473edc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -680,7 +680,6 @@ static int __acpi_device_add(struct acpi_device *device,
 	 * -------
 	 * Link this device to its parent and siblings.
 	 */
-	INIT_LIST_HEAD(&device->children);
 	INIT_LIST_HEAD(&device->node);
 	INIT_LIST_HEAD(&device->wakeup_list);
 	INIT_LIST_HEAD(&device->physical_node_list);
@@ -1786,6 +1785,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
+	INIT_LIST_HEAD(&device->children);
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
-- 
2.30.2

