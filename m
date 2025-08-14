Return-Path: <linux-acpi+bounces-15683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CBB26968
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA6B189B675
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A3321445;
	Thu, 14 Aug 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFl+K7C6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD29321440
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181094; cv=none; b=POEqb8QKwj77zQy6RRXn8cARqOctLkgk7j53YDm4oD3cnPKK8+i6M5TWymPduDdfhGbkIapelRhGQg82hhnp1rZse/k3KlI5aD+H6SWdWoK550LkrAZ7RX96zH5X54suO3MKlu3srfp+UoRgK+9cf3Hy3hwn/yKfwDcfC3fqc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181094; c=relaxed/simple;
	bh=fzicJF7q4dLRrPHjJsfFWmWacz7FUNgbf3Z1XpBzzQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gBKHNpv0rVheFuphgHM+3i/EnaWBAw594/2C1160//yTFCHyB9a1FyPp3OCM/8GdtEIg29dxp3zsZcLtNTvQs2WYeffs/FWsMUO7vnMtcSLxsrd+866CuD1AovtxLsOqgxRRLSsJvCx8jcRNdbdB4sTXEOK5TPu0P/C0gRTWRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFl+K7C6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755181091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bNKOtXjUgCmr7vZC9Pfp3UyUNOWyPhcYtzWE4DBiIqI=;
	b=XFl+K7C6AHp+6X0GQOAvCWz5x2+zdZMy1m1LvqmOByKUmKg35odXhnpYBg72vuFqPOzmzg
	BoMumTZYt7k58CfRQPPHtyNetXJSOn5GYO5MbQwSXxKbngUIoALka/prh5SEm1lidtLmNa
	mgj6sl9tYaqKGTQjXc+TpaDOjZMwk4A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ftt7xQQsN2aAGreQBuMtOA-1; Thu,
 14 Aug 2025 10:18:08 -0400
X-MC-Unique: ftt7xQQsN2aAGreQBuMtOA-1
X-Mimecast-MFC-AGG-ID: ftt7xQQsN2aAGreQBuMtOA_1755181086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15590180034F;
	Thu, 14 Aug 2025 14:18:06 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98D7D19327C0;
	Thu, 14 Aug 2025 14:18:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	robin.murphy@arm.com,
	rafael@kernel.org,
	bhelgaas@google.com,
	jgg@ziepe.ca,
	lpieralisi@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	jean-philippe@linaro.org,
	jsnitsel@redhat.com
Subject: [RFC] iommu: Fix virtio-iommu probing
Date: Thu, 14 Aug 2025 16:17:58 +0200
Message-ID: <20250814141758.2140641-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") broke virtio-iommu probing and no iommu group are
produced anymore.

When probe_iommu_group() gets called viommu_probe_device() fails
because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
So it seems we need to restore the original iommu_probe_device
call site in acpi_iommu_configure_id() to get a chance to probe
the device again.

Maybe this defeats the whole purpose of the original commit but
at least it fixes the virtio-iommu probing.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I also tested smmu probing and this seems to work fine.
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..9f4efa8f75a6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = viot_iommu_configure(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * iommu_probe_device() call for dev, replay it to get things in order.
+	 */
+	if (!err && dev->bus)
+		err = iommu_probe_device(dev);
+
 	return err;
 }
 
-- 
2.49.0


