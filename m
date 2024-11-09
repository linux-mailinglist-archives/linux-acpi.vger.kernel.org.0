Return-Path: <linux-acpi+bounces-9484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBABE9C2FB0
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F7B1C20B61
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19217199FDC;
	Sat,  9 Nov 2024 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx/rG8Rn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBF42069
	for <linux-acpi@vger.kernel.org>; Sat,  9 Nov 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189647; cv=none; b=F+4MP1trAKu9J9lI1WPRSWB7FBRFu33Cp6hjk0WTmW+R5ab0S5Iz2YjXEtu69WctjmFYUjOpGlhLKkh6JD5lwkKQOxebyUIZN/Qw5PMOUeNfimJ6iRakUuX9/U38GQxuU0E/xbzhkQ/mdQCfyzwlS/2yzn2/kCLiTrvxHnmqDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189647; c=relaxed/simple;
	bh=y0A6f5FOKVQea5gb0AK39dVevQmN3je9X4ws7cs4Tno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWOHdZJ+qGD0rqQkjIg8ZsLx0ZeOihKFkuBSz2gPSjNYzZjbSB9TP9YiM17Tnt1ATXUDIsurX/aZ1+Vzg6bozCYVNpiZrfAd61ApEnrDCHL/k6hYzjlNaE/seMRbjYTeWZag1n9EdnNSy/ARWN3b3WhmKQmNz5CpRiAB8NmxoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nx/rG8Rn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731189644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2QRF/ZK4oIb1Qn5vFHGBEqnGAFd6pFENWUVKkX2W1lU=;
	b=Nx/rG8RnZk1B00yVKx7eTVmkKCMCydSOWYcepPC5laR3XbXmujmYuVCzGRA1yWiJuDVGGJ
	5o18/yz14KLRjZIucWd27f5zH+NjNrl0m2HQFm5WghfsDWOcBRi6Th8WAYwxblBWLFYUIF
	U64Rzat2MkrPntZDTTXUTuqQPTTREFU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Qa6RDUxnNFORFQ0HtU5oNw-1; Sat,
 09 Nov 2024 17:00:40 -0500
X-MC-Unique: Qa6RDUxnNFORFQ0HtU5oNw-1
X-Mimecast-MFC-AGG-ID: Qa6RDUxnNFORFQ0HtU5oNw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F7C19560AA;
	Sat,  9 Nov 2024 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2451B1956089;
	Sat,  9 Nov 2024 22:00:37 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration()
Date: Sat,  9 Nov 2024 23:00:28 +0100
Message-ID: <20241109220028.83047-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

acpi_dev_hid_match() does not check for adev == NULL, dereferencing
it unconditional.

Add a check for adev being NULL before calling acpi_dev_hid_match().

At the moment acpi_quirk_skip_serdev_enumeration() is never called with
a controller_parent without an ACPI companion, but better safe than sorry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 3eec889d4f5f..423565c31d5e 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -536,7 +536,7 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	 * Set skip to true so that the tty core creates a serdev ctrl device.
 	 * The backlight driver will manually create the serdev client device.
 	 */
-	if (acpi_dev_hid_match(adev, "DELL0501")) {
+	if (adev && acpi_dev_hid_match(adev, "DELL0501")) {
 		*skip = true;
 		/*
 		 * Create a platform dev for dell-uart-backlight to bind to.
-- 
2.47.0


