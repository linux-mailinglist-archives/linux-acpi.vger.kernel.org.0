Return-Path: <linux-acpi+bounces-8399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AE985C40
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897BA28380A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9361CC8A3;
	Wed, 25 Sep 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1X/4Nge"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364717557E;
	Wed, 25 Sep 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265546; cv=none; b=SVQmTv+YaRc2Pwsolu+awC7cYD7jPoI3jWEOwLmlTgt6fQ6arHTvQ+me/uZJQJ445abAPZvhlfS2xzftt6Kkkp6IxSDiP4IHuRt85/ZxbAoqbgTUnJT3RSGX/tl4aPwdogrx1nvpWFjbdSPXXZFjBtTpcdytODJeKZ33DJv+vOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265546; c=relaxed/simple;
	bh=7lurwg8SHx4zpQjJ7uh//EVBUwdH9uFADQGz3lk4T7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klqHSmMoIazl2kNPfWAHXJO3rtOyg0asj5BFLmiHOrrbA7l+EPS+v1NGOpoP9m0bnbKJ2gtpxNeebllwFV/aY9Z99jU/SgI6ghph28/hJaqn9tOy55LiQ9mt7SkHj2P9MzW++UsYBaEh6q4KsWV8S8d5rBcMt9UsKXEVm2gzmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1X/4Nge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE85C4CECE;
	Wed, 25 Sep 2024 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265545;
	bh=7lurwg8SHx4zpQjJ7uh//EVBUwdH9uFADQGz3lk4T7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1X/4Nge64zKhzOBjuvIWYLa+NI8Bf1ZdRUAATyHwSSPRD+MUfBUpH3ztesMGXoqM
	 Q+PtTdLhzR55O0RAZ77gnseIkVjpUKdhjcE7SgwV7dmJw2HXrczGkWD4z5XV95hT6d
	 Ug6o6fsayCoICMdZZ/sIGYcVHb5EKk21WhbQw44lQaZG54dCOEWLzDuHJAzUkE2mAS
	 l0habEZUD15KBZptj48Mq5icnOHfco+AJWl2JWE4MxcSguKS1taD4dc033OEaWzND2
	 uw7em3zBOhifWm6N/akM5CP7QARxGl4+6EvD4Z+gXFFXB6PwtdIK9zP1eOenI/FT8C
	 DQvPGkTpx6jiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Seiji Nishikawa <snishika@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 015/197] ACPI: PAD: fix crash in exit_round_robin()
Date: Wed, 25 Sep 2024 07:50:34 -0400
Message-ID: <20240925115823.1303019-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Seiji Nishikawa <snishika@redhat.com>

[ Upstream commit 0a2ed70a549e61c5181bad5db418d223b68ae932 ]

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
Link: https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
[ rjw: Subject edit, avoid updates to the same value ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_pad.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f02907..e84509b19f94d 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -132,8 +132,10 @@ static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
 
-	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
-	tsk_in_cpu[tsk_index] = -1;
+	if (tsk_in_cpu[tsk_index] != -1) {
+		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+		tsk_in_cpu[tsk_index] = -1;
+	}
 }
 
 static unsigned int idle_pct = 5; /* percentage */
-- 
2.43.0


