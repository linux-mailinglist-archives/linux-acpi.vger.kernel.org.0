Return-Path: <linux-acpi+bounces-16491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16FB4956C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BB83B739A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1731196C;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb5GFOK+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA0311950;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349112; cv=none; b=QmE927BzwmNRVnOtcK6bdJvbJRyfo4Nt1ge//7mNn+n7H1D+S9yM0tuAN9uaSZrKvclnLIq1b7S8u+WKkNjwHdy4XkIlsPEfDDCzSgU3OBbzbEneQtCBG+4IQwQOB099q4ncs2fX4EAQqIDZSANjUTCx55zd8NwsC/zrV1pevTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349112; c=relaxed/simple;
	bh=34uZqtOIifxx7Qodt8KhbqZ4rpIhHdbh4fyeIBhH5VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOsEeg6YJogTiAlE/qtgwcoAXZ5yMnkXmj7OQgxdqH6nluNAGsQ6DuIWGEjhUxf+GffUlqn/lpoDqJu6L2wm/BQorlCCEoN5eQ7Jn+ovLIKammDd4ADiZwRoGdfDJ+U/0Q0tGsBBi3pX9mihkDzVY6Ym6NfzfTX1R/Omky84bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb5GFOK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D7C4CEF9;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349112;
	bh=34uZqtOIifxx7Qodt8KhbqZ4rpIhHdbh4fyeIBhH5VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb5GFOK+rgyb5ds0tm+g9TuE1oDCmwFV0CBYo9vFZmd8YHy+ziAnur9Fc0uODcq70
	 VlsYxCDDb6mG7ZJxKyMMK3rmARq3vK8/t017NkWGz51+sLNQ/tbyU1cZ4785d0cgdP
	 dZJ2pic9pufNEpJhKg12mQYKuizvSp5N70lC7u6F7zwwmk+7/chpac0c4Q4iB9ouFf
	 fAZvTLW0SJVGcXe71JKHtBEW6DOnA3pl/7/I2HGwajKbthlS49V1Bgn6glOP3n9UeB
	 2kYD1UZd2Hv941e5oe83PqpGPd8Hgyj9JXy0671n1EKGxoVaGclkrNLTeDJVMcYKUF
	 cOgOpex6toBMA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemU-00000004NTm-1jcW;
	Mon, 08 Sep 2025 16:31:50 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 18/25] perf: arm_pmu: Request specific affinities for percpu NMI/IRQ
Date: Mon,  8 Sep 2025 17:31:20 +0100
Message-Id: <20250908163127.2462948-19-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908163127.2462948-1-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Let the PMU driver request both NMI and normal IRQs with an affinity
mask matching the PMU affinity.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 044c9c6296997..0d64e929d9bf0 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -679,13 +679,14 @@ int armpmu_request_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu)
 		}
 	} else if (armpmu_count_irq_users(cpu, irq) == 0) {
 		err = request_percpu_nmi(irq, handler, "arm-pmu",
-					 NULL,
-					 &cpu_armpmu);
+					 per_cpu(pmu_affinity, cpu),
+					 armpmu);
 
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
-			err = request_percpu_irq(irq, handler, "arm-pmu",
-						 &cpu_armpmu);
+			err = request_percpu_irq_affinity(irq, handler, "arm-pmu",
+							  per_cpu(pmu_affinity, cpu),
+							  armpmu);
 			irq_ops = &percpu_pmuirq_ops;
 		} else {
 			has_nmi = true;
-- 
2.39.2


