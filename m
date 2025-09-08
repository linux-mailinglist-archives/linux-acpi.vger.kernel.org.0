Return-Path: <linux-acpi+bounces-16492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEBB49570
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D103B5995
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148A311C2F;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4NCKVjt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF7311C06;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349112; cv=none; b=d/VocyPM7fLAYqLSWQl/p5SuH7tkrYJ2KHIM4vMnym970CvZKTzOwBXNb7wB/qE4T1/+puU37GJBDPGwa+6Vv4d3eUOg9mqPhrzcfcxLrGNUrzlsuod+PLxSdfKqBwxffM4fxy63PtjddgWB1rob9DL1zCmuTnAGf/OTSCsRNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349112; c=relaxed/simple;
	bh=fWLFQJQCjHkUmgzJrwoVr3TR8ormeAz7AFVrQDQpANU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTBqee5v0JN+vZws6RRqkCh6qf8JW0lz53LdxgqEeYQI2AA0Fc0U/Hp4srm8UT9AMaa8jPimjZ0L2RZWoPxg6YSDwd+cf9sXpWd5stqR2qW3Uf5MJZgYo+n6t1cZGImUgWu/MU6krVXZLaYM927b1buFu1yKi784G7LQpimT6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4NCKVjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEFAC113D0;
	Mon,  8 Sep 2025 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349112;
	bh=fWLFQJQCjHkUmgzJrwoVr3TR8ormeAz7AFVrQDQpANU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4NCKVjt4aEI/Ymf/1sLgZyoe86T9ex/Kj9p4I6Z0B4AFpcvdcO6hM+A8rRNbH8EZ
	 RmoQcV6fK8rTsBiysO5qtvGmiFNmowwqmkxpW7dMavzQA2jEgm7/LIbRBYs4YpTTU0
	 fobJOXMy6OVoEgJ3HZTbA/Rxz/Tlhd7j3eoMVXcxg0hB/ZnXl9qa9DSvPU1czpJHrw
	 cd1DvYIIa88TqAb0PaEmdsd2tstM9MhINwHEWoitXAl1uQ6X/lLKnIc3yKw45Ak12o
	 Oxsa5aJfi8DKAQVBRe163FRCHh+0Hlh9O1zDOF5KHEs0E3QESaAfrHjC9YQhD7p0FL
	 sBVpFohL2ym6w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemU-00000004NTm-2rYr;
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
Subject: [PATCH 19/25] perf: arm_spe_pmu: Request specific affinities for percpu IRQ
Date: Mon,  8 Sep 2025 17:31:21 +0100
Message-Id: <20250908163127.2462948-20-maz@kernel.org>
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


