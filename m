Return-Path: <linux-acpi+bounces-11503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35317A46D8D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 22:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB36188A6ED
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC725A34D;
	Wed, 26 Feb 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZkhiXnv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405220DD7A;
	Wed, 26 Feb 2025 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605724; cv=none; b=pZ3A9xm9AE9CXXTu1LJHAUTM4odBMZo1fZispVui4hV9pWsId0akGDbAeTgsdNz2Rp/Ff2fiXvMjWlj9YFGEp1lmhLnfwxYyBtJOEIkC/you2x0npQqlpRd+WH6Iz3XYKJttYn0UUJ5KB3sv3+4v9Ao1Vw+qumZBUPJlTIEfOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605724; c=relaxed/simple;
	bh=eP+n2IkpX0AHc7Sui2TNCj9yDs/4+qfdiCG97wQbdzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnJRwL8zXtKUGRCeKrk/F2gTyHhdvHmd5xsti8DNYXVCN+8kYlu/RBpJZ3IjWaht5u1WHDN7+/aAbu7qH4d/+XnjE4o1fo0ilHIxoTMQVtVCwzdIcXhy/7VPB3wO/gfkZuZ2KOrx2unScXOvuT+I4pU5NDrRUErSlqf0GaZ3UF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZkhiXnv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f7031ea11cso3027207b3.2;
        Wed, 26 Feb 2025 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740605721; x=1741210521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVYI9kcUdIjH4cxP98YN5mlg2UhaCwMf2rCWTMU2nGY=;
        b=YZkhiXnvGNPSjk5LnIfrnmuCAnkmqb6ac+qRhkob+IW4zDbOWRGmTNYmYbiBgX6/oi
         HnibC9LV9NvTku+vC1HnijdgAqNXaef3wDnEi30DeG0rbu3YhDQkcg4mEZTW2KM/DcHW
         w6os9dMwW+LPbbTB/SVUGianeYtlav4CrREhQpB0ZgjL4nOJPak8793aI9GMWhAUabnM
         rHscGb8tzkqybiLyTFpzSJod0m0a3nqJwoDAodPtwluYvbKpJfaxl10rKtkc/Fx7LFBS
         fR7pMpmEj6d2jedkiEWK1GfiMg74zQ8HajLKGPF9L1rt63ulwUoKpSi7TMNnev63UxlR
         JgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605721; x=1741210521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVYI9kcUdIjH4cxP98YN5mlg2UhaCwMf2rCWTMU2nGY=;
        b=xP80cAdKkxeuOR5q2KnSghlwY275OnBh8DepCPRqkBtZ0+Bsom6RJN7o4TKWQdV3Yz
         joX04KPV7T9VlTlHcoUAz/boY+sUgd1seQ8ycgApDVqJmLaYjrNfg9KSU8001f66axXM
         8qWV+xtxjinWjjIFxGJ6fnejKUxWh0gU3QzNW+el0YzKN9O65HzpLcF2tDHizHW3EDhU
         mtcR7Q7NilebWAMgdP5MzX493PoEuHvuhg9MmDxIsVS4PH8la3TAFGvScOT7PT1bDyPj
         tRV0i6D8uSxjc5R8urg3RyH/wydGeTs+ZOIkBqZLlA879rDq8WhfKTQBHJkW7AtoXkfU
         h3/g==
X-Forwarded-Encrypted: i=1; AJvYcCWI1/90OM+zDbxGQIGtcs6Lt1BDn83X+WaxTkNiKGqu2IRqmjkLvYq03PhQ6dQ7/DJmXtpgu4eMLBLBYuE4@vger.kernel.org, AJvYcCWnIWvCJB9WVaOD8+z25MJuyoOKIUf0PyTbxXZOOJxczFjJiijYRiNMXqLyxsMvN+n+3fLrq/9xavQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86PXW9kTBx0eVoIwBQajpvEG612JnvZ39k+Iq9j4Lj0Ltv+Nx
	5TlYFhrsDhuyJP9mumhuP7YVC6eDuIZAt5om4areP2g7DxhTtAMy
X-Gm-Gg: ASbGncuECQY5kPGA5EFgRdbbKVaoAW1XUSCSnOqrhO0FDMCofueL7RmDfWDOh1S/28v
	HchqanRBM2mtL2MzTVxtBBLmNusxdADm0YLQvX5CYg8dWvBDTsLzWWerogZvpjgcGdVXecpCS3O
	7V0oAuVnosII0zMm/mvVeCHfonDsgSvxCe+jgLf0OICdHWCzOfxl/PmiAJMLv9ZcI7CYIXrfeQC
	vl8E8BMKROxvwX+pmhVYtXuOD8uimO/7p10FcJsDPNMW5WmBVPr3ea5bogPB3tZCZk/mrRZUO6s
	ZluiaICEvjAQTp5yxurzzekj
X-Google-Smtp-Source: AGHT+IG1EvsPoz1Bd0r2fP5cpv7TzPk24gy2Kj+wLmrdUzEN3RWmK1nuptSk4y4e1hD44ksUTTWCBA==
X-Received: by 2002:a05:690c:498b:b0:6f9:9891:7a7f with SMTP id 00721157ae682-6fd22084565mr44734717b3.25.1740605721598;
        Wed, 26 Feb 2025 13:35:21 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd1185bd13sm11805607b3.96.2025.02.26.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:35:20 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com
Cc: honggyu.kim@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for memoryless nodes
Date: Wed, 26 Feb 2025 13:35:18 -0800
Message-ID: <20250226213518.767670-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should never try to allocate memory from a memoryless node. Creating a
sysfs knob to control its weighted interleave weight does not make sense,
and can be unsafe.

Only create weighted interleave weight knobs for nodes with memory.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4cc04ff8f12c..50cbb7c047fa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3721,7 +3721,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
-	for_each_node_state(nid, N_POSSIBLE) {
+	for_each_node_state(nid, N_MEMORY) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-- 
2.43.5

