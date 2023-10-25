Return-Path: <linux-acpi+bounces-991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B07D75C8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF174B2092B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8AE34186
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="auVS/K/J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1833985
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:24:45 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047F198
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577fff1cae6so96828a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265483; x=1698870283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmA5kOKekb5h3Uw1k+e0LhCWijGnTH8utnJ5szxpch8=;
        b=auVS/K/Jk7vgky4MjvSPyw3256thHNswIFM0+CHRJfw8cZMbSsKDL7aCq9OiRUFHIn
         vhqWb1Ba0aPYiVgfisYHsfrxFFdjBfLbOs15MAzbLhPHxuRqT5s81JCMSPHp7u4BnRry
         2ZPfCe8yqF4CGCh/KyUFfF2HFzYkNOEEm7i8nBl2N857thL2U0IW97wJcK88BIZUrGVV
         OYTNiUslB8+H3xiH1zs8mwP083VVwgO4yBf3eLBh2Fzc2+Waue+65NOTaD2v8RT8lmcd
         FXE3K1JffCz/cOrAvDcRniAps0d0N0MF3sseo29l7YXpoM1uetpW//TUo52Ge7kHw90C
         KoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265483; x=1698870283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmA5kOKekb5h3Uw1k+e0LhCWijGnTH8utnJ5szxpch8=;
        b=wADGhYu5/aZ1hfHTrpFEcpeRkwirlZ60Ato0Fogok6xlj0LOxogXSAXwFhqPOG1D1G
         wscN73dV/t+3Q73vCBRICoo/aEAi2hCrjhpJlGFJ9jocCl6opADSpC6NvlvSf3HXKbuV
         NIT7FGzh5Oux8AN3xq95J03xUs2F6LgMBGBwM6SDGYmhcAjsjRMjAMIpWRY7GOggqE5L
         DcJJtdO35DGHZvsIMwlNyeCSuiYCNeV3Y3SdaV+pR3Z3bUx6+aLuG9oOoCkqHIALNOIm
         zvovRoZEH2QLNe9FaiZXs5i6vRVPwLm40Uj0cljMuJ25K/4KWlVrjWKJRabCCKZ04B8C
         HuXA==
X-Gm-Message-State: AOJu0YySWljYjgG5ZWoXtIt09kUX3cCcxz70qOvde8luIS/HiQY6R8rZ
	TRqJ2vJawRKhZB4tvWNpjLh6jA==
X-Google-Smtp-Source: AGHT+IEWaGrpkEpDFbneFUdLQrgY3wxCJPmh6tSJaEBSJOipB/ao+CEA+asAJLO3X3etojz+m4Eg/g==
X-Received: by 2002:a05:6a21:999c:b0:17a:f4b6:bf89 with SMTP id ve28-20020a056a21999c00b0017af4b6bf89mr713082pzb.31.1698265483317;
        Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
Date: Thu, 26 Oct 2023 01:53:29 +0530
Message-Id: <20231025202344.581132-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

On RISC-V platforms, apart from root interrupt controllers (which
provide local interrupts and IPI), other interrupt controllers in the
hierarchy are probed late. Enable this select this CONFIG option for
RISC-V platforms so that device drivers which connect to deferred
interrupt controllers can take appropriate action.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c105a151e12..b62441aefa6a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-- 
2.39.2


