Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B161733482D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhCJTkz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 14:40:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12456 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233898AbhCJTkt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Mar 2021 14:40:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJbuZs170817;
        Wed, 10 Mar 2021 14:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/KUdtckSygLDugrrBHMuewBEh3FNf0o9H7ah6gI+3UA=;
 b=aKYZ0JIA4UYH3fRZ6iF8IKdqyyK1fZr9gXXcZT9LppcSr6APRL+v8KGcV5B0imaBP8Al
 NXFlPrkMj7iNPk0hCrZbhRKdH7kdWzuCr+B2OZ8U6AxymcSXImhmoTl9w8rDDGXO69ca
 c6rOFtvnHuUiMAhVl+//OAlOCqXVcKzmsvda4FPwSCazQKnCApiJMJNxhpRXetztpDGX
 2CiHWrL0wf3vd1VZp+gDB7/BlStPDOBtwiWAmh8+/jbKZkCMPhkJb/FKyMiIvubZtpdw
 UKpP6p72+e0/PnsTbzzhB2KNUb5WOqVoXXuR0MMaiLYSVgaigK8R6nYy+uTeZpKw+Npa kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774ek02g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 14:40:36 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AJcKrW171599;
        Wed, 10 Mar 2021 14:39:54 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774ek0193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 14:39:54 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AJZGwd010776;
        Wed, 10 Mar 2021 19:38:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4h90m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 19:38:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AJcS0o29295074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:38:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7CA811C04C;
        Wed, 10 Mar 2021 19:38:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB5D511C058;
        Wed, 10 Mar 2021 19:38:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Mar 2021 19:38:41 +0000 (GMT)
Date:   Wed, 10 Mar 2021 21:38:39 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
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
Message-ID: <YEkgP0G94uQBGDa9@linux.ibm.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
 <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
 <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100092
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 10, 2021 at 08:10:42PM +0100, David Hildenbrand wrote:
> 
> > > > Memory gets allocated and used in a different order, which seems to have
> > > > exposed (yet another) latent BUG.
> > > 
> > > Well, you can call it that, or you can say that things worked under
> > > certain assumptions regarding the memory allocation order which are
> > > not met any more.

Regardless of the assumptions in the page allocator we had a page used by
the firmware on a free list, which is a bug.

> > > > The same could be reproduced via zone shuffling with a little luck.
> > > 
> > > But nobody does that in practice.
> > > 
> 
> Dan will most certainly object. And I don't know what makes you speak in
> absolute words here.
> 
> > > This would be relatively straightforward to address if ACPICA was not
> > > involved in it, but unfortunately that's not the case.
> > > 
> > > Changing this part of ACPICA is risky, because such changes may affect
> > > other OSes using it, so that requires some serious consideration.
> > > Alternatively, the previous memory allocation order in Linux could be
> > > restored.
> > 
> > Of course, long-term this needs to be addressed in the ACPI
> > initialization code, because it clearly is not robust enough, but in
> > the meantime there's practical breakage observable in the field, so
> > what can be done about that?
> 
> *joke* enable zone shuffling.
> 
> No seriously, fix the latent BUG. What again is problematic about excluding
> these pages from the page allcoator, for example, via memblock_reserve()?
> 
> @Mike?

There is some care that should be taken to make sure we get the order
right, but I don't see a fundamental issue here.

If I understand correctly, Rafael's concern is about changing the parts of
ACPICA that should be OS agnostic, so I think we just need another place to
call memblock_reserve() rather than acpi_tb_install_table_with_override().

Since the reservation should be done early in x86::setup_arch() (and
probably in arm64::setup_arch()) we might just have a function that parses
table headers and reserves them, similarly to how we parse the tables
during KASLR setup.

-- 
Sincerely yours,
Mike.
