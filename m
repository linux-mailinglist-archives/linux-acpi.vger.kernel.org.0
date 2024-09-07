Return-Path: <linux-acpi+bounces-8199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C942B970231
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C337B231FC
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBCA158DCA;
	Sat,  7 Sep 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLxDrGRR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02712E5B
	for <linux-acpi@vger.kernel.org>; Sat,  7 Sep 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713068; cv=none; b=b/fX7ZyQgY//aWX3Nzk88ouBExG+TH3GMk0L/RtW685ZWMNc5See0YLxFgzBKsGY8Rg37sg/D779yrVaxNqJ1G/x0lv9SIOgssp9rH6T4mYVBs3K0COBX28xhNBASRZnaxyaumo+Fh9yS7A/tj54gpjFjdrvdu8rsRoWJmhC42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713068; c=relaxed/simple;
	bh=rVGEgQ/ex6trJPLbeQpdy9pqiT/8UsbHI8OL5LkbdGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iARe1lMdB28OvGivKoBiXYEs+uPu/yp2xuv3iXERdZyDFgEmk/Q8neaidt3XZ87uwORuLG8pDUuA15DV8JPHO7e23c9ml/zKT5oYWSdJVWHPc4iytUjfy9ZY8Z80j24zBkrWRBziJbDR1MiyBQFxzM1D8FdGHRmcbZep3t/V0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLxDrGRR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725713065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZk/YyKxn20Una5OSIl1j3J7mGBXwUDwOMDyPnYEUzk=;
	b=PLxDrGRRjw4y6Tb8HIoeAtMUzZUKAyP0lSnSP6ouftX5uWuwhIilyGbfwYBvBEYaY7Lg4r
	iP5sFiBFAJh0uNyEkXoPYJ/eQNVlwzweoafaycgB3oA6Z3US3na6zUNIqMVBEiVS6LV9H8
	oS+0mocuRR8QV0ZQgYMm71vE6x5fmas=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-bePs7cZ_MhW0vxfZwuAocw-1; Sat,
 07 Sep 2024 08:44:23 -0400
X-MC-Unique: bePs7cZ_MhW0vxfZwuAocw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAE841956088;
	Sat,  7 Sep 2024 12:44:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D2FC195608A;
	Sat,  7 Sep 2024 12:44:20 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
Date: Sat,  7 Sep 2024 14:44:19 +0200
Message-ID: <20240907124419.21195-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The Panasonic Toughbook CF-18 advertises both native and vendor backlight
control interfaces. But only the vendor one actually works.

acpi_video_get_backlight_type() will pick the non working native backlight
by default, add a quirk to select the working vendor backlight instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e33ab5a2f489..68afdab5d3ab 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -254,6 +254,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PCG-FRV35"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Panasonic Toughbook CF-18 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Matsushita Electric Industrial"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
+		},
+	},
 
 	/*
 	 * Toshiba models with Transflective display, these need to use
-- 
2.46.0


