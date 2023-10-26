Return-Path: <linux-acpi+bounces-1022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147E7D84D1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C2282073
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DF52EAEA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiVJTlfw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32C2D049
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 13:53:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3B6BD
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698328398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0FdxtQ3dQEGH7WLEFe+olpxwuofCY8+lrXJ9vtnZ3wc=;
	b=QiVJTlfwC7jW87EZYIdXQPlGwekP2YGlVWJojZqi34hcFQNPhycDEg/YhOGkkoSoT5mllV
	BE/BRTVcROKGTQ/myW0CpvUiLw2HHHNDrtHMq/XIMS9LJ2TlF09Yt+GeT2KOwO1wLm2cVN
	aLR8NMV0WR/xxhmM0O0EhQ18wpFr5FY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-aIDz7ZLnM8iulsLYLhzndw-1; Thu,
 26 Oct 2023 09:53:07 -0400
X-MC-Unique: aIDz7ZLnM8iulsLYLhzndw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8DB61C03D98;
	Thu, 26 Oct 2023 13:53:06 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB4961C060AE;
	Thu, 26 Oct 2023 13:53:05 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Add comment about acpi_video_backlight_use_native() usage
Date: Thu, 26 Oct 2023 15:53:03 +0200
Message-ID: <20231026135303.48757-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add a comment explaining that acpi_video_backlight_use_native() MUST
only be used by GPU drivers and that it must NOT be used on other places.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The main reason for writing this patch is that some recent submitted
patches actually were using acpi_video_backlight_use_native() wrong.
---
 include/acpi/video.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index 4230392b5b0b..3d538d4178ab 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -75,6 +75,15 @@ static inline enum acpi_backlight_type acpi_video_get_backlight_type(void)
 	return __acpi_video_get_backlight_type(false, NULL);
 }
 
+/*
+ * This function MUST only be called by GPU drivers to check if the driver
+ * should register a backlight class device. This function not only checks
+ * if a GPU native backlight device should be registered it *also* tells
+ * the ACPI video-detect code that native GPU backlight control is available.
+ * Therefor calling this from any place other then the GPU driver is wrong!
+ * To check if GPU native backlight control is used in other places instead use:
+ *   if (acpi_video_get_backlight_type() == acpi_backlight_native) { ... }
+ */
 static inline bool acpi_video_backlight_use_native(void)
 {
 	return __acpi_video_get_backlight_type(true, NULL) == acpi_backlight_native;
-- 
2.41.0


