Return-Path: <linux-acpi+bounces-13633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88845AAF209
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 06:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FD41C028CA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0913AA27;
	Thu,  8 May 2025 04:16:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0568BEE;
	Thu,  8 May 2025 04:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677771; cv=none; b=aILSefZtd+Juawpj4h7L3AGbTozapDIe/08cOCMdc9FIqN4m7+UUhHisXpgn5OK8wPHARTvvVM+9EjEnaKe3Eqgbosa0vdg4ZPKJ2QMvYkiXSGBonngSO67o418l532+F4h5bbNPWMLf5E0Q3PgBJ6ny1P0Sllak10R/BrHPCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677771; c=relaxed/simple;
	bh=SYPfWTFh0S/3r3Zj9WHCONJnjPTTvaA4ymNvkrkBam0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ga3q/RvU3qZbmp61P1oDs30NxXma97YJaRZM/gfUYd6NiiRFStCQPrOw3XkPJPG7kHZNOZceQZh0aCxSczfyngbntKu2NfrrgRVGpZM8Hc+msA8qConiWcWo1WKq7dmbzEDN5nyRC3ICjrQ9NrainJKsPJpfBsIez95HzOkKVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZtJMY12t6z27hdY;
	Thu,  8 May 2025 12:00:57 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 11A16140277;
	Thu,  8 May 2025 12:00:11 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 May 2025 12:00:10 +0800
CC: <yangyicong@hisilicon.com>, <lenb@kernel.org>, <jmeurin@google.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sudeep.holla@arm.com>, Maximilian Heyne <mheyne@amazon.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PPTT: Fix processor subtable walk
To: Jeremy Linton <jeremy.linton@arm.com>, <rafael@kernel.org>
References: <20250508023025.1301030-1-jeremy.linton@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <14393dc8-692d-eea2-c8c0-76125806622c@huawei.com>
Date: Thu, 8 May 2025 12:00:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250508023025.1301030-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/5/8 10:30, Jeremy Linton wrote:
> The original PPTT code had a bug where the processor subtable length
> was not correctly validated when encountering a truncated
> acpi_pptt_processor node.
> 
> Commit 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of
> sizeof() calls") attempted to fix this by validating the size is as
> large as the acpi_pptt_processor node structure. This introduced a
> regression where the last processor node in the PPTT table is ignored
> if it doesn't contain any private resources. That results errors like:
> 
>   ACPI PPTT: PPTT table found, but unable to locate core XX (XX)
>   ACPI: SPE must be homogeneous
> 
> Furthermore, it fail in a common case where the node length isn't
> equal to the acpi_pptt_processor structure size, leaving the original
> bug in a modified form.
> 
> Correct the regression by adjusting the loop termination conditions as
> suggested by the bug reporters. An additional check performed after
> the subtable node type is detected, validates the acpi_pptt_processor
> node is fully contained in the PPTT table. Repeating the check in
> acpi_pptt_leaf_node() is largely redundant as the node is already
> known to be fully contained in the table.
> 
> The case where a final truncated node's parent property is accepted,
> but the node itself is rejected should not be considered a bug.
> 
> Fixes: 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls")
> Reported-by: Maximilian Heyne <mheyne@amazon.de>
> Closes: https://lore.kernel.org/linux-acpi/20250506-draco-taped-15f475cd@mheyne-amazon/
> Reported-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks for the fix. The last CPU in the PPTT can be parsed on my board with this.

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

> Closes: https://lore.kernel.org/linux-acpi/20250507035124.28071-1-yangyicong@huawei.com/
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jean-Marc Eurin <jmeurin@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/acpi/pptt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index f73ce6e13065..54676e3d82dd 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -231,16 +231,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
>  			     sizeof(struct acpi_table_pptt));
>  	proc_sz = sizeof(struct acpi_pptt_processor);
>  
> -	while ((unsigned long)entry + proc_sz < table_end) {
> +	/* ignore subtable types that are smaller than a processor node */
> +	while ((unsigned long)entry + proc_sz <= table_end) {
>  		cpu_node = (struct acpi_pptt_processor *)entry;
> +
>  		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>  		    cpu_node->parent == node_entry)
>  			return 0;
>  		if (entry->length == 0)
>  			return 0;
> +
>  		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>  				     entry->length);
> -
>  	}
>  	return 1;
>  }
> @@ -273,15 +275,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>  	proc_sz = sizeof(struct acpi_pptt_processor);
>  
>  	/* find the processor structure associated with this cpuid */
> -	while ((unsigned long)entry + proc_sz < table_end) {
> +	while ((unsigned long)entry + proc_sz <= table_end) {
>  		cpu_node = (struct acpi_pptt_processor *)entry;
>  
>  		if (entry->length == 0) {
>  			pr_warn("Invalid zero length subtable\n");
>  			break;
>  		}
> +		/* entry->length may not equal proc_sz, revalidate the processor structure length */
>  		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>  		    acpi_cpu_id == cpu_node->acpi_processor_id &&
> +		    (unsigned long)entry + entry->length <= table_end &&
> +		    entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
>  		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
>  			return (struct acpi_pptt_processor *)entry;
>  		}
> 

