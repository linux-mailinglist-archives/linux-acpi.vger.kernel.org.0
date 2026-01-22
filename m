Return-Path: <linux-acpi+bounces-20562-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBDNF1dJcmkJiQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20562-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5DA695F3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C669C3013263
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5438F234;
	Thu, 22 Jan 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgcetXa7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD623542CC
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097326; cv=none; b=Wfx1VHE3h7k66jb0PVadkc7I+zXaNodEKGRgxJnZHqd7dcmdu0ikYhAVHTADvvJxEB22gzfaUs0a5s1vEQUAAfqNlEeslKeeKVlfrg1XBPyLwqxN2DQuAdF06RqKeIq0Yh+xXQXmpoSqGRnx+gs3JlPjqw3mYoKd6cpuSazuIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097326; c=relaxed/simple;
	bh=pITSoNE3VQ33XxIaYm2AgBt4ZThPk06LRfJuwhvwh/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHjDa+2W5fsChRAUDL5LxJRld+kwFpW3zXiMxK1uvh1NNl5l0wXoHtN0EkbJq2guriTAt9m3yTQwosy1afMNCYThOh0b5qH2tQrwAHcfbD5H65+Hv2uWVkv3Yq307bVyFrqF4cysd3pUcV5gehIxFCYywC8UWs+Rl5qFI1EatzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgcetXa7; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b71557299dso1535449eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097319; x=1769702119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKtMTSVYxonSlbpUyIW/ic7Xfc0BNVbSgxoEnuNp57U=;
        b=PgcetXa7/UbUvlCl5xrRn2P0afO9xNMimnoaK2rZe/taRFWKcnM4Om6dTp1wKm+q0a
         mhk9xgYkHfw9G9MqzjoZgX2iCZ8YXCxifCLT2B4jEqLsEZXfBa1I8OA36YXOG4y3WIw6
         +7AQ4mN03yuctxeBDwra0W5ynr0Jxf2Cv4QCxOJ59PnnEw+RrXPTLPfbvMajA9n/G2vo
         Rg1I/DWIID4Z/vZBA+8DYHFb5Y0eZFKRx6Us9RcU9jobUO4nssxxdXX0ZdKWMKA4FtmC
         Cr2tMR+BddISbcQJxInHLFsxX6qGXkRefGcYXN8BxSbJ/lxtwbysfU8i5NWedE1PWv+l
         EPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097319; x=1769702119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKtMTSVYxonSlbpUyIW/ic7Xfc0BNVbSgxoEnuNp57U=;
        b=t4qRKwVU6lyxLsYqOemZN5E75rpqjDrZJ8FvgukrPTsK5kiZ07NkdU2EIssDI6i+Ys
         tRhszWtNAYCFgVF9PpDPe2w/FeVIbz2GwKdla/EmFJws+D4yzmdusX3lfGM5S5t2MNY3
         T6d6Ii8/vf7Z6Qm04x32UGH6QEQeES9jNNO+qjvkDYjN9MJWp33m/ca+Vjg99D1IUFlL
         ckhaiDzGhpNf0DXMpVGmdfkbwZvwPrCzAUk5PzISz+EaKFbzU6Fl0xta95SxitpcLXTZ
         NpLCuDblEW/2dtQbc+RmcPT1bAaRUXhs37PGZ3mjOfc9MCwdtb9Olc1kNtqD9HjvU+rr
         BJZg==
X-Gm-Message-State: AOJu0YzOGtu0Tb2lw264yyRfJlvq8D7oxar49wjywK4pg2jUCOu7zcK9
	PICt3qKEveg5LU2yvRjZLDEaI2sZ/+5b6wMbxq8BBD5ZJ3IJAbdNtyL/
X-Gm-Gg: AZuq6aKpB5ZJB2N2EJTx+bHVj8A67kbz4eOdLy/RTT4eslwZrRB6VeWLqAJiuiuh5HJ
	m0CvJDbSB3RPxE8ce15yg2PfMJKwgL9CkU4qzhjjtSrvOcoAt7cfVkD8K5EfFR/NZGuYXVkc5Ik
	iavxDSFgk8Mc8D6WGsZuZnTQLIKp2oQahNGGukr03fO7G26LnwV91/+bJ/Ts8+BoTk+SoFseblX
	QR0W6wgMGfYaQH6ADRJyl2jVsT/Qr7adGVy3AbkCS3MMnG7MkjBAPihpRpVnQA25fdxjZY/bl7J
	69ymLTodHdBx9ZTDu6754vtQrigXr2z0V8aTcc3Q5b5mHkSGyjYidGtCg9sjiwd2D5Bg5pXZWzV
	ptOCdhpQiGxVOFy9/+SR9l3I76KXBlZY7zfRwu+8ANC6HrTK6LG9uI724l/cY0Oc0IC45wq2SEB
	CI5z+GhUYidH50NVgpNOiZ/K7JKLJOH7MOzolMu5GcxjUpnwWhgV2i
X-Received: by 2002:a05:7300:1908:b0:2ae:5bb5:5732 with SMTP id 5a478bee46e88-2b6b4e97901mr13128772eec.29.1769097318588;
        Thu, 22 Jan 2026 07:55:18 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:18 -0800 (PST)
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
Subject: [PATCH v2 2/4] Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:54:59 +0800
Message-ID: <20260122155501.376199-3-550230171hxy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,amd.com,linux.intel.com,perex.cz,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20562-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[550230171hxy@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC5DA695F3
X-Rspamd-Action: no action

The MECHREVO Wujie 15X Pro requires several i8042 quirks to function
correctly. Specifically, NOMUX, RESET_ALWAYS, NOLOOP, and NOPNP are
needed to ensure the keyboard and touchpad work reliably.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 654771275ce87..4cd09560c5bfb 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1176,6 +1176,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with the forcenorestore quirk.
-- 
2.43.0


