Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8063718D849
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Mar 2020 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCTTTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Mar 2020 15:19:32 -0400
Received: from mail-bn7nam10on2113.outbound.protection.outlook.com ([40.107.92.113]:44633
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgCTTTb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Mar 2020 15:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJTeDDvYGOjjWkieFgIU53NgJJ76x9bPw87klrQrkEscN8tNfI76FkiJ05XoZG1PurSEgUY2XX9ixg327Hf7Fx4WuhPwtwzUyLZOJ98fQJZzZsT1kFtX6UXWgfQQQUxBajS8ZlVu8m+DGgu2w8DDgVMafdaxe97Kqg3ziox8hyGzrS2Ud+gDnW7QGoAk8Zti4wwyky2fANCi7DpFwtmm9HrRBwZ49hwCGiXn/oMFS76fE3O8UFf3ec4oA3/44a+632RdakhC+gb9le3hJbX9fXtsKFsUPl5kkGDTy1nyFCkiwXHwprMEtoDROsXKaU7hbThoPAHC7WPov8f/j39BPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEG4D8frae4gtuQ5PgQffriM8kE3Kl3d0291lqIQhE=;
 b=HmjDlHqbCwkai41ZhMvzdMW1bNwEOeArchBPJuKMUXllMHfMQ+AERI+2vuumhQkcYm11n/ranxSHvmT8Xgzkn97UUJcIFvf1I2eakQtJApFg3tIfyLpBn9JSWrzESyiNpYusBKRInt+u7L5jxU/umCSi/AU2c21oKcAS4Z8gjOtaTNQGmkk1aIxn2DwwOC7VCwN+TzK4DhCRawBl1fgdrE0jzIBKCb836L9fuEbGR7S4W0hmLE/coeTWCSJlbK2E0Fq9eAKHSMwcvWSKyqSbdq2zyH9VFC4sMAAGxqSJBmrd1MqiuEojyXSh1L1dJ/4BJ3pDpkdgEDzs6Rmkp4v87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEG4D8frae4gtuQ5PgQffriM8kE3Kl3d0291lqIQhE=;
 b=QuRk5UY6CBkDHJxZKe/cAGXuiYHbyztjvo9cbj5WZADN5oiu5jXxG+fwmw+8hiIB2Iw/Fn4xL9VJSkNOQk99EZTEAFkPd2JjXg2nUQsnKedKAazWcZo0VcV5fl2dA/8o3IUq12KLJTro6iN6jU4VmtTViqP9UEL8ivav0MXWVlg=
Received: from BN3PR01MB2130.prod.exchangelabs.com (2a01:111:e400:7bb8::10) by
 BN3PR01MB2034.prod.exchangelabs.com (2603:10b6:400:1::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Fri, 20 Mar 2020 19:19:28 +0000
Received: from BN3PR01MB2130.prod.exchangelabs.com
 ([fe80::5173:38fe:25ed:5c19]) by BN3PR01MB2130.prod.exchangelabs.com
 ([fe80::5173:38fe:25ed:5c19%10]) with mapi id 15.20.2814.025; Fri, 20 Mar
 2020 19:19:28 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Thread-Topic: [PATCH 0/3] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Thread-Index: AQHV7l9UaRPCwzdkCUmGr97GfYKTH6hR+qG5
Date:   Fri, 20 Mar 2020 19:19:27 +0000
Message-ID: <BN3PR01MB21303880EF8D2953854401D5E3F50@BN3PR01MB2130.prod.exchangelabs.com>
References: <20200228174817.74278-1-james.morse@arm.com>
In-Reply-To: <20200228174817.74278-1-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-originating-ip: [45.37.71.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4c4ad1-1961-4200-1974-08d7cd039c1c
x-ms-traffictypediagnostic: BN3PR01MB2034:|BN3PR01MB2034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR01MB2034B91E845045902012E7E3E3F50@BN3PR01MB2034.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(199004)(8676002)(4326008)(81166006)(2906002)(81156014)(86362001)(55016002)(91956017)(76116006)(66946007)(33656002)(966005)(5660300002)(7416002)(71200400001)(110136005)(66446008)(316002)(66476007)(66556008)(7696005)(54906003)(26005)(8936002)(6506007)(53546011)(9686003)(52536014)(478600001)(64756008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR01MB2034;H:BN3PR01MB2130.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEaRI5FOqT+oYoF4w3IzI3rJcgD3qMyymNV9mvlzLtXiiS7XAW4wsQd5A18fpwZK+Iudf51DJhT/OA4N8V/fLzknRc13NlevNUxjzBelXpx1Pz2v759ylkb+ppMrvv12B5KUlZPquRY2dYZaU8gelZbdCL0bBhwj+KoTloGl3wXHJb0QYFmTIBHmxKBWdcNOzywyJ4p1FmcDfGJU9rhBoTidFgI1utyihgjQxTzbQ555pRrOp1sKQQyS6vfY7O6X+Rlcak7qzGW3ECVRpNOaeXlsHGiRfdOEmPMQaGS5eQUa/BHAscgQvIBHIoBnrSFQ2HhhcCY2IT/IIcvz5f1JHFGgpWigzld14NjhuVq2PWxiO5XHS1ctfwJU4c2yU1PFd20dxdtsNvT1r1GLRLy+b8buwyJoEyvnFzMz6GYnXXwOgRcyxsNyX2PN7DAIJ4xynvdUhjV3Qve2J4WfqCH9+IZMCIpCo3pNb4jcuTjFFTLrtFlQA+d6nQQ64g1gKm0+saY6AohQK+5zjtQcCFX3FA==
x-ms-exchange-antispam-messagedata: voW+fDs6Wvza5gGIt53EsFKvOx5mjbH2LygB5SgKwJ+6/xf0zH0kvCAVnuFIMTJFpPB2GPwxdMWGpa7BdGIQYLANhnXKCKxin0m1pxfG48tUGdR+140xl1lrO4kLMWw9YQT80ffzJVHYA/qyR5+y5g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4c4ad1-1961-4200-1974-08d7cd039c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 19:19:27.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDY8cXPVUA6DpVJan52lFDzYSqoRuxwQTaZXz/kSerYYOgCU1qnPcqTM566I+XZJEzcfmP78wUmMh4eXcUtsmFxnUZrHmW+ibG8Ef9QIwg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB2034
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello James,=0A=
=0A=
I think my one comment on patch 2 is valid, right? But for this series:=0A=
=0A=
Tested-by: Tyler Baicar <baicar@os.amperecomputing.com>=0A=
=0A=
Thanks,=0A=
Tyler=0A=
=0A=
On Fri, Feb 28, 2020 at 12:48 PM James Morse <james.morse@arm.com> wrote:=
=0A=
>=0A=
> Hello!=0A=
>=0A=
> These are the remaining patches from the SDEI series[0] that fix=0A=
> a race between memory_failure() and user-space re-triggering the error=0A=
> in ghes.c.=0A=
>=0A=
>=0A=
> ghes_handle_memory_failure() calls memory_failure_queue() from=0A=
> IRQ context to schedule memory_failure()s work as it needs to sleep.=0A=
> Once the GHES machinery returns from the IRQ, it may return to user-space=
=0A=
> before memory_failure() runs.=0A=
>=0A=
> If the error that kicked all this off is specific to user-space, e.g. a=
=0A=
> load from corrupted memory, we may find ourselves taking the error=0A=
> again. If the user-space task is scheduled out, and memory_failure() runs=
,=0A=
> the same user-space task may be scheduled in on another CPU, which could=
=0A=
> also take the same error.=0A=
>=0A=
> These lead to exaggerated error counters, which may cause some threshold=
=0A=
> to be reached early.=0A=
>=0A=
> This can happen with any error that causes a Synchronous External Abort=
=0A=
> on arm64. I can't see why the same wouldn't happen with a machine-check=
=0A=
> handled firmware first on x86.=0A=
>=0A=
>=0A=
> This series adds a memory_failure_queue_kick() helper to=0A=
> memory-failure.c, and calls it as task-work before returning to=0A=
> user-space.=0A=
>=0A=
>=0A=
> Currently arm64 papers over this problem by ignoring ghes_notify_sea()'s=
=0A=
> return code as it knows there is still work to do. arm64 generates its=0A=
> own signal to user-space, which means the first task to discover an=0A=
> error will always be killed, even if the error was later handled.=0A=
> (which is no improvement on the no-RAS behaviour)=0A=
>=0A=
> As a final piece, arm64 can try to process the irq work queued by=0A=
> ghes_notify_sea() while its still in the external abort handler. A succes=
full=0A=
> return value here now means the memory_failure() work will be done before=
 we=0A=
> return to user-space, we no longer need to generate our own signal.=0A=
> This lets the original task survive the error if memory_failure() can=0A=
> recover the corrupted memory.=0A=
>=0A=
> Based on v5.6-rc2. I'm afraid it touches three different trees.=0A=
> $subject says ACPI as that is where the bulk of the diffstat is.=0A=
>=0A=
> This series may conflict in arm64 with a series from Mark Rutland to=0A=
> cleanup the daif/PMR toggling.=0A=
>=0A=
>=0A=
> This would be v9 of these patches, but after a year I figure I should=0A=
> start the numbering again. I've dropped any collected tags.=0A=
>=0A=
> Known issues:=0A=
> =A0* arm64's apei_claim_sea() may unwittingly re-enable debug if it takes=
=0A=
> =A0 =A0an external-abort from debug context. Patch 3 makes this worse=0A=
> =A0 =A0instead of fixing it. The fix would make use of helpers from Mark =
R's=0A=
> =A0 =A0series.=0A=
>=0A=
>=0A=
> Thanks,=0A=
>=0A=
> James=0A=
>=0A=
>=0A=
> [0] https://lore.kernel.org/linux-arm-kernel/20190129184902.102850-1-jame=
s.morse@arm.com/=0A=
> [1] https://lore.kernel.org/linux-acpi/1506516620-20033-3-git-send-email-=
xiexiuqi@huawei.com/=0A=
>=0A=
> James Morse (3):=0A=
> =A0 mm/memory-failure: Add memory_failure_queue_kick()=0A=
> =A0 ACPI / APEI: Kick the memory_failure() queue for synchronous errors=
=0A=
> =A0 arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work=
=0A=
>=0A=
> =A0arch/arm64/kernel/acpi.c | 25 +++++++++++++++=0A=
> =A0arch/arm64/mm/fault.c =A0 =A0| 12 ++++---=0A=
> =A0drivers/acpi/apei/ghes.c | 68 +++++++++++++++++++++++++++++++++-------=
=0A=
> =A0include/acpi/ghes.h =A0 =A0 =A0| =A03 ++=0A=
> =A0include/linux/mm.h =A0 =A0 =A0 | =A01 +=0A=
> =A0mm/memory-failure.c =A0 =A0 =A0| 15 ++++++++-=0A=
> =A06 files changed, 107 insertions(+), 17 deletions(-)=0A=
>=0A=
> --=0A=
> 2.24.1=
