Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB263864
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfGIPLU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 11:11:20 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7044 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfGIPLU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jul 2019 11:11:20 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69FAGw0004437;
        Tue, 9 Jul 2019 11:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=TBZk+yNP+qC/18ws2gniZavlYQC4RNmmueO8uKxargU=;
 b=bWMSVZHr1Mo9mgSdsfe06Z2aeZFtLiWrAxC0f6DbWqMbKFEAzP9TjvEj80QWb/Qzqcxo
 xfaVrVMoSSKOpT9P2tlr37qgGNQukb8KkKghdUvfaa5G3aa7+51QSeWX0KbEulwWkyuz
 FfZ//m9RgCurJsQ6mfNoSpTf1xmrC+ELorPl0WXLObA8/atDZFaCvWwD468Ni/zEkBp9
 01AhaQgl2/dOwcsW3xnkCdmyVIELvXcWAwHXhOiJWXDfs0bA5YIeHV4RsT50ASh3DPeO
 zdTbvWrwns9llJZ4gDNtlANe29jqeWuweXd4zDv4BF50sFOQPe55hXw/UTk3CmQ9NdjV kw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2tmnwgj1s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 11:11:19 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69EvqDk190682;
        Tue, 9 Jul 2019 11:11:18 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2tjp9g00fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 11:11:18 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1268810633"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <yehezkelshb@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <lukas@wunner.de>, <anthony.wong@canonical.com>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct
 icm
Thread-Topic: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct
 icm
Thread-Index: AQHVMxgohJgdbkcrxkC2VFkyEZprd6a8LTOAgAABhYCABjudQA==
Date:   Tue, 9 Jul 2019 15:11:15 +0000
Message-ID: <23cca57934d24eb6b897ebf00f852128@AUSX13MPC105.AMER.DELL.COM>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-3-mika.westerberg@linux.intel.com>
 <CA+CmpXt5q93e2TQJzfY4afSEMPWijPU+Ks+cgrVDVqUM4=y3Cw@mail.gmail.com>
 <20190705105815.GT2640@lahna.fi.intel.com>
In-Reply-To: <20190705105815.GT2640@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-07-09T15:11:14.3744530Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=787 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090179
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=866 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090180
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Friday, July 5, 2019 5:58 AM
> To: Yehezkel Bernat
> Cc: LKML; Andreas Noever; Michael Jamet; Rafael J . Wysocki; Len Brown; L=
ukas
> Wunner; Limonciello, Mario; Anthony Wong; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to st=
ruct
> icm
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Fri, Jul 05, 2019 at 01:52:49PM +0300, Yehezkel Bernat wrote:
> > > @@ -2054,6 +2059,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
> > >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
> > >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
> > >                 icm->max_boot_acl =3D ICM_AR_PREBOOT_ACL_ENTRIES;
> > > +               icm->can_upgrade_nvm =3D true;
> >
> > Shouldn't this be also !x86_apple_machine just like AR?
> > (For FR, we don't use ICM on Apple machines, as much as I remember, so =
it's fine
> > to enable it there unconditionally for ICM code path.)
>=20
> Yes, good point. I'll fix it up.

Another thought - does the TR or AR ID's setting can_upgrade_nvm to !x86_ap=
ple_machine
show up in anything like a dock or is it only host controllers?  If it's in=
 docks, then it might be worth
only blocking on apple if it's a host.
