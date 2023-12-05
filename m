Return-Path: <linux-acpi+bounces-2164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F480637C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BE91C2082D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D37EC6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l9rnlWkX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F54B5;
	Tue,  5 Dec 2023 14:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=k5UHSRsYexw7YmIWFMZ0g5GX98velugEhzwlyJPyNlg=; b=l9rnlWkX3cI7xQFCITWtTqZHAM
	LLN4oI0AATxWrL7asoJGj9grOX9Yw5ig4KtJEThvJl3ulaK/GXar9m+pJpAJm+D4+EnGM+t08/zH+
	FqgZezLmUzy4UV2ID69QDGYCdbEsfdAhOph4eCt+xJ1yqx2KMqR5+dDWncUgDUk9wLksHQSjaVYpE
	E6HiLXATL5ZbPcBcHiDZ/xuSApc6rD35I/4BZpRA7032U6baxIdgMZoppNH5SCJs04z1l5M3RbGHr
	jsrQYcdbIWz820qumwkjfvGolZxXV/csMQfFWvy/t+3Y9hGZIf5J+NQfY8PCzCDvr44GyYmao3Q/K
	S04cRKmA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAeFa-008YJL-0B;
	Tue, 05 Dec 2023 22:50:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: watchdog: fix kernel-doc warnings
Date: Tue,  5 Dec 2023 14:50:45 -0800
Message-ID: <20231205225045.32121-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings found when using "W=1".

acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
acpi_watchdog.c:85: warning: missing initial short description on line:
 * Returns true if this system should prefer ACPI based watchdog instead of

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/acpi_watchdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -81,7 +81,7 @@ static const struct acpi_table_wdat *acp
 	return wdat;
 }
 
-/**
+/*
  * Returns true if this system should prefer ACPI based watchdog instead of
  * the native one (which are typically the same hardware).
  */

