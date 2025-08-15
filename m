Return-Path: <linux-acpi+bounces-15715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF03B2763E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 04:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F82604289
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E6125B1F4;
	Fri, 15 Aug 2025 02:42:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06896220F30;
	Fri, 15 Aug 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225749; cv=none; b=fVI7k1orTT96QgQUmCsfRRPbgJfISt8rXuGCazDlDgFDd/yIezpPrhdjK2DGA3foJVAu0yce8JY2VCsBEbPalwfhlES9FC8PLuvzGuh6VTEY/wCzS3aX+6YSm4hEMIW5VzTjBz1cYF/C4ypRrFAXhVKBAEMVLpnnydFD/mOiPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225749; c=relaxed/simple;
	bh=L5mfzaKnGUxZGpHN9HE+pHJm0jk3HsdWvB+VzyIZr0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LI3E5f04FhH7YkJ/cr776ZBi2iU/3MR/PXhuJxkvBlu5HXoFZ0nn4jHPXwq8AwHXNsZgpF0oTQYAdls70g/LbXo9ykzq1uU3FoCno+e16Gu8QO89Lj3YOFvkPr3ScRPJCcp+5OCOaM2ji+top6kPEx4Unrj3tTzo+S6F8bRcN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202508151042099718;
        Fri, 15 Aug 2025 10:42:09 +0800
Received: from locahost.localdomain.com (10.94.14.201) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.57; Fri, 15 Aug 2025 10:42:10 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <ira.weiny@intel.com>, <zaidal@os.amperecomputing.com>,
	<Jonathan.Cameron@huawei.com>, <colin.i.king@gmail.com>,
	<dan.carpenter@linaro.org>, <dan.j.williams@intel.com>,
	<sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in __einj_error_inject
Date: Fri, 15 Aug 2025 10:42:06 +0800
Message-ID: <20250815024207.3038-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025815104209f2ad94c75f6003c6785862e0bd3d971a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The __einj_error_inject() function allocates memory via kmalloc()
without checking for allocation failure, which could lead to a
NULL pointer dereference.

Return -ENOMEM in case allocation fails.

Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/acpi/apei/einj-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index bf8dc92a373a..93a3ae1325e5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -540,6 +540,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		struct set_error_type_with_address *v5param;
 
 		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		if (!v5param)
+			return -ENOMEM;
+
 		memcpy_fromio(v5param, einj_param, v5param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
-- 
2.43.0


