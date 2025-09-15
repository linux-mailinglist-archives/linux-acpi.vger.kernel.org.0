Return-Path: <linux-acpi+bounces-16900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F3B573C5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90A73B9F17
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395B2F3C02;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhEZNaJC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3D2F39CF;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926635; cv=none; b=ri/mb+o/UVzAa7jpdWuoR19nNWBCiSbz2yWf3sisnPr0rBolcNr9zieflgI4uoQNSmu3NA/QP+bz6SlrA1ikRVY0cnqm2/rKVG9UFDDRycK8iSi3/kU52nvT8pWXz38QqqhFFN3Liu3RmXA1hZ+VCswjKVdjYCq9kfM4Nxda//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926635; c=relaxed/simple;
	bh=jQHOrUvrdulPrMOQtn05zaOApqc5lhkt4nBzVAEvlWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG8CuLayg5HYFhfmmudVmUI7+AlKxbk510cCzXUFKFBE8eTtjJGHXk2U0iwOjs0CrxDesqFf9nzQZeIuvGkLliJ9g/Jcs4TCcYpjdxQw9Z+vB2Si8LzBv0QkrQQGyc9+7adi2OETPVWp54aFeFlcX4b0fTleg5RLzZeOyGxyJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhEZNaJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74A6C4CEF1;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926634;
	bh=jQHOrUvrdulPrMOQtn05zaOApqc5lhkt4nBzVAEvlWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhEZNaJCOef+kjuudwquagxii3vPQdIanoRj6OFfUnBUUlN8fm1rbJPQ9S/BKrvQ5
	 Zp9O5ZOgux068/m4Ixy7HyArw1cavqKQCIG38Ty619Yol5Zrpg9fcoHnpiSutswoEP
	 ZhDyAmdGgCwSHjwH3sboQ6OpDdH0E4elI7JagqhJjLI53VC2RTjb8Kqyq8VUaDSZgV
	 ts6gu2rdjlmbLjaRoL7cmjuVkxlfhkI0LTSEi4w5vHM8nEU2+7kJ+5Ll21n2HS6b0i
	 tGNT0O39khZcX2QW0P2fgLQfe3cZ7uehBs4plY/jSX62UgLhJCd2pFoxO3mhpaHt07
	 0Gmrl39nppT7g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51M-00000006IHP-3uqQ;
	Mon, 15 Sep 2025 08:57:12 +0000
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
Subject: [PATCH v2 07/25] coresight: trbe: Convert to new IRQ affinity retrieval API
Date: Mon, 15 Sep 2025 09:56:44 +0100
Message-Id: <20250915085702.519996-8-maz@kernel.org>
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

Now that the relevant interrupt controllers are equipped with
a callback returning the affinity of per-CPU interrupts, switch
the TRBE driver over to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8267dd1a2130d..c512f8faa6012 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1472,9 +1472,10 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
 static int arm_trbe_probe_irq(struct platform_device *pdev,
 			      struct trbe_drvdata *drvdata)
 {
+	const struct cpumask *affinity;
 	int ret;
 
-	drvdata->irq = platform_get_irq(pdev, 0);
+	drvdata->irq = platform_get_irq_affinity(pdev, 0, &affinity);
 	if (drvdata->irq < 0) {
 		pr_err("IRQ not found for the platform device\n");
 		return drvdata->irq;
@@ -1485,8 +1486,7 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
-		return -EINVAL;
+	cpumask_copy(&drvdata->supported_cpus, affinity);
 
 	drvdata->handle = alloc_percpu(struct perf_output_handle *);
 	if (!drvdata->handle)
-- 
2.39.2


