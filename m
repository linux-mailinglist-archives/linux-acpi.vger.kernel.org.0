Return-Path: <linux-acpi+bounces-17980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC77BF12F0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49F6C34BFE8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82B53191B0;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkMJoSAj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD73176EF;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963411; cv=none; b=XpIgqHRjz4PX/5z2RnyPGrTA9FUA0yehuvfrh2Wk7FOd08e6HutShSvjMX6X+Mi13Sajh0qoiEf8kq7L0dH641VSvtDAY0Aih1lS/E1E7rBSIYT+OOCWSwU9QrWRWfxvIXKh0xL35TESm+eTS96XWCsvlcY1w0lGvh9uJ2urHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963411; c=relaxed/simple;
	bh=zX7lqDoWbyPeNyYwwY3fy1ifM5eVofZ6o0yvdnCCG24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6FvJCBhuUYd5HsN9rExyoFsrBXXN4AjjT3LI1jzCWegxoOMQe8oLt4xk/OKmcokl57LqcWi5YQBpkpdjKE9+Eh8LtDl6qTGwCKNS11j4opxTfTO9mdQ2Q92RxnTHTovCrwEwuJGQZOc/lP6/oa8LuxzcuDUoiQCdW5LuE81+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkMJoSAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B51EC4CEF9;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963411;
	bh=zX7lqDoWbyPeNyYwwY3fy1ifM5eVofZ6o0yvdnCCG24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkMJoSAjb4S+cUYm06lGp87CcNHwjoxX/lVN+U2sJveh49UH6Cc+GbNSEDWqiGGGi
	 eo3o7Jfh+a/tOpRWd52HElF2FXWXe/q9H4Ehmmu4KGhU/7tcbleeEW1cI9/5QbQ63e
	 tZpFNXKkZ6DK6ra+gBtjl4KRuNDCCvbxxzBpXNLrwVHMrg6GhJi4iji3f2tVgcHUMf
	 uo1n2kLcxUK1WMl78fB6jdF0j//3Dy12NZAw179s/HgpCl729XWmLlUGJ6EjJRDrrF
	 p4jjvZU19E/O9Laep8YDiVW+VXBWby33shSvz9YsPu3ICEhkfQyGtS348Xw+kzeNx6
	 ar3WEwdjnQw0A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1d-0000000FUu2-1Dkq;
	Mon, 20 Oct 2025 12:30:09 +0000
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
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 07/26] coresight: trbe: Convert to new IRQ affinity retrieval API
Date: Mon, 20 Oct 2025 13:29:24 +0100
Message-ID: <20251020122944.3074811-8-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020122944.3074811-1-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that the relevant interrupt controllers are equipped with
a callback returning the affinity of per-CPU interrupts, switch
the TRBE driver over to this new method.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 43643d2c5bdd0..8f17160fec442 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1474,9 +1474,10 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
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
@@ -1487,8 +1488,7 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
-		return -EINVAL;
+	cpumask_copy(&drvdata->supported_cpus, affinity);
 
 	drvdata->handle = alloc_percpu(struct perf_output_handle *);
 	if (!drvdata->handle)
-- 
2.47.3


