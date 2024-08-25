Return-Path: <linux-acpi+bounces-7818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2795E397
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B420281A7F
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0913DDB6;
	Sun, 25 Aug 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egBZnGVU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B54A07
	for <linux-acpi@vger.kernel.org>; Sun, 25 Aug 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724592221; cv=none; b=BYaSnw+j18kzEmKaf0LhUEeE0omIOkbtTjSeC3nX7A7nUCYPAmLPMhpl8ibT7w3sY4CnmsMn48GKn7S6s0Fadxkz+weOnB1stSvGNeO90I3aFirQHhbJ+UF/tVKAkWKrVQ1UVz5mlUO3AfroZkI4f/f6gsFdbOd9nQetINTG7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724592221; c=relaxed/simple;
	bh=OmWVn+OQCtb8CjW2htsP9xpL5FBb5CbnWpSceiEkNRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biXTC4bxMBlM9/ugztmB6N5uc4ryOKX5IGYWySIbGC7zEy4PwsnlSurz2WN7kKXhNsbmpVkyymKmduIQwSlingG0IOZgZrzTRmqUSYhqoPCkpo76BoZx86ItIjNBF1PQip/klE3D1tx0uEG3BXOEZezooKer/wzr6cRc1BZipPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egBZnGVU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724592218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIq9QkLjz1Dy0Cn9xH1qnZVB8Ii0LGT5+ESUoyPfXro=;
	b=egBZnGVU/rttdRDhgfbFbJjZHe4p9ayFIP3uBuA/f2/JB7azaZyWSisFFFfomAgDakh9oF
	20sj5OEc2tPugy8Fx+RQA3yO5+fXPt+YeqwpGFtX60YOMySKPe229bBprokieFKqa/kLzy
	rdsKKsQcuxWERkrgyJrLtSc/JqvBFj4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-98aY--xTOkifBqqLV4AnoQ-1; Sun,
 25 Aug 2024 09:23:35 -0400
X-MC-Unique: 98aY--xTOkifBqqLV4AnoQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 106B3195608A;
	Sun, 25 Aug 2024 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A55D19560AA;
	Sun, 25 Aug 2024 13:23:32 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: x86: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Sun, 25 Aug 2024 15:23:22 +0200
Message-ID: <20240825132322.6776-2-hdegoede@redhat.com>
In-Reply-To: <20240825132322.6776-1-hdegoede@redhat.com>
References: <20240825132322.6776-1-hdegoede@redhat.com>
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
 drivers/acpi/x86/utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ab2b5fa83e1f..6af546b21574 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -355,7 +355,6 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		/* Lenovo Yoga Tab 3 Pro X90F */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-- 
2.46.0


