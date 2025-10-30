Return-Path: <linux-acpi+bounces-18381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F556C21099
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7684246628C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36383366FD7;
	Thu, 30 Oct 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WAz4PaLg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB93655E2
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839281; cv=none; b=A28jWN3m6c2Qb7RLFIxkC9BY9SbklpIxY5qR+R8k9MwXrnlBmy6fTJmMznbZatwo6KRJedE4oAoun5TRLUI+fWARAX/5YUYqtJDFgqNGH53wdlBvzZqPMQwwvEdRcsHesGiTLhJ59GW++pZMj/IAmY+X9e404Hzy/1NfCtWDeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839281; c=relaxed/simple;
	bh=XJrAeM0bm8IOI+PtKrJkM5ofQWWoG6sG4rQq8LIKX0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO1z5BfrHa9k9aKTzd3OJ5I/vtxfez7NDjvbHUL6fT6oeg8RaJw4adrQFWv8kOxEBv4hXPveXVR5NTL5mfHq3gL51hdyzGJN6eZAlx04RJPmApihVAAngvzh10Kt2S1Py82yuTzQaSnipygvLOgh1uz+eKjH1dprtNCzNwNIrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WAz4PaLg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so724977f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839277; x=1762444077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EvAdEwVOXpN/RTJbLmUZiFBI5Zw4W1nq/Q+XC07Oog=;
        b=WAz4PaLg1bZJgv+lXGj4SosOAfcLlPRh3xCK/sL/InmnYo0JXGJ8n/0QGyb7e1Vg0d
         kiQLhoBLrPPCaP2Ju94e0sWlbRF0l380mClSMQicbAdDSrgHUjO2GUHyEAYskCrVBEum
         sUUr5wzUwIpNzVMHOi8bYJiTmfzGgxgclLisesItdDai9GrgkwSDCbD5ebKsbUKoY4Pd
         oZIsKQRAe3ZF/1hJEcF7P8zi0E/q8uoYRLzQHwqNbU2rmBfjnZ46E0K5scAGLjJE9ZKG
         5zPnbexlcaLH0DgOW0aMdFhKMbadh8wgwq8NJ5TIAdJDc4EE6OskfT1rGGWg9YB8/kHD
         SkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839277; x=1762444077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EvAdEwVOXpN/RTJbLmUZiFBI5Zw4W1nq/Q+XC07Oog=;
        b=WLvkyAcOzqeXcqn3hsfF2USTAZBTxsXGk3jFCdV2P4zIeZYLNMNQbWQjECPUcf0RPA
         B6YcXxpJCR3ft7Pl5Okq+nGwIBGeHEBBU5X9Do2gYPU7eeAhozdx1LXi/OORsp2AMh6n
         zoUB9s0J36QTet+ODclUB8IIHASaDMI8TWOdh3J5Fobe8uH0ZlUMcPZbtQNJphUVAlhJ
         ItxxvdXfUzewqY4olXpo60DLyMzUO6s7rVaLoYNud1V9edYU6iQ5D2BY2Bak73CwAnS/
         fVx0o/vGYGYZ41/8uFcHFf0DFYPx8Qmg2Tsb5vTG9FbUGrIw7NpYa2LvaNB+HrXXzuBr
         v/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXmdDe23bRiYLq6Gq/PuxnbTL/asZDLsrvMIxmD3LPxzpMn9E1fSE6sh+SnGxge5jW9GScicRmZvPIm@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUgUAma7JiWMSWTsTmPNb3Rk+IfoxFD4smdVTWWOpOi5Du93P
	lZnRlqPT8AP2FKiMnuLTu+XqLJNXZ022gdhwnYTTSV8Q2OR6rQM2Xvp8VsaoZPj8TtE=
X-Gm-Gg: ASbGnctWtvITHKyPGKj0eQ2Xlkdbca7SEweFKpSLJFvNH7QJ9fpm41pp7D+/PlykL8c
	E0zyhZyfuvIZ6HZvNxRdktp9G6z/y7g4S5AvqHh4EUC37CsulpvMwaQKT+5lrKQNidOO1sCg340
	YHdD78P0EBwdNX1jFoPnbBJTMqL7VzFT8OeKrRjHsrUrxkG75buxfPGtkiaREZyApkDA8ZsDaS0
	ZsVPI2yrTJ65L+uvFGyX68e7Wrut32vKPsZ9OMSI2WpPzeKFR1tqtmhdoMemRTmH+1qhGSwgHE7
	EJRBiS/q4uPqcoeFIOLv8k0ZtmqugUtK07LcTXps+8mjg4ojlV8GQxhz+fdjfNq2Bs42ksCGN05
	8FVxTpXbCuf8msipfbW33iEcbSJiN59q5C3UtFoWZ5pyiwIAJyWAEXFZ2MoXmPZ+9rhy4JcaKKV
	ze5Ri47I6quiPODas=
X-Google-Smtp-Source: AGHT+IHv0b72t6uTN5xevmEXlNNhXb865PxInovOLuEzLPLCBQj4iAvE7Apv1laDFcFKTRnG6CgXAg==
X-Received: by 2002:a05:6000:2309:b0:426:ed9d:4072 with SMTP id ffacd0b85a97d-429bd680cd2mr43975f8f.21.1761839277284;
        Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
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
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/5] ACPI: thermal: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:39 +0100
Message-ID: <20251030154739.262582-6-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
References: <20251030154739.262582-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
CC: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8537395b417b..a511f9ea0267 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1060,7 +1060,8 @@ static int __init acpi_thermal_init(void)
 	}
 
 	acpi_thermal_pm_queue = alloc_workqueue("acpi_thermal_pm",
-						WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+						WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
+						0);
 	if (!acpi_thermal_pm_queue)
 		return -ENODEV;
 
-- 
2.51.0


