Return-Path: <linux-acpi+bounces-7817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869395E396
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36701F2144A
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC91E492;
	Sun, 25 Aug 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj1fOwjb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D54A07
	for <linux-acpi@vger.kernel.org>; Sun, 25 Aug 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724592219; cv=none; b=H0ECSRd50ToxhEKJcdaa6oHeHkcsstU0TeowlTugcuNCRoslWICWc04CQdpg3rD5l2EfG+ogsHkVzbwugNZj/wjFmY2ChCP173mYly/gKKuSUdihQme81NIfNupc4K7JIU3zcpnm0qWJf0A3v3CFpjh0D8YdviN7LJPwHnhH0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724592219; c=relaxed/simple;
	bh=aHdhGfODNNcWwh53d7HRkQYI5rjY9UrZRnsP8n7VNrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzSdmzKlRc9ziuROd38EB1GSGfsWy1M74hQaDaZ41K+vAYMODcCT3ScEVxoZywM3TOZJ2vreUPqDURwBZ0h/xkt45ByeGTQgDEBPTW6CBqLjH8sYtc3vnjQFSWXdKuv4kTR7h7Lwq7ifrmtzwVkfrhnnI3jWxnlu/Kpt5vgik0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj1fOwjb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724592216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+tsO+Z6raV1yL84B/cNPonA8m0Wj0REBTT1SQupbVs=;
	b=Bj1fOwjbs8IAvtvwSFuvl5W7JPocq1TijrxBz1WKPJDFysFBT6+4deLxltgak9ZdtpwDkO
	k5kFmXdxcA3dT7sortpQ1KqRSTTXlBw4tGKQx+9wO/S/rdhvaNbLI5sIGnfUXZedgUdNHd
	+jRBro18ch4G9m8npNP6nTDYA7f10x0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Q9hu_1KrOsqeAMbp8uFMyw-1; Sun,
 25 Aug 2024 09:23:33 -0400
X-MC-Unique: Q9hu_1KrOsqeAMbp8uFMyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 045F31956080;
	Sun, 25 Aug 2024 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7486B19560AA;
	Sun, 25 Aug 2024 13:23:30 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: video: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Sun, 25 Aug 2024 15:23:21 +0200
Message-ID: <20240825132322.6776-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 674b9db7a1ef..e33ab5a2f489 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -896,7 +896,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 /* Lenovo Yoga Tab 3 Pro YT3-X90F */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 		DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.46.0


