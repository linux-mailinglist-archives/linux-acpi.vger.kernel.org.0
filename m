Return-Path: <linux-acpi+bounces-13592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA39AAE4A0
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1249352343D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156F28AB0B;
	Wed,  7 May 2025 15:25:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FFB28AB03;
	Wed,  7 May 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631531; cv=none; b=Mv0t4nMnbHCdFkpqi8Cvexme+gVxcDAeRNMmdTMn0Cf5V3mGvzMkSwzgNs4O8QWV33S9w9L3vmGXwOeMKK0yqrXO9gZpJyl9jkvV9mJvDiV+TMfvkKlMRZiTos+uf9/urBxOgd1pDL4hf4eRunlGob3rMpWYnsxYHiExGvkm6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631531; c=relaxed/simple;
	bh=CLGuly61z6pxnXMpY7OtXp7nCpQcfXJ9VrfOuwL8JdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSyTl1pNq2xKXjgj0fDW3vqNS5BfYQFGEhwyFMO6SaYBmfyB128Ul/gGdiICeK1I3IKGSIN1xPS3/3zxM3IT27LBznFbI3jZ6BizqH2zR5XEslAjLo8qMf7/UpWTqHQNMuLAyXCUib7saeLDsnj74z8xrYAOX10p9gHdWtxEgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8166D339;
	Wed,  7 May 2025 08:25:19 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AA5D3F58B;
	Wed,  7 May 2025 08:25:27 -0700 (PDT)
Message-ID: <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
Date: Wed, 7 May 2025 10:25:25 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250506-draco-taped-15f475cd@mheyne-amazon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> sizeof() calls") corrects the processer entry size but unmasked a longer
> standing bug where the last entry in the structure can get skipped due
> to an off-by-one mistake if the last entry ends exactly at the end of
> the ACPI subtable.
> 
> The error manifests for instance on EC2 Graviton Metal instances with
> 
>    ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
>    [...]
>    ACPI: SPE must be homogeneous
> 
> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>   drivers/acpi/pptt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index f73ce6e13065d..4364da90902e5 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
>   			     sizeof(struct acpi_table_pptt));
>   	proc_sz = sizeof(struct acpi_pptt_processor);

This isn't really right, it should be struct acpi_subtable_header, then 
once the header is safe, pull the length from it.

But then, really if we are trying to fix the original bug that the table 
could be shorter than the data in it suggests, the struct 
acpi_pptt_processor length plus its resources needs to be checked once 
the subtype is known to be a processor node.

Otherwise the original sizeof * change isn't really fixing anything.




>   
> -	while ((unsigned long)entry + proc_sz < table_end) {
> +	while ((unsigned long)entry + proc_sz <= table_end) {
>   		cpu_node = (struct acpi_pptt_processor *)entry;
>   		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>   		    cpu_node->parent == node_entry)
> @@ -273,7 +273,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>   	proc_sz = sizeof(struct acpi_pptt_processor);
>   
>   	/* find the processor structure associated with this cpuid */
> -	while ((unsigned long)entry + proc_sz < table_end) {
> +	while ((unsigned long)entry + proc_sz <= table_end) {
>   		cpu_node = (struct acpi_pptt_processor *)entry;
>   
>   		if (entry->length == 0) {


