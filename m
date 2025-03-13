Return-Path: <linux-acpi+bounces-12174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E10A5EFCC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4793F17D495
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E92264607;
	Thu, 13 Mar 2025 09:42:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352414900B;
	Thu, 13 Mar 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858957; cv=none; b=VJ+faQ2rvnFWCSrvMzxn9Jc7OkE8cdZLXFmDax1xN83NW9FZMQjjG+I+gt15A9ja4dUShjJRAk5oKxBbcjLmh2WiykV3ijZw0KdLRuZjuDx143bj7p+cn8XJGKz0exlFYHlpY3mCP7EzfJgAHNHyVIiRvkEViI+pFF+BbhnDXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858957; c=relaxed/simple;
	bh=qZ5vfvpUrKsLdGPtkFTdyXDmyZok76YvHsEQ6mib4gQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2P/NLws6TAU5aaJSqcpQLZcrcOt597PDHRr0flKAjWcw3X3/gq/0lBtD5uEckkCRCxPHaTN9u8tqcPFT/ao07Ez8Dpsu/Arfkjf6+O242OPxuHFeo6c7/RYPS7qiBfQ4OJcviDmwGxSrOWRxgLvwTfEgpFGTR4vkCkO78za0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2Wv3pCKz6H8g6;
	Thu, 13 Mar 2025 17:39:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 139F9140D26;
	Thu, 13 Mar 2025 17:42:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:42:32 +0100
Date: Thu, 13 Mar 2025 09:42:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20250313094230.00004696@huawei.com>
In-Reply-To: <20250306234810.75511-7-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-7-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:48:07 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables
> EINJv2 by extending set_error_type_with_address struct.
> 
> (1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
Still seems to be down.
Also, we have tag for this.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4615 # [1]


One additional request inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index aee9a7b17313..32b8d102f399 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -50,6 +50,28 @@
>   */
>  static int acpi5;
>  
> +struct syndrome_array {
> +	union {
> +		u32	acpi_id;
> +		u32	device_id;
> +		u32	pcie_sbdf;
> +		u8	vendor_id[16];
> +	} comp_id;
> +	union {
> +		u32	proc_synd;
> +		u32	mem_synd;
> +		u32	pcie_synd;
> +		u8	vendor_synd[16];
> +	} comp_synd;
> +};
> +
> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[];

__counted_by(component_arr_count);
should be fine and marking these is always good to do in
new code (and old code if you have time!)


> +};
> +
>  struct set_error_type_with_address {
>  	u32	type;
>  	u32	vendor_extension;
> @@ -58,6 +80,7 @@ struct set_error_type_with_address {
>  	u64	memory_address;
>  	u64	memory_address_range;
>  	u32	pcie_sbdf;
> +	struct	einjv2_extension_struct einjv2_struct;
>  };
>  enum {
>  	SETWA_FLAGS_APICID = 1,


