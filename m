Return-Path: <linux-acpi+bounces-7998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F639658FD
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FE828786B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C515C129;
	Fri, 30 Aug 2024 07:46:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE315C127
	for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003960; cv=none; b=VsSOjlzQxEkPJ6c7X8KZtjwYj0rHxZ1ZrcaqwLAtEXM8S7VCSfs0iSOT1ZfYEc+E66M3tsgQUDwbFSy5GXF6ScThsE+TkpfprHuc8BjM+Khyne/wvm7GMd5hXCN/Pdr872bCvLD/u1k/o5a/f8AHZdbz/2axE78q36L40+reN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003960; c=relaxed/simple;
	bh=ycx7Af3gGC2XDqHn8dU+KgLtCV6QPuz0Wv4IRaTBr88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZy7psO/bSQuKDtC6RMxbZCkR5ji+w7sqGx9eOpmaqHW1sDENVSJ3y6lKg46/fq2BZKDYywvUuF5f66f0625aMgyHh+ASfFWCTWvSXoJSznefKWwAaFiDKpC6+RJUyWEZBqdX4Wyebjn7COLpQAdjzfkzqNeXW2kTOcEPL6Th7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww9951Kw4z1HHs8;
	Fri, 30 Aug 2024 15:42:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0955214011D;
	Fri, 30 Aug 2024 15:45:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:45:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] ACPICA: Use swap() to improve code
Date: Fri, 30 Aug 2024 15:54:03 +0800
Message-ID: <20240830075403.3540985-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the swap() macro to simplify the code and improve its
readability.

The target code segment uses the bubble sort, we can use
this macro to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/acpi/acpica/nsrepair2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..5d56b2fd9151 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			      obj_desc2->integer.value))
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
+				    obj_desc2->integer.value)))
+				swap(elements[j - 1], elements[j]);
 		}
 	}
 }
-- 
2.34.1


