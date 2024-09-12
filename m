Return-Path: <linux-acpi+bounces-8271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7155976FAC
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515CB1F2786C
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A691BF7F3;
	Thu, 12 Sep 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dS4wlnTF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F11B375F
	for <linux-acpi@vger.kernel.org>; Thu, 12 Sep 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162748; cv=none; b=bgMx3hO1C25YzZ6WxUbyNAm0Ffdyhzirmw3NiVsZ8Uxq/iZzwP9+fTxW6S9jstHLU4+Y4XNLLwWqxgLYIbn1ZQOZGUZyPvplJzgkuEgQQEtyEsMtdKk2UO5+K55Rn9i7ljrurLOQ4P1CxWZMAEF599oZSzgcm3R3CtpajytZoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162748; c=relaxed/simple;
	bh=vnB+9idXhCgy5AVg4jFbptofzxlS7h1aP1hq2toSSZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUNY7jlRRZGcqKhWExlHudn0zDczjWsRQPGHGTYZhziBN+5NDjo5/FWUHfS5wkZajVrAF0gjtLBVnxhFIOeFlpNBZidFlTiZ6+6VHNJeL1mmVtUnDQqp4FM1IIhj81QSbv6KSkg/Enl4X/aKKOznYLFpKOp5wEzaYjlT7DnUZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dS4wlnTF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82ade877fbeso4418339f.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Sep 2024 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162746; x=1726767546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkPvlYPCbX57sBLIscwM1o4s5S3tQ3XUG2CHY2rXX5g=;
        b=dS4wlnTFWaBOdIvM+L8o9+/rkD1o42AvboizmiMPAWG9C2qOuoq1517sqdV/lH2kXc
         Of3KUBA/eZyvAZLDQ6Pwoi6Dl0y43ZHyvhrMQR/ogHrBPNA9zw/wbdwrWSitXXFAq92t
         vYjy+SHU++wzVl/X46ABoCF7QQgr5Pl/6zOZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162746; x=1726767546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkPvlYPCbX57sBLIscwM1o4s5S3tQ3XUG2CHY2rXX5g=;
        b=wDkPbFVk/KN7x+xcajyFYxH04f0bpORZf4uCfPcZnkH7U2SdoyVY7Lx4bvIXAxEFWM
         mMv7Xxbem0Wo3F9vnRfqO3LQ2kKOaXgzg+H+NCPAHd5ux+Kg/pTXUSlIO06Z/ZvnTDMD
         k1l4N/wies3k1rr56SP3DKCr2R9i7/yJfEOlaxKF52gCU0McUC/POyjR7pGOhRGfWIcb
         R/zn3Aki6jXKvbggUfwzv7yDYTJhA2laEYKhRr8xOn7CJBV1PsuW2bdDwpOVUtYoSW5d
         EeJkdH1NM/ivhLOeB4cqYzs4OYN0oiy+ciuz9uS7e1lmpA7f8TDhmATJED5GzyIL0qYT
         /rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8u309oStQe9ydsvA7TFB/5zgMZgsAYM1xaaniGfRliw8kDqy4FMl7f6ErrApqrQDW/mc4Ubbk/KB@vger.kernel.org
X-Gm-Message-State: AOJu0YynpNG4FEUdcUGhk63cmmicX3WhpBSlePCkHJaaEo4+Gf5lpVhy
	gKdXjm32LFuod5wWCVlbPLdqSVGQ8y/2BO5eu82MSIJje7ub+fkpuKshEkT53w==
X-Google-Smtp-Source: AGHT+IFVUkbp4TmmxAsFzcXQPNvxYhKtSHk8lxW631++WJrjz1s5/fgX7On0NuVst8yiDDtcDIcjOA==
X-Received: by 2002:a05:6e02:1aac:b0:3a0:4d6b:42f7 with SMTP id e9e14a558f8ab-3a08495dfc6mr41140215ab.22.1726162745917;
        Thu, 12 Sep 2024 10:39:05 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:05 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Implement ACPI SPCR v3 support and minor earlycon cleanup
Date: Thu, 12 Sep 2024 11:36:18 -0600
Message-ID: <20240912173901.3969597-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getting `earlycon` working on AMD platforms is a bit tricky because the
uartclk is 48MHz. If the uartclk isn't specified, we default to
115200*16 which results in an incorrect divisor computation.

This patch set adds the uartclk to the `console=` documentation,
prints a notice to the user that it's using a default uartclk, and
implements support for SPCR v3 so that the uartclk can be provided
by the firmware.


Raul E Rangel (3):
  Documentation: kernel-parameters: Add uartclk to console=uart
  earlycon: Print a notice when uartclk is unknown
  ACPI: SPCR: Add support for rev 3

 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++----------
 drivers/acpi/spcr.c                             |  5 ++++-
 drivers/tty/serial/earlycon.c                   |  6 +++++-
 include/acpi/actbl3.h                           |  6 +++---
 4 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.46.0.662.g92d0881bb0-goog


