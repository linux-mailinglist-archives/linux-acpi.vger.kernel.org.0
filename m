Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4376748FC5
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGEVby (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEVbx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A045319B9
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNj7Pqd/37O7IcqVEW3F0RbUZZA1kpdzg1WJQV37Gz0=;
        b=JyKc0pxAA2OOgI9opzCtXvl72rz4AsD2TWDsSuasOV6bq+66qqQLnqJrq4AJvCuqYJKP0r
        5Hq+ln+FxoO9D/XQvBv4aRfvD+fGLb2uA/ReAa8RYXxSS0JSJWotO4msA0j08VLQLJwNiX
        uKVy5dMYvvbNbN0ZuzKnTHu1AZ7b8Lk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-XmbUsj76P_eYnwvb5sfCmA-1; Wed, 05 Jul 2023 17:30:25 -0400
X-MC-Unique: XmbUsj76P_eYnwvb5sfCmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E830A381494E;
        Wed,  5 Jul 2023 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 662A340C2063;
        Wed,  5 Jul 2023 21:30:23 +0000 (UTC)
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
Subject: [PATCH v3 02/18] media: ipu-bridge: Do not use on stack memory for software_node.name field
Date:   Wed,  5 Jul 2023 23:29:54 +0200
Message-ID: <20230705213010.390849-3-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 567f97bd381f ("media: ipu3-cio2: support multiple sensors and VCMs
with same HID") introduced an on stack vcm_name and then uses this for
the name field of the software_node struct used for the vcm.

But the software_node struct is much longer lived then the current
stack-frame, so this is no good.

Instead extend the ipu_node_names struct with an extra field to store
the vcm software_node name and use that.

Note this also changes the length of the allocated buffer from
ACPI_ID_LEN + 4 to 16. the name is filled with "<ipu_vcm_types[x]>-%u"
where ipu_vcm_types[x] is not an ACPI_ID. The maximum length of
the strings in the ipu_vcm_types[] array is 11 + 5 bytes for "-255\0"
means 16 bytes are needed in the worst case scenario.

Fixes: 567f97bd381f ("media: ipu3-cio2: support multiple sensors and VCMs with same HID")
Cc: Bingbu Cao <bingbu.cao@intel.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 7 +++----
 drivers/media/pci/intel/ipu-bridge.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index f0927f80184d..ef6c6cb7b51b 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -220,7 +220,6 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						 struct ipu_sensor *sensor)
 {
 	struct software_node *nodes = sensor->swnodes;
-	char vcm_name[ACPI_ID_LEN + 4];
 
 	ipu_bridge_init_swnode_names(sensor);
 
@@ -240,10 +239,10 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						sensor->ipu_properties);
 	if (sensor->ssdb.vcmtype) {
 		/* append ssdb.link to distinguish VCM nodes with same HID */
-		snprintf(vcm_name, sizeof(vcm_name), "%s-%u",
-			 ipu_vcm_types[sensor->ssdb.vcmtype - 1],
+		snprintf(sensor->node_names.vcm, sizeof(sensor->node_names.vcm),
+			 "%s-%u", ipu_vcm_types[sensor->ssdb.vcmtype - 1],
 			 sensor->ssdb.link);
-		nodes[SWNODE_VCM] = NODE_VCM(vcm_name);
+		nodes[SWNODE_VCM] = NODE_VCM(sensor->node_names.vcm);
 	}
 
 	ipu_bridge_init_swnode_group(sensor);
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index 8cb733c03e2f..6cce712a0f34 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -103,6 +103,7 @@ struct ipu_node_names {
 	char port[7];
 	char endpoint[11];
 	char remote_port[7];
+	char vcm[16];
 };
 
 struct ipu_sensor_config {
-- 
2.41.0

