Return-Path: <linux-acpi+bounces-16913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE1B573D8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D4E1A20DAE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE472F7443;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnA1dcGA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE022F6581;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926638; cv=none; b=dQIYGSLC5UUJkcsNgqJ1ydxBRtLqO1ImI2LM94r7PwMMHaxpYAf/JXmccLl8s9JSsAK+qpoEw7iyIAxJRO8mMJIFLVe8IdjQe2P3+AE6zCQr0Jh5n3Af9hZManyiLeViGuXelNUGMACApqBdeEvU2Pr4N9uav/cA7+MOPpzSS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926638; c=relaxed/simple;
	bh=fWLFQJQCjHkUmgzJrwoVr3TR8ormeAz7AFVrQDQpANU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnKyWbPyAYhfTwoaCHPmQdPdP/YhgE6+7kjhhkTcVYxqetxesNIGTh08aZAYHU13swopmSgHoqtGZ/8YouQDkLIOnCHEgWoNK6fnDtSzKThseG3zOYVJa1QIorBEq8tXL6by5JkNwbZjtHxzvyznvYpQo6IzdHRHI/xyicjtGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnA1dcGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA1BC4CEFD;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926637;
	bh=fWLFQJQCjHkUmgzJrwoVr3TR8ormeAz7AFVrQDQpANU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnA1dcGAWiexuI6w+IKEAW0AKhpD9wxz1i1f364cFyecz5nyEiN4ldn27bBvVJ5nx
	 37Axx2muW1VsAJcbyYk6Tq0H51RmxyvA16KSPdQZjeIwptOTef6KXVUK+hgwFcoaJK
	 lA5OKaSwXlLE8YikuVy1sT7RK7xfh+2eHORK3Qlrl6VziHrUg1FXZoDktD78Ab7GLH
	 VLVRwMkeO+RZJM9TbILn6GfFyT8s3nZkjW7kqYbcG2E9P/PRnWs2aHUkVlLIgor88u
	 LwntpESCRIchcUHsagNxhEgBf/DpCWuHYPWQ6yLgjsaLN1CXMC910tMXRogVtohhDS
	 MJmje0oFtxD0w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51Q-00000006IHP-09bv;
	Mon, 15 Sep 2025 08:57:16 +0000
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
Subject: [PATCH v2 19/25] perf: arm_spe_pmu: Request specific affinities for percpu IRQ
Date: Mon, 15 Sep 2025 09:56:56 +0100
Message-Id: <20250915085702.519996-20-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250915085702.519996-1-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
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

Let the SPE driver request IRQs with an affinity mask matching
the SPE implementation affinity.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index a1c86a1f21427..f8763f0771776 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1183,8 +1183,8 @@ static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
 		return -ENXIO;
 
 	/* Request our PPIs (note that the IRQ is still disabled) */
-	ret = request_percpu_irq(spe_pmu->irq, arm_spe_pmu_irq_handler, DRVNAME,
-				 spe_pmu->handle);
+	ret = request_percpu_irq_affinity(spe_pmu->irq, arm_spe_pmu_irq_handler,
+					  DRVNAME, mask, spe_pmu->handle);
 	if (ret)
 		return ret;
 
-- 
2.39.2


