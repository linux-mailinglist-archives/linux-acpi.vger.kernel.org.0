Return-Path: <linux-acpi+bounces-20817-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE8KASq2gGl3AgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20817-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:35:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590BCD6CF
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D04303A8F1
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909736B069;
	Mon,  2 Feb 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pAP2QGa3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79792364037;
	Mon,  2 Feb 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042493; cv=none; b=Kp3oXevG4UTSBigxnAocJXe7Q+mLZskzHuFBCABfg+/z0K3xOBjHW45ZPZo9xC2oxKk0MTXxlWN0JvUlIux34Lt/wSjxz131qykwA9EfNoF8NXkM1dciGD/7xHdE/AYx4oz1dPFC554vuj7jwavmUPJZS9rAZJ0ua8xmj4NHh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042493; c=relaxed/simple;
	bh=gI1rB1UnSjdCFeqDmDgt6zB+vX19MFGXqv9RVorUFSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mlRBXGqo+Rnru7IcL7oWizcOqKvyQyfYo+X9A0tutvZccMfqZoJNDvYXysGKyNpTFPdt5JrNlUKW7iQocel/He26AoK5ZE0FcckzBdDq8K3qpCM8+h/2IwVV1YpnHeomCyG0xN8rB0GBvQ70ji2NidtZeRKksjp+U6a9G1GSPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pAP2QGa3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=j9uLyV9kFLJGHA7zrDn69gzb5Tm23oRDPvMLnu7DPy0=; b=pAP2QGa3zgjdrxhHkBkctEe5b4
	ANZYe1bm/0fZydyOBYtIgfw7OxYc4p7YtvRDaw6WWQebKcCOm0UAg0fcAOPRJ5qEzwYkDzMedxPaK
	yU7eg8/K84YPFcuPxyKJffM/3IQJWOksoQfELQJocH8DEdFxC+w2BQaPRTjUKrpU4F+6Tw5zEyDg5
	rOSE9fC2mTnHuSN48uje3X3J2O+ASRyFQFzCbtCcKZ2QiHuOiRyoRm+M50YGycH0XnDqbXdmRQSuM
	14SAIgAcPAKkrmcbpbdwdVbXYMik5CpAMfF2jBw9vlhp/zhLsmqOzo/S3h2jMeXG1NKp2Yya/qEDI
	EJf+ftwQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuJ-0046XU-Lw; Mon, 02 Feb 2026 14:28:04 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Date: Mon, 02 Feb 2026 06:27:38 -0800
Message-Id: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFu0gGkC/33NQQqDMBCF4auEWZtigtXqqvcoUjTO6BSalIwNF
 fHuRbvv8sHP91YQjIwCjVohYmLh4KFRNlPgps6PqHmARoHNbZkbW+v0dCEiewp3WYREExXlpaq
 r2g1nyBS8IhJ/DvLW/ra8+we6eXf2YmKZQ1yOz2T27g+fjDbalIUzhIYwr64D9tz5U4gjtNu2f
 QEZ/HDywwAAAA==
X-Change-ID: 20260129-vmcoreinfo_sysfs-ff4687979cd5
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=leitao@debian.org;
 h=from:subject:message-id; bh=gI1rB1UnSjdCFeqDmDgt6zB+vX19MFGXqv9RVorUFSo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRt8/uJvmAO9WWOHLmnUuQuY2PdOl13iumgj
 4SNdyDegrmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bQnFEACdMj0oOmwbD8xG7FWlRTtT8LyTyEBdZ2U2fGf6rlMswS0oVubjyxCmqe1ZUwXn3UvQV4h
 T2zW3gibCr24Mu7/kx05Xb8y/IJsebfdJZoNrBvVjtO3J61LYdHxAFtJtRBuTy7kWOSAVU65Gn2
 wOKdK26E7mHmZexrJncyFZwzNndbKNQWiAg4KE+bZLIPs2hCfNVgXgQZYOOiU1HUlIk9LALzTNk
 rvjbknxALwyzWIvnYPGLPP5ZDXG1VkS8DWM5UPPdcOUUY424KLESaAPK+CWWpA4NACa3Og+mHwd
 QExGhwKue4aegJaVbrb08ZHJwnIZgeToucqSZ8J6gBZnAelKrWwtxnQN3O6TKLhXO0C9COZZowV
 0ZEZJsek7p48pSXSHTyzJj8+1nHU8GMTLo6zNkclnoBCcD/DYM4S2BBu8zg0ORTzFBCSuoRvX1O
 Ie+7Mo/8uixMTI4Zez234AshN0GIw5vKjGoWQxEgizgPR1gdMg9Pr11S/5BM0w/cqCdimOgVuc6
 +1JgrAYaazS/Rp0kT6wGRqJpH6zVBeOebeyOr4Aq/uA3PsutJpPuw0C9lf7wthZXqtNpXQWrBYH
 ZN1pm7heacYfkYcTaJBeOIwh8B3r9OY1oiqfNEk5Xh+qO+/M9FbegCi9cStJzH3CYi1uxpTkCyY
 z4THSJjcVKrxQ+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20817-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,intel.com:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,meta.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 5590BCD6CF
X-Rspamd-Action: no action

The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
However, this data is only accessible after a crash.

This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
expose these statistics at runtime, allowing monitoring tools to track
hardware health without requiring a kernel crash.

The directory contains one file per error subsystem:
  /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}

Each file contains a single integer representing the error count.

This is useful for:
- Proactive detection of failing hardware components
- Time-series tracking of recoverable errors
- System health monitoring in cloud environments

To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org
To: bhe@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com
Cc: tony.luck@intel.com
Cc: xueshuai@linux.alibaba.com
Cc: vgoyal@redhat.com
Cc: zhiquan1.li@intel.com
Cc: olja@meta.com

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Renamed vmcore_stats to hwerr_stats
- Separate each subsystem in multiple sysfs entries, one per file
- Link to v1: https://patch.msgid.link/20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org

---
Breno Leitao (2):
      vmcoreinfo: expose hardware error recovery statistics via sysfs
      docs: add ABI documentation for /sys/kernel/hwerr_recovery_stats/

 .../ABI/testing/sysfs-kernel-hwerr_recovery_stats  | 47 ++++++++++++++++++
 Documentation/driver-api/hw-recoverable-errors.rst |  3 +-
 kernel/vmcore_info.c                               | 55 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
---
base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
change-id: 20260129-vmcoreinfo_sysfs-ff4687979cd5

Best regards,
--  
Breno Leitao <leitao@debian.org>


