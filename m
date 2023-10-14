Return-Path: <linux-acpi+bounces-647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFE7C970B
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Oct 2023 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9001C2093C
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Oct 2023 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F726E14
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Oct 2023 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wecf09EC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E23171DA
	for <linux-acpi@vger.kernel.org>; Sat, 14 Oct 2023 20:53:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B02DC
	for <linux-acpi@vger.kernel.org>; Sat, 14 Oct 2023 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697316801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HfvERTe/FR195wFtTeMXmEEjZtmCTqU7GmIwjqCAJM=;
	b=Wecf09EC936fvlBjXJEDVH0wn/ojC2R3AodBunLLu3Js9pIBKKLqY9Q1HaxhIJddFQgvVt
	OFB7pv7dH/6Y3meePmhFd7tbCNxI6/7ztk/5n4rzDH9QFB17kmHBxdi2QqvdPH5H+YseJ4
	kzDOLVBeFSzB35A5s3bZjgxaMZiv5yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-cmda1pSoMA-UMij-2OWvVg-1; Sat, 14 Oct 2023 16:53:18 -0400
X-MC-Unique: cmda1pSoMA-UMij-2OWvVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99BD21023110;
	Sat, 14 Oct 2023 20:53:17 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68BCA25C0;
	Sat, 14 Oct 2023 20:53:16 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/4] spi: Export acpi_spi_find_controller_by_adev()
Date: Sat, 14 Oct 2023 22:53:11 +0200
Message-ID: <20231014205314.59333-2-hdegoede@redhat.com>
In-Reply-To: <20231014205314.59333-1-hdegoede@redhat.com>
References: <20231014205314.59333-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Export acpi_spi_find_controller_by_adev() so that ACPI glue code which
wants to dynamically create a spi_device using acpi_spi_device_alloc() or
spi_new_device() on a controller, to which the code does not already have
a reference, can find the controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/spi/spi.c       | 5 ++---
 include/linux/spi/spi.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8d6304cb061e..ac6d9b15b2fa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2527,8 +2527,6 @@ static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
 		lookup->mode |= SPI_CPHA;
 }
 
-static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
-
 static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct acpi_spi_lookup *lookup = data;
@@ -4523,7 +4521,7 @@ static int spi_acpi_controller_match(struct device *dev, const void *data)
 	return ACPI_COMPANION(dev->parent) == data;
 }
 
-static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
+struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
 
@@ -4537,6 +4535,7 @@ static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_devic
 
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(acpi_spi_find_controller_by_adev);
 
 static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7f8b478fdeb3..da05488cade8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -867,6 +867,7 @@ extern int devm_spi_register_controller(struct device *dev,
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
 #if IS_ENABLED(CONFIG_ACPI)
+extern struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
 extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 						struct acpi_device *adev,
 						int index);
-- 
2.41.0


