Return-Path: <linux-acpi+bounces-4074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9286F9E8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 07:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F7C1F21355
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FCBA5E;
	Mon,  4 Mar 2024 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hRj648vQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25558DDAB;
	Mon,  4 Mar 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532854; cv=none; b=eLctLWN6vdlWF6urRmv4x47Z57dqpCNfLBVK9ALjF5UasZFoqehwYfTIRy70tsLbMMXNjEMOsEm1vnwQOqF9XfzTgCgUKxzvPs7Iesgqhqxwb/4+DpsUeTYCtBAxZytYnwvJon8yM9/s2up1mqO7wSdPmt5mf4zwNDJ03bQVEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532854; c=relaxed/simple;
	bh=GVrSxTRoMoV/uU/Lb3y9z9tOXaZgZRfgXcw2rhOhs4o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lDbFlIPO15Y1+BduuOcYsnLGiokq7+Qs83cNUKCxEpp8ywzSqwLhg8u+0I6o3MZuFq+lrklP9UuZdJxuWtL4ECB2cTgXzlG42V64/wm8x/2jkd2IHG9Lq+x1eP+BE/+ORvln2I+pO81YV+ojwPRJchrvEgGZ9Ovp488JsYwLRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hRj648vQ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709532847; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=Y3fZ+6vBH41DEF8Tx5lK1ddq74UM+m/DasdXXyNUDG8=;
	b=hRj648vQBg0rzXXepkUty8Sjd6mX51ieqH3bXy+Vqbz603hJxci3WwDqWftTvSH3K804OpgKE/MUQP+zPO2zAsA/DPLzWzcBLlWqYrHqJ3gpWdTbiJ/ZpXTBav2XvRbmt2tKy8XsJHauVLNEv2vtw+i4rWM3Z7d2cPVleDm9pgk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W1k7gsm_1709532846;
Received: from 30.221.98.44(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0W1k7gsm_1709532846)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 14:14:07 +0800
Message-ID: <07b62879-2445-4b0d-880a-be01a44820f8@linux.alibaba.com>
Date: Mon, 4 Mar 2024 14:14:06 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jacob.jun.pan@linux.intel.com, lenb@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 herongguang@linux.alibaba.com, shannon.zhao@linux.alibaba.com
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH v2] x86/cstate: fix mwait hint target cstate calc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

According to x86 spec ([1] and [2]), mwait hint_address[7:4] adds 1 is
the corresponding cstate, and 0xF means C0.

ACPI cstate table usually only contains C1+, but nothing prevents ACPI
firmware from presenting a cstate (maybe C1+) but using a mwait address C0
(i.e., 0xF in ACPI FFH MWAIT hint address). And if this is the case, Linux
erroneously treat this cstate as C16, while actually this should be legal
C0 state instead of C16, according to spec.

Since ACPI firmware is out of Linux kernel scope, fix kernel handling of
0xF ->(to) C0 in this situation. This is found when tweak ACPI cstate
table qemu presenting to VM.

Also fix intel_idle case by the way for kernel code consistency.

[1]. Intel SDM Vol 2, Table 4-11. MWAIT Hints
Register (EAX): "Value of 0 means C1; 1 means C2 and so on
Value of 01111B means C0".

[2]. AMD manual Vol 3, MWAIT: "The processor C-state is EAX[7:4]+1, so to
request C0 is to place the value F in EAX[7:4] and to request C1 is to
place the value 0 in EAX[7:4].".

Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
V1 -> V2: Amend commit message according to Rafael.

  arch/x86/kernel/acpi/cstate.c | 4 ++--
  drivers/idle/intel_idle.c     | 3 ++-
  2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 401808b47af3..f3ffd0a3a012 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -131,8 +131,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void 
*_cx)
         cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);

         /* Check whether this particular cx_type (in CST) is supported 
or not */
-       cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
-                       MWAIT_CSTATE_MASK) + 1;
+       cstate_type = (((cx->address >> MWAIT_SUBSTATE_SIZE) &
+                       MWAIT_CSTATE_MASK) + 1) & MWAIT_CSTATE_MASK;
         edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
         num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index bcf1198e8991..e486027f8b07 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1934,7 +1934,8 @@ static void __init spr_idle_state_table_update(void)

  static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
  {
-       unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
+       unsigned int mwait_cstate = (MWAIT_HINT2CSTATE(mwait_hint) + 1) &
+                                       MWAIT_CSTATE_MASK;
         unsigned int num_substates = (mwait_substates >> mwait_cstate * 
4) &
                                         MWAIT_SUBSTATE_MASK;

--
2.43.0

