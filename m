Return-Path: <linux-acpi+bounces-16489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A1B49566
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A361896566
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB13115A7;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy95G8ma"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84231158E;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349111; cv=none; b=XMB/4iNs7JzCTO6xdhmKcjTyiHrKVW4G+KlqzGFGt1pQ3pwzU5nf4e1wAD5TIJGqKhuIFBNjmD+jwCNb/bQY+8eg5IQCcPGaCDU5MdgMjKAHnhjEP3eHL5K1H4nb9+wpwsVJdeCqQ4x/0frrVxmuB6ajxh8tCeo6xK+M0tcoIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349111; c=relaxed/simple;
	bh=a5Pq4IyChIRNpCI1Y1MOptr/VB0oiXKYMj/CA7z9q3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBciswz1v8hRl2G8i+cekq2UMs2byPWca75u9jI7rZMsNTtKBoF8Dn/UiR72yKXPy4rSFwCP4kuL8Vh4i1uGmvsx61ExwmV0I4lct49FZtk0T6qkCB4qpkWo6UNtchRMq0VCyZZ4V3XxQktQe2T5KLfMll3gX/6WDeHt637J+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy95G8ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F10C4CEFA;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349111;
	bh=a5Pq4IyChIRNpCI1Y1MOptr/VB0oiXKYMj/CA7z9q3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy95G8maMfmMge8QcGPbs+tYvH4MiN/OP8OT3gniHAqU2h5Ck5FJSgJ+QBhs0hqKw
	 sRikmTOW7kvJWgzdo//bRwXLGAZdl/Hb4NlTkl6VrgZE7N46g8CdH9HqJ3/KgGz9i5
	 5PEcIHYp3jbMyTm8mxarLTZRvjbaGRtsPMWdCESy5lrLSipzOQvlMxSZd6mvfsI4Ec
	 nd56LJQkuA1gcYq4WwcoZbooFMEOrbUmb/0P/2Ot5/Ljaj74JaXmSdst5pZ8K+yevE
	 O15J62feK2gLgIMi9xi390ijkPUq7MZLYnZjC9wq6PSSDbO2siBhBW0xZ37HKcEPZK
	 bOJcEkIGAlHfg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemT-00000004NTm-3XkI;
	Mon, 08 Sep 2025 16:31:49 +0000
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
Subject: [PATCH 16/25] genirq: Add request_percpu_irq_affinity() helper
Date: Mon,  8 Sep 2025 17:31:18 +0100
Message-Id: <20250908163127.2462948-17-maz@kernel.org>
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

While it would be nice to simply make request_percpu_irq() take
an affinity mask, the churn is likely to be on the irritating side
given that most drivers do not give a damn about affinities.

So take the more innocuous path to provide a helper that parallels
request_percpu_irq(), with an affinity as a bonus argument.

Yes, request_percpu_irq_affinity() is a bit of a mouthful.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2134e7c08c169..c8e6f4895782c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -196,6 +196,15 @@ request_percpu_irq(unsigned int irq, irq_handler_t handler,
 				    devname, NULL, percpu_dev_id);
 }
 
+static inline int __must_check
+request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
+			    const char *devname, const cpumask_t *affinity,
+			    void __percpu *percpu_dev_id)
+{
+	return __request_percpu_irq(irq, handler, 0,
+				    devname, affinity, percpu_dev_id);
+}
+
 extern int __must_check
 request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *devname,
 		   const struct cpumask *affinity, void __percpu *dev_id);
-- 
2.39.2


