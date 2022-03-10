Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3E4D5257
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiCJTKE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiCJTKD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:10:03 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2F172E5E
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 11:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMwNlDRT4nOWLp6FH1XejWqcoatiXvWsWgHADXKFNh+oHpnZyMcNC86TjgbfKtCx6KiyeH/myv4+y1ICX5XiBHKfazQjVy13t7qWINdR09Uo/t8iFqrW9Yfm0ICJd98sfvGw/ZAIFzBfscSP1veXoAxAU8E3oOfrH1SWGx7OicnNxpPtB1sb/yoBIVn0K0lpXcL9WjXO1ALg7YI7xB6SH+S2Sfm7YHNv8o/txFgrajiA9cFVBOVsPwQMoatshb8eA2dMTQcNHPTrfd1RtKwjBwmF6FNMQTF5FrJA/Fm/CBVHD9EpXiupIJXN14IaajW2eLJfA0O/kY7vz5F+kvy1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nygUO3Lj7rD93OSjhmlb1V2kJF0a08CO/4BQwX1v2lY=;
 b=mdom1A5xrTbsTxjg3rLiz4IiJW3S2N+FFAOheLraNsrSOLd+HRrtn6k/9CVDQ7ipKXTweJParYC7CEdLc0Lxk46Sy39BIuwA+R75MjuI1JEGDA92STQ8PWUILbCHqG9Y37H33gdmqr1DydkJwMtlA2hpvLdLcjn8zeJGJ+0qFhitKNBFXqSCZyhSYgoKlIDi01Z896099lytE7fyx6FfVhYLrUjJ7F4EzUQJp4gLYbiAJDhLqRcgU0D1cH34YZSFdXfN67LfV4p1SNmHDnGDnt+NszEv298eU6cmJZ6lxbJNOFBJPj1c/v8wSO8vzTsyBB0y0ujJkixAAkAvnfptRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nygUO3Lj7rD93OSjhmlb1V2kJF0a08CO/4BQwX1v2lY=;
 b=G8hVK/ZUHm/ZjEvZuHdAvYZfHZGDnvng0sVfItk92Ok0HDtMuOR8H+902NfXddHdpQoZZY5xkt3wKniannAEofdDjt/gwhXwqmNVQnr2Ssm4qGGLGUJnRze3nfad5qliWbfQS1Q5KqGsEywVFvrR8RgXK6+CmijjjKtZUTo8m+0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR12MB1832.namprd12.prod.outlook.com (2603:10b6:903:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Thu, 10 Mar
 2022 19:08:58 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 19:08:58 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v5] ACPI: bus: For platform OSC negotiate capabilities
Thread-Topic: [PATCH v5] ACPI: bus: For platform OSC negotiate capabilities
Thread-Index: AQHYM9RbebGVAV332EKwvIQljZou/Ky4+9sAgAAAcwA=
Date:   Thu, 10 Mar 2022 19:08:58 +0000
Message-ID: <BL1PR12MB5157A25B586DAE3E5B58F696E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220309163749.773474-1-mario.limonciello@amd.com>
 <CAJZ5v0gw7z6qwXRYe-_XRTZouJ+gpAWX3W02jiMnaR44T453Cg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gw7z6qwXRYe-_XRTZouJ+gpAWX3W02jiMnaR44T453Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T19:06:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=af95fa91-3d9a-4592-96ed-10ccc2cb7f0a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-10T19:08:57Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 29206768-118b-4e8f-9674-ed7de209a447
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17a637b6-6b4e-4927-6915-08da02c96e47
x-ms-traffictypediagnostic: CY4PR12MB1832:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18322E2778BC64DB58FD359BE20B9@CY4PR12MB1832.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rH8ScpLzB6VAseRsdZgvC4Yf6hM+vc6OTTAUK6Cz9Ug0vVI9J0ZiXNk7DccqOKHPdumUFZpTHfEB2NOJ/ubnrGoaj/EMXt223AyU2TbwmyREnqYq2lmvXVKgRVJZIus+vsCtMKxKgUyZXRTvcSUybmutrY7d6jrG1oCprsR+k3WNDZqUysYecQJ+1gUnJaO7vIQqID9KFPNv8/M+b2WiJ6yB0JDpsW3CuNwQlLK4EU9RV34/qlVJBdp/KaSXMZPuyJUHCq6PQC8qJEbK/5UwGuE6xi1CIpMDdZL5OPjZIrdd1tvQpiWnSILiJKoZfZlp8XL+Y80zR0LywbzB3BZSJqrhUlVXs5Jsp9/SyDv24nzQcqlCi8YNfjxyJkJMdxeC0XGW74AxFEvxFwLnSx8XLrbUvjlOmoZ39o/mQTPM9/UXcJnQz5pIvIbiOJmfx8aSklquQRxpJgfyaTPS3q7Qkqq0Thfj2gUkbKTfNIoTB5DczpuVGSYawXNt5BAQeYIZItT1BM1KLkBnF6KALVzQnxoIYCuEYXuHJoNr0E3DM4MWIjhSWeVGmbXVbKMeJWHBMMzX0osd65RPQ9jlHrvnJoK3GsS4R9tzzQ+VInxygNuAUuaFwNO1vNnZYg98mAqOCQurfHGey7LG7aMqE7FUseqUjbxIhiUkKcI+qA2oaL+UYtYt8enDU0Tqx5E1i46t3v0mRXSvF3PDT4Ensiffg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(7696005)(9686003)(5660300002)(6506007)(186003)(26005)(2906002)(86362001)(8936002)(54906003)(33656002)(316002)(508600001)(38070700005)(52536014)(71200400001)(6916009)(4326008)(55016003)(122000001)(66556008)(66446008)(8676002)(64756008)(76116006)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0F5cVR3aGlzUnRsMmRsV1Z2Njd4a2ZORHN5N3ZOY05mM2tiSUdoVm1VdTA4?=
 =?utf-8?B?UXpLR3hVREVhRU1Nb21hOGYvVlRuNXdMK3ozK1ZwOVVMa0FLRVlrTUg1RjU0?=
 =?utf-8?B?TVhxbFp0aERqcDBsQ3pEVVUyR2JFeURtVExMc2tLR2xxamVIeEgxVG1FcklY?=
 =?utf-8?B?QkxuUVQrRmtHYkYrbk9hekNrc25TbWFWMk5hWjczY1JsU2tROUZDRmhvTi9a?=
 =?utf-8?B?eWpIYm5jMG9jaUE0aGNBaU9XQXg1WXd1Y2kvY21HdzRPZE11QWlBQ1BKK0xl?=
 =?utf-8?B?bnJnLzVFNnBQaUpNM21LdlUzQUt5bWZmQUFxTHBTcEwrSUs1Wnd5Nm8vd2Y2?=
 =?utf-8?B?Wmhhcjlqbk1STzhQZGFjOEVFT2R3c21KeVc2aEVVakVMOVlWT3JWdWtYUGk3?=
 =?utf-8?B?MVR6OFYwZFdPSnFGeFRmUmJyQ3RuenkxMHo2dFl6NG9nQ0ViZS92TXlkSkYv?=
 =?utf-8?B?V1pFN3JKTGEyK0NtSk9PUklNemhmcFVoUkEyQTFFMHgyWk1idDYrV2VKOE1D?=
 =?utf-8?B?SVRNdWFvTklYc1BJZXI3UmhvanplZW9WZ0JWcFRyV2ROT2J1c1grME1KbU9n?=
 =?utf-8?B?Tk1QcjZZQjNaNDV6Y0NYRW10TWxoUjMzOTRMNzI3OEJYbVFUTERpaENZWmxj?=
 =?utf-8?B?M1hRZXFqYTFqNXF5V04wZjlRZVFoQTgwTTliYUV0WkQzZENKMDZFZE5FQkly?=
 =?utf-8?B?T2E3VDlYZHVvdDhqQUx3ZXppRnpKVmljeHJYL0Z1dEZ4UUxTTUVVaElLSWxH?=
 =?utf-8?B?S2xmeVFIVzZWZmhrNmpheXZmWUYyNnRuMEhHN1FEV0RUT1dOcUpPeTViU1pK?=
 =?utf-8?B?QXB4cHZPVHdUZjlXM2kzdnRtOGZ1b1lTU0ZacG56aUNvUnkxcytaTDgrUmh1?=
 =?utf-8?B?UTU2N0F3UThVMm0zbXJjcmlMblNiVTUrT0NuS0ozV1pyc2VFcHNFRXUwOCtI?=
 =?utf-8?B?QStqaHh4WXdtdkZ2dWhyZjVhSXRQOFlPTVJDeDA1WFBncTBobEhTNUkrRFl3?=
 =?utf-8?B?eWdpSytPeFM5ZStqRVlHUGFqVWNrOWFoeDQ1bzlxNjcxY0k4Q3M3ckJXZXo0?=
 =?utf-8?B?STZFZTR4c0NpUEV5R0d4eFRpME8zRFU3RlVlQ2pIMjFxYkdsWDFCQm4rQjl3?=
 =?utf-8?B?N3RNZ3dyODV6TUlsd0lMSldWWjhreEFiakI1V21VakVwZjZXQnZUSjNBdzJF?=
 =?utf-8?B?bkduTFpOZjFxeTFKNGR2UnlxWVdaZXY1Sm5HWDhuVXY3K3JqR2x1T3N3eDdP?=
 =?utf-8?B?K2ZaLzhsdEwxZzNwdy9TaVlTdXN2Tng2Wkp0RFNHbUNUdGVrVjFSY0hlY1hV?=
 =?utf-8?B?S2pwd1diUzZlNlFXcGRUTW1xRUljWEpYREw3bzk3N2hrRElleURPM3hEaHVj?=
 =?utf-8?B?VWRVbnJNOU9Sb1JueGM5NEk0QVhPV3hpQ2JxY1l6QlJxaUw3YjlqSENaRS9T?=
 =?utf-8?B?aHpvQ0RZR2lzSzVHa0lQcU9yR1N1NW1MRmVZNGYxN01nb21ETi9FcncvTGpP?=
 =?utf-8?B?WVY2dSttKzQ1d2E0NjZOR1ZFdCtzN3QwdVY0V1U4VXhhejZiM3dyOWw5aS9S?=
 =?utf-8?B?MkhBWWdDdXp3MFB3YU5VdERUdnREWmp6S2FlSjMvUDV4QVl6QmVwMytvZXhC?=
 =?utf-8?B?ejg3TXlIUnJ3SkYxdWlhU1hnVFlFQllzSXJONWc1OXMxaktmUEt1eWZGNUNC?=
 =?utf-8?B?dThWNEw2TnRPbUF4THMwUktSWkV5Zk5VYmgzbUVpQ1Z2QXVHRFhmc3RleXl3?=
 =?utf-8?B?ZFVEbUtXeDF0Tzd4d0NSNlZDbjh5OEE0ZTJVNlE5Z2h4UkNENlhKaDNXUGEx?=
 =?utf-8?B?TXNqUG9Ydk9VeXRFRG04K29admpOdExxYUpCem96Yy9UUENiOHNVRytFRGUv?=
 =?utf-8?B?aHlBSHU4dTN0azZTaUluUFFNNHE3bGlmdXIyZHRpNGtKNXVjNXlxbWtrQnJ0?=
 =?utf-8?B?UWFybWtIVDRRS09VNnZ1bmlkRXIrZ1NxU2hpNlBKb3Rzd00wUUVOYjZ0TXRH?=
 =?utf-8?B?cmtJVzdhZktyQmRtTU5nVVJqTE9xeTFsK25jWUNXbGxJSjdBU2RMaFUvaVJv?=
 =?utf-8?B?dlZkVXd2Tld4SmlyZEErRXdFaUNqUXlKYlBDQmRGRUEvMjVXQ0N3WVkzbkhv?=
 =?utf-8?B?NVdXS09oY3hacVV6ZW5SNEs2TUJyK1dKMmZydjVkRjRuMnBpVWZyVHF2TDZk?=
 =?utf-8?Q?3NfhZAPqwrYvpMlVZLZVTQ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a637b6-6b4e-4927-6915-08da02c96e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 19:08:58.6626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4jjzUTmTTIeqZYuoibrnutY21JLcKO5k+Toi8lucjo9qw+XV0e1pzkIkFwmgs8D0GxbhEdioG9hq60Ot1O7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBBQ1BJIDYuNCBzcGVjOg0KPiA+
IEl0IGlzIHN0cm9uZ2x5IHJlY29tbWVuZGVkIHRoYXQgdGhlIE9TIGV2YWx1YXRlIF9PU0Mgd2l0
aCB0aGUgUXVlcnkNCj4gPiBTdXBwb3J0IEZsYWcgc2V0IHVudGlsIF9PU0MgcmV0dXJucyB0aGUg
Q2FwYWJpbGl0aWVzIE1hc2tlZCBiaXQgY2xlYXIsDQo+ID4gdG8gbmVnb3RpYXRlIHRoZSBzZXQg
b2YgZmVhdHVyZXMgdG8gYmUgZ3JhbnRlZCB0byB0aGUgT1MgZm9yIG5hdGl2ZQ0KPiA+IHN1cHBv
cnQ7IGEgcGxhdGZvcm0gbWF5IHJlcXVpcmUgYSBzcGVjaWZpYyBjb21iaW5hdGlvbiBvZiBmZWF0
dXJlcw0KPiA+IHRvIGJlIHN1cHBvcnRlZCBuYXRpdmVseSBieSBhbiBPUyBiZWZvcmUgZ3JhbnRp
bmcgbmF0aXZlIGNvbnRyb2wNCj4gPiBvZiBhIGdpdmVuIGZlYXR1cmUuIEFmdGVyIG5lZ290aWF0
aW9uIHdpdGggdGhlIHF1ZXJ5IGZsYWcgc2V0LA0KPiA+IHRoZSBPUyBzaG91bGQgZXZhbHVhdGUg
d2l0aG91dCBpdCBzbyB0aGF0IGFueSBuZWdvdGlhdGVkIHZhbHVlcw0KPiA+IGNhbiBiZSBtYWRl
IGVmZmVjdGl2ZSB0byBoYXJkd2FyZS4NCj4gPg0KPiA+IEN1cnJlbnRseSB0aGUgY29kZSBzZW5k
cyB0aGUgZXhhY3Qgc2FtZSB2YWx1ZXMgaW4gYm90aCBleGVjdXRpb25zIG9mIHRoZQ0KPiA+IF9P
U0MgYW5kIHRoaXMgbGVhZHMgdG8gc29tZSBwcm9ibGVtcyBvbiBzb21lIEFNRCBwbGF0Zm9ybXMg
aW4gY2VydGFpbg0KPiA+IGNvbmZpZ3VyYXRpb25zLg0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBu
b3RhYmxlIGNhcGFiaWxpdGllcyBhcmUgc2V0IGJ5IE9TUE0gd2hlbiBxdWVyeSBpcyBlbmFibGVk
Og0KPiA+ICogT1NDX1NCX1BSM19TVVBQT1JUDQo+ID4gKiBPU0NfU0JfUENMUElfU1VQUE9SVA0K
PiA+ICogT1NDX1NCX05BVElWRV9VU0I0X1NVUFBPUlQNCj4gPg0KPiA+IFRoZSBmaXJzdCBjYWxs
IHRvIHRoZSBwbGF0Zm9ybSBPU0MgcmV0dXJucyBiYWNrIGEgbWFza2VkIGNhcGFiaWxpdGllcw0K
PiA+IGVycm9yIGJlY2F1c2UgdGhlIGZpcm13YXJlIGRpZCBub3QgYWNrbm93bGVkZ2UgT1NDX1NC
X1BDTFBJX1NVUFBPUlQNCj4gYnV0DQo+ID4gaXQgYWNrbm9sd2VkZ2VkIHRoZSBvdGhlcnMuDQo+
ID4NCj4gPiBUaGUgc2Vjb25kIGNhbGwgdG8gdGhlIHBsYXRmb3JtIF9PU0Mgd2l0aG91dCB0aGUg
cXVlcnkgZmxhZyBzZXQgdGhlbg0KPiA+IGZhaWxzIGJlY2F1c2UgdGhlIE9TUE0gc3RpbGwgc2Vu
dCB0aGUgZXhhY3Qgc2FtZSB2YWx1ZXMuICBUaGlzIGxlYWRzDQo+ID4gdG8gbm90IGFja25vd2xl
ZGdpbmcgT1NDX1NCX05BVElWRV9VU0I0X1NVUFBPUlQgYW5kIGxhdGVyIFVTQjQNCj4gUENJZQ0K
PiA+IHR1bm5lbHMgY2FuJ3QgYmUgYXV0aG9yaXplZC4NCj4gPg0KPiA+IFRoaXMgcHJvYmxlbSB3
YXMgZmlyc3QgaW50cm9kdWNlZCBieSBjb21taXQgMTU5ZDhjMjc0ZmQ5ICgiQUNQSTogUGFzcyB0
aGUNCj4gPiBzYW1lIGNhcGFiaWxpdGllcyB0byB0aGUgX09TQyByZWdhcmRsZXNzIG9mIHRoZSBx
dWVyeSBmbGFnIikgd2hpY2ggc3VidGx5DQo+ID4gYWRqdXN0ZWQgdGhlIGJlaGF2aW9yIGZyb20g
NzE5ZTFmNSAoIkFDUEk6IEV4ZWN1dGUgcGxhdGZvcm0gX09TQyBhbHNvDQo+ID4gd2l0aCBxdWVy
eSBiaXQgY2xlYXIiKS4NCj4gPg0KPiA+IFRoZSBfT1NDIHdhcyBjYWxsZWQgZXhhY3RseSAyIHRp
bWVzOg0KPiA+ICAqIE9uY2UgdG8gcXVlcnkgYW5kIHJlcXVlc3QgZnJvbSBmaXJtd2FyZQ0KPiA+
ICAqIE9uY2UgdG8gY29tbWl0IHRvIGZpcm13YXJlIHdpdGhvdXQgcXVlcnkNCj4gPg0KPiA+IFRv
IGZpeCB0aGlzIHByb2JsZW0sIGNvbnRpbnVlIHRvIGNhbGwgdGhlIF9PU0MgdW50aWwgdGhlIGZp
cm13YXJlIGhhcw0KPiA+IGluZGljYXRlZCB0aGF0IGNhcGFiaWxpdGllcyBhcmUgbm8gbG9uZ2Vy
IG1hc2tlZCBvciBhZnRlciBhbiBhcmJpdHJhcnkNCj4gPiBudW1iZXIgb2YgbmVnb3RpYXRpb24g
YXR0ZW1wdHMuDQo+ID4NCj4gPiBGdXJ0aGVybW9yZSwgdG8gYXZvaWQgdGhlIHByb2JsZW0gdGhh
dCBjb21taXQgMTU5ZDhjMjc0ZmQ5ICgiQUNQSTogUGFzcw0KPiA+IHRoZSBzYW1lIGNhcGFiaWxp
dGllcyB0byB0aGUgX09TQyByZWdhcmRsZXNzIG9mIHRoZSBxdWVyeSBmbGFnIikNCj4gPiBpbnRy
b2R1Y2VkLCBleHBsaWNpdGx5IG1hcmsgc3VwcG9ydCBmb3IgQ1BDIGFuZCBDUFBDdjIgZXZlbiBp
ZiB0aGV5DQo+ID4gd2VyZSBtYXNrZWQgYnkgdGhlIHNlcmllcyBvZiBxdWVyeSBjYWxscyBkdWUg
dG8gdGFibGUgbG9hZGluZyBvcmRlciBvbg0KPiA+IHNvbWUgc3lzdGVtcy4NCj4gPg0KPiA+IEZp
eGVzOiAxNTlkOGMyNzRmZDkgKCJBQ1BJOiBQYXNzIHRoZSBzYW1lIGNhcGFiaWxpdGllcyB0byB0
aGUgX09TQw0KPiByZWdhcmRsZXNzIG9mIHRoZSBxdWVyeSBmbGFnIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiBUaGlzIHNlcmllcyB3YXMgYWNjZXB0ZWQgYnV0IHNob3dlZCBhIHJlZ3Jlc3Npb24g
aW4gYW5vdGhlciB1c2Ugb2YNCj4gYWNwaV9ydW5fb3NjDQo+ID4gc28gdGhlIHNlcmllcyB3YXMg
ZHJvcHBlZC4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2NC0+djU6DQo+ID4gICogTW92ZSBuZWdv
dGlhdGlvbiBlbnRpcmVseSBpbnRvDQo+IGFjcGlfYnVzX29zY19uZWdvdGlhdGVfcGxhdGZvcm1f
Y29udHJvbA0KPiA+ICBkcml2ZXJzL2FjcGkvYnVzLmMgfCAzMSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9idXMuYyBiL2Ry
aXZlcnMvYWNwaS9idXMuYw0KPiA+IGluZGV4IGI5NmM1NDgxMzg4Ni4uODZkODhiZDcyYzA3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9idXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNw
aS9idXMuYw0KPiA+IEBAIC0yOTQsNiArMjk0LDcgQEAgc3RhdGljIHZvaWQNCj4gYWNwaV9idXNf
b3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKHZvaWQpDQo+ID4gICAgICAgICAgICAgICAg
IC5jYXAucG9pbnRlciA9IGNhcGJ1ZiwNCj4gPiAgICAgICAgIH07DQo+ID4gICAgICAgICBhY3Bp
X2hhbmRsZSBoYW5kbGU7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgICAgY2Fw
YnVmW09TQ19RVUVSWV9EV09SRF0gPSBPU0NfUVVFUllfRU5BQkxFOw0KPiA+ICAgICAgICAgY2Fw
YnVmW09TQ19TVVBQT1JUX0RXT1JEXSA9IE9TQ19TQl9QUjNfU1VQUE9SVDsgLyogX1BSMyBpcw0K
PiBpbiB1c2UgKi8NCj4gPiBAQCAtMzI5LDEwICszMzAsMzQgQEAgc3RhdGljIHZvaWQNCj4gYWNw
aV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKHZvaWQpDQo+ID4gICAgICAgICBp
ZiAoQUNQSV9GQUlMVVJFKGFjcGlfZ2V0X2hhbmRsZShOVUxMLCAiXFxfU0IiLCAmaGFuZGxlKSkp
DQo+ID4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPg0KPiA+IC0gICAgICAgaWYgKEFDUElf
RkFJTFVSRShhY3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+IC0gICAgICAgICAg
ICAgICByZXR1cm47DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogQ2hlY2sgaWYgYml0
cyB3ZXJlIG1hc2tlZCwgd2UgbmVlZCB0byBuZWdvdGlhdGUNCj4gPiArICAgICAgICAqIHByZXZl
bnQgcG90ZW50aWFsIGVuZGxlc3MgbG9vcCBieSBsaW1pdGVkIG51bWJlciBvZg0KPiA+ICsgICAg
ICAgICogbmVnb3RpYXRpb24gY3ljbGVzLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBm
b3IgKGkgPSAwOyBpIDwgNTsgaSsrKSB7DQo+IA0KPiBXaHkgNSBpdGVyYXRpb25zPw0KPiANCj4g
V2h5IGNhbm5vdCBpdCB3b3JrIGluIGFuYWxvZ3kgd2l0aCB0aGUgbG9vcCBpbiBhY3BpX3BjaV9v
c2NfY29udHJvbF9zZXQoKT8NCg0KNSB3YXMgYW4gYXJiaXRyYXJ5IG51bWJlciBzZWxlY3RlZCBq
dXN0IHRvIGd1YXJhbnRlZSB0aGF0IGJhZCBmaXJtd2FyZSBjb3VsZG4ndA0KZGVhZGxvY2sgdGhl
IG5lZ290aWF0aW9uLiAgSXQncyBhZG1pdHRlZGx5IHVubGlrZWx5LCBhbmQgaWYgeW91IHdvdWxk
IHByZWZlciBJJ2xsIHN3YXANCm92ZXIgdG8gYW4gZW5kbGVzcyBsb29wIGRlc2lnbiBsaWtlIGFj
cGlfcGNpX29zY19jb250cm9sX3NldC4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgYm9vbCBy
ZXRyeSA9IGZhbHNlOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKEFDUElfRkFJTFVS
RShhY3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICAgICAgICAgY2FwYnVmX3JldCA9IGNvbnRleHQu
cmV0LnBvaW50ZXI7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHJ5ID0gY2FwYnVmX3JldFtPU0Nf
U1VQUE9SVF9EV09SRF0gIT0NCj4gY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXTsNCj4gPiArICAg
ICAgICAgICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSA9DQo+IGNhcGJ1Zl9yZXRbT1ND
X1NVUFBPUlRfRFdPUkRdOw0KPiA+ICsgICAgICAgICAgICAgICBrZnJlZShjb250ZXh0LnJldC5w
b2ludGVyKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFyZXRyeSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAga2Zy
ZWUoY29udGV4dC5yZXQucG9pbnRlcik7DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICog
QXZvaWQgcHJvYmxlbXMgd2l0aCBCSU9TIGR5bmFtaWNhbGx5IGxvYWRpbmcgdGFibGVzIGJ5IGlu
ZGljYXRpbmcNCj4gPiArICAgICAgICAqIHN1cHBvcnQgZm9yIENQUEMgZXZlbiBpZiBpdCB3YXMg
bWFza2VkLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyNpZmRlZiBDT05GSUdfWDg2DQo+ID4gKyAg
ICAgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUCkpIHsNCj4gPiArICAgICAgICAg
ICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSB8PSBPU0NfU0JfQ1BDX1NVUFBPUlQ7DQo+
ID4gKyAgICAgICAgICAgICAgIGNhcGJ1ZltPU0NfU1VQUE9SVF9EV09SRF0gfD0gT1NDX1NCX0NQ
Q1YyX1NVUFBPUlQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKyNlbmRpZg0KPiA+DQo+ID4gICAgICAg
ICAvKiBOb3cgcnVuIF9PU0MgYWdhaW4gd2l0aCBxdWVyeSBmbGFnIGNsZWFyICovDQo+ID4gICAg
ICAgICBjYXBidWZbT1NDX1FVRVJZX0RXT1JEXSA9IDA7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4g
Pg0K
