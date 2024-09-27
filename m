Return-Path: <linux-acpi+bounces-8459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB9F9886D4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849411C214FE
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11D13A879;
	Fri, 27 Sep 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGU9Grl8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8113AA47
	for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446582; cv=none; b=EawtcTl2HGRp7C6psscsx73BED7vdafWTMlMQiTA10VK4mUOCMWfxaps2lqe7wUZFCrIEDp24+6/t8lNnArmo60IKyvw/22b8ORjzsNJT+Ux6aA9ubiJgP0lZLemzTTnvj0CJB8r7bldTj3Y3mILDDcXFNis2Ayo9h3qfm6PVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446582; c=relaxed/simple;
	bh=gh9rcBnLoktcwNOQG1qG234HpzZYoZyvaM4Y8zNBXeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOVwZ/KLSmPxKy01YyT4koAZskStHJNLrAKeWif1SBTXyE5GcfQrYemWlKwiQJfK9VTEEHn5FAWMeuojTmvrR6YOTDhY5zMr+7TvEqmEqfWZxasoiZF2+n/5s6wyL4WfDhvG42tQU7Ru44bhVRV5CGgzMWEZyTOMeUJTTcSlzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGU9Grl8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pePjaCmWorVHVAoQp30DP/JCU/QFnyFXqgGyMCgWztE=;
	b=FGU9Grl8I0hkdFs9lNObaHiv+cdcljRLTrAjDvwr+rrE8dlKBlATHkkaSgWlveuLdVjRBz
	mRweQu8UACO6RgK1fKuQnTWRjcRlKznZ/QMtQIY3EG4Pfes6KoorUAKqqNbXjMGhDgi5In
	ynGnMZ/DGafqh7elypGPb+TuT7I/iSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-y9lu6ccROz-cLhUoNGZrVA-1; Fri,
 27 Sep 2024 10:16:17 -0400
X-MC-Unique: y9lu6ccROz-cLhUoNGZrVA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 751CF18F377F;
	Fri, 27 Sep 2024 14:16:15 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE5AB3003DEC;
	Fri, 27 Sep 2024 14:16:12 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ben Mayo <benny1091@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tamim Khan <tamim@fusetak.com>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	Lamome Julien <julien.lamome@wanadoo.fr>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
Date: Fri, 27 Sep 2024 16:16:05 +0200
Message-ID: <20240927141606.66826-3-hdegoede@redhat.com>
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

Like other Asus Vivobook models the X1704VAP has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the X1704VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Reported-by: Lamome Julien <julien.lamome@wanadoo.fr>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1078696
Closes: https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dfe108e2ccde..8e672790ac51 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1704VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
+		},
+	},
 	{
 		/* Asus ExpertBook B1402CBA */
 		.matches = {
-- 
2.46.0


