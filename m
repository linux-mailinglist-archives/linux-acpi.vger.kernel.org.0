Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7F4450D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfFMQlV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 12:41:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfFMGya (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 02:54:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D6sNAx011711;
        Thu, 13 Jun 2019 06:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=+p9bNSHm2Ncbv+ASm69GCpznMFNiwtbpe0dw2hqUkkA=;
 b=yHWMPWdZv/XtUu9DlTm5CxgFfps6bAs4TkRabP82B6j8j89SvriCL99WkWUw5S5VKCRX
 LJwfH2REQSETyo6FuM16gyjV2Bj/tFXcOA4XzmZWpRNHjvFpdsMx7+l0wnrazVQkIz5y
 i/ZEAXpiviIIzZKzF4ZRhi9ODUjtRi1PR3T6NPe2bspKL3MbRJ3DrLRDUXeGHJpEGkXc
 +xvSln+ZhEuZBmdAO6E1b5AX9AQ/ZMwTMOWuds2DNFDqPLmWhzn3n+jb/Acw0kF4H090
 ytrFMfyqIoGUpi/rklBewd6MyKcCiIHaOryRExSBnKQsgEZhJqLLDc3GzqNVEWt+mSCW vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etymwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 06:54:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D6qqht075123;
        Thu, 13 Jun 2019 06:54:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t1jpjcyut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 06:54:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5D6sHww011651;
        Thu, 13 Jun 2019 06:54:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 23:54:17 -0700
Date:   Thu, 13 Jun 2019 09:54:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     tn@semihalf.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [bug report] ACPI: Add new IORT functions to support MSI domain
 handling
Message-ID: <20190613065410.GB16334@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130055
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Tomasz Nowicki,

The patch 4bf2efd26d76: "ACPI: Add new IORT functions to support MSI
domain handling" from Sep 12, 2016, leads to the following static
checker warning:

	drivers/acpi/arm64/iort.c:628 iort_dev_find_its_id()
	warn: array off by one? 'its->identifiers[idx]'

drivers/acpi/arm64/iort.c
   589  /**
   590   * iort_dev_find_its_id() - Find the ITS identifier for a device
   591   * @dev: The device.
   592   * @req_id: Device's requester ID
   593   * @idx: Index of the ITS identifier list.
   594   * @its_id: ITS identifier.
   595   *
   596   * Returns: 0 on success, appropriate error value otherwise
   597   */
   598  static int iort_dev_find_its_id(struct device *dev, u32 req_id,
   599                                  unsigned int idx, int *its_id)
   600  {
   601          struct acpi_iort_its_group *its;
   602          struct acpi_iort_node *node;
   603  
   604          node = iort_find_dev_node(dev);
   605          if (!node)
   606                  return -ENXIO;
   607  
   608          node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
   609          if (!node)
   610                  return -ENXIO;
   611  
   612          /* Move to ITS specific data */
   613          its = (struct acpi_iort_its_group *)node->node_data;
   614          if (idx > its->its_count) {
                    ^^^^^^^^^^^^^^^^^^^^
I wasn't able to find any information about how its->its_count is set
but it looks to me that is off by one.

   615                  dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
   616                          idx, its->its_count);
   617                  return -ENXIO;
   618          }
   619  
   620          *its_id = its->identifiers[idx];
   621          return 0;
   622  }

regards,
dan carpenter
