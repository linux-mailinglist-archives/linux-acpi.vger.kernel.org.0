Return-Path: <linux-acpi+bounces-18377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44EC2108D
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F64EFC51
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5668363B9B;
	Thu, 30 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDSQpdEv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5322638BC
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839277; cv=none; b=nd6sTGwJkP4egIfq2sJs0+Hnc8PiAMnvn2PPQUeYy0awZdgTgONi+m/Qpnms6uxNNS5DBB0kPTptSqMOA+cBlhS0oSRXV6AP27uyO6XEsnpwYxFtPIIwIyIUZKl+kZKXdYKZ4sQbNUACa4ilMCQ0tzBBQCU3JriIcFjj9Sp6abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839277; c=relaxed/simple;
	bh=/7LsG64oWK7wGZDkhEcwZF7KCXXElgpetNi9oy+Oo9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhAK9191CrNX/UK7YFXOhooHPfWFERjGfDJ8b3V70S4Q0D1eIiawjOtCjlqHAddTqJhI3iuOQT5r7DuWGlLP+ueD42P9BxTLVrUK+jrkL+NN34ncTxfEByp4+qHd5f+sBZbqjFmu4e+TVnKrRrhqs+6yOtc8Q8E4fKvs5i+H3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDSQpdEv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so751865f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839274; x=1762444074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94J6pOSo9Nuw6aebkUjzuSFc2ureh881e+PTgGeW2qs=;
        b=PDSQpdEv9Va+o2beBQso0UH6T1ZDsLE5Vseo4p+/4PczU/zft4iLM1fkTeziawf1yU
         BLgs1Xf8cH5gZPJ1wb18Z2eu7CAD6PbtHroDHrV7jl6lXRGSLT9DFpsg4FTqGm66mZyp
         LiBdX3AbuvwDlhJzYk0SpSfwXs7/Mu0obPRkAKPqPc503vM3qpr+1e2Qow4ZJ0Kem8zz
         gr+XNbOWfqHnM/bDabMfZzYlQWaODEvlgddQRY9ld2kpGoFTdimH23uLzn4q/u7LJD8M
         0SzVzioD3DnZuJkcVp6U0r4lhOu8ZEauDcTvf1n4psRUBlWTH8KMVjhsO0yoKGNPgGFV
         x39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839274; x=1762444074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94J6pOSo9Nuw6aebkUjzuSFc2ureh881e+PTgGeW2qs=;
        b=vPzbcsG0gDAhxpd9Pq47z5j9VpV3vk6MQzdS7HyyeCSDA8wQb2d9IuTl+DFLgOed6T
         4Go3irTivEuxypfFOlh8ug0fJjH81Ecx9MmJ7F8DpkxOt1OG+eZi706TuyAJELxSDq7n
         3V23nIJlYzCMkYgW/NdIowP08BYGx5311UoGzSXawmclczDtUnCzzndss2Kxv3aj9C7v
         ZCj0HPS9WtPCWL7pqeJXNSE3g4vVlbVO3PqBrqlhab5Ck4eJJKia14w/DqkakU62ktqG
         oI09eR8WElwykIYaWaSBzMk7hpg43sMlwnWQyFFsFDQqN8Pnu+KXf2LmX5ZSVylThYID
         a8ig==
X-Forwarded-Encrypted: i=1; AJvYcCWX6v4MRvGPXYwiOGH7YwDNMkUdeTsdUPeGVKW6YwUJf8QYWdS2B1w9Q8v+kPD/nw6dCoWxFRLQz8bL@vger.kernel.org
X-Gm-Message-State: AOJu0YzthxppoHh76USTYTWXeaIXNc22OAYN3cuPjqu6p6/OUeT9bvoJ
	cY4bLvyEQTXWS/2LWFZnKTIp/sHgupENcKc5OrmqmotlGKnUo4uJYSMwpkLCsJxIf9Q=
X-Gm-Gg: ASbGncuxOxgq6ZERw5s4i1TmyFU51HS7FjMgNiWKqQlsPeYf2ub4VdKWBK4JA51m8pG
	/D1RWRcxoR3jnGjN1UTu5R7BneOGrset/m8igCmTA5N57o/xuNNp8MIuLWYJBo0rX6C6v9yN3yX
	dhHU/vxuors/K6b9axyJHkbXN4Ny425cSimkWgulBPQMTzSUBpZsBgjrau+j+viAKahhcD4CXtR
	GDsS4+FelA/RERsJwapSMvv0L4qQ1DotkB/cnmZ851EVKps1vyi7ZtSDomw7nXhRm4ck9swyzUU
	/23Ypwa1dHfwDPxdDOmUo7dfNxFXfqbvm28Hy3EBav16WjyxkS65mIwJjhZS8Z9Pm68ogIcgRkK
	w1LUUXlQo2GL8Oy1zP46woCG6AhtAnaszCouvXjRhZRZo4LsHSTLe6AiygD3F9Q7tbw4vsWEJ3f
	RQVicGUnUwOdMBp9YFBWXa7tAwvA==
X-Google-Smtp-Source: AGHT+IHmDqkqWJ4cBL6EIyssI/vAVsIRgr+fKOw3ABPhay5rVVbLQ0/kllfx5VmeHkJX+iBkkymQXg==
X-Received: by 2002:a5d:64e4:0:b0:429:927e:f2d with SMTP id ffacd0b85a97d-429bd69fd97mr30084f8f.38.1761839273935;
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
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
Subject: [PATCH 1/5] ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 30 Oct 2025 16:47:35 +0100
Message-ID: <20251030154739.262582-2-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ef16d58b2949..e0c0b5a50d26 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2397,7 +2397,7 @@ static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 	 * initial enumeration of devices is complete, put it into the unbound
 	 * workqueue.
 	 */
-	queue_work(system_unbound_wq, &cdw->work);
+	queue_work(system_dfl_wq, &cdw->work);
 
 	return true;
 }
-- 
2.51.0


