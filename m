Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAC3AC655
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFRImN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 04:42:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44550 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233589AbhFRImN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 04:42:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I8W7JA012388;
        Fri, 18 Jun 2021 08:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=K9ViZWnvJaTQyc2xxPxbXG6tzmirAZyhLh1+h4TlX80=;
 b=cTnICU4J9ROWyX2nQe6ZSY3aeU2PZjP0NnbSC2by3psOpI39vFqNGYmD2oiVMdon+I9r
 RO7bT3tzc4x00+Hwf6IDQGG3ENWwPFbZd5KExin8GjfJGYKTPgS8IwQ6FvHZUH6xLWUr
 CXS7Zm0mVnxqyFcgsNI9yAvhtdNbq7/ut83n0LVfbOYXw1umE8/Kf5618cdeFlBuPGj8
 AA9hZhtmybTD+4vOWWnlg3GBlXVRD3ME9nAwcxERtucgVBNz7i7mdAn6ZqvqfBbBNIKd
 atwn40NRPagyNPr14p0IA9gJ6rxYN7hhN5nDPIxVgbKlWVytZ+A9OQFyuFazu32X66EL hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnquru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:40:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I8Zca0075539;
        Fri, 18 Jun 2021 08:40:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 396waymrr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:40:01 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15I8e1oo083619;
        Fri, 18 Jun 2021 08:40:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 396waymrqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:40:01 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15I8dxwQ009406;
        Fri, 18 Jun 2021 08:39:59 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 01:39:59 -0700
Date:   Fri, 18 Jun 2021 11:39:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     erik.kaneda@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: PRM: implement OperationRegion handler for the
 PlatformRtMechanism subtype
Message-ID: <YMxb17H5xf4SttpA@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: IUcVwjJC3PziLPTXFrDHByLgmGfXlcS_
X-Proofpoint-ORIG-GUID: IUcVwjJC3PziLPTXFrDHByLgmGfXlcS_
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Erik Kaneda,

The patch cefc7ca46235: "ACPI: PRM: implement OperationRegion handler
for the PlatformRtMechanism subtype" from Jun 9, 2021, leads to the
following static checker warning:

	drivers/acpi/prmt.c:113 acpi_parse_prmt()
	error: potential null dereference 'tm'.  (kmalloc returns null)

drivers/acpi/prmt.c
    95  static int __init
    96  acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
    97  {
    98          struct acpi_prmt_module_info *module_info;
    99          struct acpi_prmt_handler_info *handler_info;
   100          struct prm_handler_info *th;
   101          struct prm_module_info *tm;
   102          u64 mmio_count = 0;
   103          u64 cur_handler = 0;
   104          u32 module_info_size = 0;
   105          u64 mmio_range_size = 0;
   106          void *temp_mmio;
   107  
   108          module_info = (struct acpi_prmt_module_info *) header;
   109          module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
   110          tm = kmalloc(module_info_size, GFP_KERNEL);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Check for NULL?

   111  
   112          guid_copy(&tm->guid, (guid_t *) module_info->module_guid);
   113          tm->major_rev = module_info->major_rev;
   114          tm->minor_rev = module_info->minor_rev;
   115          tm->handler_count = module_info->handler_info_count;
   116          tm->updatable = true;
   117  
   118          if (module_info->mmio_list_pointer) {
   119                  /*
   120                   * Each module is associated with a list of addr
   121                   * ranges that it can use during the service
   122                   */
   123                  mmio_count = *(u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
   124                  mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
   125                  tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
   126                  temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
   127                  memmove(tm->mmio_info, temp_mmio, mmio_range_size);
   128          } else {
   129                  mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
   130                  tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
   131                  tm->mmio_info->mmio_count = 0;
   132          }
   133  
   134          INIT_LIST_HEAD(&tm->module_list);
   135          list_add(&tm->module_list, &prm_module_list);

regards,
dan carpenter
