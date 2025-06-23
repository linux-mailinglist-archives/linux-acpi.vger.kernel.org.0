Return-Path: <linux-acpi+bounces-14501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D6AE41C1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 15:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19D93AB7B7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4324BC07;
	Mon, 23 Jun 2025 13:10:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893C248F63
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684256; cv=none; b=pGBLVUR6NHMPsxtyEVh323jmqQPBh/xsoLkyRiycrbI/8QWq580ww/DsIe+bzAqYSBODD9xjZDzK9XGl9jr2k3gl0SgKZPl8CrcHM4uOlyH7srYnozzkap35s4Lmb7wVebbomd7D0YmTwVi4fLc6IGeAvyJcAIglMDQTLlQa3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684256; c=relaxed/simple;
	bh=z8LcC5oXFxU5iE1yK6J8RE7WUmE4/OKRdcgbwZ5f0Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJZBaa2u73ohd1miweSTHOYa/ejTccSglncyUfBan0tNAoSfwMwPYofhrkAinawsDh5eJoe0/WTpgoC88CCNwYScgZoQYVmNvmQlERh2DMHPKZNwNm6jHCD7aSi24nQdd3YFKmsq9Kr7mdgptonSHnzVC0DZVKSN+ZLise7/lZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D695325E2;
	Mon, 23 Jun 2025 06:10:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBDCB3F58B;
	Mon, 23 Jun 2025 06:10:52 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:10:50 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Morse <james.morse@arm.com>
Cc: <linux-acpi@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>
Subject: Re: [PATCH 2/4] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
Message-ID: <20250623-fancy-quizzical-ostrich-32d305@sudeepholla>
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612171336.4858-3-james.morse@arm.com>

On Thu, Jun 12, 2025 at 05:13:34PM +0000, James Morse wrote:
> acpi_count_levels() passes the number of levels back via a pointer argument.
> It also passes this to acpi_find_cache_level() as the starting_level, and
> preserves this value as it walks up the cpu_node tree counting the levels.
> 
> The only caller acpi_get_cache_info() happens to have already initialised
> levels to zero, which acpi_count_levels() depends on to get the correct
> result.
> 
> Explicitly zero the levels variable, so the count always starts at zero.
> This saves any additional callers having to work out they need to do this.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/pptt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index aaf9b5a26d07..72e6bfc1e358 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   * @cpu_node: processor node we wish to count caches for
>   * @levels: Number of levels if success.
>   * @split_levels:	Number of split cache levels (data/instruction) if
> - *			success. Can by NULL.
> + *			success. Can be NULL.
>   *
>   * Given a processor node containing a processing unit, walk into it and count
>   * how many levels exist solely for it, and then walk up each level until we hit
> @@ -196,6 +196,8 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
>  			      struct acpi_pptt_processor *cpu_node,
>  			      unsigned int *levels, unsigned int *split_levels)
>  {
> +	*levels = 0;
> +

Does it make sense to drop similar reset to 0 in acpi_get_cache_info(), just
to be consistent across all callers of acpi_count_levels().

Otherwise, LGTM:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

