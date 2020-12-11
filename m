Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934612D7CBD
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394527AbgLKRXx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 12:23:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394392AbgLKRXg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 12:23:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBHK4pb190820;
        Fri, 11 Dec 2020 17:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=YewCcW7n5E9Q1cap81Gm1FCsiBG7HcHcaDDLPsG/k2s=;
 b=AZfkEdWH7npUi56wy2DPWxOB+OCkup3YJKtY4zkUeDJUpInDfI6gLsu05MegPnuNK0iE
 spr4siTjIAvsHnWdnD/aqrMiOHxwElrFZ3ViScDvwSxNUyIzt37YajuSyWxYeaZpeW0J
 zKgixB2zLSr3D85AgRjF1wNII3ikkKuiIHXGGv/jc6d+jRpQc03SHh5RGU/WwS83SEVr
 BNcHEmf16CgkMlsawQkMmgoMueAgzHBN+Pvd8Cd3/W2xBZPMCQQ6vUqAt+A0fmbTmo1o
 zs2+dmPWYMhbvur8ckziNQjN6FGHkxaS/LMW3TFDYRaPy4UXnXIuJg/A2t9ZUUo0aXVf GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mrbprt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 17:22:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBHFtvA123828;
        Fri, 11 Dec 2020 17:20:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 358m549b13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 17:20:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BBHKS5g024598;
        Fri, 11 Dec 2020 17:20:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Dec 2020 09:20:28 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, <dwagner@suse.de>
Subject: Re: [PATCH v5 5/5] scsi: hisi_sas: Expose HW queues for v2 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0tontu8.fsf@ca-mkp.ca.oracle.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
        <1606905417-183214-6-git-send-email-john.garry@huawei.com>
        <7a30086c-8a23-2272-fac9-a66ca92ae2f8@huawei.com>
Date:   Fri, 11 Dec 2020 12:20:25 -0500
In-Reply-To: <7a30086c-8a23-2272-fac9-a66ca92ae2f8@huawei.com> (John Garry's
        message of "Fri, 11 Dec 2020 16:56:22 +0000")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=703
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=715
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110116
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


John,

> Is there some way in this patch can be merged for 5.11 via the SCSI
> tree? It has a dependency on the earlier patches in the series, now 
> picked up via irqchip tree. I've seen multiple rounds of SCSI pull
> requests before, but not sure when we have that or if the tree is 
> rebased for those.

I'll do a postmerge branch for a few things, including your patch and
the megaraid patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
