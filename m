Return-Path: <linux-acpi+bounces-14154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC90ACF29D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E08189A8D2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A8A23E33A;
	Thu,  5 Jun 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eGVLB0tJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6E21B91D;
	Thu,  5 Jun 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136199; cv=none; b=Mlk0bdumg/Icf7GbuL+0DrskVR0L1D40G9PSnNGvjKvX5BSUKsxQ2J+6M3vXxOchGlHHiNHeRB661FPHgxThQxbgkPUu3FcSnIP6XvUVmykawnR7dhGFj6h1pfOthgXRBS2D/Y+ZKIwKLrJyljootNl66RLw+KvDsCQMAeCyZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136199; c=relaxed/simple;
	bh=iSSuAuBGh82thOhg4pzQZ11bbFxV97kMb3qIoyS8P0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WozjLk/mj3aPPHOT2+TatNBkU8Et7aotNMcM+btQzh82i2vvO5Q8MrSRvVLU04iRMsmiTgLp9a4RR14ooYdDZUgLDJFmW1ZVaQAWRWxX6Hmb80xAgc/GzXoe7I+XKiuaBFUzivVvmmoth9qkKB60B7mnvwyZiZH/PCXWM8c29T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eGVLB0tJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3E5E966C03D;
	Thu,  5 Jun 2025 17:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136186;
	bh=iSSuAuBGh82thOhg4pzQZ11bbFxV97kMb3qIoyS8P0A=;
	h=From:Subject:Date;
	b=eGVLB0tJyqmAsG4tVFxtuopKXVIuPNrSe3u4A4CrBtDgouZ8oDpN97yapfFCoAG/s
	 abN28SaxfFKu18VA64HAvBVh7Fqif+CWyDoydXRwj/TcaVYf88qHcs01jkeY8E+ltt
	 PQjCBO7WVQnAE5s5uvL93y2upH3SOPLPO0JXCRwN6iJquZ/IMXFCLpjeowByWTDETc
	 dM3JdoGqz6GLVCSIDy1HBLgBg+XOGbnX5XPRaMTVogPDNEamOg3w+TdkHGwhH3F2YK
	 TvlI1bEmiscCg/m2Oz1BcU/EQko7a1S3Nl8Nl5Xgpow+gTB69KuiDNLmu/WZf/yJOr
	 Sn62fY5rvICEQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 3/5] intel_idle: Rescan "dead" SMT siblings during initialization
Date: Thu, 05 Jun 2025 17:06:08 +0200
Message-ID: <10669885.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <2226957.irdbgypaU6@rjwysocki.net>
References: <2226957.irdbgypaU6@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEzSEGzZ/ONVrWENr6vcXfS3S2jicISDIUk4t6WJg+Zjj/tMsiKrH6p/W9hVn65rDd2JKDd5uTYEHknKQT2r7pOoqF3rdVD5yhK7Rprhh7g9Zvcj23lpp2rY7UCLtUpLjrE40L5kP2ENOt7F7JFMQrsU0BxCSyD9ImwCg/5uHKqloLfTfX1B6buKhq24d5iBCDj1fuCRg5EDPCCcGoXCAG/xJ8DxnVxdLMqNeA6Murrcf5yV2bVSf0qD3cTb1ZGJEaagT8ZwEZw1hwmHq4GBUTZA/geTkMBRKK8IMyXCx4LjU27eYT2E9Bi7kPkpz1heTPAWpmaTKgTxzYdBmQllqRTLWBelNPAhRVW4VwQLSx0e6PMhuUU5ambMzS8U+bwJv9/Cb+JdSWHenLDzZ5gIBEnagm6yX139s9sck0qGDMIC2y1VfZSq1I0HlNlzbDM9g+JEbxfAfNyfBUr1/iA4QPyC6xAxjLkgosUTidY1ZtgzdnnMqoSNyG1skerF62mk9N9bf0ZQL9SMZyX0pxlH5hCx1RhBz8fW0EtTwi1ytUVZmZzDcpv+j4s00gw5p2NEYVEEfbt+M/N+0uFCEdabEfzDPDSpo+BbtQQbTL7hidWb4l5Atz8WQc2QWNBHPyWMFhP7ehnyK7g2OAEFTH78IqVqkrHFk5a60Goa9VBB6cTlw
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_idle_init() call arch_cpu_rescan_dead_smt_siblings() after
successfully registering intel_idle as the cpuidle driver so as to
allow the "dead" SMT siblings (if any) to go into deep idle states.

This is necessary for the processor to be able to reach deep package
C-states (like PC10) going forward which is requisite for reducing
power sufficiently in suspend-to-idle, among other things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2506,6 +2506,8 @@
 	pr_debug("Local APIC timer is reliable in %s\n",
 		 boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
 
+	arch_cpu_rescan_dead_smt_siblings();
+
 	return 0;
 
 hp_setup_fail:




