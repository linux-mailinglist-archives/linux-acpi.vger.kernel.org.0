Return-Path: <linux-acpi+bounces-2789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76282AAEF
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC91F24459
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD07B125CA;
	Thu, 11 Jan 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nystDnn5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936611722
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso40924995ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704965466; x=1705570266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0u2ZqaYTukKS/ErfsgIWqLBT0BekDb7tY/EUWordXcQ=;
        b=nystDnn5QuSvip3d60xSy0rBgMQrJnJMPbGIEhWktq1Bur8GW0CDK/UMU/9o1ZyZjM
         iFzPBHBFRPzOx3MGYetwX68u3Ohy5Y/H5BqOj677k0f0Kv+2YOvaVDffmPxGMkTIxv4U
         Z9hOP9Cu5eI32TZ7Sd0f0UVQ5sGRrSQR10M3n5oj2qAXvQy3GxgON3vpWgdUb+P5V5Ez
         m00Ps2TfSrOcMkSl4wRcrFBXf3YUvUOUjqYPHxIq7R8D6cH+sSSQ8xWV3qc92lJCJWUJ
         x32//+koXUakHI39WmiQp7ZUToznzUL382cRvaoTaTFAvQUbHH9MEdDzHBRn/t8RX4BK
         TroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965466; x=1705570266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0u2ZqaYTukKS/ErfsgIWqLBT0BekDb7tY/EUWordXcQ=;
        b=bXlToRLpjDJ955wxmqeEkCxrjtk4HSpQzCyEx/malcPIHaGxZCZpeFwbtN94JEPMgg
         XYGjQYDJ1tJ24HVPFIhRqSKO54jDHw2AI1jYcxomVPA0KE5kMaMYMKfkE0t4GP+Skzua
         onRMXSha3Ruxnw1RD/FSx3WzkEROVopSnYzViDxvvru4xrm9ZPJSZ14kZsFCqFlD0s0E
         wRDyE23euXXaCAVK60VasjYgWM5DsY+rPAncspyAbUL4S0iJob3geanp1VAHM3y8PI/e
         Kz+BWQO33vVmq8AAEqNx/TU8rL2o1y3/NXH63L5Sl4Cg7DEAOFs/hSbN4dDkn36Q/NHV
         8/9Q==
X-Gm-Message-State: AOJu0YxX3SF6dSAjKkGG3WjbjBjdACSL1SQcS7VnCHgSHeGhc9rBRbmY
	ytMtsoD+mjYwn7F7sfoYsXJcgYeAtPkT85AH8xDHXchqseSd8g==
X-Google-Smtp-Source: AGHT+IFdmA3NHb1ER4UFaUxR1jSr/olfCSoHwNY32G7qcH3iYgX8OKA4O85XbeUboGgxDYYmHv1L3Q==
X-Received: by 2002:a17:902:bb16:b0:1d4:e208:9b0 with SMTP id im22-20020a170902bb1600b001d4e20809b0mr880703plb.44.1704965466610;
        Thu, 11 Jan 2024 01:31:06 -0800 (PST)
Received: from sunil-laptop.. ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b001d4a7cf0673sm730566plb.117.2024.01.11.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:31:06 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH -next 0/2] RISC-V: ACPI: Add LPI support
Date: Thu, 11 Jan 2024 15:00:56 +0530
Message-Id: <20240111093058.121838-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Low Power Idle (LPI) on ACPI based
platforms. 

LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
enable this is available at [2].

[1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#lpi-low-power-idle-states 
[2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v/riscv-ffh.pdf

Sunil V L (2):
  ACPI: Enable ACPI_PROCESSOR for RISC-V
  cpuidle: RISC-V: Add ACPI LPI support

 drivers/acpi/Kconfig                |  2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.34.1


