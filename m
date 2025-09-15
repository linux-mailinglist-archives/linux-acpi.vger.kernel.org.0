Return-Path: <linux-acpi+bounces-16906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9CB573CE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A39C7A6846
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6462F532E;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwOMJ1Qs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B42F5316;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926636; cv=none; b=LBde9gpscWYteD8xJTk96a4Pa9Pcoeqh3uJUvxF8kYyzx9lL/x9X8/GP/Xx4ZtcPIm4nV8Lz+e4EDjNDbfPD6Xkx+lmr37DIpJzNtmBV6kAI37BcXtBjxzIEjID0SUCHMoPth+TXN7T5oJiJn8mz+RCvQPkORL+jsx/WINqB2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926636; c=relaxed/simple;
	bh=FpP+wQwpUSsvvoV5l0PFF2kZyltIOuG1yyX8/6val7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBA5QY0V+Dz9H0Z7STrknNs/b2xhEDKinvSRaV9qsJxqKtDm1pg8JsR2dn1daI3YVn7mMY7h/p3Tq/QK7+urJHAWq88T1bB9cQTGxS2v5q+gMFchemMqkhLSfhjorxRuxshcY+FJR6K5yEqy05Z2okrwQji0q6zDMkt+7DqgT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwOMJ1Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79BDC4CEF9;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926635;
	bh=FpP+wQwpUSsvvoV5l0PFF2kZyltIOuG1yyX8/6val7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwOMJ1QsCKHum3+O6tpah9nAC+QaK2hT3MKttI5GVKDkep/VY13D4hs+pACNcCe/U
	 D8EcTkXezdYRdovltwMnP+CYLor7PI4IgvPmqkvguLV8qzCGFntnwD0VV/WPUGi5wZ
	 MxHni98v4JFcoqLMIgfRHSdoNhyMZgo8h0zAKvvfBX4QY+sWDcchXqGTFV42Xrgrkj
	 buA+Ace9YFsWz3HMAUSXkfbSb2Nw5wYmHODCTJL0x7vziXV+wYmfwTSGT7sjT0WMST
	 84ThnVflZxJ3g424ApIBph6C4BLCP4zZ09mdViZvsYrORa2RgjwgpbPMACEOI0E2uo
	 rEDPvVpf/E+Nw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51O-00000006IHP-0wPL;
	Mon, 15 Sep 2025 08:57:14 +0000
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
Subject: [PATCH v2 12/25] genirq: Merge irqaction::{dev_id,percpu_dev_id}
Date: Mon, 15 Sep 2025 09:56:49 +0100
Message-Id: <20250915085702.519996-13-maz@kernel.org>
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
2.39.2


