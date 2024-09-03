Return-Path: <linux-acpi+bounces-8093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182E969109
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 03:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986F91F21503
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0631CCED4;
	Tue,  3 Sep 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b="IhJyCF6I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5761CCECD
	for <linux-acpi@vger.kernel.org>; Tue,  3 Sep 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327836; cv=none; b=s0ngUc+ZOn8jguC66LQRseb5nbkgW0Ny7ODgW9Iz274WNG3AdguZLkI0Cct3IS/qi0q//ALdyGWAUyiuY9tFucY9fDtAoFLfpF/mv2c0rn4LEwDbcMKkYXvq8EofmB9jpoSA857YL+lArzasi93l3vC9eXIl+7P7fSaP0bWolTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327836; c=relaxed/simple;
	bh=EXxyBaYrjiPuaWzTNCgRQZsdNp2cmaeehbRr192MBDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS8jzlN99mvdNjAqqTEq65Wgj+AVRk/p60Z2rVGHAGw20skQilFNz3FXZ32ik0w0weYqH2XjwQVc0PludPCngb/Cv4up9sechpIolmxJcdF5XLyDw3RysRjw4uyLAUM4sJUlPFhuRfjkDgrQwZUx5kb5aecl+EEjf0kCxx45q3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com; spf=pass smtp.mailfrom=fusetak.com; dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b=IhJyCF6I; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fusetak.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-457d46ea04dso7930861cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Sep 2024 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google; t=1725327834; x=1725932634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vArw/0vO/h4vvh+0tXaEtMMFDMzEmoPNT+12If5OX7c=;
        b=IhJyCF6ID3+s2WdjWJDigUWkvl3lRKCAYlGYS+kskh5LQBy1+cGoK6Ejdok96PZE3+
         PLqkm4DoPIvkXE9bxvKWyI67FYnf6JHMhFEUyTTf5B9puaLuibDHF+YVNpjc8feP3i2Z
         UPq3uxYmXxPv5hpb8efjuW2QzZ/WQvAQfNKE0LfjId+UVWT/UKMd3wCvrK2Y3RaTHNX7
         j0jdt6/X948nDvKO9CNM8vPKu0xl+bHwz389A92HMWubY6ZufESnzmEpJbSjVdq8+nZb
         vVb4cUY7OqC2oV+jaNEy/vfkNDM0WHpBV29OGeP0+BJ5463qxz5Mz80ORCV3lcGgKi8f
         1NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327834; x=1725932634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vArw/0vO/h4vvh+0tXaEtMMFDMzEmoPNT+12If5OX7c=;
        b=Bn4KMsTE3uS7kqgo2Dd/9wup2a5j4He6T3mYIpdH01OlVP2AC9HodAmkLQoBzsrN0+
         2dkoHYB0ix6zkWcm3/076da5uNTrwR6DP4YWGwJR/zdk4GmMnuwv9Cy60Nai3Elam7w0
         Fcb4TcGXSZQPyLqt2rFfazLS3Pg00fWwShOetjZG519+uevCgEeXX5g8KbdFd+aGKQeC
         wi5V0xQboOIM5JGgBPENNsJlklLsZE+TjEsyd2okiTqhzqwkSh4TPS9LFCmE5b+A6kWi
         0n0j1up5kcQYZhPmh10Jzb5O7tQa7jwzKJCy8mqlWNM1mvBgw45TzSozX/QjmlymWlJo
         3KCg==
X-Gm-Message-State: AOJu0YxdgoVTTWYGRWpY3ipSBcwhklawBYr8KytWzzTCsHdG+Zn2fNFt
	aPRmCplfaVTPk3h7CDtOmH42yvsHdFtjM7DtF4TV+o+CCJs3Mk2pkfQUwsKurR9UZ2L8pXPZUML
	8ziU=
X-Google-Smtp-Source: AGHT+IH9PuhmiGtgMPk0l+p+gFO0qmpWxYscGgE/3EgT0ta8/tfppKkkQmxUhS28X0olKCQcm5w+eA==
X-Received: by 2002:a05:622a:4249:b0:451:d734:eaf4 with SMTP id d75a77b69052e-4570545433emr154280461cf.10.1725327833695;
        Mon, 02 Sep 2024 18:43:53 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net ([2607:fea8:4d9f:ec87::105f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66e0bsm45126621cf.75.2024.09.02.18.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:43:53 -0700 (PDT)
From: Tamim Khan <tamim@fusetak.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	Tamim Khan <tamim@fusetak.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB
Date: Mon,  2 Sep 2024 21:43:05 -0400
Message-ID: <20240903014317.38858-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
This override prevents the internal keyboard from working. This patch fixes
this problem by adding this laptop to the table that prevents the kernel from
overriding the IRQ.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index df5d5a554b38..c65c72c515e6 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
 		},
 	},
+	{
+		/* Asus Vivobook Go E1404GAB */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.46.0


