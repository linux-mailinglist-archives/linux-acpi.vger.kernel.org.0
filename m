Return-Path: <linux-acpi+bounces-3287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BE84D917
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 04:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6261F22896
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 03:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6512C194;
	Thu,  8 Feb 2024 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZF/FY+Wj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A422E83F
	for <linux-acpi@vger.kernel.org>; Thu,  8 Feb 2024 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363884; cv=none; b=rpc2wMtt9HVBReiOhKESmdUfpAGtBQBM859L0tAj5zkIKpe827FpKTAQAGUNUSUm3af6tp0GfkbG2qIO3q9l7cStFwYBPQtY+NOjrlxC+IjofTkj/v/79dSZjPcWmncY0igNo+gQyRHdqbKU7n6v88MbfxBISlm9errEEbav5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363884; c=relaxed/simple;
	bh=k//nL0O52r0Pst+dMnarHtp2qW40QOxuRpgoBz8kxz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qtw1q1BIaPwMAwBIhDLH9llUOm3gt1M0yIZKB2Hi4Slwzy0e2ldLSMsPnWX0ei8ccs+8V2kt9kjFDmcT7gBL7b2yx8MxZIknTtgiSH9NbAyV8lwE2+e2oDZTJW06snIO1ZCbtcjMek3rCarmUxmdotBuKPvh9sZxVetDICT2h5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZF/FY+Wj; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-218eea4f1a7so751938fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2024 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707363882; x=1707968682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHHbaCQ0poyIlU4NNDp8/EJ+oDcSBjCEciZfSlQAroE=;
        b=ZF/FY+WjnT3ygBMUPf6UDktNH+t5dSGZi617TrWm/5EmMUQmaKakp99wR7Q2hyZRtu
         oNgrqOifXttQaI9RzNJ4ay3MKfYrflfpcR8bPsr5FLeMANJ4wJ8JxQ3Xl/qVzykjgQKN
         04f00ErSBBM+FGGlrI6lQAzdw3OeFgxsIR/bTfEBZeYSOJcORX2T2oH+1OQDlP8z+Alf
         V7pqgocVhcsh9WjCkyaK4tZ+u8Cofbnse0SuuTD4GaW4nwkQLQQbWyJ1CG7sNDEjdUns
         8A5GmRHlsGd/FNQgqkBZbJQCzaved9w090gzAsUmHy7YqGRNF+mfYrsvldB48sC2HreU
         98wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707363882; x=1707968682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHHbaCQ0poyIlU4NNDp8/EJ+oDcSBjCEciZfSlQAroE=;
        b=lpSAiAhyuQC9unzEdF+bHOqHCn7VxzvtJ2f6az7Crj+VGeN6ak1GBS1YWq8SF8V56f
         Hj9iUwpXogzvGDYYekL2ajougbvssCJGrS4oenbu5e3JDf6klG76uxSiapJrHbqGCEgV
         BdMQnYGM7oNkJuaiykR4wZybTv9Fc/tK9GY/+SC62V1LGbBVQoWahPMVMeHQft6EQvu2
         PzqmuAjofnZI7uuDo344w+be18mgD1maUTts4gPKflQeOv5K4sKtPfVhkxCd75iEpM9L
         CqHjsavnhMSmwj/JcFOxtrfC2gvlHbv2/fY6SawN+PvEZ6L+CMCw/RGDiLS9vt+1urJx
         pVog==
X-Gm-Message-State: AOJu0YzrVRq3rUMQCUt++du0f0TM+A3qAYVLxpiWKsVgQKK/jFCfDhjY
	a+a8vL8CVyOU0DxjUkUeFKuikN3h4uszd8sFzbuHEXFCSNJRWyp+qwb8STNhV/I=
X-Google-Smtp-Source: AGHT+IF8S/sWdD2/t/IehosLthOGcp9RQPnzkTr2qd4mbuxfbLO4HkNLnW4usy2ZbfgHlv8pV/ejiA==
X-Received: by 2002:a05:6870:5aa6:b0:219:efcf:4566 with SMTP id dt38-20020a0568705aa600b00219efcf4566mr608603oab.13.1707363882197;
        Wed, 07 Feb 2024 19:44:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVh/Tfazr2HX3H9HLVSgqn2h5sWZF5zZ5Zu3TylAEJBkg6WlJX4/E7mdRNyYeqRzmewuTn9VXmXv1FtoOtXhtlcOre2zou7FFXQUDmY6pI/9p/FsbwVr0+8GGlVgHQ9AYdz6tBzr5/i8hIFf+7EspTg8jBmrbfhdhTP3qiwyFvjpwO2in0n4qTOitGh8nK7brPcNu/Kvh21nlOV/qTSz2Rnp1Gbk49vPosP7AWKXM6PoV/qytusk6FagZIAGKefqaqZynnwmgekry/tFV+XDLPJWXhLi4W2ycmDpIRCad/Huk1Yjxqhm2F7DjWvdLC3aIgaUNaY9EbYeOBLtVswBA3q71Sj1eHrmp9KORNCA/U8M8UAnDOI4Yp334RzlA1isNR7FePtaKlAYAN/Vo8T3HErx+2vd6HLGUiyszV6wXoj9Hcm2pveNgVjS2wxW6nYATvDx94n
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id g10-20020a056830160a00b006ddbfc37c87sm443595otr.49.2024.02.07.19.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:44:41 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 -next 3/3] RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
Date: Thu,  8 Feb 2024 09:14:14 +0530
Message-Id: <20240208034414.22579-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_ACPI_CPPC_CPUFREQ is required to enable CPPC for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index eaf34e871e30..2988ecd3eb4d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPUFREQ_DT=y
+CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
-- 
2.34.1


