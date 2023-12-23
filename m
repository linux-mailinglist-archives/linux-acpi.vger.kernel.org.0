Return-Path: <linux-acpi+bounces-2604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7534881D4B9
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FB81C210F8
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B028DF5C;
	Sat, 23 Dec 2023 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OloEaBps"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA611CB0
	for <linux-acpi@vger.kernel.org>; Sat, 23 Dec 2023 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703343431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=556cidxl5UMk1OJZBL59R3nap5oo8emLN3+LeOkOKpw=;
	b=OloEaBps+IjxuVf+l1O7jXhlvyDQf/84dRpcYxVI/cWsCyKFKwumfV3/shNLGEjouhPNvI
	yoGZiv6Vj+FJ9urSXzVjEZofrfGRpOc1UN9D5Zdc9ZYsafogEmVQgOpns4KHXFPPoALt+Y
	cIRq3IBeGOCnsUK1u+Hz7eaT0ssFQE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-UIWOS5TBMKeijpq-DVYzkw-1; Sat, 23 Dec 2023 09:57:08 -0500
X-MC-Unique: UIWOS5TBMKeijpq-DVYzkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93247185A780;
	Sat, 23 Dec 2023 14:57:07 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B82C2026D66;
	Sat, 23 Dec 2023 14:57:06 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	Luis Acuna <ldacuna@gmail.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	All applicable <stable@vger.kernel.org>
Subject: [PATCH] ACPI: resource: At another DMI match for the TongFang GMxXGxx
Date: Sat, 23 Dec 2023 15:57:06 +0100
Message-ID: <20231223145706.26218-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The TongFang GMxXGxx, which needs IRQ overriding for the keyboard to work,
is also sold as the Eluktronics RP-15 which does not use the standard
TongFang GMxXGxx DMI board_name.

Add an entry for this laptop to the irq1_edge_low_force_override[] DMI
table to make the internal keyboard functional.

Reported-by: Luis Acuna <ldacuna@gmail.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note reportedy by private email so not Closes tag
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 9bd9f79cd409..c3536c236be9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
-- 
2.41.0


