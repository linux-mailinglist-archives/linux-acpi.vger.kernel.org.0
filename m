Return-Path: <linux-acpi+bounces-21134-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLMgLqzCnWnzRgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21134-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:24:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B082188F19
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 839DE303CE07
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16103A1E7E;
	Tue, 24 Feb 2026 15:22:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197014502F;
	Tue, 24 Feb 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946559; cv=none; b=ql6+BnDspNxzAeIs8meyAn06vU79aMIswB4SG/eXlExLPRStpJM0OQbGAB4jhtBJZCjUoGGTzNzeV6h+liM8EuxyH1YTdhuBe+BOtAGVhQs3ele2wQAtPBIdAYaPEpfvszSNchPZ8vrrTFpYiSwdkdIu5iEMV6SjFUilKEd9gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946559; c=relaxed/simple;
	bh=lJJG+rbmg1bthB43+VBSJv90qHClL59YAS6yfJ0ArGw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIXIMSA3NIt34kjljMhu0NciZeLr4Q6sQStqUW934Um3yQZ0thYdrhixOfChR5PnoSWWAPp1Ny27BoXYzDkdw80ih8ghoDzFwi8lYCbeJufqg1541vxsQtZsZkAxL6b87u+9m6ciadwpAaEAcAASqqNoPkIu1xPOPKuX1cL1kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL1fp4W6xzJ46g6;
	Tue, 24 Feb 2026 23:22:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 612B64056A;
	Tue, 24 Feb 2026 23:22:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 15:22:31 +0000
Date: Tue, 24 Feb 2026 15:22:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<Dmitry.Lamerov@arm.com>, <catalin.marinas@arm.com>, <bp@alien8.de>,
	<robh@kernel.org>, <rafael@kernel.org>, <will@kernel.org>,
	<conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <krzk+dt@kernel.org>, <Michael.Zhao2@arm.com>,
	<tony.luck@intel.com>, "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 01/11] ACPI: APEI: GHES: share macros via a private
 header
Message-ID: <20260224152230.00000531@huawei.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
	<20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21134-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 2B082188F19
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 13:42:19 +0000
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Carve the CPER helper macros out of ghes.c and place them in a private
> header so they can be shared with upcoming helper files. This is a
> mechanical include change with no functional differences.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
+CC Mauro as he's been doing a lot of work on error injection recently so
can probably review the use of the various structures much more easily
than I can!

My main comment is on the naming of the new header.

Jonathan


> ---
>  drivers/acpi/apei/ghes.c | 60 +-----------------------------
>  include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f96aede5d9a3..07b70bcb8342 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

>  
>  static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> new file mode 100644
> index 000000000000..2597fbadc4f3
> --- /dev/null
> +++ b/include/acpi/ghes_cper.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * APEI Generic Hardware Error Source: CPER Helper

There is other stuff in her usch as the GHES acks etc
in ghes_clear_estatus(). So I think this intro text
needs a bit more thought.  The boundary is already rather
blurred though as for example cper_estatus_len() is only
tangentially connected to cper.

> + *
> + * Copyright (C) 2026 ARM Ltd.

Doesn't make sense to ad this copyright in this patch as so far
it's cut and paste of code from a file that you didn't write (at least
not in 2026!)

Might make sense after a few patches, in which case add the copyright
when it does.

> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> + * Based on ACPI APEI GHES driver.
> + *
> + */
> +
> +#ifndef ACPI_APEI_GHES_CPER_H
> +#define ACPI_APEI_GHES_CPER_H
> +
> +#include <linux/workqueue.h>
> +
> +#include <acpi/ghes.h>
> +
> +#define GHES_PFX	"GHES: "
> +
> +#define GHES_ESTATUS_MAX_SIZE		65536
> +#define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
> +
> +#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
> +
> +/* This is just an estimation for memory pool allocation */
> +#define GHES_ESTATUS_CACHE_AVG_SIZE	512
> +
> +#define GHES_ESTATUS_CACHES_SIZE	4
> +
> +#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
> +/* Prevent too many caches are allocated because of RCU */
> +#define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
> +
> +#define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
> +	(sizeof(struct ghes_estatus_cache) + (estatus_len))
> +#define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
> +	((struct acpi_hest_generic_status *)				\
> +	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
> +
> +#define GHES_ESTATUS_NODE_LEN(estatus_len)			\
> +	(sizeof(struct ghes_estatus_node) + (estatus_len))
> +#define GHES_ESTATUS_FROM_NODE(estatus_node)			\
> +	((struct acpi_hest_generic_status *)				\
> +	 ((struct ghes_estatus_node *)(estatus_node) + 1))
> +
> +#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
> +	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
> +#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
> +	((struct acpi_hest_generic_data *)                              \
> +	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
> +
> +static inline bool is_hest_type_generic_v2(struct ghes *ghes)
> +{
> +	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> +}
> +
> +/*
> + * A platform may describe one error source for the handling of synchronous
> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
> + * or External Interrupt). On x86, the HEST notifications are always
> + * asynchronous, so only SEA on ARM is delivered as a synchronous
> + * notification.
> + */
> +static inline bool is_hest_sync_notify(struct ghes *ghes)
> +{
> +	u8 notify_type = ghes->generic->notify.type;
> +
> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
> +}
> +
> +struct ghes_vendor_record_entry {
> +	struct work_struct work;
> +	int error_severity;
> +	char vendor_record[];
> +};
> +
> +static struct ghes *ghes_new(struct acpi_hest_generic *generic);
> +static void ghes_fini(struct ghes *ghes);
> +
> +static int ghes_read_estatus(struct ghes *ghes,
> +		      struct acpi_hest_generic_status *estatus,
> +		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> +static void ghes_clear_estatus(struct ghes *ghes,
> +			struct acpi_hest_generic_status *estatus,
> +			u64 buf_paddr, enum fixed_addresses fixmap_idx);

I'm not sure some of this makes sense in a file named ghes_cper.h
Maybe we just need a different intro comment though.

> +static int __ghes_peek_estatus(struct ghes *ghes,
> +			struct acpi_hest_generic_status *estatus,
> +			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> +static int __ghes_check_estatus(struct ghes *ghes,
> +			 struct acpi_hest_generic_status *estatus);
> +static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +			u64 buf_paddr, enum fixed_addresses fixmap_idx,
> +			size_t buf_len);
> +
> +#endif /* ACPI_APEI_GHES_CPER_H */
> 


