Return-Path: <linux-acpi+bounces-13283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F272A9D1AC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B09E1BC0D2B
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2722155C;
	Fri, 25 Apr 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hzV3VUOQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB1218EBD;
	Fri, 25 Apr 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609664; cv=none; b=gO3Z2615EFWNLBIrmAdvW/EnfShQdUCGekI97dHLN0Lzg7NeGZn++3ZidyMQnsFQV47WPjnHZJ1fqxRmniGV0W08e7Y5kIrHLCI9xiUeZAvjquwqlVbSYmriN8QKWrPuJ7Mz00DPpA623CPBO6PXRqZ+DLkYP7U0CGUPTZZN6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609664; c=relaxed/simple;
	bh=S4iIUQi57lzah0776a4YX+dVuF+D72rkHNVDEtCHcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUwDtoCf4id1JIvYkXKTZKBmB2W9Dpi/uJlIDxZYmeLciz8fQpwd++GbV5S+dMPdrOleKGupIzBAkZPXn9Veq/Y+g9qwU8Tqda+n2fjqn3MRehvk5drys2RA/umlkA4RqS83/xqUFal0+r0vd0ms5zJEVR1f0ITwMxfXZ68wO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hzV3VUOQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DD6826643E6;
	Fri, 25 Apr 2025 21:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609654;
	bh=S4iIUQi57lzah0776a4YX+dVuF+D72rkHNVDEtCHcxw=;
	h=From:Subject:Date;
	b=hzV3VUOQ11bX/cIKSPN5sGlhjxHOfB0IaEi60kRGijDR4Kloyg21UGTi1fxUIVxAt
	 c9t5zW3ltQKbK5fnxE8pLz+rrdABb/pBQkHjArfxEDxWlHDjhgsZqPsg4npjkGyW+p
	 mgy1uiAE86iKcaFSW7nNuL90giIfJU+be2yEP2o7ICQjLBV9bqxrsjSoGzwKoq/oaU
	 fiQfsMZ2sj9CRg7RZYxP+LS5F/VCP3na/R6hTCbZx7O7ebSpawhu6QTq54JPSgX2Dq
	 xrofB9GzfXV8VjVQO/+dtd8v5MYUvKtYtB56ipavdVjpTDrUmN2Fx05pbB5iZdkb/q
	 balPaoH3CpNTQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 15/19] ACPICA: Adjust the position of code lines
Date: Fri, 25 Apr 2025 21:29:48 +0200
Message-ID: <2670567.Lt9SDvczpP@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Zhe Qiao <qiaozhe@iscas.ac.cn>

ACPICA commit 5da6daf5691169d2bf2e5c9e55baf093757312ca

In the acpica/utcache.c file, adjust the position of the
"ACPI_MEM_TRACKING(cache->total_allocated++);" code line
to ensure that the increment operation on total_allocated
is included within the ACPI_DBG_TRACK_ALLOCATIONS configuration.

Link: https://github.com/acpica/acpica/commit/5da6daf5
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 85a85f7cf750..046e6ba127d4 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -251,9 +251,9 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 	} else {
 		/* The cache is empty, create a new object */
 
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 		ACPI_MEM_TRACKING(cache->total_allocated++);
 
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 		if ((cache->total_allocated - cache->total_freed) >
 		    cache->max_occupied) {
 			cache->max_occupied =
-- 
2.43.0





