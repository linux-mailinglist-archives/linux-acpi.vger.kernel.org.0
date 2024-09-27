Return-Path: <linux-acpi+bounces-8460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E09886D5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C411F21C7F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEE13C689;
	Fri, 27 Sep 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES45IAOz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E21386D1
	for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446582; cv=none; b=QpBvgx4BJBSJ8yDfOzNAFt74hk5qetybtqJyu/0eMsF72/wGpGhHCnkdXR7IbQ/rKIv7PS9e5ixi1fItZN5d1k5KhU1KQFTgIyrQwsNzkEry+6UE/jcYK/h2FGjjshEj2zexptjyFHjzuIaEslXiVht3U2VXwx/eS1ZF5VeM93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446582; c=relaxed/simple;
	bh=lgnNlVYyaY1Gq35epLXc2xk3UmcREDNwbqplkuqtrxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JexQj2cjN23e10gBNKYZ3jYfqL7SzaKhJDN3jlNsKUmQAIY3ZcmCuE+w8YKqdHL7mbV1GIj9xXV42hhmrOadP+OT1SOrxgtb6S9duORYnUV1DHhviMdKBmNYnHtsuJJ1DGQ15Mczn/sHPzL7SMlYH/CK2RwVtiB4shyYfyBDa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES45IAOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nhcvv20+83wxqlmldyHBKA2HMfVVTDyvB5SLewi9B8=;
	b=ES45IAOz+KZdrINPWRt9ZZ1AMbakHDma+Aa5RlDe7GpHBWxPFP4XFJSPsfg9nUbdp9gTH2
	3V7H+7czcCmSnYScrzJLmYQJm7QGwxlpawthVjpDBHKWkSJf/eTGzKKQfpBFgbdqeeXZth
	t0UwEbsVxWOOkyDJV9xLYu0QLapR/as=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-_N-DxtUUMKCx3hI8arBe1Q-1; Fri,
 27 Sep 2024 10:16:19 -0400
X-MC-Unique: _N-DxtUUMKCx3hI8arBe1Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1193518B0960;
	Fri, 27 Sep 2024 14:16:18 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD1A73003FD2;
	Fri, 27 Sep 2024 14:16:15 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ben Mayo <benny1091@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tamim Khan <tamim@fusetak.com>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
Date: Fri, 27 Sep 2024 16:16:06 +0200
Message-ID: <20240927141606.66826-4-hdegoede@redhat.com>
In-Reply-To: <20240927141606.66826-1-hdegoede@redhat.com>
References: <20240927141606.66826-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Like other Asus ExpertBook models the B2502CVA has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the B2502CVA to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217760
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8e672790ac51..3d74ebe9dbd8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B2502CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
+		},
+	},
 	{
 		/* Asus Vivobook Go E1404GA* */
 		.matches = {
-- 
2.46.0


