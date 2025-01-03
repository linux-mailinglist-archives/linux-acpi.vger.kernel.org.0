Return-Path: <linux-acpi+bounces-10344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4EA00349
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2025 04:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C814D16312F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1981957FF;
	Fri,  3 Jan 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G+K4zY91"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453279E1
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jan 2025 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735876293; cv=none; b=fPjVsSg99dh4Q5LvOjz9BQRUrFRyypANHdYYcjCQRoSl9eZEvAGWLUIxydpa7cQBIwePP95ZskQophHqAbd4HHwVFk4qsOke2Xqx/v4GroHBlu67ZN538ylgjJWiwOiLnY/CcS4IvWosQp1vCR2t5gmfCmuh9s5nxc62PCqHQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735876293; c=relaxed/simple;
	bh=J0RS2Y/3i7zSWbCrPylfoWsS0Dycx+v0Lbw2C4KIcgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuOVuC7g1blvhz2beGZ2e7smjwHTqm2dLL9QXxYRSKsF+2wMDLv5cKckrV/tne8xvsOLNWTQqzQDXrtXFoGHOFHX1RFykTuvOB9GbYID8zXNp3ItYfA3QNx+KRU8jDt0iFpEAlpUv6cJQZy0cKcGLw6uZsB0cL583wQj6XBDaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G+K4zY91; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so160320065ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jan 2025 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1735876290; x=1736481090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lgzNXUiBA8yQfqR3yckj04m/Cj5p3G72SP94HTml2s=;
        b=G+K4zY91uZIDJE8ZdY+SdXtQzlNgVjcqCZDL6/PMVPkR929tipUGrcL9kKYfAadz/B
         DttC05ViQmoJDvuy0ekVWWiKj3VB1We+7AywqPyUvo4ZWD+IFUwfuNSLW0SuosYendGr
         CQ1wgM8BhozMVuQp4oDYmcOZVaESjJtxk/Ftx3LQxKxKvNJSzam1t4Q6yah+JbsPNbTa
         B6SzN6bh+gDl1/LGiUKhDckDCyo5IU70oNr2sO63so5CBQBnLiENCPulT1Fzwr0qExOx
         xflen5+Qc/Q3zxJ5lVLwuP242hxDBjG5pwB3a1g3KhXMBcCRqg2TvSq33+C1f/u0pzvg
         P3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876290; x=1736481090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lgzNXUiBA8yQfqR3yckj04m/Cj5p3G72SP94HTml2s=;
        b=wuIhxSH7Aa9MnKKrJhN6CYJMIaxTXodO0/zEIunQnMBAui2mwmCgL0LyF/pjFrptTo
         kUnT3TwDOhweWFbhQDDmUtsKsfRUvpy607sw73TYB0lqox0+RyBkpwIIk4lMVGIHP4Ug
         TluIot5wY5aYavtMMcmHVtCjBxchBAbkZoRzoeUN90elx0N6B0shovOKkfGaHUwQXVAl
         DoQNyteF5nsrtyeb7T5ksfo66Ft7ncJN9LbwN+heNlE6C4Y6gHmWhXkaaVOPHRx/B/GV
         v3FPrqV47cwXYaZEjC3+M02HcIQWvXVsZhQp5jwTIjWCLqj9D2Z2reS9HUxoiKhRO6yV
         B98g==
X-Gm-Message-State: AOJu0YxjXEWAHOcxlT/PgAbc6FBDt30r+ZOqUVRKlPBfsrD/JmF1fhuO
	isBceRDoE/aJWJqrlwsidsWLNu16osYGT9xsfKWfHUZ5l3Vw+JQwUtQ6cJMWSuLHLtftKbbQyjN
	mKLk=
X-Gm-Gg: ASbGncv7zejRdxfCe//nq0MoCsyhnJduUQ3MGKYdxilgFF7pXuLkyjubojFgUN4xWoQ
	v/XEAAQ9d40gP6SSVcOnTQpcES6Ebno5ZT2f6sKJp1zIIzJCPUtAxCERFQDlNqPc/3Rsht8Y3YU
	zyKnIiuxYCgg9KRrhTjtNzGiH2PZE1QWejVTXNUroxu3C5o8pcVaSxoaPa4YFvZ+hpk2OYCK4Qw
	4utpv4TmO9bk4yKtQgfZwpkkidlWjvqbfxzSx++NtDNj/EbuO1yvDDIO8+GPCyg7Jg=
X-Google-Smtp-Source: AGHT+IEt7WcT7HqU90XVhaXFQ8XErZ+RAyqavnHez97PnVkyuyT5AweC5pn9UqTrk0Layht2T8NPHQ==
X-Received: by 2002:a05:6a00:392a:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-72abdeb7326mr70516356b3a.22.1735876290419;
        Thu, 02 Jan 2025 19:51:30 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.192.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816413sm25127316b3a.38.2025.01.02.19.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 19:51:29 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] ACPI: tables: Use string choice helpers
Date: Fri,  3 Jan 2025 09:21:22 +0530
Message-ID: <20250103035122.50315-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_enabled_disabled string helpers for better readability and to
fix cocci warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202501010947.0e3GVHNa-lkp@intel.com/
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202501010947.0e3GVHNa-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/tables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9e1b01c35070..2295abbecd14 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -56,7 +56,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			    (struct acpi_madt_local_apic *)header;
 			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
 				 p->processor_id, p->id,
-				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->lapic_flags & ACPI_MADT_ENABLED));
 		}
 		break;
 
@@ -66,7 +66,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			    (struct acpi_madt_local_x2apic *)header;
 			pr_debug("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
 				 p->local_apic_id, p->uid,
-				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->lapic_flags & ACPI_MADT_ENABLED));
 		}
 		break;
 
@@ -160,7 +160,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			    (struct acpi_madt_local_sapic *)header;
 			pr_debug("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
 				 p->processor_id, p->id, p->eid,
-				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->lapic_flags & ACPI_MADT_ENABLED));
 		}
 		break;
 
@@ -183,7 +183,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			pr_debug("GICC (acpi_id[0x%04x] address[%llx] MPIDR[0x%llx] %s)\n",
 				 p->uid, p->base_address,
 				 p->arm_mpidr,
-				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_MADT_ENABLED));
 
 		}
 		break;
@@ -218,7 +218,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 
 			pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
 				 p->processor_id, p->core_id,
-				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_MADT_ENABLED));
 		}
 		break;
 
@@ -228,7 +228,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 
 			pr_debug("RISC-V INTC (acpi_uid[0x%04x] hart_id[0x%llx] %s)\n",
 				 p->uid, p->hart_id,
-				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_MADT_ENABLED));
 		}
 		break;
 
-- 
2.43.0


