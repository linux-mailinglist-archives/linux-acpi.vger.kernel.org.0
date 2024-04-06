Return-Path: <linux-acpi+bounces-4694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922EB89AB35
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31231C20C6A
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2194374E9;
	Sat,  6 Apr 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbBZ6lx7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99F34CD8
	for <linux-acpi@vger.kernel.org>; Sat,  6 Apr 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411928; cv=none; b=OGLjeqKumpcdrj0T8FZ9iQdDvAETK651h87+HyyCk3XIjbe4t+OhBvw5PUrs6eFf9EpcsxzaxvlLrrMJE7sD9vrLZgvX/EDNiEQ02MNEO9smHaxk4erulUi3sGrOkCAKIxgRVoBTLTCZbus+pay5hvI/sWZELHj6likG3tERaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411928; c=relaxed/simple;
	bh=HiYlmnV1JxvSmus2kMoCceHatoMsYMccco3jmZPU9mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nc7iFjKfwt+JLLJY0d99y3EGP+j4h+Z9Bh/pNb/Y4nEH83FTt1QNveb+gzBRUsH2jVgn98GRlVCR5VNZeyjWjizC9F4/qhypQEbs2/5G7lMW3kyL0+4obwEt4fqR6KlAQ0Kow/KNsZOS5X43CWYWGYjOuydq2U3RwgFPYmVQztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbBZ6lx7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712411925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tCV++6cziM8hD67Ei5JbV2ZY6ibWidsrdMVvhhP3Y0k=;
	b=NbBZ6lx7tNTZiye5SRFC+kP7Cpgy+g40mRk5oyQ+olBUeqmOLn3M/n2R3+Y3a/x3hpn/UX
	lJ2/VFB+V3RKAqd2B9DopNWNkzMpt6LaHp7kTz80eJkrNxO0JQfHJ/Mg2Rc8/U+oSr2J6P
	tNiLucOb4H8K6Fn4ZyAqdAKR+/QlZZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-wopHcyHHM3CN8SeSxZk0IQ-1; Sat, 06 Apr 2024 09:58:39 -0400
X-MC-Unique: wopHcyHHM3CN8SeSxZk0IQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4823685A588;
	Sat,  6 Apr 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B30972166B33;
	Sat,  6 Apr 2024 13:58:38 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: x86: utils: Mark SMO8810 accel on Dell XPS 15 9550 as always present
Date: Sat,  6 Apr 2024 15:56:24 +0200
Message-ID: <20240406135625.17118-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The Dell XPS 15 9550 has a SMO8110 accelerometer /
HDD freefall sensor which is wrongly marked as not present.

Mark this as always present so that the dell-smo8800 driver
can bind to it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 90c3d2eab9e9..c7af2d2986fd 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -100,6 +100,15 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
 
+	/*
+	 * The Dell XPS 15 9550 has a SMO8110 accelerometer /
+	 * HDD freefall sensor which is wrongly marked as not present.
+	 */
+	PRESENT_ENTRY_HID("SMO8810", "1", SKYLAKE, {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9550"),
+	      }),
+
 	/*
 	 * The GPD win BIOS dated 20170221 has disabled the accelerometer, the
 	 * drivers sometimes cause crashes under Windows and this is how the
-- 
2.44.0


