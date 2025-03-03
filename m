Return-Path: <linux-acpi+bounces-11704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3AA4BCFD
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A103A9C51
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634311F461F;
	Mon,  3 Mar 2025 10:53:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EE1F4171;
	Mon,  3 Mar 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999211; cv=none; b=JtyUrvuOSn2y1jwCuZDVGLeMchvB75nCV6rmP3ko/0vlbMzYIcc3dB0Ga1ohAZo72RlYVBPTR5nN2lPGL34zar4mNj1TnNNpS+e6D3yJsfYNqN9iJwRKl6xcm6lzioGo+3Qpfrw+XZruwN/F7NFTJxuAw5x5CrvFtKNHDBlrSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999211; c=relaxed/simple;
	bh=200nn/4JF4ubELss3QLL7p1PASyuP4e2PWPIQkroDkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oylh+Zs1xJ6BRP5NozjqgBYjSks6IjeQ5q3BnERTy0bGbs1QutYNQPAlDoB0utAm3HdAWIbms19XMKPqIxgV2/vb3fLRjbSLBahXXjLrBU43yN8R5WgjQbBEa6/jdce6FpjDOLUB9q6Kw/Tay8NmLGgJi4tImYLr5sOQmtLSTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264082008;
	Mon,  3 Mar 2025 02:53:43 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A3FA3F673;
	Mon,  3 Mar 2025 02:53:27 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:38 +0000
Subject: [PATCH 03/14] mailbox: pcc: Drop unnecessary endianness conversion
 of pcc_hdr.flags
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=200nn/4JF4ubELss3QLL7p1PASyuP4e2PWPIQkroDkE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohZmJ3X0WGWizJXAMHN4xUhfGZueR0Z07Dj
 q7KIRpPjESJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mJStD/4xFv05gSx16Q02HplCWvd9xj+wDUj8h5sm5XDXHkL47PmV6wfQGqVrrPdvQUbKgPFAT3u
 xQUmYrtSHKyjkh+cXL2545LmxLm6HUw4qVa+wMWMaIL2YWY5qZeIq3DabKRwTQkL1f0AtHSuLH8
 gD0vMKUkAAUdfyA/XtHTxkVfLJv9YIOwAFDh+yYLLPzWc2I0rdfay8w53362zAlYG3j6CYP6Bso
 g/L1ggHB33nm16pUpsNH/NFxZci1p6wtnhmTcPd/gimQqtTHlmcf/qmCP8p+6NC/qnkwkXLy+Vk
 du3mM5JUTuaD/WCxK334tmlxr8zY3Umm9jHPzgnqyRyQ1AiFA6zYQqq8gljiMrkhKcFV8EWae+u
 tbUv6BCvm/fMOCtZUXuG7M22/hzfjLlt7w+ge+lV9u8Awhzo4sWE90SlS1O7IitmKbns4C9fJk5
 iFjNmH4WdCFsTrBXsSUcvEwBFdfV8el4kamxeE/cB1ASzqqERqYlBNDbsiuJ/6UrRuniHLR1cWg
 oyOQSEtxRAEUVdbkGHuf8hS09nkXl5txSgkQ8BwSRusNbOb0GizkTy87xjyxz+7Opg/PPIn2Wtm
 NFJxScB3+X1PLuYMiPuHNPQz3Gl/5+Agn/8D/oOnTyHZ3/3B58gj6uMCb2braCN+YqaCvHn5+g5
 gueITME3C6hscpA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The Sparse static checker flags a type mismatch warning related to
endianness conversion:

  |  warning: incorrect type in argument 1 (different base types)
  |     expected restricted __le32 const [usertype] *p
  |     got unsigned int *

This is because an explicit endianness conversion (le32_to_cpu()) was
applied unnecessarily to a pcc_hdr.flags field that is already in
little-endian format.

The PCC driver is only enabled on little-endian kernels due to its
dependency on ACPI and EFI, making the explicit conversion unnecessary.

The redundant conversion occurs in pcc_chan_check_and_ack() for the
pcc_hdr.flags field. Drop this unnecessary endianness conversion of
pcc_hdr.flags.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 4c582fa2b8bf4c9a9368dba8220f567555dba963..c87a5b7fa6eaf7bcabe0d55f844961c499376938 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
 	 *
 	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
-	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+	if (pcc_hdr.flags & PCC_ACK_FLAG_MASK)
 		pcc_send_data(chan, NULL);
 	else
 		pcc_chan_reg_read_modify_write(&pchan->cmd_update);

-- 
2.34.1


