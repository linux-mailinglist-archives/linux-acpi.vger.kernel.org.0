Return-Path: <linux-acpi+bounces-10319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62249FDBB7
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245E33A1432
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFD18A6CE;
	Sat, 28 Dec 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQZZw7zM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E818A6C0
	for <linux-acpi@vger.kernel.org>; Sat, 28 Dec 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735404543; cv=none; b=lnayuM+/zNeidCc0xOLtgmgMItyZj3RBIXd2+Cy3buy2zB51E/cT5AtuGZUIvAHqWq3hbHF3f1Zyjx475iXPS2F6cEkp02V/wkjGqrjv+0dQRvo/e504WQ74fUEnhJg8jeEKzVKb/RMfvpLA27K15J/5dF2Wo3sBqqdS4sYaarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735404543; c=relaxed/simple;
	bh=CnHOjWnwcxBfEr30xjoW1jdvqAsEgL8xjieParMkvc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gws0cKjk7lCOiycwZ2JARijcSxd/P1Sb+GocWoHYC6jXioNilpMiyW+8dBdIoHAX1AeHjbi/dXHuB9Vi08Rmj6GCaVvfEcfb1z01YJWblcIpx+BQ5xl3uB+i0mzF9t+KaLHvKPkHhN23glpbetfPhP35b4fdPceTIBqMKCjuf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQZZw7zM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735404541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DrhhYC/SUzcKanUzR7ReLLrLLKZ8RxD2ej3oFU+uwCA=;
	b=LQZZw7zMhsu1p11WUiFcHEO59enAarwuAZh19Nr+tZNqpCKsQ3AaJX7bkAxHk5JLNYinPb
	lHaM9scSB5PGR1R8uS42TfwJtpwa/B6ZXdkXPHyCdVxdlfZOsGa8bY2XGbr5/qAWk3GcC0
	EuqHZW/kHlVXCFzRS0CXg/pD4FuX+wU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-4CTNSmINOwOYq9lcnypZjg-1; Sat,
 28 Dec 2024 11:48:55 -0500
X-MC-Unique: 4CTNSmINOwOYq9lcnypZjg-1
X-Mimecast-MFC-AGG-ID: 4CTNSmINOwOYq9lcnypZjg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AA5A1956089;
	Sat, 28 Dec 2024 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB4801956053;
	Sat, 28 Dec 2024 16:48:51 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
Date: Sat, 28 Dec 2024 17:48:45 +0100
Message-ID: <20241228164845.42381-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The TongFang GM5HG0A is a TongFang barebone design which is sold under
various brand names.

The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
laptops in order for the IRQ to work.

At least on the SKIKK Vanaheim variant the DMI product- and board-name
strings have been replaced by the OEM with "Vanaheim" so checking that
board-name contains "GM5HG0A" as is usually done for TongFang barebones
quirks does not work.

The DMI OEM strings do contain "GM5HG0A". I have looked at the dmidecode
for a few other TongFang devices and the TongFang code-name string being
in the OEM strings seems to be something which is consistently true.

Add a quirk checking one of the DMI_OEM_STRING(s) is "GM5HG0A" in the hope
that this will work for other OEM versions of the "GM5HG0A" too.

Link: https://www.skikk.eu/en/laptops/vanaheim-15-rtx-4060
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219614
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7d6537ea176f..90aaec923889 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -653,6 +653,17 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/*
+		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
+		 * board-name is changed, so check OEM strings instead. Note
+		 * OEM string matches are always exact matches.
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=219614
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_OEM_STRING, "GM5HG0A"),
+		},
+	},
 	{ }
 };
 
-- 
2.47.1


