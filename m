Return-Path: <linux-acpi+bounces-8579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797EB991ADA
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 23:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC35B1C216CB
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC2153BF6;
	Sat,  5 Oct 2024 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2UFwrg2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147516132F
	for <linux-acpi@vger.kernel.org>; Sat,  5 Oct 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163731; cv=none; b=mO6uZp+Pg64Ez0/9pw+sEOaYEaSG5sMLWsx+4Rdg+T9O3VbrZoxUUnxnYLzkIgS6wuYYSPISE8fNesFjJUEgxDNibSEDW7WZYAo/pcIWka6xkOGVy/lElck45NtqTAmOwRSTcs7hZ88GrexrukVGRIBaQh2dmoQgxVoVX/Xt/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163731; c=relaxed/simple;
	bh=bSCJyJAhuJcf54t7nsFA90nloDqvtd2uUKWjO6PXuZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFHzGwYiCgBgL7cofQYPyf5f/SRip7t+MlTTZ2byFnvk0ubmOpm9Eb+0Nv1gNXoDL9dhaonZAFAqdvDr5fJ5Wklu6cEz7rGL2POXuGWwEF7uDWdCb6GLMc5+KAd38i49jgNvOzub0sg2tdSoJvCbnha++PuWUNWREVC/kvJxXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2UFwrg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728163728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhlNoDtLM5PX7ZBKdCGWhaCIQpEQGnyj7EDVKAuZMFo=;
	b=Y2UFwrg2iEZHrxOxTlohWe0JJEjhUiNQm1CH3ETziHCkDd19g+skllmk7wvjxwhBhftiZN
	TbYGksnd4bFYTiR7c02qt2XeSgcHnR4qaWr3e01oVDDM58hoH2mSJAi8jK7yRE4Jgq1jYK
	mu6fcxgStPXN6t9FVQn4p0aQq7d0dms=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-LyYp-TgtNi6APEHHwKavRw-1; Sat,
 05 Oct 2024 17:28:45 -0400
X-MC-Unique: LyYp-TgtNi6APEHHwKavRw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61DFC19560A3;
	Sat,  5 Oct 2024 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.19])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D24DE1956088;
	Sat,  5 Oct 2024 21:28:42 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/4] ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together
Date: Sat,  5 Oct 2024 23:28:19 +0200
Message-ID: <20241005212819.354681-5-hdegoede@redhat.com>
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

Asus Vivobook Pro 15 OLED comes in 3 N6506M* models:

N6506MU: Intel Ultra 9 185H, 3K OLED, RTX4060
N6506MV: Intel Ultra 7 155H, 3K OLED, RTX4050
N6506MJ: Intel Ultra 7 155H, FHD OLED, RTX3050

Fold the 3 DMI quirks for these into a single quirk to reduce the number
of quirks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2c17d3ea4d3c..129bceb1f4a2 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -490,24 +490,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook Pro N6506MV */
+		/* Asus Vivobook Pro N6506M* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MU */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MJ */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
 		},
 	},
 	{
-- 
2.46.2


