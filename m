Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3705700B7D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjELPZU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbjELPZS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 11:25:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18844A9;
        Fri, 12 May 2023 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905102; x=1715441102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q1sW1Gz2U/5Ne/jJ8Cs4K614LHklur6Wpp/rErAHYPU=;
  b=myWnPIoe2Gdgp5NAaQg6OUTg/xSxJp4eHalXyyYaDXWVRxpIgujSb98X
   zdriTFfN+5Ty3ssCx8T6h42R6V4utBfVmCmQ7Aj+ly6ZoblRu5bNvgCMO
   I2VwRb8v1PMjjGCcTeODfGcR96CCi228dQFB63W/6/X2kq/D1uKl91jzA
   81xcqGJD3SFxBwyLn1+ANtNaIWs1qVROJx3GL0zuIRYG//LadInOOgJJq
   Oq61E79niPwxyvjp3xLbe8ihvmca52dqQZN59IyCFAkMrj/oDI8THAUzs
   y1GKRjrsFvHb2glNd3WXxblRvt3fco2V6JF70uFB/nKq1t5urOgcOsMWv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="340129345"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="340129345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874424894"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874424894"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.160.55]) ([10.213.160.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:24:21 -0700
Message-ID: <ab1adb89-5f4c-08f0-8f3b-8f33cfebaa48@intel.com>
Date:   Fri, 12 May 2023 08:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] acpi: tables: Add CDAT table parsing support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
 <168330797672.2042604.12339416734589446371.stgit@djiang5-mobl3>
 <20230512125831.00000eb0@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230512125831.00000eb0@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/12/23 4:58 AM, Jonathan Cameron wrote:
> On Fri, 05 May 2023 10:32:56 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The CDAT table is very similar to ACPI tables when it comes to sub-table
>> and entry structures. The helper functions can be also used to parse the
>> CDAT table. Add support to the helper functions to deal with an external
>> CDAT table, and also handle the endieness since CDAT can be processed by a
>> BE host. Export a function acpi_table_parse_cdat() for CXL driver to parse
>> a CDAT table.
>>
>> In order to minimize ACPI code changes, __force is being utilized to deal
>> with the case of a big endien (BE) host parsing a CDAT. All CDAT data
>> structure variables are being force casted to __leX as appropriate.
> 
> Hi Dave,
> 
> This falls into the annoyance that CDAT doesn't have a standard table header.
> Whilst I understand that was done deliberately it means some odd things happen
> in this code.
> 
> Just how bad is the duplication if we don't do this at all, but instead roll
> a version for CDAT that doesn't force things through pointers of the wrong types?

130 lines I believe.
https://lore.kernel.org/linux-cxl/168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3/

Dan, can we please make a decision on which way we want to go with this?

> 
> Otherwise, maybe we need some unions so that the type mashups don't happen.
> 
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/acpi/tables.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
>>   include/acpi/actbl1.h |    3 +++
>>   include/linux/acpi.h  |    4 ++++
>>   3 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 7b4680da57d7..08486f6df442 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -42,6 +42,7 @@ enum acpi_subtable_type {
>>   	ACPI_SUBTABLE_HMAT,
>>   	ACPI_SUBTABLE_PRMT,
>>   	ACPI_SUBTABLE_CEDT,
>> +	ACPI_SUBTABLE_CDAT,
>>   };
>>   
>>   struct acpi_subtable_entry {
>> @@ -239,6 +240,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
>>   		return 0;
>>   	case ACPI_SUBTABLE_CEDT:
>>   		return entry->hdr->cedt.type;
>> +	case ACPI_SUBTABLE_CDAT:
>> +		return entry->hdr->cdat.type;
>>   	}
>>   	return 0;
>>   }
>> @@ -255,6 +258,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
>>   		return entry->hdr->prmt.length;
>>   	case ACPI_SUBTABLE_CEDT:
>>   		return entry->hdr->cedt.length;
>> +	case ACPI_SUBTABLE_CDAT:
>> +		return le16_to_cpu((__force __le16)entry->hdr->cdat.length);
>>   	}
>>   	return 0;
>>   }
>> @@ -271,6 +276,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
>>   		return sizeof(entry->hdr->prmt);
>>   	case ACPI_SUBTABLE_CEDT:
>>   		return sizeof(entry->hdr->cedt);
>> +	case ACPI_SUBTABLE_CDAT:
>> +		return sizeof(entry->hdr->cdat);
>>   	}
>>   	return 0;
>>   }
>> @@ -284,9 +291,22 @@ acpi_get_subtable_type(char *id)
>>   		return ACPI_SUBTABLE_PRMT;
>>   	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
>>   		return ACPI_SUBTABLE_CEDT;
>> +	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
>> +		return ACPI_SUBTABLE_CDAT;
> 
> I'm not super keen on inventing a SIG when the CDAT 'table'
> doesn't actually have one.

I wasn't sure how else to deal with this. Additional parameter to 
indicate it's CDAT?

> 
>>   	return ACPI_SUBTABLE_COMMON;
>>   }
>>   
>> +static unsigned long __init_or_acpilib
>> +acpi_table_get_length(enum acpi_subtable_type type,
>> +		      struct acpi_table_header *hdr)
> 
> I don't like parsing in an acpi_table_header type here when it may not be one.
> I think this length decision needs to be pushed up a level to where we can see
> if we have a CDAT table or not.

You mean have the caller pass in the table size directly?

> 
> 
>> +{
>> +	if (type == ACPI_SUBTABLE_CDAT)
>> +		return le32_to_cpu(
>> +			(__force __le32)((struct acpi_table_cdat *)hdr)->length);
> 
> Perhaps a local variable in here somewhere would make it more readable.
> 	__le32 length = (__force__le32)((struct acpi_table_cdat *)hdr)->length;
> 
> 	return le32_to_cpu(length)?
> 
> 
>> +
>> +	return hdr->length;
>> +}
>> +
>>   static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
>>   {
>>   	return proc->handler || proc->handler_arg;
>> @@ -332,16 +352,19 @@ static int __init_or_acpilib acpi_parse_entries_array(
>>   	int proc_num, unsigned int max_entries)
>>   {
>>   	struct acpi_subtable_entry entry;
>> +	enum acpi_subtable_type type;
>>   	unsigned long table_end, subtable_len, entry_len;
>>   	int count = 0;
>>   	int errs = 0;
>>   	int i;
>>   
>> -	table_end = (unsigned long)table_header + table_header->length;
>> +	type = acpi_get_subtable_type(id);
>> +	table_end = (unsigned long)table_header +
>> +		    acpi_table_get_length(type, table_header);
> As above, I don't like carrying CDAT which doesn't have an acpi_table_header
> section around as that type of pointer.
> 
>>   
>>   	/* Parse all entries looking for a match. */
>>   
>> -	entry.type = acpi_get_subtable_type(id);
>> +	entry.type = type;
>>   	entry.hdr = (union acpi_subtable_headers *)
>>   	    ((unsigned long)table_header + table_size);
>>   	subtable_len = acpi_get_subtable_header_length(&entry);
>> @@ -464,6 +487,26 @@ int __init acpi_table_parse_madt(enum acpi_madt_type id,
>>   					    handler, max_entries);
>>   }
>>   
>> +int acpi_table_parse_cdat(enum acpi_cdat_type type,
>> +			  acpi_tbl_entry_handler_arg handler_arg, void *arg,
>> +			  struct acpi_table_cdat *table_header)
>> +{
>> +	struct acpi_subtable_proc proc = {
>> +		.id		= type,
>> +		.handler_arg	= handler_arg,
>> +		.arg		= arg,
>> +	};
>> +
>> +	if (!table_header)
>> +		return -EINVAL;
>> +
>> +	return acpi_parse_entries_array(ACPI_SIG_CDAT,
>> +			sizeof(struct acpi_table_cdat),
>> +			(struct acpi_table_header *)table_header,
>> +			&proc, 1, 0);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(acpi_table_parse_cdat, CXL);
>> +
>>   /**
>>    * acpi_table_parse - find table with @id, run @handler on it
>>    * @id: table id to find
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 81b9e794424d..3119be093cfe 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -66,6 +66,9 @@
>>   #define ACPI_SIG_IEIT           "IEIT"
>>   #endif
>>   
>> +/* External to ACPI */
>> +#define ACPI_SIG_CDAT		"CDAT" /* Coherent Device Attribute Table */
> 
> Worse that that, fictional signature :)
> It's the nameof the 'table', but it's not a signature as it's never
> used as they are in ACPI and doesn't appear anywhere in the table.
> 
>> +
>>   /*
>>    * All tables must be byte-packed to match the ACPI specification, since
>>    * the tables are provided by the system BIOS.
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index efff750f326d..4c3dfe7587e9 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -135,6 +135,7 @@ union acpi_subtable_headers {
>>   	struct acpi_hmat_structure hmat;
>>   	struct acpi_prmt_module_header prmt;
>>   	struct acpi_cedt_header cedt;
>> +	struct acpi_cdat_header cdat;
>>   };
>>   
>>   typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
>> @@ -266,6 +267,9 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
>>   
>>   int acpi_parse_mcfg (struct acpi_table_header *header);
>>   void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>> +int acpi_table_parse_cdat(enum acpi_cdat_type type,
>> +			  acpi_tbl_entry_handler_arg handler, void *arg,
>> +			  struct acpi_table_cdat *table_header);
> How did we end up with an 'acpi_' table that isn't in ACPI?
> (I'm not looking as I fear I might be responsible :)

git blame says Bob. You are off the hook. :)

> Should perhaps consider renaming all the CDAT entries so it doesn't looks like they
> are.

Sure I can do that.

> 
>>   
>>   /* the following numa functions are architecture-dependent */
>>   void acpi_numa_slit_init (struct acpi_table_slit *slit);
>>
>>
>>
> 
