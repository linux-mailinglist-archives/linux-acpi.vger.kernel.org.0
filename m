Return-Path: <linux-acpi+bounces-17985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D7BF130E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B930F18A4317
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F731BCA3;
	Mon, 20 Oct 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuXfohmK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8B313E39;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963413; cv=none; b=fTru665jZ1zD7eR9U2awjQyzX/c1Vs+n82F1XH+PSRQpP37+eckSLIvr46N7C3Tceb+4Ck2olsxSGMxNsPjTH5Dsa8H1Q3eLaH94FTWMzFSzxy246PUCCIdP6Rdv7qDxN/Kuctm6L195oDKlxFi+enAXy94uWl5PWma53tXhJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963413; c=relaxed/simple;
	bh=q1h3des/mWBZaJqah+p6h4WNGOU+koYIJ7/5FZVosrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYKDETyv+jBDCOJwM6Q7xHpHN25JzJPl7/FhSgc2A94WylIMFsR1np6u7P6rqk1udXx58szo7UKYVCNLDb2FzYfUV/JfeL+kK5OUPv4pJV3dI6CJlMVuTOo1kl0k/2RLFDztYsHlBNtKa/pvn3/C4pha25inlcsMZ5GNWeG4pAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuXfohmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A6CC113D0;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963412;
	bh=q1h3des/mWBZaJqah+p6h4WNGOU+koYIJ7/5FZVosrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuXfohmKgI204IGoS0+aky5HAcJhTU84eFM27SgBRUEqP04vGYAoMu6oTaRfaD7YT
	 TmdyX8CPqTSOoVUZa7zbD/+CUxaBIhUT1M4/cChLA82T781x7WbzBpbZ9WxTOZjw/e
	 ixA4eYdS6YDgiTlPEhvlugo1/b19NIS22XR4hvgqcM9linZ3ZA1DDdAbTV/Alqg7GH
	 hQ5WGlbIp4Qj6tVbW3yZoeN3YUDYyXQprSwmvoFXYaPVbxdS1xwIvz+qOwYcdVFVdn
	 uzxZldKLtOH14LUz7tTkhz8mnNdWH4UfHv+cJlSdhEjv6aP31OMgaecmRHqlTf/Dvu
	 itG+N5QuouMRA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1e-0000000FUu2-3gip;
	Mon, 20 Oct 2025 12:30:10 +0000
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
Subject: [PATCH v4 12/26] genirq: Merge irqaction::{dev_id,percpu_dev_id}
Date: Mon, 20 Oct 2025 13:29:29 +0100
Message-ID: <20251020122944.3074811-13-maz@kernel.org>
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

When irqaction::percpu_dev_id was introduced, it was hoped that it
could be part of an anonymous union with dev_id, as the two fields
are mutually exclusive.

However, toolchains used at the time were often showing terrible
support for anonymous unions, breaking the build on a number of
architectures. It was therefore decided to keep the two fields separate
and address this down the line.

14 years later, the compiler dark age is over, and there is universal
support for anonymous unions. Let's get a whole pointer back that can
immediately be spent on something else.

Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c04934..0ec1a71ab4e84 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -121,8 +121,10 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  */
 struct irqaction {
 	irq_handler_t		handler;
-	void			*dev_id;
-	void __percpu		*percpu_dev_id;
+	union {
+		void		*dev_id;
+		void __percpu	*percpu_dev_id;
+	};
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
-- 
2.47.3


