Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F159AEA7
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Aug 2022 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiHTORH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 20 Aug 2022 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiHTORG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Aug 2022 10:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA280F44
        for <linux-acpi@vger.kernel.org>; Sat, 20 Aug 2022 07:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB3560B61
        for <linux-acpi@vger.kernel.org>; Sat, 20 Aug 2022 14:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3A0C433D6;
        Sat, 20 Aug 2022 14:17:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="petZXmNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661005022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=c1p852RXvxrIUjWZWzea/kwuUnxU+SMIS4UYDCg+xqw=;
        b=petZXmNKbljaxop4/aUHKmRgqOiSIHloDiM6KqvH3ySDVWgUqFtzQUym4RKUizHOeNUaRB
        bbLmZvv0Zl9wv0GpRLSwWddoaNJBVWlx6LcaUxfyh8KtLtfpYxSsFQSzkwfHrTI+a+383+
        tjpFv9nPde4/dg/YViZcBCtUQXa2z2U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1fd2833 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 20 Aug 2022 14:17:01 +0000 (UTC)
Date:   Sat, 20 Aug 2022 16:16:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: null ptr deref in __power_supply_is_system_supplied
Message-ID: <YwDsy3ZUgTtlKH9r@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

With 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a, I'm seeing this OOOPs
from __power_supply_is_system_supplied:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: 0010 [#1] PREEMPT SMP
CPU: 14 PID: 1156 Comm: upowerd Tainted: G S   U             6.0.0-rc1+ #366
Hardware name: LENOVO 20Y5CTO1WW/20Y5CTO1WW, BIOS N40ET36W (1.18 ) 07/19/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffff88815350bd08 EFLAGS: 00010212
RAX: ffff88810207d620 RBX: ffff88815350bd7c RCX: 000000000000394e
RDX: ffff88815350bd10 RSI: 0000000000000004 RDI: ffff888111722c00
RBP: ffff88815350bd68 R08: ffff8881187a8af8 R09: ffff8881187a8af8
R10: 0000000000000000 R11: 000000000000005f R12: ffffffff8162d0b0
R13: ffff88810159a038 R14: ffffffff823b3768 R15: ffff88810159a000
FS:  00007fd1f0958140(0000) GS:ffff88901f780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000152c7a004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 __power_supply_is_system_supplied+0x26/0x40
 class_for_each_device+0xa5/0xd0
 ? acpi_battery_get_state+0x4e/0x1f0
 power_supply_is_system_supplied+0x26/0x40
 acpi_battery_get_property+0x301/0x310
 power_supply_show_property+0xa5/0x1d0
 dev_attr_show+0x10/0x30
 sysfs_kf_seq_show+0x78/0xc0
 seq_read_iter+0xfd/0x3e0
 vfs_read+0x1cb/0x290
 ksys_read+0x4e/0xc0
 do_syscall_64+0x2b/0x50
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fd1f0bed70c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 a4 f8 ff 41 89 c0 48 8b 54 24 18 48 8b 74 24 10 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 8f a4 f8 ff 48
RSP: 002b:00007ffc8d3f27e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1f0bed70c
RDX: 0000000000001000 RSI: 000055957d534850 RDI: 000000000000000c
RBP: 000055957d50b1d0 R08: 0000000000000000 R09: 0000000000001000
R10: 000000000000006f R11: 0000000000000246 R12: 00007ffc8d3f2910
R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000c
 </TASK>
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_skcipher bnep uvcvideo videobuf2_vmalloc btusb videobuf2_memops videobuf2_v4l2 btintel videobuf2_common bluetooth video>
 i2c_designware_platform i2c_designware_core snd_hda_intel i2c_algo_bit drm_buddy snd_intel_dspcfg kvm_intel spi_nor intel_gtt think_lmi snd_intel_sdw_acpi mtd mei_pxp mei_hdcp firmware_attributes_class wm>

CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffff88815350bd08 EFLAGS: 00010212
RAX: ffff88810207d620 RBX: ffff88815350bd7c RCX: 000000000000394e
RDX: ffff88815350bd10 RSI: 0000000000000004 RDI: ffff888111722c00
RBP: ffff88815350bd68 R08: ffff8881187a8af8 R09: ffff8881187a8af8
R10: 0000000000000000 R11: 000000000000005f R12: ffffffff8162d0b0
R13: ffff88810159a038 R14: ffffffff823b3768 R15: ffff88810159a000
FS:  00007fd1f0958140(0000) GS:ffff88901f780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000152c7a004 CR4: 0000000000770ee0
PKRU: 55555554

Regards,
Jason
