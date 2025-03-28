Return-Path: <linux-acpi+bounces-12528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B6A74CC3
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B1F3A1DAB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92771CEAD6;
	Fri, 28 Mar 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oakB8fyW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xFOaDI6G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oakB8fyW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xFOaDI6G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BE1CAA8E
	for <linux-acpi@vger.kernel.org>; Fri, 28 Mar 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172250; cv=none; b=PrYRdV16yPHH5gVrxKt7DwUMBxPWapYFfBLByCNuyRlOJahYfq+8czLEt2XA2ZtJlhNQITEIIiS74VFKDc4MsGQ3IjyZYzBq/iIx/a849fcEcijkprUncF3EbdMaLKLNxAfkZru+RPymGswIMPGYq39NFhlmR+rHoZ7gjZSBaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172250; c=relaxed/simple;
	bh=6WZsbnC4paAqOsKhngMldX+wKK8UXIZBRhoD2GEpm5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJJSQGhIkBP+0PsJS0jpdkUq13rznnRrsKDPmoAvvVEk19LMyqSGHEpXPt0Sypw6+jzs48ZgEVKmIMkVtzCS3YU/VzeQQmilSt8kfXCs6p9G8NID31CSH6tdQ/JN56wBb+hkkEIePo5i+lNKhnpjmrZ1rLE4b/4aLvVtJQSKBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oakB8fyW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xFOaDI6G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oakB8fyW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xFOaDI6G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F687211D7;
	Fri, 28 Mar 2025 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743172246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8y1RvIEvtR+JLRVTCmgGUMQ5N4AeeQLdq6j1JnQ8Zs=;
	b=oakB8fyW4oJHpvd4wKxAbX6t25Yuj6WUyo0o39vD0V9BToAFf5y8aK76JzI03IynpmdSPM
	fmHlRgGcamdnRCuUZjzQ5wlP9gXbw9D3SB7ESBF311OkUuDKW6JqNdmujrJkJDN6mtR7V8
	sui3ZrdO6rAANqD9I46bQC80RYVU5Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743172246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8y1RvIEvtR+JLRVTCmgGUMQ5N4AeeQLdq6j1JnQ8Zs=;
	b=xFOaDI6GZql2ACSDtq82ZrTuX9CKGxLpItZA0PqQSBuL4c2MpLMAakmFmk5xcvz2N+oqD5
	QfLsEtxsYlIQTcCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743172246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8y1RvIEvtR+JLRVTCmgGUMQ5N4AeeQLdq6j1JnQ8Zs=;
	b=oakB8fyW4oJHpvd4wKxAbX6t25Yuj6WUyo0o39vD0V9BToAFf5y8aK76JzI03IynpmdSPM
	fmHlRgGcamdnRCuUZjzQ5wlP9gXbw9D3SB7ESBF311OkUuDKW6JqNdmujrJkJDN6mtR7V8
	sui3ZrdO6rAANqD9I46bQC80RYVU5Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743172246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8y1RvIEvtR+JLRVTCmgGUMQ5N4AeeQLdq6j1JnQ8Zs=;
	b=xFOaDI6GZql2ACSDtq82ZrTuX9CKGxLpItZA0PqQSBuL4c2MpLMAakmFmk5xcvz2N+oqD5
	QfLsEtxsYlIQTcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60EF613927;
	Fri, 28 Mar 2025 14:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nik+F5ay5meUeAAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Fri, 28 Mar 2025 14:30:46 +0000
From: Giovanni Gherdovich <ggherdovich@suse.cz>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] ACPI: processor: idle: Return an error if both P_LVL{2,3} idle states are invalid
Date: Fri, 28 Mar 2025 15:30:39 +0100
Message-ID: <20250328143040.9348-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Prior to commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI: processor:
idle: Allow probing on platforms with one ACPI C-state"), the acpi_idle
driver wouldn't load on systems without a valid C-State at least as deep
as C2. The behavior was desirable for guests on hypervisors such as VMWare
ESXi, which by default don't have the _CST ACPI method, and set the C2 and
C3 latencies to 101 and 1001 microseconds respectively via the FADT, to
signify they're unsupported.

Since the above change though, these virtualized deployments end up loading
acpi_idle, and thus entering the default C1 C-State set by
acpi_processor_get_power_info_default(); this is undesirable for a system
that's communicating to the OS it doesn't want C-States (missing _CST, and
invalid C2/C3 in FADT).

Make acpi_processor_get_power_info_fadt() return ENODEV in that case, so
that acpi_processor_get_cstate_info() exits early and doesn't set
pr->flags.power = 1.

Fixes: 496121c02127 ("ACPI: processor: idle: Allow probing on platforms with one ACPI C-state")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/acpi/processor_idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 586cc7d1d8aa..b181f7fc2090 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -268,6 +268,10 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
 			 pr->power.states[ACPI_STATE_C3].address);
 
+	if (!pr->power.states[ACPI_STATE_C2].address &&
+	    !pr->power.states[ACPI_STATE_C3].address)
+		return -ENODEV;
+
 	return 0;
 }
 
-- 
2.43.0


