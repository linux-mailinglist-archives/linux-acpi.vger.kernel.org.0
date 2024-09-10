Return-Path: <linux-acpi+bounces-8211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371C97349D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A761C24FDB
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6E18FC86;
	Tue, 10 Sep 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MJdwSxhI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MJdwSxhI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3317A589;
	Tue, 10 Sep 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964779; cv=none; b=D3riLJ1jy8wktq7nXCKk+2H4e5EKGQoR+6vTWhzLRybpRMZN1XVv4E/0KlkpHUJvQgmX6f2xgfz7RS8FIIgeuzC1UqiWf1YVwAokjK24kQe5cGqFx9JSvKOnsoKFDN+jfeBIY1SKbvEDjgPd61IrwYJTMSxd2IZjd7PtQJM60PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964779; c=relaxed/simple;
	bh=7zrIfLoxboUnHnBP4p3GjEhg7cf+0nKde0qJeENKL+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cE2EcxYQmElp0/vPccd8eyifXQYyNiVBtVjRSl0bOCH1fRPPgdh+ZeopRKLfhVkbHQythaP+glP2TmioKVGi2yeEexoFKLQOOeI/MU/MEU1h2AoQVFGIH04apqajKJdKAZYfxHpMMwRCqBJGZALfw4pve2rDDtQKH+KZvHDUIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MJdwSxhI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MJdwSxhI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B16621A32;
	Tue, 10 Sep 2024 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6w0KKKScpSdCGyQyfm+U/zq2K600ZMP+OJ4gtPNgbdg=;
	b=MJdwSxhILRkVOHveQo3EG9CabNyFBPmNnYuol2KN561p/EN6CTSFVg+zKoiXf8Vl5jm/c0
	yOqD1KxjD8zXBuZT/nq14WXl3q7oSxOwgbx3erwpDPCiDBhiWVhNScvSLVkrMtTwi0K578
	wnU7rBz/M/JPuILZ1Sia6JGEhoJW/Qc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MJdwSxhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6w0KKKScpSdCGyQyfm+U/zq2K600ZMP+OJ4gtPNgbdg=;
	b=MJdwSxhILRkVOHveQo3EG9CabNyFBPmNnYuol2KN561p/EN6CTSFVg+zKoiXf8Vl5jm/c0
	yOqD1KxjD8zXBuZT/nq14WXl3q7oSxOwgbx3erwpDPCiDBhiWVhNScvSLVkrMtTwi0K578
	wnU7rBz/M/JPuILZ1Sia6JGEhoJW/Qc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA81132CB;
	Tue, 10 Sep 2024 10:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +R6KBech4GahYwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 10 Sep 2024 10:39:35 +0000
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
Subject: [PATCH v3 0/7]  xen: fix dom0 PV boot on some AMD machines
Date: Tue, 10 Sep 2024 12:39:25 +0200
Message-ID: <20240910103932.7634-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B16621A32
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

There have been reports of failed boots with Xen due to an overlap of
the kernel's memory with ACPI NVS reported in the E820 map of the host.

This series fixes this issue by moving the NVS area in dom0 to some
higher address.

Changes in V2:
- split of v1 patch 5
- new patch 6

Changes in V3:
- addressed comments

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
 arch/x86/xen/p2m.c                 |  99 ++++++++++++++
 arch/x86/xen/setup.c               | 202 ++++++++++++++++++++++-------
 arch/x86/xen/xen-ops.h             |   6 +-
 8 files changed, 282 insertions(+), 52 deletions(-)

-- 
2.43.0


