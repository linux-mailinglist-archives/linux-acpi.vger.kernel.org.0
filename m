Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F511342C9E
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Mar 2021 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTL6M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 20 Mar 2021 07:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhCTL6A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 20 Mar 2021 07:58:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12K83rNM143519;
        Sat, 20 Mar 2021 04:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UUZSld/Y2ScyH/gr9DXdRTOqZEpHJR3JyvCTPA1fYjo=;
 b=e7K92LmPpPWpQyx7VbEPIv5pysKwYkQOwXcq0Din0U1POcYIOht6JoBfjKcn6XUiC3LU
 /dd86y5VNoWvCGMc+jWgx+3ipd7dRAO8+EPf7XWyD3eSguuJJeIdtrswvqtyqAvY+Huq
 bxV+oiGMWTQI29rnJ5z6RH+bPc2us+braw3rOU+zrRBDNFqau28K+H1WP1XBeVHWCSO0
 T9rjycSpeshQHnQEaFZxg0rGZ1ngwTxCxWsMPTipLsbfSUGEFeseI1wfXLhHRrZaC71J
 z81Qak4bVFKmEN/Jc78AA+//0gpF3GyfPoa0Yj8mxW4t35qTsHJ5yxG3rbTt0im5UWek Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dd6v8af8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Mar 2021 04:25:29 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12K85ALr150631;
        Sat, 20 Mar 2021 04:25:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dd6v8af0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Mar 2021 04:25:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12K8MbUB017835;
        Sat, 20 Mar 2021 08:25:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99r89q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Mar 2021 08:25:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12K8PO6657737682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Mar 2021 08:25:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A7605204F;
        Sat, 20 Mar 2021 08:25:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.165.64])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 01CEE52052;
        Sat, 20 Mar 2021 08:25:21 +0000 (GMT)
Date:   Sat, 20 Mar 2021 10:25:19 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
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
Message-ID: <YFWxbzN92XcXNl95@linux.ibm.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
 <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher>
 <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_12:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103200058
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 04:22:37PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 18, 2021 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > There is some care that should be taken to make sure we get the order
> > > > > > > > > right, but I don't see a fundamental issue here.
> > > > > > >
> > > > > > > Me neither.
> > > > > > >
> > > > > > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > > > > > >
> > > > > > > Something like this.
> > > > > > >
> > > > > > > There is also the problem that memblock_reserve() needs to be called
> > > > > > > for all of the tables early enough, which will require some reordering
> > > > > > > of the early init code.
> > > > > > >
> > > > > > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > > > > > during KASLR setup.
> > > > > > >
> > > > > > > Right.
> > > > > >
> > > > > > I've looked at it a bit more and we do something like the patch below that
> > > > > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > > > >
> > > > > It looks to me that the code need not be duplicated (see below).
> > > > >
> > > > > > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > > > > > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > > > > > early_memremap() twice for no good reason.
> > > > >
> > > > > That'd be simply inefficient which is kind of acceptable to me to start with.
> > > > >
> > > > > And I changing the ACPICA code can be avoided at least initially, it
> > > > > by itself would be a good enough reason.
> > > > >
> > > > > > I believe the most effective way to deal with this would be to have a
> > > > > > function that does parsing, reservation and installs the tables supplied by
> > > > > > the firmware which can be called really early and then another function
> > > > > > that overrides tables if needed a some later point.
> > > > >
> > > > > I agree that this should be the direction to go into.
> > > >
> > > > So maybe something like the patch below?
> > > >
> > > > I'm not sure if acpi_boot_table_prepare() gets called early enough, though.
> > >
> > > To be 100% safe it should be called before e820__memblock_setup().
> >
> > OK
> 
> Well, that said, reserve_bios_regions() doesn't seem to have concerns
> like this and I'm not sure why ACPI tables should be reserved before
> this runs.  That applies to efi_reserve_boot_services() too.
> 
> I can put the new call before e820__memblock_alloc_reserved_mpc_new(),
> but I'm not sure why to put it before efi_reserve_boot_services(),
> say?

The general idea is to reserve all the memory used by the firmware before
memblock allocations are possible, i.e. before e820__memblock_setup().
Currently this is not the case, but it does not make it more correct.

Theoretically, it is possible that reserve_bios_regions() will cause a
memory allocation and the allocated memory will be exactly at the area
where ACPI tables reside.

In practice I believe this is very unlikely, but who knows.

Another advantage of having ACPI tables handy by the time we do the memory
detection is that we will be able to SRAT earlier and simplify NUMA
initialization.

-- 
Sincerely yours,
Mike.
