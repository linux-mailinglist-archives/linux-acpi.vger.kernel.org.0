Return-Path: <linux-acpi+bounces-8920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49919AB8C7
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC121C23408
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6C1FF5FD;
	Tue, 22 Oct 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XI0zjFlD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C51CCEE7
	for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632899; cv=none; b=KfH0qsy/A9YtLEFJUPPHiUef7/naiPND3BxMIQ6cC3ZNPPFI5Xh7H3tHay5/7/ebKJHEwJm1zpa+U0LaPMXhz38r2Tc13vwwsJHWb8hdULt+03O/98gfSKl9YBrtoX/zvrpx+kgsWyusgY3D1+MEV3+KpELFcoZYvS8hVd8yWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632899; c=relaxed/simple;
	bh=W1pk87B56sY3NmTWTw0fYcdlm0GNbCNKUts7riRYlbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD0NmvGcKoBQ24yUYxHnq2uNO22ZrLUU1oqQ2y22PgdFZltY9jGCp5hJ7y7ITRkIdC1pL06rrI1isw0nJPqGSd66b3fSDmUEVXdfIYdicDD2QrEGItv1sY/p2TFIT4++DDkt525DaYdxbtrg1W7Wd71+QNSsu7h1gwl6+rx2nSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XI0zjFlD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460b2e4c50fso29640981cf.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729632896; x=1730237696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqCv7heAkmMbGyHort0yESB5tthHSXy3Avmci0WyUUs=;
        b=XI0zjFlDTySPEMo8xxPza+roQKJ7BQVdRPzHM0HsauL0+eoX5b58OZ8OeV/pwfVvJA
         aghuv+EkWRV3VIZ3aQxugkQTQd9c9uRXAsrpe6QhB8y7KNAEek5A2kU1Ebm7AKZxWUhp
         QRd+dGzfzhcrkCLozLAVvKlqKIuwYTDRr7b+rfbr344WDRFJC8zNah3r4ObwSiS1isC6
         EEIlyk6VPZ6ywHOZxEFNRb5iz8PqQ436gyDHMfWJbQrlc9oMmzIEyIa37LOW4qmhuOmt
         uG3aTrndbUejvgcqm2vYprkao/PKi8uuQ/6nnO5y5luMDfvBBphCOhIIztedfuMMsmW+
         XcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632896; x=1730237696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqCv7heAkmMbGyHort0yESB5tthHSXy3Avmci0WyUUs=;
        b=Ny79QLI8Ju2ZOODaL3xDPoFUYmR5ddZAIPyjO5ujUHIGzRItn/mK1mehcEhZez/cJ0
         /vpHrTarUDe3GLKU171hN8FMU0XomMRHpePylBZR5RZpzYJaUQefcAE6nA4aTVV8onIS
         XEZoA9prTQQtwpRfa2buVdKXp54iM2oZ97N9bWtyReYw7+12ReJZt1daie0K3S8NKcLs
         +fB5gfrsAl6sVLX+/0jLr26RwGOqtV5VeDV1PIBR22JqknniTwSpSDyfkaXh9dGXicC9
         pi8+gF/rFzYZwjMb8ndALxE8jUDAPFL9XpOqXtSUKDFc3qhsMYq2Ce6uhajSfkeEWaIc
         u/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIBCKV9GQi61BP2yhMcrmMjk7mPGUtlHagDFBm+usJTUYmbEcZOmjW9Txc16GjipQPTbC/zBqS0nJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBpdSWd7fQHjLhMokL2Jjo3OD1Bs5YZd4r9C79FSD0q2Po9Jw
	dO6Ok/MlN1zSFtNNfTW1Qm47PbRChrEmPxPUidIRBgW/yIUGniGRvz0loSr0cGQ=
X-Google-Smtp-Source: AGHT+IG6u8nXwqeHHa2iAZjSeQvjzXX9LlJNqnqKjo6O88p7xQbadR2zh6+g2YkgEfRojyf8qrAQmQ==
X-Received: by 2002:ac8:59d4:0:b0:460:8e3b:6790 with SMTP id d75a77b69052e-4611470b2b0mr4519561cf.48.1729632896082;
        Tue, 22 Oct 2024 14:34:56 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62f4dsm33845841cf.28.2024.10.22.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:34:55 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v3 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 22 Oct 2024 17:34:49 -0400
Message-ID: <20241022213450.15041-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022213450.15041-1-gourry@gourry.net>
References: <20241022213450.15041-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..93d669f467f7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,13 +1452,17 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_probe_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
-	}
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 
 	/* Find the largest allowed block size that aligns to memory end */
 	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
-- 
2.43.0


