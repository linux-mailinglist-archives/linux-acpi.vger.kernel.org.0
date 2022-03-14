Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0D4D85E4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiCNN3p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCNN3o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 09:29:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310812618;
        Mon, 14 Mar 2022 06:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxklnZnKP1YhAjPNOMlI7RO3H6yzul0Uw1BnLj7dvyRbKCznEP8XeH15+sC8c7NYnTMhQ9/oNxpYls69OkEcEsBlNAUNB/dFDOcOc3ic8EMZUF1bbkelt+hgHJTPYfRb0h6WNacpuOjIXBryr0AQyl11WHMKytDRDerM58acj8iXKs/9noWxja1SuWaPbY4+YeSNAU5dCVgjGsG98J/0Y1Yviz2Pc1xNedrqOmimEAolobv7zR07yYLwdBgYbZx8qzdXpkGJ31dkqM1dXFYSObbg1jk5swBGmE0qHmHHXvppfKrx4uhH9+flgkfjskRMlguCVtc+wKMarnwfisbD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMg2Oe5jVBoJJ5OLBkhBzj0g23DfdrzNmE+7L6aIl6A=;
 b=Po2Q/s6g2DAC829jdYvWQZ67dr4SShilO3lDx8pIMlMazKaQxPPaLA9Q3cl4ni8ZorPDJE/WxHwOl4hosUzRuedrd22kUFn0DLiPKMNQbxiMIHIxu9IVwuKcTA4n4hKQ/YehliujU6TPp4oyTs3Kt0rBZ7DM6MQU/XXglqxag7arjGloNiUu+YiF9lttzC/iJ/ASVYde2LxzDgSfGhFxzDXGUFVoQL/RHhhaFGmTljNonh7wX02xGF+nr1nYSg5YnkIqurZT3YxSKwA2+H3AgGrpkjXdkGrD17Xoj7+R3fV6uwQIlJEMsZYRQKskgG22l7u4aZiU7Y3GFGFRndt+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMg2Oe5jVBoJJ5OLBkhBzj0g23DfdrzNmE+7L6aIl6A=;
 b=xio1LM+aqPqId89q2Ze9zwvtzMN4Gh5vRvOs0cAm6x5hqlYipdeHFvkJDY7DjqKMAd3HWVRttIp8o9YfG5DeITvmNR+CtVb5HZLhBNcr7Wv1apKmfzHpcJTix1x4S7kpvOTeG8ONrBj4CZVulrENov3nP5zN5dCjcLqVFzZY21U=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 13:28:31 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 13:28:31 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Subject: RE: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Topic: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Index: AQHYN2DqFPMQrXTwwk2R9AIKdGhSYay+mJWAgABGODA=
Date:   Mon, 14 Mar 2022 13:28:31 +0000
Message-ID: <BL1PR12MB5157D2C86D5588607F53EFAEE20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <20220314091247.GA28904@wunner.de>
In-Reply-To: <20220314091247.GA28904@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-14T13:24:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3bc6693e-d61e-409b-9dfd-3f2e119984b3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-14T13:28:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1650cc4c-6833-49ad-bef9-26907dd61483
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 145bc63a-1f66-4bf0-7082-08da05be8875
x-ms-traffictypediagnostic: DM5PR12MB1898:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1898759B5EF7FC1101B29FB0E20F9@DM5PR12MB1898.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdmtiSI6zDqowg3HSMZ6FqNd6rFv56Zx/QXt5nTbgDz0y7aticNudEkxbryBbmV5XwV6iEW0gqTbZgoo95oIk0VD2bKppUMOfhs7SRX7JXS6IcX7Hp79W6JPhvhRPZxU86Z53nmt5LASxy2AOtVc+eMdHTrxqUVzn9Ci5KyXUTvbcugCmgV35m03A/lRvllPj+uFYGux8XwkPfrhSUVOJADGbp2TdmaMFfkJnfS2+T+9FXr2jBC0EokILgbSL4LaWdkk7pWnbR6TRZhs2g9CHs6M/J+BdQ3hxwbsQZaIvJ1rMEf+jD6+2vimVGgFZ8TO6ExJ2wjNi+6N+e6rXqCpgAlO0QoqP3arsCREHC265dh4jcBVnSG1r6kKnzA/HzVyC3Nt2AnHaHLwqU+VtweTIyDL7cYfvLXuUhTo3YQG5SJUWC3eF57nbnPQq9MbQQkS2biTUuLFd2ET6wi5w3A0DMC/ykGaKGwozQXEf/x53NApmSti3jW6eCg58Q4MB4/0csacCmLlosrSj22kWD0rHKnqBEAkSt2zrDd7Iq991MrV9ylW2SgOnzl5ihpVjIVkPxS4mrEW2ZYEBqzQJqcLR+IMl94z2fE0LZp3jo/hRO4AwX6kBgp00astWEZYfhloZN8JEIjPOKXOjBDNBkli5J0WS0XNs1xHN+bN+u6WI3NNHIjnsuLDks53f2kjVfgHmXstMiTCXbBPw7BtXCa6dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(508600001)(7696005)(5660300002)(9686003)(55016003)(26005)(186003)(53546011)(2906002)(52536014)(71200400001)(66556008)(4326008)(8676002)(76116006)(66946007)(66446008)(64756008)(86362001)(66476007)(8936002)(316002)(54906003)(6916009)(122000001)(38100700002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9RR+/dbLQOmumm1jgSkGtkz5uzBiap7cpZMJYIoNRrD1niZUm4AVyVkosmTc?=
 =?us-ascii?Q?kGiATttqMmr86zzAsyyPBSzK4INwhlB4vhIf2puXAfwIY6+G7HPoB5h2aaao?=
 =?us-ascii?Q?RQZIeMefwWHR7G840csuiQPYQ6/lJSXVRJhWZAf/aAris6SBhLFxumNJlikz?=
 =?us-ascii?Q?0k1EoKArwFXz2mcSZF9jbB8cgwP7j32EH68kZ/nqwUFijW6dODR7aCYr4U71?=
 =?us-ascii?Q?zJSqepFOzSgtLSJmg7rvdQh8qAoxrjX3Bv0H1+gZZd0ZT1PANFRjH0tUGPBO?=
 =?us-ascii?Q?iTHIBetkYhxYBO0ec70MFB4bclb9lsEjKum9GagKS9qcuPYjR7qExVnZhzsk?=
 =?us-ascii?Q?GlHp6jvmb7XoIEIwryirShKa31zWsSVDLBpi4tiEYh/tlL/0DJ3AoGCwXtQz?=
 =?us-ascii?Q?ymWTHLYLwlf4Y8ZS4a7ZFzjwZGoLZcGeMNVUvyW685d77G7gD0wyOCCYhLGk?=
 =?us-ascii?Q?v9DQITcljwhOnVir3zO2sZENcY9nSeHVMtkFpu6+0CL65dMnoeph9hUbBFQL?=
 =?us-ascii?Q?ViEQkCIuo10wK+8O2JW+u+o470Ort9gUqZPA/PW7vEKiU/K1cT06CwWweAQh?=
 =?us-ascii?Q?H21AJDJypglVHE81lHN6neG3SakXJXIhtTk6COzr3n1+eQYEBw7LRByuByYF?=
 =?us-ascii?Q?KcJ5hxXDrCrPOVuzsDms/+qmcfm9dotAM4iOlr/prQvB/ZQCm/agJsw61iQs?=
 =?us-ascii?Q?u2gFXW5u7L+IztSIGK4p1tw2H+0OesSFDJwVNzDi1yGT9Ane+QzGYkA4FFHH?=
 =?us-ascii?Q?x3idyFmHFxtLtRsGVIx2xTagbeQbgIXLS3MKfMShf9xEeAE3HIC/Cp213zX2?=
 =?us-ascii?Q?r/44VazwLxJQsQEDXRp3o4mNVRmlpvW1a4VXr4CTonNIRfab1mmdH0IR6KQD?=
 =?us-ascii?Q?RTFu1yzHTdkkZ+p2xmmmABrQHBvb1QoPkEYluTK7J6ZzHlsv6lfnkzYZNdn6?=
 =?us-ascii?Q?4WRiARwDi3ArW279/MgJk0UTgi78BePvXgY8Fnx6bM2HS14BemRwT83zkINv?=
 =?us-ascii?Q?7rS/IrnzWTWIa9s5KZKY79QnMbp/HKgGwPhMDFVIfwJyzR9WDhYeQTvzhLrm?=
 =?us-ascii?Q?kVt4YpdRdbrjpFjsdgCMeJMk3h8K+rgf4HvosLAz931qvsuwux79Zu6ySa/p?=
 =?us-ascii?Q?Kc6Tc3UVJ/ykTlI+ZOxm2rxJ4PZ4NNrejhB2yHUCXKtu96i2ERFwTTXmmJMv?=
 =?us-ascii?Q?wElUJJdJ1vonXJjzNNg13pGwjyez+9ywYabAKlefVAu3Nj1gUa1O5uXDWYdD?=
 =?us-ascii?Q?R43wdxaAnvn7ibKEI/a2SSma7u8CW2ygLU8noEGSm888nXm2aDqle4sI0hg5?=
 =?us-ascii?Q?bOL+XjDBpK5oZTRAiz5Yu9h4n3Ho3NCdMAYGM6q6bcSBBLW+ApShW/lXSPVh?=
 =?us-ascii?Q?GE0F1+4jjkixGEg3dj7npljFGJtXZO+Dl3QtLcFd4tXjLYZJsUH3uzvtQBNI?=
 =?us-ascii?Q?GZSIfnemYKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145bc63a-1f66-4bf0-7082-08da05be8875
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 13:28:31.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9WvVt3IpMr1LaS+VaOXa/9LDvfSnLNSxNyTHlAjwZ3OAqYKKYUotYqu0Gg1zUgtnVGq7RZyKulKz6avzug+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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



> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Monday, March 14, 2022 04:13
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; Mark Gross
> <mgross@linux.intel.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; open
> list:X86 PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>; linux-
> acpi@vger.kernel.org; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> Goswami, Sanket <Sanket.Goswami@amd.com>
> Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback han=
dler
>=20
> On Mon, Mar 14, 2022 at 12:03:35AM -0500, Mario Limonciello wrote:
> > Currenty the latest thing run during a suspend to idle attempt is
> > the LPS0 `prepare_late` callback and the earliest thing is the
> > `resume_early` callback.
> >
> > There is a desire for the `amd-pmc` driver to suspend later in the
> > suspend process (ideally the very last thing), so create a callback
> > that it or any other driver can hook into to do this.
>=20
> I'm wondering if this can be solved with much less code by either
> using device links (a device link to amd-pmc from everything that
> needs to be suspended before it), or with a notifier chain?
>=20

I don't believe that device links will work well here - the LPS0 "prepare_l=
ate"
happens after all device suspend routines are already done.

Notifier chains would probably work, but I'm not convinced they will be muc=
h
less code.  As I already have everything working with the current patch ser=
ies
before I try I'd like to know what Rafael prefers that for this purpose.
