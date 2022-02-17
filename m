Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692384BAAAA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Feb 2022 21:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiBQUQ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Feb 2022 15:16:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiBQUQ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2022 15:16:26 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E608093C
        for <linux-acpi@vger.kernel.org>; Thu, 17 Feb 2022 12:16:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX6FH/3NL9vmklPaknegxt2GQN/ZFDCW4sjgSCSzlcpA3ldu6MC0K4GPshnHGE5ZCfewjznWtpR5vCHtb7CSm21WjTl6+Ie5xKE9D49by1blc6Bd2wUc6HZY6uAM1rVxGZeiGToCCloUgOMfObVKenmy5LPowOvSTdxl0El6+uA/4rOX0j+xJuWETJ8TwguAC1jreK3k5As0ohK8JBkGYBvUmYbYlz4khJa5mhhzkarQ4+0xnncjIvn43mDi/KWqXVOjYok54Cv337nrdiY8ueyHMHz7fkUaBcXW9vxHKX5rrX5QsD732XDUDnGyh6xruiETP9j2r2nUsZbk0sadKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7HeR2IlZywA1WzuSn+gor7s+HqUBeg69vv6apU6S0k=;
 b=AB3iG3+Mt7T3UJKD5WUa75+5SfK7SSzaJAPUBLrOZavsEJF73B4WC4PexBj0lX4Xbw7hyEzKmtzqLt3oWmI3iI+T9JaRDCdYAqtKeRrqvaNW4gT6Wy88H/UQQ7rqo9gqNsbt6ax23fSHizN4lAdgoQp61Dh7ZdBodbhfTqhJFi+sC8hdG7Fi8frDZbVcYXjL7aOi/sm4xFvYXybLyevBE5kYPfMeBLG29RHZMYAISVtfQtAneY+Ezx+rZf0gZzfLP4BRKqfXrDV5Dpg1JRxbIxZxfthOMONdAWt2Ou6C3A0QyCQmLMDPh+AC6mCM9W3BV9Kr5Is+giDjRZnyM6FwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7HeR2IlZywA1WzuSn+gor7s+HqUBeg69vv6apU6S0k=;
 b=oxFvxqVLn+F9tt1PTkWv0a4eoiWOI3VEGr/v5+nyIEQrGY0DDel+VsjaQLSvlrPOiZzsOH9vPaEuZ3F54mZOBrHw1bsmu1djvf9TdbjS3Ro59NEewyz0qOZQ6KLc1XBQP6QKBIDkIVeyn1mrJrlXc5Youtgk5ymlMalNbCcTjXw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 20:16:09 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 20:16:09 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: Regression in 5.16-rc1 with suspend to idle
Thread-Topic: Regression in 5.16-rc1 with suspend to idle
Thread-Index: AdgjxKRqoif+H8GDSFuptXvIhGhWMAAJ0i2AAAqAH3A=
Date:   Thu, 17 Feb 2022 20:16:08 +0000
Message-ID: <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-17T20:13:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8dfbe5c0-f886-45a4-b3d5-095bebde050e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-17T20:16:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b6f451d6-0e3d-4081-8503-bbab7328c450
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa21c419-9780-43d8-67f8-08d9f25255d4
x-ms-traffictypediagnostic: BN6PR12MB1153:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1153B01E6DE36E8A22A9E3D1E2369@BN6PR12MB1153.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sd/FvX3W5CsY7nyHPJ4sZVridS7jH4H7pfCvM+mpP4+et57r1gDDKsfGk+7SKkZGDyZTlEjBuEy0tnAqbZz3ehP4N4hNXmcGYC5ZhkP8UkmdEuVGV1gMbTvFH8rHsjc68PqZSlp5tHskVQgJz7Bdw382yAOBWunxxdU38Cg7APUE4yn7R0z8G9eYFGjxWRi5xXhU7+H0B9aGsO97tzXZjJz6NfEAtz2j5uFil2uuJXvp+pxqJCpviAfEbOd10oCDHnN0lONb2AcHkXp3bUio50WhEVH+s83+w7rcNvWYnasN7VdxeOG28rmclysSsHoFXJZ9fZ5yGkH2LFhcai74vRxT8N2UsUPZ7h5SSSmkzUGASeqQFke9L4JmK2KmXgT2WCKTUYredJsgjLDzGSy8GCAp/nngT1S3jVMxT/y4YnOvrQxpDi6DMbwqOVqDAg2qx7M1xMkppDsvr9v6qaUODR4JsK3ac8Fll6aKFav9G6mMRc5dg/E/zGSakJ2FYiLOQujAI1LJ7hQeoOWOe6C19LuIiqJtels3DUrtwRD1uYgPUIeHYXW6Y3PBWkAvUUFNAwrnP39Oed15ilRSW2Viufe/n6rPgepJWlpYh/bA2g1HXqfwmhEs7D0KocTOFQvqvo0yGk45fsHZOtPW+PjvHZGzDRVQlyAXwha32lPQWwow27wQ0/mhUOhuuMTaAaX1vqrNq+geR9uKpDGm8r3VAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66446008)(66556008)(66946007)(71200400001)(83380400001)(2906002)(76116006)(66476007)(5660300002)(8676002)(54906003)(6916009)(38070700005)(4326008)(64756008)(508600001)(86362001)(186003)(15650500001)(9686003)(7696005)(122000001)(26005)(8936002)(52536014)(6506007)(33656002)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wINFgz3QuuB+sm+ZdK9er+TQzMYmixgBELxX9889Tnf+dhPs3EmG0tGvevF?=
 =?us-ascii?Q?3rywoXeJl75fFcyQ+DZkQUkcphw+pgBTWHsMyVczJzxuAI1nHAwpm2x5zljg?=
 =?us-ascii?Q?JaJ9ASqG6qvAR/pB3eRwFdb4PUgP52onIXOLlLJzXZzYXJfeDtVBNqsVIm+u?=
 =?us-ascii?Q?5zq7AOYc75hNwhNsJoegdXB6h5Ut1KujK05onbal/WeWv+iomiCK/WSkh1Na?=
 =?us-ascii?Q?RgNLtGmtF9Fy7qLLlaHTLybP7tjZMSjbARAKu2yjim8F70wpS7MV3dNweHx5?=
 =?us-ascii?Q?vAOF1pHVNoP3PNK0NMnCqa8BW235J/x/ZWifSMjw9XW2TTfIj+GHJqETGabi?=
 =?us-ascii?Q?mKTIQsf9dG7TD0t1L6AmyqP+gCCzu61/vXs9DAvwzeXoeBHurJ3y0f8m8N55?=
 =?us-ascii?Q?rp2MFDU2mBJf2hNLeavFuCHJIWLS8N8VHmIW5hQKwYim9wFgtGQpIw+5+dy1?=
 =?us-ascii?Q?FN8OIlb8UIPTxnnaUESSDTVY3d4OSBnBt1P8jrCIJWwBEGnt/Sb7k1pKjbpk?=
 =?us-ascii?Q?1JMARakXIG1HwPq8yPMs/GoCS9/bAmcltKBe1UXsZ5jGLlzA7xfdQS8/p+Am?=
 =?us-ascii?Q?vbtdcbMnvuafr4rMGKrsvbiBTOrYxQJ4gmdhhDmIhs0XqApknBEhIeVscPkO?=
 =?us-ascii?Q?jSZFXpQC1q1AGktbH9BfBckxIn10CTDz4FSsoWyDBMaUGAeABdIRJgdiWtDi?=
 =?us-ascii?Q?/9m+oOIAA6sEURyJTASiu8GNDy1WcV500l6ZQiPtLopygHYoGa76XwvFrGEM?=
 =?us-ascii?Q?O17eQLT9ALqOA9WZ4Jj1WaU+PPm3YZ9lBnIqBFpC9EDmYjo0IJPNtLB/sIHC?=
 =?us-ascii?Q?TzAca/sy8aqAyw0xcRxBZ9GoFEEVtoWrkEo+N9b8U9Wcf9GfpZPNa4tiEi3j?=
 =?us-ascii?Q?pA0cCR1Ou5fbo8eKLlnjSAwrPyuYqAuEV9sud0ERaev9Fzl7X35VpB+ssqqn?=
 =?us-ascii?Q?BMNlw5PL3FvRgkALLRXP+a63/wx3m6cKmZmcBsXtBVAqXtJSl9ZwOzyGJ+4j?=
 =?us-ascii?Q?CSONLkGUFxBK0VqCJjurPSZ/ZB9wWBoMjbiAyJ5hnwanMEJsYHvRgtuozNrx?=
 =?us-ascii?Q?FiEJToeQG/cmd1FfNXa+FiwYOwG9XbyqDeZBHRliuIlesXj2JI3DkB5/+T/y?=
 =?us-ascii?Q?FpMmhLlIA6/Ao+EOwiUZCGBrA4uRoMbwWajiswf7KODMLlHAtllyPvLpn7t7?=
 =?us-ascii?Q?GkInGUFIBkFsKDDTtj+WDlkN/0YN7XI423+HBPUMA2BNLHTK8jcglScN6/NB?=
 =?us-ascii?Q?31hyDabDrbudAF08UAyDFm2WnaEMXI1ra/VwiA5YJmlcFaxHCl5+uXYC75Xi?=
 =?us-ascii?Q?kiAoeg0FUts2RdpfGEbDqT7ENQtrnJm41djCOSJ1f7YQuVNLNbsDl1RyBNY4?=
 =?us-ascii?Q?miCWIZeIHZB/CHXixHxPhSIGoJWwqzDYJ5sVN22r9xfwYKl6f7dgTaa5m2jx?=
 =?us-ascii?Q?Nn0uKK00gyfxPklXL+D85iAFuDCGsjbfnxYz2OYJBCHPM5YL4Ct4miWvlICE?=
 =?us-ascii?Q?uKhQJAdjSkORpGQywww1jq2rfE0/JsUw+xFnog+wrIXBimtctkJfiDt5/Dej?=
 =?us-ascii?Q?ThhkKwm/UpLiXUlCVdTDoOqeUw1tPF7XiG0dAHQxBa/2D5xVjGHfJwLj2zB9?=
 =?us-ascii?Q?3mDZN7Q1/6/Gapsv118UXBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa21c419-9780-43d8-67f8-08d9f25255d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 20:16:08.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYiq1Tn+8/7F6SUv68HvYACUWEHaFvVxD6CK4nXgN3I67iYome9Y9v8UN6ZyjRNeNLoKK4Ds/aoGcg+AyR2xwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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

> > I've found recently that on kernel 5.17-rc4 some OEM AMD laptops are
> shutting down when entering suspend to idle.
>=20
> Interesting.  Can you identify the exact point when the shutdown occurs?

It looks like it's a platform firmware crash that causes the shutdown not a=
 kernel
crash.

> > What would you suggest to be done in this case?  Revert both commits?  =
Or
> would you prefer to have a fixup on top
> > of that?
>=20
> I would prefer to fix the problem on top of the current 5.16-rc.
>=20

Here is the minimal patch I can come up with on top of 5.17-rc4 that fixes =
it:

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 04ea92cbd9cf..f5bf46782043 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <linux/suspend.h>
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuidle.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>

@@ -1350,6 +1351,8 @@ int dpm_suspend_noirq(pm_message_t state)
 {
        int ret;

+       cpuidle_pause();
+
        device_wakeup_arm_wake_irqs();
        suspend_device_irqs();

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6fcdee7e87a5..1708a643ba5d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -97,6 +97,7 @@ static void s2idle_enter(void)
        raw_spin_unlock_irq(&s2idle_lock);

        cpus_read_lock();
+       cpuidle_resume();

        /* Push all the CPUs into the idle loop. */
        wake_up_all_idle_cpus();
@@ -104,6 +105,7 @@ static void s2idle_enter(void)
        swait_event_exclusive(s2idle_wait_head,
                    s2idle_state =3D=3D S2IDLE_STATE_WAKE);

+       cpuidle_pause();
        cpus_read_unlock();

        raw_spin_lock_irq(&s2idle_lock);


* Removing the cpuidle_pause call from s2idle_enter will fix the crash,
  but the system doesn't enter the deepest sleep state.

* removing the cpuidle_pause call from dpm_suspend_noirq the firmware conti=
nues to
   crash.

I also confirmed that reverting both of these commits together on top of 5.=
17-rc4 fixes it:

8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle pat=
h")
23f62d7ab25b ("PM: sleep: Pause cpuidle later and resume it earlier during =
system transitions")

The commit messages at least make it sound like it was just a rework for un=
ification of the codepaths,
not supposed to be for anything to be actually fixed, so I would think it s=
hould be safe to revert.

So please advise which way you want to go and I'll send up a patch (or if y=
ou want to write one
I'm happy to take it and test it since I can readily reproduce it).=
