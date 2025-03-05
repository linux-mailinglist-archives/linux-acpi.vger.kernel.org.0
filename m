Return-Path: <linux-acpi+bounces-11870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C6A50C45
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E113ACC87
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BFD255222;
	Wed,  5 Mar 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGFmNq+R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB019D06A;
	Wed,  5 Mar 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205524; cv=none; b=h/JO84GA8sfY4FS0IK98aCmT4yEvba3BwUhgTb+pqh7/uTjujOAnmYtU9oiiT3gi/Z0LdzOmA6+B+AKQoGRkUH1xQkYUyHt2qo1cKnAAaI4gWaFuj4ENaZ+1Mdb/Klh2nQUv0bsc6V4x7KebnSKGnFCeYvUj6EjvbrgVIFg2CTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205524; c=relaxed/simple;
	bh=xxlaja1M5ZzvELQDVXtt0CFRedwIrI6HNEgqbSGwixk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSA7e9J+aKFTdbJGt9nFk4HqBD0qzekSEWJaIPN6ybB2J4wGt2yJbwGtRkXnEwRk/+xc59iLjmNGRd9/JPNT+1Yequ6d/ayqlL/5pG4cEu9ERa407M+HaCJR49Bxp2oRyBzomob1KywgLTEZb0W0dloIR8o7nMhbnp5X96HauEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGFmNq+R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so15226135e9.3;
        Wed, 05 Mar 2025 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741205521; x=1741810321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brW+pYPJwmA8bUp4jZVsRkg/nzzvoeD/T7yxjePWcwo=;
        b=HGFmNq+Ra+YAldY+WqJSnpLrdrkNkAcT91Tf5PxPU0yC1YtvHNMZskaXcerPGwn2+o
         VqiGZ0bwmbjEk3Z2RB/lhMdvdsVRyirADI8w+9DQnaUuGMarnSCBJ77Um7Y/5RRojjZT
         C4Kb9tC2lC5mehJEo9NfToiI+sp8S8/XWmj+I2hcM7EJeSlrGKb5eFsBOgwMZn9McRpT
         EIWHU6SKEmNEQUmffE7HcMhUV5bwxcP7ACvW+C5LtNvl5faasJrhrfDDeGId5DnjUbbn
         s625HhSihb1wiNQulFSYebszr3hEGC18p0AXrM3P8wCPLo/TdLzFiX6QHXqNXeK8OLcl
         MqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205521; x=1741810321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brW+pYPJwmA8bUp4jZVsRkg/nzzvoeD/T7yxjePWcwo=;
        b=jhCZKMbrSjznaEHZQWf/AtqhEumTM4CpoYUK+uyLlniC9phyjHsvxc09ZEH2mweoyk
         m1On3331F5MkDHi3Ix3CAFRM5Hwtct5WQTapw15p9EoW6PiDiPw7SLuF7ag0BzUNWcMQ
         Dmqt+ke6g36lsBBZ2eIcPFEKBciLS6+nfxITnw3A0FeBUzQO3+33tEnD3tSDJISrTvIQ
         lf/b+6TFPV/AZ8g161ogFs3LAfXEYGfEnDkTrX6w99bRqGI6NlYbtgqCidGhsMjINrTq
         SFT1dMOOaTvJAbWXy/JF16/3ZMWjooy4lo8YZeKzy1pcrhcgQ8D0wu2vI/l/8DcFxABG
         jSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcY3/cUWDicVviuLiZJoiNMcEtTijqF3W6TLZPZRfZIcl21nF6OJiANKvNbk2orhoY+8IwGtsKg0NsCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeMvImzoL4oKiwUXwhcr62vZ1n16s++AAJv5+R6XAPfp4YLHv
	H93CIybUqzmOtTO8bJh0dnbMw+PV0a93o82ZaXO8LKwJcSHVyRqakOKG2MDt
X-Gm-Gg: ASbGncvn19QsQUggWTjjjs4+KSiXUlcCjui0seb2GmkbxH1I2ll6L3QtshEPIAU9U0c
	A8XBU8X0sp7iDTWL11xB/1JRRU1jw0E65GJ/cb8tlDFDWyNzkiUDd6Y+fojlIYu1GsgNmnjzgmP
	z1WtfgJEEvzhPlLqlXhpCq5Pnn/XklzOdZFdzD5+xSpaR4YKm5jY3A45jycXPkcgJyR6v+MxXn6
	oh6SpNnVLsCJn0JRIvTCM90S4m6vFSk/duzfY08NV5/Ej5jBGVZPwnIiAvLsOmugHK9T7IMJ03d
	VYH8FU9NuX2M1Wpe8J3tJtcPI6xA54znDvlyZi60O01pGxA=
X-Google-Smtp-Source: AGHT+IHHSlhkTQg0bA8WTfh3FL+5l2gFszvj8/9uJnqxNv7fFJD7FqP9JeC/cix2kc24r83fx6bhTQ==
X-Received: by 2002:a05:600c:4f51:b0:439:92ca:f01b with SMTP id 5b1f17b1804b1-43bd29bb5f2mr31670395e9.13.1741205520566;
        Wed, 05 Mar 2025 12:12:00 -0800 (PST)
Received: from localhost ([2a00:a041:e509:7500:3a4a:9c50:c5b2:c109])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd42e402bsm27052915e9.25.2025.03.05.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:11:59 -0800 (PST)
From: Or Avni <oravni8899@gmail.com>
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Or Avni <oravni8899@gmail.com>
Subject: [PATCH] Staging: pnp: interface: fixed a pointer coding style issue
Date: Thu,  6 Mar 2025 00:11:55 +0200
Message-ID: <20250305221155.35981-1-oravni8899@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a pointer's declaration coding style issue.

Signed-off-by: Or Avni <oravni8899@gmail.com>
---
 drivers/pnp/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 44efcdb87e6f..5148c431ac0c 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -186,7 +186,7 @@ static void pnp_print_mem(pnp_info_buffer_t * buffer, char *space,
 	pnp_printf(buffer, ", %s\n", s);
 }
 
-static void pnp_print_option(pnp_info_buffer_t * buffer, char *space,
+static void pnp_print_option(pnp_info_buffer_t *buffer, char *space,
 			     struct pnp_option *option)
 {
 	switch (option->type) {
-- 
2.48.1


