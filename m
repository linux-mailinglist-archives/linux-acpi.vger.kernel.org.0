Return-Path: <linux-acpi+bounces-21533-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIseK/u0rmkSHwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21533-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 12:54:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04233238400
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E13304CA69
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BA1D5147;
	Mon,  9 Mar 2026 11:52:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280139903A;
	Mon,  9 Mar 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057151; cv=none; b=ZEepVM1BrujEOSDqdorFVBqfCDhZQYdZRvV4xswsjklm4rpKHL2P77UelP4ubP6+LIrBX7cmdu+Sd4zY0VluzsNp4liHYL41d97IlF80uF6WF6iwxpmrO0mOmIRVx0SX7sbvFlTY6xRpdLIhXII3BtTwH0T5di+3E9ZEc9ebfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057151; c=relaxed/simple;
	bh=ZNOmKkBbFQlb/cZJ5uldSm7yF7puOY4GBaohWuZt/2M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BybF6nql45x3BY6JtkezURn8uRyUhzMJ5wlnFYcoGV/HcCUAZNqZvct8pFF5OMpRHENqYI5vqrrUYZjlvBNW71ZvbFUOW2SoVBBj3ggN3iy+7Rvg9ha/0xwnH0kdV70EY0bPejuFZ+WtDN1DSYpxpgSfqdlvWo9X1tlGMJGLAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTwN00xn5zJ46sw;
	Mon,  9 Mar 2026 19:51:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 041DE4056E;
	Mon,  9 Mar 2026 19:52:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 11:52:25 +0000
Date: Mon, 9 Mar 2026 11:52:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Kai Huang <kai.huang@intel.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <akpm@linux-foundation.org>,
	<nunodasneves@linux.microsoft.com>, <xueshuai@linux.alibaba.com>,
	<thorsten.blum@linux.dev>, <gourry@gourry.net>,
	<wangyuquan1236@phytium.com.cn>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI
 is on
Message-ID: <20260309115224.00002a6e@huawei.com>
In-Reply-To: <20260308222313.14014-1-kai.huang@intel.com>
References: <20260308222313.14014-1-kai.huang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 04233238400
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21533-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.572];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:mid,huawei.com:email]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 11:23:13 +1300
Kai Huang <kai.huang@intel.com> wrote:

> On CXL platforms, the Static Resource Affinity Table (SRAT) may not
> cover memory affinity information for all the CXL memory regions.  Since
> each CXL memory region is enumerated via a CXL Fixed Memory Window
> Structure (CFMWS), during early boot the kernel parses the CFMWS tables
> to find all CXL memory regions and sets a NUMA node for each of them.
> This memory affinity information of CXL memory regions is later used by
> the CXL ACPI driver.
> 
> The CFMWS table doesn't provide the memory affinity information either.
> Currently the kernel assigns a 'faked' NUMA node for each CXL memory
> region, starting from the next node of the highest node that is
> enumerated via the SRAT.  This can potentially increase the maximum NUMA
> node ID of the platform ('nr_node_ids') a lot.  E.g., on a GNR platform
> with 4 NUMA nodes and 18 CFMWS tables, this bumps the 'nr_node_ids' to
> 22.
> 
> Increasing the 'nr_node_ids' has side effects.  For instance, it is
> widely used by the kernel for "highest possible NUMA node" based memory
> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> related system calls such as 'get_mempolicy' which requires 'maxnode'
> not being smaller than the 'nr_node_ids'.
> 
> Currently parsing CFMWS tables and assigning faked NUMA node at boot is
> done unconditionally.  However, if the CXL ACPI driver is not enabled,
> there will be no user of such memory affinity information of CXL memory
> regions.
> 
> Change to only parsing the CFMWS tables at boot when CXL_ACPI is enabled
> in Kconfig to avoid the unnecessary cost of bumping up 'nr_node_ids'.
> 
> E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> reduced with this change (when CXL_ACPI is off):
> 
> 	w/ this change		w/o
> 
> Slab	900488 kB		923660 kB
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
Even without all the reasoning above, I'm keen to remove state that we
know is pointless!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

