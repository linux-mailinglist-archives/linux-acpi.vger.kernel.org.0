Return-Path: <linux-acpi+bounces-465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E277BBA61
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A178128225A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE126E04
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxuu05QZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A31F615;
	Fri,  6 Oct 2023 12:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED31BC43395;
	Fri,  6 Oct 2023 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696597190;
	bh=1a0WYm/JOuoSloUtHO8rcUYP3nlPMtWwDXeoC9j17ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cxuu05QZS2zUIu3FMQpOk4GTxl5etLU3bdmcRa3X9ASqNJV8AQNtb+4cuNWzOCliJ
	 J2kW9cevvgvHxvm2JEB1uR6HDj9cA+D79ZTTMcgylFpaflS9XKt6xPHUksQQphUpP0
	 YeHTCWvV3aju5DnJZ2jNvxYEYgOaD2jdZ9W+3V2X/HAD7oPblNqmPPCb7BGc2Nq2u4
	 ba7IrcEIp9aWoA5984O5Nc/ztL1bY609fWg0t+ncvT2vx/dDSQSxyw8E4xW0A3me35
	 U1zkddfi/3nPuZ/8AKxXknVUuYFpbKzZwt3shyb3JEomgv03yPXktZQ5NywNA5Ef9H
	 vmENa5OnxIeIg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 4/5] ACPICA: Add new MADT GICC/GICR/ITS flags handling [code first]
Date: Fri,  6 Oct 2023 14:59:28 +0200
Message-Id: <20231006125929.48591-5-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new flags and related fields to the MADT GICC/GICR/ITS
structures according to the code first ECR:

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

Temporary code waiting for ECR approval, for testing
purpose only - eventually ACPICA changes will trickle
into the kernel from the ACPICA project repos.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 include/acpi/actbl2.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..dd44915efd6b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_NON_COHERENT     (1<<4)  /* 04: GIC redistributor is not coherent */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
@@ -1090,21 +1091,27 @@ struct acpi_madt_generic_msi_frame {
 
 struct acpi_madt_generic_redistributor {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* reserved - must be zero */
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
 	u64 base_address;
 	u32 length;
 };
 
+#define ACPI_MADT_GICR_NON_COHERENT   (1)
+
 /* 15: Generic Translator (ACPI 6.0) */
 
 struct acpi_madt_generic_translator {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* reserved - must be zero */
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
 	u32 translation_id;
 	u64 base_address;
 	u32 reserved2;
 };
 
+#define ACPI_MADT_ITS_NON_COHERENT   (1)
+
 /* 16: Multiprocessor wakeup (ACPI 6.4) */
 
 struct acpi_madt_multiproc_wakeup {
-- 
2.34.1


