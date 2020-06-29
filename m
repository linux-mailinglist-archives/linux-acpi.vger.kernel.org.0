Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A9C20E19B
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jun 2020 23:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgF2U5u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Jun 2020 16:57:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730558AbgF2U5R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Jun 2020 16:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593464234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXQKyufgPXhUo0Jq6KgGlFhHy0UGyfCM3CWYr/sTDJY=;
        b=SuD/PcW6xwZ3jaOtAkadBh4ClIhk7uL/VbvJc0kArVZRDY6Sn0W5nowRpjbzrcKzARS+4C
        OslIJnAofrQhNu6ABFgRnE3rU+NUtO2ebMRyjsKFgXtApcUQlgKH6iLBXAJMHSrM40N/S4
        JuoIU7zPTHCdNKUDyRLSf54oCPorCVg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-sYiDLRMtPESnTNMiEakF6w-1; Mon, 29 Jun 2020 16:57:11 -0400
X-MC-Unique: sYiDLRMtPESnTNMiEakF6w-1
Received: by mail-oo1-f72.google.com with SMTP id j13so257081ooe.22
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 13:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXQKyufgPXhUo0Jq6KgGlFhHy0UGyfCM3CWYr/sTDJY=;
        b=MscYgLTm3v8rDH7u+XyPNGdwj2QeOCbGUWHeKDvEiJJ8AIQEGRkCMuSzZffzk2/ul9
         dznpbmpLrneyVc347NboUakJpFrq2Hq+nLWNvUqF9P+aww8ILnBcWIfantttPb3m7N5E
         LUTTfxmQh96mtRRqrFh6RT6w9AXe0Jf5QYIR8pUDXLRqRN1sd4G1nqeHuMSxlph3fu6Q
         moHSDwlpedrEsr/WrRNG5HExLw+MUs2RoRO0U6S537/13Wb897fBkxiq3YBV5aodQInH
         FD6el7XY3V8ed3BUAx3PUswnyKVwLZ1vn0BCPfz7o7pOkY05fjtRYCXpzL+Mnp0043pI
         S9ig==
X-Gm-Message-State: AOAM5300s9oqNSdCybdFLH3iUfYgGBfWsigH6v5/M8duapqmNpOeEwzu
        /4bZODiCOjR/sJy4kGDRwy7jIyNx4ygiqNw2iJg1loKn32atTrAxkI0lU97Xt9UZW4hNf1K5jNn
        pRK9WUkjSgHwSFI7kUnz49w==
X-Received: by 2002:aca:4d11:: with SMTP id a17mr4409703oib.93.1593464230007;
        Mon, 29 Jun 2020 13:57:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy50dTvP8getMLG9WKIZFKpGpouEipqrXwVaD5gR2GF1XOftPXBRyPQOyrnXYhVsmxqF0/wA==
X-Received: by 2002:aca:4d11:: with SMTP id a17mr4409684oib.93.1593464229695;
        Mon, 29 Jun 2020 13:57:09 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id n128sm193358oih.33.2020.06.29.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:57:09 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:57:08 -0600
From:   Al Stone <ahs3@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Message-ID: <20200629205708.GK1237914@redhat.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher>
 <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794490.F2OrUDcHQn@kreacher>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 29 Jun 2020 18:33, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPICA's strategy with respect to the handling of memory mappings
> associated with memory operation regions is to avoid mapping the
> entire region at once which may be problematic at least in principle
> (for example, it may lead to conflicts with overlapping mappings
> having different attributes created by drivers).  It may also be
> wasteful, because memory opregions on some systems take up vast
> chunks of address space while the fields in those regions actually
> accessed by AML are sparsely distributed.
> 
> For this reason, a one-page "window" is mapped for a given opregion
> on the first memory access through it and if that "window" does not
> cover an address range accessed through that opregion subsequently,
> it is unmapped and a new "window" is mapped to replace it.  Next,
> if the new "window" is not sufficient to acess memory through the
> opregion in question in the future, it will be replaced with yet
> another "window" and so on.  That may lead to a suboptimal sequence
> of memory mapping and unmapping operations, for example if two fields
> in one opregion separated from each other by a sufficiently wide
> chunk of unused address space are accessed in an alternating pattern.
> 
> The situation may still be suboptimal if the deferred unmapping
> introduced previously is supported by the OS layer.  For instance,
> the alternating memory access pattern mentioned above may produce
> a relatively long list of mappings to release with substantial
> duplication among the entries in it, which could be avoided if
> acpi_ex_system_memory_space_handler() did not release the mapping
> used by it previously as soon as the current access was not covered
> by it.
> 
> In order to improve that, modify acpi_ex_system_memory_space_handler()
> to preserve all of the memory mappings created by it until the memory
> regions associated with them go away.
> 
> Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> memory associated with memory opregions that go away.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evrgnini.c | 14 ++++----
>  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
>  include/acpi/actypes.h         | 12 +++++--
>  3 files changed, 64 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> index aefc0145e583..89be3ccdad53 100644
> --- a/drivers/acpi/acpica/evrgnini.c
> +++ b/drivers/acpi/acpica/evrgnini.c
> @@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
>  	union acpi_operand_object *region_desc =
>  	    (union acpi_operand_object *)handle;
>  	struct acpi_mem_space_context *local_region_context;
> +	struct acpi_mem_mapping *mm;
>  
>  	ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
>  
> @@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
>  			local_region_context =
>  			    (struct acpi_mem_space_context *)*region_context;
>  
> -			/* Delete a cached mapping if present */
> +			/* Delete memory mappings if present */
>  
> -			if (local_region_context->mapped_length) {
> -				acpi_os_unmap_memory(local_region_context->
> -						     mapped_logical_address,
> -						     local_region_context->
> -						     mapped_length);
> +			while (local_region_context->first_mm) {
> +				mm = local_region_context->first_mm;
> +				local_region_context->first_mm = mm->next_mm;
> +				acpi_os_unmap_memory(mm->logical_address,
> +						     mm->length);
> +				ACPI_FREE(mm);
>  			}
>  			ACPI_FREE(local_region_context);
>  			*region_context = NULL;
> diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> index d15a66de26c0..fd68f2134804 100644
> --- a/drivers/acpi/acpica/exregion.c
> +++ b/drivers/acpi/acpica/exregion.c
> @@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
>  	acpi_status status = AE_OK;
>  	void *logical_addr_ptr = NULL;
>  	struct acpi_mem_space_context *mem_info = region_context;
> +	struct acpi_mem_mapping *mm = mem_info->cur_mm;
>  	u32 length;
>  	acpi_size map_length;

I think this needs to be:

        acpi_size map_length = mem_info->length;

since it now gets used in the ACPI_ERROR() call below.  I'm getting
a "maybe used unitialized" error on compilation.

>  	acpi_size page_boundary_map_length;
> @@ -96,20 +97,38 @@ acpi_ex_system_memory_space_handler(u32 function,
>  	 * Is 1) Address below the current mapping? OR
>  	 *    2) Address beyond the current mapping?
>  	 */
> -	if ((address < mem_info->mapped_physical_address) ||
> -	    (((u64) address + length) > ((u64)
> -					 mem_info->mapped_physical_address +
> -					 mem_info->mapped_length))) {
> +	if (!mm || (address < mm->physical_address) ||
> +	    ((u64) address + length > (u64) mm->physical_address + mm->length)) {
>  		/*
> -		 * The request cannot be resolved by the current memory mapping;
> -		 * Delete the existing mapping and create a new one.
> +		 * The request cannot be resolved by the current memory mapping.
> +		 *
> +		 * Look for an existing saved mapping covering the address range
> +		 * at hand.  If found, save it as the current one and carry out
> +		 * the access.
>  		 */
> -		if (mem_info->mapped_length) {
> +		for (mm = mem_info->first_mm; mm; mm = mm->next_mm) {
> +			if (mm == mem_info->cur_mm)
> +				continue;
> +
> +			if (address < mm->physical_address)
> +				continue;
> +
> +			if ((u64) address + length >
> +					(u64) mm->physical_address + mm->length)
> +				continue;
>  
> -			/* Valid mapping, delete it */
> +			mem_info->cur_mm = mm;
> +			goto access;
> +		}
>  
> -			acpi_os_unmap_memory(mem_info->mapped_logical_address,
> -					     mem_info->mapped_length);
> +		/* Create a new mappings list entry */
> +		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
> +		if (!mm) {
> +			ACPI_ERROR((AE_INFO,
> +				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
> +				    ACPI_FORMAT_UINT64(address),
> +				    (u32)map_length));
> +			return_ACPI_STATUS(AE_NO_MEMORY);
>  		}
>  
>  		/*
> @@ -143,29 +162,39 @@ acpi_ex_system_memory_space_handler(u32 function,
>  
>  		/* Create a new mapping starting at the address given */
>  
> -		mem_info->mapped_logical_address =
> -		    acpi_os_map_memory(address, map_length);
> -		if (!mem_info->mapped_logical_address) {
> +		logical_addr_ptr = acpi_os_map_memory(address, map_length);
> +		if (!logical_addr_ptr) {
>  			ACPI_ERROR((AE_INFO,
>  				    "Could not map memory at 0x%8.8X%8.8X, size %u",
>  				    ACPI_FORMAT_UINT64(address),
>  				    (u32)map_length));
> -			mem_info->mapped_length = 0;
> +			ACPI_FREE(mm);
>  			return_ACPI_STATUS(AE_NO_MEMORY);
>  		}
>  
>  		/* Save the physical address and mapping size */
>  
> -		mem_info->mapped_physical_address = address;
> -		mem_info->mapped_length = map_length;
> +		mm->logical_address = logical_addr_ptr;
> +		mm->physical_address = address;
> +		mm->length = map_length;
> +
> +		/*
> +		 * Add the new entry to the mappigs list and save it as the
> +		 * current mapping.
> +		 */
> +		mm->next_mm = mem_info->first_mm;
> +		mem_info->first_mm = mm;
> +
> +		mem_info->cur_mm = mm;
>  	}
>  
> +access:
>  	/*
>  	 * Generate a logical pointer corresponding to the address we want to
>  	 * access
>  	 */
> -	logical_addr_ptr = mem_info->mapped_logical_address +
> -	    ((u64) address - (u64) mem_info->mapped_physical_address);
> +	logical_addr_ptr = mm->logical_address +
> +		((u64) address - (u64) mm->physical_address);
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "System-Memory (width %u) R/W %u Address=%8.8X%8.8X\n",
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index aa236b9e6f24..d005e35ab399 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1201,12 +1201,18 @@ struct acpi_pci_id {
>  	u16 function;
>  };
>  
> +struct acpi_mem_mapping {
> +	acpi_physical_address physical_address;
> +	u8 *logical_address;
> +	acpi_size length;
> +	struct acpi_mem_mapping *next_mm;
> +};
> +
>  struct acpi_mem_space_context {
>  	u32 length;
>  	acpi_physical_address address;
> -	acpi_physical_address mapped_physical_address;
> -	u8 *mapped_logical_address;
> -	acpi_size mapped_length;
> +	struct acpi_mem_mapping *cur_mm;
> +	struct acpi_mem_mapping *first_mm;
>  };
>  
>  /*
> -- 
> 2.26.2
> 
> 
> 
> 

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

