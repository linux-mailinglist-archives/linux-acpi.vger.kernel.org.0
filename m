Return-Path: <linux-acpi+bounces-4690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82289AAA6
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7A1C20DF0
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC52BAEA;
	Sat,  6 Apr 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EljTKWKo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD22C6A8
	for <linux-acpi@vger.kernel.org>; Sat,  6 Apr 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403792; cv=none; b=nX3wGhW89jlgLoe5S5tSJdQsRUskw/lGpuKMd586fcnyj0GE26TLCBDPweeuLHo9ga9ubZWlIX7NMnelnSGuS4sMgqcUR0aPIkftYrXB4aFvzjDuLYtLPTzV0MYFPRl+2milp5ReojIPDMkM9GmDbMI06JfLJiW2MLVQAoQC3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403792; c=relaxed/simple;
	bh=R/zXw1R28OLH33PLMuKmji3VRcEUqJ0OEWcs3tt0Sws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxBxhuXC6/tq4ljhOequznocrrEuMCLMUZuP0LN34PFf833fFk2CdW3+UKXXAas27Qt83VLo1HDD+QhEBZA8xflvqy+I3yOoBxjAGOMvbpoJfbEmTHy7wqPWe7RzyjRPU5DpVxPhhR7lG8AlMXA4lbCPtmEc4RXe4zAYbtSQQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EljTKWKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712403789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNqF3wqE6cBHIB4mPUlAvfauWxCW1U0xmKPSwYgTgnc=;
	b=EljTKWKo93LdpNjgtQRMTHKxqwWXpSIePI/cP2qPp7EmoiXbG4RHRjqW3duvkxp1a7P9iQ
	NtNwQ5oqBEjyUaVgP4qoqCjqhDHKgr+hmHuvOA+ZZU6PUI8GbB5VExv+EXiTjRopVqn5oC
	H+tpfkiKHPIK/5j6ND+Lx+BNBca4GTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-mYDZFI8yN0qe8gWMURS9ZA-1; Sat, 06 Apr 2024 07:43:03 -0400
X-MC-Unique: mYDZFI8yN0qe8gWMURS9ZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA58A80B2C7;
	Sat,  6 Apr 2024 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19222492BCD;
	Sat,  6 Apr 2024 11:43:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: scan: Do not increase dep_unmet for already met dependencies
Date: Sat,  6 Apr 2024 13:40:52 +0200
Message-ID: <20240406114052.4884-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On the Toshiba Encore WT10-A tablet the BATC battery ACPI device depends
on 3 other devices:

            Name (_DEP, Package (0x03)  // _DEP: Dependencies
            {
                I2C1,
                GPO2,
                GPO0
            })

acpi_scan_check_dep() adds all 3 of these to the acpi_dep_list and then
before an acpi_device is created for the BATC handle (and thus before
acpi_scan_dep_init() runs) acpi_scan_clear_dep() gets called for both
GPIO depenencies, with free_when_met not set for the dependencies.

Since there is no adev for BATC yet, there also is no dep_unmet to
decrement. The only result of acpi_scan_clear_dep() in this case is
dep->met getting set.

Soon after acpi_scan_clear_dep() has been called for the GPIO dependencies
the acpi_device gets created for the BATC handle and acpi_scan_dep_init()
runs, this sees 3 dependencies on the acpi_dep_list and initializes
unmet_dep to 3. Later when the dependency for I2C1 is met unmet_dep
becomes 2, but since the 2 GPIO deps where already met it never becomes 0
causing battery monitoring to not work.

Fix this by modifying acpi_scan_dep_init() to not increase dep_met for
dependencies which have already been marked as being met.

Fixes: 3ba12d8de3fa ("ACPI: scan: Reduce overhead related to devices with dependencies")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..d1464324de95 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1843,7 +1843,8 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 			if (dep->honor_dep)
 				adev->flags.honor_deps = 1;
 
-			adev->dep_unmet++;
+			if (!dep->met)
+				adev->dep_unmet++;
 		}
 	}
 }
-- 
2.44.0


