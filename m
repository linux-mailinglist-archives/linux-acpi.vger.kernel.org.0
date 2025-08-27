Return-Path: <linux-acpi+bounces-16122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED70B38EC2
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 00:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD18E188F9B2
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74D30F94B;
	Wed, 27 Aug 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKhb4886"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298D30C61C;
	Wed, 27 Aug 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335107; cv=none; b=HnwxsPqNmV/ryZ+U3nhDmSBWFMLXxg2QQ3egF0MTEwkPiWQ4xMY3kSusu4tvXo63jaU4iOUt+iyVBkB0iid9LlsG62FErHc7eVj/tmiPp5PXGa3hhhVWrvVYYw7oKWIHkd+uhsTm0AqNUCDPjEMGGg3e8X6jSDWdnn9oqsUw4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335107; c=relaxed/simple;
	bh=9cV81rIGpOy/YM5fTPAKbxKdQSFcMwRfOq2BESMcKzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7pJDDnbwFNURxPPyrI3daiZTLIdKUDp7siLlxO16qDT8v6SYz4xk3o8NBhi+dzEhIGoHBP/rMYtAZFp0M+8XrJcXB84PFOGpCTZFSR5B0Nm4qOU5E2SJfnMtkogLKIYWCXt7NQk3l6NYQ4nsGPjTxbLUyRoUljrua+Lbu4RZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKhb4886; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e872c3a0d5so45098685a.2;
        Wed, 27 Aug 2025 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335104; x=1756939904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLKctxTOQt+KSqUzMXlw+wuQaBiyEtfCcGttdld7tsQ=;
        b=QKhb4886oOnYK6Yg6mbXpGSsOePzYL4FM/6XmqPCMQsm6SJ8VRgxEAR3IbnqSuBIye
         JkXah48elK7HUiTRKh/x/3zrQlXFuK3yiDsKmmrMa/sPGxc6XuziK/y34my13bc0B5w4
         JaI6fUtBSSO8orJX0LZtDucXifhHtQ+lb1Gl3suSgXGUrBZYvMjjjB2SQZRmsJaG2NTE
         6E29yKmnraZz3LWGvQi42PrWkrFwjNIziboprrC20e31Bj/UKlqUv2h66owbNdRAYBnm
         5ZxRQhMSF8i5ZRSTN11KzdrBpfaeYHCnx1KD3AsK67ql4bs1WG+ftUUMjiBDtAMZtHUp
         FfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335104; x=1756939904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLKctxTOQt+KSqUzMXlw+wuQaBiyEtfCcGttdld7tsQ=;
        b=wOgincKKER5mKerFCQnp/DXO16v79ddIuGycXe9tJ+MwG8a5J2p4JNY2w13pmTelLo
         YCQ7qksqU/xxl5xfoQqpEiYOxU4ZcY5XSGV1a3/YrIu/5HXsqfk1nS2ToHmWXq9q0tkS
         EupUJ7GFw7uTtzqS54o+8Ih/jmA/4++LPz2u68aNRBxWTmphEmoUXMw0y+OmEXhCRFyT
         u3rr33ZJi/C6F7KXuA9801WZJtFAB3tLardrO1ogDhhUD/mMGrkK7MsPjuvFsA1a+pB+
         Wbfor5MwOQucR7q6NB7b9qvJd+AYFQ6EX8+bPwIyS1QQ7pOlzV1+PqiBsRSiYniinii/
         a3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXT3xER31WBL2YZitE0QUp9sRdIsM3XBLqk4DrU04GkcKy1M7qjcTYgOR4Qc0M/yDKhkAQ6e35lglK1Ggo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HwkKiwkA9A/FSb1pPmoUC39WEIQkLo2MdYur9W1a7+jlkmY4
	SvwPKyJlE+ardXtuhsY7KsCpTWrLxgGIg9RLzwfatnHMGIK71H5aSYg8ydTl28Yk
X-Gm-Gg: ASbGncujLbaw7hg/8didsmqk9Mfumk5K6qXxLOvIqz4exwjlK2dz0lsFnUw0wwOPQWx
	BzBXFB2Uy6qY9g0byjoEwSIjUwHbQxT3fn5LFBw19xUQdoAKGS8RPgHOPoQzXlnuoON5aZ8E7kv
	kqPmmjnXcmtcroCGWuSNFh7G4cmXfzpPAKxz+nyvJs16AjJomt+cUZhDco+7Sst9oL6AYS/BdRb
	7BWoa1bfPH6krA9WM5y6IVFpAraTmx1ikAfnUKnKAxx4Jq0NrsDwpFgO0hPSexq5haCI5RAAKy+
	adX9evb3v4PpwFpqBYUUXILGAl7AjU3FJ3H/SgnYsU1W/vAoELF7KQIW1f+kpw3Fzg04CVZaWsi
	pW3D7/ZWlxA2gZmxv0tYpvXMLAFvtUlFaQ2dV7s9vTEKBqTXsCy4FiJd1fv0=
X-Google-Smtp-Source: AGHT+IHDaHYGBqi8tCPu0bIHe3JLhoBlRb53NPj46J4iH1xg9p0MMmSeFejFKBzOsvMzWFaf7j+VMA==
X-Received: by 2002:a05:620a:4495:b0:7e6:9b9f:2fe9 with SMTP id af79cd13be357-7ea11093f3bmr2170227485a.56.1756335104314;
        Wed, 27 Aug 2025 15:51:44 -0700 (PDT)
Received: from daniel-desktop3.localnet ([204.48.94.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf2b4f01fsm966237185a.36.2025.08.27.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:51:43 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] acpi: TAD: Add missing sysfs_remove_group for ACPI_TAD_RT
Date: Wed, 27 Aug 2025 18:51:41 -0400
Message-ID: <7674021.TlGXAFRqVo@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Previously, after `rmmod acpi_tad`, `modprobe acpi_tad` would fail
with this dmesg:

sysfs: cannot create duplicate filename '/devices/platform/ACPI000E:00/time'
Call Trace:
 <TASK>
 dump_stack_lvl+0x6c/0x90
 dump_stack+0x10/0x20
 sysfs_warn_dup+0x8b/0xa0
 sysfs_add_file_mode_ns+0x122/0x130
 internal_create_group+0x1dd/0x4c0
 sysfs_create_group+0x13/0x20
 acpi_tad_probe+0x147/0x1f0 [acpi_tad]
 platform_probe+0x42/0xb0
 </TASK>
acpi-tad ACPI000E:00: probe with driver acpi-tad failed with error -17

Fixes: 3230b2b3c1ab5a0d3f99d5850bfdc4bf48d11cdd ("ACPI: TAD: Add low-level support for real time capability")
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 drivers/acpi/acpi_tad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 91d7d90c47da..33418dd6768a 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -565,6 +565,9 @@ static void acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (dd->capabilities & ACPI_TAD_RT)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
+
 	if (dd->capabilities & ACPI_TAD_DC_WAKE)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
 
-- 
2.48.1



