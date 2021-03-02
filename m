Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9432A4D2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446541AbhCBLSI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:18:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33328 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1577885AbhCBJ6d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:58:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1229aYR1184438;
        Tue, 2 Mar 2021 04:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=yKyKNplrnfGIMREBrT/v98LCI1geLYbB+er4Q6fkd9Q=;
 b=Jn5lxbK+UhDFunwJyfZ4umAH5vGgxd6IDwt+sEN0mKoA2rO257d89naH37/rhSBWL6yy
 IoBv5QXi2tI/Qkxmsc71Wx0lAkaEb+anjQGUoghaOXrFzjsGm45NFE1OR/DxE+avxeoR
 4i5M8StT1YH1b9k2MUdw3TC9hzaZD5FeeP4hSJuRohOKhHIcxmH0EJqVulwIg6kz6sXU
 Hzd3G4po0+dCiGSDz3duSqyOvu6THoZt93A7f1WOFrj3UlGtZDvGeZ5k6EZrSR5Zv+Fb
 2VtgPSmgdNp7XkDKO8IqvIP5TxlomLA1HZdZm6OeEEvZGVSHkhSlxL+YbwZ7fYobI+Ay 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371gvtn1hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 04:57:18 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1229aqv3185978;
        Tue, 2 Mar 2021 04:57:17 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371gvtn1gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 04:57:17 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1229vECn024285;
        Tue, 2 Mar 2021 09:57:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmgpx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 09:57:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1229vDsg54526246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 09:57:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E643AE053;
        Tue,  2 Mar 2021 09:57:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88387AE04D;
        Tue,  2 Mar 2021 09:57:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Mar 2021 09:57:10 +0000 (GMT)
Date:   Tue, 2 Mar 2021 11:57:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
Message-ID: <YD4L9DCpsFWhjSlJ@linux.ibm.com>
References: <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
 <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
 <20210226111730.GL1854360@linux.ibm.com>
 <e9e2f1a3-80f2-1b3e-6ffd-8004fe41c485@oracle.com>
 <YDvcH7IY8hV4u2Zh@linux.ibm.com>
 <083c2bfd-12dd-f3c3-5004-fb1e3fb6493c@oracle.com>
 <a8864397-83e8-61f7-4b9a-33716eca6cf8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8864397-83e8-61f7-4b9a-33716eca6cf8@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_03:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020078
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi George,

On Mon, Mar 01, 2021 at 08:20:45PM -0500, George Kennedy wrote:
> > > > > 
> > > > There should be no harm in doing the memblock_reserve() for all
> > > > the standard
> > > > tables, right?
> > > It should be ok to memblock_reserve() all the tables very early as
> > > long as
> > > we don't run out of static entries in memblock.reserved.
> > > 
> > > We just need to make sure the tables are reserved before memblock
> > > allocations are possible, so we'd still need to move
> > > acpi_table_init() in
> > > x86::setup_arch() before e820__memblock_setup().
> > > Not sure how early ACPI is initialized on arm64.
> > 
> > Thanks Mike. Will try to move the memblock_reserves() before
> > e820__memblock_setup().
> 
> Hi Mike,
> 
> Moved acpi_table_init() in x86::setup_arch() before e820__memblock_setup()
> as you suggested.
> 
> Ran 10 boots with the following without error.

I'd suggest to send it as a formal patch to see what x86 and ACPI folks
have to say about this.
 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 740f3bdb..3b1dd24 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1047,6 +1047,7 @@ void __init setup_arch(char **cmdline_p)
>      cleanup_highmap();
> 
>      memblock_set_current_limit(ISA_END_ADDRESS);
> +    acpi_boot_table_init();
>      e820__memblock_setup();
> 
>      /*
> @@ -1140,8 +1141,6 @@ void __init setup_arch(char **cmdline_p)
>      /*
>       * Parse the ACPI tables for possible boot-time SMP configuration.
>       */
> -    acpi_boot_table_init();
> -
>      early_acpi_boot_init();
> 
>      initmem_init();
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> index 0bb15ad..7830109 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -7,6 +7,7 @@
>   *
> *****************************************************************************/
> 
> +#include <linux/memblock.h>
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "actables.h"
> @@ -16,6 +17,33 @@
> 
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_tb_reserve_standard_table
> + *
> + * PARAMETERS:  address             - Table physical address
> + *              header              - Table header
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: To avoid an acpi table page from being "stolen" by the
> buddy
> + *              allocator run memblock_reserve() on all the standard acpi
> tables.
> + *
> + ******************************************************************************/
> +void
> +acpi_tb_reserve_standard_table(acpi_physical_address address,
> +               struct acpi_table_header *header)
> +{
> +    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
> +        (ACPI_VALIDATE_RSDP_SIG(header->signature)))
> +        return;
> +

Why these should be excluded?

> +    if (header->length > PAGE_SIZE) /* same check as in acpi_map() */
> +        return;

I don't think this is required, I believe acpi_map() has this check because
kmap() cannot handle multiple pages.

> +
> +    memblock_reserve(address, PAGE_ALIGN(header->length));
> +}
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_tb_install_table_with_override
>   *
>   * PARAMETERS:  new_table_desc          - New table descriptor to install
> @@ -58,6 +86,9 @@
>                        new_table_desc->flags,
>                        new_table_desc->pointer);
> 
> +    acpi_tb_reserve_standard_table(new_table_desc->address,
> +                   new_table_desc->pointer);
> +
>      acpi_tb_print_table_header(new_table_desc->address,
>                     new_table_desc->pointer);
> 
> George

-- 
Sincerely yours,
Mike.
