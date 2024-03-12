Return-Path: <linux-acpi+bounces-4258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D7878EC7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 07:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683F8284F8D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48658AB4;
	Tue, 12 Mar 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N87hEi6d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBF59B56
	for <linux-acpi@vger.kernel.org>; Tue, 12 Mar 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224280; cv=none; b=dUKuABAFRRgkKUC1hwvAonnOZWS6YiM515yt9Vm1gy4M6ervBQb8SSfCxBPqglNfI0FO10PI52e4vwpPk9DwYIoQNRVWB/ue0OOAooIeZCH8gS5z0mUjFn4xCnuu7xt99tRmxYUVss/bWmY7dpl2zBxa1ni25fyO/r/BDIaxmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224280; c=relaxed/simple;
	bh=nmhtM2hCPPzOA3PI1UXfFRGQ2/QNiXyNuDJau9M3uBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNaFhyKvYRjjL97BME6CkwexZPEu3TbqHgT0FK8T/qL52gIWZasUo3aEU6YxW48WH8cEqTNq13GRfp3A/BSg8MBuqCKaZXASO6BgBOu5/Lfl6YeAQpKkZEJatdUlyN8cibkAZibVDAC9hpOBc6LoT6nXchelmsDMYOU5fLTB8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N87hEi6d; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78810ba2ff1so179788585a.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710224276; x=1710829076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
        b=N87hEi6diJng+w7+kr1gATEIjESXvtw+Akc9f6rIK63qn+rl+fDI9YzT3pZIvLm2AS
         OabDFtRqCET9CeXl9TW1mvwAw+q5Iu2x8e+dI/ZOY1Cfo4Pvg4LUdE98CjZm50RoeSQJ
         9ymy2k0sf7H86rm0Dysxp5qPoueOXY3sgFMAgpvPmX1ruTqp0SBnhC3ADYXksDFcVFCq
         ZjtzN2DQqaPe4+byUBjTn/bvgLNg6yJ3WQPxYdioeQdXirc3fdG+iDg8VDKRhhoWNeIh
         4zsxKVOOpG+K9JAD1D45Uhd8/QurjMHKsCswPJIeKzSDVNdZWisjkRAUW3KIRBJtxEC2
         y21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710224276; x=1710829076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
        b=EUkWCNy06s36eC3aw70s34UiGU8WkYnqSEOE2yXsreBM6EoESY6dWSop/NOVhXRi6A
         HHL3QTdkOeuPMgxch66U3KnIRyQDtBzFH3AT5PFjPgBM/LCnzPCEH4/XiUKdpetjHwIN
         zTaJDQtqmr39F8VV+EiLkr/0fj9Gxyq9FRs48S1mzeu0RgpnWD3b+FQnwPzBn5o4LmdY
         uNh0lWvbw8kyxRIxJV/tIAzM8mBQjmxaG1ruff4lbdPIMFPYNDYodW62MJrAiwdaL+MS
         mfPDy59q0RMKhh2+5DBs8z6IKEFSz3Ac1/osiOMZD0MiDGA+gdmo0/L7dsH+ogYaQ8x4
         eTfg==
X-Forwarded-Encrypted: i=1; AJvYcCV7ELP+qwDY6718/SaOXyWUMtc9PSfuTxiZjaPgaf/HBnSEQZ+6njNS8QXvE7ebOCMIYPnGKKB6UDBSmXUVJJbvt2fmEqBg+Gv5Hg==
X-Gm-Message-State: AOJu0YyNlzM5vozWgHkDDKzjzkCoR0W9WwmO55CpZ9gza3JWbYMZJuiJ
	N5McEooMxIZZmtn11u7PkEwRAHUlGFQoUMLmFNWAZgPGQUInX4jUNfLRroyZEeY=
X-Google-Smtp-Source: AGHT+IGQVjf55XaSaA7QRv11XERHDa0ikizCRigRPLUcQWIpU3ODAYNJ7IKwN9aaMW4bZrAoONZoqw==
X-Received: by 2002:a05:620a:4494:b0:788:7dc5:cf8f with SMTP id x20-20020a05620a449400b007887dc5cf8fmr499319qkp.35.1710224276179;
        Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.133])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b00787b93d8df1sm3394396qkh.99.2024.03.11.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 23:17:55 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue, 12 Mar 2024 06:17:26 +0000
Message-Id: <20240312061729.1997111-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
at boot time, eliminating the need for user intervention.
If no HMAT is specified, it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
-v1:
 * https://lore.kernel.org/linux-mm/20240301082248.3456086-1-horenchuang@bytedance.com/T/


Ho-Ren (Jack) Chuang (1):
  memory tier: acpi/hmat: create CPUless memory tiers after obtaining
    HMAT info

 drivers/acpi/numa/hmat.c     | 11 ++++++
 drivers/dax/kmem.c           | 13 +------
 include/linux/acpi.h         |  6 ++++
 include/linux/memory-tiers.h |  8 +++++
 mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 16 deletions(-)

-- 
Ho-Ren (Jack) Chuang


