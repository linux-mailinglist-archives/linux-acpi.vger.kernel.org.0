Return-Path: <linux-acpi+bounces-8457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15229886CF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FDE1C22AD6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA59138490;
	Fri, 27 Sep 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi4G7z47"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8A8493
	for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446576; cv=none; b=IOEi2EGVIfrodzAiYGm9+3t8qZc+hfQurELnWtwAhEXpJ2ipZAPH+lMyxFzH02ShBOLgyyiIWXCNqqC12r4aGxEx6aeDqPiqTJ0sTjb0os/9ibARfxVnV3f+XscwG/jVlyqX5CGOJJY0p5NvJDNfIZKZLMosvvBwUsJUG9HYOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446576; c=relaxed/simple;
	bh=nFOjVQ+Q6pI+KtmxTBhIGG74BM7aRQGhqhPG57v7/cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JW/JDdAsHejDRmDyouxHM6iiIiyhFbuflhiGOf3H9274p6gNWpjyRAntjATptlcXI+OThZrVdhy95S/9n5fk+NeABawSTsiEXql670Juo4lLvjAZmeVP+Krc/zZ0JI3Dt975f2zsA9AF1retZ5Ptpe8q6dtV4uL9aGIpcXGHZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bi4G7z47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TFW1BIJrUCI5UKgWkQUSCNzAomMKqYJA8V/kv/ybMls=;
	b=Bi4G7z47Uz6BP2Z2Jq6MpOtSB8hMLcOOFOTp4ggks99kzSSxJNz38c9ynk4tsDJSqWTZDp
	rfjRDj5B4pCb2SjUh8bSSQm6L4IPVb2VVn5rOPGgLHlxsIk2kALpEaYmjpkssrFklnpm9p
	4gMS3L2NZOEhlIiXeXoRKUBVXQRHAd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-qLzXGBzjNPyoLCA1zTA_vw-1; Fri,
 27 Sep 2024 10:16:12 -0400
X-MC-Unique: qLzXGBzjNPyoLCA1zTA_vw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1E5B18F36B2;
	Fri, 27 Sep 2024 14:16:09 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EC843003E4D;
	Fri, 27 Sep 2024 14:16:07 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ben Mayo <benny1091@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tamim Khan <tamim@fusetak.com>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/4] ACPI: resource: Remove duplicate Asus E1504GAB IRQ override
Date: Fri, 27 Sep 2024 16:16:03 +0200
Message-ID: <20240927141606.66826-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit d2aaf1996504 ("ACPI: resource: Add DMI quirks for ASUS Vivobook
E1504GA and E1504GAB") does exactly what the subject says, adding DMI
matches for both the E1504GA and E1504GAB. But DMI_MATCH() does a substring
match, so checking for E1504GA will also match E1504GAB.

Drop the unnecessary E1504GAB entry since that is covered already by
the E1504GA entry.

Fixes: d2aaf1996504 ("ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA and E1504GAB")
Cc: Ben Mayo <benny1091@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8a4726e2eb69..1ff251fd1901 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -511,19 +511,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook E1504GA */
+		/* Asus Vivobook E1504GA* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
 		},
 	},
-	{
-		/* Asus Vivobook E1504GAB */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
-		},
-	},
 	{
 		/* Asus Vivobook Pro N6506MV */
 		.matches = {
-- 
2.46.0


