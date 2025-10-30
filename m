Return-Path: <linux-acpi+bounces-18378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E4C210D3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD53A1AA170C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC43655C9;
	Thu, 30 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a7RXwf1u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056929E11A
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839278; cv=none; b=lwpo5R1D1vFWA/UQwlWhW9Qa3C9X2xrDAoLHcb1ADjAJT7Iij5gvJ916NDyyqi4BZplmNPijd6OC2Chbhdh/6ScWFBYqxq3DXm4gzpBScz+iLj2ilY9U3fJv07af3vpEKAvo9eQvlsjHMubAPbikswWDFjZoFEWFVa09JweAwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839278; c=relaxed/simple;
	bh=rZ5kBwXxvaDt2BMbcVF0+veZbJzLSOJtP3lgRZMOnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky90OqTwfuV7XcIK8n0TBR6mTtYRT/pgcLCg9zqwfLCpV9BUuEpwH+9Bh9miRuf2Tny0k5bVV8ydRSwEttlaoEci9wwp+PN82uMYDTfSaH4TJA5S7k9qU47WoLK5a0VzNIUxl5Y24hz74iVDdHS0U7agcso8J5f76iB4GW2kvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a7RXwf1u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429b72691b4so975559f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839275; x=1762444075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKjLkJX2ivVfrTT2riKqUS+oMXr5sjkkm9myJlL5OtQ=;
        b=a7RXwf1unOg68jpKCn9x/k+2salVh/g0WirsNygnnD7SRef6+p8gCUVI/O7ZCkrNnS
         MRW2UljlQJFqmt5Gz5lldtqN5LrgVK6HoDxP/vVE6ORXaxLKpYQCtohInHG7zUz7Pl/m
         I5nkyQlBm/lH3AGEg4bmh1jfP9vCPMbIowBsnS2mMLCijjX035/N1q+/injn4p4Iihau
         79IrbaT68xHsdZPEiFqgYQMb7YSqsovKUnb0OgkE3a+jpbDv+tCb1ZZaoQnZ0c9cTYPH
         u6K4GF02LIB2TeCACzQwdFq9Dhqp+tQgY9JPu8Rgs5VP5cl9nzju0nAtBUkjs0fFUVpX
         ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839275; x=1762444075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKjLkJX2ivVfrTT2riKqUS+oMXr5sjkkm9myJlL5OtQ=;
        b=KMmhzi0yJxVE89z8EfwwqmUTYBqS/UjfKx9O9A38mtKcSsnjRP/jzYQdQOuQ/coomy
         so/g0itlyuTKXipPLBgnqZqY8thhK5mKODbuTNzFAqiaS3hZC9TItPGfNS07SWRqDi8Y
         iW3xwnvuJ3MfNWx7jcLRWHRNTdtImmmWBwBfeQGxpKSp2YLxWO9JOlwbxHh7GBl6soaa
         d1NZ9csJXkfeC1pA/1Z4u19ez/iPY79ulOV+vR1r0TBCmYwMh1vPhHTuNrsn0v7F7s/Z
         4d96TeAmpDaPPGSbFx+BC0pe75/kqzpdaFyaERRAbzr9zyiGrOQnuxqZ1oXD6YLoVvWt
         kKHw==
X-Forwarded-Encrypted: i=1; AJvYcCUW3pMfYRrGooyoD5g1yuFb9yjVlQ512gBwkwpbUbgGMaDMpYOaoNlQkiUiYccK4i+DLJXTHhcvg5k1@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq8pQlN23Tz/3v0BDCun/FWLCWvZkudQ1QM/Dv5QX4WSrFlqk
	XDSLgZu5Hrbavd03C1sP5WM5PZ1K3JhuiMM8rjMlfNCOHBc3eRxOGm+QTpSkKWwmJqc=
X-Gm-Gg: ASbGnctTvlNGZl+eZoAR4jlauIiVLAkUXaVvZYFF3bKhTB3wHYmw8B7LSrEX5IaLuH5
	7cELqcISOPiosuWbDdYebRbb0/bEcvF5VGhRnXuIwLCmcIc7Jo0vAlHm9dIZM1NSLWyWTxJaPFK
	dSyKPvOlYYHWThiyRAldZSwFVBP++Iry1IVEsIWH4UueEEPSlYaxMBvUeI2vwNlJ7TPc3H7wHRq
	BlSlgVM6wY1sBvau696rQe9eQXtfnqX6auyWGEY0ssQ1BvdRZ0gkajnYAtUfosQ76g7tVAEnl22
	xuduu+Avfc5kYtc9lJ1QigCpLlklbB8aGMOBjwuSvytwh4bojE9PDeKFjl7FGRmau1ExSg8e/Dd
	x/PaRUEVOOjS4JXBTZ6SAjDQ2fqupADRRfh3rbV58WD4CAm7ShISpNPEZZZpM3z9ThJpQdgLeGL
	xSPA1ItEAKFwSABnlFoQ+Rp9drsQ==
X-Google-Smtp-Source: AGHT+IE5s+Lf9wcOpZOtCH5Tt/5Y2/EehbblVu3uT0e68kjERO0vfqRCRcYIbE+J21bs7leTY3ELdw==
X-Received: by 2002:a05:6000:186c:b0:429:b703:ad97 with SMTP id ffacd0b85a97d-429bd6de678mr15906f8f.57.1761839274731;
        Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] ACPI: OSL: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 16:47:36 +0100
Message-ID: <20251030154739.262582-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
References: <20251030154739.262582-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..a79a5d47bdb8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -398,7 +398,7 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 	list_del_rcu(&map->list);
 
 	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_remove);
-	queue_rcu_work(system_wq, &map->track.rwork);
+	queue_rcu_work(system_percpu_wq, &map->track.rwork);
 }
 
 /**
-- 
2.51.0


