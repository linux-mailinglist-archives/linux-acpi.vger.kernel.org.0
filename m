Return-Path: <linux-acpi+bounces-7699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32B9580C1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4331F22810
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AC17B4ED;
	Tue, 20 Aug 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YvV/+XCd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YvV/+XCd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AD12FB34;
	Tue, 20 Aug 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142019; cv=none; b=BwyZrSvE1XCH16nEz3kOIbDyvdx35gr+vKP5jrcxMA0HgIGhbfrIsxSMflITpSuZ9dpVRNybs06VzDLAT7R6uPjW3g3Wo4WP8RDog6MnHW3Apm3fR7ei7tJKf8amCwi5Z0zVKQTdpWcYQorXluWMyH1onL9GLzmM7cg+RUbIjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142019; c=relaxed/simple;
	bh=b1CjUpKKAmAJsrz+QBxfl9wW3dUj9vcgeCiMN83Ij78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbmrgjL5lEiJ6A7FoMhU/M87KS7QI6P6h5fGzA1hAmzEyAoxQfyBoVX8XPPw4wG6jY1l6ph96gDveeRFmwvrnMO1sqhxfiNEydk88mLeZ+MYhg7pOD09K+641biXpLL+WkzZLel6UMEf6PsIPxIUnHk2+LfYxiguwYcfFVHaHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YvV/+XCd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YvV/+XCd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7911F1FFB3;
	Tue, 20 Aug 2024 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724142015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4KYVEXnC+ZhHA3BCFJAEBnlMKyTINJg9vlBPCcs8xc0=;
	b=YvV/+XCdljrzW8kQlBoIna+DYDrGHvTkBX4owjjkAxCU5Ge1dH2qDBYb/vA4c9x5qCfIb0
	Yd8CSVZ0qGO2zS6I2AIoQH80IBPWssGlyNUfOCICSYZ9k2VtE+oDPg5Zv7k5WMDN6R0VhP
	xcU2jEhVfOSE2v2IS5GMjuTrmqD+A9M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="YvV/+XCd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724142015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4KYVEXnC+ZhHA3BCFJAEBnlMKyTINJg9vlBPCcs8xc0=;
	b=YvV/+XCdljrzW8kQlBoIna+DYDrGHvTkBX4owjjkAxCU5Ge1dH2qDBYb/vA4c9x5qCfIb0
	Yd8CSVZ0qGO2zS6I2AIoQH80IBPWssGlyNUfOCICSYZ9k2VtE+oDPg5Zv7k5WMDN6R0VhP
	xcU2jEhVfOSE2v2IS5GMjuTrmqD+A9M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1506413A17;
	Tue, 20 Aug 2024 08:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZzuYA79RxGaSKwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 20 Aug 2024 08:20:15 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-acpi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/7] xen: fix dom0 PV boot on some AMD machines
Date: Tue, 20 Aug 2024 10:20:05 +0200
Message-ID: <20240820082012.31316-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7911F1FFB3
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There have been reports of failed boots with Xen due to an overlap of
the kernel's memory with ACPI NVS reported in the E820 map of the host.

This series fixes this issue by moving the NVS area in dom0 to some
higher address.

Changes in V2:
- split of v1 patch 5
- new patch 6

Juergen Gross (7):
  xen: use correct end address of kernel for conflict checking
  xen: introduce generic helper checking for memory map conflicts
  xen: move checks for e820 conflicts further up
  xen: move max_pfn in xen_memory_setup() out of function scope
  xen: add capability to remap non-RAM pages to different PFNs
  xen: allow mapping ACPI data using a different physical address
  xen: tolerate ACPI NVS memory overlapping with Xen allocated memory

 arch/x86/include/asm/acpi.h        |   8 ++
 arch/x86/kernel/acpi/boot.c        |  10 ++
 arch/x86/kernel/mmconf-fam10h_64.c |   2 +-
 arch/x86/kernel/x86_init.c         |   2 +-
 arch/x86/xen/mmu_pv.c              |   5 +-
 arch/x86/xen/p2m.c                 |  95 ++++++++++++++
 arch/x86/xen/setup.c               | 203 ++++++++++++++++++++++-------
 arch/x86/xen/xen-ops.h             |   6 +-
 8 files changed, 279 insertions(+), 52 deletions(-)

-- 
2.43.0


