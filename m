Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3293596706
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2019 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfHTRAQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Aug 2019 13:00:16 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:65312 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbfHTRAQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Aug 2019 13:00:16 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KGxXkL009269;
        Tue, 20 Aug 2019 13:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FpNfivoxXKcKCPMOtO7Ai5kR4gztS/4X4jJx0GcEPHw=;
 b=qsimQHs5yq3QlW4popc6Y1JW4rLQxtf7VobGSN/X1tPD221Tv85wRh2lfQz/+adijBic
 OnxamrfrpzaQ45irbj0LFRO6tc22TgoBZ5eUVOjI+qxKy+E+8Do3U8ECna5YuFkowB9o
 cXnQMuaPML6oaivj3OGbcsV2sd8w+wc/OHHWCZksltzyXNIIkohqrIOP9NcGDsIBynKR
 xGfqjQ3dnH9VpnI9aCAMseuZ/FCx3RTpOpo5ns7SxjZH5NApbuHXaHf4fEvNQUOON9/J
 ujxhtA1dpJesLpkoj4opI2Xh2YyD1AMmwvEua/ep56Y+Gry7D1eV61KJM81E50SxZM/G MA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uggbwhh2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 13:00:15 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KGw6Hx011367;
        Tue, 20 Aug 2019 13:00:14 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2ugjqbjes1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 13:00:14 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1346898468"
From:   <Mario.Limonciello@dell.com>
To:     <lukas@wunner.de>
CC:     <mika.westerberg@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <anthony.wong@canonical.com>, <rajmohan.mani@intel.com>,
        <raanan.avargil@intel.com>, <David.Laight@ACULAB.COM>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Thread-Topic: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Thread-Index: AQHVVoBozBrF8LXinkuY9L30yxdXE6cCqCcggAGVAACAAAaZYA==
Date:   Tue, 20 Aug 2019 17:00:11 +0000
Message-ID: <b5db55608d944b95a58cdfc7ccb60b69@AUSX13MPC101.AMER.DELL.COM>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
 <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
 <20190820113404.pm6qvqakdkcwdpat@wunner.de>
In-Reply-To: <20190820113404.pm6qvqakdkcwdpat@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-20T17:00:10.4140031Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908200155
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Tuesday, August 20, 2019 6:34 AM
> To: Limonciello, Mario
> Cc: mika.westerberg@linux.intel.com; linux-kernel@vger.kernel.org;
> andreas.noever@gmail.com; michael.jamet@intel.com;
> YehezkelShB@gmail.com; rjw@rjwysocki.net; lenb@kernel.org;
> anthony.wong@canonical.com; rajmohan.mani@intel.com;
> raanan.avargil@intel.com; David.Laight@ACULAB.COM; linux-
> acpi@vger.kernel.org
> Subject: Re: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, Aug 19, 2019 at 04:29:35PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > I've run into a problem when using
> > a WD19TB that after unplugging it will cause the following to spew in d=
mesg:
> >
> > [ 2198.017003] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [ 2198.017005] WARNING: possible recursive locking detected
> > [ 2198.017008] 5.3.0-rc5+ #75 Not tainted
> > [ 2198.017009] --------------------------------------------
> > [ 2198.017012] irq/122-pciehp/121 is trying to acquire lock:
> > [ 2198.017015] 00000000801d4de8 (&ctrl->reset_lock){.+.+}, at:
> pciehp_check_presence+0x1b/0x80
> > [ 2198.017026]
> >                but task is already holding lock:
> > [ 2198.017028] 000000000899e2eb (&ctrl->reset_lock){.+.+}, at:
> pciehp_ist+0xaf/0x1c0
>=20
> This was first reported by Theodore in April and appears to be a
> false positive:
>=20
> https://lore.kernel.org/linux-
> pci/20190402083257.kyqmirq4ovzscxsv@wunner.de/
>=20
> Thanks,
>=20
> Lukas

Indeed it does actually seem harmless and only comes up once.

I've filed https://bugzilla.kernel.org/show_bug.cgi?id=3D204639 to track do=
wn further
what's going on.
