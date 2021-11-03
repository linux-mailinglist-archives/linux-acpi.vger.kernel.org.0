Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798B5443D55
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 07:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKCGmA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 02:42:00 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:3280 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCGmA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 02:42:00 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A34WCqo006017;
        Wed, 3 Nov 2021 06:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=WnhqCie5YsZt9qKw2Czm27HaCVvnrzCh5gAGwnUrxBM=;
 b=oTgNgtaHNl/c7E3/NEDf9xOkRaxqmm86ZDoGbT4P24gJuMWA8rwZg06Tj6x9xZ/WHNfk
 tu+fOlQjiOQB0BHtmabBX3B+rI6mTowZHk21J87o8Qm1g/toi0C9Mx/5pYPP9fXcHb/J
 gxkgx0sytUMLsOpT8NQd9kxCLiAKaq6vv2EQTUF6a3QPjDEnjTDWFTfDqk1slB1keRPC
 E/viEItHbpfg0Il77Noa3gj4iRCx0KObwLYSYwddp6d6gCBI8wqueCCIH7bj1A/MEtAL
 v/+eedPIAZ6mI8ePU9BPQ5FutHtEDvC47V/iXzLQXlyMZsdlmqGZghbIRj2U3ThLfD5u Fw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 3c3e71ash6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 06:39:23 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 143D75C;
        Wed,  3 Nov 2021 06:39:23 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.asiapacific.hpqcorp.net [15.119.205.146])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id B7DC655;
        Wed,  3 Nov 2021 06:39:21 +0000 (UTC)
Date:   Wed, 3 Nov 2021 14:39:20 +0800
From:   James Liu <james.liu@hpe.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.chang@hpe.com, clayc@hpe.com
Subject: Re: [PATCH] ACPI: OSL: Handle the return value of
 acpi_os_map_generic_address() for a non-register GAS
Message-ID: <20211103063920.GB4546@blofly.tw.rdlabs.hpecorp.net>
References: <20211022011833.24308-1-james.liu@hpe.com>
 <CAJZ5v0iaiZTCSqLgC8X03118m4WL2AGvQiGh+bo2KMho9MZZXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iaiZTCSqLgC8X03118m4WL2AGvQiGh+bo2KMho9MZZXA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: cG9gw3XBdPmR2Gwtj3dLz2KeiqegpZLS
X-Proofpoint-GUID: cG9gw3XBdPmR2Gwtj3dLz2KeiqegpZLS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030041
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 04:55:59PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 22, 2021 at 3:18 AM <james.liu@hpe.com> wrote:
> >
> > From: James Liu <james.liu@hpe.com>
> >
> > Modify acpi_os_map_generic_address() to correctly handle a non-register
> > GAS (i.e., a pointer to a data structure), whose bit width is expected
> > to be 0 according to Table 5.1 in ACPI spec. 6.4.
> >
> > For example, the RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS is a
> > non-register GAS, which points to a data structure whose format is defined
> > in Table 18.30 in ACPI Spec. 6.4.
> 
> IIUC, the RegisterRegion field is defined in Section 18.6.2 that says
> "This structure describes the physical address of a register as well
> as the bit range that corresponds to a desired region of the
> register".  This doesn't appear to be a non-register GAS to me.
>
Sorry, my description is improper.
I will rewrite it as "a GAS of a data structure".
 
> > This fix can prevent EINJ (Error Injection module) from loading failure
> > when a platform firmware can correctly support the format of Injection
> > Instruction Entry in an EINJ table.
> >
> > Signed-off-by: James Liu <james.liu@hpe.com>
> > ---
> >  drivers/acpi/osl.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 45c5c0e45e33..74de9341fadf 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -456,13 +456,23 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
> >
> >         if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >                 return NULL;
> > +       /* Handle a non-register GAS (i.e., a pointer to a data structure),
>

Thanks, I will update it in the next version.
 
> Check CodingStyle for the expected format of comments.
> 
> > +        * whose bit width is expected to be 0 according to ACPI spec. 6.4.
> > +        * For example, The RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS
> > +        * points to a data structure whose format is defined in Table 18.30 in
> > +        * ACPI Spec. 6.4
> > +        */
> > +       if (!gas->bit_width) {
> > +               pr_info("Mapping IOMEM for a non-register GAS.\n");
> > +               return  acpi_os_map_iomem(addr, sizeof(unsigned long long));
> 
> It is not clear to me at all why sizeof(unsigned long long) is the
> right size to use here.
>
It can be set as sizeof(addr) to avoid returning NULL when gas->bit_width equals 0,  
which means a GAS is used as a pointer to a data structure.
 
> IIUC, there is a data structure located at addr that needs to be
> accessed, but what if it is larger than the above size?
>
Your concern is correct. The size of iomem mapped at addr depends on the data 
structure used in the ACPI context (e.g., 36 bytes is for the data structure of
SET_ERROR_TYPE_WITH_ADDRESS). 

We could better defer the exact mapping to user/platform modules since the data 
structure information is neither defined in Address Space ID nor passed as an 
argument of acpi_os_map_generic_address().

Thus, this fix just makes sure EINJ can *still* be successfully loaded if OS modules
only use SET_ERROR_TYPE_WITHOUT_ADDRESS even though a platform firmware claims to
support SET_ERROR_TYPE_WITH_ADDRESS. To be more specific, this can avoid
pr_err("Error pre-mapping GARs.\n")in drivers/acpi/apei/einj.c.

> > +       }
> >
> >         /* Handle possible alignment issues */
> >         memcpy(&addr, &gas->address, sizeof(addr));
> > -       if (!addr || !gas->bit_width)
> > +       if (!addr)
> >                 return NULL;
> > -
> > -       return acpi_os_map_iomem(addr, gas->bit_width / 8);
> > +       else
> > +               return acpi_os_map_iomem(addr, gas->bit_width / 8);
> >  }
> >  EXPORT_SYMBOL(acpi_os_map_generic_address);
> >
> > --
