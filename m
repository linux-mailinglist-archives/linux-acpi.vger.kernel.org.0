Return-Path: <linux-acpi+bounces-3147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C7844F26
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Feb 2024 03:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4281C268BC
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Feb 2024 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8012B1079B;
	Thu,  1 Feb 2024 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/0SX2Ln"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA98171B1
	for <linux-acpi@vger.kernel.org>; Thu,  1 Feb 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754333; cv=none; b=PlyyULHRtdkXujTS0HueWY9XiPZB+vzJNFfEL6jzccWWygUSz+V3e2GNq7egJG4YD++h1nm2f+cKSP2DhkRaWDSH5CNqQXShqtW/QC2mO9iW3PVsffLiCBS1VpugCHZiYkqjo9gBBE708ICcZYLHf5QQv3m3t5m/joGU10EHAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754333; c=relaxed/simple;
	bh=Jn7CkBOs4tUlgrqscjF6KuMg1DBK8nDyXuCYCUYaGkA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j8tyRUok6zzrbLqwXxSYtND6NsI8K4A7lCzjYU/eloldeGn5FVCE3LzdZo0IRyA/+uYSEVeRn9cPEU6/Uk2NMQh2A3z0dg10IWW0sGW4Jf9xFT3c+CdtN9ZaPJtjdFam/IyVMX4+VXOvNPKALxV1k/PD7qa4qTd5X0oGdTFzCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/0SX2Ln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706754329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jRTK9ROGaA/FkV3J3RPSroICl0B/0VEu0ibu3GFX7qg=;
	b=f/0SX2LnXU/UlSNqh5nxbkwFSsInO4xpv6D7cm5SAz9/278U1SsCoNSTsqimHCCzWnuQ2V
	/M+of+2VaAA2FU+LLQ6Q/CrlsqvfUsO1oj51FJzQZ574LjypvIAobfSys1zSWmA0dlySmq
	FgT2KHBV+HGQPXy+NbRY6eF9yFogcVA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-VfOtwkxXPMO3BJTaKl2Zmw-1; Wed, 31 Jan 2024 21:25:27 -0500
X-MC-Unique: VfOtwkxXPMO3BJTaKl2Zmw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-296195e86fdso57130a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 18:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706754324; x=1707359124;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRTK9ROGaA/FkV3J3RPSroICl0B/0VEu0ibu3GFX7qg=;
        b=u+LGe10C7z8l7KqorfwklOfR51h2gGuYc1r09tSg6zE702vfMT3+q3l28ZPOQ8LSiN
         melDgdJfglO0TCBMS3boIkkv51nPwTjUsOo8evJKBMSZMfwc9mk0ak4SV5+8kikiyjTa
         MouAA8ODVFWZLhud4KavZUY/5tOseGFbXhLJRP9r7KZXRPloUPPaSRX0bhC7rl+k5zQQ
         j2SU6idJBB8ouc+2re5LcxbqmTNWSIFUGbKYIUKS116fUXI1sw9SukyVZyxlh+920mrU
         awyEqsB91pSRa3O2f+IIj8rjgGkerZW4IydH+pJoNJcSuY+LjhlrZcuO1tniZpx0BK78
         ss3g==
X-Gm-Message-State: AOJu0YyAOL4ByYk+eU9wSbVmthmsz89i/XW9URcUHoPpjYWPzUobAZGE
	sDGARACP/43sRcEMwFfF1y7KI7Q5rblt2rNweYYwG7FKMjdUhQfYVU1l7XWVE8QwoUHkypnFoAh
	bd8J9RRYZ3G7JizLggKYuDmv4ZS6fMS5rvC0In1XEex0Yx4EHBNNsr2aq+Q49snGNQh88+ThBlu
	AVJ6WcoCNKsTEfStPoGNO6sXFwllvKMt0VYgRdDMWCte9vJeY=
X-Received: by 2002:a17:90a:94cb:b0:293:6f2b:2ca4 with SMTP id j11-20020a17090a94cb00b002936f2b2ca4mr3343206pjw.3.1706754323973;
        Wed, 31 Jan 2024 18:25:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAouBSTmv8JE/ghf8T3koFdHAXqCmbyyz599wqsl2jfNsz3jMaGRsvMvXgud77xps2LWxxMmTc9dnRPD93LuY=
X-Received: by 2002:a17:90a:94cb:b0:293:6f2b:2ca4 with SMTP id
 j11-20020a17090a94cb00b002936f2b2ca4mr3343195pjw.3.1706754323663; Wed, 31 Jan
 2024 18:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 1 Feb 2024 10:25:12 +0800
Message-ID: <CAHj4cs_G+JJO9_jn=r1K-Y-N+HM0t=nh02ZZ9aak+RLmq85eHg@mail.gmail.com>
Subject: [bug report] system panic after "ACPI: PM: Preparing to enter system
 sleep state S5"
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello
I found this panic recently after I did reboot operation, not sure if
it's one known issue, could you help check it?
Let me know if you need any info/testing for it, thanks.

[ 1043.213318] systemd-shutdown[1]: Successfully changed into root pivot.
[ 1043.219854] systemd-shutdown[1]: Returning to initrd...
[ 1043.320459] dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
[ 1043.385715] XFS (dm-0): Unmounting Filesystem
e306de50-ca8c-48be-ae7b-cb9572bd4abc
[ 1043.440310] dracut Warning: Unmounted /oldroot.
dracut Warning: Unmounted /oldroot.
[ 1043.481954] dracut: Disassembling device-mapper devices
Rebooting.
[ 1043.913483] megaraid_sas 0000:18:00.0: megasas_disable_intr_fusion
is called outbound_intr_mask:0x40000009
[ 1044.464876] ACPI: PM: Preparing to enter system sleep state S5
[ 1047.510492] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 5
[ 1047.510495] {1}[Hardware Error]: event severity: fatal
[ 1047.510497] {1}[Hardware Error]:  Error 0, type: fatal
[ 1047.510498] {1}[Hardware Error]:   section_type: PCIe error
[ 1047.510499] {1}[Hardware Error]:   port_type: 0, PCIe end point
[ 1047.510501] {1}[Hardware Error]:   version: 3.0
[ 1047.510502] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
[ 1047.510504] {1}[Hardware Error]:   device_id: 0000:01:00.1
[ 1047.510506] {1}[Hardware Error]:   slot: 0
[ 1047.510506] {1}[Hardware Error]:   secondary_bus: 0x00
[ 1047.510507] {1}[Hardware Error]:   vendor_id: 0x14e4, device_id: 0x165f
[ 1047.510509] {1}[Hardware Error]:   class_code: 020000
[ 1047.510510] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
[ 1047.510511] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
[ 1047.510513] {1}[Hardware Error]:   TLP Header: 40000001 0000000f
90028090 00000000
[ 1047.510516] Kernel panic - not syncing: Fatal hardware error!
[ 1047.510518] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2+ #1
[ 1047.510520] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[ 1047.510522] Call Trace:
[ 1047.510524]  <NMI>
[ 1047.510526]  dump_stack_lvl+0x38/0x50
[ 1047.510533]  panic+0x312/0x340
[ 1047.510537]  __ghes_panic+0x67/0x70
[ 1047.510541]  ghes_in_nmi_queue_one_entry.constprop.0+0x21d/0x2b0
[ 1047.510543]  ghes_notify_nmi+0x59/0xd0
[ 1047.510545]  nmi_handle+0x5a/0x150
[ 1047.510550]  default_do_nmi+0x40/0x100
[ 1047.510554]  exc_nmi+0x112/0x190
[ 1047.510556]  end_repeat_nmi+0xf/0x60
[ 1047.510561] RIP: 0010:intel_idle_ibrs+0x89/0x100
[ 1047.510564] Code: 48 89 d1 65 48 8b 04 25 00 2f 03 00 0f 01 c8 48
8b 00 a8 08 75 14 66 90 0f 00 2d ee 81 45 00 b9 01 00 00 00 4c 89 c0
0f 01 c9 <65> 48 8b 04 25 00 2f 03 00 f0 80 60 02 df f0 83 44 24 fc 00
48 8b
[ 1047.510566] RSP: 0018:ffffffff99803e38 EFLAGS: 00000046
[ 1047.510568] RAX: 0000000000000020 RBX: 0000000000000003 RCX: 0000000000000001
[ 1047.510570] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
[ 1047.510570] RBP: ffffffff99cb4060 R08: 0000000000000020 R09: 0000000000000c54
[ 1047.510572] R10: 0000000000000001 R11: ffff9ae2300321e4 R12: ffffffff99cb4060
[ 1047.510573] R13: ffffffff99cb41b0 R14: 0000000000000003 R15: 0000000000000000
[ 1047.510575]  ? intel_idle_ibrs+0x89/0x100
[ 1047.510577]  ? intel_idle_ibrs+0x89/0x100
[ 1047.510578]  </NMI>
[ 1047.510578]  <TASK>
[ 1047.510579]  cpuidle_enter_state+0x7a/0x420
[ 1047.510583]  cpuidle_enter+0x29/0x40
[ 1047.510590]  cpuidle_idle_call+0xf5/0x160
[ 1047.510594]  do_idle+0x7b/0xe0
[ 1047.510596]  cpu_startup_entry+0x26/0x30
[ 1047.510599]  rest_init+0xcc/0xd0
[ 1047.510600]  arch_call_rest_init+0xa/0x30
[ 1047.510604]  start_kernel+0x329/0x400
[ 1047.510607]  x86_64_start_reservations+0x14/0x30
[ 1047.510610]  x86_64_start_kernel+0x92/0xa0
[ 1047.510612]  secondary_startup_64_no_verify+0x184/0x18b
[ 1047.510617]  </TASK>
[ 1047.510631] Kernel Offset: 0x17000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

-- 
Best Regards,
  Yi Zhang


