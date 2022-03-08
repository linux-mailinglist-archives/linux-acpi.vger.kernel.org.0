Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB524D1C6E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbiCHP4m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348136AbiCHP4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 10:56:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165E4FC73;
        Tue,  8 Mar 2022 07:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOz3tjSaanCed4oPf5Gbn/wpM/AxW3bFBORSE8+KatDWzt3QDaJJJMMXOa1dkioIGPHwjGa/LLsUFCJZbwzqBxsT4SdCPdPJwj29SW9M3LEfDLSNjQOfK8yS6ywMaCkxpvtcqKxxEjTScn6OvLEng1kI4pVEPnRpzaN+3CSspvjyQFOHyxQOCWAyT+ojWbzx6g59Ls3QtS5EhVOcHQKlz+Qfe2MbVBcKXtUjoQPZ9HX+O9vDwYsdZwzfn0BH3VVz/PKAzeExIvFxD4juwryMEFdrim7CTlobrJEOrVg9CBmXHc3ZTAyD6V67fBUpqPYmAjDMf7xsCCvUZMLewE/57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6jGxtIihlcW9yPQGltXPfxMWMoAMXpX5Cejk1xPoXQ=;
 b=FWCajj28boM1e7HOsCDJUFTonvANA/df4jnsAnHcZD8TXeRRwuOJ124ckOmHCf/6qgvyTvqjvrytW24cojiypID+OFEHXN0wGt8l/z1rEnhHBTexl8vdvmE3Y+p+YHA6B6w1tVFP57JECDEEcduJF0SXv6ZyjXUeK6hr+lvpij5waCWv3gRcv5UK44PDLSPXq2NhmyEUygJklthNQtLjcIR/38oecy38PSSzVZWSYkPNFtgrt8BmWSghRS2ZXqmG9WOAmLh0bbPyTq37vfyTFqORP+SnPbqVmhBVo4vevIB5F1NE7rw9TlBFiSUgL2vPwFA7ynvZ/XUMUBGyNABHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6jGxtIihlcW9yPQGltXPfxMWMoAMXpX5Cejk1xPoXQ=;
 b=PG5DP865Lu5bQZd1an2jKqjQw6/mtngFsqc1B66j4HYPVd7PhNDG23/rT1o7rdQQ88sFCcgea6+0kU40L//8aT5x7R4/ci0rTIKnpPAdS988KhcHdasJxe4OCn0d2o30W6M5IH4X304k4fj9CLFSvF0pCJJdJS7lkjS8QwHBQqQ=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR12MB1551.namprd12.prod.outlook.com (2603:10b6:301:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 15:55:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 15:55:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [RFC] ACPI: platform-profile: support for AC vs DC modes
Thread-Topic: [RFC] ACPI: platform-profile: support for AC vs DC modes
Thread-Index: AQHYMvpOgF/dWfErcUSFT4Dgm8wHfqy1kShQgAAH2ACAAAKsEA==
Date:   Tue, 8 Mar 2022 15:55:26 +0000
Message-ID: <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
In-Reply-To: <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T15:55:24Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2561bc53-d6dc-4d01-9c4f-4db5e43f0b58;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-08T15:55:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7a3739b9-478f-401e-bd10-2b9b405671fa
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e9ce40a-75ff-476a-3b5d-08da011c0fc7
x-ms-traffictypediagnostic: MWHPR12MB1551:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1551304782BDCA94C8C90D02E2099@MWHPR12MB1551.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAnSrABV2Z2DcDuW49KlR2VuR548VGsBWFe3hP4ocUt+C405565RmHpMpuWBSSNRLqtDr3FoI4eW10UyJ4qJl/FUOLhKHmCH+3589se1H7sx4whepU4CYPHDVKdtq/RqTDs8AJYLSwfJ/2Por9MViO2Za4DiM4Cr1oDhDQQT4JdU9rXt0WN9ubKN8EXCI7h0ctBf7S7/TFoupETc8XPrvrNs2RMvanqxHXR+9Pe7suMI1vv2ol/a1wnuMPY605FN23XtMPtQk/Zv3PIoiTkzowGTNy79+cwr32s4sgwhnNn5cXTwNgXQajlk5M49d93Jb87baYnYu3uf+flEEVdT1m4Sp5qU+jz1gH04IIulJs8l6Z0sXQYC9qtz9ikk3+Iw6p5Rb/pR2+X6o6GQF7NGioJvHIMzDRa24zOvByQIcoAxxpUx2KcaK4Pyajtwf4dM6JMgji2XHEN42wKFD9s3TptSftj0ZT8oTdnmrjoKgc+7omU90pQB11eC7Ibd1zVh7PmMyw7dYjVRCbcHOo6ejGK3BpIDwYbQbJ1CCzn47T6glaIW2oVN8BXSnVFrPYZAJhTlqBynQW+dMyphTlVlZl7d95Ok/MDLZiYFNV8En7Q/Aq3bSfCxPyb65BuNtkmtpah6qo4n4u0ncEHLF+dYHWZs8FHuiLGg8vt1OK+RLUqkRSD8NRDQZf++Gn0JI+Kp9GG6TtOrCjyHPw+NvSlsfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(122000001)(33656002)(5660300002)(83380400001)(8936002)(66946007)(66476007)(508600001)(2906002)(38070700005)(8676002)(64756008)(66556008)(4326008)(86362001)(66446008)(316002)(55016003)(38100700002)(7696005)(54906003)(9686003)(6506007)(110136005)(71200400001)(52536014)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFVWQ0kxV1VJZC9QQTJnNjJuQzRlb1BNN3h2UTh5d0tCZzAzd25KalFON1Bq?=
 =?utf-8?B?WFdPaUFBS3BYNkRQaXlXSWxaQTVsK092L1JYeEJ4NE9vOU5WVlNLS3BWYkZF?=
 =?utf-8?B?d0g3dmU5dS91ZVlPL2RiVytVaDI2aEY4SXI3RlUwNTFBVW12R210SURXUXMx?=
 =?utf-8?B?aURjTW1OYVh4MGNqOUNPV040eXgxSEI5UWZ6c0Z2VXhzWGVCdmNxVDB6c2xv?=
 =?utf-8?B?bVJaNzIxK3VXd2lzK0lRMy96cUdpdUxmTm1VSnk1ZjBGU0JvV09iYnJkQnhn?=
 =?utf-8?B?NlBMMVAxMFBDckFoZld1d2dsaWhucm0vOTFIVjRBRDJ4QzFFWDBUQ2l2eUNW?=
 =?utf-8?B?cXYydHJzSjlzcitBRmN5dVR3bTYxOURMOVhaa20zd2hjZklCd3B4MFB4b1Ft?=
 =?utf-8?B?UDZoOHlMRHpEbkZINzQ5ZzdvRG5BZlN2eHQyVmlHN3RzeEdzOTYrNHRVSTlG?=
 =?utf-8?B?UUF6TEVSa1lFaGE2UEtMZEVmNXpJaG9lOXVWNWlyeEliOGhKdzltbWRBMTV2?=
 =?utf-8?B?bmRLcjkvOE84elVHRU1haG9tUlpkaGM3aGt0cmM5clpJNStZNCt6cjZKS0tr?=
 =?utf-8?B?U3FhRm4veGpuV3pOVVNlbkVNUTBLUFQzUWQzRHltc0gzZzRWZHBBYzdiSWNL?=
 =?utf-8?B?d3BycVcwaDVKZno2aHM2WHV4OEJYbW41OVVlTk1EMVVGN2o5VnhkRzB6Tk1p?=
 =?utf-8?B?UmZVeFlKTUNHbklOT0tLYlBmTU1vbVlMZlFET2tCK04raHp6MEtzTDVQYVVN?=
 =?utf-8?B?NEJPeVJRZFZ1U2VJUHNJSUdiRDJEMjZPeWZnYjBzUGpsK0wvcFFSN3JIa1Zi?=
 =?utf-8?B?ZnNWKzBIVjcwWmhrNTJmRGlrRi9NM1FpTGZ5S2t2TS9vYU1HNG5LQ0d6T2ox?=
 =?utf-8?B?UGZZRGFVTTZoZ1F0UzNPRW1FK1dTTGsweE1DVm14Um5hYWVpWlo1N2plVUJV?=
 =?utf-8?B?cU1BbmpKMCtTOUYrK2kwRHdTbFhVR0hHOElIczN1ZVBQdE8yTWJpZVZoN1NU?=
 =?utf-8?B?L1hDRnFpVlRJNWtYQ09mbFRKT21CY29qNmd1azk2cFhlOU1RSG5oZ2VFU1hq?=
 =?utf-8?B?eVRreW9KNjIvaUR4blZYaWtCcnpGV1FpVXZ3bm51RzJLR09XTkpKOHJDVGdV?=
 =?utf-8?B?Zm1FQ2VHWDZudmsreDMraVYvTDMyRE5lRkc0dTEyRkZOUUVDbWg5OUp0NG11?=
 =?utf-8?B?QWg0ZGVmMldzcEc1S1p4b0FlZGM4eW1JWHU3bUJxYUk0YmJqZVMrbWEyMTV6?=
 =?utf-8?B?RVpNeEpscTNVU2ZMMGs2SlFMOWpjZTZ2K0xCTGM4cUVBVlR3aHlRYXVldlF0?=
 =?utf-8?B?bFJ4RzY2bmRZL1p1b0ZlRm5GeFRIa1A4SWdpODN2SE12amU4V1VWRm1XSDNX?=
 =?utf-8?B?TUNUeXBoVFAzajBJRDNEUk5GVVdjZWpESCthRlFCSE5yMUhydEpBQTkrVzV2?=
 =?utf-8?B?SEVkT05hSnB6MGh3SVMwWHNzaGpjZk53SitXZGFBNDlPQWJVQy9jdTRwZnVF?=
 =?utf-8?B?M0U1UXUrWFVSakU0RllveTBRQ255M3g1OVpKQ0VOQmphRkVvZHVaUmt5V2tV?=
 =?utf-8?B?VDlaeFl0QVVYYTdxK2crVE1xWGh0Nmo3K0cxanQrQld3NEpLL1FJbENtUmdL?=
 =?utf-8?B?YmpCL1J0M2l6K0pOSnFrOHRVT2RMSUJDVGZXTjBBd1cvODc1eEdwSDN6T0hU?=
 =?utf-8?B?eGN2aFVJWTFmdjV3cTZqdW9wYjllZzBIbGhXTjVQaTM1cGdFR2gxbFJvV0hp?=
 =?utf-8?B?dzlvQkhDNklqVk9VRmRFb0FVakwxWnZFZnpORzZoemdZdDhJNnNHQUxHdWs0?=
 =?utf-8?B?OWZJME43Ykg2bllCSTBSZzgrRkV2WGk0ZlIwZjBlaTZobjhXZnJwdkZRRCtS?=
 =?utf-8?B?OHllMmtoZkptOVZvTWFmWHg4SWNTN0JoQ0JjMzdNRHc3TlhZejFXRnRQVXlt?=
 =?utf-8?B?UHpjUUVsSmhYWlZDUHozaW9ETWErK2ZQYVJraVdxb2VYblUxVGkzNzJoazl3?=
 =?utf-8?B?dlo4NXhncHVxS2JiOU9TQVNtRjcxQ2pjOFdUWG5vODRjS0ExTFF6MG40Qyt5?=
 =?utf-8?B?WFV3YUR4YktFMi93ZFRkRHJVWXNoYTlWdFdVSUZ0aC85ZHZQRDNtUFJMdnM0?=
 =?utf-8?B?QXpsb0MwKy9wZmM4NDZNZ2tlSmxkdjBRcnNaV3JtVnprbGFMemlVRDVoWVhT?=
 =?utf-8?Q?BwokS+igJyRBe5n8k1oHVV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9ce40a-75ff-476a-3b5d-08da011c0fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 15:55:26.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n735Vbo/IbEa17TfYGz9WzJals8kC55YyndBYSfL0iQumriKu5TqJbgS/AxUUVmnYy/GY2h60rMHtajnTMZGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIHJpZ2h0
IGZvciB0aGUgUFNDIFRoaW5rcGFkcy4gIFRoZXkgaGF2ZSBkZWRpY2F0ZWQNCj4gPiBkaWZmZXJl
bnQgdHVuaW5ncyBmb3IgZWFjaCBvZiB0aGUgc2xpZGVyIHBvc2l0aW9ucyBvbiBBQyB2cyBEQy4N
Cj4gPg0KPiA+IFNvICJiYWxhbmNlZCIgb24gQUMgd2lsbCBub3QgYmUgdGhlIHNhbWUgYXMgImJh
bGFuY2VkIiBvbiBEQy4NCj4gDQo+IEkgc2VlLCBidXQgaXQgaXMgbm90IGxpa2UgYmFsYW5jZWQg
b24gQUMgaXMgY2xvc2VyIHRvIHBlcmZvcm1hbmNlDQo+IG9uIERDIHRoZW4gaXQgaXMgdG8gYmFs
YW5jZWQgb24gREMsIHJpZ2h0PyBJT1cgaW4gdGhlIFVJIHdlIHNob3VsZA0KPiBzdGlsbCBjYWxs
IHRoZW0gYm90aCBiYWxhbmNlZCA/DQoNCkkgZmVlbCB0aGF0J3MgYSBncm9zcyBvdmVyc2ltcGxp
ZmljYXRpb24gdG8gc2F5IGJhbGFuY2VkIG9uIEFDIGlzIGNsb3NlDQp0byBwZXJmb3JtYW5jZSBv
biBEQy4gIFRoZXJlIGFyZSAqc28gbWFueSogb3RoZXIgKG90aGVyd2lzZSBpbnZpc2libGUpDQp0
dW5pbmcga25vYnMgYmVoaW5kIHdoYXQgUFNDIGRvZXMgdGhhdCBMZW5vdm8gaGFzIHdlaWdoZWQg
b3V0IHRoZSBiZW5lZml0cw0Kb2YgdXNpbmcgZm9yIGRpZmZlcmVudCBjaXJjdW1zdGFuY2VzLiAg
DQoNCllvdSBuZXJmIGFsbCB0aGlzIGJ5IGp1c3QgaGF2aW5nIG9uZSB1c2VyIHNwYWNlIGZhY2lu
ZyBrbm9iIGFuZCBsZXQgdXNlcnNwYWNlDQpjaGFuZ2UgdG8gcGVyZm9ybWFuY2UgbW9kZSB3aGVu
IHlvdSBvbiBjaGFyZ2VyLg0KDQpBdCBsZWFzdCB0aGUgd2F5IFdpbmRvd3MgZG9lcyB0aGlzIGlz
IHRoYXQgaXQgb2ZmZXJzICJvbmUiIFVJIHNsaWRlciBidXQgeW91DQpoYXZlIGxhc3Qgc2VsZWN0
ZWQgdmFsdWVzIGJhc2VkIG9uIGlmIHlvdSdyZSBwbHVnZ2VkIGluIG9yIG9uIGJhdHRlcnkuDQoN
CjEpIFNvIG9uIGJhdHRlcnkgSSBtaWdodCBoYXZlIGJhbGFuY2VkIHNlbGVjdGVkIHRvIHN0YXJ0
IG91dC4NCjIpIFRoZW4gSSBwbHVnIGluIGEgY2hhcmdlciwgYW5kIGJhbGFuY2VkIGlzIHN0aWxs
IHNlbGVjdGVkIGJ1dCB0aGlzIGhhcw0KZGlmZmVyZW50IGNoYXJhY3RlcmlzdGljcyBmcm9tIGJh
bGFuY2VkIG9uIGJhdHRlcnkuDQozKSBOb3cgSSBjaGFuZ2UgdG8gcGVyZm9ybWFuY2Ugd2hpbGUg
b24gY2hhcmdlci4NCjQpIFRoZW4gSSB1bnBsdWcgY2hhcmdlciBhbmQgaXQgZ29lcyBiYWNrIHRv
IG15IHNlbGVjdGlvbiBmb3IgYmF0dGVyeTogImJhbGFuY2VkIi4NCg0KPiANCj4gSWYgdGhhdCBp
cyByaWdodCB0aGVuIEkgdGhpbmsgbXkgcG9pbnQgc3RpbGwgc3RhbmRzLCBpZiBQU0MNCj4gaGFz
IDIgc2VwYXJhdGUgc2xvdHMgKG9uZSBBQyBvbmUgREMpIGZvciB0aGUgcGVyZm9ybWFuY2UNCj4g
c2V0dGluZywgdGhlbiB3ZSBjYW4ganVzdCBzZXQgYm90aCB3aGVuIHVzZXJzcGFjZSBzZWxlY3Rz
IGENCj4gcGVyZm9ybWFuY2UgbGV2ZWwgYW5kIGhhdmUgdGhlIGFjdHVhbCBlLmcuIGJhbGFuY2Vk
IC0+IHBlcmZvcm1hbmNlDQo+IGNoYW5nZSBiZSBkb25lIGJ5IHVzZXJzcGFjZSB3aGVuIHVzZXJz
cGFjZSBzZWxlY3QgdGhlIG1hY2hpbmUNCj4gaGFzIGJlZW4gY29ubmVjdGVkIHRvIGEgY2hhcmdl
ci4NCg0KQnV0IHlvdSAqZG9uJ3Qgd2FudCB0byogYWN0dWFsbHkgc2VsZWN0IHBlcmZvcm1hbmNl
IHdoZW4geW91IHN3aXRjaCB0byBhDQpjaGFyZ2VyLiAgSWYgeW91IGhhdmUgMyB2YWx1ZSBzbG90
cyBmb3IgQUMgYW5kIDMgdmFsdWUgc2xvdHMgZm9yIERDIHlvdQ0Kc2hvdWxkIG9ubHkgYmUgc3dh
cHBpbmcgYmV0d2VlbiB3aGF0IGlzIGluIHRob3NlIDMgdmFsdWVzIHNsb3RzLg0KDQo+IA0KPiBS
ZWdhcmRzLA0KPiANCj4gSGFucw0KPiANCj4gDQo=
