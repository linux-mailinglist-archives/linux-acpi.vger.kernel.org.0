Return-Path: <linux-acpi+bounces-18379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5EC21093
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B5F467D0A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA3365D59;
	Thu, 30 Oct 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="euOyBBWw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858D3590D2
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839279; cv=none; b=Bj8PVJMxC0o4eKPK2OwIxvAiPEqgVrk+ubB9wWZhNaL8jPh6BOi1Qmm9+XWYB/6vwAlZDqgEeayQaXK4jCOauusBqf+guAX+Uawx1hf//ADLH3IeO25SjZnfuLQg4g/a68ifTF1U5Ed+rqWqwp+uB7PwNW/TKI0QtPEr6a+0e18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839279; c=relaxed/simple;
	bh=x6Jmgz7kV0VtWAu8fu5Me/0BmZbSfEXouiezE/Fn2eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX/JgedlkwU8P6IU1SmbTiWqdR0FNf50lJCqaN1ssEe8N4HMjWkLUXfOPJ/Qqbo3EZ5M6Rtiq7cN3Xryubz9/t3Fi546Y3HVya/djd5oiBf9xq9GO9rpXvBeWNb5ogyUy9rW5K4iPYX53elDwN9nd6/ZB0uQ8DOkvqCHx8DrZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=euOyBBWw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429bcddad32so69142f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839276; x=1762444076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXy7dakDLCk8jvSrBK5+P+LY5BhZuaHlKUiBvDFl9N8=;
        b=euOyBBWwCOvZyAJx04ToCfke5r355HvV0/89KHupr0ZoBV+SFK2/YwpB9eQK1fPohM
         GvwXRt/6B58ESmRliNt0cPq6dqtZeJJB12HQ1h0JMBGOH9pc7EiE2szr4v+MqmyZfFKX
         gotkNmI6xCkMiCqNsfpj8YbKQE1diYUVdW9AymYKXSfCt/MB+bLiP5gwfr2hIh3MfJQ0
         F1B1O+unzUweXTRlU1eMFfQBi87jWbIj3pvFk/OyKYOx5xsO7L5VAlaaiIwJYWpEFGXc
         y6gs8tbm31oXXcm4qUMKCOXNYvM2Bi7BO/Y+9qotvdhrbUg9IvXxsnDNUUFUohRNsEKz
         c94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839276; x=1762444076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXy7dakDLCk8jvSrBK5+P+LY5BhZuaHlKUiBvDFl9N8=;
        b=bAoM/kgWdA5QhUnt4rg6V7JkVw3hqhmPcjZXh2vSrTM7CHarkIqbTWKAafIau+sAgb
         PSlYgFAbDFdgRFFzVVQf5syjyJ2hoW3BkyVPUpIqCBCU61+28v2qsRhEv8zS5IezRqpc
         IoDqXnoEayRnRCPaw2Td3u0wqhtkuRv2ltvB7ZZeIEmnpiY4poMQKWXowEi9jM3pjF81
         JiFke2zoIkNVT+EzAmPNeO3ZA4BnG/hIR/RoWDJOx8UYMTaZCNpnP1Ciw98BfMrXb2kl
         HhzhzjFwIDzniChTMnRiom4zC3YFBR4e18yqw534iBH5TLoH2mqd1vLOak2lohAhcBuV
         l+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7mqk6U3pSiqEB8NBA7gd6/UPl4EcB6+Cx6nKpjo7RLr8/VD9XSi493p6GWvQJstYqBtpD41uQ68vS@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0XcMWtL5IJu+BlPOBhAzd1SEcnET3TrdKTDhXR07uM4nWRxl
	v3v4wjQaWwHKWD2gN7XhPWgdt7yF9YrfWo8x05PECOcu8zMDN6a+GGtBWlNFunK8XT4=
X-Gm-Gg: ASbGnctxrUDSSuZNt0jlbIJFoYjxSC5Mxt4KlQ1ND4TsUxwMJWoitueLXRfYLXyX8Wj
	Br5SDMlmjEzN1LaD0BOBE/Dgz/9ksm+WdwFvbzniIuq+4RfPUoIicOs2nW+WPgU2wv8/TR7eVpO
	WpgNIa87mnzc+NNacsQy5vOcM2XArO7gzOJNgy0tfrME/o+xkcvrg82AZUky+lyH0OrJ5vg7So0
	6nE1qd8CchRafr2kw7mIRwRXA0KBu/29DCKv6Wbvh27GjIP4oSNxpJgvdbDlzD0GYmqy+sFgetf
	1zJF/fn++IQOxSQjrxRd0Uteyqxvwy9ojYV8QSjEpWz9z+LPqgTMPykyqfdzeU9MViCWAfHbiVX
	63q4zUGBfrjzrbE74Zob5HTa+jNqT6Zsd4bdh3/81XZjfx5LettOBDp2HBYtxI5uzOCNfVt9+08
	bHyZgWHSCZvReKANg=
X-Google-Smtp-Source: AGHT+IFpbJXmONDXqy8URpoDE2bukqEzjx2Yz0ZfSH27dYfjypq+STqGcJyBnSPnqHPqYEfzLHpSvQ==
X-Received: by 2002:a5d:5f43:0:b0:427:7d5:e767 with SMTP id ffacd0b85a97d-429bd6ac817mr32343f8f.42.1761839275608;
        Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
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
Subject: [PATCH 3/5] ACPI: EC: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:37 +0100
Message-ID: <20251030154739.262582-4-marco.crivellari@suse.com>
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
 drivers/acpi/ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7855bbf752b1..59b3d50ff01e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2294,7 +2294,8 @@ static int acpi_ec_init_workqueues(void)
 		ec_wq = alloc_ordered_workqueue("kec", 0);
 
 	if (!ec_query_wq)
-		ec_query_wq = alloc_workqueue("kec_query", 0, ec_max_queries);
+		ec_query_wq = alloc_workqueue("kec_query", WQ_PERCPU,
+					      ec_max_queries);
 
 	if (!ec_wq || !ec_query_wq) {
 		acpi_ec_destroy_workqueues();
-- 
2.51.0


