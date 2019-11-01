Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA38AEC144
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2019 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfKAK2r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Nov 2019 06:28:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfKAK2q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Nov 2019 06:28:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1AKFeb144312;
        Fri, 1 Nov 2019 10:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=HuA8RaLVfqKHYCJhNS2PfjhgX6duj/i6VwF/atHQe0U=;
 b=Iq/ZFoG1vmZajIFaLIDy3zU02rQ5rdrV94mauY24RI9QVarahicT/Dwj8ajBH1M4e3kk
 TgmDpMP1mWWtxqPc9YyugNMjvOtWvh5/BOjfncsjp8j2/zaC36SMwKXcMqN6KBa4jeL+
 QdTWrBelUxhMeB21dzWzPqcKuBCWEDm/xmL3UtkDOL/V6pLqC4cqP2nqfu83AdAN17mC
 X6m8wzK4k0GhS7FZc5NH1IIQeALIpb7sBodCPZTIlDswg6DFWuFplFljQjFdOk3EIWPP
 keenyV/UOfXH0Jqgkr+H70PuGrUCvlJGuPv+CjYAT41+fLnBs51BY88YlmgSW4Z8y5l7 /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vxwhfs5c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 10:28:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1ASGG7067286;
        Fri, 1 Nov 2019 10:28:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vyv9hyywq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 10:28:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA1ASZBT009972;
        Fri, 1 Nov 2019 10:28:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 03:28:34 -0700
Date:   Fri, 1 Nov 2019 13:28:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Erik Schmauss <erik.schmauss@intel.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [pm:bleeding-edge 62/70] drivers/acpi/acpica/dbnames.c:576
 acpi_db_walk_for_fields() error: double free of 'buffer.pointer'
Message-ID: <20191101102553.GH18421@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010104
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   aaa43552df9b1f8c788d18df5f5989f8a13433f5
commit: 5fd033288a86676045d9e16243dfc5f988013371 [62/70] ACPICA: debugger: add command to dump all fields of particular subtype

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/acpica/dbnames.c:576 acpi_db_walk_for_fields() error: double free of 'buffer.pointer'

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=5fd033288a86676045d9e16243dfc5f988013371
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout 5fd033288a86676045d9e16243dfc5f988013371
vim +576 drivers/acpi/acpica/dbnames.c

5fd033288a8667 Erik Schmauss 2019-10-25  518  static acpi_status
5fd033288a8667 Erik Schmauss 2019-10-25  519  acpi_db_walk_for_fields(acpi_handle obj_handle,
5fd033288a8667 Erik Schmauss 2019-10-25  520  			u32 nesting_level, void *context, void **return_value)
5fd033288a8667 Erik Schmauss 2019-10-25  521  {
5fd033288a8667 Erik Schmauss 2019-10-25  522  	union acpi_object *ret_value;
5fd033288a8667 Erik Schmauss 2019-10-25  523  	struct acpi_region_walk_info *info =
5fd033288a8667 Erik Schmauss 2019-10-25  524  	    (struct acpi_region_walk_info *)context;
5fd033288a8667 Erik Schmauss 2019-10-25  525  	struct acpi_buffer buffer;
5fd033288a8667 Erik Schmauss 2019-10-25  526  	acpi_status status;
5fd033288a8667 Erik Schmauss 2019-10-25  527  	struct acpi_namespace_node *node = acpi_ns_validate_handle(obj_handle);
5fd033288a8667 Erik Schmauss 2019-10-25  528  
5fd033288a8667 Erik Schmauss 2019-10-25  529  	if (!node) {
5fd033288a8667 Erik Schmauss 2019-10-25  530  		return (AE_OK);
5fd033288a8667 Erik Schmauss 2019-10-25  531  	}
5fd033288a8667 Erik Schmauss 2019-10-25  532  	if (node->object->field.region_obj->region.space_id !=
5fd033288a8667 Erik Schmauss 2019-10-25  533  	    info->address_space_id) {
5fd033288a8667 Erik Schmauss 2019-10-25  534  		return (AE_OK);
5fd033288a8667 Erik Schmauss 2019-10-25  535  	}
5fd033288a8667 Erik Schmauss 2019-10-25  536  
5fd033288a8667 Erik Schmauss 2019-10-25  537  	info->count++;
5fd033288a8667 Erik Schmauss 2019-10-25  538  
5fd033288a8667 Erik Schmauss 2019-10-25  539  	/* Get and display the full pathname to this object */
5fd033288a8667 Erik Schmauss 2019-10-25  540  
5fd033288a8667 Erik Schmauss 2019-10-25  541  	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
5fd033288a8667 Erik Schmauss 2019-10-25  542  	status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
5fd033288a8667 Erik Schmauss 2019-10-25  543  	if (ACPI_FAILURE(status)) {
5fd033288a8667 Erik Schmauss 2019-10-25  544  		acpi_os_printf("Could Not get pathname for object %p\n",
5fd033288a8667 Erik Schmauss 2019-10-25  545  			       obj_handle);
5fd033288a8667 Erik Schmauss 2019-10-25  546  		return (AE_OK);
5fd033288a8667 Erik Schmauss 2019-10-25  547  	}
5fd033288a8667 Erik Schmauss 2019-10-25  548  
5fd033288a8667 Erik Schmauss 2019-10-25  549  	acpi_os_printf("%s ", (char *)buffer.pointer);
5fd033288a8667 Erik Schmauss 2019-10-25  550  	ACPI_FREE(buffer.pointer);

Freed here.

5fd033288a8667 Erik Schmauss 2019-10-25  551  
5fd033288a8667 Erik Schmauss 2019-10-25  552  	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
5fd033288a8667 Erik Schmauss 2019-10-25  553  	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);

No error handling here so "buffer.pointer" isn't necessarily modified.

5fd033288a8667 Erik Schmauss 2019-10-25  554  
5fd033288a8667 Erik Schmauss 2019-10-25  555  	ret_value = (union acpi_object *)buffer.pointer;
5fd033288a8667 Erik Schmauss 2019-10-25  556  	switch (ret_value->type) {
5fd033288a8667 Erik Schmauss 2019-10-25  557  	case ACPI_TYPE_INTEGER:
5fd033288a8667 Erik Schmauss 2019-10-25  558  
5fd033288a8667 Erik Schmauss 2019-10-25  559  		acpi_os_printf("%8.8X%8.8X",
5fd033288a8667 Erik Schmauss 2019-10-25  560  			       ACPI_FORMAT_UINT64(ret_value->integer.value));
5fd033288a8667 Erik Schmauss 2019-10-25  561  		break;
5fd033288a8667 Erik Schmauss 2019-10-25  562  
5fd033288a8667 Erik Schmauss 2019-10-25  563  	case ACPI_TYPE_BUFFER:
5fd033288a8667 Erik Schmauss 2019-10-25  564  
5fd033288a8667 Erik Schmauss 2019-10-25  565  		acpi_ut_dump_buffer(ret_value->buffer.pointer,
5fd033288a8667 Erik Schmauss 2019-10-25  566  				    ret_value->buffer.length,
5fd033288a8667 Erik Schmauss 2019-10-25  567  				    DB_DISPLAY_DATA_ONLY | DB_BYTE_DISPLAY, 0);
5fd033288a8667 Erik Schmauss 2019-10-25  568  		break;
5fd033288a8667 Erik Schmauss 2019-10-25  569  
5fd033288a8667 Erik Schmauss 2019-10-25  570  	default:
5fd033288a8667 Erik Schmauss 2019-10-25  571  
5fd033288a8667 Erik Schmauss 2019-10-25  572  		break;
5fd033288a8667 Erik Schmauss 2019-10-25  573  	}
5fd033288a8667 Erik Schmauss 2019-10-25  574  	acpi_os_printf("\n");
5fd033288a8667 Erik Schmauss 2019-10-25  575  
5fd033288a8667 Erik Schmauss 2019-10-25 @576  	ACPI_FREE(buffer.pointer);

Double free.

5fd033288a8667 Erik Schmauss 2019-10-25  577  
5fd033288a8667 Erik Schmauss 2019-10-25  578  	return (AE_OK);
5fd033288a8667 Erik Schmauss 2019-10-25  579  }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
