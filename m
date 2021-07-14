Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64F53C91E0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhGNURj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 16:17:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhGNURi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 16:17:38 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EK3g8i084171;
        Wed, 14 Jul 2021 16:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=O91ChT6aq6gFj1s1eeKJPhJgYPpsA9fr7zrKDQPlVMI=;
 b=F78hDwxT8p5Hi5ea4iRmX5YeibVAKo+ISPXe/ejlEYJV1dC3zfaPdt/8SfrQMnToMzqc
 PTp7Sxg7CGgJ6765F47q1xHtVlrHlq/ZyO6D5+DhL+FXOCde+9CJnqUYe/odcWPC1lUR
 K+cZ58Nhyy6TsLLhwXT6rLIfcS5swNDkv2qnUtRdzr1VY9DsFk51ZAW/psKjI0wy/mBi
 DGzhSg+MEbCzQUNlNKfFY01l/RCorJ2BBWBz8yN1IA+VM2nZrnYHxCXyZEqseij9o3qe
 /ZmBVBPct3F4dItCcdBCX4QhVoLrXNIRADXchr2nSZer+zyoUCgWhmBMCyJ7ImRY2JLc ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc8kfb2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:13:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EK3sS4084604;
        Wed, 14 Jul 2021 16:13:24 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc8kfb13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:13:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EKB4nX032501;
        Wed, 14 Jul 2021 20:13:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39q3689x6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 20:13:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EKDHkb36307240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 20:13:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCFC7AE051;
        Wed, 14 Jul 2021 20:13:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC7C0AE04D;
        Wed, 14 Jul 2021 20:13:15 +0000 (GMT)
Received: from osiris (unknown [9.145.80.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Jul 2021 20:13:15 +0000 (GMT)
Date:   Wed, 14 Jul 2021 22:13:14 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in
 zone_for_pfn_range()
Message-ID: <YO9FWrT9h21e/G8X@osiris>
References: <20210712124052.26491-1-david@redhat.com>
 <20210712124052.26491-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712124052.26491-2-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _R4J7Ka4suONfylmv2kX6PD4cpzO6szw
X-Proofpoint-ORIG-GUID: NPoolV9OQ2VwpTmyT54T1Ri1bj2r49ZC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=805 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140119
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 02:40:49PM +0200, David Hildenbrand wrote:
> Checkpatch complained on a follow-up patch that we are using "unsigned"
> here, which defaults to "unsigned int" and checkpatch is correct.
> 
> Use "unsigned long" instead, just as we do in other places when handling
> PFNs. This can bite us once we have physical addresses in the range of
> multiple TB.
> 
> Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/memory_hotplug.h | 4 ++--
>  mm/memory_hotplug.c            | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

I'd propose to add Cc: <stable@vger.kernel.org> since I actually had
the fun to try to debug something like this a couple of years ago:
6cdb18ad98a4 ("mm/vmstat: fix overflow in mod_zone_page_state()")
