Return-Path: <linux-acpi+bounces-20898-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDTsL24LiGmzhgQAu9opvQ
	(envelope-from <linux-acpi+bounces-20898-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 05:05:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F7107CCD
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 05:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D3A3303AF3C
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Feb 2026 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8642C21F6;
	Sun,  8 Feb 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyVk2OVv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F82C11D5
	for <linux-acpi@vger.kernel.org>; Sun,  8 Feb 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523450; cv=none; b=n2C1fb6Ev9QOl3k0ua7Rw3JCxdp+L0GaWQK7+pDl4jLEjW8fJpnr1Rxu+Sr/mNtJa1HOf4GTNWGNb/R4iDX7s2FxQ+5d8NFoDGEy1gb7l9fklHIzhY56NW+PRrCXmOyyZWBAXFY4V1KB4Szxu7AptzTEUadMshpJWr8ekKgWByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523450; c=relaxed/simple;
	bh=SwRM9LTR2QUOgaPTFf+sezPTqw3NitYdjpeSCcdcW0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ/9ZPGmbXOymMgSXEl81uL2G1rfJKS3U50RtBjdoHGlBbgzC2DVFzVOKhF4JXczisPZEt8EICkHHg7lNM/quiJjVdxWEoTFmbCBDoXcG9hZu3JqCcS5OqQat4Ioty3xVJHKHmLt0JaWpYhkvLjjMlHM4SF3p70C6kEr0WBZVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kyVk2OVv; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9694so7465058c88.1
        for <linux-acpi@vger.kernel.org>; Sat, 07 Feb 2026 20:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770523449; x=1771128249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDmFN1mVg5seJ+q06CZhGBYTZV2fU/sK9RfIemTnpDU=;
        b=kyVk2OVvyLzq7C7CaEbShgB15EOVqQp6qAohRkw4VHSQQW+Cz3Nx6BsrzQgVCe4lVZ
         1BFBmn6dtKwG1T7HWaaV1n6+is0n776L3xioyIWAP8drz6bI+t8cSEtJzPiJmGX7j1Hk
         XNUsD0lfnY8W58dUFYSvR5W2EQqB5c6dit4cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770523449; x=1771128249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDmFN1mVg5seJ+q06CZhGBYTZV2fU/sK9RfIemTnpDU=;
        b=NVKdqGQSEESxGH/pZ9utl7/dmdKsc85MrU1DMope9ww95uvfIIMQzA9oVluCWEcmoc
         8j19zkxdo1fltjEcWy7HbcbYQArDyBR+LOIdti2RfO8MIgBNJn7kh9gcu6WYOH7FuFpm
         Hp/IvxIxCQj/XEeOGKLxlK7bpB3OsnnCWMJLqGZG22WyDyVTKQfkcmYND3AX7iEiNyXw
         vTIeMhGK8Cu28QWGlDCMVXt4A/YJubuQAU4SA995ktArvDWSnvtUPAwG5npN4D039mc2
         ydixUmnt3ztY/zbw8549+lD4QkF07mnHcw3SJdVQVm05Vw3AW4Rbe5ddkEXoOzI8qP/2
         dmLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFjUqiaNo3o4SD4qsfKYyqLN3aXXcB1en0PmaaDhFfN5UO/QUCRS041u6ExI/i7B/iSFc2aAmFgGWO@vger.kernel.org
X-Gm-Message-State: AOJu0YwTq/5NrXevSeItI0CkwATYl4CYb+sID1o4A1xU4DRdw2ynVxgj
	2KAU+bkICuJCyLZwAwLIqu3pLmZ/9RaejLSh3Oz5b3KWlGYXJ2Lr1JtM41dUUACFlg==
X-Gm-Gg: AZuq6aLQ0hL51gvqCCtYoAxizEqWVSjolt1AZ2qEnZGoMfWlXkkcbyWMa6uYiDEOdgW
	zh/g6DAysmUAqVzDs4u9piKat6KRTRSnxeJSJCLLt/lw7vj08L9aGzxkkUk1zr9H6duUcFk2gjv
	Mxzh9SK6/wXqPwjrxoI+4Ss6IySFSxGisIX3qFx7vHDXL417jN04Qrv4FqCdpZCbiEUviQuF6eB
	TcKJA19APK0h5btpdWqjaSSuh5e6xVbBxM09RTcA8uBU3MN/gUOlT8M42kjwOGMi6aui4QcR/Sk
	dlNndA7HsrXbs0LfllwXTbNsvN2hkI5y+c4Jti9r3cUy3NbNusU6PdmfjEiKf3NGvZxwW1jkCFu
	R7kCtRDNUfEdFhSNV6Mp2Aq/ntPFlLj56JYHpqrH0pfwFnn6ZheJ4ECVbN4tS9yeUWgSsAxMHGi
	b/xNRql0J3KnCn8fl9syN7jPdwVnCMTds0/260eNtXT9s4E1+jnyHhipPKVfOg6OYuLiTrMaI=
X-Received: by 2002:a05:7022:6ba6:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-1270401e29fmr4298462c88.35.1770523449409;
        Sat, 07 Feb 2026 20:04:09 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:6d43:22d7:40eb:81e6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm7085064c88.8.2026.02.07.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 20:04:07 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: jassisinghbrar@gmail.com
Cc: Douglas Anderson <dianders@chromium.org>,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH v2 02/15] ACPI: PCC: Use mbox_ring_doorbell() instead of NULL message
Date: Sat,  7 Feb 2026 20:01:24 -0800
Message-ID: <20260207200128.v2.2.Ibc0c2b7d0280f23aecade13c49dedc2bb7fdd7a2@changeid>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
In-Reply-To: <20260208040240.1971442-1-dianders@chromium.org>
References: <20260208040240.1971442-1-dianders@chromium.org>
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
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20898-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D4F7107CCD
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
2.53.0.rc2.204.g2597b5adb4-goog


