Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BA32FF8D
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Mar 2021 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhCGHrt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Mar 2021 02:47:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18288 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhCGHrS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Mar 2021 02:47:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1277YLA5173783;
        Sun, 7 Mar 2021 02:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=POVp9fyakxyA52br+HNplqiEd9E35h8aut0jl4KHgz8=;
 b=fA1I+c1VQilumKH4BsHYrXA9EcSOYSXTL2KfCKR1M9PtsRMEzIx5VrGCdhCxlpMjIZsB
 jZaf+xped44ES0doQuLdLcRTY1EuttKnsOAWPMgv5af2bHcIZr4TDx4IR18IhtfCjWdV
 hmElmPK4XqZBXvoOEBHIJdGCXhf/Aj7KuDCyoheK0QMh14kKk5rO2abQBS1pdBW3wbnM
 j9pGNgM5jKR+nKzjElkoPdXfNsODWQQrc2kmbNIumdFv3a5W5cYmxepA0EkyzcMeRCbJ
 /6F4c4k9RzSVm43FYuw3fNFbWuNRw1ZK6gaftDXtyGhHMl6S8qUmVYEOji7GEWol6h50 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 374se6168q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 02:47:04 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1277YXN4175959;
        Sun, 7 Mar 2021 02:47:04 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 374se6167f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 02:47:04 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1277hHNJ022752;
        Sun, 7 Mar 2021 07:47:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3741c8ge27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 07:47:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1277kiVO33882488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Mar 2021 07:46:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2263252071;
        Sun,  7 Mar 2021 07:46:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 878B25206D;
        Sun,  7 Mar 2021 07:46:20 +0000 (GMT)
Date:   Sun, 7 Mar 2021 09:46:18 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Message-ID: <YESEymRQ2/F7xJGt@linux.ibm.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-06_08:2021-03-03,2021-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103070040
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael,

On Fri, Mar 05, 2021 at 02:30:07PM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 5, 2021 at 12:14 AM George Kennedy <george.kennedy@oracle.com> wrote:
>
> > The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> > page for the ibft table is not reserved, so it can end up on the freelist.
> 
> You appear to be saying that it is not sufficient to kmap() a page in
> order to use it safely.  It is also necessary to reserve it upfront,
> for example with the help of memblock_reserve().  Is that correct?  If
> so, is there an alternative way to reserve a page frame?

Like David said in the other reply, if a BIOS does not mark the memory that
contains an ACPI table as used (e.g. reserved or ACPI data), we need to
make sure the kernel knows that such memory is in use and an early call to
memblock_reserve() is exactly what we need here.
George had this issue with iBFT, but in general this could be any table
that a buggy BIOS forgot to mark as ACPI data.
 
> > >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > >> index d883176..97deea3 100644
> > >> --- a/arch/x86/kernel/setup.c
> > >> +++ b/arch/x86/kernel/setup.c
> > >> @@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
> > >>          cleanup_highmap();
> > >>
> > >>          memblock_set_current_limit(ISA_END_ADDRESS);
> > >> +       acpi_boot_table_init();
> > > This cannot be moved before the acpi_table_upgrade() invocation AFAICS.
> > >
> > > Why exactly do you want to move it?
> >
> > Want to make sure there are slots for memblock_reserve() to be able to
> > reserve the page.
> 
> Well, that may not require reordering the initialization this way.

The memory that is used by the firmware should be reserved before memblock
allocations are allowed so that ACPI tables won't get trampled by some
random allocation.

On x86 this essentially means that the early reservations need to be
complete before the call to e820__memblock_setup().

We probably need more precise refactoring of ACPI init than simply moving
acpi_boot_table_init() earlier. 
 
> > >>          e820__memblock_setup();
> > >>

-- 
Sincerely yours,
Mike.
