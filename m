Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC0748FED
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGEVe5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGEVct (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D691BEA
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2je6FkWJRXTsTMxHOIrRjFLltc7XmjnvmAD6oPDRtGs=;
        b=YW9ful7ojHeFNcYEEJKxujNqHKeLZmIiGLFPYM8sQXV6Ofei19E1BG0lZLj1y/8k9uN9Wq
        CKYVE7VRUS9W//Za8AvJbBWdhTe/vJp83YnaL5z33Y81KxyUgSCmBRfxfKV0kX2Zhyz8jO
        G2293uOJCjosLby3tWh+OVS5WNzfoNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-OZcjZdZ4NOqugZs_cL_-Ow-1; Wed, 05 Jul 2023 17:30:48 -0400
X-MC-Unique: OZcjZdZ4NOqugZs_cL_-Ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2616F101A529;
        Wed,  5 Jul 2023 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9693C40C2063;
        Wed,  5 Jul 2023 21:30:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device() function
Date:   Wed,  5 Jul 2023 23:30:07 +0200
Message-ID: <20230705213010.390849-16-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some ACPI glue code (1) may want to do an acpi_device_id match while
it only has a struct acpi_device available because the first physical
node may not have been instantiated yet.

Add a new acpi_match_acpi_device() helper for this, which takes
a "struct acpi_device *" as argument rather then the "struct device *"
which acpi_match_device() takes.

1) E.g. code which parses ACPI tables to transforms them
into more standard kernel data structures like fwnodes

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c      | 22 ++++++++++++++++++----
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d161ff707de4..de75ad675f92 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -888,6 +888,23 @@ static bool __acpi_match_device(struct acpi_device *device,
 	return true;
 }
 
+/**
+ * acpi_match_acpi_device - Match a struct acpi_device against a given list of ACPI IDs
+ * @ids: Array of struct acpi_device_id object to match against.
+ * @adev: The acpi_device structure to match.
+ *
+ * Return a pointer to the first matching ID on success or %NULL on failure.
+ */
+const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_device_id *ids,
+						    struct acpi_device *adev)
+{
+	const struct acpi_device_id *id = NULL;
+
+	__acpi_match_device(adev, ids, NULL, &id, NULL);
+	return id;
+}
+EXPORT_SYMBOL_GPL(acpi_match_acpi_device);
+
 /**
  * acpi_match_device - Match a struct device against a given list of ACPI IDs
  * @ids: Array of struct acpi_device_id object to match against.
@@ -902,10 +919,7 @@ static bool __acpi_match_device(struct acpi_device *device,
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev)
 {
-	const struct acpi_device_id *id = NULL;
-
-	__acpi_match_device(acpi_companion_match(dev), ids, NULL, &id, NULL);
-	return id;
+	return acpi_match_acpi_device(ids, acpi_companion_match(dev));
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c941d99162c0..db854e78b2f8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -561,6 +561,8 @@ void acpi_bus_trim(struct acpi_device *start);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_device_id *ids,
+						    struct acpi_device *adev);
 void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
 		       char *modalias, size_t len);
 int acpi_create_dir(struct acpi_device *);
-- 
2.41.0

