Return-Path: <linux-acpi+bounces-2697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520982319A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 17:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1EC1F20FB8
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A91BDE7;
	Wed,  3 Jan 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYaCBn9e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0F1C281
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbe1560c5b0so727012276.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300919; x=1704905719; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwnkabEmCOp/hY21qtO6ioiemRhGbRPJNwfgWicqTY4=;
        b=bYaCBn9e8KK+P1Tk4OQZSjUN9N1GXlkYkzaJoQbxRpfjHvlJu5z/Anr15nMWcAjbLB
         H59Cror1KF7z4uT4gohgGvI+mOCF37wW01oUN3QgM+9kf17ItlAvEUZVEIiYFCeenS1I
         cUJNW4r8DC7u0YKe6mX0Op06RDPhd6ReZpv1GVIFnuKWr0nORP2688urT0irst55wF9j
         c0PQp32Py9aviGlIKK8QBAmzqFdTcS7uES3ZbSc6Lbi+AMyfw/igxmx0idC+uBirRm+X
         I+0U6s+6TJMBxe5eYUjgwWtI3DVdz52ZyMXFoXMAgIWzJEoY1R0wTs6xGap0SWLssBzG
         7uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300919; x=1704905719;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwnkabEmCOp/hY21qtO6ioiemRhGbRPJNwfgWicqTY4=;
        b=VhodK9HxVBOP3GocoRXBjeiU3+qsMrScrXI8dj0/Ow5f1YkwEtjJwBAxCGu9z32SrK
         DfKS8J1LsB+mgRVZDHZicCR0QUOIYnP0Q3bhpDH7T6FJcN79N2frI5n40/KoJy/oqfOk
         heeNXFigav6gpKy3F7qKLntWZYYkziW1H56xDP+2xDZnfjhbMEG4B5Q8ZoguiaKFhhcl
         SnSW841GFUAGFWqsNqoY5qF7iQyhaRmR7rZuG0FdwzTgghFdArOjycJ81LrAZ89n0jiM
         xTMsO08rhk4Qp6RoHLt4CrD7ZEUr17bAOKG0FQShifgMCg8ZYHpyZXtcA/U370IV12nK
         76hA==
X-Gm-Message-State: AOJu0YwXEwNZApWf2l5Xpra0Gdmkf8xCjIlKjmKUooT5Q1f/XeoGqZ16
	UWqgEzlelG/LARZkY66hmao5sEcHZs/EkQ==
X-Google-Smtp-Source: AGHT+IHRkIGWOw4G8VvBQXqqbuY226ZNfqsa0ssbiUD9Bs0hKqVJz4w1cq4qj8hFmlMjfYbgqQOdWw==
X-Received: by 2002:a25:c3c1:0:b0:dbd:45b3:bc9f with SMTP id t184-20020a25c3c1000000b00dbd45b3bc9fmr16064846ybf.1.1704300919573;
        Wed, 03 Jan 2024 08:55:19 -0800 (PST)
Received: from davidm-laptop (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id po5-20020a05620a384500b007815fb7018fsm5699036qkn.4.2024.01.03.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:55:19 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  linux-acpi@vger.kernel.org,
  Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5] ACPI: resource: Add Infinity laptops to
 irq1_edge_low_force_override
In-Reply-To: <877ckq4az2.fsf_-_@gmail.com> (David McFarland's message of "Wed,
	03 Jan 2024 12:50:57 -0400")
References: <20231230150916.1843117-1-corngood@gmail.com>
	<CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
	<87il4a4ipc.fsf_-_@gmail.com>
	<fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com>
	<87edey4bcp.fsf_-_@gmail.com> <877ckq4az2.fsf_-_@gmail.com>
Date: Wed, 03 Jan 2024 12:55:18 -0400
Message-ID: <8734ve4art.fsf_-_@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A user reported a keyboard problem similar to ones reported with other
Zen laptops, on an Infinity E15-5A165-BM.

Add board name matches for this model and one (untested) close relative
to irq1_edge_low_force_override.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
---

- v5: fix commit message

Apologies again, in my haste I made a typo in the commit message.

 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c3536c236be9..0e2c397b1399 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -555,6 +555,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1


