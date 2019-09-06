Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5343BABF47
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfIFSTr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 14:19:47 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:5890 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730881AbfIFSTr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 14:19:47 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86IA1Tq000810;
        Fri, 6 Sep 2019 14:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YB/kOC8ZWJlrYMhzEovQRsZUGkZZfBOjO9qedOnCFGA=;
 b=Abdy0jqmSGTPKvJlzjpEfT04aLjBZ3xIJ9k/d4zISCF9ZEBq1uaCo9pgcR3T2Uf8vGum
 wLZALxgCYCnLEt/Ca+L3NVNPA0aVBYVEf6LoCa/CA3UJPtnpA4y3Lqe4b9rd/1gw3xIC
 4zYSCyEmAACGxTt2q99/65RRxG/4eW8MKoVV1r2J9SCC7rO4/0kGJlKSlhCjaqomcn6r
 xGtR4Isi/NrV/NEiB0xI3cTexFFKL8bdRhLCJMSz83GwMaVBGDx4+qLglm+5TpHAR2qn
 6lMZCFryQOOl5zsWG50wWiZJWTswbsaVY6RWUKrMl0l5u6raI1tO+v1cTlF7midfPkmq 2w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uqmr0v0j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 14:19:45 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86IDZVS042249;
        Fri, 6 Sep 2019 14:19:44 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2uu3x28mv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:19:44 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="393526737"
From:   <Charles.Hyde@dellteam.com>
To:     <stern@rowland.harvard.edu>
CC:     <bjorn@mork.no>, <oliver@neukum.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <Mario.Limonciello@dell.com>,
        <chip.programmer@gmail.com>, <nic_swsd@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVZCzhVbpOtOy+DEKwLQ92ABp4yKceW3ikgACI4XCAAGUoAP//rQLA
Date:   Fri, 6 Sep 2019 18:19:37 +0000
Message-ID: <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
References: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
 <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-06T18:19:36.2181054Z;
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
 definitions=2019-09-06_07:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060193
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060193
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > <snipped>
> > > > +	ret =3D usbnet_read_cmd(dev, USB_CDC_GET_NET_ADDRESS,
> > > > +			      USB_DIR_IN | USB_TYPE_CLASS
> > > > +			      | USB_RECIP_INTERFACE, 0,
> > > > +			      USB_REQ_SET_ADDRESS, buf, ETH_ALEN);
> > >
> > > Where did that USB_REQ_SET_ADDRESS come from? Did you just look up
> > > an arbutrary macro that happened to match your device config?  How
> > > do you expect this to work with a generic NCM device?  Or even your
> > > own device, when the next firmware revision moves the function to a
> different interface?
> > <snipped>
> >
> > https://wiki.osdev.org/Universal_Serial_Bus#SET_ADDRESS
> >
> > https://www.usb.org/document-library/network-control-model-devices-spe
> > cification-v10-and-errata-and-adopters-agreement
> > Download and view the NCM specification v1.0 (Errata 1), dated November
> 24, 2010.  See table 6.2 on page 30.  Also see sections 6.2.2 and 6.2.3 o=
n page
> 32.
> >
> > USB_REQ_SET_ADDRESS came from include/uapi/linux/usb/ch9.h.  This
> matches the SET_ADDRESS definition from the osdev wiki page, so I used it
> because the name and numeric values both matched.  It further matches wha=
t
> the Windows driver issues.
>=20
> The names and values may match, but the meanings do not.
> USB_REQ_SET_ADDRESS refers to a USB bus address, not a MAC address.
>=20
> Alan Stern


What better suggestion do folks have, instead of using USB_REQ_SET_ADDRESS?

Thank you,
Charles
