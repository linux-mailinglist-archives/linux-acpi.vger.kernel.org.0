Return-Path: <linux-acpi+bounces-3994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01686A8F4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 08:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC14E1C2385B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94F2556D;
	Wed, 28 Feb 2024 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QuQdgyyD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC225561;
	Wed, 28 Feb 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105297; cv=none; b=q6JVCIR7qj773YwmO9mWeSu9ls3lac20usTmlTEn73dkiYWWU7+NtQqVtKtUBYSiQAFr8HnYNjQoKxyc2tmsjj2dOoKIhpj0PjY/xwhKflo6WWitEq5r8KVWCJg3rH9JXa4YUOR2isHMPz8UnEbh6tKdbAK1/nHGtAmEcZRnFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105297; c=relaxed/simple;
	bh=ePqKn8ziKMdqjuoJwILjLschlxQ28phSyMpacK99zsk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=R+zoNofABUkg5ffcbXiBff9AOgjUMGO+vBY0nfpoB4aUgck//GYNY2lguJc4Vdj42+dobGaZSGa9qjatKUhSV7IFo/rKNc4phP0JPZvjCK/mN1BM5y4nK/A+fuiSGoVtvbnS4UxVj4IAM5PxzTo/iakyAmDMu0ycwdHzsv3IFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QuQdgyyD; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709105292; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=tTdDg6Bgbx6mgt0LyKK65ZbQOISSRCoKbVfK76KQnng=;
	b=QuQdgyyDa1UTktdRQa8IjR1u0ZntwQSgWDKijq2KIMWJDwvzLnapzrsN+eWQ0qJjezn8J4awpaVKTor/8I1jURk5PS8OXpWp9CKJqBT0Ht+joddCbXZb2muZbfThDPEyLa/CkyuZGgeYmWEd4dmO2+WYalycC3vaIfgeQstVzdo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W1P1iM4_1709105290;
Received: from 30.221.96.233(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0W1P1iM4_1709105290)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 15:28:11 +0800
Message-ID: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
Date: Wed, 28 Feb 2024 15:28:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jacob.jun.pan@linux.intel.com, lenb@kernel.org, rafael@kernel.org
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH] x86/cstate: fix mwait hint target cstate calc
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 herongguang@linux.alibaba.com, shannon.zhao@linux.alibaba.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

According to x86 manual (Intel SDM Vol 2, Table 4-11. MWAIT Hints
Register (EAX) and AMD manual Vol 3, MWAIT), mwait hint[7:4] adds 1 is
the corresponding cstate, and 0xF means C0, so fix the handling of
0xF -> C0.

Intel: "Value of 0 means C1; 1 means C2 and so on
Value of 01111B means C0".

AMD: "The processor C-state is EAX[7:4]+1, so to request C0 is to place
the value F in EAX[7:4] and to request C1 is to place the value 0 in
EAX[7:4].".

Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
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

