Return-Path: <linux-acpi+bounces-16914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794EB573DA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A77AB3A3
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2E2F39B5;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDp0tfF6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A92F745F;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926638; cv=none; b=Yg6Mxf5T0PAeugCpS8tJEqaJU6+1IS1BOaceFdzrWrtI3jg0v1A+fvfZZRwLVlk1vE6bOb7IEg0o9tTjuqmYSZ5phgtA6MHxy5Y6/98v2ZWMdPrKwAxOEOdEMZMMaTT+UOWPSzw3tcXLAmX+yoDaqubKycZxnDdHO1EfP+vwdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926638; c=relaxed/simple;
	bh=Cd0M6Ctqz2mIs5KmsrNG7gPuEf0W9llFNTYE/JJTtFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srxUG13SaaeQBtrGJ+GYKs4HxFQ3PnTx8kLLSKeHVON7vgznfwaRGcAmAJkzq0nQWADUpd9Ul3n324Ge3RM/BkBHCVYrQeJLuF8eU5XXXfp/yq1xPM9MozlBxKQlCiGuFURlHOm0WtZ+GomYcvMqfKdnDigwzZurCODwgV1xdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDp0tfF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261EDC4CEF9;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926638;
	bh=Cd0M6Ctqz2mIs5KmsrNG7gPuEf0W9llFNTYE/JJTtFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDp0tfF6k68R8ROhzn5O52Xa2JXOkXJe0iGU44AyngmY9O4NJhu91UZvWywCLWgqe
	 MBbDYisBTdGB6+tfyzhYubwaR+ncKGJhpObY6LXNKLViCK6XYTl+6Y6u5C30rFBwD3
	 odeALTB/iFNRpYe/uQNdDUOiOG7SXyIUkO0Z1bGSVgQ2s5e7vkvV64VxG/gsHVVCu6
	 YYtGU2VhlYdSnnvarqXJ6B0l7L3613AKnHLUJR6TEFUt72D73pDntzCdZPK6VeIkCy
	 yb4P7bpqMGjg9wrdlMm5KU1U5ffP5EfhSMS1aK24oQOpu1rjuhDwEw2+mIzBHHxVun
	 Luijc+/ENQxkQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51Q-00000006IHP-1REL;
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
Subject: [PATCH v2 20/25] coresight: trbe: Request specific affinities for percpu IRQ
Date: Mon, 15 Sep 2025 09:56:57 +0100
Message-Id: <20250915085702.519996-21-maz@kernel.org>
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

Let the TRBE driver request IRQs with an affinity mask matching
the TRBE implementation affinity.

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
2.39.2


