Return-Path: <linux-acpi+bounces-21136-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEo8LQfGnWkRSAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21136-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:38:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00897189286
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD5931AE9B9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545A27380A;
	Tue, 24 Feb 2026 15:32:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47539265CC2;
	Tue, 24 Feb 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947147; cv=none; b=hOWSXxjWMfqdNOYaPSBU/6iJyyfIV6fcUSNE4+oimYfT6z/2bYJHkdop5lLL1jO1yiv1kbTMQhJip02mQhd8rsH5CrbGCrMXh3CL/79W1GrufmI/0KGw6F3wq4G40rJZt9E+CztjikwyWq47ursi+MxTsTmJoKxrn3YmKsyarAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947147; c=relaxed/simple;
	bh=IShJhdM+xp3ZVYybHW8Mai7SLBuCyHk3MNaRzPIauG4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbX5ORt0pyF/X5BNqlERfVPDYtCIuY299XkKxCajRxtS6BxsADgYoNeZZ4GHFjwjVzsJGaUkiKCnISu/73lvyET9ANuRR+TOHm2HOC8UsQce/xPSmwdSaimmh7Wmb9kzovTN0zcD0Sec4hflgxCRXoRizfQS4a/+rHqMF0hDty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL1tB2VYdzJ46Bq;
	Tue, 24 Feb 2026 23:32:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1ED894056A;
	Tue, 24 Feb 2026 23:32:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 15:32:23 +0000
Date: Tue, 24 Feb 2026 15:32:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<Dmitry.Lamerov@arm.com>, <catalin.marinas@arm.com>, <bp@alien8.de>,
	<robh@kernel.org>, <rafael@kernel.org>, <will@kernel.org>,
	<conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <krzk+dt@kernel.org>, <Michael.Zhao2@arm.com>,
	<tony.luck@intel.com>
Subject: Re: [PATCH v2 03/11] ACPI: APEI: GHES: move CPER read helpers
Message-ID: <20260224153221.00000420@huawei.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
	<20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21136-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 00897189286
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 13:42:21 +0000
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
> ghes_cper.c so they can be shared with other firmware-first providers.
> This commit only shuffles code; behavior stays the same.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
Hi Ahmed,

Most of the comments in here are about changing the patch break up.
Basic suggest approach is move stuff as it is needed, not in advance of
that need.  So when you move the function to the c file, only then add what
it needs to the includes / header.

Jonathan

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 63047322a3d9..7e0015e960c1 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   *
> - * APEI GHES CPER helper translation unit - staging file for helper moves
> + * APEI GHES CPER helper translation unit - code mechanically moved from ghes.c

In the long run, no interest in where it came from. People can
look at the git history for that. 

>   *
>   * Copyright (C) 2026 ARM Ltd.
>   * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> @@ -17,10 +17,176 @@
>  #include <linux/slab.h>
>  
>  #include <acpi/apei.h>
> +#include <acpi/ghes_cper.h>
>  
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
>  
>  #include "apei-internal.h"
>  
> -/* Helper bodies will be moved here in follow-up commits. */

If you just do the file creation with this first move, then we don't get churn of
comments like this one.

> +/* Read the CPER block, returning its address, and header in estatus. */
> +int __ghes_peek_estatus(struct ghes *ghes,
> +			       struct acpi_hest_generic_status *estatus,
> +			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
> +{
> +	struct acpi_hest_generic *g = ghes->generic;
> +	int rc;
> +
> +	rc = apei_read(buf_paddr, &g->error_status_address);
> +	if (rc) {
> +		*buf_paddr = 0;
> +		pr_warn_ratelimited(FW_WARN GHES_PFX
> +"Failed to read error status block address for hardware error source: %d.\n",

Unusual indenting.  I'd just fix that whilst you are here. Don't worry about long line.

> +				   g->header.source_id);
> +		return -EIO;

> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index 2597fbadc4f3..2e3919f0c3e7 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -74,21 +74,21 @@ struct ghes_vendor_record_entry {
>  	char vendor_record[];
>  };
>  
> -static struct ghes *ghes_new(struct acpi_hest_generic *generic);
Huh. Static forward declarations in a header?  That never made sense. Fix it in the
earlier patch and remove the statics from the declarations.

Actually no, just bring them into the header only when you need to. So as part
of the patch that moves the caller or the function.



> -static void ghes_fini(struct ghes *ghes);
> +struct ghes *ghes_new(struct acpi_hest_generic *generic);
> +void ghes_fini(struct ghes *ghes);
>  
> -static int ghes_read_estatus(struct ghes *ghes,
> +int ghes_read_estatus(struct ghes *ghes,
>  		      struct acpi_hest_generic_status *estatus,
>  		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> -static void ghes_clear_estatus(struct ghes *ghes,
> +void ghes_clear_estatus(struct ghes *ghes,
>  			struct acpi_hest_generic_status *estatus,
>  			u64 buf_paddr, enum fixed_addresses fixmap_idx);
> -static int __ghes_peek_estatus(struct ghes *ghes,
> +int __ghes_peek_estatus(struct ghes *ghes,
>  			struct acpi_hest_generic_status *estatus,
>  			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> -static int __ghes_check_estatus(struct ghes *ghes,
> +int __ghes_check_estatus(struct ghes *ghes,
>  			 struct acpi_hest_generic_status *estatus);
> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>  			u64 buf_paddr, enum fixed_addresses fixmap_idx,
>  			size_t buf_len);
>  
> 


