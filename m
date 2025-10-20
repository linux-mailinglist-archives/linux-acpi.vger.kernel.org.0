Return-Path: <linux-acpi+bounces-17993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAABF132C
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BE618A43EC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619E320A0C;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="booUqgsr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9B3203B6;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963415; cv=none; b=ahQ+SiEuBc/jhMs2wg7b30bnU9XNxd0PO9aaxIarUt0glRo7oChKgcP7AAl/RGAJ86EKKa+NNck4fuZdSJeBwxBZ2t0rRlMq/mNQkUX8/1M7wT/TrQgNUMgW0jrFpP2+iBnr8gYQTK0YrRwxeHt1shNitbHAmGIgKiVMwR7ZgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963415; c=relaxed/simple;
	bh=Z4H5BsUqrowzozLwQNmNb98DvlFEdBawk1MycZ0axyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPHZIaoefpaN7lCHzgjaNI59xgXFnW0EPadgduMDuR4Xqb2P7ShTfXA0Dvd6FEOK6ztdREM0nG9lCvnTa75EKvH6hUaJC06PgYJ/dtAKUE2bRmGgf65zNH9JwBZyvE4fas3d4D55eSVOVN26pSpmzBPZltpOu9eyR+nk7iPBWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=booUqgsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1442CC113D0;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963415;
	bh=Z4H5BsUqrowzozLwQNmNb98DvlFEdBawk1MycZ0axyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=booUqgsrcMGJd9IyHOLMkyyzapma72ctsEsDKJAvFgNtx+gYb3cAcj4bmqfrmxu1F
	 Ba22RtLX1HtxOI8H7kEuSFZ6oMwHpOU2ovTUmraQaLCE+jSSpgsTPxqRFR5tQB18M2
	 nTjbU/LFugGslOBPJjo2Tec4zHuGb0C4vVaybgVmMPWaRBOV2KFPyJ2CYdS5IVXeQi
	 AICja+9wm8hfjWJvxVFf22OYp6WnspIQUA/hHmYIR6MAZEtfVw41E+GhNbCYaN2U1w
	 aOpJj9G98PPRqxXyaBQQkE8e2fXOHGc9S+GAPbKToByEGKBQaMpB1fiEGEBZHMZT0n
	 /6lVXODGKNZuw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1h-0000000FUu2-0bcz;
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
Subject: [PATCH v4 19/26] perf: arm_spe_pmu: Request specific affinities for percpu IRQ
Date: Mon, 20 Oct 2025 13:29:36 +0100
Message-ID: <20251020122944.3074811-20-maz@kernel.org>
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

Let the SPE driver request IRQs with an affinity mask matching
the SPE implementation affinity.

Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 1460b02d20e8b..87908f0712c0c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1259,8 +1259,8 @@ static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
 		return -ENXIO;
 
 	/* Request our PPIs (note that the IRQ is still disabled) */
-	ret = request_percpu_irq(spe_pmu->irq, arm_spe_pmu_irq_handler, DRVNAME,
-				 spe_pmu->handle);
+	ret = request_percpu_irq_affinity(spe_pmu->irq, arm_spe_pmu_irq_handler,
+					  DRVNAME, mask, spe_pmu->handle);
 	if (ret)
 		return ret;
 
-- 
2.47.3


