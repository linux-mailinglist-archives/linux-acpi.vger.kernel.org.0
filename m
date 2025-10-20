Return-Path: <linux-acpi+bounces-17992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F690BF13D4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FF43ADF32
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FD320A0B;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ile+P+67"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42C32039B;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963415; cv=none; b=oaVBarYNl0i4jw2Qa5gkcZwrFfd/UegLCLPJjms4zy4rq6ehtXVmr7z8JUbIaD3KXPDuNQj3Trzw+7bZMgTQdPdrUIZpWexxJVSgnwI4TC/KY/s8JnAA3h0b3ShdCXc93QAxRziu5Y2ppgCvxAUg5PtkJrDJ9vf7FKXfbLaPRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963415; c=relaxed/simple;
	bh=SD2Umc58RAYBDBTzYKG/F/oMtl5Yq55ujhMJL6VW3lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBPhBMQS/8G5mJK0lldpHJucX0vr6BzQN5KjTYhnQ3QtQko52dTYE8EPt8hl3CpNpFjZKFgT3ueydc3Kjmwrk0wGSv0GUeTES9/RVIIGkhaKBcjsJ8qwquF7EGtFe60YDhPd75vhyPd0Y8xpAVssU+iiUIRWu6IQZPGerAe2f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ile+P+67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51595C16AAE;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963415;
	bh=SD2Umc58RAYBDBTzYKG/F/oMtl5Yq55ujhMJL6VW3lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ile+P+67iCccGOyk8MsETfiEbnx1XINkCvcKe1oS0JLCfbTSO6bT5eLL1vmiGqjlY
	 hW69mpFQsuZRRCUr2MHzNB0BplAZGaajF29Ib6eGFJZXT1zTgDOaARtI5ANTmyU+ZZ
	 gGpQzF7tzGoVsvXdCoj9vcONOvx8w2RIZQ/6e9LIOQFFVTTnLBxUZXg/jbtMlunIoV
	 x+ksrfeGMsm+ki0fYJydhWoCovfcZYBckl7k4M/RZTqcnzQY8f8p/sJX4iAcFEOzgf
	 7PivfJRjM2RCYW1FPjrehrX+B3Vbu0YmNghcWa/OLZn7wKelAP5ha/bcGar7EA8QQO
	 DrJtcUBDZH4KQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1h-0000000FUu2-1rqN;
	Mon, 20 Oct 2025 12:30:13 +0000
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
Subject: [PATCH v4 20/26] coresight: trbe: Request specific affinities for percpu IRQ
Date: Mon, 20 Oct 2025 13:29:37 +0100
Message-ID: <20251020122944.3074811-21-maz@kernel.org>
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

Let the TRBE driver request IRQs with an affinity mask matching
the TRBE implementation affinity.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8f17160fec442..9f64f463339d6 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1494,7 +1494,8 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
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


