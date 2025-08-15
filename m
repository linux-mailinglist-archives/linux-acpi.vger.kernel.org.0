Return-Path: <linux-acpi+bounces-15723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B7B27AB4
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2226681C97
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A942C0F78;
	Fri, 15 Aug 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="JCHaOt79"
X-Original-To: linux-acpi@vger.kernel.org
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773532BEC3F
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245465; cv=none; b=VFsS13694Y3eUjssB8hHY0HOHxsI3hCyTMhLGiN+Mms2Ym91w9JXw3U6G7uXuxY0A55XnRZdCO5uybfzx/GX4R4mZDYjXXlgJYz8VFvyChK3u6BfoQOuz3WomoMPluoK0A/jzMWCnHsc5/kTLplkhOdSiAUSXJtm4lB3cb6CWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245465; c=relaxed/simple;
	bh=5nOrQy3XElJENfSC/LatOI56f9OxwJE4m2TuPasPCn0=;
	h=Date:To:From:Message-Id:Mime-Version:In-Reply-To:Content-Type:Cc:
	 References:Subject; b=csucbyRYQc5d1+V4yDpb0C8nbD4UPuN19P1nAHnCGssEUYMp7fuPIJ3xKb9Xb7l6tqq/BXMABQUDTPTUAzbnnw0Lk6yUlDwbAMt+3mOOn/ncl7kp83R+jUSxKE91FgAZIBHgdYBQlL0barsmhb+owA4v1VZN7eX4la/Zf2LBHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=JCHaOt79; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755244556;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JFpwghLSkeHlDIyCqRaPY0QI7oFLO/bDk8iDSgor+H0=;
 b=JCHaOt79+FpJwMEF7MRFiVBmM7NRIVRO46N9vtxoUBQNCWKKuPHJnhr1vPpzS8NH/c0s/I
 33ez8lQ1GIkU3aGeRNvcisNTor4xcYX4/obXTRhXN9VeCXJMyi5nLH0EiAZAzWBNyHlD62
 GEwqxVMbCRlj3QDclzcpb+Mtdclvs4G7kFh7VICQThkE7567Bup+Wz4J2RVj6SASBmc6o6
 AoBpSQBCWEDINl1b4IkCjPCXKe5LRQRe4RihqqppIEokahkYW+w2P/V0WMKTz8xmxN8L0/
 3eK3aNopCH3jZs/7unM/Isv9V2FBhHK+KLSlUxon8ip2aLd+qxYrylKsjtF6uA==
Date: Fri, 15 Aug 2025 15:55:41 +0800
X-Mailer: git-send-email 2.34.1
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 15 Aug 2025 15:55:53 +0800
To: <sunilvl@ventanamicro.com>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Message-Id: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
In-Reply-To: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Cc: <ajones@ventanamicro.com>, <alex@ghiti.fr>, <anup@brainfault.org>, 
	<apatel@ventanamicro.com>, <atishp@rivosinc.com>, 
	<iommu@lists.linux.dev>, <joro@8bytes.org>, <lenb@kernel.org>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <rafael@kernel.org>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>, 
	<huangxianliang@lanxincomputing.com>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+2689ee80a+aedf14+vger.kernel.org+huangxianliang@lanxincomputing.com>

Hi Sunil,

On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> +
> +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> +		*id_out = map->dest_offset;
> +		return parent;
> +	}

Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
a valid deviceid required for platform device in rimt_plat_iommu_map?

Regards,
Xianliang

