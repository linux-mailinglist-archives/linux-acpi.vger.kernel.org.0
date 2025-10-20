Return-Path: <linux-acpi+bounces-17989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327EABF13EC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2001C3ACB36
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731731E102;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA/9vGx+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DE31DD9B;
	Mon, 20 Oct 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963414; cv=none; b=URTPIjqweIW2Mo9IupUQBe6PuKvkPlSDfL22StZ7v+IjYCYwrp/w9bLTJfZgbgUxO3AecHQG8c6/MXr7S94ZNCRr5Wfksr5XXFbOySlRlNLVqFveRK6RXkHtO5d946PkX4y9yFMP+QLaoHr9siLJHNx604fLGbW42ZD7AI3OEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963414; c=relaxed/simple;
	bh=oqk3bWnV63Av2DQTlB+h2XdFTNKY9wTJHCjcd1AWrDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+2gqx157eutUYF6DnisTMOizezoJbo85LgwqlU776FGUp1YNnr07u2hLLGWmJ9JAjzIKAQATzvwEyGacrrwnS5YCfl5sAbVpygoFSQPHG2cLlLl7IUmM0KFDwaJxXEEG2v7nBaMitxzYJVqE3d03Yv6BTOgQW3PMUnaBFR3rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA/9vGx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB4C4CEF9;
	Mon, 20 Oct 2025 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963414;
	bh=oqk3bWnV63Av2DQTlB+h2XdFTNKY9wTJHCjcd1AWrDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA/9vGx+DnBcwLaW2vU4NgSiYx7JB+MQqwoUadNfYchgOUrPpUsRrImcKdGV014p3
	 lw1AcCZPPaKBLL5VKtu7tGSZoFeK4ycQfkZKXnkCqs5rlsWRUsvtzmhKgVL9J4keYl
	 OD7/Hn37LcLLEkQE13gzbKq07daVouFziGbtCf+MndDoLDTFYU3ir2dnsiLYZpPt0/
	 o/Eya/SkZMGM8DxPgcULI4pY6MtRNAh6ZT5dHlj2cl9svcOu6wgKTBQLoPXKCjMVbY
	 5x7nIIcc7YpeUT0fldtujEoZmHAnWLA3/bMh7CKR9sI98ZBVekS0yeEE2AgUejrV2M
	 0gOsabYUF2Jag==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1g-0000000FUu2-28CJ;
	Mon, 20 Oct 2025 12:30:12 +0000
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
Subject: [PATCH v4 17/26] genirq: Add request_percpu_irq_affinity() helper
Date: Mon, 20 Oct 2025 13:29:34 +0100
Message-ID: <20251020122944.3074811-18-maz@kernel.org>
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

While it would be nice to simply make request_percpu_irq() take
an affinity mask, the churn is likely to be on the irritating side
given that most drivers do not give a damn about affinities.

So take the more innocuous path to provide a helper that parallels
request_percpu_irq(), with an affinity as a bonus argument.

Yes, request_percpu_irq_affinity() is a bit of a mouthful.

Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 81506ab759b81..fa62ab556ee32 100644
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
 request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *name,
 		   const struct cpumask *affinity, void __percpu *dev_id);
-- 
2.47.3


