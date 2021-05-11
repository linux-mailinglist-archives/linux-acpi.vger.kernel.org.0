Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77A37AA87
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEKPWH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 11:22:07 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:62720
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231461AbhEKPWH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 11:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqV+x6ikH39DKqCgN/qe7HiBPgnVAz3RIEp0vwUfoTOLOpOdUOdIf4cYVdvLj4iGR8XOo9x9dW8BFIwr4NBey5yvSxCjL8CBYgKF3E/wdGqcPDf8NOVTsIn3uDgy3h31D9ObFS8l+l8jJn/kJFh4nNLxDYqIml2BPOTyLRz3p/FdBiueKb8Yg2yAdfXXuGuNRC2urP7bDorjmqljS6B2Q5oAQMeqpIvknGvcHSkC9t4ZkyMU9ROvrPOq1Wdb7AtYHCRqvs+YcP3kIwg9locnzrEKIMaGv+hkZFnGZexzodajPcDfebnfI6QjG5YOz8miPtxUI/HP+1UlnwTi3+fLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrgZoLbIyuuBL51NWzc5kXkE5g4yct2UCIzU609GQOg=;
 b=LrbHrSMjSgmwZQxb9GieQBh8qIXw6nwU4Mwf7FW2EjoMtOsU3Fhs/7JV6PmYTS+4UpgWoqzidgcJur8VCxX3lYwa/HRHDMxqXkbkbj+ecbiIy1I2XP3fgsFzsVI0S1Pys2/NZdApflpljdftHszjJ1rdE5k/wKJQb03WsDyZYZMhu4JTXqlx5oAghY89DU3N3Zi7vuQqjEec8tvYGyyo4l7GM8wkxNWpb6ZA1u6HqKkQ7FQNiU0xI6FSgzxgAWbXEI2XPaKyh0VGaLiEMnw5IMDigzoTapkzApCXr2vFS+sjdVoCSPOiTfJB/7LKXyosKdZUnWfziDisBSJVm46jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrgZoLbIyuuBL51NWzc5kXkE5g4yct2UCIzU609GQOg=;
 b=W45qOZErxisSAGUejhJGH27IsK2U+dGuIYtMYyKT9O1CkMLFhCb9m1VMyP0O1ZKQAuY5ylH+QDVzJMBSoRFSO2B88fu6un3a2et6aV4J32bpctK98J8SwwjP6J3dYLE9PbynpqiOYN8QP/RlvrjlaDoiKwKv9oPSe1DToF6k2MY=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB2885.namprd12.prod.outlook.com (2603:10b6:a03:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 15:20:58 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:20:58 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXRhB2PGuo7Bnw1UWLxLUelvn94KreE2SAgABSPyA=
Date:   Tue, 11 May 2021 15:20:58 +0000
Message-ID: <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-11T15:20:18Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=8e660593-1576-4607-a1bb-cbea342f70d5;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:5f0:f9af:d99c:b88f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b059b9e1-cac5-485e-bca0-08d914906131
x-ms-traffictypediagnostic: BYAPR12MB2885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2885ABEFF0655FC1BE2B2B88E2539@BYAPR12MB2885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNRo/QP2i/1QQNsVhw/a1QoFukgHv/vFcDbas4fUNOC/cct2U40prJVXHewyJxmYmeX0Fi2/qxXV4d61MsK2bij8e001/UTgobTYzfxfS+p+euy6njDilqTBUWS41abu6CDZ+QBMQ/T7NvJuwPjw0QI2beQbZ1a5SeUu9MIvtLLUG6FSq+QQPSxGXLz/O10GltJUGii8dLC3SJo6M5HZIXLlQKYoCYSogOblgAq2YqyUZlpvXUq2H0v/N/6E7fbdus7lhUT/465e09f7j6AOg1pQ5T/YVXr8kjaLGsoZtF9I+mMMU2uZZcM031DxVipMfmgq7SDVM8HzCQBlJNFtWKWr6yWz42f7jJtB6lKrhMGdvNyeg/ZhWIoxYSf+wsFxZRXzgHlylw4bhfuarNMN0e6d+HZ4YslXnfz1VY5be6PGziY66o/SlatCWegY9QYGKo0JUrGDTAOfuD7EEQPc56I8Ntn+W3XO+tvawSjUvENkY5n/sum+wtj60N5KuodNo1msSCBuRiKnTBVYz/D9Pz2GFK/6SrrgycUD9EoeRrBln7m5RSZ6bqiMLPNgAIrJtD6hQy+1dl1/YfY9Oy5PKrREWjj97EFORK4dSOcNEVzaWmfjCtXT/Ur092CCf6ser95EWTsLjmIcTyTFz1BWzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(2906002)(76116006)(4326008)(4744005)(54906003)(71200400001)(9686003)(66556008)(64756008)(86362001)(66476007)(38100700002)(52536014)(6916009)(83380400001)(6506007)(5660300002)(186003)(8936002)(8676002)(498600001)(122000001)(55016002)(66446008)(66946007)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?86h9CDMAWsSJCh83+rRyGtkfiGbI7WqJUaXdqQY6AkjJu2YQHLXtXFoQfTS7?=
 =?us-ascii?Q?N0tPU1KbXtS5Dpqe2HdMSGJ7rusb5dyQq7xypgoLRpGMv1K3qAtEsbZ6DgOB?=
 =?us-ascii?Q?xBiOZqWDmOkaWfBUErVodCj0UlUJmDpJX4wBfVpmTEnmWlymAacTGcAWz18z?=
 =?us-ascii?Q?rTL3VLXdljTdZwkk6HLeiXl5IDpXxjy/7Ls4j/Fe3tcRcomt1O92pQ7/lDMj?=
 =?us-ascii?Q?nPvZ5+EQLr7wbq+ZRGb90PAyQES4JlC3EmckEBzXq4OCY7L9hkbc98Uf3537?=
 =?us-ascii?Q?B7XtbzvKhEG6cFIZWEwfEMcMWIrIcjTvmig10aT5WiGi3wWgMpQzJJFnAj7x?=
 =?us-ascii?Q?FIwaHTsUtyhezHSiY5eNu/dBXwn85gnRzx2YsMAbtSI8fzBqHJ/C9zw2wCD8?=
 =?us-ascii?Q?qXGaL3AdXD1/77XyJokFJUBydFU846ElBferK1OuvvV5tkwnbpoM4vPwAZAM?=
 =?us-ascii?Q?u/VsTyVZRqdJ0GTVLUH8rNb+bJmYoykUmO3sDdDLh4Te4x/53MTMBqvbGR1M?=
 =?us-ascii?Q?5/SwLGnjXp3LmSj0hPwUyYbvq5FZWVF6c+0TAKf88gSMPNY9A/3J7rO1JxyO?=
 =?us-ascii?Q?zpU91mQFISh6U89UT7uF0UGA8gbcCMjY2L+5V6AK9AhsAsi4O/RkWTZB+rQj?=
 =?us-ascii?Q?Ma3ppXPwF81df87lQ/uHUoXXj6VjhSsasJEHqmIe5srNSZDEwngkcsL206hS?=
 =?us-ascii?Q?OOGNKN33gmAK107/f0dUccqimDyGBcnM7zPaFyHq/p+vvG1AwSP44BUtTCzZ?=
 =?us-ascii?Q?ggL6WtMDXJWZrEnnt9MV6va8JemVX/H8fMR23kcSvfLaot/ZZu3F1ym1TGQL?=
 =?us-ascii?Q?Qgr7npSaVvUMWvq7gcDUujEWQyHMV0IQeWEBjSX8cRCrnjZN+JuGqdcwBv90?=
 =?us-ascii?Q?GB0nbSWj/bKWLkNHeBcjRPswjpik+UHDl586v51x5aLK4fA9vQ60UfLyGraC?=
 =?us-ascii?Q?KkLb+MtuOHSlth+ILTxtrVUVqxboXtNv4RLkhCiYzzAqpYiayGh2ADmuwnsu?=
 =?us-ascii?Q?d7OI8RK9kaaoFPT77onLNWtUE4elXBVR+IOTZ8P7SxglaQC4mF2KrapnQXPY?=
 =?us-ascii?Q?fR+8slKEsdWqXnLM6H70QPYpSAoTfkIbZhbelORqVeFUOfYFiDLp90Bu36A5?=
 =?us-ascii?Q?JvkJX3Wd5oy4+I82zC0zdA9jjSt1RyQpUfw2ONC/SmeOkphpv16DG64e7JAN?=
 =?us-ascii?Q?ug+MtXZn3Mksn9zNFAu/Bt35C1WPQzgWwdVk5NEnpNyUUKLD5mUgM3/IMuHW?=
 =?us-ascii?Q?9/r5QQIb3OQklUj/AMHT+hhONcBUIYnvt+8bhWenN9oeuvWlsIu7+WUmycIF?=
 =?us-ascii?Q?YCXPTePV+yCsg2zrT/reOT18JVF3gnYOq90ifJxk4xjD4Zf9HJVlKxzaKFPz?=
 =?us-ascii?Q?LEDae4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b059b9e1-cac5-485e-bca0-08d914906131
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 15:20:58.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/tva3XCqWAy5Zp0Vuzwn2SJAcMOMJLtsXVn6a/PVJeJ+5eDlunWmM/szPKS+MfqIw3o4b9hAF1KX+tV3swmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2885
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Well, if find_deepest_state() looked at the target residency instead
> of the exit latency, this would work I suppose?

Unfortunately I don't think this would help - from an OEM system the follow=
ing
target residency values:

# cat /sys/devices/system/cpu/cpu0/cpuidle/*/residency
0
2
800
700

>=20
> > In other operating systems the latency values are not validated and thi=
s
> > does not cause problems by skipping states.
> >

