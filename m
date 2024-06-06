Return-Path: <linux-acpi+bounces-6217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA48FE5DF
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FE11C25BFF
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753641957FC;
	Thu,  6 Jun 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KSuigMUZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+xZnJmI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BA13D28C;
	Thu,  6 Jun 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674962; cv=none; b=VsucdNYUVj/ZFTZTwSZOTPXOX9BTEfuudvuWcgk12UyCeeKtXaYbdNsbtq8nI0qn7WtqZM5IeDAdLgUYq5n80I7zlNQmLGz0LbHki4+gUqm9rI4v7SnQdg+OJX07fapK5lyLO9ZxJMpBAOjBRg7APGPIQ4CHmbVZ0bdebFeDk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674962; c=relaxed/simple;
	bh=5TcS2L0Vunv8bQ6XHbiioGIW6DmWOl9p9toiSyHCi2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xjm6FJtNIheugHSy0wbqqU+8RJUDx7W8fz8hgh+BtolkRsULU2AUPxwN4TrucNT4QY5xEgdFBzjZ9eP7/ihxAyz757lq0kdkcKyTO54w9+62iMoXn6tOLokE34k/J1ovCDAx16VFmH/4F8cX7mfR3Z7lquh8n1Mk8V/ma+MfkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KSuigMUZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S+xZnJmI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3352D21AE5;
	Thu,  6 Jun 2024 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717674956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZCoYGmEJh4l+ym/XnVfcBBQBC1YxZZjqAJOP1GtJnA=;
	b=KSuigMUZRBIcqfkAVkZAJe2+Kz4kxMP0xgEDW1yewEdpvZRLLPVjmvjrU46HhqyFkTO6/x
	wUW2+Cz0iYRl88d2gglyM0D79ucUSMYWYRQFwlKULo2q6Hb1UhBrb+WJE/b7zs3ClU/yrz
	W+YKy6+U0tUasIGhJGev130yd09Vqx4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S+xZnJmI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717674955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZCoYGmEJh4l+ym/XnVfcBBQBC1YxZZjqAJOP1GtJnA=;
	b=S+xZnJmIO9S/4p9OmvLSKVLvkKVr7oLEj8ouZ27JRDBUKNJHTarj+i0ol0z6MFOr62TNVi
	1XCcs3djAI9rdTX32Fz4WqjZuoavds1svj6eLNgA6acbdvGKkJyoatH94XmzJ+ccSFeGbW
	Eaj/PgFkBLtDQyLGB7a5G5JnrGtTrt8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A8D313A1E;
	Thu,  6 Jun 2024 11:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dn6JAcujYWa1KQAAD6G6ig
	(envelope-from <ptesarik@suse.com>); Thu, 06 Jun 2024 11:55:55 +0000
From: =?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <ptesarik@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <ptesarik@suse.com>
Subject: [PATCH] ACPI: CPPC: add sysfs entry for guaranteed performance
Date: Thu,  6 Jun 2024 13:55:41 +0200
Message-ID: <20240606115541.2069-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3352D21AE5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.71 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[56.37%];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

Expose the CPPC guaranteed performance as reported by the platform through
GuaranteedPerformanceRegister.

The current value is already read in cppc_get_perf_caps() and stored in
struct cppc_perf_caps (to be used by the intel_pstate driver), so only the
attribute itself needs to be defined.

Signed-off-by: Petr Tesařík <ptesarik@suse.com>
---
 drivers/acpi/cppc_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..9976bb57356e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -160,6 +160,7 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
@@ -196,6 +197,7 @@ static struct attribute *cppc_attrs[] = {
 	&highest_perf.attr,
 	&lowest_perf.attr,
 	&lowest_nonlinear_perf.attr,
+	&guaranteed_perf.attr,
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
-- 
2.45.1


