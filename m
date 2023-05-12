Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1E700D82
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjELQ6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjELQ6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:58:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443533C23;
        Fri, 12 May 2023 09:58:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvxc69hnz6J74s;
        Sat, 13 May 2023 00:54:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:58:27 +0100
Date:   Fri, 12 May 2023 17:58:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>
Subject: Re: [PATCH 1/4] acpi: tables: Add CDAT table parsing support
Message-ID: <20230512175826.00007db7@Huawei.com>
In-Reply-To: <645e65d7dbf3_1e6f29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
        <168330797672.2042604.12339416734589446371.stgit@djiang5-mobl3>
        <20230512125831.00000eb0@Huawei.com>
        <645e65d7dbf3_1e6f29476@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 12 May 2023 09:14:15 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 05 May 2023 10:32:56 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > The CDAT table is very similar to ACPI tables when it comes to sub-table
> > > and entry structures. The helper functions can be also used to parse the
> > > CDAT table. Add support to the helper functions to deal with an external
> > > CDAT table, and also handle the endieness since CDAT can be processed by a
> > > BE host. Export a function acpi_table_parse_cdat() for CXL driver to parse
> > > a CDAT table.
> > > 
> > > In order to minimize ACPI code changes, __force is being utilized to deal
> > > with the case of a big endien (BE) host parsing a CDAT. All CDAT data
> > > structure variables are being force casted to __leX as appropriate.  
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
> Yes, this was the question before sending this out. The savings is on
> the order of ~100 lines which is not amazing, but was enough for me to
> say lets keep going with this idea.
> 
> The other observation is that the ACPICA project is doing something
> similar for offering disassembly of CDAT buffers within the existing
> ACPICA tooling vs building independent infrastructure. So that was
> another weight on the scale with proceeding with the code reuse for me.

Great. I'd missed that.  I took a look at that ages ago and decided it
was too hard to solve and ran away / wrote CDAT tables in a hex editor instead
for a bit.

> 
> The only thing I don't like about the result is still seeing acpi_/ACPI_
> prefixes. I think these entry points and symbol names should be
> cdat_/CDAT_ where possible, more below.
> 
> ...and as I read to the end of the feedback on this one it seems you
> have the same reaction.
> 
> > 
> > Otherwise, maybe we need some unions so that the type mashups don't happen.

A union or two would get rid of the type confusion - or at least make it
deliberate at the cost of annoyingly noisy patch or maybe some wrappers.

> >   
> > > 
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >  drivers/acpi/tables.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
> > >  include/acpi/actbl1.h |    3 +++
> > >  include/linux/acpi.h  |    4 ++++
> > >  3 files changed, 52 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > > index 7b4680da57d7..08486f6df442 100644
> > > --- a/drivers/acpi/tables.c
> > > +++ b/drivers/acpi/tables.c
> > > @@ -42,6 +42,7 @@ enum acpi_subtable_type {
> > >  	ACPI_SUBTABLE_HMAT,
> > >  	ACPI_SUBTABLE_PRMT,
> > >  	ACPI_SUBTABLE_CEDT,
> > > +	ACPI_SUBTABLE_CDAT,  
> 
> To your point about ACPI_SIG_CDAT I also think this should be named
> differently, like CDAT_SUBTABLE, just to make it clear that this is a
> special case and not another ACPI table.

That works for me.

> 
> > >  };
> > >  
> > >  struct acpi_subtable_entry {
> > > @@ -239,6 +240,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
> > >  		return 0;
> > >  	case ACPI_SUBTABLE_CEDT:
> > >  		return entry->hdr->cedt.type;
> > > +	case ACPI_SUBTABLE_CDAT:
> > > +		return entry->hdr->cdat.type;
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -255,6 +258,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
> > >  		return entry->hdr->prmt.length;
> > >  	case ACPI_SUBTABLE_CEDT:
> > >  		return entry->hdr->cedt.length;
> > > +	case ACPI_SUBTABLE_CDAT:
> > > +		return le16_to_cpu((__force __le16)entry->hdr->cdat.length);
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -271,6 +276,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
> > >  		return sizeof(entry->hdr->prmt);
> > >  	case ACPI_SUBTABLE_CEDT:
> > >  		return sizeof(entry->hdr->cedt);
> > > +	case ACPI_SUBTABLE_CDAT:
> > > +		return sizeof(entry->hdr->cdat);
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -284,9 +291,22 @@ acpi_get_subtable_type(char *id)
> > >  		return ACPI_SUBTABLE_PRMT;
> > >  	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
> > >  		return ACPI_SUBTABLE_CEDT;
> > > +	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
> > > +		return ACPI_SUBTABLE_CDAT;  
> > 
> > I'm not super keen on inventing a SIG when the CDAT 'table'
> > doesn't actually have one.  
> 
> Agree, I think CDAT_SIG makes it clearer that CDAT is not in the
> traditional ACPI namespace.

Agreed. IF it shouts different I'm fine with this.

> 
> >   
> > >  	return ACPI_SUBTABLE_COMMON;
> > >  }
> > >  
> > > +static unsigned long __init_or_acpilib
> > > +acpi_table_get_length(enum acpi_subtable_type type,
> > > +		      struct acpi_table_header *hdr)  
> > 
> > I don't like parsing in an acpi_table_header type here when it may not be one.
> > I think this length decision needs to be pushed up a level to where we can see
> > if we have a CDAT table or not.
This comment was (as Dave pointed out) not very helpful.

Switch struct acpi_table_header for a union of that and
struct acpi_table_cdat (renamed)  and it would make me less
uncomfortable with this



> 

