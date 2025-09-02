Return-Path: <linux-acpi+bounces-16274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202C5B3FE88
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B055C18974E7
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FF30C604;
	Tue,  2 Sep 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhqCetge"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EF30BF54;
	Tue,  2 Sep 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813574; cv=none; b=DU2+80UvdxFvatvRSR2N5V9uh61Ix2L1mLl/J3DGJoGkW4x8WnpoB24pfE54wZrcaE1GK9y+V0e447CIDEC44ef8UwRCzBfm+7jikBlzFPFTWfR+EgP1sFhJlzSe7b7AIkiLa4Q0VmKkOV+skum6ePasF9rDyl4PSuVJcKt3TMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813574; c=relaxed/simple;
	bh=b2dzqMeUqWyWDJ6+jIt81dE/5kfkNj+Ptj+goWcMI5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqrtzJ2EE/Nm76dTOlNyJ0dgvGF2D0Fge5RRk6xB9q8e9bNFEdpHcPKfDs1nMGWkrE5yLwT5M58QyWWj8Ia0N2zr1i9gPBj+ZnecFCOUYLH5/oZcRA+H265mtzaXyaadJ6p1Syul+OThuw+Saz6m0tu8ERwrfd1A4BeI4eucoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhqCetge; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1755320f8f.0;
        Tue, 02 Sep 2025 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756813571; x=1757418371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSpYSwOXNofPRqPJb67ltbn5EWSPohwy2KpciLMYW2U=;
        b=PhqCetgeu5/GhoulrjaoWQKojVqhqwf1iLzpsvWlHtbuoWkW8VbXpZvViUqW0XQsqh
         qYXKWefxzXUFQj2H3iYLZQaholMdmRS4r97lDvzBm0XrTICYT3b0wviSG2EYjJt3UN4v
         hE4cyzoMXkEoHTCVNJ16DnVO3K4aBcZonDbBQ5hx+j2+4sAxwN8XOBNik+Qpm0AoBeg2
         ml4HzKNf8jumpehf/eP9q45T7rn+ALk8AbnGP65Uh0ceQCyOjaiWWokikvbv6RYhYdtr
         CgcXJhKUdqGFx9r4YZ5sgzuvSYSOpltY9r7K8kzg65X+nODWzdIIGYETO2qHVuX/hHYd
         5+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813571; x=1757418371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSpYSwOXNofPRqPJb67ltbn5EWSPohwy2KpciLMYW2U=;
        b=YxnIiYh9nj1mw+KezEzbePvJSCF4S2BdUz6heENIYgEF+GThxvq3w1/xEO+GhMFd8F
         IiliATyGQLyN9rY8YkkULRyGz/HiHTaNmYzCvO3YSIlcdP85oqFZIL/DPC2K6fCAB+0/
         Mss0SkoEAUEnTNSM9kzBnnvyN06gUR0bTtHTs4Jg3u2C9QKNX+iTJfLojd+dQWIqgFqB
         ErNZcCPsql/BPQ5UTawBGzhw7iERLaZ1iDndAHfseoN6kGwDo421XcUX/ybtwilkDxS7
         EhpCKjXj2bwDs7idt8NNjIkp8Cv65Av6sJWooYNOnq4tppnOPPFQ1W1nr3Vyqd3I6kY4
         R6xg==
X-Forwarded-Encrypted: i=1; AJvYcCXSPnu7gumHnzSVDEYyOZCaWDfYx/vrBLyEouBsbzdThdu50egbbXfis1BwZQpIa/AatdpXFQs1wl3R@vger.kernel.org, AJvYcCXuB0vzc9c2Uk1xmPGxbkAbTQEkev6qV8i2gnSzwPkLLVTTERtkTjQ1v0QECTrj/R8s33n7s+EB0U7J82OT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12q0JNvBxqkj4QjgQyk3Qa9freXLtWMjHb+E+vbdkxoS1rigX
	pdKFQNc9bgTC/aGKDPOOkFRR9MuizAzmrm0+YRdvTtt0qxKkgH6WSJFK
X-Gm-Gg: ASbGncummxJi+gSwzIew2D/px+zLvXS6OWbpaKQ38fQpQYLXlcRnrBeCDgWtqy+Kww3
	KGiKjJCVpLL9JbvjMXn4GAjK8052RZu0u6xTeWpVJ6dH1Leqju0UbrSDXp6AxfvxSMWqjnU0enO
	1aw8pslLVLCeJMcqTrDIh43Gd2TcGJeUDrJkxgdDKULP69W/yXvonl8gNtYWw7AmopLoDrq2xET
	9lhnGaDrRPPVNJoqOusfSb+VBc7orMJZJXbMPdwbat9nSGt5ERe/rND2J48ry98epHWrKimchd7
	X2Y9Y4SUAPZh3MxPs+TKghMTkilyu397Vd7lANW+30U6Gfy0HjBaZovMeZ7nifIJcI1KQ05nKaG
	3AYLSC783mOe2mb/QBxzQ
X-Google-Smtp-Source: AGHT+IFSx1ZLxuVxr4IHYwG/kkbItLSnigBFcwtrJLVgNw4wTdNNofAu9Ao+jN20uMosvQnfKfZH2g==
X-Received: by 2002:a05:6000:4202:b0:3cb:285f:8d9c with SMTP id ffacd0b85a97d-3d1dea8e31amr8673398f8f.48.1756813570540;
        Tue, 02 Sep 2025 04:46:10 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf8a64fce8sm19086547f8f.34.2025.09.02.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:46:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jia He <justin.he@arm.com>,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: NFIT: Fix incorrect ndr_desc being reportedin dev_err message
Date: Tue,  2 Sep 2025 12:45:18 +0100
Message-ID: <20250902114518.2625680-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There appears to be a cut-n-paste error with the incorrect field
ndr_desc->numa_node being reported for the target node. Fix this by
using ndr_desc->target_node instead.

Fixes: f060db99374e ("ACPI: NFIT: Use fallback node id when numa info in NFIT table is incorrect")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae035b93da08..3eb56b77cb6d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2637,7 +2637,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	if (ndr_desc->target_node == NUMA_NO_NODE) {
 		ndr_desc->target_node = phys_to_target_node(spa->address);
 		dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
-			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
+			NUMA_NO_NODE, ndr_desc->target_node, &res.start, &res.end);
 	}
 
 	/*
-- 
2.51.0


