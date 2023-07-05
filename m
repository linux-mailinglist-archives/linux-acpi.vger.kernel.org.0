Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80334748FBF
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGEVbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGEVbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D891B19B5
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+8vuyD5M67TFv6LoooeJoTqBLl6qlPDtYuFzoWTY50=;
        b=gGIaznjX1T/pT1xR3hpD4hk9arzyElf7/QJmtB2wc3t5UeJWcGbLGdgc4fEqfH4wLIiGl+
        fpY5XinhJaZXW3YgaXUMnX4wUegOv8MB8jakWHtU/ROgQ6mdFnk8CVKxSlkj1u5osavMQx
        QH4FSQ5WHzBH/md9GqqZtjKUOMsJA+4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-_DJ3MYxtNmeSCz-Q21B9yQ-1; Wed, 05 Jul 2023 17:30:23 -0400
X-MC-Unique: _DJ3MYxtNmeSCz-Q21B9yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31E3E1C4FD83;
        Wed,  5 Jul 2023 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F67940C2063;
        Wed,  5 Jul 2023 21:30:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
Subject: [PATCH v3 01/18] media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
Date:   Wed,  5 Jul 2023 23:29:53 +0200
Message-ID: <20230705213010.390849-2-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When ipu_bridge_parse_rotation() and ipu_bridge_parse_orientation() run
sensor->adev is not set yet.

So if either of the dev_warn() calls about unknown values are hit this
will lead to a NULL pointer deref.

Set sensor->adev earlier, with a borrowed ref to avoid making unrolling
on errors harder, to fix this.

Fixes: 485aa3df0dff ("media: ipu3-cio2: Parse sensor orientation and rotation")
Cc: Fabian Wüthrich <me@fabwu.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 62daa8c1f6b1..f0927f80184d 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -308,6 +308,11 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
+		/*
+		 * Borrow our adev ref to the sensor for now, on success
+		 * acpi_dev_get(adev) is done further below.
+		 */
+		sensor->adev = adev;
 
 		ret = ipu_bridge_read_acpi_buffer(adev, "SSDB",
 						  &sensor->ssdb,
-- 
2.41.0

