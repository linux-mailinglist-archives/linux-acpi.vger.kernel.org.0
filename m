Return-Path: <linux-acpi+bounces-4433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A198872F7
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CF285610
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B0657CA;
	Fri, 22 Mar 2024 18:23:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8062801;
	Fri, 22 Mar 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131788; cv=none; b=Rlmm6NSxFCZVNOcht8uz/2uzv6jMyH4C/p+6fBBEYRHlMgHKMbqAsc2l1kF2ZFy4tmpB5ya+watbFDjBAIXSNW4qJ5bnRpW9aI8nWNCvP0EaVbTrb5JPjtxaqV48e0hVOg67VkTT2qqrfYhPYNqmT8gPg+1WDxoLSIolp7x6lYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131788; c=relaxed/simple;
	bh=C3yFCYIxjXBw2tTNFQ6IgQn83J6QjcwG/Tyrj2jYoiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNh6e2IA6+gd5hHJhqIKuwh3R4FaV+nV3v2HUluZHmZoRBcEUUy5r1SYI9fu5Dg15f3cay9fs83DZ78+aw9MwUXJOU8CiPXSL0OIPGXg45oupKDXtjfoIeCZVrifz/0ja3gEC98PdRqn4q5WjZdaDdqG2dtvRKNPIYOLC5Ov0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.19] (port=24516 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rnjJu-0007gk-6r;
	Fri, 22 Mar 2024 21:08:46 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1106.mail.hosting.nic.ru (Exim 5.55)
	with id 1rnjJu-003M2t-03;
	Fri, 22 Mar 2024 21:08:46 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Robert Moore <robert.moore@intel.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] ACPICA: debugger: check status of acpi_evaluate_object in acpi_db_walk_for_fields
Date: Fri, 22 Mar 2024 21:07:53 +0300
Message-Id: <20240322180753.5612-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

ACPICA commit 9061cd9aa131205657c811a52a9f8325a040c6c9

Errors in acpi_evaluate_object can lead to incorrect state of buffer.
This can lead to access to data in previously ACPI_FREEd buffer and
secondary ACPI_FREE to the same buffer later.

Handle errors in acpi_evaluate_object the same way it is done earlier
with acpi_ns_handle_to_pathname.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Link: https://github.com/acpica/acpica/commit/9061cd9a
Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields of particular subtype")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v2: Add ACPICA project git links for corresponding changes
 drivers/acpi/acpica/dbnames.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index b91155ea9c34..c9131259f717 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	ACPI_FREE(buffer.pointer);
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not evaluate object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
 	/*
 	 * Since this is a field unit, surround the output in braces
 	 */
-- 
2.34.1


