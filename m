Return-Path: <linux-acpi+bounces-1834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7927FA699
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05061C20B49
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07436AE7
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhhLJflG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC6191
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701095868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn2QY9BkzTsBxRkgzM3InhgNVD/4YvY9FZFSMQPAJn0=;
	b=bhhLJflGlUpTTjEy3qL8/6PypJJv3yi/5egroWe4nM/oKaYRfFgghTCasO0zzuAVs7sT/I
	KvpB00oc4XYTkToUZpqB7xiCn+S15wHQStneDg7N1E1WxqI12OG5qVh6oz6b3ggp+u/iSF
	xnBBvJdXFvPKPdEhwio6elDMKe23rbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-DO237glwNUe4j5hIC_HhZA-1; Mon, 27 Nov 2023 09:37:44 -0500
X-MC-Unique: DO237glwNUe4j5hIC_HhZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 591AF866DCB;
	Mon, 27 Nov 2023 14:37:44 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6639420268D2;
	Mon, 27 Nov 2023 14:37:43 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	"6 . 6+" <stable@vger.kernel.org>
Subject: [PATCH 1/1] ACPI: video: Use acpi_video_device for cooling-dev driver data
Date: Mon, 27 Nov 2023 15:37:41 +0100
Message-ID: <20231127143741.5229-2-hdegoede@redhat.com>
In-Reply-To: <20231127143741.5229-1-hdegoede@redhat.com>
References: <20231127143741.5229-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The acpi_video code was storing the acpi_video_device as driver-data
in the acpi_device children of the acpi_video_bus acpi_device.

But the acpi_video driver only binds to the bus acpi_device.
It uses, but does not bind to, the children. Since it is not
the driver it should not be using the driver_data of the children's
acpi_device-s.

Since commit 0d16710146a1 ("ACPI: bus: Set driver_data to NULL every
time .add() fails") the childen's driver_data ends up getting set
to NULL after a driver fails to bind to the children leading to a NULL
pointer deref in video_get_max_state when registering the cooling-dev:

[    3.148958] BUG: kernel NULL pointer dereference, address: 0000000000000090
<snip>
[    3.149015] Hardware name: Sony Corporation VPCSB2X9R/VAIO, BIOS R2087H4 06/15/2012
[    3.149021] RIP: 0010:video_get_max_state+0x17/0x30 [video]
<snip>
[    3.149105] Call Trace:
[    3.149110]  <TASK>
[    3.149114]  ? __die+0x23/0x70
[    3.149126]  ? page_fault_oops+0x171/0x4e0
[    3.149137]  ? exc_page_fault+0x7f/0x180
[    3.149147]  ? asm_exc_page_fault+0x26/0x30
[    3.149158]  ? video_get_max_state+0x17/0x30 [video 9b6f3f0d19d7b4a0e2df17a2d8b43bc19c2ed71f]
[    3.149176]  ? __pfx_video_get_max_state+0x10/0x10 [video 9b6f3f0d19d7b4a0e2df17a2d8b43bc19c2ed71f]
[    3.149192]  __thermal_cooling_device_register.part.0+0xf2/0x2f0
[    3.149205]  acpi_video_bus_register_backlight.part.0.isra.0+0x414/0x570 [video 9b6f3f0d19d7b4a0e2df17a2d8b43bc19c2ed71f]
[    3.149227]  acpi_video_register_backlight+0x57/0x80 [video 9b6f3f0d19d7b4a0e2df17a2d8b43bc19c2ed71f]
[    3.149245]  intel_acpi_video_register+0x68/0x90 [i915 1f3a758130b32ef13d301d4f8f78c7d766d57f2a]
[    3.149669]  intel_display_driver_register+0x28/0x50 [i915 1f3a758130b32ef13d301d4f8f78c7d766d57f2a]
[    3.150064]  i915_driver_probe+0x790/0xb90 [i915 1f3a758130b32ef13d301d4f8f78c7d766d57f2a]
[    3.150402]  local_pci_probe+0x45/0xa0
[    3.150412]  pci_device_probe+0xc1/0x260
<snip>

Fix this by directly using the acpi_video_device as devdata for
the cooling-device, which avoids the need to set driver-data on
the children at all.

Fixes: 0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add() fails")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9718
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5eded14f8853..7cd91e85c62a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -253,8 +253,7 @@ static const struct backlight_ops acpi_backlight_ops = {
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
 			       unsigned long *state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 
 	*state = video->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
 	return 0;
@@ -263,8 +262,7 @@ static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
 static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
 			       unsigned long *state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 	unsigned long long level;
 	int offset;
 
@@ -283,8 +281,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
 static int
 video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 	int level;
 
 	if (state >= video->brightness->count - ACPI_VIDEO_FIRST_LEVEL)
@@ -1125,7 +1122,6 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 
 	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-	device->driver_data = data;
 
 	data->device_id = device_id;
 	data->video = video;
@@ -1747,8 +1743,8 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	device->backlight->props.brightness =
 			acpi_video_get_brightness(device->backlight);
 
-	device->cooling_dev = thermal_cooling_device_register("LCD",
-				device->dev, &video_cooling_ops);
+	device->cooling_dev = thermal_cooling_device_register("LCD", device,
+							      &video_cooling_ops);
 	if (IS_ERR(device->cooling_dev)) {
 		/*
 		 * Set cooling_dev to NULL so we don't crash trying to free it.
-- 
2.43.0


