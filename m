Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84C19F827
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgDFOo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 10:44:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgDFOo3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 10:44:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036EhhSZ194083;
        Mon, 6 Apr 2020 14:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NPzOHNL43b3IOI3Dg4i9Q4dV8e8iUPkPKzlaZijfd18=;
 b=YUOfFcqf5oAQ/JB5RuW1U/8RgVGKNQ3DZI3iVSbizkanrsNbVPqb72OlVAPtHVqTNH2v
 O5c67XUjqtwN0q7sbK/RBwVhd/oCFeWDVYn98o7KwMCJGLLcYomvPmMwQjcYzPtf+XHU
 vfhrZwhBP2VodS/LMIMP/FPPiX23KGAO5qZFmeNDdE5dsUPnyxR102r+QmVAFix2Mt9/
 xToVAeir+zjIauJ6mDLJstVCZSQsEpkkkPSOLnFXRGUcTaKzAiPqB9S6GUoH/7dRPBbc
 vRCXBqekcmHVzQoxVIcKtyqQJsywz6rgaiGTTI6lizXgC27ol/WGCM1fTKyuP807DGfW 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 306j6m7916-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:44:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036EgPAY029945;
        Mon, 6 Apr 2020 14:42:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30839q6ffd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:42:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036EgNL6026874;
        Mon, 6 Apr 2020 14:42:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 07:42:23 -0700
Date:   Mon, 6 Apr 2020 17:42:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: EC: Avoid passing redundant argument to functions
Message-ID: <20200406144217.GA68494@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=10 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=10 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060122
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael J. Wysocki,

This is a semi-automatic email about new static checker warnings.

The patch a2b691772acd: "ACPI: EC: Avoid passing redundant argument 
to functions" from Feb 27, 2020, leads to the following Smatch 
complaint:

    drivers/acpi/ec.c:1624 acpi_ec_add()
    error: we previously assumed 'ec' could be null (see line 1595)

drivers/acpi/ec.c
  1588  
  1589          strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
  1590          strcpy(acpi_device_class(device), ACPI_EC_CLASS);
  1591  
  1592          if ((boot_ec && boot_ec->handle == device->handle) ||
                     ^^^^^^^
Assume "boot_ec" is NULL.

  1593              !strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {

And the strings math.

  1594			/* Fast path: this device corresponds to the boot EC. */
  1595			ec = boot_ec;
                        ^^^^^^^^^^^^
so "ec" is NULL.

  1596		} else {
  1597			acpi_status status;
  1598	
  1599			ec = acpi_ec_alloc();
  1600			if (!ec)
  1601				return -ENOMEM;
  1602	
  1603			status = ec_parse_device(device->handle, 0, ec, NULL);
  1604			if (status != AE_CTRL_TERMINATE) {
  1605				ret = -EINVAL;
  1606				goto err;
  1607			}
  1608	
  1609			if (boot_ec && ec->command_addr == boot_ec->command_addr &&
  1610			    ec->data_addr == boot_ec->data_addr) {
  1611				/*
  1612				 * Trust PNP0C09 namespace location rather than
  1613				 * ECDT ID. But trust ECDT GPE rather than _GPE
  1614				 * because of ASUS quirks, so do not change
  1615				 * boot_ec->gpe to ec->gpe.
  1616				 */
  1617				boot_ec->handle = ec->handle;
  1618				acpi_handle_debug(ec->handle, "duplicated.\n");
  1619				acpi_ec_free(ec);
  1620				ec = boot_ec;
  1621			}
  1622		}
  1623	
  1624		ret = acpi_ec_setup(ec, device);
                                    ^^
NULL dereference inside the function.

  1625		if (ret)
  1626			goto err;

regards,
dan carpenter
