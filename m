Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E034332FC5
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 21:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCIUUE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 15:20:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10684 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhCIUTg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 15:19:36 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129KEMmm145065;
        Tue, 9 Mar 2021 15:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aS1Aa9fTZPc17/c+7pqDOz2pDumYV23TjqmU+LSMAOo=;
 b=l1HCX84DeDgONbHKAiKDvthvg1br726HpMhKQ26VclKhgoGaBj0/oaKCpB1EqLGYj9pA
 78JN6jUNR1Y1LDguDXOaaGVJmliy1GSC1S9r82I6eebftQOHXk8aREzEIsRFZNoHGSQu
 8UzWHPul9qyoITPDwxMoUBULvasv06r8dCVzSc6RvAR+lBAUA0PDKRGA8LOnsASugtKS
 V0gqqW17aIQSMWweo6wSCJMpChsD1MZwTWp/c7Ag3frWCd9WjZTBOOmuoyT8EdsJB5zP
 57MdXVn48yNyHygw7zftAQ1gsbRfM6R/jCeXgBaau50ay0l+uKpWdwFiix29pJ2F6TAI MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376fvm83n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 15:19:23 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129KEYCU145985;
        Tue, 9 Mar 2021 15:17:27 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376fvm837k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 15:17:26 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 129K7vW6026055;
        Tue, 9 Mar 2021 20:16:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3768n606pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 20:16:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129KGVgu46268922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 20:16:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED0AC11C04C;
        Tue,  9 Mar 2021 20:16:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F1E11C052;
        Tue,  9 Mar 2021 20:16:26 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Mar 2021 20:16:26 +0000 (GMT)
Date:   Tue, 9 Mar 2021 22:16:23 +0200
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
Message-ID: <YEfXl38hFc0jSsXm@linux.ibm.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <YESEymRQ2/F7xJGt@linux.ibm.com>
 <YEe2SAESEaEak+HB@linux.ibm.com>
 <CAJZ5v0hAQo7+3bthoC8K7n7qyhQFMuOd8U3BhZWSREjPmq0-7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hAQo7+3bthoC8K7n7qyhQFMuOd8U3BhZWSREjPmq0-7w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_15:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090096
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 09, 2021 at 07:29:51PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 9, 2021 at 6:54 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Sun, Mar 07, 2021 at 09:46:22AM +0200, Mike Rapoport wrote:
> > > Hello Rafael,
> > >
> > > On Fri, Mar 05, 2021 at 02:30:07PM +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 5, 2021 at 12:14 AM George Kennedy <george.kennedy@oracle.com> wrote:
> > > >
> > > > > The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> > > > > page for the ibft table is not reserved, so it can end up on the freelist.
> > > >
> > > > You appear to be saying that it is not sufficient to kmap() a page in
> > > > order to use it safely.  It is also necessary to reserve it upfront,
> > > > for example with the help of memblock_reserve().  Is that correct?  If
> > > > so, is there an alternative way to reserve a page frame?
> > >
> > > Like David said in the other reply, if a BIOS does not mark the memory that
> > > contains an ACPI table as used (e.g. reserved or ACPI data), we need to
> > > make sure the kernel knows that such memory is in use and an early call to
> > > memblock_reserve() is exactly what we need here.
> > > George had this issue with iBFT, but in general this could be any table
> > > that a buggy BIOS forgot to mark as ACPI data.
> >
> > BTW, I wonder is there a fundamental reason to use ioremap() to access ACPI
> > tables at all?
> > In the end, they reside in RAM and, apparently, they live at the same DIMM
> > as neighboring "normal memory" so why cannot we just map them normally as
> > read-only not executable?
> 
> This may be NVS memory (depending on the configuration of the system)
> which isn't "normal" RAM AFAICS.

Hmm, according to the description of "ACPI NVS" in ACPI 6.3

	ACPI NVS Memory. This range of addresses is in use or reserved by
			 the system and must not be used by the operating
			 system. This range is required to be saved and
 			 restored across an NVS sleep.

it behaves more like "normal" RAM rather than actual non-volatile storage.

There are other places in ACPI text that imply that "ACPI NVS" is actually
RAM, it's just reserved by the firmware.

And judging by the example below both "ACPI data" and "ACPI NVS" live in
the very same DIMM as "usable" RAM.

[    0.000000] BIOS-e820: [mem 0x0000000029931000-0x0000000029932fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029933000-0x000000002993afff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000002993b000-0x000000002993bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000002993c000-0x0000000029940fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029941000-0x0000000029944fff] usable

Unfortunately, both UEFI and ACPI standards are very vague about the
meaning of "ACPI NVS" so there may be systems that use real non-volatile
storage for it...

-- 
Sincerely yours,
Mike.
