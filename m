Return-Path: <linux-acpi+bounces-6859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F792E45F
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581671F22641
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947A15ADA4;
	Thu, 11 Jul 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UndiOja3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53515A87C;
	Thu, 11 Jul 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693215; cv=none; b=ujvTVVb95uEIftOOgkDx+HjaIkFljkqPrTwf8C0yENCpODfDFwwESO3GCUpMrXmO+wGhnRUq5v3rEJfTi4941niBMj7s3UYXxhYOIWJww2tqkqCsU6+F02ML35eKie8AEhZjfxDNTiWXZ/yE+7hwXKbGiP3mi1J+t+K1HLcXyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693215; c=relaxed/simple;
	bh=bXkbx4XI9S8xRoGMmjvhk/F6NhSDbNwIV9TJqHXo5uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ry2zm9QOKddlQL1DQ2nSmRykQfMNQpmTeDyblndBsbxgdQQ2rqMsIxZRggt/gWA1B9mvrMbyYy6ANMwS4pnjS+RiQw26uQYIhUraTEnFhwXo9eC/hpUElgGNvqmSApc/QPDUbfGxR/aXU8LVGApSQGQouDo/jiMDYmXdYNo7fdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UndiOja3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 952ffbbb51c44c8d; Thu, 11 Jul 2024 12:20:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9C185A05B88;
	Thu, 11 Jul 2024 12:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720693205;
	bh=bXkbx4XI9S8xRoGMmjvhk/F6NhSDbNwIV9TJqHXo5uA=;
	h=From:To:Cc:Subject:Date;
	b=UndiOja3SPB9b5Tn/U6FgzBq5jzVoLISHeHDa+v4TXNX/lJQFZqDNz61/EFcy7euU
	 QWTq5RnaDd970QEn9NjBAMb4eZ/4QwYXOptIOn7SJMWadxiO7/SELsyLhWDLfTUxuN
	 uoOecNFLxAonU1iSSyIVoPyhTLwf2e858tQAHXfwLIlIinKjvGFCkeEB+zFA5dZW4h
	 mGfMPw6axU69raDv4ICEi5dydH1Ae4iK8vOgvX7yXUFE6bdS2+jrEdTha14JivxWFP
	 gqXnkjR4e+pXfxFsOI2KE3CH5837cKYF1W9tEtMuL/2YJAQmtdrWj+/iLf3DMgq0Ae
	 t5pPNrySDfN1g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: [PATCH v1] irq: Set IRQF_COND_ONESHOT in request_irq()
Date: Thu, 11 Jul 2024 12:20:04 +0200
Message-ID: <5800834.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvfhgrnhdrshgvhihfrhhivggusehgohho
 ghhlvghmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The callers of request_irq() don't care about IRQF_ONESHOT because they
don't provide threaded handlers, but if they happen to share the IRQ
with the ACPI SCI, which has a threaded handler and sets IRQF_ONESHOT,
request_irq() will fail for them due to a flags mismatch.

Address this by making request_irq() add IRQF_COND_ONESHOT to the flags
passed to request_threaded_irq() for all of its callers.

Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")
Closes: https://lore.kernel.org/lkml/205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com
Reported-by: Stefan Seyfried <stefan.seyfried@googlemail.com>
Tested-by: Stefan Seyfried <stefan.seyfried@googlemail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/interrupt.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/interrupt.h
===================================================================
--- linux-pm.orig/include/linux/interrupt.h
+++ linux-pm/include/linux/interrupt.h
@@ -168,7 +168,8 @@ static inline int __must_check
 request_irq(unsigned int irq, irq_handler_t handler, unsigned long flags,
 	    const char *name, void *dev)
 {
-	return request_threaded_irq(irq, handler, NULL, flags, name, dev);
+	return request_threaded_irq(irq, handler, NULL,
+				    flags | IRQF_COND_ONESHOT, name, dev);
 }
 
 extern int __must_check




