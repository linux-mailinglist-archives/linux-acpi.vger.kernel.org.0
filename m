Return-Path: <linux-acpi+bounces-20560-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LihMEZJcmnpfAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20560-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C08695C3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F53D300F876
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2135B649;
	Thu, 22 Jan 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih16WRW0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220D35B624
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097321; cv=none; b=MW5uJ1KKPb9SsUl/U36w5U6D4NGHkpw0vCzixlW/A7u/gjAIY0fQeDth6XQyfJyHV8bCRvk8fEPzgg05Bx0aAPhDzfcl/GNDAubTsfq6NjaaKx5L4HajULRLkJNILEiznlq5VD029amP+vQyGOGKlaOJE/Sn5veFRbQWq+ML8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097321; c=relaxed/simple;
	bh=1lJiiqWoJdn86LEsDUwKr3hpmoTFDu27DtAns1UCABk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bi5/3ihQ4q1bjU94R4KiSM+SrN44YQZS20ngNoEB92yR3fEWGbR1fm4Q+ijb+zeZ8R8M+cmObsLyEJOti5IyrHsuna3QBE6rsPsczAWO5tKTyb2CeVDLFGX2RSmr4Icc/yBXKsq0C27dURZr8SZPLyhcccY98uYfdhob0/dvleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih16WRW0; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1232d9f25e9so208442c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097309; x=1769702109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTnCx05EWycA27LR6+sAdSVg/yTmd3i6OMWgoqxWzqk=;
        b=ih16WRW0cv9YjOZIbz2XI24d30Af2NGcOuJap7sybeUGYVwdjQVF7GNFrK55T6mVJX
         qdQG+xmG8TfMmYgt/zAn7CHi8rREmmzW32dHazaoJdMxBHtsLG4e/zJW0wGFMhW25kFL
         qYRVSvebKiOrTz7pxfVafJRS5Nv+bVkM0T1/FSEFw442aiXO6HqUywGrrGaKpZdNOpn/
         MWLzEF9AImYKLjh+l9kFR8IAi0jtxUbfEbtrlVQ7gJ6Y1Bip9R2bZ0HiDoUNuZSpbAcf
         UWU3AywwQcM3ParyEgMp1E0CpfL0Q16ZJk3u+bCGPnx1RjRgYAG2sBnUDDeGwQSCMwTe
         M50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097309; x=1769702109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTnCx05EWycA27LR6+sAdSVg/yTmd3i6OMWgoqxWzqk=;
        b=qf3teeGWydwoWeuZqBcfkAL9/bPYVm9Nm48p7KjPuMsvkgMH/Td/01VB6W1FC4Meg7
         wvlXoNxuPeIwIgI2Qwn/4xHTsu6j0HZR8g6yckNkpsoyIdTLWIuVAtzSvPpmwCk8w1Vq
         t2BxcpWmGmMBEcMkUJHIvBnVVULfPRYAE8hedbBwt9VmkJbhHTo8wwgUZS2ZPoCo3aLz
         UyfcmCRCdjeRkIFzB9SEKb+XRhbXJFw92KQ6xxlP9npezh4bsr+2fN1ZrFfcdz0PeyrY
         6CMk7QlIOx4FrXzYd+KzbOhUd65R4bwaGWUQ4DExd0sMO8Ao9aObeCu0IdaQuwp87ACA
         L5mQ==
X-Gm-Message-State: AOJu0YyIfKeZFOGk2F8BK0fUHPpvJteyKZOa6htS0ICZzqlTMPoUsTpu
	Jq41XikkVPmyAyOMG2/pbxnqJTmweCXeu2O0SpMbBKfo1K1UgYbz9Uh6
X-Gm-Gg: AZuq6aJ6ybWVOv5SQ9empSnHm1Rx7A19cPLNcexGo6QcN2rZC49tKyDjQksQ4qWjrH/
	SIHtl7Bt9lGV7Lk3iS0RzgfZCx6YaIhP/R1HtPrue3VpY3u/NBxDWMXLequZ/0V02iHjeUr8KAr
	O5Qykj3AERvCN1sI5XtyUT5vUBGZNMKKh2g81DvDccA7xRxgJYu4ggm8E9/5T+K4bT9+lSe8bvg
	cc9bKTL+I30QlOQ8a771t3Bw0o7hn4sBggLxcIEnrU3UBqfTofgj30LKgQ/8mEZC218bAXUVeS7
	bOGs0YpLSyzywdvo91PzotY/323nVA7Aez/fISvtV3zngW+EFl4XxrE2Bejnh488rkiTncTxdP6
	ch3+7lS5xjIl3gVCjnAxYb6LWVxtUA7qGqjnXa01ZNIvm+1aUcyPKAg5LEih9245fiKRF4VZr7a
	01MFAuuooebBnWDlbzx2b9JgS7jFrabQxyQCNuLNHI8kkigVcRcMvt
X-Received: by 2002:a05:7300:e8a2:b0:2ae:5d5b:4ed0 with SMTP id 5a478bee46e88-2b6b40d9dadmr16548799eec.21.1769097309215;
        Thu, 22 Jan 2026 07:55:09 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:08 -0800 (PST)
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
Subject: [PATCH v2 0/4] Add quirks for MECHREVO Wujie 15X Pro laptop
Date: Thu, 22 Jan 2026 23:54:57 +0800
Message-ID: <20260122155501.376199-1-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-20560-lists,linux-acpi=lfdr.de];
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
X-Rspamd-Queue-Id: 31C08695C3
X-Rspamd-Action: no action

This series adds several quirks for the MECHREVO Wujie 15X Pro
(AMD Ryzen AI 9 H 365) laptop to fix issues with the keyboard,
touchpad, power management, and headset microphone.

The laptop requires:
- ACPI IRQ override for the keyboard.
- i8042 quirks for keyboard/touchpad stability.
- AMD PMC quirk to fix spurious IRQs during suspend.
- Conexant codec quirk for the headset microphone.

Changes in v2:
- Added Missing Signed-off-by to all patches.
- Wrapped commit messages at 72 columns.
- Unified author and committer email to 550230171hxy@gmail.com.
- Properly formatted cover letter to improve threading.

gongqi (4):
  ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
  Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
  platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
  ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro

 drivers/acpi/resource.c                   | 6 ++++++
 drivers/input/serio/i8042-acpipnpio.h     | 7 +++++++
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
 sound/pci/hda/patch_conexant.c            | 1 +
 4 files changed, 21 insertions(+)

-- 
2.43.0

