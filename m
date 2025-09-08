Return-Path: <linux-acpi+bounces-16485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5DB49563
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A3A1897161
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9F310764;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awFb+qx9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C9310647;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349111; cv=none; b=fXy/EQxhOxsUhXpYevnjzvXXohdglaY66aiFE5zoOGe5kqUgLyPXZ5atlAbAKRTTmg55iFlLAU+EhkTUaJvYQuU4336x3elH6B8CYYUqR6WyuATSHrBMzpOVDMrlBtt40ZWuIKql4yyIzyPv2kzIlMq0ggwVr/OpLLRW4og8UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349111; c=relaxed/simple;
	bh=FpP+wQwpUSsvvoV5l0PFF2kZyltIOuG1yyX8/6val7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bh18PqbRusg4VOmRM1bo40iNPyWiuAlE3OqHQ2Uf0/cY03BmCKyMBlDfbou36XgN5baHhWUlqEUpbWxlk2nCKy2vbMN4G/WuAJKn/0N8VJYvc+a4gxzEMHhoOfpAJ5FOkA8JfZa04+NuQ/daLlGSwRdb7t9ATX1de1kC4Guw+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awFb+qx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970ABC4CEF1;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349110;
	bh=FpP+wQwpUSsvvoV5l0PFF2kZyltIOuG1yyX8/6val7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awFb+qx93m7wK7Lp9ei/bQMnb/uaAZw5ZDrOiZoPp80OE+U6MV9OSM8hwjjBHFfTi
	 rE64OCFNiDXu1kVsGT2ZW8iZlAe5e/+UyMjGhlqez3PUK218SC2qcwlay2LklC1ohr
	 hOItsAIzYX2J9zRScejz6nfXvyzG2DlYf2jsO4UBYeABwuO5G60yR72Hkqb/k2mbIN
	 sSHWhUyE4MsrTggGvasug86bfzLwCmhGypdvnI/Eq/08WuUwEI9pBG7WdnSv+oEsw4
	 VK0UQANe2i0PcLJeirWelzRtb3l3d7PpWbe0uDUt/YS5N4zOI7igp3KH45poBCywRr
	 qE+HFv/n7N1rQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemS-00000004NTm-28Kl;
	Mon, 08 Sep 2025 16:31:48 +0000
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
Subject: [PATCH 11/25] genirq: Merge irqaction::{dev_id,percpu_dev_id}
Date: Mon,  8 Sep 2025 17:31:13 +0100
Message-Id: <20250908163127.2462948-12-maz@kernel.org>
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


