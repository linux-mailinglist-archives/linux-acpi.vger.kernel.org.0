Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25257748FCD
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGEVcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGEVcF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684B19BF
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0DTzrgAZBiYTKYT0PbWhHnkaHxl706xaM7SL5gQnHs=;
        b=Aq14pmupSGKAqZaxfAvSi7pgMmTiNW0DyRJ6V8/lA9Up4z6IURH0jXmpIkyOkvD0gtfSbS
        sVm0mgDHftXk0IqBYygKOmEjyovrW68nL9L9Lsg0dQyZObpsD+TvB3K5aNn3dch1VB8rAG
        Tb+3YQnm30+G8+vEXVXcJowve7jVnys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-Ii-d3Cz6MAWGKJ4S3i21bQ-1; Wed, 05 Jul 2023 17:30:27 -0400
X-MC-Unique: Ii-d3Cz6MAWGKJ4S3i21bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B00048022EF;
        Wed,  5 Jul 2023 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A55340C2063;
        Wed,  5 Jul 2023 21:30:25 +0000 (UTC)
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
Subject: [PATCH v3 03/18] media: ipu-bridge: Move initialization of node_names.vcm to ipu_bridge_init_swnode_names()
Date:   Wed,  5 Jul 2023 23:29:55 +0200
Message-ID: <20230705213010.390849-4-hdegoede@redhat.com>
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

Move initialization of node_names.vcm to ipu_bridge_init_swnode_names()
where it belongs.

And make the initialization of nodes[SWNODE_VCM] unconditional,
ipu_bridge_init_swnode_group() takes care of not registering it
when there is no VCM.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index ef6c6cb7b51b..1c88fd925a8b 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -201,6 +201,12 @@ static void ipu_bridge_init_swnode_names(struct ipu_sensor *sensor)
 	snprintf(sensor->node_names.endpoint,
 		 sizeof(sensor->node_names.endpoint),
 		 SWNODE_GRAPH_ENDPOINT_NAME_FMT, 0); /* And endpoint 0 */
+	if (sensor->ssdb.vcmtype) {
+		/* append ssdb.link to distinguish nodes with same model VCM */
+		snprintf(sensor->node_names.vcm, sizeof(sensor->node_names.vcm),
+			 "%s-%u", ipu_vcm_types[sensor->ssdb.vcmtype - 1],
+			 sensor->ssdb.link);
+	}
 }
 
 static void ipu_bridge_init_swnode_group(struct ipu_sensor *sensor)
@@ -237,13 +243,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						sensor->node_names.endpoint,
 						&nodes[SWNODE_IPU_PORT],
 						sensor->ipu_properties);
-	if (sensor->ssdb.vcmtype) {
-		/* append ssdb.link to distinguish VCM nodes with same HID */
-		snprintf(sensor->node_names.vcm, sizeof(sensor->node_names.vcm),
-			 "%s-%u", ipu_vcm_types[sensor->ssdb.vcmtype - 1],
-			 sensor->ssdb.link);
-		nodes[SWNODE_VCM] = NODE_VCM(sensor->node_names.vcm);
-	}
+	nodes[SWNODE_VCM] = NODE_VCM(sensor->node_names.vcm);
 
 	ipu_bridge_init_swnode_group(sensor);
 }
-- 
2.41.0

