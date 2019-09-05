Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5AAADA9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 23:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfIEVOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 17:14:10 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:21682 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbfIEVOK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 17:14:10 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85LAEP3025646;
        Thu, 5 Sep 2019 17:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=+jq7grcpY34tFciJAAXZQnXIoduIjVOoyKqR6xJ1bmI=;
 b=f+yv0Fmy6Na/vEfBU9ibPVT6cmijwbQTNXOP6z7fcPkBeUYhgjSDIuarW0hXKomBgCfm
 2Fq6riA4dNIEZXMBtFNbpn7SNcUzYNlgzNoed29edBi5kPlul94WNcfOJKbEv4UpMsAC
 YfXsOEtnO2R9hzvvMAprWm1+ZzdB87mj6sD0b595WGPaVzxvuuh6cpplCIT1t6y3koFo
 K8I6MOhVVNJPtBa0Iw2HPyEo1tIefDmO2sLWE/BIfHz0NsSIGJUQAci0s8wVb5ady5hK
 7uai+nC8DXGItNo9epn2vfxUwT65myGnl7EvRV+cdREVIgEWQGzt8JgH3ktTCz0Th723 7Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uqkf8yf0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 17:14:08 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85LDFLa141616;
        Thu, 5 Sep 2019 17:14:07 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2ur5ykj8qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 17:14:07 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="418917019"
From:   <Charles.Hyde@dellteam.com>
To:     <Mario.Limonciello@dell.com>, <oliver@neukum.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <chip.programmer@gmail.com>, <nic_swsd@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Topic: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Index: AQHVZCwTRTL5ZMYdHkq49OEeo/k+tKcdkjpQgAACzEA=
Date:   Thu, 5 Sep 2019 21:14:05 +0000
Message-ID: <67e340c684a64e528b04276f715567cc@AUSX13MPS307.AMER.DELL.COM>
References: <1567717313153.65736@Dellteam.com>
 <e41270463c46445d82415d86bebc9566@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <e41270463c46445d82415d86bebc9566@AUSX13MPC101.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-05T21:04:57.7352618Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_08:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050198
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909050198
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > -----Original Message-----
> > From: Hyde, Charles - Dell Team
> > Sent: Thursday, September 5, 2019 4:02 PM
> > To: Oliver Neukum; "Rafael J. Wysocki"; Len Brown
> > Cc: Limonciello, Mario; chip.programmer@gmail.com; Realtek linux nic
> > maintainers; linux-usb@vger.kernel.org; linux-acpi@vger.kernel.org
> > Subject: [PATCH 0/3] Add get/set ethernet address functions and ACPI
> > MAC address pass through functionality to cdc_ncm driver
> >
> > In recent testing of a Dell Universal Dock D6000, I found that MAC
> > address pass through is not supported in the Linux drivers.  However,
> > this same device is supported in Windows 10 (Pro) on my personal
> > computer, in as much as I was able to tell Windows to assign a new MAC
> > address of my choosing, and I saw through wireshark the new MAC
> > address was pushed out to the device.  Afterward, Windows reported a
> > new IP address and I was able to view web pages.
> >
> > This series of patches give support to cdc_ncm USB based Ethernet
> > controllers for programming a MAC address to the device, and also to
> > retrieve the device's MAC address.  This patch series further adds
> > ACPI MAC address pass through support specifically for the cdc_ncm
> > driver, and generally for any other driver that may need or want it,
> > in furtherance of Dell's enterprise IT policy efforts.  It was this
> > latter that I initially found lacking when testing a D6000 with a Dell
> > laptop, and then I found ifconfig was unable to set a MAC address into
> > the device.  These patches bring a similar level of functionality to
> > cdc_ncm driver as is available with the Realtek r8152 driver, and is av=
ailable
> with Windows.
> >
> > The cdc_ncm driver limits the ACPI MAC address pass through support to
> > only the Dell Universal Dock D6000, so no other cdc_ncm device will be
> > impacted.
> >
> > Charles Hyde (3):
> >   net: cdc_ncm: add get/set ethernet address functions
> >   ACPI: move ACPI functionality out of r8152 driver
> >   net: cdc_ncm: Add ACPI MAC address pass through functionality
> >
> >  drivers/acpi/Makefile            |   1 +
> >  drivers/acpi/acpi_mac_passthru.c |  63 +++++++++++++
> >  drivers/net/usb/cdc_ncm.c        | 148 ++++++++++++++++++++++++++++---
> >  drivers/net/usb/r8152.c          |  44 +--------
> >  include/acpi/acpi_mac_passthru.h |  29 ++++++
> >  5 files changed, 234 insertions(+), 51 deletions(-)  create mode
> > 100644 drivers/acpi/acpi_mac_passthru.c  create mode 100644
> > include/acpi/acpi_mac_passthru.h
> >
> > --
> > 2.20.1
>=20
> Typical practice is to make this new patch series prefixed with a v2. And=
 to
> describe what has changed From v1 either in individual patches below the =
'--'
> or in the cover letter.
>=20
> So can you please describe what changed from previous submission in case =
it's
> not obvious to reviewers?
>=20
> For example:
>=20
> [PATCH v2 0/3] Add get/set ethernet address functions and ACPI MAC addres=
s
> pass through functionality to cdc_ncm driver
>=20
> Changes from v1 to v 2:
> * Changed foo to bar


Ah, my apologies.

What changed with today's patch series from what I proposed on Friday, Augu=
st 30, is that I created a function named get_ethernet_addr() which replace=
s two instances where the same code snippet was located in the previous pat=
ch series.  I also created a post reset function to set the MAC address, if=
 there exists an ACPI MAC address pass through (MAPT).  Oliver Neukum had r=
equested a post reset function for this purpose.

Charles Hyde
