Return-Path: <linux-acpi+bounces-18380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DDC21090
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB4467F5C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6ED366FB7;
	Thu, 30 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYqcXIB0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F7364497
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839280; cv=none; b=A3QU+bNd5g5WdXqhBYvCzhThkSuYRXCjn2SRJBMTQYI13lZWdhYKGqHKvF0DwG/Qg2aSzFNo895A5Z20w3BcGVep+0y3MA96mDkiL5Y8L6bPzvwLU64lEqG44l2ixKb3vDCtfHcRqteosPReKJ6N2m9NByi1Rd6I/cy/jo7pVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839280; c=relaxed/simple;
	bh=dj4JgxYSsx9iEnxdLQ5jxXbS7kC+kfcSZq1bbTHwdIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKm4NlfZ+J0OxBkb4EauOMPsEdCAP4PNNICoG/tPnPGjK7KHV7o+80yT6jm3glR4BFeEMJjllaJyp6OMQpeTgkEI8vB8NDubtX8gW+K/YVuSeJVq/0RDX5TQptosMgzHz8b7ShJrhnkvuKO2tvJd8MjPA2GIL9J8AxxnmaYvQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OYqcXIB0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1254723f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839276; x=1762444076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JA5tH0/jN6QofZu1XRi2irHFU4Wf8X4Ks8QpkT31AM=;
        b=OYqcXIB0cWM8c1GgJbJM6dF98vt3GzLky6N+84TJvZIjbQeisHBEzlogtoXd6hx6XW
         uzRGHeMGlvW2aqzXCd09LdS+tB6vlG12tMhTrv80RpLOUx/5KLgaDcBhdnkcumjNDCwD
         vDtYo2EYOzgd235VgPtwuJe4Yv3KnNTI0YZ44ihjapCwTtrAnmbTKUs5fC3ZgvE/MBun
         tiHqK1Fskzu6W5t+NcydRiHmaFitLofjibGWu6+Zz99UQguBmVGbBNtcNk5TK4eoTtHy
         0T9CQl4bKuifJ6b8hNllups+f2gSJzPCWpE3tLtsuH/hidVgW05lhscZ3JiDDEv37yKR
         dTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839276; x=1762444076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JA5tH0/jN6QofZu1XRi2irHFU4Wf8X4Ks8QpkT31AM=;
        b=tRnaYStCLWdivlXFealWqtclck+68ZwF7xA2k16ryYrb8M5kfE3dok38ijP2O0WG+e
         N5bSfo7SDo6ghV5MP+k4KwaBaK6MpKtGyOYDKiWOuhwk+Ip8QptrG8TP1JCSmMsPd2aK
         QJHt6EUayNd0cYaPJ96GzEUJWHMwm59tT2CG9dWWZq4C9TyTrfmpc3mwGAGRZd+L1FZ3
         VxUXsn1FaAmbpNle/DCIVknWrdMkcr84/EQL1yabjZ0CQINNWEJEJB5cfazVl5W8/IYW
         AKB5Q/s4pksvCl/HWBBYQqBhQDTpzW5aY9CQaqLr1lrNaY5RKslsyeCp24QmOnf4hiGG
         ZJSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7/xSfyaHJVM0l2qcRN4GCb2J9OLyw7WndrJAFXHm2WbY9QiiGDTAQr++VOuUYszRxocSmKP+rwC3r@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mYk3G6/zqVuS2ivTqxURMtKS608dJuZ+hiobJVJF7JqW1h0/
	kEdiZEG/u9tzvgyPXOHlEgu2r20Z/16r/Jox9cwAs4Ot0C4djKg+7asqEvgXlBi2Iec=
X-Gm-Gg: ASbGnctCdyz9MdFymnSyGYMxsJscDU+UqjvuQuH5buBGx0aV8fJuiE7UiP43P8DHxko
	zYE8/JFgSgQcxxd/7GZvdMjy9pZ4ERyQ62gQDh0w2NMc6WzO+vPASfWmglN7c/dQqjss4rmlvp3
	DaaPcsUKOlpMsWEiQK0OnbubxeQccp76VxpHYqPp9RcPuLWdJ/tNWCKNNYCNI7i+Hx/hMaLRjEn
	jztE1MrSvhbAS5HBgMkSIqsece/0Do4RNScw5qMcfctc+hcpZL+EHepvr7jCu8Fd6vj0A1KgC7f
	s/Z+EILyE6ujJBuMODWvNDPEDoomkU3GqQHY9Dm53qw1iOM9zWVLB2/xs+BRlBhWrhKP31kZWH8
	Zkvm2eVf3xIqKXtuvWCAhZoDYnBDA7bXDrNtnQfP4mZiC086YraP1s8K3A2QUgvMp77kil4KeG1
	pmBYsN+SLt9JBSlW8=
X-Google-Smtp-Source: AGHT+IEEYnjir9tDFz2xcJ3AeLq+Hq9UTEgdA54xaGRh8uYrQgEV3tVv37Pq49sexRk8dbqzfWFkSg==
X-Received: by 2002:a05:6000:2203:b0:428:3ea7:4473 with SMTP id ffacd0b85a97d-429bd6a48f4mr35234f8f.39.1761839276467;
        Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
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
Subject: [PATCH 4/5] ACPI: OSL: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:38 +0100
Message-ID: <20251030154739.262582-5-marco.crivellari@suse.com>
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
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a79a5d47bdb8..05393a7315fe 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1694,8 +1694,8 @@ acpi_status __init acpi_os_initialize(void)
 
 acpi_status __init acpi_os_initialize1(void)
 {
-	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
-	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 0);
+	kacpid_wq = alloc_workqueue("kacpid", WQ_PERCPU, 1);
+	kacpi_notify_wq = alloc_workqueue("kacpi_notify", WQ_PERCPU, 0);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
-- 
2.51.0


