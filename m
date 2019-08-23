Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E219B88A
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfHWWZh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Aug 2019 18:25:37 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:20912 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbfHWWZg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Aug 2019 18:25:36 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMJV46011478;
        Fri, 23 Aug 2019 18:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=qdwOFLeBcJUtJ9ZssAGRqjii4Pt80pTQpheBzEYBa+Q=;
 b=oYyKrwSPquznnspp8AqKUyEEe5L1I/G0HLuu3nbP3qA+NAnHNBLYzZbQmnKlWNofRb4d
 XK6hzy5i5y3gG9FEao0678MmDuvePfYTaq2QkfwLP/jkNC05qnxlCvK9Q0cokbN/Ph8Z
 7IpZm1HFzMggjskkWBkPucX22+iUbpvTduCRstEWCfD/U3OujMajoYHLBohSc8V4g0g3
 DKbfW7KsD2z2SKAB5mmGiHiQjMCk/y+9r6DUjs4R+JzZEjXHGD49rZseXfYdSN7LCGqP
 np1oBJOzBgUj+1SoeIenASMOIlHXUtw6MflOg+hyhGm2YXsPNm0p7jcp944JT9/fmu1n Hw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2ujpux8dbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 18:25:35 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMMit4141263;
        Fri, 23 Aug 2019 18:25:34 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2ujpcgj3a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 18:25:33 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="364648682"
From:   <Charles.Hyde@dellteam.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <Mario.Limonciello@dell.com>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: [RFC 0/3] Add support into cdc_ncm for MAC address pass through
Thread-Topic: [RFC 0/3] Add support into cdc_ncm for MAC address pass through
Thread-Index: AQHVWf/CIeynkNmpu0qa16VBRcYrmw==
Date:   Fri, 23 Aug 2019 22:25:31 +0000
Message-ID: <1566599131748.86079@Dellteam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=300 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230211
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=390 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908230211
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is my second iteration of proposed code changes, based on feedback fro=
m the first iteration.  I dropped my original changes to usb/core and usbne=
t, in favor of keeping the needed get/set ethernet address functions in cdc=
_ncm driver.  The changes in cdc_ncm driver reflect similar code in at leas=
t one other driver, namely aqc111.  Furthermore, the system used for testin=
g is a chromebook that lacks iproute2, so I used ifconfig, debugging messag=
es, and other chromebook tools to ensure these changes work as intended.=0A=
=0A=
In recent testing of a Dell Universal Dock D6000, I found that MAC address =
pass through is not supported in the Linux drivers.  However, this same dev=
ice is supported in Windows 10 (Pro) on my personal computer, in as much as=
 I was able to tell Windows to assign a new MAC address of my choosing, and=
 I saw through wireshark the new MAC address was pushed out to the device. =
 Afterward, Windows reported a new IP address and I was able to view web pa=
ges.=0A=
=0A=
This series of patches give support to cdc_ncm USB based Ethernet controlle=
rs for programming a MAC address to the device, and also to retrieve the de=
vice's MAC address.  This patch series further adds ACPI MAC address pass t=
hrough support specifically for the cdc_ncm driver, and generally for any o=
ther driver that may need or want it, in furtherance of Dell's enterprise I=
T policy efforts.  It was this latter that I initially found lacking when t=
esting a D6000 with a Dell laptop, and then I found ifconfig was unable to =
set a MAC address into the device.  These patches bring a similar level of =
functionality to cdc_ncm driver as is available with the Realtek r8152 driv=
er, and is available with Windows.=0A=
=0A=
Charles Hyde (3):=0A=
  net: cdc_ncm: add get/set ethernet address functions=0A=
  ACPI: move ACPI functionality out of r8152 driver=0A=
  net: cdc_ncm: Add ACPI MAC address pass through functionality=0A=
=0A=
 drivers/net/usb/cdc_ncm.c        | 121 ++++++++++++++++++++++++++++++-=0A=
 drivers/net/usb/r8152.c          |  44 +----------=0A=
 include/acpi/acpi_mac_passthru.h |  16 ++++=0A=
 lib/Makefile                     |   3 +-=0A=
 lib/acpi_mac_passthru.c          |  61 ++++++++++++++++=0A=
 5 files changed, 200 insertions(+), 45 deletions(-)=0A=
 create mode 100644 include/acpi/acpi_mac_passthru.h=0A=
 create mode 100644 lib/acpi_mac_passthru.c=0A=
=0A=
-- =0A=
2.20.1=
