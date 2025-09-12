Return-Path: <linux-acpi+bounces-16767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCCEB55767
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E5B7B07AB
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32212DECCD;
	Fri, 12 Sep 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/o/L7NH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899572BE037;
	Fri, 12 Sep 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707588; cv=none; b=qAURSC19bkkYl9EeBJ+YVTpuSMaDJc+Ea2/aX66d9UO06ekxzAlAs6FHQ1Vcx3MCQEw97de5AIaOk5nrAwyX2rlGifMKjVoLd/ZQix8qpHo4Wjp+3OKlff5C+vKsHjpQsWD7OIY8pJF9pIQnStgLdVhjLaRWEqObtAnMNqTf1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707588; c=relaxed/simple;
	bh=vvdT75Ms03lq3XoN4qb2LKrHWT20aQC603yF15w9RkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBDzMFzohqod2KnKV3U2k5mRuncQ5CWt0oScXZGbKACogl5spCK3rWKNlYQDq7jgFx1wZdGuD/37/JCUUweR4lC7aj1dt9IAmoSTVw8YxJsiccQBA8iZAoGB3KKYQI87ueMZKBXfZIsiV/Oz0wHPSNX7lDC2hfoKa7QafB3KT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/o/L7NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6020CC4CEF1;
	Fri, 12 Sep 2025 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707588;
	bh=vvdT75Ms03lq3XoN4qb2LKrHWT20aQC603yF15w9RkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/o/L7NHxUQ8KW78A5iP++PhtzSIJVIN+VSZhnkPvryc8mrCbhMxP31xYqxYm+v3z
	 pZvyS4r9B83in/MrNHEmPl6dbpZSajatiCS7zpWasdZjSlsm7wjCEvDtjOaMMGW9+X
	 VmYOz8O0srNDcqtIE27SiTZDHc08GXi9fHgCE21zWHjspixPbZvSH4uMCEvdYZV6ka
	 twAN5opogKQRMbktiqXv5xIq2h5bI2f9NL4NbTxhXedWo3nFI6Kzp8PayDDvwXuj1Z
	 SxXzQG3Rl7PpV4Psu+puLntKV/KcnCEdt2kOxwOwLWFlHn1URmDXpNg6awIm5E0SSm
	 hfcYHprrqQFMw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 13/16] ACPICA: Fix largest possible resource descriptor index
Date: Fri, 12 Sep 2025 22:03:16 +0200
Message-ID: <878863953.0ifERbkFSE@rafael.j.wysocki>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

ACPI_RESOURCE_NAME_LARGE_MAX should be equal to the last actually
used resource descriptor index (ACPI_RESOURCE_NAME_CLOCK_INPUT).

Otherwise 'resource_index' in 'acpi_ut_validate_resource()' may be
clamped incorrectly and resulting value may issue an out-of-bounds
access for 'acpi_gbl_resource_types' array. Compile tested only.

Fixes: 520d4a0ee5b6 ("ACPICA: add support for ClockInput resource (v6.5)")
Link: https://github.com/acpica/acpica/commit/cf00116c
Link: https://marc.info/?l=linux-acpi&m=175449676131260&w=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0c41f0097e8d..f98640086f4e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1141,7 +1141,7 @@ struct acpi_port_info {
 #define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
 #define ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG     0x92
 #define ACPI_RESOURCE_NAME_CLOCK_INPUT          0x93
-#define ACPI_RESOURCE_NAME_LARGE_MAX            0x94
+#define ACPI_RESOURCE_NAME_LARGE_MAX            0x93
 
 /*****************************************************************************
  *
-- 
2.51.0





