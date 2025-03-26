Return-Path: <linux-acpi+bounces-12469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14325A72091
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF9417A818
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0A264F9E;
	Wed, 26 Mar 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VkJrv26U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE22263F42;
	Wed, 26 Mar 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023531; cv=none; b=gRF5aMGDHb2u6VIXImJkduanCQsOR9ahmwjbXjyOfl4jYgut1qS6s/A3dbbKBJ/GO1mlEI7dGGiBbd5TCXYr+egfpI2EOppcByXfmYamEopuUu2bpddw7w8acNuZB8u33vkpc66gaeR0yzw1WF0A4fQy4luY6wptz/IHniNfj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023531; c=relaxed/simple;
	bh=NYQAQqoU+cHLeOfl1KDN/XyVgb+cqHSH3yULOBASxyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU1VKiNptH/doSHv8WSnzLpVaa+11IpCpf9TQCVzICLYVaiCHRr+6gxq5S8r7r7+R3VE2fDZIM8FZdMCWdTwTX44LvdzEJFNhHBsR6H5vBploD0ZDMG4pWNJ8xBPp9FqfP1AFGvYjZDCVQ87FoZTNumG1xsISFC/C0fx6hkrAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VkJrv26U; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id d31ff512a1974e56; Wed, 26 Mar 2025 21:12:08 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9176A7F6388;
	Wed, 26 Mar 2025 21:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019928;
	bh=NYQAQqoU+cHLeOfl1KDN/XyVgb+cqHSH3yULOBASxyU=;
	h=From:Subject:Date;
	b=VkJrv26Ulf20eo7d3KUDHRNNLkzglmluzBUM8GBbxodpEH8h1OAlwxjUFex6CZ1Be
	 pQ2Oj1lWJt+Il6uls7Gi8O1XY3VbVnodK3dPXGu0W4stzaYYAtzm7zvjBEaCYtmRJg
	 lkFoz1Uw55jz/XRPaxwrP+OEP0rCsZCGoeAuksM66FdBQHFXlwVobAEZMGn2tylqIl
	 YhRc6igN6HkFRdVMlj10iD9X0c39uvynK0E+2JkvolZd4Zbytnp/aDw/FbQomBsysQ
	 SuHc2vrf1htw4HAacQR0Pf9opBbR0t1mdpXK9R4smbgSsCAblK6sUZxKFycPhX+Noa
	 aEGMq8X1zhBQw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 3/8] ACPICA: New release 20240927
Date: Wed, 26 Mar 2025 21:07:06 +0100
Message-ID: <1918458.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <5873907.DvuYhMxLoT@rjwysocki.net>
References: <5873907.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=8

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit 4632caf451c28da5355ab7131df8bef77818e0f4

Link: https://github.com/acpica/acpica/commit/4632caf4
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 78b24b090488..25a071d305bd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20240827
+#define ACPI_CA_VERSION                 0x20240927
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.43.0





