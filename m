Return-Path: <linux-acpi+bounces-14153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E703ACF2A4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD643AF12D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBF1F4CBB;
	Thu,  5 Jun 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="b/SLqO4d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAD194A60;
	Thu,  5 Jun 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136196; cv=none; b=PwALTIqZSduJA8Hg3qfZ8LuWDilcw6ZyxLs59+szpa4VpGL6r/CGn8CheBp4dbucdQ7WJa5p0vcxur1UyQDbD1zvNatRzuisqGNv0MHElczbXrf8lMbqrMoAfhSOLvHVjtJ3woSxAJsOnJflGi1Ho/5rQ1cKneNmHajDlkoDwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136196; c=relaxed/simple;
	bh=bUZAefnMoQ6GyPP0LPJ56AhGcZo1AvmNMwPv/Ep77s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC5ADN592nsjStMMvtf3S46WtArhoUGinlY7OHgAzt+pes4dj5iKTma5a779kFE1N/nA5OUqLlDv9WluM1JXKM/kNA6CTgZE5X/V03VUFev4BK9VlSoTLHL9MKLLV6hN0VzNlvjHHR7GFwNteubUf4V9bhGlb4qoMUMSb0/5VGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=b/SLqO4d; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 25F0166C03A;
	Thu,  5 Jun 2025 17:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136185;
	bh=bUZAefnMoQ6GyPP0LPJ56AhGcZo1AvmNMwPv/Ep77s8=;
	h=From:Subject:Date;
	b=b/SLqO4dkgIS3CV1d41iGGnvVFhMbaQUmU7OjKM/ZhhMVeJtXoyHxMsz+jR/weZqg
	 Vo8H9Dbm+Zly+mvWbOKm+7wvFfxjNGfGcs+49VZgueNCJUzhrgNksGZcihOUkW7vfT
	 xGNeLYSVZ8t32YWM4yhE7JtpfPFT+IGcskIKOZihXs7NPH4NXisa68T7J6DjFwq66e
	 5gXgqoA477y8tUCQ9+Chs+B+Svq4MuqSAdAxQ2oGXIDULuV/F2iFUSLwrrP6c1Kh3x
	 W+K9BozF/5fyw5+i4QzzUlK3iKLNh/wStkSOEK9uGI3YHdeWri6F0icoow10qaHQwD
	 rJhw2txD083QA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 4/5] ACPI: processor: Rescan "dead" SMT siblings during
 initialization
Date: Thu, 05 Jun 2025 17:07:31 +0200
Message-ID: <2005721.PYKUYFuaPT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTEzSEGzZ/ONVrWENr6vcXfS3S2jicISDIUk4t6WJg+Zjj/tMsiKrH6p/W9hVn65rDd2JKDd5uTYEHknKQT2r7pOoqF3rdVD5yhK7Rprhh7g9Zvcj23lpp2rY7UCLtUpLjrE40L5kP2ENOt7F7JFMQrsU0BxCSyD9ImwCg/5uHKqloLfTfX1B6buKhq24d5iBCDj1fuCRg5EDPCCcGoXCAG/xJ8DxnVxdLMqNeA6Murrcf5yV2bVSf0qD3cTb1ZGJEaagT8ZwEZw1hwmHq4GBUTZA/geTkMBRKK8IMyXCx4LjU27eYT2E9Bi7kPkpz1heTPAWpmaTKgTxzYdBmQllqRTWWWLh9bdarQACukaKKD1gzL4waUdt4/zs1VIPKSdqhTq/U/RVz897VTG9yYY8jkWxQq6PgqADFxzcZK1Xbl84dnPBPiNZZJp2JKO3TrdgQRIF0ftcWkGnuwtdjNGmbFzYx0xs6DyphKqnpfw0doJg/j4R9j02/CnAO0VHZgdc3XcoNq5AfMwnKkkfMlJ0VVvqv0agcecjwk98bxqwjhsD7SzajVr+ob2CJh5RClOTDUea/jBX/8ymupS2mmL96AXsULSd9hO9Jeu+zaC5gH8Q3nNw0PWwvWhQgNX6sclo7xfsl+qVxK82MnU768YcP4Apk++8jWA1uH4MOmnZrpnjw
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make acpi_processor_driver_init() call arch_cpu_rescan_dead_smt_siblings(),
via a new wrapper function called acpi_idle_rescan_dead_smt_siblings(),
after successfully initializing the driver, to allow the "dead" SMT
siblings to go into deep idle states, which is necessary for the
processor to be able to reach deep package C-states (like PC10) going
forward, so that power can be reduced sufficiently in suspend-to-idle,
among other things.

However, do it only if the ACPI idle driver is the current cpuidle
driver (otherwise it is assumed that another cpuidle driver will take
care of this) and avoid doing it on architectures other than x86.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h         |    6 ++++++
 drivers/acpi/processor_driver.c |    3 +++
 drivers/acpi/processor_idle.c   |    8 ++++++++
 3 files changed, 17 insertions(+)

--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -175,6 +175,12 @@
 static inline void acpi_early_processor_control_setup(void) {}
 #endif
 
+#ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+void acpi_idle_rescan_dead_smt_siblings(void);
+#else
+static inline void acpi_idle_rescan_dead_smt_siblings(void) {}
+#endif
+
 /* --------------------------------------------------------------------------
                                   Embedded Controller
    -------------------------------------------------------------------------- */
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -279,6 +279,9 @@
 	 * after acpi_cppc_processor_probe() has been called for all online CPUs
 	 */
 	acpi_processor_init_invariance_cppc();
+
+	acpi_idle_rescan_dead_smt_siblings();
+
 	return 0;
 err:
 	driver_unregister(&acpi_processor_driver);
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -24,6 +24,8 @@
 #include <acpi/processor.h>
 #include <linux/context_tracking.h>
 
+#include "internal.h"
+
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
  * available also for UP (on SMP it gets magically included via linux/smp.h).
@@ -55,6 +57,12 @@
 };
 
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+void acpi_idle_rescan_dead_smt_siblings(void)
+{
+	if (cpuidle_get_driver() == &acpi_idle_driver)
+		arch_cpu_rescan_dead_smt_siblings();
+}
+
 static
 DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
 




