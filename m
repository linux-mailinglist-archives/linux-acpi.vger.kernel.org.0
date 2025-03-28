Return-Path: <linux-acpi+bounces-12529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019BA74CCF
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA981894E1D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D01D63E3;
	Fri, 28 Mar 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWTlLNnK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="78mYvrRR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWTlLNnK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="78mYvrRR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15451D5CD1
	for <linux-acpi@vger.kernel.org>; Fri, 28 Mar 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172256; cv=none; b=DQfuUbU32faytwqDX6ns04Ybi8BPTap/wl3gTS3h/Um14JZFhQOTyqWAE8mM+fSF6bHqhtO2aKVeWfUL4F814wsXhzxP7taAhZvmoi4oPoCej/thjqwbywrs7dT4Lef5PGcG9WDWiEzv6aEECwbSCJc40PyvLlVLkJrITvOGGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172256; c=relaxed/simple;
	bh=K8pdPrPH2/V9uEO9ZVDq/4eu4bA60pgngP9tp9BWxSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc034cRjCCmMbkjCimo+BWrvDTGcnG1x84V40Bm3AKu6eLoaCToaiA4BHXwHpqAikLUyo7NduoPhPin/smE/Jt5Wtbet35z+rozzGcStdwt8KjA63hyfKq8prp4sk0yzeueobjmhfrmI+5Wxtigm+A5C/MvrhrDTpYT2oc7fsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWTlLNnK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=78mYvrRR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWTlLNnK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=78mYvrRR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CF9A211D1;
	Fri, 28 Mar 2025 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743172246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XVCLbyTVqkdwNo0naeJBfFSzYf4PuaJD4ozQH+Q3A=;
	b=QWTlLNnK7eulyhB+ffKQMPhlAMe2VAp0GnPsP+4ivlmvvyceSlYi4yn8ZLVfh/4cM0A0jZ
	aK1D7c+K+ntQdH1MbV1ykAxSv9dAVHVr50t3qWPCKrBRqabA/z6dhTtcd1AKHfk5wKW8DM
	pIeWj0QpZHKQKWCsHe15q/gpu8Dowp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743172246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XVCLbyTVqkdwNo0naeJBfFSzYf4PuaJD4ozQH+Q3A=;
	b=78mYvrRRRHk9rvw1O+qs5Oa4BaVr9bpaOR5m/80xfKiaJWeWennciTq5E/oBvPG6vBPyT8
	q2MDOwzylzVUhEAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743172246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XVCLbyTVqkdwNo0naeJBfFSzYf4PuaJD4ozQH+Q3A=;
	b=QWTlLNnK7eulyhB+ffKQMPhlAMe2VAp0GnPsP+4ivlmvvyceSlYi4yn8ZLVfh/4cM0A0jZ
	aK1D7c+K+ntQdH1MbV1ykAxSv9dAVHVr50t3qWPCKrBRqabA/z6dhTtcd1AKHfk5wKW8DM
	pIeWj0QpZHKQKWCsHe15q/gpu8Dowp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743172246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XVCLbyTVqkdwNo0naeJBfFSzYf4PuaJD4ozQH+Q3A=;
	b=78mYvrRRRHk9rvw1O+qs5Oa4BaVr9bpaOR5m/80xfKiaJWeWennciTq5E/oBvPG6vBPyT8
	q2MDOwzylzVUhEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8208D139D4;
	Fri, 28 Mar 2025 14:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kG9oH5ay5meUeAAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Fri, 28 Mar 2025 14:30:46 +0000
From: Giovanni Gherdovich <ggherdovich@suse.cz>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Date: Fri, 28 Mar 2025 15:30:40 +0100
Message-ID: <20250328143040.9348-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328143040.9348-1-ggherdovich@suse.cz>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Since commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI: processor:
idle: Allow probing on platforms with one ACPI C-state"), the comment
doesn't reflect the code anymore; remove it.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/acpi/processor_idle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b181f7fc2090..2a076c7a825a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -482,10 +482,6 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 
 	pr->power.count = acpi_processor_power_verify(pr);
 
-	/*
-	 * if one state of type C2 or C3 is available, mark this
-	 * CPU as being "idle manageable"
-	 */
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		if (pr->power.states[i].valid) {
 			pr->power.count = i;
-- 
2.43.0


