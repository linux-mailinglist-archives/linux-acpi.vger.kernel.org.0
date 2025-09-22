Return-Path: <linux-acpi+bounces-17191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE12B8F866
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1286418921C4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90581303A15;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSB5WA6/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337A302CB2;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529729; cv=none; b=L3xBaTGXCjmc8v1CPWddsy9ZN2/OfIdzcrLr6xfIX3oNamtgIoDWoBSk7FEjIvKtT9whpwNLeHQwtfDcX9COr15wF6IPSlz6lXFh6oUhHZaXaAQ6f0QK6H5759JXjtPCREXqWdPFjlDpJttxr/l40l5Jg1e/HkBYdM1aP9oCcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529729; c=relaxed/simple;
	bh=B9kVMS1KP6Byn0zyMEHaUwA2iK8UDNHnAZC4Pwhtp14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnQqjPQ6t/2+RvZn60ue+xHm7UJk0coyZB950eGfrCGNtN7Quv+MYe1Sf4K9Gv0veu+LSIUseUXgx9AiIQrhnzaQxCeRhyuUNmpBFEVn7MLdsu7FQDx1dYpAeuGa1v0IkJRz/vLOjF6t8W8GjNPEproVWdMT33bqg8QdMl6pGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSB5WA6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32208C116D0;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529729;
	bh=B9kVMS1KP6Byn0zyMEHaUwA2iK8UDNHnAZC4Pwhtp14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSB5WA6/7jLOB0XbcgmJdzxVvAE40Ux/TSo9VYS/S331nBFQ44dVAMHk5+jCWVdlY
	 iOHFhQgcf1rKcm8JFJ7JiHZ1pOxyqqoyWZrGlv+HSeXNiFDD8O+r4bQblSHerLTEVO
	 QzJP3MtthyrOkjidwlzhGNV+JiM7o2RjYT+nMREcCebxN6ik+wJiAuYAbVKDH+NBrQ
	 PT7PuGxO3AOwF3I4PDfInFXrPNAl4xt92LHRNENNlqyZpwfGTdoIonkHoNYQUxygGu
	 y/nGLPNjAQ9MaYJj58jc8FHKn2XUF/8GtII1iTEpF94JYbBF8gqOJoaYRXdpFv+vmp
	 CljDh0vyBJn3Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buh-00000008Kds-1itL;
	Mon, 22 Sep 2025 08:28:47 +0000
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
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 20/26] coresight: trbe: Request specific affinities for percpu IRQ
Date: Mon, 22 Sep 2025 09:28:27 +0100
Message-ID: <20250922082833.2038905-21-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Let the TRBE driver request IRQs with an affinity mask matching
the TRBE implementation affinity.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c512f8faa6012..4a84a6bc2e8fc 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1492,7 +1492,8 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
 	if (!drvdata->handle)
 		return -ENOMEM;
 
-	ret = request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle);
+	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler, DRVNAME,
+					  affinity, drvdata->handle);
 	if (ret) {
 		free_percpu(drvdata->handle);
 		return ret;
-- 
2.47.3


