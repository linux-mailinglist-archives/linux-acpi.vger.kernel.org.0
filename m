Return-Path: <linux-acpi+bounces-8577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D86991AD8
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4B1C21976
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F562168483;
	Sat,  5 Oct 2024 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMKpIj/Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F80161901
	for <linux-acpi@vger.kernel.org>; Sat,  5 Oct 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163728; cv=none; b=UBMk1ifBkzvN3JfDxt5ACWD7c1nHWDpSQe7gZkZwlKmXY+cdts9YK8tlXhdBEFqHQ09MByYh5BognYREmMRTsgbh+mzFTsIQPOluD+c1PqY7dT4NqAB05CQrDJ9ghuNw2HXk7gCaRI6GzVLs4uLUjf6JVqfosSaVk0oEcHhqz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163728; c=relaxed/simple;
	bh=z1pxeO8mVQwKBIFqKFnh/1VLQPZk/KQ7VV5XBPnimdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9YcVos8bB2TxQO+wkFx4cNTMl2xmXUrS4XS/FLLboCl65ZeWXAV4ekD0SG2HUoeLL6FMVrpDKknEaHnM1WFNlaDTJiAuRoDqmwtRhb/1zzP9nguOov8lklZhQ/xqMO0KnX8qCdZacs2IkHYCjhHbllK0s/D3bV8bG+hNe3KPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMKpIj/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728163725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeNXoeL41sk20UPqbv+HuwE52k5lAYr7hEhCphc5XHM=;
	b=YMKpIj/QgPTjxHkl4IGc0EgeaMm8lqHYqGpFYRVS0ejN4tZY3Y7GnuFHpPS6WuQvSrdGb6
	OG9uFJtTWK31lHZQ15jRsCB/ZvLHmZrpHImsSSJJ2KEPX4w5acRAVQ9SZFMTAvK/2wIiLt
	6DM5oCpMD5qg78dLc+J2AwnCQTM1c7g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-2KB21bf5NsS76lIy4euc_w-1; Sat,
 05 Oct 2024 17:28:43 -0400
X-MC-Unique: 2KB21bf5NsS76lIy4euc_w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89B541977009;
	Sat,  5 Oct 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.19])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBA0A1956088;
	Sat,  5 Oct 2024 21:28:40 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/4] ACPI: resource: Fold Asus ExpertBook B1402C* and B1502C* DMI quirks together
Date: Sat,  5 Oct 2024 23:28:18 +0200
Message-ID: <20241005212819.354681-4-hdegoede@redhat.com>
In-Reply-To: <20241005212819.354681-1-hdegoede@redhat.com>
References: <20241005212819.354681-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Asus has 2 ExpertBook B1402C models:

B1402CBA with 12th gen Intel CPUs
B1402CVA with 13th gen Intel CPUs

Fold the 2 DMI quirks for these into a single quirk to reduce the number
of quirks.

Likewise Asus has 3 ExpertBook B1502C models:

B1502CBA with 12th gen Intel CPUs
B1502CGA with 12th gen Intel N-series CPUs
B1502CVA with 13th gen Intel CPUs

Fold the 3 DMI quirks for these into a single quirk to reduce the number
of quirks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0eb52e372467..2c17d3ea4d3c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -448,40 +448,19 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus ExpertBook B1402CBA */
+		/* Asus ExpertBook B1402C* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402C"),
 		},
 	},
 	{
-		/* Asus ExpertBook B1402CVA */
+		/* Asus ExpertBook B1502C* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502C"),
 		},
 	},
-	{
-		/* Asus ExpertBook B1502CBA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
-		},
-	},
-	{
-		/* Asus ExpertBook B1502CGA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
-		},
-	},
-        {
-                /* Asus ExpertBook B1502CVA */
-                .matches = {
-                        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-                        DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
-                },
-        },
 	{
 		/* Asus ExpertBook B2402 (B2402CBA / B2402FBA / B2402CVA / B2402FVA) */
 		.matches = {
-- 
2.46.2


