Return-Path: <linux-acpi+bounces-5444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E38B4D0D
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Apr 2024 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E312812F8
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Apr 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7773163;
	Sun, 28 Apr 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b="FkesS8EX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11215433DA
	for <linux-acpi@vger.kernel.org>; Sun, 28 Apr 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324255; cv=none; b=hRFK+efyAfTGL6l6lVzXmRY8DuNHHL6ZUgpm3NVGhK8Ph37AdrpQuTPKG/rDYzj1XoyVtbVf91jniM7ZRxFrWnuKkBFUKiMwzF7+bjfzae2fA6pn9krw+YgLFOp/8FKDCPBTV00X4qFlNOMmLEpEsqShOfWuvjuUJB1JfgNosy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324255; c=relaxed/simple;
	bh=99jae5MDfVghTRZvjzK/Jonss0r8KwPZ3NYO+iRDuuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgYrEA5wVjPXFtdz4jnAFJyNwq+5wswTAEIO7yO4mWFYKs4L4AbImB8lu4BesfE3+i9fRUI2OWJF8M6kvR8oywj7UnWZC56g75Nm6xYXxTw+lJ8FerrU2HVEnd7WCUyxXN5IeNeeVTW1Wnjc1E9psPLeRtOy1iRag+MdGDOBbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com; spf=pass smtp.mailfrom=fusetak.com; dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b=FkesS8EX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fusetak.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c74b643aebso2266308b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 28 Apr 2024 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google; t=1714324253; x=1714929053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojsnHD0izPc70zn6XGsr26jNlBmYXwCV6KDnNT4uY0w=;
        b=FkesS8EXh0YnOxWHPpSwAKXUFukfeFflXa9A06X1TJYT2Jy0rOlOYYuNNyA6uaXVdU
         k/i9YG51kEvx5xL7q1wOF/aRl75enIrp6HERPobdE/EU2iSJSYXWClVTC8wQYbnDy8WM
         KGv23YMaCnNUbhhhSSJ0LWBubUs4ZrPi9iU9qV4xobnisLfD76SJPvU/D85O9GdkAmmc
         elkA3+Kobq4vJ22QI406u8SuvfsTtclU20Ut8WZNXpMDN8J6lqTM+wJ24G5c809pe1AT
         LNQFPppePA1isY/+VCLUi9NLQlQvL6My7bmJtKf45fsypuI0PJBeQVNp7thaRPy6SYQD
         0KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714324253; x=1714929053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojsnHD0izPc70zn6XGsr26jNlBmYXwCV6KDnNT4uY0w=;
        b=ucp2ZZDf3jAzy6V76TMJZLfdGft54RMBVystOeAlhKW+5IuvPwuZp+WnvKHIDFYaIZ
         NJz8SN5VHVvtJOa6VKhIZYHeuIn2PKEJMWxetbUMoJ9XRnTc7OeOfPzvXObC3u2r2mGf
         xEMn4BavOrCMtfpKY01hOmYH+00j1DWPYxepSoMHaBnNyyee9nQwv5NrYhTT86wkEF8Q
         sqGeW6Tygil5E3rKIghoi9LiRO9dRicD7+uFSGxneqkslqIFaZGgHWhQBhypC0j3qlFm
         LJNLASOrgWWHxxHo3zPPIJftNnwW8zFRJr1U0fTr8f3GBC45ApBF+PJGALBAzCaLGI6Q
         AIpQ==
X-Gm-Message-State: AOJu0YxXH2A/AvnA40aQpCTfO/M4nNo4NxAP3Ws8tf49ez+nsuwXO+2L
	bRad2IYWF/V5Mw1KS45+D+ef9zQWKIV1ssKofebr0XSe3rjmMfl/6OnuI3TLT9w0CEvu9UIjYaa
	R5v8=
X-Google-Smtp-Source: AGHT+IEXMT/WVPGJf9cvvE1S/FmEbGwTSu9CQ++2ZN6kLCWY1Scp1NhiqltysBlc3lKxsrLgOxzTrw==
X-Received: by 2002:a05:6808:2748:b0:3c8:37b7:4a8b with SMTP id eh8-20020a056808274800b003c837b74a8bmr8931680oib.7.1714324252882;
        Sun, 28 Apr 2024 10:10:52 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net ([2607:fea8:4d9f:ec87::130c])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cc504000000b0069b5e92350bsm8699887qvi.96.2024.04.28.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:10:52 -0700 (PDT)
From: Tamim Khan <tamim@fusetak.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	Tamim Khan <tamim@fusetak.com>,
	Gianni <gianni.casagrande.mail@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV
Date: Sun, 28 Apr 2024 13:08:12 -0400
Message-ID: <20240428170841.487584-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like various other Asus Vivobook and Expertbook laptops, the Asus
Vivobook Pro N6506MV has a DSDT table that describes IRQ 1 as ActiveLow
while the kernel is overriding it to Edge_High. This prevents the internal
keyboard from working. This patch prevents this issue by adding this laptop
to the override table that prevents the kernel from overriding this IRQ

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218745
Tested-by: Gianni <gianni.casagrande.mail@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d0f2..23d6f5d4206f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -517,6 +517,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MV */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.44.0


