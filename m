Return-Path: <linux-acpi+bounces-10320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993619FDBB8
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6D7A123A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975B165F18;
	Sat, 28 Dec 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl7ukiSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5C9474
	for <linux-acpi@vger.kernel.org>; Sat, 28 Dec 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735404792; cv=none; b=Gtc4ZdEDpWlx9lb2N6arsggsTt9dl9xqWJ3PP5aTxKC1YKsvLpi93dBzdnoSGpEWpi/202MXE818X6BzkukH6k+8Vq0VnGGM34FMocAXJesQPoyOqQ8ZHMCnnd2q1HF56hZztST68Ow9M0sxIOc6JZj43TnqE7rwB+PjHfrxQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735404792; c=relaxed/simple;
	bh=3AZbGWRtm8Pn9kXsJERDEqOFMe6x+/WRf1OtUIT8GRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyhk6XMEvg1Wy5PY64Redso0kMaqZqFhfF+1+/+AhL9lsGYmc/YhfyYNzDTCeRfnrrOG/D24do+GjzvUVTo+qFQ6vzTISvdpQFRj6zfhPz7MeIOp8dXGX6MW8v7ET4fRdy9YP+u3F0CgbpdyAOAsjC/IxhR/9lgKrzY2TvXUDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zl7ukiSM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735404790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z767iiP+iraJ5xUuiCPg+1Xsko3ekOZqTT4cEWyu3C8=;
	b=Zl7ukiSMxD2EhakOMtSA5sU52tYH8+RJodvn9sTOwf2yAVlio2oD20ZTKfgyTBgoFs0C88
	oMwFms/jkpJEWZvJuwu6ERE6uivfX5Yeg3LMfSsOo/Vw/dIJN4t8uSZFLsCjWlZHtYvJ0X
	+mjdE3z0pfAo3H6JxOgTCPkmMz77BvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-ZJAwLQl8Mn6FunCQvzKW0g-1; Sat,
 28 Dec 2024 11:53:06 -0500
X-MC-Unique: ZJAwLQl8Mn6FunCQvzKW0g-1
X-Mimecast-MFC-AGG-ID: ZJAwLQl8Mn6FunCQvzKW0g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09F21195608C;
	Sat, 28 Dec 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B6E83000197;
	Sat, 28 Dec 2024 16:53:02 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: acpi_dev_irq_override(): Check DMI match last
Date: Sat, 28 Dec 2024 17:52:53 +0100
Message-ID: <20241228165253.42584-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

acpi_dev_irq_override() gets called approx. 30 times during boot (15 legacy
IRQs * 2 override_table entries). Of these 30 calls at max 1 will match
the non DMI checks done by acpi_dev_irq_override(). The dmi_check_system()
check is by far the most expensive check done by acpi_dev_irq_override(),
make this call the last check done by acpi_dev_irq_override() so that it
will be called at max 1 time instead of 30 times.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ab4c0e0b6b8e..7d6537ea176f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -678,11 +678,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
 		const struct irq_override_cmp *entry = &override_table[i];
 
-		if (dmi_check_system(entry->system) &&
-		    entry->irq == gsi &&
+		if (entry->irq == gsi &&
 		    entry->triggering == triggering &&
 		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
+		    entry->shareable == shareable &&
+		    dmi_check_system(entry->system))
 			return entry->override;
 	}
 
-- 
2.47.1


