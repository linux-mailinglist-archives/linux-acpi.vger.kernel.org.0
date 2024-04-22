Return-Path: <linux-acpi+bounces-5242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA708ACA2B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 12:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE711F227EF
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62E13D637;
	Mon, 22 Apr 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+wa/HXb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FFC13D607
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780153; cv=none; b=ICArAHB/5c77Dg7GqJOXLBr1tIJFuDNe7PYVAQPleWW52F/+3W/+RRGOHiY7yFSbkDVYjWCw1PMTaN7WnHYMbafSVTp+sm4Jyv9og3JQE7+3/H+dpIt3zXQrR3IZAEOCxpjinmxM4VnddOTCkysbGo/0WPFzVmYPtIqaRNWWrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780153; c=relaxed/simple;
	bh=JRLv+7c6/54HDoGYrbdHXHSK8O4NnP+tTLDS2tZlvxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgYCEMjG2wgg7JykbmTFiA4HaTVB+PXnM2jVSYkDFNtKQJ5wEoFGqhwAwv48cKQWZmmvwN/3TJPiPtC+iUtaw90oRk2RT3afDVIi+XHIvioiOv7fCMkry5Jw8xUCv6GrrZMdD5lXEKS4L6l/3LqGD/yv6IYQ0DmiODuEfStReUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+wa/HXb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCvduDYfaBEzJg7iPTcnkiyhAz7LjPATOqpFPP2ip+k=;
	b=E+wa/HXbsA35G55AUkQz/iabalCCnkW+b4KQdSAhIoekaug0alo1uZq0qf9XE4bqerXtdb
	ZgP332i04PLbCV+pcBJTrIR63Ytrz5wmEYywvfClR8TvW5SfIqYipEBZ7xJ9qeMd/1tnzP
	eqGqQp/XRDeNnJUvL4ey7b87R5N7ZQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Xn71PnciPfS0PSnNXqt9Fg-1; Mon, 22 Apr 2024 06:02:26 -0400
X-MC-Unique: Xn71PnciPfS0PSnNXqt9Fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DDC1811003;
	Mon, 22 Apr 2024 10:02:26 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3508F44049;
	Mon, 22 Apr 2024 10:02:25 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 3/4] iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
Date: Mon, 22 Apr 2024 12:02:17 +0200
Message-ID: <20240422100218.7693-4-hdegoede@redhat.com>
In-Reply-To: <20240422100218.7693-1-hdegoede@redhat.com>
References: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Replace the duplicate ACPI "ROTM" data parsing code with the new
shared acpi_read_mount_matrix() helper.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 45 ++-------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 110591804b4c..ace550b0ba40 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -23,6 +23,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include "acpi-helpers.h"
 #include "bmc150-accel.h"
 
 #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
@@ -386,13 +387,9 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 						   struct iio_mount_matrix *orientation)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	char *name, *alt_name, *label, *str;
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
+	char *name, *alt_name, *label;
 
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
 		alt_name = "ROMK";
@@ -411,43 +408,7 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 		return false;
 	}
 
-	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
-		return false;
-	}
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
-		goto unknown_format;
-
-	elements = obj->package.elements;
-	for (i = 0; i < 3; i++) {
-		if (elements[i].type != ACPI_TYPE_STRING)
-			goto unknown_format;
-
-		str = elements[i].string.pointer;
-		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
-			goto unknown_format;
-
-		for (j = 0; j < 3; j++) {
-			switch (val[j]) {
-			case -1: str = "-1"; break;
-			case 0:  str = "0";  break;
-			case 1:  str = "1";  break;
-			default: goto unknown_format;
-			}
-			orientation->rotation[i * 3 + j] = str;
-		}
-	}
-
-	kfree(buffer.pointer);
-	return true;
-
-unknown_format:
-	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
-	kfree(buffer.pointer);
-	return false;
+	return acpi_read_mount_matrix(dev, orientation, name);
 }
 
 static bool bmc150_apply_dual250e_acpi_orientation(struct device *dev,
-- 
2.44.0


