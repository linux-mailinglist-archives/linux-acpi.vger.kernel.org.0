Return-Path: <linux-acpi+bounces-7264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7301946EB4
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AE8B210A9
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D64D8DF;
	Sun,  4 Aug 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htybqFKm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7F48CE0;
	Sun,  4 Aug 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774870; cv=none; b=uEsiYlBzZc8y4ER8CnZ/T1JQSUwdfPeSinF+w4s7d0VbaB6wfgpWI7aM4PJmJI7xILPSto0rK/0xQA7wX9I8GwwpCRk0g4BLWovqnOCNNne66vzxyYC39xuvEvHe4ndI7JxLkqWToi05Hlf7XhdBwKb/rW8RugYAchPUVfsPucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774870; c=relaxed/simple;
	bh=Zqu6IN3uMtGrOXHt38sgoQIzQsR4MLchASujTxmZM1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N86HVmQ8CUA+vk1H5VnBmy4bYlbWUTntfPlOPIg+zU6K/oWOVCcpwBeUbO3kOGF0uFU800rGHmFYiYIoOFGcxFt7DZ+hLhCU1qBmfdKQ3tg0NaQN5eB5Mfn6UbVgi2AcK5Y67Lu0gDrDbJOq+LhBmPryewogT9Md4WAAF7Qldig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htybqFKm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f025b94e07so121804131fa.0;
        Sun, 04 Aug 2024 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774867; x=1723379667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcOqHeXbaXwSJzQv6OvP4E1IqsOv4RTjOEMViMUcM4E=;
        b=htybqFKm6kIDwXqcf9OR4JMokv1h9vRKDtkvCisnq5WwjxuCgp4Jo3wbskfg1JH8rx
         5Z2pIGuAIPj38HFD+uMPqJSepXMJiSVekC66/Rucaq+6Q1Vux6ZNpXhIi4405COU9XaG
         qW5nSnYFQ4NCU76PtPwc200XiTuzJ5M6HGo0BXN/XTIlDQDBRmdgpIjKwM5tYILJ8NRN
         Z6hpuxPn+PQh/kY69kf1jKLWsACdyF/eHMpHYmSyJfpk6oXGG3eTnzgy6bbxDq5KCXxi
         egUKq5QRQ3m78y54hfNV5KNddjC6VDdO6LoEWjMOED/fITWVIa4Kdk4E+Kydr+FF2qRV
         dy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774867; x=1723379667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcOqHeXbaXwSJzQv6OvP4E1IqsOv4RTjOEMViMUcM4E=;
        b=jdwlAODYS7OLUg+jtCDP0NLx2w/ZLNyYLDrkoU/IUJwat3uTFdJbaStUgFsyCAx+Py
         9O5ZEMVd2HKhTF/7SHO5oNS/rmNjg60f/i1HMhcuVHzihcoCti2G/IfgkWHYMbSSjbro
         OqYHBJ+FJ0Jaofw5eGZOqLdBUKqmrlsssOBHNrs+PQXCvD+mMdzpExV9WxvY0IddObBq
         2iH2l+GW3BQAbastQP4jvOpEyuLmDSeJowLZTIky33tiIA5wi7xErxOKPV6SakL7d6Hu
         UwQmSe2OpiGP5poGB2Hf6CP4YD46Jz3roW4Jb12LL+G7WsvID+oxE4fk85dxvoRCNBy1
         9BXA==
X-Forwarded-Encrypted: i=1; AJvYcCWpWf6tZpcuIEGvCfS7+N04uuqq4ytDEhHASe85+y+4G1U8Rh3MtPtLiW4W9v4zq4lugzannimm7ELMnJQDKf/yvmawCS5gWX8P6XFnssCJd0KlddwfpBjr8N29QfbrUsFBbOqkWApBNw==
X-Gm-Message-State: AOJu0YxZYGw7+5P1YhhyyLA5op+Lx5pZvqb40S3wMMPr+7gtaWw1JB2r
	vo7NDmAhjA/sN91yckfrhuUKPWDY812FRaCnKLgPgJUOZmck3k0r
X-Google-Smtp-Source: AGHT+IHLzciFjdyduAWE/0WOIXimmZVuerYCXVbtqRo/hW/vpwW76RfH4CTO1DiUPdjbohR+Qs1y9g==
X-Received: by 2002:a2e:9d47:0:b0:2ef:2c62:f058 with SMTP id 38308e7fff4ca-2f15ab03fd7mr58788201fa.39.1722774866941;
        Sun, 04 Aug 2024 05:34:26 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:26 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 6/6] ACPI: bus: Define and use a macro for device and class name length.
Date: Sun,  4 Aug 2024 17:33:13 +0500
Message-Id: <20240804123313.16211-6-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804123313.16211-1-qasim.majeed20@gmail.com>
References: <20240804123313.16211-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 include/acpi/acpi_bus.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..74ed1170fe66 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -226,11 +226,12 @@ struct acpi_device_dir {
 #define acpi_device_dir(d)	((d)->dir.entry)
 
 /* Plug and Play */
-
+#define MAX_ACPI_DEVICE_NAME_LEN	40
+#define MAX_ACPI_CLASS_NAME_LEN		20
 typedef char acpi_bus_id[8];
 typedef u64 acpi_bus_address;
-typedef char acpi_device_name[40];
-typedef char acpi_device_class[20];
+typedef char acpi_device_name[MAX_ACPI_DEVICE_NAME_LEN];
+typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
 
 struct acpi_hardware_id {
 	struct list_head list;
-- 
2.34.1


