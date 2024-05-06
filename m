Return-Path: <linux-acpi+bounces-5634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEA8BCFB2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 16:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD41F2243F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63799824B2;
	Mon,  6 May 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RYTxThHK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HVHPEnYV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ejiA94ww";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PQcJp/c8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21882497;
	Mon,  6 May 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004538; cv=none; b=e7Gnom4NuIUbhGyri+6E7f4SufwmnzMgdLp92mCc8qBM1wxJBPFgZ7UnZ7skz8xVhwSx7diYPn57AI5PClbjGgwIkxqGytYFTwnN1mh3abuxe3rdPbMFh+QI0qiLMUpT8X9tEjQIA5LsO1vESkxQqTZJlNbHLR/Fm9G99FXTGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004538; c=relaxed/simple;
	bh=D4aRyvqT3grAqmfUGEFS/JdTe7ofhsNbvKny7R+kP+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXMGYP4PJ+Qckavx7IVMrkIaY6dcJo+/7CXktZXiSuv0+hweFuHDMU06nOIy1rD3YSoGxARy4ZYCPbCIdtFaEeJ87QEFea988/umT5A0nSpgx/rh2cJ6xtlFilcNN47uxkQ2OVPLSNxjZXCb6pa35PxVj+BWT1FMXnudXXP2PBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RYTxThHK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HVHPEnYV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ejiA94ww; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PQcJp/c8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E70BC3845F;
	Mon,  6 May 2024 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715004535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7JBvaGeM3j7DGR7X0tpm2vFdVObPH9J+7TPetXuL2sA=;
	b=RYTxThHKiL6dWcPvwvnTJc2p8MmqzheAMkfyWQ7SqpSZdpPGkR2aXVGY4blT1lemRiCbbg
	VrHFKQBkrBBttzGTTs52mlrAuPx2CtvVTo7HBh97hASJQlWX4H94a1s+/Dk0L6UuowEW41
	ueLPvKTtVUjaHKegclUE/dXpCnIIjng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715004535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7JBvaGeM3j7DGR7X0tpm2vFdVObPH9J+7TPetXuL2sA=;
	b=HVHPEnYVAImIWD8KDkPPmXo1hMKvBXZQUn66aPSO0wINMIOTPTDGCAvu2MlqASiTQoSr4I
	NuZ66PRq3Hds+jAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ejiA94ww;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="PQcJp/c8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715004534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7JBvaGeM3j7DGR7X0tpm2vFdVObPH9J+7TPetXuL2sA=;
	b=ejiA94ww9Hn+V/0hDDBuMQm2uzeaYBgBG6JDn530fEiuHJ9bXWUP3MdSKKu/gF7o45TSRL
	Lccx5+BjoTgQV6pqufoyBKBkLGdx7Tbop1kk6IO8JQmeamQcys8cuqigT8o3Y5fslZ27De
	RA/XWWX9YJVmw3OIUAYDjslLgcpKspI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715004534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7JBvaGeM3j7DGR7X0tpm2vFdVObPH9J+7TPetXuL2sA=;
	b=PQcJp/c81LySugEG7UqHJBeU9KWO34/drNKQoIXw3Sz32rorJjRMYr66q9R7dBkLE7O5rd
	/auETibe1iByyBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB45013A25;
	Mon,  6 May 2024 14:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mz5yLHbkOGY8aAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 14:08:54 +0000
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Mon,  6 May 2024 16:08:50 +0200
Message-ID: <20240506140906.26034-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.03 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[51.59%];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -0.03
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E70BC3845F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Lenovo Slim 7 16ARH7 is a machine with switchable graphics between AMD
and Nvidia, and the backlight can't be adjusted properly unless
acpi_backlight=native is passed.  Although nvidia-wmi-backlight is
present and loaded, this doesn't work as expected at all.

For making it working as default, add the corresponding quirk entry
with a DMI matching "LENOVO" "82UX".

Link: https://bugzilla.suse.com/show_bug.cgi?id=1217750
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 9fdcc620c652..2cc3821b2b16 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -497,6 +497,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo Slim 7 16ARH7 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82UX"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Lenovo ThinkPad X131e (3371 AMD version) */
-- 
2.43.0


