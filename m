Return-Path: <linux-acpi+bounces-14444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC507ADEBE0
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A01188FB64
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C52E9ED9;
	Wed, 18 Jun 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GkK37ofw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8C2DF3E8;
	Wed, 18 Jun 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249077; cv=none; b=dnaXWWXsgNRrtyS71k01h4T+uTDnj16Njn8N+czgZR8DUF38UhLUvheMJXGHeQL3VhL7oBVIqnkeIun6/8So+UMZ6VX9IyWxd4ytg19lvXuL4f/ih9KZQYPG0Q3Vqj5wqMUlMMvWX9hjFj5OXZQ1Kmsco6KLljpb4VrkxHfbrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249077; c=relaxed/simple;
	bh=qr3/kjwLFylG6ywry69iDYJGlppx2JuUHVeJAZ5YGck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGPb+7D0QmRfmG5/Pg1oPYh8+298wjFpJtT0jaS/QigwLx/Hbl8pgUDfaGWu1llyBqnFoyArQAVuxRqged4CeU6U29qMjG+l1oIH/I5V9YCSSzBHxngXulhaHfnEQJwoRtB15ZWynB13PtAuy9HswWAM5r9gaBgBg9ZGcLCwd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GkK37ofw; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D537466DF26;
	Wed, 18 Jun 2025 14:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750249066;
	bh=qr3/kjwLFylG6ywry69iDYJGlppx2JuUHVeJAZ5YGck=;
	h=From:Subject:Date;
	b=GkK37ofwj4Eo4j/3VBAP6iJsgOTaK3/TTbEKVn71nhfhh3aN8hpk79g6wGxsQhL5i
	 DOMOF5lO1hjucslpe8j7JJM9R3T1B0potQH8XjXhaT/wNmmQr2NgUVrww1On5+5odP
	 iSdJHysGltv3BnaKJF+fzT3QhSRHCilq/yqpFFnKuUM5CXeRS5KIOdSpcRuvdU0Iua
	 n0qvbx/N0X/UNaA1nh/4V14RB0mClXVLlDudsgavb6bU4H8gA+PtKGpHeZ+q2IqeTC
	 t9qVFFWRGNPl023VeEgwPY7ejjczjF+HF78JNf3LcMUiPJgRttAKg/XoVxyChJmSHA
	 4QnKFzrKWX8fA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Peter Williams <peter@newton.cx>, "Dumbre, Saket" <saket.dumbre@intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1] ACPICA: Refuse to evaluate a method if arguments are missing
Date: Wed, 18 Jun 2025 14:17:45 +0200
Message-ID: <5909446.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTGSdzENJcvV6kGmthZjDnKCac5iu4OOazHJo9JnKE4e7+Uye2DtxC5ELcPNg81iFw3RUc23yIxhNrNPR0Wwyyca6aie5TMoD7weryqNnQclYUHNyIQXzRjZdfd3VrWP6tc5xQa2Dh5q2eskkdnqNjmR3s5qoMjPweUydZhPgtdRd43tKixj7QV7WRmdx3k8Ir4M/6GfVSA+rtxAgZRdEvnNPSmuXpZwdyn4sGEk7cAgaloTNgIfH4/D2s2bgIHScFzouGHrCRhFY0wq8e/3MX0JzvCm+DXbJHrumKjViJUhftRb2eh6ywS/YXEa87JeScQL5KOSyeI1f3lVjQnKZFXyCqqRnwGIrQqSlkT9pEh4NqLiJmbVaNXSn6vTnn3h++A5XcnHM7PLiptvxmZCXqzwPFXCLzQeubzE1WLgm1w8KgteQ2joJrk57ZtRL15dgwZBgXUYIsU2P9teUDEu+x/dsOgWOoRINkvXLQlrKYheEvovBA7ynTcgSyP6z4tFBFPS80bIjU01+PgfpVZOJ+edXFz7WFfNBiGdLuVE8A5DwzCK5Veq8SvzV0vlU88CwoJ4WHl3HzX7K9WtiTpvpif6r3hOgB9L9X7qMayJh3/9//QrCyRG5Bi7GmWM03us296fM1SDLCgOu/IiiCC+F0N6wRaR9zN4lXJpgb9UUaqmhA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As reported in [1], a platform firmware update that increased the number
of method parameters and forgot to update a least one of its callers,
caused ACPICA to crash due to use-after-free.

Since this a result of a clear AML issue that arguably cannot be fixed
up by the interpreter (it cannot produce missing data out of thin air),
address it by making ACPICA refuse to evaluate a method if the caller
attempts to pass fewer arguments than expected to it.

Closes: https://github.com/acpica/acpica/issues/1027 [1]
Reported-by: Peter Williams <peter@newton.cx>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is an exception as it fixes a kernel crash on multiple platforms
affected by the defective platform firmware update.

I will take care of submitting an equivalent change to upstream
ACPICA later.

---
 drivers/acpi/acpica/dsmethod.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,6 +483,13 @@
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
+	if (this_walk_state->num_operands < obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+	}
+
 	/* Init for new method, possibly wait on method mutex */
 
 	status =




