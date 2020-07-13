Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFA21D01F
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgGMG6c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 02:58:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726571AbgGMG6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 02:58:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D5WLk6054775;
        Mon, 13 Jul 2020 02:58:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32771wky9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 02:58:12 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06D6PkkL195365;
        Mon, 13 Jul 2020 02:58:11 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32771wky9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 02:58:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06D6lDl5025511;
        Mon, 13 Jul 2020 06:58:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgsvre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 06:58:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06D6w7xu7012664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 06:58:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8359FA405B;
        Mon, 13 Jul 2020 06:58:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B74A4062;
        Mon, 13 Jul 2020 06:58:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.145])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jul 2020 06:58:04 +0000 (GMT)
Date:   Mon, 13 Jul 2020 09:58:01 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Jia He <justin.he@arm.com>,
        Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 07/22] numa: Introduce a generic
 memory_add_physaddr_to_nid()
Message-ID: <20200713065801.GB11000@linux.ibm.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_03:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=971 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1011 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130037
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dan,

On Sun, Jul 12, 2020 at 09:26:43AM -0700, Dan Williams wrote:
> For architectures that opt into storing their numa data in memblock
> (only ARM64 currently), add a memblock generic way to interrogate that
> data for memory_add_physaddr_to_nid(). This requires ARCH_KEEP_MEMBLOCK
> to keep memblock text and data around after boot.

I afraid we are too far from using memblock as a generic placeholder for
numa data. Although all architectures now have the numa info in
memblock, only arm64 uses memblock as the primary source of that data.

I'd rather prefer Jia's solution [1] to have a weak default for
memory_add_physaddr_to_nid() and let architectures override it.

[1] https://lore.kernel.org/lkml/20200710031619.18762-2-justin.he@arm.com

> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mm.h |   11 +++++++++++
>  mm/Kconfig         |    6 ++++++
>  mm/page_alloc.c    |   23 ++++++++++++++++++++++-
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 

-- 
Sincerely yours,
Mike.
