Return-Path: <linux-acpi+bounces-11123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C77BA32C58
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E161669F3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADD253340;
	Wed, 12 Feb 2025 16:49:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDD21A424;
	Wed, 12 Feb 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378985; cv=none; b=uIeAyTWsws5Kr3PVhK5Slq2w23ZO/9a+sDrw+geytFKV4sVUKZalgS1XXL4XFlu4P76ChXvm9BopqY8USAn3VckZVWWsjl3WuAzswkJJs3SOVALBONkszm3Z8LeGStA+LqzHGKEwNqb0bpn4DsNyfMfvmKWt5KOHkWiKMlW3+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378985; c=relaxed/simple;
	bh=5lBfxDqhP6i0fP0vG2l8Jug6aTKM3z+l/r4YqPVpkIg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON1ygQ+9VcpysEsftY1P05gGQKP83PKWl2Zzc0gM8OdaNXmOLUtMX55RubIUl7Gf6qTpzSnvjAMCZsS5YfPBm0wOTVYXIxzRZllaelvqK2ph5tRCotvftL6dBumavxy42BRpLedqZoqeWOCpivaGswmDPJVw4G1nR9fGY/BftAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPQL0YJ9z6K60p;
	Thu, 13 Feb 2025 00:48:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 33261140A90;
	Thu, 13 Feb 2025 00:49:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 17:49:41 +0100
Date: Wed, 12 Feb 2025 16:49:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20250212164940.00005cfb@huawei.com>
In-Reply-To: <20250210183705.1114624-7-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-7-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Feb 2025 10:37:02 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables
> EINJv2 by extending set_error_type_with_address struct.
> 
> (1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 369d92e410c1..c604aa875644 100644
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

__counted_by() marking would be a good addition.

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


