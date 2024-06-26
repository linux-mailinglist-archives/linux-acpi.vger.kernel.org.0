Return-Path: <linux-acpi+bounces-6627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79829181FF
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2FEB24F34
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E5187560;
	Wed, 26 Jun 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0QhM9gF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673B181CE5
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407397; cv=none; b=nB3PAbUOyOJtZAVJjIRUQf+dk5BiYnymeSLsGchQ/HsB3Vz7UXB6b0fmgCGSX2di/xQDYx0ieUODgVi3HqYVECfAr/jERPSg/cy813wa1jqbrJgAqK1ViZUOxV7ikIl9NQ9iHmSqP60OpK/1W1v70ZuJ5HJevwdEtuqBNBNgaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407397; c=relaxed/simple;
	bh=6uEUSzsEeuVF0miA570LIvND7sHCNQamL19d+U+SUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bzd9ccFWxa36Z4kwOv4K7ywvIygtDXZHfbihakT4IEh1xKybxZwacw4W/3/tLOLwMghZdZU7n4HZSQFOwK6Ym+4A66SUqFak2FlRLvo3OSrTanXABjH/txM/EdN2p5/K2jDnm6AV5g2C2h+4CsrQkXCOCuPwF4kSNRLyHnfbDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0QhM9gF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa244db0b2so30840985ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407395; x=1720012195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGbxhcxxd8H/oj9TqR8ht0XnwzieNM2edhuYRxERoPM=;
        b=Q0QhM9gFIGDzhKK03leRcfixNDEPJSAAHIJ994WFTrmcaUQfhhqpAFZg778mZDXwLA
         7ZOPVnc0fYxXEHVn1/qJ8uunedt6SH4SlAxuM++dh3yF6nr2wNgqe74puz/RuEDMso5x
         hg5gKQVWq6fz3jgh0qZ9VcSFSuZ4OHSJfJDtDkJlqZCDO1NAtly/Pt1tRuVUgEpvsAzx
         dS0iWWl12ucZtRuavUfFBaZAhc9dGKD3V/4vQNTL+oeaJvMOeASpqQ5zfdouB+SXGCIp
         +aGrSzF1Xizg0WFpyK4uuq7LTKJTuSuwPoRqisT+vUccpsvuGrLC4Nh71uFN664xN2vY
         onnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407395; x=1720012195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGbxhcxxd8H/oj9TqR8ht0XnwzieNM2edhuYRxERoPM=;
        b=pkIrDPNeGXkWQWiIcHD6sjSSfk7DBOSMhMDrvUuZfwFjVlRmVFYTec+ooUHBlFLZpL
         nXCCREADGFKfWXZZFEOJdav57sjqKcdd2BxvXLLeYGlOfqhdrS6A2ceZCwkhIGhXihyz
         PbVwbfbC4ifuDlAAbPY57tgtDzPjzwQBncbdJCqLEq15z9hnbqat+BQ/VdkStA9EE7h0
         5HgirFH6CvAaPoadL/z3UkHUHex6Oif6F1bacMbh2xPCqxtmn7k+wZtJWTY7m9U1zFPk
         qDvJ6tjDo+8Z9PmvXn2Fds0/SnhbVndERLEFxo3xdJ0jbH8NSzMWkquqkssFRClxuRa0
         Fggw==
X-Gm-Message-State: AOJu0Yx1Yem8zs7EQTi2uFhOmrShIKqC90LN28wvz56j0SDetvW5rRbo
	n9sHdYJ344j7luniYf245K1a5EwXf4PtAQhXoecpdKTTIuCJOnTBENk26w==
X-Google-Smtp-Source: AGHT+IE8+fguFK5237LYgWs7mE+FvBC5TbSMqunC49lRZ/4nPBDzS30WcxWC1QAPjKpa5JlPkMILrQ==
X-Received: by 2002:a17:902:da86:b0:1f9:d817:1fb0 with SMTP id d9443c01a7336-1fa158d0809mr118849885ad.14.1719407395324;
        Wed, 26 Jun 2024 06:09:55 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb3f1esm99049695ad.265.2024.06.26.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:09:55 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH v2 1/2] ACPI: CPPC: Replace ternary operator with max() in cppc_find_dmi_mhz
Date: Wed, 26 Jun 2024 09:09:40 -0400
Message-ID: <20240626130941.1527127-2-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com>
References: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..a2591e1677f5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1837,7 +1837,7 @@ static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
 		u16 val = (u16)get_unaligned((const u16 *)
 				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
-		*mhz = val > *mhz ? val : *mhz;
+		*mhz = umax(val, *mhz);
 	}
 }
 
-- 
2.45.2


