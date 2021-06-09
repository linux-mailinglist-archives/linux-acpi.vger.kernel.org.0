Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A793C3A0BFC
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 07:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhFIFy1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 01:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233165AbhFIFy1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 01:54:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1595WaEV006804;
        Wed, 9 Jun 2021 01:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gjmqYGcd0wsw2MORSb2x1vkekNfP3sefDMsNGhyGlK4=;
 b=SCk/9dR4vFgOuJknDxGxhza76eqnL9wG5AmWiIt7227Oy2gz417xieuriZlCCr0D5npE
 kpMWkXUu2JcPH7VowArVDe3yoLMNKfHRsKS76erBMFx/2NKE0oaMYIctIv6VSiX4H+M8
 RegxZ+1+YA8/hRArcHvxiEtBnJO/ai64YF4ufRc9o1zy0sGOliRyAGJCnqrNDqOF9DFZ
 jIr9S5yKsbO+IFzpKvGkGWjZehm3YGMKkRp9R043iYWjLyWlvG7RPaSzyvAl3N7YmOsL
 70QzaUo5j3/mTgNNa83zRrbdy7czLKMCFp+4t9V3DxZU8cDyQT+RDIPkRdL7llkTG1t1 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392pjrht97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 01:51:11 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1595YJLY012698;
        Wed, 9 Jun 2021 01:51:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392pjrht8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 01:51:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1595hDl1005435;
        Wed, 9 Jun 2021 05:51:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3900w8hwnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 05:51:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1595oI0k28377562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 05:50:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCDA752057;
        Wed,  9 Jun 2021 05:51:05 +0000 (GMT)
Received: from osiris (unknown [9.171.25.171])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CB30152051;
        Wed,  9 Jun 2021 05:51:03 +0000 (GMT)
Date:   Wed, 9 Jun 2021 07:51:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
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
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Joe Perches <joe@perches.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Jia He <justin.he@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v1 04/12] mm/memory_hotplug: remove nid parameter from
 arch_remove_memory()
Message-ID: <YMBWxiUGBjJCz1+q@osiris>
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607195430.48228-5-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YmICdrBc-KG4i-61RykYBVdFdJ3s1NyM
X-Proofpoint-ORIG-GUID: qw89e5qOMxCOu0pR5cZeD51I3FVnw-xL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_01:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=901 bulkscore=0
 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106090015
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 07, 2021 at 09:54:22PM +0200, David Hildenbrand wrote:
> The parameter is unused, let's remove it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/mm/mmu.c            | 3 +--
>  arch/ia64/mm/init.c            | 3 +--
>  arch/powerpc/mm/mem.c          | 3 +--
>  arch/s390/mm/init.c            | 3 +--
>  arch/sh/mm/init.c              | 3 +--
>  arch/x86/mm/init_32.c          | 3 +--
>  arch/x86/mm/init_64.c          | 3 +--
>  include/linux/memory_hotplug.h | 3 +--
>  mm/memory_hotplug.c            | 4 ++--
>  mm/memremap.c                  | 5 +----
>  10 files changed, 11 insertions(+), 22 deletions(-)

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
