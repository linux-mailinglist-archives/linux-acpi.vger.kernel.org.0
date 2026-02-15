Return-Path: <linux-acpi+bounces-20991-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Hk1JOawSkWnuewEAu9opvQ
	(envelope-from <linux-acpi+bounces-20991-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 01:26:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3096D13DD29
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 01:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCED93012CA9
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 00:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDE15ADB4;
	Sun, 15 Feb 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b="gsQ4E17T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523942AA9
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2026 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771115176; cv=none; b=uJyOmV7s5MPUX86/vP9h4142kNnlhDvz+pkBafaAWbGw6rfKJrmhw3I/W3+dtbMR4MmxIln/4pAvLjTnQy6PKlhPs8S7ovQOE98lBRoRL4WligyqXFZM2UXktZpfCyCbzuOQC1GP9e2lZx28381V88TR92Gixv+S12F4FTEvVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771115176; c=relaxed/simple;
	bh=BA7IXASyatxN7ATnwz5oBY0lvRBTyAWwqOBOPpIobJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IX+swfwvBa2MZGS0UFPYXfLqtc9AKNqLyvgNq/WB0Suko7tF4MqkyOTr5AuSmAsu+9WNwgjz/kNN5Gr6N1/GpM/zLgmEfJUpVH3xX0ydbhAyXEUiNtLQoXKpXezXiPU6mgGfd54vWnijW3RS1s0lGlMk7dqfCXqEo03J169ISII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai; spf=fail smtp.mailfrom=jingkai.info; dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b=gsQ4E17T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jingkai.info
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483703e4b08so15525125e9.1
        for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2026 16:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingkai-info.20230601.gappssmtp.com; s=20230601; t=1771115173; x=1771719973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0jTOTpzRNgvZbFYsQ/NORV3ipGEtXBuTe6jH4JSjbE=;
        b=gsQ4E17TaNmDaLiKfrqNCriDL4e8vKpkR16tbncPZ0cERvmGRQmb3TzODgWdaaC+Vz
         DGFGQ7cWA+xow9g4fotDXhbLWmb426rKOZa+enWNAxUHO2RrFzeLWe2YCR1kUrJpY7Hb
         PDAG2xgFUyMIaqhL7hcWbtYj796e3sru6rnFiPygdqzTUxcLD56ccpf3SCVGADUwKl5z
         5DUSmwg4nkxwVCXnDbZAEa/iMjExzNOd8aWoet7kgRnhxAIUgt7DG8Lokq7K/dTbo798
         iCKGjSPN2XlGUFnX5RiTMevAaJnPco34I3vUn9WvMpSBagbBULPOrOpdXWGMshV+s84+
         hLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771115173; x=1771719973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0jTOTpzRNgvZbFYsQ/NORV3ipGEtXBuTe6jH4JSjbE=;
        b=od3+irXsQsRK6CZRXF9SVaRsxjr2nBz7kisNcECLiSe8G+xXtHgOf8+PqUVfK+j/aj
         XdFASbJ0bgXF0BOmBPhPxXrv7djdJQyHuZNYc2uvBduPMizCQ0hBcOthqqixumhZPWsm
         a+N8/tawVKJfwy2wQzVFMNyj8fGVM/vT3R43Qz49jZNlyvKIMQm7QyLvhOpmnrDMr95g
         l5tI53FWRRWA0F3Yt1OBCcglIa2WO4Jr5NMMeA3XIy+BlSlsnmz2AKXRNM4Z0UNEEo1G
         IglpdklgcpzTRooYgHNJS5jRieVxbU7et5R5K3xH/1uNg0GvvYVvczSWc9lfnhTSX1mJ
         gV3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2UgpmRb3K+2DYCpfilYjARF6b2h5s64PhKab47VPtC6nWEBCePrlpBVYDIkKei9ParQDqJnwa8wZU@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQfHi5A4LzFZCevHxMpUVAccdzkNqF9WZtgJuRSvdhy2W1JmP
	Fcx5P1mLNbZIWFlFeS0lNKAJQCYKaYkMhGz/dy1fb8mM/icqMCoWUHYkNZxGvjmbWPHYZQ2a2kU
	kUzt8uQ8=
X-Gm-Gg: AZuq6aLcXYFeRC0QyW1TwChU7e/10gL9+RcBpjmcW21Y+oLOsPySPZtsxHODkVWAE6r
	XWS2PbvNIVslTloIuH7zf4hZRecoWAya2fWklUXMylWXYtF0c0wiip2iuQRA/Vbfpduzdo/EWb2
	IX9nkD1uKFWhXnd+pcm3jzkCffT9KmkA52NuK0IN/iVlT/IzqkFvW8yRjmtnXRChk3Lpi8g8/gQ
	n8p5TOncdXqVaqsp2BpWUjbxQRejhlIsQ1c1PXbPzd9lir8wl5/av/w7fuuAw6rgbfBkelEaq5e
	R/wkX690GLiQO1YU8fgLvK+P6OgduvpSvdhUlPZyJY1aGF37PXRFS64gmC1tYmi6ikBbNXo86L5
	xv4b4N25pWDUHAGOsl21pOT4q6ETL0DLhUea0PBc2MQdIVffwqGEgTlejBIRonZn5CtuC6hShEW
	Tg3jzcyQBRyXaxaHHQJY2l6nK326WbooGDQuKE4HPksCZm855b+tjDa4i8Se6k1kpdttQNI/1rN
	7bygj0ovQX9ETDnle7RtNkFJlVVbJbkpNdu6lv5lXvnVekjCuSwuRckXrpMsCJGQv8D
X-Received: by 2002:a05:600c:3acf:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-48378d6ab64mr80523345e9.5.1771115173257;
        Sat, 14 Feb 2026 16:26:13 -0800 (PST)
Received: from localhost.localdomain ([140.228.89.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm396568025e9.6.2026.02.14.16.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 16:26:12 -0800 (PST)
From: Jingkai Tan <contact@jingk.ai>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	Jingkai Tan <contact@jingk.ai>
Subject: [PATCH] ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()
Date: Sun, 15 Feb 2026 00:26:08 +0000
Message-ID: <20260215002608.54934-1-contact@jingk.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jingkai-info.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20991-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jingk.ai];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@jingk.ai,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[jingkai-info.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3096D13DD29
X-Rspamd-Action: no action

The inner loop in flatten_lpi_states() that combines composite LPI
states can increment flat_state_cnt multiple times within the loop.

The condition that guards this (checks bounds against ACPI_PROCESSOR
_MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
within the inner loop between outer loop iterations.

Add the same bounds check inside the inner loop to prevent
flat_state_cnt from exceeding ACPI_PROCESSOR_MAX_POWER there as well

Signed-off-by: Jingkai Tan <contact@jingk.ai>
---
Hi,

I'm still fairly new to kernel contributions, just looking for small
fixes on the weekend to familarize myself with contributions, so hopefully
I am not making a mistake here. I was looking at other issues and came
across the processor_idle function. While reading it, I noticed that the 
guard from L1048 to L1052 only checks at the beginning of the outer loop
iteration and seems to be written with a singular increment in mind to
check whether flat_state_cnt exceeds ACPI_PROCESSOR_MAX_POWER each time
it loops around.

The nested loop at L1064 possibly increments flat_state_cnt multiple times
depending on the composite_states_size. I'm not too familiar with this
but flat_state_cnt looks to me like it might hypothetically
increment more than once and exceed ACPI_PROCESSOR_MAX_POWER. 
 
 drivers/acpi/processor_idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 81f372c64074..a27dab1ad78e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1062,6 +1062,12 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 		}
 
 		for (i = 0; i < prev_level->composite_states_size; i++) {
+			if (flat_state_cnt >= ACPI_PROCESSOR_MAX_POWER) {
+				pr_warn("Limiting number of LPI states to max (%d)\n",
+					ACPI_PROCESSOR_MAX_POWER);
+				pr_warn("Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
+				break;
+			}
 			p = prev_level->composite_states[i];
 			if (t->index <= p->enable_parent_state &&
 			    combine_lpi_states(p, t, flpi)) {
-- 
2.50.1 (Apple Git-155)


