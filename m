Return-Path: <linux-acpi+bounces-10216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC769F9942
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1B51606E7
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305C21A45A;
	Fri, 20 Dec 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3mWZdQk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA7143895
	for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718443; cv=none; b=BLPecqAbaQC0JlslfX2zc2GQIABwvsCSBHvZTHJnPFq9BZQp1UvS+WJVgNm3mTn2HRLFReT2RvdEavmAGJTgHGHiMSGCmwDC2NcPmITdqc5imTZUWo8mLcKO2qRZ4Q+HwpgCE5ik6Ivqg8hT+Y906ldfHYmUvT910Tl2304coF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718443; c=relaxed/simple;
	bh=D+422xzYfNbceghs9iP1357co6BAuS7mDh4KB0sBq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+VJtlN+dvmcD1yjyxod4a5zosEdr/vyUwT1NoZRUO7+okQmuA3SyVY6UtNpuz6n6Oz0EWpz2chNOsAQpPRaznWev6DOO+N5S2RTaAg7DjblGIBZdByh1P/alM4WzCQEK9xKyTP97eTcjrVYKSpitYxHEOfWIB6g1PvvyJ43RUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3mWZdQk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734718440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+E/+0LM2lE7K2vZEgFblryD/86he2sGF+A9H+0OMLmM=;
	b=Q3mWZdQk5BFy0KcUx5bGqfjZ8oujl9HsDopYxIUeoX//spn/R4PVpHsV9NHkjJhjG8wSD0
	rz/q/bt/k2wAWiayn4a29OX7eOHYquYG07EJAImfXktU41IM1v3ibaq66QUxEYyUH877qg
	wZhBzYwlw9vjvjX6lcLBkYJ+voKA1kA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-jFLqdM_nOjWkuJ6_exb9Sw-1; Fri,
 20 Dec 2024 13:13:57 -0500
X-MC-Unique: jFLqdM_nOjWkuJ6_exb9Sw-1
X-Mimecast-MFC-AGG-ID: jFLqdM_nOjWkuJ6_exb9Sw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE16919560A2;
	Fri, 20 Dec 2024 18:13:55 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CA45195608A;
	Fri, 20 Dec 2024 18:13:53 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
Date: Fri, 20 Dec 2024 19:13:52 +0100
Message-ID: <20241220181352.25974-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Like the Vivobook X1704VAP the X1504VAP has its keyboard IRQ (1) described
as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
breaks the keyboard.

Add the X1504VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 821867de43be..ab4c0e0b6b8e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1504VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1704VAP */
 		.matches = {
-- 
2.47.1


