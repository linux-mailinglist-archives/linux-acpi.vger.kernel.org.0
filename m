Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE619C031
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgDBLa7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 07:30:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36888 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgDBLa7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2020 07:30:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032BSIpE015369;
        Thu, 2 Apr 2020 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=7o0FVYwJwkPoxE1Cw1mXQzPgG4H99LYFk/EWX3dnUwI=;
 b=A2OPctM+5Z1X/yUJSCs71WpzoQHomIEDXP8QxdOvr7R9DuTiAsgMq7/zyiilSl/iKSFC
 5T6LIrZRb68xqMI5bAHGBa592kG5L3hNAAHNTNlV7geGahDiJXtp8GNmX9iygrh2IXwV
 xJoR5K3kRMYDo+F+duejELE4bgbaGEN0DZroe49TuYOcfQCRaDgG6YYjYUDNo6Jsu9o7
 PNRb9npVQ5l+CTI9+urhh4HkgvWoGnbQ/tkk7lYYdCDpfUCwYIHSkuBdV+LvavyRcKqo
 8me7wmjoDXM/I33zVyHtEN1sUjbLJjqcjuTcD5u0I7QH3Me4t/k8zEsDX/128qartOur Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 303yundc29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 11:30:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032BQvwn147884;
        Thu, 2 Apr 2020 11:28:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 302g2jd5wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 11:28:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 032BSmYq009917;
        Thu, 2 Apr 2020 11:28:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 04:28:48 -0700
Date:   Thu, 2 Apr 2020 14:28:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jan Engelhardt <jengelh@inai.de>
Cc:     kbuild-all@lists.01.org, rafael.j.wysocki@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpica: clear global_lock bits at FACS initialization
Message-ID: <20200402112712.GN2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330085852.31328-1-jengelh@inai.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020104
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jan,

url:    https://github.com/0day-ci/linux/commits/Jan-Engelhardt/acpica-clear-global_lock-bits-at-FACS-initialization/20200330-183705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/acpica/tbutils.c:60 acpi_tb_initialize_facs() error: uninitialized symbol 'facs'.

# https://github.com/0day-ci/linux/commit/cc0fd9e263391ff230ac700aa76dbcf7195c8c42
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout cc0fd9e263391ff230ac700aa76dbcf7195c8c42
vim +/facs +60 drivers/acpi/acpica/tbutils.c

009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  35  acpi_status acpi_tb_initialize_facs(void)
009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  36  {
7484619bff495c drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  37  	struct acpi_table_facs *facs;
009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  38  
22e5b40ab21fca drivers/acpi/acpica/tbutils.c Bob Moore      2011-11-16  39  	/* If Hardware Reduced flag is set, there is no FACS */
22e5b40ab21fca drivers/acpi/acpica/tbutils.c Bob Moore      2011-11-16  40  
22e5b40ab21fca drivers/acpi/acpica/tbutils.c Bob Moore      2011-11-16  41  	if (acpi_gbl_reduced_hardware) {
22e5b40ab21fca drivers/acpi/acpica/tbutils.c Bob Moore      2011-11-16  42  		acpi_gbl_FACS = NULL;
22e5b40ab21fca drivers/acpi/acpica/tbutils.c Bob Moore      2011-11-16  43  		return (AE_OK);
8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  44  	} else if (acpi_gbl_FADT.Xfacs &&
8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  45  		   (!acpi_gbl_FADT.facs
8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  46  		    || !acpi_gbl_use32_bit_facs_addresses)) {
8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  47  		(void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
c04e1fb4396d27 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  48  					      ACPI_CAST_INDIRECT_PTR(struct
c04e1fb4396d27 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  49  								     acpi_table_header,
7484619bff495c drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  50  								     &facs));
7484619bff495c drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  51  		acpi_gbl_FACS = facs;
8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  52  	} else if (acpi_gbl_FADT.facs) {
                                                                                  ^^^^^^^

8ec3f459073e67 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  53  		(void)acpi_get_table_by_index(acpi_gbl_facs_index,
009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  54  					      ACPI_CAST_INDIRECT_PTR(struct
009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  55  								     acpi_table_header,
7484619bff495c drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  56  								     &facs));
7484619bff495c drivers/acpi/acpica/tbutils.c Lv Zheng       2015-08-25  57  		acpi_gbl_FACS = facs;
c04e1fb4396d27 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  58  	}

There is no else path, only else if paths.

cc0fd9e263391f drivers/acpi/acpica/tbutils.c Jan Engelhardt 2020-03-30  59  	/* Clear potential garbage from the initial FACS table. */
cc0fd9e263391f drivers/acpi/acpica/tbutils.c Jan Engelhardt 2020-03-30 @60  	if (facs != NULL)
cc0fd9e263391f drivers/acpi/acpica/tbutils.c Jan Engelhardt 2020-03-30  61  		facs->global_lock &= ~0x3;
c04e1fb4396d27 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  62  
f06147f9fbf134 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  63  	/* If there is no FACS, just continue. There was already an error msg */
f06147f9fbf134 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  64  
c04e1fb4396d27 drivers/acpi/acpica/tbutils.c Lv Zheng       2015-07-01  65  	return (AE_OK);
009c4cbe99bea2 drivers/acpi/tables/tbutils.c Bob Moore      2008-11-12  66  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
