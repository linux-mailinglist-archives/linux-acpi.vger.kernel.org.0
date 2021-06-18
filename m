Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C793AC657
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhFRIn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 04:43:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32198 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233129AbhFRIn6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 04:43:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I8ffrw019261;
        Fri, 18 Jun 2021 08:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2kpiTSJMR+xGEgSz0B8dAR+kCyUSpye/8O4JUhMac+4=;
 b=SGGXcSfEpl+gg3FW6QbOWE5nxMUjlcsBhA53efEKeJHkt3c/MY2FD9o6YvUif/D2qXAm
 bsA9xlMNvRM+3BwyTxIqpb228sFV5dUXRdHFsItYb7GndnRIOAxJwISRNGAi7n5tqbw4
 i1SdG3YgkmwooAHXh5XXZ1h/hlXrmb8O/6yH4arbGUcDihHD1q0OykldHsQ6sJAgkCj6
 /2UDWy73u+FTgNIHEngVPiv49WTYw4JEZslAwibOggdDkmiR2TKxwgHtNDuAtW40BlER
 Ou5NhFlZuOegP+S62wewloOWr4MDGGQ1v4D5vdpBunYmVoB8e2g+K6XxmphLj8ArvUee dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39893qsd74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:41:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I8fDDp049039;
        Fri, 18 Jun 2021 08:41:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 396waxh6b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:41:45 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15I8fMna050193;
        Fri, 18 Jun 2021 08:41:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 396waxh6ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:41:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15I8fi4u017522;
        Fri, 18 Jun 2021 08:41:44 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 01:41:44 -0700
Date:   Fri, 18 Jun 2021 11:41:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     erik.kaneda@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [bug report] ACPI: PRM: implement OperationRegion handler for
 the PlatformRtMechanism subtype
Message-ID: <20210618084137.GS1901@kadam>
References: <YMxb17H5xf4SttpA@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMxb17H5xf4SttpA@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: jhvrmQjpYRaoOXsbyaP6G7ck6antGx40
X-Proofpoint-GUID: jhvrmQjpYRaoOXsbyaP6G7ck6antGx40
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 18, 2021 at 11:39:51AM +0300, Dan Carpenter wrote:
> Hello Erik Kaneda,
> 
> The patch cefc7ca46235: "ACPI: PRM: implement OperationRegion handler
> for the PlatformRtMechanism subtype" from Jun 9, 2021, leads to the
> following static checker warning:
> 
> 	drivers/acpi/prmt.c:113 acpi_parse_prmt()
> 	error: potential null dereference 'tm'.  (kmalloc returns null)
> 
> drivers/acpi/prmt.c
>     95  static int __init
>     96  acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>     97  {
>     98          struct acpi_prmt_module_info *module_info;
>     99          struct acpi_prmt_handler_info *handler_info;
>    100          struct prm_handler_info *th;
>    101          struct prm_module_info *tm;
>    102          u64 mmio_count = 0;
>    103          u64 cur_handler = 0;
>    104          u32 module_info_size = 0;
>    105          u64 mmio_range_size = 0;
>    106          void *temp_mmio;
>    107  
>    108          module_info = (struct acpi_prmt_module_info *) header;
>    109          module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
>    110          tm = kmalloc(module_info_size, GFP_KERNEL);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Check for NULL?
> 
>    111  
>    112          guid_copy(&tm->guid, (guid_t *) module_info->module_guid);
>    113          tm->major_rev = module_info->major_rev;
>    114          tm->minor_rev = module_info->minor_rev;
>    115          tm->handler_count = module_info->handler_info_count;
>    116          tm->updatable = true;
>    117  
>    118          if (module_info->mmio_list_pointer) {
>    119                  /*
>    120                   * Each module is associated with a list of addr
>    121                   * ranges that it can use during the service
>    122                   */
>    123                  mmio_count = *(u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
>    124                  mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
>    125                  tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);

Also here:

drivers/acpi/prmt.c:131 acpi_parse_prmt() error: potential null dereference 'tm->mmio_info'.  (kmalloc returns null)

regards,
dan carpenter

>    126                  temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
>    127                  memmove(tm->mmio_info, temp_mmio, mmio_range_size);
>    128          } else {
>    129                  mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
>    130                  tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
>    131                  tm->mmio_info->mmio_count = 0;
>    132          }
>    133  
>    134          INIT_LIST_HEAD(&tm->module_list);
>    135          list_add(&tm->module_list, &prm_module_list);
> 
> regards,
> dan carpenter
