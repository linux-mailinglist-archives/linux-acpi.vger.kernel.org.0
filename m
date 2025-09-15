Return-Path: <linux-acpi+bounces-16909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDCB573D1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EAC17F48E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAEB2F619D;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt2suhNt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C52F618E;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926637; cv=none; b=PGiBnc1d2Ehnp2L8Ub1wjmwpeJvpsDciPFvxZEKv9e3JZ4/fRt8wYDExwsb0/tRP2SW2/I9mw1KQxwLRy/IZWtDjaDeSOQ5Ca7yay3I1AZH8uVtMN2G7StxTjydRkTAmMxpN2dWcIUSkqf/CHEqLoX7yVhr9H5dSh+W3KaT01+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926637; c=relaxed/simple;
	bh=a5Pq4IyChIRNpCI1Y1MOptr/VB0oiXKYMj/CA7z9q3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rybZyS/k/utiiHNj+N2f5P5rMzzz2TCWpDXhbk9lRkqQzCQgSVwRvx1OurhhMSaSu4IsI88ZRlkSGZzQC0QIZh/bvM3GudMQgwb1ZzDD4+T2ZNRL/i+JTsRcZ9GuTs58oBZ5ZS/IRIJNdL85/5HTV08wtKtaherUf8G5+SsFqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt2suhNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A83C4CEFB;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926637;
	bh=a5Pq4IyChIRNpCI1Y1MOptr/VB0oiXKYMj/CA7z9q3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt2suhNtBryNbVM6DmZ8ZNhYrUzzxxAGTLn4ERk+k7tzEwRvzafwQ6VfjIMqfXSxa
	 8zX9+meYdetpRmN/NuHhlox0X8NsejOuszCIH316PfWfK1auIo6YbwmwWtNQdDbMZp
	 iGhDIS4rFdEyTAQBvpfRWCG7jdX83+MGY5/uGG5Jq6SWFvGce/5TcMqvmJr4ikZHXD
	 ZXFe3/53qH//uGugC3cv1IeWh91KElkNK5pj44gII5yh/mI63Vh+7/nxGKUDn4OgGV
	 ivlf1g2rRFsFP0rac7Tk9VRyo2LgaoHaouXU7B/5zujfKErLpGcX8J+EV1q27KM+ai
	 ji5DCEuT7/oWQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51P-00000006IHP-23aU;
	Mon, 15 Sep 2025 08:57:15 +0000
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
Subject: [PATCH v2 17/25] genirq: Add request_percpu_irq_affinity() helper
Date: Mon, 15 Sep 2025 09:56:54 +0100
Message-Id: <20250915085702.519996-18-maz@kernel.org>
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


