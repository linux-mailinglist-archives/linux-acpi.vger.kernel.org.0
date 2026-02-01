Return-Path: <linux-acpi+bounces-20801-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B6HFjlPf2nangIAu9opvQ
	(envelope-from <linux-acpi+bounces-20801-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:03:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7527C5F2F
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D8A300D68C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822133F8D3;
	Sun,  1 Feb 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akjHXLeD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118C33ADB5
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951028; cv=none; b=KvL5jROSK7BE2osrNQ1ZiHTpRBLVUGjYogaBJx1Tih7+t/1ETSUt7epxg9UATGFNSVjwNhCUrhDFOKrOtKo6OXbFsJiDu+N4Ga+I+GqK1RXfJ+JX/WLJYWydXGugdxKl2F7CoksOU5rN9jUegFwyg2t6x7md7gRPOr/YHjBRBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951028; c=relaxed/simple;
	bh=sVm24CuiuqVqC6ovc76VvEq4lqBdnsh8y2PXm4fmeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jzXCnLY2l6/xYFExgs4COb1caaKozb/R/cKfNa1B/fP57lXJu3JCCS3KE1ZVcU6xPFrmgq5hPEwZQZqlHWFZi/NawbsYLhIB+K7ul9hKHQfZpuxlgp0NBuyU9WgP0uQ+35U/ixbS+MZ5PB+YR22VVJV1Dmh6GqiDs1zKA6smIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akjHXLeD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so37585765ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951022; x=1770555822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNiuy8DgVoYWmI0eU5urHtLokDol+0VX8KfBQgmnbrA=;
        b=akjHXLeDHOsO7HHB9y08rEfOVoQuMCm3PkG+fJW3m6YQY8/eWd02ZK4Oh84n8DpmSD
         Z3/XFtXvjkFCcjsRPnzBtxclhtLz5ORBv+Btvyh8ooB7MlICXdx2pxh7oirkqqIaQBND
         sgeWUL4XCy/C5lAADH1FaWoG4zyIssNmSOIv61LqQpAMiJRyYjhuKRhr8T20MHT0gp47
         tlN8/jFWjah1flJf01u7uo6mK6EvIF71w1oR5BVvd4Tv4woz7ElWCxiFOMTKmlVRmNDN
         qZIcLzNiO2F4+z0yB3DJxbxvQmtTLIY9ipENQSWLusFbca1TKAOrTHrLXtQ3z5hq4VNg
         E9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951022; x=1770555822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNiuy8DgVoYWmI0eU5urHtLokDol+0VX8KfBQgmnbrA=;
        b=D1mqS5aI6sEOAhYrabRwZlrPpJ7cSa5eH4lAciwu1lldYGfdLDDuf0mPdEkdbXBqpv
         NAaWivIsRsqyQZSSq1LvO4QgMwAwMSXn0VzM/ieqyg0klcAXYcZWt37DpFl1DcejMOMJ
         ly4uCRvovVMj/7BKW90Zo6cYet+i5FwIAKQicdsrIwEAygMzQeKOVAZdYjin8GRYnn5z
         MLDuYDQgjZWYSstYeZeI35xGEbhlgy+9PyUcsKo9KE1yIYyaDsNxt6habYINVE8SV7Sl
         RFfp4veFSoGWWkClkv9AVe9E+2wc2GocUksNeAGpeYA41438OsLy7jxzACtFAYByyAFA
         0e0g==
X-Forwarded-Encrypted: i=1; AJvYcCXFUQG8UfxZk2nf2J70jxR5fpme034KvCkPzODn25j2HoupOpiR4yNlRJdDrq5+03gX8j3lKPl/navX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzr+HLE7mMuFfv/i8eyi2Ae7dB5GjIh8e8I35eAjdny1M49zO9
	4SlEzKfCRaJFppP2wipXmY3diC7zxhmnM2uRLBaxj+hOO7CCLScgE9dF
X-Gm-Gg: AZuq6aL/nwC1nulv0Zf79NUyBtoFcASZd/7G5Df6mTeyO+gdiOUgGOuGRMwt/rZTHKz
	heoZ5ZNHIf3qggoIH5dGHnebfGPFX4kw78yLfU22XvONU/m77mqXb2CM85wdJovhbqJ+j2lAOFU
	+1RC9PRovnyJma70wSgv1F2YtYKjE1sS1d7P2vJV1QMtw5fz4jDfwtAFEvPKDzKURoB6Y08ir0N
	Rg8eg47SiuYxv/UKmD+dKC5p7nkV+2oc/joOIQWQ4L79yRh1YopU4ge3v5DYav3z6WVqsA7S1+x
	cvZ/7QUKvqBB2SSZMGfKGtJnKrhfnmFMC9gH5P4VgM5r9eu5RlXU8pd3txdwODrv2pBnTgzMhsN
	3jHY/Nl3BUtcHryVFRpuZFo7bUTwh7wvs0feLCAGBmNpn4qD8oz4qefanC3S1iEG4n1n0/8cTtb
	DpyuDb93RJvqFUDCWwwVmYUMDlAK9XijCkOToxMGXU+UumowVzjNwJ8A6Qgp+xsG/AbZoVsUC+Z
	SjeM/mkjQ==
X-Received: by 2002:a17:902:ebd2:b0:29f:f91:35ee with SMTP id d9443c01a7336-2a8d9a5f1bcmr89170245ad.43.1769951021796;
        Sun, 01 Feb 2026 05:03:41 -0800 (PST)
Received: from nickhuang.. (2001-b400-e28b-f958-90c5-2a29-7d9f-5524.emome-ip6.hinet.net. [2001:b400:e28b:f958:90c5:2a29:7d9f:5524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm96831045ad.95.2026.02.01.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:03:41 -0800 (PST)
From: Nick Huang <sef1548@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paladin@ntub.edu.tw,
	kusogame68@gmail.com,
	ceyanglab@gmail.com,
	n1136402@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH 0/2] nsrepair2: Improve sorting performance and add tests 
Date: Sun,  1 Feb 2026 13:03:32 +0000
Message-ID: <20260201130334.3107-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20801-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sef1548@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7527C5F2F
X-Rspamd-Action: no action

   This patch series improves the ACPI nsrepair2 sorting implementation
   and adds comprehensive KUnit tests.

   Patch 1 replaces the O(n²) bubble sort algorithm in acpi_ns_sort_list()
   with the kernel's sort_r() function, which uses heapsort to achieve
   O(n log n) time complexity. This improves performance when sorting
   large ACPI package lists (e.g., _PSS, _TSS) while reducing code
   complexity by leveraging the existing kernel sort API.

   Patch 2 adds KUnit tests to verify the repair functions in nsrepair2.c,
   covering:
     - ACPI operand object creation (integer, string, buffer, package)
     - Namespace node creation and NAMESEG comparison
     - Package structures for _PSS, _CST, _ALR, _PRT methods
     - _HID string format verification
     - _FDE buffer expansion
     - Sorting logic with ascending/descending order



Nick Huang (2):
  ACPI: nsrepair2: Replace O(n²) bubble sort with O(n log n) sort_r()
  ACPI: acpica: Add KUnit tests for nsrepair2 repair functions

 drivers/acpi/acpica/nsrepair2.c      |  87 ++-
 drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
 2 files changed, 916 insertions(+), 25 deletions(-)
 create mode 100644 drivers/acpi/acpica/nsrepair2_test.c

-- 
2.43.0


