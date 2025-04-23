Return-Path: <linux-acpi+bounces-13199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A250A9847E
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 10:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC857A5068
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42181C6FF9;
	Wed, 23 Apr 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ejq2PBol"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0C1DFF7;
	Wed, 23 Apr 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398611; cv=none; b=tTJAEnU8atKKevfvNT5/Qjq//QRnhUL8SGF/UqkI16yuWvKxDQBTcimxJPmOnH6TatSZGcp2yNHGeiw8wbQSV8PcZGvuZ2QGq9SEJpEWSL7szfw6Tql0BazdCDgI1A8jcN2NlLFtKrbnqxzXXoxoZaeXORxRCdkKYWuaoY2tGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398611; c=relaxed/simple;
	bh=4qJtVCKaWisPWUvzA+09//BzeYzyDJDaUibejerPk7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s+DGSy7Z2VvtURcSXx7LehLNgocxo2XteD0CmcplEMgu1ISgI8UozCF0U/FysllbjM61UzgKLOh4ugqzjhlTxWdd5/FlQu34svtBrVzfutxcaDqFGnn9vVGK+JAwdugkd3b0rq6HgzktjqOmwA0f/v7YnNMXzjY/TzgTPH8RGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Ejq2PBol; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1745398610; x=1776934610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0AcJZvxph3F3OuxHELWSPKQQ8VK4R4EnD0VhPZ1HpEw=;
  b=Ejq2PBolBAFj8xzWxBQu7LBZov3iwDzaqC/tjdI78YG10F06GdZEB40M
   oTiJJRu+s/YAe0EEyNGNhdnnWewYabOvH04Jj/Lc+ZC9NcibgsTdNsFt5
   R8Sd/BDgIU64NIr51d5gzYwnZZ5Kt43EIObQ/2kTxJFM60RhfKtXpI6J/
   o=;
X-IronPort-AV: E=Sophos;i="6.15,233,1739836800"; 
   d="scan'208";a="43069670"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:56:47 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:65379]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.9:2525] with esmtp (Farcaster)
 id 8c24f798-aa96-477e-a521-9623d36da87a; Wed, 23 Apr 2025 08:56:46 +0000 (UTC)
X-Farcaster-Flow-ID: 8c24f798-aa96-477e-a521-9623d36da87a
Received: from EX19D029EUC001.ant.amazon.com (10.252.61.252) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 08:56:46 +0000
Received: from dev-dsk-bsz-1b-e2c65f5d.eu-west-1.amazon.com (10.13.227.240) by
 EX19D029EUC001.ant.amazon.com (10.252.61.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 08:56:44 +0000
From: Bartosz Szczepanek <bsz@amazon.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <nh-open-source@amazon.com>, Bartosz Szczepanek <bsz@amazon.de>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/acpi: Improve logging around acpi_initialize_tables
Date: Wed, 23 Apr 2025 08:56:36 +0000
Message-ID: <20250423085637.38658-1-bsz@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D029EUC001.ant.amazon.com (10.252.61.252)

Emit warning that includes return code in a readable format. Example:
  ACPI: Failed to initialize tables, status=0x5 (AE_NOT_FOUND)

This commit intends to make no other functional change.

Signed-off-by: Bartosz Szczepanek <bsz@amazon.de>
---
 drivers/acpi/tables.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2295abbecd14..6a017cc92d4e 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -719,8 +719,12 @@ int __init acpi_locate_initial_tables(void)
 	}
 
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_warn("Failed to initialize tables, status=0x%x (%s)", status, msg);
 		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.47.1


