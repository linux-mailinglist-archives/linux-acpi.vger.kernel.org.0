Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860B1C3EB3
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEDPjJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 11:39:09 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:16900 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgEDPjJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2020 11:39:09 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FcxeZ018780;
        Mon, 4 May 2020 11:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=O2WbsxsZuUPSXf26/rBUiMV6gTfnpKukAyM0OOwerJk=;
 b=SydrB3k6fn7Ql0ZE3/cEDl2uNe/SDD+fnPJQAguN/1oEqngZvr8DaPhWAlRQH+RnUJK+
 2OaxadohFRW921MykkCJlSsCphIdDnJSLRPKcMB5sHbNIu+uXZ2kqfl8bNTD5zJ/gm2+
 WpOyWVRCXDR5i1EUXrxFV5YVwoQ3y/i3s11uhDnkIRHU/YmWbm+zZSixi4p62O/3EUFK
 5n7scSPQK86+qDqTr2vFaoow+yAx/stzFNP0qZ6K1U92zXUmqYNf7Cw+VW+s1V33CWsD
 D9chR4i1yLfgPp4pPNpUzKc7GoG4poaEKsB9+fi/sn1KZ12GCi020tLyr9BZm1pUjXe7 ZQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 30s43a45qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 11:39:07 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FWh3s053414;
        Mon, 4 May 2020 11:39:06 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 30s57eg13j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 11:39:06 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="545729394"
From:   <Mario.Limonciello@dell.com>
To:     <hdegoede@redhat.com>, <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] platform/x86: intel-vbtn: Fixes + rework to make it
 work on more devices
Thread-Topic: [PATCH 0/5] platform/x86: intel-vbtn: Fixes + rework to make it
 work on more devices
Thread-Index: AQHWIK+xAhXVMpX2lEOTT4RsIve+eqiYDgUw
Date:   Mon, 4 May 2020 15:38:58 +0000
Message-ID: <e729ee1142a94fd394e0dbfb84e52a4b@AUSX13MPC101.AMER.DELL.COM>
References: <20200502182951.114231-1-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-04T15:21:38.2713206Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c39d1487-c787-4f40-9be5-36055d49081e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_10:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040126
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040125
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Saturday, May 2, 2020 1:30 PM
> To: Darren Hart; Andy Shevchenko; Limonciello, Mario
> Cc: Hans de Goede; linux-acpi@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 0/5] platform/x86: intel-vbtn: Fixes + rework to make it =
work
> on more devices
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi All,
>=20
> Here is a series of fixes, mostly aimed at fixing commit: de9647efeaa9
> ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's"=
)
> causing the driver to not bind on some devices where it could and
> should report SW_TABLET_MODE.
>=20
> The last commit makes the driver also work on some devices where it
> previously would not work because they lack a VBDL method.
>=20
> Mario, can you test this on a Dell XPS 9360 (for which you wrote the
> de9647efeaa9 commit) to ensure that this series does not cause a
> regression there?

Unfortunately I can't double check that with WFH, I don't have access to th=
is hardware.

> Also I have a question for you about using the DMI
> chassis-type for this / a proposal for dealing with this differently
> below the '---' of the commit msg of the 4th patch.


OK will look.
