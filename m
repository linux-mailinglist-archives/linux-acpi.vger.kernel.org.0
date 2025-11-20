Return-Path: <linux-acpi+bounces-19166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED3C7581B
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5D2A62B9FF
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C593590AF;
	Thu, 20 Nov 2025 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd+CRwG5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8D281341
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658016; cv=none; b=MGIeM0zP7DfvHoWlMgbHpp2Z2xkr9MniLCnWydKn53EoImYsrkvwx+spwrqPBJjZ/yGOmexai9RGQ9UBjFk+YGty81aMvNhq3zG57MWDMr/LaE5553yxyCsOPBezNYQZM3x735GJjqG+ajyjClPja1kYdRiwOZwXOhH4JCJMV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658016; c=relaxed/simple;
	bh=l79bhb8Rml19lkkEmkA0c+LZL1ScG7jhO+hl9yufoGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdH5jZjARsSUDLp9o6HPN+7Ti7BbIMIndOr9JDgEfWY6xuPrBOWJZgCkDdYkIn9A8YBEeTn1CMzm1G8gIxzDi1yxid+RcX0LL/p4R9FnqAGyu09LtimxfX7axOUu3N8MybCesydAvAI0YPHs6pXXOqjkG4NhQ5ngQNJ3AuuWrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hd+CRwG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763658013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zql52UJpb99WilLwYKYnbYuQW8tcqMVBJhzSSFgCSFM=;
	b=hd+CRwG5iXY2nUuhv3Ufn2PYkaqNrCLw9Vi4D3bfhOxoud2hRMqOpBK7QTD54Z4QS/BVcY
	CYXimkbyzVyWh6j2KBV7Lu/I+X6xubKSMC7q5MuC/C0rh1qVyCPzRQx68X0MxQXzREYh0o
	BQPzlmhdzzU6Od/w1BfaZUtcivDn8DI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-gK0dQdIkPhek7Kcg_qLZnw-1; Thu,
 20 Nov 2025 12:00:11 -0500
X-MC-Unique: gK0dQdIkPhek7Kcg_qLZnw-1
X-Mimecast-MFC-AGG-ID: gK0dQdIkPhek7Kcg_qLZnw_1763658009
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82476195606D;
	Thu, 20 Nov 2025 17:00:09 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.80.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADB6B1800878;
	Thu, 20 Nov 2025 17:00:05 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	lyude@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] ACPI: tools: pfrut: fix memory leak and resource leak in pfrut.c
Date: Thu, 20 Nov 2025 22:29:58 +0530
Message-ID: <20251120170001.251968-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Static analysis found an issue in pfrut.c

cppcheck output before this patch:
tools/power/acpi/tools/pfrut/pfrut.c:225:3: error: Resource leak: fd_update [resourceLeak]
tools/power/acpi/tools/pfrut/pfrut.c:269:3: error: Resource leak: fd_update [resourceLeak]
tools/power/acpi/tools/pfrut/pfrut.c:269:3: error: Resource leak: fd_update_log [resourceLeak]
tools/power/acpi/tools/pfrut/pfrut.c:365:4: error: Memory leak: addr_map_capsule [memleak]
tools/power/acpi/tools/pfrut/pfrut.c:424:4: error: Memory leak: log_buf [memleak]

cppcheck output after this patch:
No resource leaks found

Fix by closing file descriptors and freeing allocated memory.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 tools/power/acpi/tools/pfrut/pfrut.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index 44a9ecbd91e8..4d9b0177c312 100644
--- a/tools/power/acpi/tools/pfrut/pfrut.c
+++ b/tools/power/acpi/tools/pfrut/pfrut.c
@@ -222,6 +222,7 @@ int main(int argc, char *argv[])
 	fd_update_log = open("/dev/acpi_pfr_telemetry0", O_RDWR);
 	if (fd_update_log < 0) {
 		printf("PFRT device not supported - Quit...\n");
+		close(fd_update);
 		return 1;
 	}
 
@@ -265,7 +266,8 @@ int main(int argc, char *argv[])
 		printf("chunk2_size:%d\n", data_info.chunk2_size);
 		printf("rollover_cnt:%d\n", data_info.rollover_cnt);
 		printf("reset_cnt:%d\n", data_info.reset_cnt);
-
+		close(fd_update);
+		close(fd_update_log);
 		return 0;
 	}
 
@@ -358,6 +360,7 @@ int main(int argc, char *argv[])
 
 		if (ret == -1) {
 			perror("Failed to load capsule file");
+			munmap(addr_map_capsule, st.st_size);
 			close(fd_capsule);
 			close(fd_update);
 			close(fd_update_log);
@@ -420,7 +423,7 @@ int main(int argc, char *argv[])
 		if (p_mmap == MAP_FAILED) {
 			perror("mmap error.");
 			close(fd_update_log);
-
+			free(log_buf);
 			return 1;
 		}
 
-- 
2.51.0


