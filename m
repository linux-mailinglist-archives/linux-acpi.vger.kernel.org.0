Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367492077E9
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbgFXPvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jun 2020 11:51:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56388 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404166AbgFXPvL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2020 11:51:11 -0400
Received: from 89-64-84-125.dynamic.chello.pl (89.64.84.125) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 75a335d69da962d9; Wed, 24 Jun 2020 17:51:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH] ACPI: avoid relocations for table signature array
Date:   Wed, 24 Jun 2020 17:51:09 +0200
Message-ID: <49808094.hYbmfjfd4k@kreacher>
In-Reply-To: <20200617082505.1159131-1-ardb@kernel.org>
References: <20200617082505.1159131-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, June 17, 2020 10:25:05 AM CEST Ard Biesheuvel wrote:
> On architectures that implement KASLR using the ELF native RELA relocation
> format (such as arm64), every absolute reference in the code incurs an
> overhead of 24 bytes in the .rela section. So storing a 41 element array
> of 4 character signature strings using an array of pointer-to-char incurs
> an 8x overhead (32 bytes per entry => ~1500 bytes), and given the fixed
> length of the entries, and the fact that the array is only used locally,
> it is much better to use an array of arrays here, which gets rid of the
> overhead entirely.
> 
> While at it, make it __initconst, as it is never referenced except from
> __init code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/tables.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 0e905c3d1645..ada36bc40c2b 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -490,7 +490,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>  }
>  
>  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> -static const char * const table_sigs[] = {
> +static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>  	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
>  	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
>  	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> @@ -501,7 +501,7 @@ static const char * const table_sigs[] = {
>  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT, NULL };
> +	ACPI_SIG_NHLT };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> @@ -548,11 +548,11 @@ void __init acpi_table_upgrade(void)
>  
>  		table = file.data;
>  
> -		for (sig = 0; table_sigs[sig]; sig++)
> +		for (sig = 0; sig < ARRAY_SIZE(table_sigs); sig++)
>  			if (!memcmp(table->signature, table_sigs[sig], 4))
>  				break;
>  
> -		if (!table_sigs[sig]) {
> +		if (sig >= ARRAY_SIZE(table_sigs)) {
>  			pr_err("ACPI OVERRIDE: Unknown signature [%s%s]\n",
>  				cpio_path, file.name);
>  			continue;
> 

Applied as 5.9 material, thanks!




