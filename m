Return-Path: <linux-acpi+bounces-12539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E784A758AD
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 07:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146C31886702
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 05:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840438634C;
	Sun, 30 Mar 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDP28CiP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCD6A009;
	Sun, 30 Mar 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314033; cv=none; b=palmwE80yIBgoDofSfU51z43Czudpu3F4VuVHzOtnOWYZ5hwkLHTI2ee6c1Tlu8foPRd2digd1ZbIqT+DKOnh3GuXJONPspST8mH1R44lmdF9YWqW796oBw4Q+/YZxJD6GxjzkSTLuuwjPTO2AYujEGNUdbCwQcBzal96kYNDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314033; c=relaxed/simple;
	bh=2Fhv9qnvd8RNjpQuGaYtULwR1+y1/6h6SMgBrXpH98g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QekkQ3eSye7bZY9cww3hQKF71PxjXPrtcdpFDxNtuPq3GP9K42Nr2EBfcojjk5YZQteu8P0RvcHqUNjqKhBR1QUBoRO11ds3o8ILQ27q1IMYf571JXoSFn4EOCCIjfa4Y8ESM1AvqPcbNx/iQGwoXRzQFTR4Cn62qXzS2Ec71xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDP28CiP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac339f53df9so626745166b.1;
        Sat, 29 Mar 2025 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314030; x=1743918830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7+opnZnWv2RK4udQA4OVRLQ8DCRiE3lR+tMnaFWVmg=;
        b=fDP28CiPoMUglOFZBzy4q+I6NlHfTsShAiY5uUMf5lvLdUcfRWEo5denYuXJzswA2D
         3y/QtlqN4GXJQ2Zs7joVxqrtWDIEnwmF74yweJN1q/OQxf2Pl7Dapx2E/MbjWVaUJSXS
         AsTtoJVmKD45G7xfYgulQh61j1M8gay+9AlfnQlY7vneR+7KtObzWe9zBA8uSFnnzlMk
         +i8RgPpiLnRRX6YfLiqOUeGmYHcJ480X4jv112T6D7Adism0/a13nSxu51evLTj6+YVS
         ky3IzEY9kHYmouHjLFHSgP13TklHy04XsdMf4maIGj2qE5bWZFqoZAPKLjlRwzwGJiBs
         IENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314030; x=1743918830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7+opnZnWv2RK4udQA4OVRLQ8DCRiE3lR+tMnaFWVmg=;
        b=nEES0buLPaaWJAvVTxhwy5AVWrEdvOBRxQKFKMWDTTfHl1q2xyoIFnzQ6VIuxHgdLC
         kW2l+vg3B03H+7yNnd+nwXL6RXlZoxoctk7iw2bM5ihcRoG95IdMrVfdKFO8vc9gGi3P
         Qjl6HV39a7lTjBs9Syadi/oFANqsYK9uIsZhsUGAVI8dbsPIko5hYyiIf+4ZjK3X8AsX
         IM8KI6nd44P5Tz5ZJ2QqHzW/9HgLclmyAIICwbuqH+/c5vh/zbd0zhsbq0QQHhflm62L
         I1Brl78hPr2aGjq40YOUcUk2KMfehs9zH4gc2s6L72BIUi4insvTNGri1xy7mzEMO/cm
         ojJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqKxQpG/ebBQl12mLufTRzTD2HBOQMvRHxSSP2cCerqDlOQyCWlT2JUYgyHHmcfcZEY0AtrHnhFvOn2wfg@vger.kernel.org, AJvYcCW8lgkXM03f6tTGo2v1Mysqv8s0EFIYG684sxinxOcf/fCc1bmb0srBjpi8gFkpmVpJkNPUttZfGJx5@vger.kernel.org
X-Gm-Message-State: AOJu0YyzA3N6FNbOWa72GRzDyZDBEcne6R4A/Nfo8gzrt3I8FXAVgCyZ
	KQ88iK8z8K3M2zvtHvdPHnkX3UuHieM2URRcoULeTakcFQD8tWZn
X-Gm-Gg: ASbGnctxO7z9zAHSkLLT9IlfBVfb+nwnbYaCLnXTZSNiUHhpN2Nj9EjSxEQL8v1MyMS
	izZAR7jSK0RyFMQFjfmSEcXY9ypGZPzai9sPKM4Il/OVFy5HrWDXCPCrTLOqVfrGGoosjFrzSxr
	9z1s102mBwAhcq0GypWFR1trqCXjS7Lq4IECXiIrL8ynomfKxbRiPRb6M8vl4LddUaWM2Q3UGKP
	PbGaf4NRSvvXwmBsMva1BrMXTpFC/aOcGUst/yGfxq02cl6AqwiXy9pKRtwv8+HcIwj1kfGJOFz
	egDF8S7Fp24n/25awX+7f4B/rQ0JBFj13ZGVn3q6vDjhq0WfKC8WLPThGIpXzPi6VVs=
X-Google-Smtp-Source: AGHT+IFt1IoPQ+hdWHf9zq0XxxQYclb2T0wJwu5XUmcSUTJ7OgzLLs+YQy9bosZqvphuRf4Q85XUYQ==
X-Received: by 2002:a17:907:9629:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-ac738a96fc7mr372842066b.34.1743314029858;
        Sat, 29 Mar 2025 22:53:49 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac71927b12dsm441296566b.59.2025.03.29.22.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:53:49 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:53:40 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] ACPI: replace deprecated strncpy()
Message-ID: <cover.1743313252.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

strncpy() is deprecated. This patch series is split over two patches,
the first of which annotates destinations with __nonstring, and the
second replaces strncpy() with strtomem() in the ACPI_COPY_NAMESEG
macro. Additionally, two replacements in drivers/acpi/acpica/tbfind.c:60
with memcpy().

This is an effort to avoid using deprecated interfaces, and potential
compiler warnings in the future.

Link: https://github.com/KSPP/linux/issues/90

Ahmed Salem (2):
  ACPI: mark ACPI_COPY_NAMESEG destinations with __nonstring attribute
  ACPI: replace deprecated strncpy() with strtomem()

 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/acpica/tbfind.c                             | 4 ++--
 drivers/acpi/prmt.c                                      | 2 +-
 drivers/acpi/sysfs.c                                     | 4 ++--
 include/acpi/actbl.h                                     | 6 +++---
 include/acpi/actypes.h                                   | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)


base-commit: b3c623b9a94f7f798715c87e7a75ceeecf15292f
-- 
2.47.2


