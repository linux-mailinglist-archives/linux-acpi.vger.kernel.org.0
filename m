Return-Path: <linux-acpi+bounces-16569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A00B51352
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3B83B1DB9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48A3115B8;
	Wed, 10 Sep 2025 09:57:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9225771;
	Wed, 10 Sep 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498258; cv=none; b=nhbrt02EHlAfIpEvuw/no/rNQZXXjQMG18jY1XYGb73TTDMUmNJTrTxOB8MvTlLRShUnOmSYiKYsh/n/w3UwcwvPIcCO+/4yGoiArWUz80E/xog7cqQkI3U2XWLI+Idl5mkYlOqIQJa1j00GVXLTvVxKvnvYQ2sqh3ja7Pc//xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498258; c=relaxed/simple;
	bh=oKEInT9r79tnnynoCx5h3GSPajAEItwq/hRBflYvKik=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9qf+yiSMtGTjUxw5IakmaTwv6+c2yBsS6lpoFK8NeIDznDIkzNAl1RdO1rDlXm4ldSWDEudnzjmRtWlR0dqvN4Ulz6gTZM7XvZ1mBsRF20FzLEYcSSZthEM7+8Z3ZHyYsQe6KZ6kH5oW7sJ3bhd93bPX0xpuzD6x6iDd9nEibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMGJF14mYz6LDB2;
	Wed, 10 Sep 2025 17:54:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E2D01400C8;
	Wed, 10 Sep 2025 17:57:31 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 11:57:30 +0200
Date: Wed, 10 Sep 2025 10:57:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<andrew@kernel.org>, <bfaccini@nvidia.com>, <eahariha@linux.microsoft.com>,
	<dan.j.williams@intel.com>, <thorsten.blum@linux.dev>, <gourry@gourry.net>,
	<nunodasneves@linux.microsoft.com>, <wangyuquan1236@phytium.com.cn>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
Message-ID: <20250910105729.000070a5@huawei.com>
In-Reply-To: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
References: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 17:39:49 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> The Generic Initiator Affinity Structure in SRAT table uses device
> handle type field to indicate the device type. According to ACPI
> specification, the device handle type value of 1 represents PCI device,
> not 0.
> 
> Fix this by defining explicit macros for device handle types and using
> the correct check for PCI devices:
> 
> - ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
> - ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle
> 
> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

The actbl3.h additions need to go through acpcia and then have a link
tag in here to show that it was merged.  Perhaps just fix it with a number
for now and follow up with the acpcia stuff in the longer run?

Also note clearly this only affects a debug print - no functional bug.
That may change whether people choose to backport this or not.

I'm curious on whether you are thinking of wiring this up so that
we can set the appropriate nodes on PCI Devices other than by doing it
with _PXM().  For obscure reasons there can be references both ways
(so DSDT Device entry -> SRAT via _PXM, and SRAT -> Device via this field
of generic initiators).

For now we only implement the first one so all we need is a node to be
instantiated for the GI to sit in.

Come to think of it the fix that made PCI device entries in DSDT with _PXM
turn up in the right place was reverted (for a problem with broken firmware
on AMD threadripper systems - IIRC that I think is long solved).
Not sure if that path even works today and the one this code is about has
never been hooked up.

Thanks for the fix!

Jonathan


> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  include/acpi/actbl3.h    | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 53816dfab645..de71b370a275 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -237,7 +237,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		struct acpi_srat_generic_affinity *p =
>  			(struct acpi_srat_generic_affinity *)header;
>  
> -		if (p->device_handle_type == 0) {
> +		if (p->device_handle_type == ACPI_SRAT_PCI_DEVICE_HANDLE) {
>  			/*
>  			 * For pci devices this may be the only place they
>  			 * are assigned a proximity domain
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 79d3aa5a4bad..c8488614429c 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -284,6 +284,9 @@ struct acpi_srat_gic_its_affinity {
>   * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
>   */
>  
> +#define ACPI_SRAT_APCI_DEVICE_HANDLE	(0)
> +#define ACPI_SRAT_PCI_DEVICE_HANDLE	(1)
> +
>  #define ACPI_SRAT_DEVICE_HANDLE_SIZE	16
>  
>  struct acpi_srat_generic_affinity {


