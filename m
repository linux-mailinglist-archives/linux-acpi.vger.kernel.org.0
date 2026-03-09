Return-Path: <linux-acpi+bounces-21531-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHuRGkShrmkLHAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21531-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 11:30:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7662237190
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44419300E277
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9483921D3;
	Mon,  9 Mar 2026 10:30:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBF37DEBF;
	Mon,  9 Mar 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052223; cv=none; b=axfOEmQGpFh9Jc91z6Pa0gOAPJ5JFkSiUZQ4rfvkJPg/S5lThgbkWuTZmgANjrNppRJdzFXE556b+UTCJK92lf9SodKpBMabumlvuEYTBb9uu6RgmzQ4fNZJWUFhWjqymUVx+d7cUU0HAbiD+qCn0n8+w2qRy2QDdxvx6s2fqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052223; c=relaxed/simple;
	bh=S39RhiGVyimXCDjc1xM5yDuZY2cvR5hVkmeqHSg9+Tg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HziSm9V/BDEY582fZrho78j0Ey4Yl1JOZyaZRrkwywv8HOJOhrAsWXepGVFHWy9X/jUFdDG+1Qta/dRzERo5AMFOrZmJddG+K6pCod6VsMaYxxLr91Y+Iefy0zpsvDePA5BICDePCWqaaMPjEU/7qTaqnMPpF1rNGEV72JAhszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTtYy5PyzzHnHKh;
	Mon,  9 Mar 2026 18:30:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D32140086;
	Mon,  9 Mar 2026 18:30:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 10:30:16 +0000
Date: Mon, 9 Mar 2026 10:30:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sunil V L
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>, <wei.huang2@amd.com>,
	<Eric.VanTassell@amd.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@oss.qualcomm.com>, <chenhuacai@loongson.cn>,
	<wangliupu@loongson.cn>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_acpi_id() on non-x86
Message-ID: <20260309103015.000070c3@huawei.com>
In-Reply-To: <20260309041659.18815-2-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
	<20260309041659.18815-1-fengchengwen@huawei.com>
	<20260309041659.18815-2-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: D7662237190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-21531-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.497];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 12:16:57 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> To unify the CPU ACPI ID retrieval interface across architectures,
> rename the existing get_acpi_id_for_cpu() function to
> acpi_get_cpu_acpi_id() on arm64/riscv/loongarch platforms.
> 
> This is a pure rename with no functional change, preparing for a
> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
> platforms.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

