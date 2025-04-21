Return-Path: <linux-acpi+bounces-13134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCEA95674
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 21:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EFB1895EF7
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B11E9B32;
	Mon, 21 Apr 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6wGfLMY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7813CF9C;
	Mon, 21 Apr 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262314; cv=none; b=FF4u1Ybozj082i1oEDtQ8JEIDL7ArzHPTfy3iBEkhSvKsnXqgVUjblBQ62TaRSVIGcd7DlZFV+juNxFI36IpAM7hqBM2wIz9HKGcqwwDVwXMdriBW4aXV9k0z9gEDrkW8CczyAbQF1g5jTQYXtffEO5sYUHdWV+5C7LR/g+ogfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262314; c=relaxed/simple;
	bh=cEhy27CeZeK5QaxV6IxlodG4p2ysqvsgc8gma+Bn4Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mmu2K4qz0vS51hzTIvWzhpNZw4F8fCU3pPaUf+wVTQGdfbOMUDPMJ1vvaQJ1QO2UJYQ8SyeY0Hs53Cl4dCBCM60vaVoyfaiCyf3mJ7CIgnNPoXW0SNlw3Yu2b7cwLt/sERUdCRxhNjeF2s4sABQ9CesSmIzDO4vHilXUPE8Mvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6wGfLMY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af28bc68846so3723862a12.1;
        Mon, 21 Apr 2025 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745262312; x=1745867112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=egqOJo53kX1P4lbE+VhU9h/iDcziStXYm40YlBK6LPA=;
        b=D6wGfLMY2j7j3lvE/ANA0B47633rwUZWOq9lEEUBQvxsHdQ9R9W9TpSTBgvZeMv3S0
         qedxL31BNZE0UPQBkH1wLIDSM2NHdr0Wd7lexFRNvCM/8a8e3wSmLLUkY6pnwxVWScbT
         zCbtIaI69/L6O9YzjMBHGzhZCl2rMivVKeUerRmtSEUsBO7YzJiaxOQi6q3i2nKMAvhK
         WrGnWiIDvUAnmYC5GuoRB3TNhw8BxsBXsRYsUfmKZSQZ4/knlGKYcJwS5VWQMArnpQ9t
         gA+T1NU8mb+1U7wEokpI8WhzED2g73zAiSdcbixeS6AZ+LWn8OlRgR7rIPFlMA+9cfs0
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745262312; x=1745867112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egqOJo53kX1P4lbE+VhU9h/iDcziStXYm40YlBK6LPA=;
        b=WXbkqV0HS5kI112vNqwngyPS6FK+FkdWZ9GsiFMfX/TY5lutgGYJR67MV61a6VRBph
         1iPpQafLK2LYvtY3um2ptfig1aiKP61hpSDbuqTI9U9lI4twyqtkG1tiimqZzml6YjXl
         7x35VWRXY4su/6f1DIasIqxV7Aic06j4Van4uWIsarqbV/hgaEeI3U8+/foRCYCstU1B
         vWjXs37r/eZmbF+AGF5yOJYRHu+HV0PKzH6DRc+sAVpNNRozAKsdB+dCuKtaYaCbBvo3
         GNmUlzlOD6uIKIThs4+s1hjC3vxi+Q+NUu1UMVqfL6dxOPJcurh84WZdqgoTOQn20WOf
         Xkhw==
X-Forwarded-Encrypted: i=1; AJvYcCU2p09z+NSVwxsxoDG+4cSK2RQlcWBxWavG6WQ53q/w1KKoS4OEnLIwUPKd/T+6/H7CuR92+WBHcdqZ+3UF@vger.kernel.org, AJvYcCXGIdaAIrBzB7dXf+xYYZC//6mkEX8bAPEWbwPvyX4eZpXzMuV22mCcxvJmRUJ2FbSO3bUIxxTK23DJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAUNxUok3fsekB50pD6pA2Y8d5VB3dqdmDkr29zZ41FTDCcIz
	U0Q0/7qwnlJvjc1oe12ZA6D9/LVvPv5UtA7ZPK3h4rwrGJFv9crvBTMpYQSA/RI=
X-Gm-Gg: ASbGncsPPbUJIDK5N60ic9o5LnJWn1F5orqMEHTpvvFOtpOHEd/MBK38d4DH1b87fwM
	f9TDc/xj+GGXUqG3/MNvcPWcNFZv6wmdJvJaTJIBorA4vtv0+wmfnfcy/3X9f372bCWR/CUyXRp
	lqdpFsaLbejDEL5+ToNLDcoxrCL9N30KvvXrfLbqfaB9HAo7xlmm/6NcJWsGPKrN02CvyZG7Yle
	1H/QObpVG8wmvrUrM6f/nnc6o7kA31jPW9bLSIhjjP7jysbQKcrGtdkGqlP/Ih9NYdg3/YaQluv
	R0ZmBWOIo5CPLFHc7Cezw1vtKvfK0hqyKRjGpU7niW/UK+5ZMU499iHzAA==
X-Google-Smtp-Source: AGHT+IG+/gqtX0vOJFK0tshavpdIR3JZHVPcmtJiP25Ax4HJgjZf025N9Kpiub2relValP+7nHvjzw==
X-Received: by 2002:a17:90b:1c0a:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-3087bb39638mr19952075a91.2.1745262312528;
        Mon, 21 Apr 2025 12:05:12 -0700 (PDT)
Received: from acer-Nitro-ANV15-41.. ([61.83.230.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df05153sm7017526a91.11.2025.04.21.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 12:05:12 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: rafael@kernel.org
Cc: "shaikh.kamal" <shaikhkamal2012@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: tables: Remove incorrect __nonstring attribute from table_sigs
Date: Tue, 22 Apr 2025 00:34:43 +0530
Message-ID: <20250421190444.163923-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The table_sigs array is declared as a 2D char array with a fixed size
(ACPI_NAMESEG_SIZE, which is 4). The use of the __nonstring attribute
here is unnecessary and triggers a compiler warning:

  warning: ‘nonstring’ attribute ignored on objects of type ‘const char[][4]’

Since GCC ignores this attribute on such declarations, and it causes
a build failure due to -Werror, remove __nonstring to fix the issue.

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b5205d464a8a..2295abbecd14 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 }
 
 /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
-static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst __nonstring = {
+static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
 	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
 	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
-- 
2.43.0


