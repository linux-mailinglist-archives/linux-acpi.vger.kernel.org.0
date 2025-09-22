Return-Path: <linux-acpi+bounces-17188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B13FB8F857
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA2D3A4ECF
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076F30214E;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufK8efCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F73019CC;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529728; cv=none; b=cjHIiRnqmMAWHO0hsNKSq72ERCoaFOUKj1vqnANoDhof3mDXe99Em6pX8KEHTwU4AgDQUcJuOIt68aEsA7t+yG7PcIg8Muu60nHQGlIeng9gizMtuFyGkOqB8rDxp4+Or3jH98TM5HKyB+2Y2TPU2y1YVtu/dVhW9TDVN4rYXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529728; c=relaxed/simple;
	bh=IXL+IAJnY+2vKkQwblhiCgALIEf3E4Odr7ea40In+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1j1ZTUAbqrolsbUZ2PURYIBO/7Pws5c2qcvNGvozrdvxUIcDRo5zVcquzSTODyjef9WT6CzECONsMnkO4H6hPQBQ5pM34J0WKMp2YKui9OIBBm0F2NTK2RCTIC66vv4zTa9VjvXUaX0zxK2FU2iRaHQG1x9wVJtE6XycxDxJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufK8efCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A63FC116C6;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529728;
	bh=IXL+IAJnY+2vKkQwblhiCgALIEf3E4Odr7ea40In+Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufK8efCtLc3aXcWKqIBHUVcqEce3ZIWNYDANBeCqn68VuoWJL3DqZCerRxLJx8N8w
	 14Bp/8fyRVzv8y0bP3rYIN09FE/vQfPbllC1C3iVWL2+gvLbOhBwZb9vfSttt6Rxz6
	 oO11vxLXUUqPRKTw9riZw7AjOFF3kAFvEo/R0GFjjxuvG7y5dWg7ycVWKFhcklRrW+
	 Y6nMhlekZM4hwf9xX49f3ytGQdr4S/qmbwGzJjHN+RkBTQGOaoX/10HztkrjphLAdF
	 /Yq4za5yrUbFCWQrpWlLL+QktbdXkCI5Khga2oN4VH4ljJJQM0q0BGVXro1NZyqUUx
	 U/86+wJxu6BtA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bug-00000008Kds-2GLT;
	Mon, 22 Sep 2025 08:28:46 +0000
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
Subject: [PATCH v3 17/26] genirq: Add request_percpu_irq_affinity() helper
Date: Mon, 22 Sep 2025 09:28:24 +0100
Message-ID: <20250922082833.2038905-18-maz@kernel.org>
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


