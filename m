Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1553EA5EBB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 03:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfICBD7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 21:03:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfICBD6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 21:03:58 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8311cqi048534
        for <linux-acpi@vger.kernel.org>; Mon, 2 Sep 2019 21:03:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uqmhtk1f7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Mon, 02 Sep 2019 21:03:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <daniel@linux.ibm.com>;
        Tue, 3 Sep 2019 02:03:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 02:03:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8313oMa50724980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 01:03:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E52D8A4053;
        Tue,  3 Sep 2019 01:03:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9248FA4040;
        Tue,  3 Sep 2019 01:03:49 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 01:03:49 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1AF7DA00EC;
        Tue,  3 Sep 2019 11:03:48 +1000 (AEST)
Date:   Tue, 3 Sep 2019 11:03:45 +1000
From:   Daniel Black <daniel@linux.ibm.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH] acpi/hmat: ACPI_HMAT_MEMORY_PD_VALID is deprecated in
 ACPI-6.3
In-Reply-To: <CAJZ5v0jXiuA3HGPCY3vbH8_53WP-6G=bVJ8SPprCDDg9MoyAsQ@mail.gmail.com>
References: <20190806042440.16445-1-daniel@linux.ibm.com>
        <CAJZ5v0jXiuA3HGPCY3vbH8_53WP-6G=bVJ8SPprCDDg9MoyAsQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090301-0008-0000-0000-000003103BF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090301-0009-0000-0000-00004A2E8B1A
Message-Id: <20190903110345.4ee753c3@volution.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030008
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2 Sep 2019 23:28:50 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Aug 6, 2019 at 6:24 AM Daniel Black <daniel@linux.ibm.com> wrote:
> >
> > ACPI-6.3 corresponds to when hmat revision was bumped from
> > 1 to 2. In this version ACPI_HMAT_MEMORY_PD_VALID was
> > deprecated and made reserved.
> >
> > As such in revision 2+ we shouldn't be testing this flag.
> >
> > This is as per ACPI-6.3, 5.2.27.3, Table 5-145
> > "Memory Proximity Domain Attributes Structure"
> > for Flags.
> >
> > Signed-off-by: Daniel Black <daniel@linux.ibm.com>  
> 
> Keith, any comments?

FYI this was found when I was testing Tao Xu's qemu implementation of HMAT ACPI-6.3 which has no implementation of  ACPI_HMAT_MEMORY_PD_VALID.

Current patch implementing Memory Proximity Domain Attributes Structure:
https://patchwork.kernel.org/patch/11125301/

