Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C544B9909
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Feb 2022 07:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiBQGP3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Feb 2022 01:15:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBQGP1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2022 01:15:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E92A2286
        for <linux-acpi@vger.kernel.org>; Wed, 16 Feb 2022 22:15:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njEEFhwQZFKLT3ik7ha/QyrhEwIk/fvbeOud9X+aFE+wSenmsQSixFJiZtOJE7HORlvX0z/iZHegT4DSvpv8udu6pPoKJVUgaVzJNrtYpxnD2Uk1jYDFh8rWFYOC5ioo+qHKNHqXtT3kadGFeJPXYFa3Za2lmFm1VavaH+rXuSPOsJg3Vse8ila6OGf4kz8HqFzgqgkigWLV4SbNP7uLtHf3CgeEyOHva2ymsQqHB1o8xELo4dtyF0dAdNgbwUMVNqGUiiafvJSYsCH4ZR5Rd8pl8iDzHizzo8zizyEjCIEHZ/6bRU1iOOQsliOIv6WXRK1+MHHYdlrFNSXur6lNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx0FAkgsHcmhGljUR18Tq6LUoeodxlL3dljihU39WMQ=;
 b=hMiOMH2Wk5uA9cUb0m/EC+ePUnl5dLdgoR1wqmqHEyHhotvGHoFfCC0838qzowpvAjliKMqrSDSKzsNwIluZXUTM9sBdMAcug0CtDaEE5wrnfiRvSmC7seBXoaYzU2bpy17/TqKlkCVEdwVQI6Fr9T/8BlrHuDNvGb0K0ekB3NFI+Ed5J3boJT63H6DGfg5NrjqtIR0oJxDr9wjeHzd8gvLH8D6Bp39KleiR5nIQ/D79zwr0gGRrl+ArHwWUMx8l+B/HJPAt1qeTXtNtIwcAvvpTlxfhV2MJXbVd5Z1a2Ws4aS2jEY1rxgbfsbL3gb5RzazULo0RgUc+9LMusp7pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx0FAkgsHcmhGljUR18Tq6LUoeodxlL3dljihU39WMQ=;
 b=2N8JOEp/kVudcPda8njEAK9gc9nBYdiocbzpG8yLWWvy9IiLkpe6aMcWOa4lkcRj8Tm7vwBHFAZCyjmjG/ijwoEotbMqY7dxtCcvbWsEgRfBvYKUyeHstO8CSBhnVNhZ9Jv/jjRKgMpzvx6FZpzGXo28QoUk0OXrZmAUgNrKNoA=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 06:15:11 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 06:15:11 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Regression in 5.16-rc1 with suspend to idle
Thread-Topic: Regression in 5.16-rc1 with suspend to idle
Thread-Index: AdgjxKRqoif+H8GDSFuptXvIhGhWMA==
Date:   Thu, 17 Feb 2022 06:15:11 +0000
Message-ID: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-17T06:13:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f7478e1e-402f-410b-bc00-424987c448d8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-17T06:15:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: efe394a1-bdd6-4331-a74a-1acdc7feaef1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ae14a9-dc4f-41aa-6a80-08d9f1dcdaa9
x-ms-traffictypediagnostic: MN2PR12MB3536:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3536B19314A38CD38EF6F3A6E2369@MN2PR12MB3536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOz/aupRWmfbMKOL2cwzWK3VMvFPFqoR9E0QV+fGJBHoMgQ0H2X+bOjUDS0+K7tRYVujUo1nVq28aqFwOJyT5FLCwEX3pE+fkE+c/0BXoIWHBdzYdlZoO+YqG0St7EOb24J1GnUX4lP4JoH7y4s2pl3QcN0736iJbsfYdQUYyLiSUvj2CV9KoLxx1S4cpWZ9HazIdO410yAuhnQFnKs6KezigUBOnG4EUNgGpWzwwLIDi2KPHZ8oFjLNLy9fX2IDoD5zROADAjJrMeJ1pWwMwg2WK+ds5eJ8eVT2wgL0WikIPXnHF82TT9WT5+70gUdflpEtOLraqzABK9PzU68Q8UatAAsH287Wa6n2NA2NpamiJeWnE5hOYAy34Mearot+Uq5YtRTtcbEASt4oRF96tb7jHIqCKL8uJYiSi0g6CFUwYa4g34aC1+cgA+wHqZwoWehWbmFYN1hqFskY1BMN9YCBKrgH1Km67lhQ+x8fkN0EhI3VNofucScZEeUifVYVkj99EVCU1/IwuaTpfeasuqQsPNwPe4XoDFN1VX25yrjegHzr+uaPZkSGq5erEy21WgBH3N89A9HXhq696c5ZxrT05NWi95AIj9bDsvrunWNphra+uxqIgW17UVxMQDAkqqiqPjN5NaCncHyHdg7v1cWXHeFF/yDaoqPmzKQlWPqgiLwIdkjalPnuDEQeBYohxydHJ1/CoiRicpSwFauMMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(508600001)(8936002)(55016003)(15650500001)(52536014)(86362001)(4001150100001)(186003)(33656002)(110136005)(122000001)(6506007)(2906002)(38100700002)(26005)(7696005)(316002)(966005)(38070700005)(5660300002)(64756008)(66476007)(4326008)(8676002)(66446008)(66556008)(83380400001)(9686003)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hckdpqHyzQvxaDzObdHS4WCHSdqnw4ZrNmGfafdN+it/HOB26iieDs8u85RT?=
 =?us-ascii?Q?ZPosiZ9/wZR41Xs5jQDM7H6tUjkgCs4iZo2FrEEf/241iAPkJ/zGFQB9QO9R?=
 =?us-ascii?Q?ZEhA9RMXqCAKfYfpihFKv/G/hwAHtCjqMSyK7DfOIXAlKcVRHPlpAT2gbVlT?=
 =?us-ascii?Q?eQhOnQDZzUFCUzxNQF8glo1mi8LgB4fWrRd4/86JuuvRo6R0kiEtU/4ZhKLy?=
 =?us-ascii?Q?gFx7Mc9ZRYK3+DLZla3qgYOHeLoKda+Ci/T4mhuVdzpN/oSsgxVS4+veTxhW?=
 =?us-ascii?Q?1tBXAgrxTIGqV5YJgv5cfvX1SSE859t48AjNe2fNkASBjdOdZcxQh8KGr2YD?=
 =?us-ascii?Q?p0qFKPtS6YO4QtAy4hHMHYgq4Xoo+QaU3RC9eKTra+TO3Qf/T/XBoA7ImFIr?=
 =?us-ascii?Q?8pImHEatEr610o/G4pQUhKnEAoIUoM0oj8GgjQ9WV72aUGbz4OdnxSR1fB3I?=
 =?us-ascii?Q?xswq1DWXiPcPfqJ+CtkfwEBIwMNYG9ebIx4OY0g3+SKfKZVt1OHFuyMxBA/K?=
 =?us-ascii?Q?MtgTqocdMr1wScV+ix7fPqDSk4uUqUqrNtr/9M0nJ6DdkTf4uuDC5DYYso/9?=
 =?us-ascii?Q?QVec0JntQb9Q6Tban8qp/U1cNzs5Eso77Ans2COP+rt1A4VAAOVJoxEPOvpA?=
 =?us-ascii?Q?Q6neBZbGR/+QtfKmamgisjkGGjk9gstOvKndgHrgyKlEqQgtp85cGJHheCe+?=
 =?us-ascii?Q?6fkq8tRie0kYVGX1cWvfn9lG3/1zyTIt71aeApvraj0T4ll/BV08jkVlu3D7?=
 =?us-ascii?Q?ByKCd2/7Fdsr3eiphCPX0kTH/jf64fn6qvECNnHrX0BoTGgVDh3WZltn16fm?=
 =?us-ascii?Q?INcDSCwLuckvWmOVAfo4KVtya1hXDD92PFz0lq7ofuSHkxDecTMOsFbkgbl4?=
 =?us-ascii?Q?BkXGM+by4Otsee0KyNFbE9BfDKF4YKRWHSlKWYzhTtw99Hgb5uKiL7ZjOn3C?=
 =?us-ascii?Q?+H/+XFFISb0NCJWVvjjlL8Yr+40hrBUWo/hkNj7EAqgX4RGkGrjlpwak05k2?=
 =?us-ascii?Q?fkbBDslI/nSzAAyZNR2MAycP/6SiEOG5ENLosKrT4pHy1mYFhHsVNGA9shES?=
 =?us-ascii?Q?Gh1vRFLz0guoiqgglG8gqKm0Nk/hEpP/VqGxTb1xU7ti7jZAFq0I8hiUFA84?=
 =?us-ascii?Q?gN0RrAD6ZrWp9KK+47DAgqzQ/KeWi47BHSxM2pQD03Wmo6WPRjbUxjwdArPk?=
 =?us-ascii?Q?KlxxddAyVPUaT8Geao1cIpMT4NA4Awb7OfveR34yfrzzPANjQCdV3BATmFjU?=
 =?us-ascii?Q?j3dAtcc9d+Q6KCMowolDpPKsN2foFwbaR4KwGKiWgIfh/G9IQ/uB1yCSxRqN?=
 =?us-ascii?Q?JWtVwkNt81Wn1RZ6PGtBhpymqxxDbbcpQa+oB5qDL2H/O3qv19p4k47hcuVi?=
 =?us-ascii?Q?j9mtegScWq90FlXHoSnUViBi9suxMQv2Zsv+DeBgEG3rhlHuOKrJWfIlcW3U?=
 =?us-ascii?Q?lqt7YesE4GwH95HetQOrY5Ci4XZNUTY3TM1GRIOQ+xL3Rqfmkx2DbPjelTVL?=
 =?us-ascii?Q?s8ePYMGXKaIP61lA+VtYJMQB0H7cxC8ltdG8FFcOiYdn7cw2vx0AWX9588wB?=
 =?us-ascii?Q?ihkslA1ekfSUTUyAY2ISkGHYe8qr6q12VtSaOsI/bErM3ayDPOxx51nDHPH1?=
 =?us-ascii?Q?Luzq8bFf9c7njg4n+9Rw2yY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ae14a9-dc4f-41aa-6a80-08d9f1dcdaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 06:15:11.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NrTO0z0vblUvJ0ws96XgJLheF8hytZhAjsAYNUi1TN+q6P6OgLf+5NadE1I3L/39x6rObMeHb0syErjGW+s7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

Hi Rafael,

I've found recently that on kernel 5.17-rc4 some OEM AMD laptops are shutti=
ng down when entering suspend to idle.
I bisected this back to commit 8d89835b0467 ("PM: suspend: Do not pause cpu=
idle in the suspend-to-idle path")
which was introduced in 5.16-rc1.  As this code has changed since 5.16-rc1 =
(notably 23f62d7ab25), a simple revert
won't suffice.

# good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect good 8bb7eca972ad531c9b149c0a51ab43a417385813
# bad: [fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf] Linux 5.16-rc1
git bisect bad fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
# bad: [313b6ffc8e90173f1709b2f4bf9d30c4730a1dde] Merge tag 'linux-kselftes=
t-kunit-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/li=
nux-kselftest
git bisect bad 313b6ffc8e90173f1709b2f4bf9d30c4730a1dde
# good: [84882cf72cd774cf16fd338bdbf00f69ac9f9194] Revert "net: avoid doubl=
e accounting for pure zerocopy skbs"
git bisect good 84882cf72cd774cf16fd338bdbf00f69ac9f9194
# good: [79ef0c00142519bc34e1341447f3797436cc48bf] Merge tag 'trace-v5.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good 79ef0c00142519bc34e1341447f3797436cc48bf
# good: [0f3d2b680444d5697650b5529c9e749acbf7371f] drm/amdkfd: protect rave=
n_device_info with KFD_SUPPORT_IOMMU_V2
git bisect good 0f3d2b680444d5697650b5529c9e749acbf7371f
# good: [a64a325bf6313aa5cde7ecd691927e92892d1b7f] Merge tag 'afs-next-2021=
1102' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect good a64a325bf6313aa5cde7ecd691927e92892d1b7f
# good: [d9bd054177fbd2c4762546aec40fc3071bfe4cc0] Merge tag 'amd-drm-next-=
5.16-2021-10-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-nex=
t
git bisect good d9bd054177fbd2c4762546aec40fc3071bfe4cc0
# bad: [833db72142b93a89211c1e43ca0a1e2e16457756] Merge tag 'pm-5.16-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 833db72142b93a89211c1e43ca0a1e2e16457756
# good: [33fb42636a938be01d951b4cee68127a59a1e7e4] Merge branch 'ucount-fix=
es-for-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/use=
r-namespace
git bisect good 33fb42636a938be01d951b4cee68127a59a1e7e4
# good: [c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb] Merge tag 'acpi-5.16-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb
# bad: [b62b306469b36fae7030c0ad4ffa11de0c9b9957] Merge branch 'pm-sleep'
git bisect bad b62b306469b36fae7030c0ad4ffa11de0c9b9957
# good: [1fec16118ff9b822431d83a16430de60cf8e8769] Merge branch 'pm-pci'
git bisect good 1fec16118ff9b822431d83a16430de60cf8e8769
# good: [928265e3601cde78c7e0a3e518a93b27defed3b1] PM: sleep: Do not let "s=
yscore" devices runtime-suspend during system transitions
git bisect good 928265e3601cde78c7e0a3e518a93b27defed3b1
# bad: [9f6abfcd67aae51374b4e8aa0b11f0ebd0d8562f] PM: suspend: Use valid_st=
ate() consistently
git bisect bad 9f6abfcd67aae51374b4e8aa0b11f0ebd0d8562f
# bad: [23f62d7ab25bd1a7dbbb89cfcd429df7735855af] PM: sleep: Pause cpuidle =
later and resume it earlier during system transitions
git bisect bad 23f62d7ab25bd1a7dbbb89cfcd429df7735855af
# bad: [8d89835b0467b7e618c1c93603c1aff85a0c3c66] PM: suspend: Do not pause=
 cpuidle in the suspend-to-idle path
git bisect bad 8d89835b0467b7e618c1c93603c1aff85a0c3c66
# first bad commit: [8d89835b0467b7e618c1c93603c1aff85a0c3c66] PM: suspend:=
 Do not pause cpuidle in the suspend-to-idle path

What would you suggest to be done in this case?  Revert both commits?  Or w=
ould you prefer to have a fixup on top
of that?

Thanks,=
