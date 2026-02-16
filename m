Return-Path: <linux-acpi+bounces-20999-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEncJvRdk2lT4AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20999-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 19:12:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAC146E81
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E8D3025C47
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9282DF137;
	Mon, 16 Feb 2026 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jdjDdybT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE952DFA46
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265488; cv=none; b=W+GzZtwtqJAZGmukZizZ8ewMln755qN9mq9NTeLct1OU2S4OUXlKs3SU4EC80QOxqPfN9sQ1weaP8++D0JwALZY/DJrYVH7BKZKvTZjzsfk6oAf8mHzGDUfzqg8GnnDWg/icwNcYiYdttVyxyL7zempbbC+U0ZnofjW5zHCwPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265488; c=relaxed/simple;
	bh=T9138cDwn+QZwBFaC6QbDa1VBT/f3YEeuN2KjrVKfhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jnz/cNbaiVCNb+M/fGh1agWJhrdJmyV+ProLaQpVgnWIKH7YSS5z274gQBenSjoe8CjjBuieglh1Wk+MzWsH8+IE6cEU32SULd4w2G932l0wf98/nLzZfbeXDpFrZiQiKX3QgJGeCcYQ2cO1qpjg/aBJUUzdI7xTniYF6qC8utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jdjDdybT; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12721cd256bso4209963c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771265486; x=1771870286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jhin/02GFgkWCuBO/6cY6fZT+lc+CgTrHw88Ws4rz8=;
        b=jdjDdybTjFsZxPPaz7naIvRFI0gEe52F3eQgLyLPjcoJBYbA8ArgdiX15fH8yvco4c
         pi0D9Szb6bwFmPDEjRAZZ9O6TSaDmhQ9CP9ABFQaElb4+Sc0cL3Q9W8O7koxtOkyEqmU
         Ys7wrqvPL4LgsjqPUE/gux6tQOHZRpsI1e0p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771265486; x=1771870286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jhin/02GFgkWCuBO/6cY6fZT+lc+CgTrHw88Ws4rz8=;
        b=d4NmAFbxiZGYuG3PAVaN9gz4DSFUhdQn5aTZzTEUiAp+wAUbwRsWhfnW/VrayyiGT5
         3POhHwskw55elFzi22y9gpbbCEzj2ESMp2E4ilGgSPiS98vgQSOZQOiW+va/4LliqKvX
         5f5VCFnhQpzSji9zRw5GDQZYabeWqHSETxnurRh6aFXXAPPEcXgmgE/HZuN1O4vBZ7By
         f2gK+RTBtgqzfyLMUwy4qjEiV3SVuchnvaiDHGPGKRRwzsKv7Zsp4+zfJJLKzbyieBQi
         o9o16K+Fjby4UOlSrYM+E9znW8UmhE0whf+NQtk9sxD9gAoo0YxyaMx97EJfq8Hbkzs7
         M/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8+3jvzA9i/D96Wx1c82GsiStIPByG+IDg66zKtkvL6drIPV/gf5+bW0CjNvRBnZgG5uqFkRkTIXDm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0n0mpkXNQlhOfR2BeJIvLhKyfeFNoLr2Ag6N2zlTvh51ROmQn
	8Bt0GQgn37rTN9o4BPIGGxtnK/mdtWW4tBdMsTmAhkqybDRlaRdnl3Tjx1aB62f+jQ==
X-Gm-Gg: AZuq6aLBIx+3omZv85x12kDM4Hzz+zVv82TPDCmMayVFd7tv+VJbmTkrIOc3JCeTlMe
	qsoBpx/6G/CC74dvlr/j5AJEO2+GCyWNhWwS5TG61u/dAZc/twF6C+CbrLVS3FP9spE1/x+dfGQ
	6RWoVAgt4dydbu32hu9yYIP55cqO+Kzaj62XOeHYaOL3/3KqypOYZqM6FcdFILc4gpOA9NNVYNz
	WzR80hJqehFe1gtR9/pcngHuOA8ZsjbPIO1fLR97hDfhdOqEalvE+RUnP1Xt32K5j0tJlKq/CQs
	YM5xhRZo6b5iRRKkV25VWTlA0nNloi8etnnSFtgRWaK/HUcPIJPPyKt1K+waMR0vbmL58zvuV2E
	ezSgJm7gioeiz6QIVL3PjZaDKCABx94Hq2xkvclkAe8stotkSppwvv+Y3jOLaqeNJCDxC3tyCuc
	4mkaYR+07t36FKjIczSilySZmA351Cd1lYyPXo9qaB8Fqrti6A8PMh6umoA7ZL1P6JK8yk/Q+NA
	0A3t/gBO7I=
X-Received: by 2002:a05:7022:4389:b0:124:11af:7b42 with SMTP id a92af1059eb24-12741bd58e8mr4199049c88.33.1771265485799;
        Mon, 16 Feb 2026 10:11:25 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:2953:dae1:1e39:73b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm13724326c88.5.2026.02.16.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:11:24 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: jassisinghbrar@gmail.com
Cc: Douglas Anderson <dianders@chromium.org>,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH v3 02/15] ACPI: PCC: Use mbox_ring_doorbell() instead of NULL message
Date: Mon, 16 Feb 2026 10:09:39 -0800
Message-ID: <20260216100943.v3.2.Ibc0c2b7d0280f23aecade13c49dedc2bb7fdd7a2@changeid>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
In-Reply-To: <20260216181002.3475421-1-dianders@chromium.org>
References: <20260216181002.3475421-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20999-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11FAC146E81
X-Rspamd-Action: no action

As per the patch ("mailbox: Deprecate NULL mbox messages; Introduce
mbox_ring_doorbell()"), we want to switch all users of NULL mailbox
messages to use mbox_ring_doorbell().

From code inspection, it appears that this driver only ever sends NULL
messages and thus the conversion is straightforward. The only change
is to remove the call to mbox_chan_txdone(). The call wouldn't have
done anything in the past anyway (since chan->active_req was NULL) but
with doorbells it's officially documented to not be needed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Something seemed a little fishy in this code. The code seems to be a
_client_ of a mailbox, yet it was calling mbox_chan_txdone() which is
something mailbox _controllers_ are supposed to call when their
"txdone" interrupt goes off.

It appears that this client even reaches into the mailbox controller
and confirms that `txdone_irq` is set, which should mean that the
controller itself signals txdone.

If the mailbox controller is actually signaling "txdone" it should
ideally be improved to not do so for doorbell (NULL) messages, but it
won't matter much for this client since we only ever send doorbells
and don't care about the txdone callback.

(no changes since v1)

 drivers/acpi/acpi_pcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index e3f302b9dee5..3d240ecd98f4 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -106,7 +106,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	/* Write to Shared Memory */
 	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
 
-	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
+	ret = mbox_ring_doorbell(data->pcc_chan->mchan);
 	if (ret < 0)
 		return AE_ERROR;
 
@@ -123,8 +123,6 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 		return AE_TIME;
 	}
 
-	mbox_chan_txdone(data->pcc_chan->mchan, ret);
-
 	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
 
 	return AE_OK;
-- 
2.53.0.273.g2a3d683680-goog


