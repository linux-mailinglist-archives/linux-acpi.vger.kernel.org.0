Return-Path: <linux-acpi+bounces-7819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742EE95E3CF
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E03C281811
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Aug 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09513DDB6;
	Sun, 25 Aug 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfEbkoz9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47929CEF
	for <linux-acpi@vger.kernel.org>; Sun, 25 Aug 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595368; cv=none; b=CBFoGJf1Fa85Gu70Y4kKKc0eYOACILOY52vNkn1nvqEw+SotPQ3QXsw1IsSrVxY688jKmJcyX9Rh82JHjSQGc50diZZ0Q9k1vIFKQn4F04/eVNX3fMRpB8GhgkAqfLr7Y+ZnRyIXZ458dH0rn4snn3u3PW7jApiNkNan+B5WrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595368; c=relaxed/simple;
	bh=QmRDbYLViJRSMBWWPSy5AUhbNrNISBmlejG8KfB7x40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omW8EUV+wqF9QSCGh2ZkFA28Aod6/tQpLWNGAoAFlj5W6QjmzHqbq2m2Q5avgal70OII9U1Ho55BQO+HeznJM+Tty24dF2rqvLQ0bgoZ68QoxKsRWpj0wrP8QIJfmFCIwgkE3WdIHLiP1LkCkj4m8jMpOWKjQqOdpzO9FZC+fQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfEbkoz9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724595363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SysA3xj+UZIMggGm9Zm0ImI3ggepwQvn0lU5nBZuNwE=;
	b=GfEbkoz9zrErzQiM2wxr46B4qUKH4nfK7+vIO7AdM2Y9w7EgBCjYX/4bfTtUTDiqpw3CWa
	fQ8FUwJhv92hFO7tmIFI1TbnC1LwwQXBdYGwrJbqNS58PEvuC+2Cm+xGC7QOz3X/e2fw65
	owG0IugL3ULTRcHwWbESd9FNVdc2PLk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-e7chhSw_Nzys_7AUXcCjLQ-1; Sun,
 25 Aug 2024 10:16:01 -0400
X-MC-Unique: e7chhSw_Nzys_7AUXcCjLQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB271955D47;
	Sun, 25 Aug 2024 14:16:00 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (unknown [10.64.240.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1B6919560A3;
	Sun, 25 Aug 2024 14:15:58 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	snishika@redhat.com
Subject: [PATCH] ACPI: acpi_pad: fix crash in exit_round_robin()
Date: Sun, 25 Aug 2024 23:13:52 +0900
Message-ID: <20240825141352.25280-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The kernel occasionally crashes in cpumask_clear_cpu(), which is called
within exit_round_robin(), because when executing clear_bit(nr, addr) with
nr set to 0xffffffff, the address calculation may cause misalignment within
the memory, leading to access to an invalid memory address.

----------
BUG: unable to handle kernel paging request at ffffffffe0740618
        ...
CPU: 3 PID: 2919323 Comm: acpi_pad/14 Kdump: loaded Tainted: G           OE  X --------- -  - 4.18.0-425.19.2.el8_7.x86_64 #1
        ...
RIP: 0010:power_saving_thread+0x313/0x411 [acpi_pad]
Code: 89 cd 48 89 d3 eb d1 48 c7 c7 55 70 72 c0 e8 64 86 b0 e4 c6 05 0d a1 02 00 01 e9 bc fd ff ff 45 89 e4 42 8b 04 a5 20 82 72 c0 <f0> 48 0f b3 05 f4 9c 01 00 42 c7 04 a5 20 82 72 c0 ff ff ff ff 31
RSP: 0018:ff72a5d51fa77ec8 EFLAGS: 00010202
RAX: 00000000ffffffff RBX: ff462981e5d8cb80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
RBP: ff46297556959d80 R08: 0000000000000382 R09: ff46297c8d0f38d8
R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000000e
R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000000000e
FS:  0000000000000000(0000) GS:ff46297a800c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffe0740618 CR3: 0000007e20410004 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ? acpi_pad_add+0x120/0x120 [acpi_pad]
 kthread+0x10b/0x130
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x40
        ...
CR2: ffffffffe0740618

crash> dis -lr ffffffffc0726923
        ...
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 114
0xffffffffc0726918 <power_saving_thread+776>:	mov    %r12d,%r12d
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 325
0xffffffffc072691b <power_saving_thread+779>:	mov    -0x3f8d7de0(,%r12,4),%eax
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./arch/x86/include/asm/bitops.h: 80
0xffffffffc0726923 <power_saving_thread+787>:	lock btr %rax,0x19cf4(%rip)        # 0xffffffffc0740620 <pad_busy_cpus_bits>

crash> px tsk_in_cpu[14]
$66 = 0xffffffff

crash> px 0xffffffffc072692c+0x19cf4
$99 = 0xffffffffc0740620

crash> sym 0xffffffffc0740620
ffffffffc0740620 (b) pad_busy_cpus_bits [acpi_pad]

crash> px pad_busy_cpus_bits[0]
$42 = 0xfffc0
----------

To fix this, ensure that tsk_in_cpu[tsk_index] != -1 before calling
cpumask_clear_cpu() in exit_round_robin(), just as it is done in
round_robin_cpu().

Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/acpi/acpi_pad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 350d3a892889..699fbc795cfe 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -136,7 +136,8 @@ static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
 
-	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+	if (tsk_in_cpu[tsk_index] != -1)
+		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
 	tsk_in_cpu[tsk_index] = -1;
 }
 
-- 
2.46.0


