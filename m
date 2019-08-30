Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1EA3E7A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3Tg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 15:36:26 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:53460 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbfH3Tg0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 15:36:26 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJYnZv011538;
        Fri, 30 Aug 2019 15:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=KiixhnD1Pq4dIXmN0767lQIU72s1aBJLx/6cjCEliac=;
 b=YwGSkHchj4MXreruFMPgy91cE2yM4x6sTVUrmIR5J/EmWoKB1Sy03xEF959NIwZAtLGW
 p1yevMrGAiDX/X+xT6GOJoimRt9BNym6lzeyKmyPqUhpia98WuKtsvTmPabN3G4/5e6E
 lBBEVhflvklNN9uBDGsIvVDTloHijVLwQVMfTPGuy8FFkXw/9Q+Eu70QAVKG3m1P/l5n
 EeK2J8Ml6Meo85Im8T7m/ZPfMyx3yS8uPT6OpXqgcxV0z/KwEmJf4EM1NoGoZh3VUa4n
 H8u+XJx+BYzslBa3iI1S/yl9qujTNGKMGSTQRKMfsV4k4dSbgC5dOZfYjRD9abaOuIqd YQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2xjcybn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 15:36:24 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJX8jg030741;
        Fri, 30 Aug 2019 15:36:24 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2up8vpcs84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 15:36:24 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1292046787"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <nic_swsd@realtek.com>, <Mario.Limonciello@dell.com>
Subject: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Topic: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Index: AQHVX2iIRQPrhZWsvkKRPPIO0hmaNA==
Date:   Fri, 30 Aug 2019 19:36:22 +0000
Message-ID: <1567193782174.28980@Dellteam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.68]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_07:2019-08-29,2019-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=511 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908300184
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxlogscore=608 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908300184
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In recent testing of a Dell Universal Dock D6000, I found that MAC =0A=
address pass through is not supported in the Linux drivers.  However, =0A=
this same device is supported in Windows 10 (Pro) on my personal =0A=
computer, in as much as I was able to tell Windows to assign a new MAC =0A=
address of my choosing, and I saw through wireshark the new MAC address =0A=
was pushed out to the device.  Afterward, Windows reported a new IP =0A=
address and I was able to view web pages.=0A=
=0A=
This series of patches give support to cdc_ncm USB based Ethernet =0A=
controllers for programming a MAC address to the device, and also to =0A=
retrieve the device's MAC address.  This patch series further adds ACPI =0A=
MAC address pass through support specifically for the cdc_ncm driver, and =
=0A=
generally for any other driver that may need or want it, in furtherance of =
=0A=
Dell's enterprise IT policy efforts.  It was this latter that I initially =
=0A=
found lacking when testing a D6000 with a Dell laptop, and then I found =0A=
ifconfig was unable to set a MAC address into the device.  These patches =
=0A=
bring a similar level of functionality to cdc_ncm driver as is available =
=0A=
with the Realtek r8152 driver, and is available with Windows.=0A=
=0A=
The cdc_ncm driver limits the ACPI MAC address pass through support to =0A=
only the Dell Universal Dock D6000, so no other cdc_ncm device will be=0A=
impacted.=0A=
=0A=
Charles Hyde (3):=0A=
  net: cdc_ncm: add get/set ethernet address functions=0A=
  ACPI: move ACPI functionality out of r8152 driver=0A=
  net: cdc_ncm: Add ACPI MAC address pass through functionality=0A=
=0A=
 drivers/acpi/Makefile            |   1 +=0A=
 drivers/acpi/acpi_mac_passthru.c |  63 ++++++++++++++=0A=
 drivers/net/usb/cdc_ncm.c        | 141 ++++++++++++++++++++++++++++++-=0A=
 drivers/net/usb/r8152.c          |  44 +---------=0A=
 include/acpi/acpi_mac_passthru.h |  29 +++++++=0A=
 5 files changed, 234 insertions(+), 44 deletions(-)=0A=
 create mode 100644 drivers/acpi/acpi_mac_passthru.c=0A=
 create mode 100644 include/acpi/acpi_mac_passthru.h=0A=
=0A=
-- =0A=
2.20.1=0A=
