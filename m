Return-Path: <linux-acpi+bounces-20564-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEOyIrZOcmnpfAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20564-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 17:22:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44169D12
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E42B30B704D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B936681D;
	Thu, 22 Jan 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss1uVZj7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E436074C
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097336; cv=none; b=lq5KT3JqvNSyFp3V83B7GOWPxk07/zDAknsiA+od2folmjcom9GwW81Dvt4fYR9pJC0AjxlkGUftgYK1J1n23uuhCtEBbv2iZAbC72mv+Aq9M8SzFDrfClYKGctt1FRzaG/CSGTjgzhO2xTwUul8RBa/S7Iqn222gO4ojl4JQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097336; c=relaxed/simple;
	bh=9BDtGVLm/YNavfQzhSMk9a18TtGw89Iu8RHa4FY/yvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxA53u3S0m6f3N88gyhnS/MeENjz7m1cblrUOpjLFn2pdZw5BiSV+Tgid8zFPi+RPLqgNLyf+o8skYD4ZEn49bHLphJjypILExPavVc9ddi4spR9RZ1Y1QgSb5906JvLBPyHJiO4zjJtgq1olQvY6rRtCzlL295jAlDCcHL9TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss1uVZj7; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-123320591a4so1272876c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097328; x=1769702128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq4VY/0urpQ2UO/GnbuvVu8bQyR50a/yUYGs16zTipM=;
        b=Ss1uVZj7KFP5VpFPeNbgCmoVJyEcQ2bAaPJa/GFIsmZ1y6+feW72vh4Okh25tgezlZ
         8S09KB0wduIbkEvoktIjlRPiXxMwOB05mfGWJ36rI5oa5Z6TU9LvxgnDScu5KZUmwp8o
         mlfo0OK3jhvLK1EjEJA/p/+IvRK/1YL628odLheVIc0brQlv84o2cHQwDRzDT5QCrA+h
         RdUeZC5K9TxVvrugouTVK4/MhUEjlaOIK0iDtNP2vEZdH87WnIAq4s0UHTq+YzhmYc1t
         zdNhEnKyY2pKgyytGhB3alhPG/MnrLR3Z/tN6Eg58z2tP4lI5SeW9hrSF1t/KJpQHf3z
         eNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097328; x=1769702128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq4VY/0urpQ2UO/GnbuvVu8bQyR50a/yUYGs16zTipM=;
        b=w0MIT//ToKGf/hC9OBvhN+lyVCWS3Qc+w+8mRf08RQG5urvyuoIKeiMA85/SuSvdSg
         Px+H7fQRr6O9X1TfK0439JnxXQuJy5GxmGF7ivOI5xgy/e1TZlqm4O6E742yDIc9uroW
         Lj27GlGMv2tEUV6WmaLJ5tAErLeBQR8wFPv0Q1u8LJifdxAIreQ3UsifzSUKPlU2UPvD
         zrbBqFrPzQlqhgMRfdIy40LbUyl8axILO1+P/jRogxxcjJ10KMWVyqKPK+4YBbEjP91M
         krVSJFkAL2uCkoNv7l2DnciuvIUPkWjdyy9bNGBX09M/MHU+/oYF6moMyKCPwc3AFEBU
         M6vA==
X-Gm-Message-State: AOJu0YzHDYNoaicyhztnwbptrsMJQm/nsANG1L/ELeg/qNgkdX/+OM7S
	V2VzF2YznxB8OPQ57qnWqP/ZtCd5AjD1AjondWW8ivkhzTw+YSTLToWW
X-Gm-Gg: AZuq6aJpMEOOtixSwfTCDrt9DLOhKkflQ/qapzdmwUX5Us5QdmlqcTDX0FcHDfNtRV1
	oxlqpo41C3ogM+bodgQUeF7UjREz8GcSTcXgAGPOfZ8buErx7UpzhsmSA/Hui3R6MVApv1eAPtZ
	xzyA1l3gigj0PYefemRFYD3f5HbqaHWgYLWP29xIEA+RvlZkJ7p+L336kw0hTJCrClY0tnPmSTK
	A73iXXbYqWEx+AhcKbXVf77mxN/SJ4s/DiyImR1ovcB0Bpe4v6Ko9SULtCLU1tJqVtW4NT+Orcp
	pva5DGguWN8evMFheECdl4D71LXcDBumqr7KaIot75g/OaigJ1eQoWhUX9VVHLlG4m6Q0qE3q6P
	dx0qNixAz2jpzNjEOhQPmo/KuUNUFiax+OcXg8HJyQRaLYw9Vc+MI+YuHYtTGavG0ETgIbxzc6j
	DsxkKaromTty8paAnGcia3pjLwtzFn8AAqpaKbFgvK2zQqSKJXNzczUS8bVAkgnNs=
X-Received: by 2002:a05:7300:1496:b0:2b7:1ef:5862 with SMTP id 5a478bee46e88-2b701ef630amr5208031eec.4.1769097327956;
        Thu, 22 Jan 2026 07:55:27 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:27 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	550230171hxy@gmail.com
Subject: [PATCH v2 4/4] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:55:01 +0800
Message-ID: <20260122155501.376199-5-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122155501.376199-1-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,amd.com,linux.intel.com,perex.cz,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20564-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[550230171hxy@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B44169D12
X-Rspamd-Action: no action

The headset microphone on the MECHREVO Wujie 15X Pro requires the
CXT_FIXUP_HEADSET_MIC quirk to function properly. Add the PCI SSID
(0x1d05:0x3012) to the quirk table.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 sound/hda/codecs/conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5fcbc1312c697..2384e64eada36 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1123,6 +1123,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad/Ideapad", CXT_FIXUP_LENOVO_XPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
 	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
 	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
-- 
2.43.0


