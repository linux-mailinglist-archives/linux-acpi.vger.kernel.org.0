Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293FC8F052
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfHOQT5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 12:19:57 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:15560 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728956AbfHOQT5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Aug 2019 12:19:57 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FGAXmk022073;
        Thu, 15 Aug 2019 12:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=EeZtSFfcASxzQDiDgQ5G5QblMNz9X1uWYaIgK2p9tnY=;
 b=Tu+T6myXCWoUSFAl0NxM5b/ntnWKClidfeali/n2ICHJgIRVJ9S+6wGyrGCpOA/VuKLQ
 577HT7V65Td9lsnAOU2iQ734oU7J+uLSdOPbZZvfGw+Vlud8X3vngzLVGET8UYaF8Kl0
 bfmRpWi6AAGx8+1mYNhbzqvsZg8WyJQsGAq2zqoo3IqsR0+TedWbqj9n9m8RzGXfMkA4
 pdb+cuJHmlVKVVH+dYi68lXMVQBe2hSzdLSQe5LFc6gw0v54HQAfxEAqxBmtl6FOMNw/
 qfDx1Xig+V46SFCnS77dW9JJbL/kfrQ6tUqmnj87fqfjmZ0Tly7/b55W6Vc/se2B3wD6 Uw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ucg1jxkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 12:19:56 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FGDU2m016365;
        Thu, 15 Aug 2019 12:19:55 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2ud9aj9whg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 12:19:55 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="408820564"
From:   <Mario.Limonciello@dell.com>
To:     <tiwai@suse.de>, <alexdeucher@gmail.com>
CC:     <kherbst@redhat.com>, <nouveau@lists.freedesktop.org>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        <alex.hung@canonical.com>, <bskeggs@redhat.com>,
        <airlied@redhat.com>
Subject: RE: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Topic: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Index: AQGgd6rdZMP3IawUTGaO286TGix+WwEoseSWASaOw1KnU3bBEIAAWGiA//+vQECAAFaFAIAAA1mAgAAFeoD//8KZYA==
Date:   Thu, 15 Aug 2019 16:19:52 +0000
Message-ID: <8724585e50004bc8b6f310587555f4a1@AUSX13MPC101.AMER.DELL.COM>
References: <20190814213118.28473-1-kherbst@redhat.com>
        <20190814213118.28473-2-kherbst@redhat.com>
        <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
        <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
        <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
        <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
        <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
        <CADnq5_Nv6tsW0J20td5rQSLq048HtTcw1b4c25jP6ZR6XWZ-eA@mail.gmail.com>
 <s5ho90qa34m.wl-tiwai@suse.de>
In-Reply-To: <s5ho90qa34m.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-15T16:19:51.1871148Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150159
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, August 15, 2019 9:57 AM
> To: Alex Deucher
> Cc: Karol Herbst; Limonciello, Mario; nouveau; Rafael J . Wysocki; LKML; =
dri-devel;
> Linux ACPI Mailing List; Alex Hung; Ben Skeggs; David Airlie
> Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI strin=
g to
> enable dGPU direct output"
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Thu, 15 Aug 2019 16:37:05 +0200,
> Alex Deucher wrote:
> >
> > On Thu, Aug 15, 2019 at 10:25 AM Karol Herbst <kherbst@redhat.com> wrot=
e:
> > >
> > > On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
> > > >
> > > > > > There are definitely going to be regressions on machines in the=
 field
> with the
> > > > > > in tree drivers by reverting this.  I think we should have an a=
nswer for all
> of
> > > > > those
> > > > > > before this revert is accepted.
> > > > > >
> > > > > > Regarding systems with Intel+NVIDIA, we'll have to work with pa=
rtners
> to
> > > > > collect
> > > > > > some information on the impact of reverting this.
> > > > > >
> > > > > > When this is used on a system with Intel+AMD the ASL configures=
 AMD
> GPU to
> > > > > use
> > > > > > "Hybrid Graphics" when on Windows and "Power Express" and
> "Switchable
> > > > > Graphics"
> > > > > > when on Linux.
> > > > >
> > > > > and what's exactly the difference between those? And what's the a=
ctual
> > > > > issue here?
> > > >
> > > > DP/HDMI is not detected unless plugged in at bootup.  It's due to m=
issing
> HPD
> > > > events.
> > > >
> > >
> > > afaik Lyude was working on fixing all that, at least for some drivers=
.
> > > If there is something wrong, we still should fix the drivers, not
> > > adding ACPI workarounds.
> > >
> > > Alex: do you know if there are remaining issues regarding that with a=
mdgpu?
> >
> > There was an issue with hpd events not making it to the audio side
> > when things were powered down that was fixed with this patch set:
> > https://patchwork.freedesktop.org/patch/316793/
> > Those patches depended on a bunch of alsa changes as well which may
> > have not been available in the distro used for a particular OEM
> > program.
>=20
> FYI, the corresponding commit for ALSA part is destined for 5.4
> kernel:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?i=
d=3Dade
> 49db337a9d44ac5835cfce1ee873549011b27
>=20
> BTW, Nouveau should suffer from the same problem.  The patch to add
> the audio component support is found at:
>   https://patchwork.freedesktop.org/patch/319131/
>=20
>=20

It sounds like 5.3rcX won't be a useful check then.

So am I correct to understand that everything related to the AMD failures
described in this thread should be in linux-next at this point?

