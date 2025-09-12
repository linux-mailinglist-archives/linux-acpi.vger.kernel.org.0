Return-Path: <linux-acpi+bounces-16776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A5B5576A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEBD1769F3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF450343D7C;
	Fri, 12 Sep 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOjhl88T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB1343208;
	Fri, 12 Sep 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707616; cv=none; b=fhUa4RRO2cMXmIE+1W8aCN92G7+3OGwmWz1gutIZelcL11tB1kvb/acUJE1LQiE1gZFMFTUm3LiQH8A51PW+hOLO9z98xDlM7Ue/euSVT/zao68dXCyb8k1lKB1rm7KmdfbEwQ+WgH2ps/Qr16YwGL1tHmcEgqaF41ZnsR0gQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707616; c=relaxed/simple;
	bh=pmUixoYqwoTGOsZN5cx+CeQbnHRaxAm1Gp9WvnXVmwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNscvBXY7kdArsH9fuF14QXQNbEx/krZHUcfEbexjfLF/8Tx9f7R6NhuvQTUtfCM3u5RKE0aL5oWdsRRpLdfXhxxORL3l0Znjhe2TRQ7b4D1nPImNxsQ5uWz+IgHMJ2EHmmBNv9U7VaBkonRIS0wqSna7yimezXD8cvw8Q6ER9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOjhl88T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96534C4CEF8;
	Fri, 12 Sep 2025 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707616;
	bh=pmUixoYqwoTGOsZN5cx+CeQbnHRaxAm1Gp9WvnXVmwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOjhl88Twv30XAVt2AQbSKLZKGJnoG/p3KVSaKozkkMEnY3rHZXi0bmYOgTual0Ne
	 8ZjdWJcAFfiMTDp4xjQlbFFkNCy02U2CPUULKvdSm0oefFb+zFUSFEiqjie2JOIbhb
	 4A41a/atFKoJlpyGkmd7eD+fk7vUSEkyGUNZUGp/21dUgSikWUtcbi9boDPA0KzE7E
	 ub4zO1yTXvuuvcr3eyst32O+sNX4gM4dSZAZvSNmjInqCjZxWtOInOC6FNABQhYF4D
	 9bUS3KDo1CeUQcO5H+jc1B2UaMrrLb25nz4e1RmsSiQuhlhdVxOJJfJW+Do1otQiKa
	 gjHThEohE2tfQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 04/16] ACPICA: Allow to skip Global Lock initialization
Date: Fri, 12 Sep 2025 21:54:53 +0200
Message-ID: <1843108.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Huacai Chen <chenhuacai@loongson.cn>

Introduce acpi_gbl_use_global_lock, which allows to skip the Global Lock
initialization. This is useful for systems without Global Lock (such as
loong_arch), so as to avoid error messages during boot phase:

 ACPI Error: Could not enable global_lock event (20240827/evxfevnt-182)
 ACPI Error: No response from Global Lock hardware, disabling lock (20240827/evglock-59)

Link: https://github.com/acpica/acpica/commit/463cb0fe
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evglock.c | 4 ++++
 include/acpi/acpixf.h         | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index fa3e0d00d1ca..df2a4ab0e0da 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -42,6 +42,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	if (!acpi_gbl_use_global_lock) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Attempt installation of the global lock handler */
 
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b49396aa4058..97c25ae8a36e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -213,6 +213,12 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
  */
 ACPI_INIT_GLOBAL(u8, acpi_gbl_reduced_hardware, FALSE);
 
+/*
+ * ACPI Global Lock is mainly used for systems with SMM, so no-SMM systems
+ * (such as loong_arch) may not have and not use Global Lock.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_use_global_lock, TRUE);
+
 /*
  * Maximum timeout for While() loop iterations before forced method abort.
  * This mechanism is intended to prevent infinite loops during interpreter
-- 
2.51.0





