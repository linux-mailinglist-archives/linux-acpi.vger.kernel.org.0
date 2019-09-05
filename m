Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A8AAD85
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 23:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390797AbfIEVB5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 17:01:57 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:40220 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728685AbfIEVB5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 17:01:57 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85Kxn3w002064;
        Thu, 5 Sep 2019 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=x9bG+oP8UsCnm6ozpC2cVF0PtYWytGD0x8rUKX3j6j0=;
 b=HX6uDx0C7LyJrj6aML2wTH4tkuXJaS+RK/Ezk92W1FSu9tfPvlHlEiWZMDTdgcATiwS0
 42jVeh+Hb2ScBw6I0tIHwoGL3dW/de3EWSJdxvYhv2lYqYUg7uX6M1urQ/6e9k3Pwg+j
 EqAPeWDxdj+8M9S1llKEAosrmKibwTjBY3tB/7hXIPp5R+8yWsmis0khUNmplhNXaVfd
 QIoLai0aswchy8qhmRefY/MAgKP7h52El8F1fRuq3imGUrFo+lFE9hP/uaqusd3E9uKu
 HaUQPHNvNOStApolRq2zjeQbYKhWNtF9HO1+CuZbDx3yuZaWN1zqKdPSXHJ/pkkk3Fwx vg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2uqm7jq1b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 17:01:56 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85Kw9EQ112094;
        Thu, 5 Sep 2019 17:01:55 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2uqkhffvgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 17:01:55 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1294303124"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Topic: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Thread-Index: AQHVZCwTRTL5ZMYdHkq49OEeo/k+tA==
Date:   Thu, 5 Sep 2019 21:01:53 +0000
Message-ID: <1567717313153.65736@Dellteam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_08:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=526 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050196
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=621 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909050196
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In recent testing of a Dell Universal Dock D6000, I found that MAC=0A=
address pass through is not supported in the Linux drivers.  However,=0A=
this same device is supported in Windows 10 (Pro) on my personal=0A=
computer, in as much as I was able to tell Windows to assign a new MAC=0A=
address of my choosing, and I saw through wireshark the new MAC address=0A=
was pushed out to the device.  Afterward, Windows reported a new IP=0A=
address and I was able to view web pages.=0A=
=0A=
This series of patches give support to cdc_ncm USB based Ethernet=0A=
controllers for programming a MAC address to the device, and also to=0A=
retrieve the device's MAC address.  This patch series further adds ACPI=0A=
MAC address pass through support specifically for the cdc_ncm driver, and=
=0A=
generally for any other driver that may need or want it, in furtherance of=
=0A=
Dell's enterprise IT policy efforts.  It was this latter that I initially=
=0A=
found lacking when testing a D6000 with a Dell laptop, and then I found=0A=
ifconfig was unable to set a MAC address into the device.  These patches=0A=
bring a similar level of functionality to cdc_ncm driver as is available=0A=
with the Realtek r8152 driver, and is available with Windows.=0A=
=0A=
The cdc_ncm driver limits the ACPI MAC address pass through support to=0A=
only the Dell Universal Dock D6000, so no other cdc_ncm device will be=0A=
impacted.=0A=
=0A=
Charles Hyde (3):=0A=
  net: cdc_ncm: add get/set ethernet address functions=0A=
  ACPI: move ACPI functionality out of r8152 driver=0A=
  net: cdc_ncm: Add ACPI MAC address pass through functionality=0A=
=0A=
 drivers/acpi/Makefile            |   1 +=0A=
 drivers/acpi/acpi_mac_passthru.c |  63 +++++++++++++=0A=
 drivers/net/usb/cdc_ncm.c        | 148 ++++++++++++++++++++++++++++---=0A=
 drivers/net/usb/r8152.c          |  44 +--------=0A=
 include/acpi/acpi_mac_passthru.h |  29 ++++++=0A=
 5 files changed, 234 insertions(+), 51 deletions(-)=0A=
 create mode 100644 drivers/acpi/acpi_mac_passthru.c=0A=
 create mode 100644 include/acpi/acpi_mac_passthru.h=0A=
=0A=
-- =0A=
2.20.1=0A=
