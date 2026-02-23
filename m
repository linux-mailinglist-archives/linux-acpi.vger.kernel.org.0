Return-Path: <linux-acpi+bounces-21096-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMiZGvnRnGlLKwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21096-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 23:17:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A817E24D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ECF4329CEBF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B437C0F5;
	Mon, 23 Feb 2026 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yv7p8bb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957437AA7A
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884186; cv=none; b=PFflxkEjsrNtgmDrXU662eMnZlvqkO5T5MuRBhYUg9wv2jOMItexwVRfLKiC0XotJsVKd/fPvpOs9qxAHraTlLcVPn0mnHFodXOctF/g5OErH3yjPdaPI/sVMtOLbVoLj2vMLKn0rKOzFfapOMqiOtlAnD6gfjX3vtL88OB3Ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884186; c=relaxed/simple;
	bh=5oZn9v4v+pnZjL/JNMMpwZvB81UtHjFOl5T7GBwMC1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdFbUDQAWqNxxWXu58pGidukHNzLHZN6xqYwk2FjdcDkJRxPY9nfZfhM+E5ntTkz2Ic0JI006tuDJ4K/tlytkClI03OHsfbgkGVaNwrA3/fim9ZS7ghxC2OiANWxq0KKvjIzyW/Sl00ki0BZxzP9moJj1fFffak/z+FNeIYe2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yv7p8bb/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eXqqyPfJ3ki5a2vh3kgDlj7p7Sn8GL5TkG1RJouXdc=;
	b=Yv7p8bb/eht84EeZ7glks+1cTeCisJhAZJsd2dWjNHXteeksMwV883io9d+MCU1ekmHQay
	90qE6VGVtUpqR7OjLiKjH2N3e79UxGU2UPtqIf3lr6kWeQ7PTMwIFm4H4Lag9EfVM38XcB
	w7g3C3YAaMk3IGq3tgHnr1P4df5E7gg=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Adam Belay <ambx1@neo.rr.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 28/62] PNP: isapnp: Check the isapnp_cfg_begin() return value
Date: Mon, 23 Feb 2026 14:00:28 -0800
Message-ID: <20260223220102.2158611-29-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,vger.kernel.org,google.com,lst.de,goodmis.org,acm.org,perex.cz,neo.rr.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21096-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bart.vanassche@linux.dev,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,acm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF6A817E24D
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

Instead of ignoring isapnp_cfg_begin() failures, propagate the value
returned by this function in case of a failure. This patch prepares
for enabling thread-safety analysis since isapnp_cfg_begin() only locks
a particular mutex if it returns zero.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Adam Belay <ambx1@neo.rr.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Fixes: f72e5c5c861c ("[PATCH] PnP Rewrite V0.9 - 2.5.43")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/pnp/isapnp/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 219f96f2aaaf..3591a2791c1a 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -853,7 +853,9 @@ static int isapnp_get_resources(struct pnp_dev *dev)
 
 	pnp_dbg(&dev->dev, "get resources\n");
 	pnp_init_resources(dev);
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
 	if (!dev->active)
 		goto __end;
@@ -887,10 +889,12 @@ static int isapnp_get_resources(struct pnp_dev *dev)
 static int isapnp_set_resources(struct pnp_dev *dev)
 {
 	struct resource *res;
-	int tmp;
+	int tmp, ret;
 
 	pnp_dbg(&dev->dev, "set resources\n");
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	dev->active = 1;
 	for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
 		res = pnp_get_resource(dev, IORESOURCE_IO, tmp);
@@ -936,9 +940,13 @@ static int isapnp_set_resources(struct pnp_dev *dev)
 
 static int isapnp_disable_resources(struct pnp_dev *dev)
 {
+	int ret;
+
 	if (!dev->active)
 		return -EINVAL;
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	isapnp_deactivate(dev->number);
 	dev->active = 0;
 	isapnp_cfg_end();

