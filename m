Return-Path: <linux-acpi+bounces-16054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C83B34F12
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 00:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C51816944E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B61EB5D6;
	Mon, 25 Aug 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beSoNAHn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700451C5A
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161234; cv=none; b=dJF/8s+CxsakBX6WRHbNLqic2cQhirfaxGmLVpCLftyJUqmFZllPkX6W7dWJRPSMQ9/llyBYPVAh14qFEg/bXqW+nhWpPuyLEuDbfjHqgMmPhd/6WnRdKbvWYQaATK0znoXoJkGyIKzFlT7PTabS3mnnB6oR8mES16vnT30U+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161234; c=relaxed/simple;
	bh=hKdSvLo2bz8p72OWEP0hZUcMo6Klib216DabiEfHw7o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XxLDmpgVNchvk9eVXQzWCKeO0Mk2UiGrJFj7kWJWo1R2DIUeIzFefkJxgGFhINmLb3QdIYH/hNrYzxIsJdbHar3KlvwZLJzGv6irmbo47/S+xWi14HnPmVFZZDIglVW5/TWGhtk794ylq7uRYVCWQNN6vm50HPAU7vQPK1tMIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beSoNAHn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325b2959306so2275385a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756161232; x=1756766032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IChvdfBS9wMpenq+Mm5AVlJVJMnn9aA/VrNPYUMhdCQ=;
        b=beSoNAHnIO4vFndwK2CvE6X/XRKIppDX9S9P+bkyWpHUF/vYPGyGXEmxcjKXt6xaQB
         KvTLygdMGs4qWWD8hlQ2fuzeQD8+PUFIUloy+/V2V9TmT/U1Rrb+mc3X1yvvhTocuuXl
         7HDPZeVl1HXs+8dg2l/7lBxT0wn4nMIsL3a1RuhNXIhlieTpvKmu+oT/mUB5q0bsD3d1
         gfu0x+6HrKUgn54jozDAqvLhqfKQQ9kk6b2iDK/B8J0Q69pDdj/cBfZhbw+HhTp/jC72
         t8WeS9mKrkS8BoEPgI7tPDEYZwQIZsioidjqsMIcHji3SuV4GBa7dZdYgp9Ce25c0qJ3
         2+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756161232; x=1756766032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IChvdfBS9wMpenq+Mm5AVlJVJMnn9aA/VrNPYUMhdCQ=;
        b=vda+MraiwoqSLy4Gk1Jtzu3Fmqrm8Tr9A7BFE7CxB4rww+HyFNb1joSZqPbuiD1sri
         pCiCRJdjgQr79A2RkM2CP7cXMkeTMOv42FlU9JtoEuskVq/mzeMyIxMWjCfbQLR3Fmc5
         tefoIskPsGfrulhdS5Eikyrz244rk0zxnhnXJpWg8VIWmKTCHZNNPbIoJGfpSRm9/L7m
         ymYLFzSubNxYuHngoCthVT5yCpQJUbpFfDMVDt+PDk+MbKY6KIMTABFy+LGPw4NQBp9B
         g3xnn8/9eicTablrekCM11qXveediPHowj93wYyLT/vSL8kizlx7fx/hH5rKY028Wtta
         oSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9XaUKoVQMPUiFbvXMKr/m5yGBMet1UD0LtdYbRe8jEj18wdgvav+XoQNtf8BtWTRL1VxH9h654mGx@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjO4qgDRajSj9q0KE6iLUHVfdvBNPEG/eUuEwhZ+Kugx5vAia
	swB2qHAytD+a1NsMO1pQCdjEjlDSq8bzWqPdORRq/jOuUqI7AQp8LPL+TVgN+xN+6ut5n7Vvex4
	t2c/7jNDoXrFAig==
X-Google-Smtp-Source: AGHT+IEVLiKUIeoBjyCsebxXipdFCCm06uPKusjXHZml8E70gNBEvvQ39nsMgG+SkIFJcsC3llllB4E4mvNVOw==
X-Received: from pjkk5.prod.google.com ([2002:a17:90b:57e5:b0:325:9fa7:5d07])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c45:b0:31f:b51:eef9 with SMTP id 98e67ed59e1d1-3251774b612mr17865676a91.17.1756161232239;
 Mon, 25 Aug 2025 15:33:52 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:33:48 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250825223348.3780279-1-jiaqiyan@google.com>
Subject: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy persistent memory
From: Jiaqi Yan <jiaqiyan@google.com>
To: tony.luck@intel.com, rafael@kernel.org
Cc: bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Legacy persistent memory, e.g. Device DAX configured like the following

  440000000-303fffffff : Persistent Memory (legacy)
      440000000-47fffffff : dax1.0
      480000000-4bfffffff : dax2.0
      4c0000000-4ffffffff : dax3.0
      500000000-53fffffff : dax4.0
      ...

can support recover from Machine Check Exception due to memory failure.
Therefore there is need to test it by injecting memory error
using EINJ to legacy persistent memory.

However, current EINJ only check if physical address falls into the
IORES_DESC_PERSISTENT_MEMORY_LEGACY region. So attempt to inject
error to "Persistent Memory (legacy)" fails with -EINVAL.

Allow EINJ to inject at physical address belongin to
IORES_DESC_PERSISTENT_MEMORY_LEGACY.

Tested on a machine configured with Device DAX:
  memmap=4G!12G nd_e820.pmem=12G,4G,mode=fsdax memmap=176G!17G
  nd_e820.pmem=17G,1G,mode=devdax,align=1G memmap=176G!209G
  nd_e820.pmem=209G,1G,mode=devdax,align=1G memmap=176G!401G
  nd_e820.pmem=401G,1G,mode=devdax,align=1G memmap=176G!593G
  nd_e820.pmem=593G,1G,mode=devdax,align=1G

Injected error at 0x35238d2000, within Device DAX region and
allocated to a userspace test process. EINJ driver now issue the
injection request to firmware, and firmware logs shows injection
at 0x35238d2000 succeeded. The userspace test process then
accessed 0x35238d2000, caused a MCE, and killed by SIGBUS.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 drivers/acpi/apei/einj-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2561b045acc7b..e746fa66f92ff 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -712,6 +712,8 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 				!= REGION_INTERSECTS) &&
 	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
 				!= REGION_INTERSECTS) &&
+	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY_LEGACY)
+				!= REGION_INTERSECTS) &&
 	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
 				!= REGION_INTERSECTS) &&
 	     !arch_is_platform_page(base_addr)))
-- 
2.51.0.268.g9569e192d0-goog


