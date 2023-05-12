Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3089B700D68
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjELQxC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjELQxB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:53:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749AA5CA;
        Fri, 12 May 2023 09:52:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvtv2955z67qpZ;
        Sat, 13 May 2023 00:52:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:52:56 +0100
Date:   Fri, 12 May 2023 17:52:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 1/4] acpi: tables: Add CDAT table parsing support
Message-ID: <20230512175255.0000229e@Huawei.com>
In-Reply-To: <ab1adb89-5f4c-08f0-8f3b-8f33cfebaa48@intel.com>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
        <168330797672.2042604.12339416734589446371.stgit@djiang5-mobl3>
        <20230512125831.00000eb0@Huawei.com>
        <ab1adb89-5f4c-08f0-8f3b-8f33cfebaa48@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 12 May 2023 08:24:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/12/23 4:58 AM, Jonathan Cameron wrote:
> > On Fri, 05 May 2023 10:32:56 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> The CDAT table is very similar to ACPI tables when it comes to sub-table
> >> and entry structures. The helper functions can be also used to parse the
> >> CDAT table. Add support to the helper functions to deal with an external
> >> CDAT table, and also handle the endieness since CDAT can be processed by a
> >> BE host. Export a function acpi_table_parse_cdat() for CXL driver to parse
> >> a CDAT table.
> >>
> >> In order to minimize ACPI code changes, __force is being utilized to deal
> >> with the case of a big endien (BE) host parsing a CDAT. All CDAT data
> >> structure variables are being force casted to __leX as appropriate.  
> > 
> > Hi Dave,
> > 
> > This falls into the annoyance that CDAT doesn't have a standard table header.
> > Whilst I understand that was done deliberately it means some odd things happen
> > in this code.
> > 
> > Just how bad is the duplication if we don't do this at all, but instead roll
> > a version for CDAT that doesn't force things through pointers of the wrong types?  
> 
> 130 lines I believe.
> https://lore.kernel.org/linux-cxl/168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3/
> 
> Dan, can we please make a decision on which way we want to go with this?
> 
> > 
> > Otherwise, maybe we need some unions so that the type mashups don't happen.
> >   
> >>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   drivers/acpi/tables.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>   include/acpi/actbl1.h |    3 +++
> >>   include/linux/acpi.h  |    4 ++++
> >>   3 files changed, 52 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> >> index 7b4680da57d7..08486f6df442 100644
> >> --- a/drivers/acpi/tables.c
> >> +++ b/drivers/acpi/tables.c
> >> @@ -42,6 +42,7 @@ enum acpi_subtable_type {
> >>   	ACPI_SUBTABLE_HMAT,
> >>   	ACPI_SUBTABLE_PRMT,
> >>   	ACPI_SUBTABLE_CEDT,
> >> +	ACPI_SUBTABLE_CDAT,
> >>   };
> >>   
> >>   struct acpi_subtable_entry {
> >> @@ -239,6 +240,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
> >>   		return 0;
> >>   	case ACPI_SUBTABLE_CEDT:
> >>   		return entry->hdr->cedt.type;
> >> +	case ACPI_SUBTABLE_CDAT:
> >> +		return entry->hdr->cdat.type;
> >>   	}
> >>   	return 0;
> >>   }
> >> @@ -255,6 +258,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
> >>   		return entry->hdr->prmt.length;
> >>   	case ACPI_SUBTABLE_CEDT:
> >>   		return entry->hdr->cedt.length;
> >> +	case ACPI_SUBTABLE_CDAT:
> >> +		return le16_to_cpu((__force __le16)entry->hdr->cdat.length);
> >>   	}
> >>   	return 0;
> >>   }
> >> @@ -271,6 +276,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
> >>   		return sizeof(entry->hdr->prmt);
> >>   	case ACPI_SUBTABLE_CEDT:
> >>   		return sizeof(entry->hdr->cedt);
> >> +	case ACPI_SUBTABLE_CDAT:
> >> +		return sizeof(entry->hdr->cdat);
> >>   	}
> >>   	return 0;
> >>   }
> >> @@ -284,9 +291,22 @@ acpi_get_subtable_type(char *id)
> >>   		return ACPI_SUBTABLE_PRMT;
> >>   	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
> >>   		return ACPI_SUBTABLE_CEDT;
> >> +	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
> >> +		return ACPI_SUBTABLE_CDAT;  
> > 
> > I'm not super keen on inventing a SIG when the CDAT 'table'
> > doesn't actually have one.  
> 
> I wasn't sure how else to deal with this. Additional parameter to 
> indicate it's CDAT?

No idea. I poke holes, not provide solutions (well not on Friday at
going home time anyway) :)

> 
> >   
> >>   	return ACPI_SUBTABLE_COMMON;
> >>   }
> >>   
> >> +static unsigned long __init_or_acpilib
> >> +acpi_table_get_length(enum acpi_subtable_type type,
> >> +		      struct acpi_table_header *hdr)  
> > 
> > I don't like parsing in an acpi_table_header type here when it may not be one.
> > I think this length decision needs to be pushed up a level to where we can see
> > if we have a CDAT table or not.  
> 
> You mean have the caller pass in the table size directly?
> 
Ah, I wrongly thought the acpi_table_header was assigned one function up
but nope, its' many layers above. 

union maybe?

> > 
> >   
> >> +{
> >> +	if (type == ACPI_SUBTABLE_CDAT)
> >> +		return le32_to_cpu(
> >> +			(__force __le32)((struct acpi_table_cdat *)hdr)->length);  
> > 
> > Perhaps a local variable in here somewhere would make it more readable.
> > 	__le32 length = (__force__le32)((struct acpi_table_cdat *)hdr)->length;
> > 
> > 	return le32_to_cpu(length)?
> > 
> >   
> >> +
> >> +	return hdr->length;
> >> +}
> >> +
> >>   static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
> >>   {
> >>   	return proc->handler || proc->handler_arg;
> >> @@ -332,16 +352,19 @@ static int __init_or_acpilib acpi_parse_entries_array(
> >>   	int proc_num, unsigned int max_entries)
> >>   {
> >>   	struct acpi_subtable_entry entry;
> >> +	enum acpi_subtable_type type;
> >>   	unsigned long table_end, subtable_len, entry_len;
> >>   	int count = 0;
> >>   	int errs = 0;
> >>   	int i;
> >>   
> >> -	table_end = (unsigned long)table_header + table_header->length;
> >> +	type = acpi_get_subtable_type(id);
> >> +	table_end = (unsigned long)table_header +
> >> +		    acpi_table_get_length(type, table_header);  
> > As above, I don't like carrying CDAT which doesn't have an acpi_table_header
> > section around as that type of pointer.
> >   
> >>   
> >>   	/* Parse all entries looking for a match. */
> >>   
> >> -	entry.type = acpi_get_subtable_type(id);
> >> +	entry.type = type;
> >>   	entry.hdr = (union acpi_subtable_headers *)
> >>   	    ((unsigned long)table_header + table_size);
> >>   	subtable_len = acpi_get_subtable_header_length(&entry);
> >> @@ -464,6 +487,26 @@ int __init acpi_table_parse_madt(enum acpi_madt_type id,
> >>   					    handler, max_entries);
> >>   }
> >>   
> >> +int acpi_table_parse_cdat(enum acpi_cdat_type type,
> >> +			  acpi_tbl_entry_handler_arg handler_arg, void *arg,
> >> +			  struct acpi_table_cdat *table_header)
> >> +{
> >> +	struct acpi_subtable_proc proc = {
> >> +		.id		= type,
> >> +		.handler_arg	= handler_arg,
> >> +		.arg		= arg,
> >> +	};
> >> +
> >> +	if (!table_header)
> >> +		return -EINVAL;
> >> +
> >> +	return acpi_parse_entries_array(ACPI_SIG_CDAT,
> >> +			sizeof(struct acpi_table_cdat),
> >> +			(struct acpi_table_header *)table_header,
> >> +			&proc, 1, 0);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(acpi_table_parse_cdat, CXL);
> >> +


