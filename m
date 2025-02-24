Return-Path: <linux-acpi+bounces-11391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D9A41E22
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6547A698E
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95524886E;
	Mon, 24 Feb 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="VH1JLX91"
X-Original-To: linux-acpi@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B3248867;
	Mon, 24 Feb 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397589; cv=none; b=OfcBK71Im0rK0MMkg7CI/6XWUf4qTf/u0d1jeQNBqzX4NDgXS/MSX+azFOLFDn3BHhyJ0ypz+zwJlpJZMGcBP+ai4AS7g0R5cvV+WN5eSwzMFSiiM0qWhB8RhKn8FBueuijts0NKB2My+OEMQS5PW/9AV/67Lzb3q8kW2Uf4FFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397589; c=relaxed/simple;
	bh=NlnoUZSFwuABwD0daHXZJr7GkVokqSLQ+bN2yG+cOGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSr1PklYOBUyy0HcsfZbBHIx894m1p+7UOl5IycRgv7673yYaGQLjCubp8CyFy6SmKpWCExc9N0z+f/oq8srG/d+85Ne+5WvAJ5hoa5rNYOX9GfpSTDQl21WDmYH+Ga/Imbob99Lf4LzvzVSMPotI3IdUlRhILuDrKk8zR9xqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=VH1JLX91; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 51BAD1E000D;
	Mon, 24 Feb 2025 14:36:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 51BAD1E000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1740397016; bh=DTItJCPFhbVedZdbaxnqWm55x4dSNHRqn77CJj9NmTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VH1JLX91L4V8hbBR8Ys8idEMJR4jPCxo+5YOsHQzRKlUEdHnBZsbL1tltsvQmg9eQ
	 /k6SebhOXLdZmqKYQCR0BBvdznolAgBtl97Ep6KbJWL4MKyTT+o/oAkiEQ0DyhRSUC
	 QR6KmdVgQsDt9Y0gZYWgieqa9WfhQ70r392ZI3h9pHZBR8B9o2SGh+U8I3mtwUsWwi
	 1x0Cq3Nb1Fg5Rvm/BJzyApfrorucWsNK4OgGcLddGHW46X/6g6Yh36LJvZnI9xD1D5
	 TGRLRwIjOYZZCjYmmG25yUAobhbgjIilun7Tva4iN6sUrngU8SIHc/tC31Y2+lq50E
	 3eNKO1Jg189Bg==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 24 Feb 2025 14:36:56 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.182) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 24 Feb
 2025 14:36:53 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@mt-integration.ru>,
	<stable@vger.kernel.org>,
	<syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: [PATCH v2] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Date: Mon, 24 Feb 2025 14:35:46 +0300
Message-ID: <20250224113546.1441-1-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/02/24 10:30:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_one_url}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, ksmg02.maxima.ru:7.1.1;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mt-integration.ru:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191224 [Feb 24 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/02/24 06:47:00 #27427681
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/02/24 10:29:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Syzkaller has reported a warning in to_nfit_bus_uuid():

==================================================================
only secondary bus families can be translated
WARNING: CPU: 0 PID: 15821 at drivers/acpi/nfit/core.c:80 to_nfit_bus_uuid+0x6f/0x90 drivers/acpi/nfit/core.c:79
Modules linked in:
CPU: 0 UID: 0 PID: 15821 Comm: syz-executor579 Not tainted 6.11.0-rc7-syzkaller-00020-g8d8d276ba2fb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:to_nfit_bus_uuid+0x6f/0x90 drivers/acpi/nfit/core.c:79
Call Trace:
 <TASK>
 acpi_nfit_ctl+0x8a9/0x24a0 drivers/acpi/nfit/core.c:489
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x184d/0x1fe0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
==================================================================

This warning is triggered if the argument passed in to_nfit_bus_uuid() is
equal to 0. It is important that this function expects that the argument
is between 1 and NVDIMM_BUS_FAMILY_MAX. Therefore, it must be checked
beforehand. However, in acpi_nfit_ctl() validity checks made before
calling to_nfit_bus_uuid() are erroneous.

Function acpi_nfit_ctl() first verifies that a user-provided value
call_pkg->nd_family of type u64 is not equal to 0. Then the value is
converted to int (narrowing conversion), and only after that is compared
to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid argument to
acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while the lower 32
bits are zero.

Moreover, the same way zero can be passed in to_nfit_bus_uuid(),
negative value also may occur. That wouldn't trigger the warning, but
could lead to a wild-memory-access in test_bit(). This is achieved with
a slightly modified version of the reproducer generated by Syzkaller.
The crash report is as follows:

==================================================================
 BUG: KASAN: wild-memory-access in acpi_nfit_ctl (./arch/x86/include/asm/bitops.h:227 (discriminator 6) ./arch/x86/include/asm/bitops.h:239 (discriminator 6) ./include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 6) drivers/acpi/nfit/core.c:489 (discriminator 6))
 Read of size 8 at addr 1fff888141379358 by task repro/681503

 CPU: 0 UID: 0 PID: 681503 Comm: repro Not tainted 6.13.0-04858-g21266b8df522 #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 kasan_report (mm/kasan/report.c:604)
 kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
 acpi_nfit_ctl (./arch/x86/include/asm/bitops.h:227 (discriminator 6) ./arch/x86/include/asm/bitops.h:239 (discriminator 6) ./include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 6) drivers/acpi/nfit/core.c:489 (discriminator 6))
 nd_ioctl (drivers/nvdimm/bus.c:1187 drivers/nvdimm/bus.c:1264)
 __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:906 fs/ioctl.c:892 fs/ioctl.c:892)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
==================================================================

All checks of the input value should be applied to the original variable
call_pkg->nd_family. This approach is better suited for the stable
branches and is much safer than replacing the type of the variable from
int to u32 or u64 throughout the code, as this could potentially
introduce new bugs.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
Cc: stable@vger.kernel.org
Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
v2: Add more details to the commit message.

 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a5d47819b3a4..ae035b93da08 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
 			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
 			family = array_index_nospec(family,
--
2.39.2


