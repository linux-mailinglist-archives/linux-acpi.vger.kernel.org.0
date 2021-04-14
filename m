Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE17E35EF4A
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhDNINq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 04:13:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhDNINq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 04:13:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13E88t1k120342;
        Wed, 14 Apr 2021 04:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uTIx3YjrJregdIh4qRlNRtV2R5pefmy1+5UWcF8xWJU=;
 b=QpthcHdTzxRfXw2HWCkF7B33TvJ2OWL36/Mb6/rN5yt8cVjRgyTRz3K+5dFGzi0wf1MA
 ypjL4D93ZHY3VuE9uCjcEp6nRVtKpxvxbwL8fGV4NvHdQstNycwfb/K0rYZBCRuiUidD
 McqCudY9UrIKMd44c4GqyqMVtSA+TeOAgSVI7J06+N+FDl3OFiHqbH0xBQ+K+TSgPEl+
 eqZ6wijMqo/xCVa6D88wYwJfB/36HNDxzEbeiOQLYKCzHaKn0Ua/495GQqrQL8PWkNxi
 G/swwfZ64AQRRNwXUWH8/AESOVeFXVh/keDx135U6hhMImr6+o9mXMRU5yHc+WXyvvzQ yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wvacgnqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 04:13:19 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13E8AFv7126759;
        Wed, 14 Apr 2021 04:13:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wvacgnpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 04:13:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13E87G6u020971;
        Wed, 14 Apr 2021 08:13:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8b559-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 08:13:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13E8DELA40894928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:13:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 642194C044;
        Wed, 14 Apr 2021 08:13:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6404A4C04A;
        Wed, 14 Apr 2021 08:13:13 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.82.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Apr 2021 08:13:13 +0000 (GMT)
Date:   Wed, 14 Apr 2021 11:13:11 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after
 acpi_table_upgrade()
Message-ID: <YHakFzNYBS6YLpPi@linux.ibm.com>
References: <11752259.O9o76ZdvQC@kreacher>
 <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
 <CAJZ5v0hHJYT6kSxoH-v7QQ7oOh=OgQXDpNB7BW7rPwrc0L3SOQ@mail.gmail.com>
 <5cfba81b-fe73-b604-2442-011deee9bcb3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cfba81b-fe73-b604-2442-011deee9bcb3@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hrWNTq_v9cyAdEjhy6SxL49MXjfQ9GRt
X-Proofpoint-ORIG-GUID: 3ZVFLPFAR-BALWYgSXFyw_Eh-AkdkZ0h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_03:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140055
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2021 at 09:42:01AM +0200, David Hildenbrand wrote:
> On 13.04.21 19:53, Rafael J. Wysocki wrote:
> > On Tue, Apr 13, 2021 at 7:43 PM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 13.04.21 16:01, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
> > > > ACPI tables") attempted to address an issue with reserving the memory
> > > > occupied by ACPI tables, but it broke the initrd-based table override
> > > > mechanism relied on by multiple users.
> > > > 
> > > > To restore the initrd-based ACPI table override functionality, move
> > > > the acpi_boot_table_init() invocation in setup_arch() on x86 after
> > > > the acpi_table_upgrade() one.
> > > > 
> > > > Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> > > > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > > 
> > > > George, can you please check if this reintroduces the issue addressed by
> > > > the above commit for you?
> > > > 
> > > > ---
> > > >    arch/x86/kernel/setup.c |    5 ++---
> > > >    1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > Index: linux-pm/arch/x86/kernel/setup.c
> > > > ===================================================================
> > > > --- linux-pm.orig/arch/x86/kernel/setup.c
> > > > +++ linux-pm/arch/x86/kernel/setup.c
> > > > @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
> > > > 
> > > >        cleanup_highmap();
> > > > 
> > > > -     /* Look for ACPI tables and reserve memory occupied by them. */
> > > > -     acpi_boot_table_init();
> > > > -
> > > >        memblock_set_current_limit(ISA_END_ADDRESS);
> > > >        e820__memblock_setup();
> > > > 
> > > > @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
> > > >        reserve_initrd();
> > > > 
> > > >        acpi_table_upgrade();
> > > > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > > > +     acpi_boot_table_init();
> > > > 
> > > >        vsmp_init();
> > > 
> > > This is fairly late; especially, it's after actual allocations -- see
> > > e820__memblock_alloc_reserved_mpc_new().
> > > 
> > > Can't the table upgrade mechanism fix up when adjusting something?
> > 
> > Not at this point of the cycle I'm afraid.
> > 
> > > Some details on what actually breaks would be helpful.
> > 
> > Generally speaking, the table overrides that come from the initrd are
> > not taken into account if acpi_boot_table_init() runs before
> > acpi_table_upgrade() and the latter cannot run before
> > reserve_initrd().
> 
> I see. (looking at Documentation/acpi/initrd_table_override.txt I understand
> what acpi table overrides are for :) )
> 
> > 
> > Honestly, I'm not sure how much effort it would take to untangle this ATM.
> 
> Also true; ideally, we wouldn't have any allocations (find+reserve) before
> ordinary reservations are done.
> 
> However, I have no idea if we can move
> e820__memblock_alloc_reserved_mpc_new() and reserve_real_mode() around
> easily. Also, reserve_initrd()->relocate_initrd() does allocations.

Even if we can move e820__memblock_alloc_reserved_mpc_new() and
reserve_real_mode(), the allocation in reserve_initrd() has to be before
the tables override, we would only reduce the probability of allocating an
ACPI page.

I think what we can do is to override the ACPI tables separately from their
initial parsing. Rafael, what do you say?
 
> This is a mess.
 
True :(

-- 
Sincerely yours,
Mike.
