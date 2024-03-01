Return-Path: <linux-acpi+bounces-4051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCF86DCFA
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6705228A648
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4A69D31;
	Fri,  1 Mar 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bvxrLYFh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B267E6C
	for <linux-acpi@vger.kernel.org>; Fri,  1 Mar 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281443; cv=none; b=kxboW/HcFLlQdp88V6AlaaJPeC2Fc/i9YqGCrnJqqCR+1wogrrIfLlznLh8vRphU+rgkMBjCNjAFehq7gBpXSW3wElx/6XplXq1HTGhBluF5+MqlCz+CZP8efIynC+dBpTtwHBkcOxInZCjrnumOC/odu6nN6yK296DmAihuuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281443; c=relaxed/simple;
	bh=4eat6mnFfXzoCJ3q1jO+074FtyB2bjfelHIkr8Ir38k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNdGVqKIl8c3toz21dlk6VMEeXUrw21c2oIAxW+GWx83p/N5CqRH4otGrcJUkWWLVDM+PcSqgFw32jPc9N3w989ru6MsM4dStatG56xdRkCNEW/Gi6tFVOwPmUhEhDHPdpIBUuN4TyS8YTNcJ5wPH1mPD2WejRfvghC8lo3Za/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bvxrLYFh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787bb013422so106869785a.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 Mar 2024 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709281440; x=1709886240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbrAz4lnEz25kwMLB527PTKTo91cgL6BvX6RpZZhxe0=;
        b=bvxrLYFhGccIDpTcA8STZO/EWHDLnSss9a9yBaMr4dRvcfekUbs8s7vldrjrBTGnxX
         aKnIaCNVgzRJrn0uvxW+FEPk7GaW96lU4e1jzAUeXdf6oN6r8MbLq9/KHK6FJISywjvr
         caQ5a5mCbfmOdpvadUnvIDY4JK/DLOEbpqasEex5XHsVJ3DcZol56GYvbaiWoX0e7Ni3
         5D8a8BpLb5wXlthMgwPOQPeZCqFldpPjgrJcUrxj6cOx1kA/mS4nuJHwQ9uKQdEoBLA+
         lB68cbZF7P1iQ5KyxQFo31UwfBT2NVq4AhKRvT1ofpoNuffREWfsnn1bETYAW0dGDOWC
         gtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281440; x=1709886240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbrAz4lnEz25kwMLB527PTKTo91cgL6BvX6RpZZhxe0=;
        b=f8rtTYWABhPqGf5dVR0iQIMzztKRuc9DrfJEVbGU2npxXpFn5xhg6NPNi0rbgHoHbZ
         JgsmdILLMz21Q5am6z2lzwbBT/CnWGd0aG28g/QmxOW5huv3QuqZXWIslr7BAVq/sArT
         uEg4UQiG6U2L6dSjEniwAnYNtMWIg71WZC1USYA+h3VimOpVVpwuBv6vWtnZp6dsV03M
         oQ1cbBLtO5yfFZnFyHEgdhZoay36F1TtIHtmiUhWcMfDb0/u77jK/LNiBl8tiv0xwWT6
         BHB6cK86duQdxopULk0d4q3WETtKlmZ+kbuXhgMaqWDJyyy7doX+M1K8MQ/3GfwhuwRa
         QpLw==
X-Forwarded-Encrypted: i=1; AJvYcCWFueHfKvpET5Qg9aaPs0lqQfLYvDAb7sdyzFsqgxoHbz17etVgy2RTeo3YJ/chB2tEcgZqkqChVvKYxKZbNQhmeuIpqeqLMyyurw==
X-Gm-Message-State: AOJu0YwU2ET0frmXE47VluvPF5YbcwEoI+7dBi0By9gBKm/kg1gfsv8d
	OhtjdbTXwwhxfsoZazN7iGnYV7WKsXwPaMEXFS/66Nlmjwdg2lONXr3PvQOB7Tk=
X-Google-Smtp-Source: AGHT+IExEjh1BdqSl2OFFVnciy2m2VKRizXJqjFfRMSkTbsdSsINER9CoqawxtN38k6ZkAj5ZjelYw==
X-Received: by 2002:a0c:c20a:0:b0:68f:43f6:4834 with SMTP id l10-20020a0cc20a000000b0068f43f64834mr990776qvh.26.1709281440109;
        Fri, 01 Mar 2024 00:24:00 -0800 (PST)
Received: from n231-228-171.byted.org ([130.44.215.123])
        by smtp.gmail.com with ESMTPSA id y19-20020a0cd993000000b0068fc392f526sm1631907qvj.127.2024.03.01.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:23:59 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Hao Xiang" <hao.xiang@bytedance.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri,  1 Mar 2024 08:22:44 +0000
Message-Id: <20240301082248.3456086-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory tiering component in the kernel is functionally useless for
CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
are lumped together in the DRAM tier.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
at boot time, eliminating the need for user intervention.
If no HMAT specified, it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

Ho-Ren (Jack) Chuang (1):
  memory tier: acpi/hmat: create CPUless memory tiers after obtaining
    HMAT info

 drivers/acpi/numa/hmat.c     |  3 ++
 include/linux/memory-tiers.h |  6 +++
 mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 8 deletions(-)

-- 
Hao Xiang and Ho-Ren (Jack) Chuang


