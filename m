Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16D31F5DF0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgFJVwV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:52:21 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:15172 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgFJVwS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jun 2020 17:52:18 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ALqGCn024963;
        Wed, 10 Jun 2020 17:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jkIE3moYoaNpj1ljEBfKnxJ6RSIRje6RAXQB8no/Okk=;
 b=LcEVKNY0HmuRhX+IyDjU+kD/BOwt5+WTJKeC9jIdrj+gX+ijGIApckBtdJXNhG4scJcT
 kWDvJJA75eIiINTR1n28eGuiUrpFv568WDyy7VP/BxtWs7pffBxnX2y8WYxtyouHSO7O
 KV0N5kBD3s5GnYIZVznJ6UoLIgZ/AsZpy1RPfeTac1f/XKbg+sAXkqDR19l3bU4n/M23
 +P1dbOkv0XlekdSEudlBKPoTs5X+Rt17YSd1QCoA3Ogx8xolhU9ixQCy+gNdFrsprZ3S
 E/Yy/G+cpF/9H51Q5sqnGcZV0xM17V0brbO2W4cqncExxdEJZQgObbzbxhFRnxsHPoZx 2A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31jjqumpfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:52:16 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ALYF9t013590;
        Wed, 10 Jun 2020 17:52:14 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31k6fq90ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:52:14 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1564454969"
From:   <Mario.Limonciello@dell.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <enric.balletbo@collabora.com>, <rjw@rjwysocki.net>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <kernel@collabora.com>, <groeck@chromium.org>,
        <bleung@chromium.org>, <dtor@chromium.org>, <gwendal@chromium.org>,
        <vbendeb@chromium.org>, <andy@infradead.org>,
        <ayman.bagabas@gmail.com>, <benjamin.tissoires@redhat.com>,
        <blaz@mxxn.io>, <dvhart@infradead.org>,
        <gregkh@linuxfoundation.org>, <hdegoede@redhat.com>,
        <jeremy@system76.com>, <2pi@mok.nu>, <mchehab+samsung@kernel.org>,
        <rajatja@google.com>, <srinivas.pandruvada@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Thread-Topic: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Thread-Index: AQHWEZn1ic1J55wnDUCcmSeyJR9LmKh32IiAgFJaEOiACNhPAP//rP0AgABYQ4D//63d4A==
Date:   Wed, 10 Jun 2020 21:52:12 +0000
Message-ID: <adf9daaf08f1464684e48ec203194fe9@AUSX13MPC105.AMER.DELL.COM>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
 <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
 <20200610214033.GB248110@dtor-ws>
In-Reply-To: <20200610214033.GB248110@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-10T21:48:50.9216576Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=80b762a3-4bd9-4820-ae3a-ab81180832bf;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 cotscore=-2147483648 mlxlogscore=748 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100156
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=880 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100157
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Wednesday, June 10, 2020 4:41 PM
> To: Limonciello, Mario
> Cc: enric.balletbo@collabora.com; rjw@rjwysocki.net; rafael@kernel.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; lenb@kernel.org=
;
> kernel@collabora.com; groeck@chromium.org; bleung@chromium.org;
> dtor@chromium.org; gwendal@chromium.org; vbendeb@chromium.org;
> andy@infradead.org; ayman.bagabas@gmail.com; benjamin.tissoires@redhat.co=
m;
> blaz@mxxn.io; dvhart@infradead.org; gregkh@linuxfoundation.org;
> hdegoede@redhat.com; jeremy@system76.com; 2pi@mok.nu;
> mchehab+samsung@kernel.org; rajatja@google.com;
> srinivas.pandruvada@linux.intel.com; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Jun 10, 2020 at 09:28:36PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > >
> > > To give you some references, if I'm not wrong, this prefix is used in
> all
> > > or
> > > almost all Intel Chromebook devices (auron, cyan, eve, fizz, hatch,
> > > octopus,
> > > poppy, strago ...) The ACPI source for this device can be found here
> [1],
> > > and,
> > > if not all, almost all Intel based Chromebooks are shipped with the
> > > firmware
> > > that supports this.
> >
> > You can potentially carry a small patch in your downstream kernel for t=
he
> > legacy stuff until it reaches EOL.  At least for the new stuff you coul=
d
> > enact a process that properly reserves unique numbers and changes the
> driver
> > when the interface provided by the ACPI device has changed.
>=20
> If we use this prefix for hatch EOL is ~7 years from now.
>=20

Isn't the whole point of the ACPI registry and choosing an ID?  You know in=
ternally
if you need to change the interface that a new ID is needed and a new drive=
r will
be needed that comprehends that ID change.  So if you can't guarantee that =
0001 is
the same driver interface in every firmware implementation google used then=
 that is
where this falls apart.

I know there is a long support lifecycle but you're talking about rebasing
to new LTS kernels a handful of times between now and then.  If the interfa=
ce really
is stable the patch should be small and it shouldn't be a large amount of t=
echnical
debt to carry downstream until EOL.
=20
