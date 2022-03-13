Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F494D78D4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 00:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiCMXq0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 13 Mar 2022 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiCMXqZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Mar 2022 19:46:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292F40904
        for <linux-acpi@vger.kernel.org>; Sun, 13 Mar 2022 16:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxrAP/ZP/fQ7IwqW4EGduA/XUC3Cz+jjoyaQnS5CjROuGCKgahLL6LskJnu0wbxvkMWCU6okY2fRPvHT6SSzt/FP+Lthgvu87oDrk5hXC8Sg19iDJARbH6fvowPNsmKZ4WIi2N6xtwhXXrmdeIvIaM5M5tOYZrcHHxEhwtpFXKJWI6JZthDdBEcgR3HZ53qFIJJQ4JAXKKnofV4BtJbsZwx0lt89FE3KNZUyeWEdb9a7QeFog968Vy+vExGl1caFBSmpbmv/tIlvbufqm8iWl8K0c8d9wn9HbV1NR//6uk/3pzc3JkdOon1XrDw/pReS8sP65FKD81xtHkJ6DL+GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvVJe+cLoANAJCK7YzZ65BD5NCU8xITtKxD6PteTRFk=;
 b=FcT7JQQPba38wMB1p7RAk7h35k5Ld3g3nhsEhRemAht1oLOe9uonWOLYskDB7fjhyPUexqLgKbmoRQ93kVgVDNcx8vC5+P7ua/jpP00MVdykNi0/CxxLETCC4uvH8ermnXbmLdXxx+GjVM/23tcv3rBVmtbumcRWZzYejWallFFpDEo0v70tMILmKFr+A4v2R57bXc4IG7k+aZs/yfVpDaqVGLghOcabAvnmxVKALrPGU17VzH/2yuy9InvuCGmsoso3anP260FiVqHUsEZ16sURET/yK5iotbC2/E+f0n2D4xhM3uWZ2bVddXF1ml+A/KJpZoavi6G2tut6JPm0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvVJe+cLoANAJCK7YzZ65BD5NCU8xITtKxD6PteTRFk=;
 b=Wj7VwsuhBRT4kSJHvAyjR+HemExvZgPs8STdBwCQcanXdqUq/UvtZm3hHKdGDp36yPkt/BUplV55P59QLk29yV/LyVOAno284zRsP3rucbqj2J/9p+4rKVO5CwGYGMI0qMV0t7zRSl5LuuxITJCEWjS5vY4lWng+EeeZiBuGIfw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN7PR12MB2787.namprd12.prod.outlook.com (2603:10b6:408:2b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sun, 13 Mar
 2022 23:45:12 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.028; Sun, 13 Mar 2022
 23:45:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Topic: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Index: AQHYNMYH7nSloADYlk2nIR9Xb+AhIay6UkUAgAOsBiA=
Date:   Sun, 13 Mar 2022 23:45:10 +0000
Message-ID: <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
In-Reply-To: <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-13T23:42:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4133ea18-4551-4b9d-8b26-1517135b6a85;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-13T23:45:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6fbdbf70-0765-4239-bf69-c86cb012ac98
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d413c8ab-c137-4322-6d9f-08da054b8317
x-ms-traffictypediagnostic: BN7PR12MB2787:EE_
x-microsoft-antispam-prvs: <BN7PR12MB27877FF37A85CB3688DBD5ACE20E9@BN7PR12MB2787.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWR7bDhr+S4g+wsGMowTcqMTB+W+p2JRofxkEShXgVkTMVi8PKUjE08bSlisF23adfBONGobLwmadWIxk4Qw68OQZ7LNrDWHalrDmdGFvrvpp0yIKjl/2h+ZTMqReXOnjF1ngr/Zq1xUTrXkVSy6ovbMfjqE3rDUaB2Hcx9Mwml7GCd0cGOXOJRaymbOE3eBNXjuZ+L98L1/rbdGch4AUfwuI34Vq2wEpL4BImKHqVDsyZRcyrsJCQo8Q0Nn6dpJBj7G/9wfE3tq39m4/pDtUREqsCsCSzmAFjHy02eqo27UwvDEaKtc6AMTZla5ydrjwYVaXySgRvdUJ/tNg1z6h+2vZoglsliuLyOYJ+oEsM1ycxSrFJhC3UwMQS3+oxVZH//sq8XOGFatpgxM62Wggo4HT9QAcFeKoWs2m0Fpp0wMirPTFyRvzoX4HdiB+iP1G1K4JLX3DEi8egGBbil0eE/cW1yin2RWW8Qvf+ovoHE909RbPiLERDS8HrtZ0MWUyenKuboVuNIBeHx7zsE5Z75x22JFG51nmduOStZDwDl+fooDKmTRNl+44qXfDe/He8ZPaJkWd+2zpeO2R4VE5V1v+/PjPcZ4GqBTpGQ3Av4VV4CrSMVfmFMjjQlgbKZWU7fg9CdYoqzxuX5+FZy/hVYiYlWkx9VtmduOBhoimseTtNB27Gt47RyWcHisit9Gqbj+kBd8oKeaOi4JAF6HlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(6506007)(316002)(5660300002)(8936002)(186003)(26005)(508600001)(52536014)(4326008)(33656002)(2906002)(66476007)(66446008)(64756008)(8676002)(66556008)(66946007)(76116006)(122000001)(38100700002)(83380400001)(7696005)(54906003)(6916009)(9686003)(38070700005)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNMVEZ2VThRUjh4UExrOUhiejNrRkg3OUNPR3JnR2lFSVZCeU02dXBOdTNt?=
 =?utf-8?B?UFUrZlRTWTNacVlJMGpFWmoweWV2aWtuNmh6WXlHSUVXZG9kaUg2S2gveGRL?=
 =?utf-8?B?Z1ZaNnY1VkxzbEN2SzV2NjJuaVduRGwzLysraXBYRDVTSk13VjZJRVlITWRt?=
 =?utf-8?B?RmFnelBJZGF3YTZvQ3ZTRHZpN1ZXS2llL2RXYUxXT05qZGNoM3hOWWJVblpj?=
 =?utf-8?B?ako5TlZubjNab2ZhUm5OeFVIcGZ5eDVsL0dabmNhWjN2NHlOaXBXWlpCam0w?=
 =?utf-8?B?eHpwbTFqL2xPRnFWZzd3KzRZNTdJNUJhM1pKN3JmTlM4Zjc0SEVVd1JVTVpT?=
 =?utf-8?B?SG82S0liZnlmN0E0SW9ub3dWa3JuQldoSC8yeUZqUjJRSDdzbXlLL1VGQnpU?=
 =?utf-8?B?blY3dGZWeGZmMldOYlFkSEUzQXAxVUluanM5MXNxTFdnQlJMUGJJOFhDT0Ri?=
 =?utf-8?B?QTg0QkVhQmtXLzRhOWIwRU1SWi96c2xuenkzR3ZoL1Nlb0NLb3BwSTk2d3Fj?=
 =?utf-8?B?YWF0eWhjY05FN09wbE0vb3kyaGUvNmV1eFc1d1pKT0VFNEM2cHpvdFRzalow?=
 =?utf-8?B?b3FBM3N4M3VOU1lHYi9uQUx6NFJSU0p4QitwekhWZzN5SStjWjh3bWdhMHYr?=
 =?utf-8?B?MGVSTkdtNzFYejRHOHFLaTQ2YmFaYmVISHJUVkV2MTZJWnVwKzAwQUcwQ0xH?=
 =?utf-8?B?RC9LOUFzc01US0ZqYTdwK3UrWlNqYlhXMkRZN1FQK2I2aHhDVVJ6OVpUcHY1?=
 =?utf-8?B?NUhpSkJrQnZwemt5dWhhZHVqQ202T2ZIQTdsT1FkLzF4c1ByTTFPbHJvYTVJ?=
 =?utf-8?B?TmRScUFqMDh5TFJWT1NOSEdlQ0lNYnRQaFB0cThlem92UjByLzlzNk1FRlpt?=
 =?utf-8?B?U0ZQMHUwODlzcDNCN0tjNlB3eVo4TDlLVnNMcjM0NnZBOVV2cVNaQ2xzSlc0?=
 =?utf-8?B?ZGNKZ2VndGgxSFRHd0wwUmgrUHh1RklBMlh5LzFjQkZCWXdHWXVQcEU4M0xJ?=
 =?utf-8?B?UGFpSHg1Ykg3UVVGZUh5empTdnBnN29KclA2OHNxZm1KZExyd0c5NXNVUW1y?=
 =?utf-8?B?dmR0TFJVUThkUW05WURlY0ZPbGFyb3hWZlY2ditxaEdOOE5kTjJTaEh4NnQ5?=
 =?utf-8?B?b2RGUmg5ejEweFFGVEV0RjZvc1NNeHA4TDJYOXU1VlRwZFNtNTFIRWxHOGxp?=
 =?utf-8?B?ODJ3OEdRZ2ZhWS9oRjdacS82ME5zaXErcENKazdscjQ1MGtmMDFHNWgwYVQz?=
 =?utf-8?B?VEVFTDY3QTlZbC9lS1FCWTZlbnJDY2U2UmFzQVhhTDVidWFJUG8vdVlhS0w3?=
 =?utf-8?B?cUFra2VFYjB1RTJqRVUxZG5HTE9xVEsvUVF3Ylk5UnQ4aUd4L3BISllocW1C?=
 =?utf-8?B?QzVRZ094VndwaEpMVFBzMUJFclgvOGYyVlNUdmdpa2hrbHZQbHFSNm44Q0h5?=
 =?utf-8?B?Vlh2a1Y0SDVTSXFUamhRTnZ2WUpLYVB3dXhQaHk1Wld4ZGlmS2RKMDhnZmhI?=
 =?utf-8?B?VjFJOXhXNHNPN0Z4a0JzdlJkdlZPak1NZXhzWFVLakcrRWQxVlBFbnUvV2Jr?=
 =?utf-8?B?L3g3NW1ScTE2cnQ0dnhMTnh0MGh2UW0wR3JRQU51S3J4NVV4Mzk4SVRWVUt2?=
 =?utf-8?B?RHk2aXNHQzNKUXExZnIySlFEZ21LMEd3enRxQTVldVJ2czdBWUFKNEtSS2o2?=
 =?utf-8?B?UzZTNmhWNTcxY0JoWHFSREwySFoybExaaEVKazZrYkZVc2oxOTZSZ1lGYWFj?=
 =?utf-8?B?QVpCbDVHbmE4Qkp1Mm5Db1dzK2FGNWtlbGNrVDhReFpnK2J4M3d2dTl5a3Jn?=
 =?utf-8?B?RHVDM3JaOVZzbWRJVk8yOHVPaEFLZzNsMkpGR2xXYnFsa1c4MVJ5TkQ0aHp1?=
 =?utf-8?B?T1FWeU16VDd1RXlxdDhmOEgrTVM1S1VTaE9Da2tGTjUvd0EwWjVsSUN3KzZw?=
 =?utf-8?Q?4Jkk8EBBupk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d413c8ab-c137-4322-6d9f-08da054b8317
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 23:45:10.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdVUEAFmLwgHrWUejz+vZ+s1gkJbpxmZXlxBMnRUvzE1iV6Nt3ukPECI5HM9ltN3StdWcIStSn6QyhJA35Lcjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiBJIHdvdWxkIGRvDQo+IA0KPiBpZiAoY2FwYnVmW09TQ19TVVBQT1JUX0RX
T1JEXSA9PSBjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSkNCj4gICAgICAgICBjYXBidWZb
T1NDX1FVRVJZX0RXT1JEXSA9IDA7DQo+IGVsc2UNCj4gICAgICAgICBjYXBidWZbT1NDX1NVUFBP
UlRfRFdPUkRdICY9IGNhcGJ1Zl9yZXRbT1NDX1NVUFBPUlRfRFdPUkRdOw0KPiANCj4gc28gdGhh
dCB0aGUgbG9vcCB0ZXJtaW5hdGVzIGV2ZW4gaWYgdGhlIGZpcm13YXJlIGRvZXMgc3RyYW5nZSB0
aGluZ3MNCj4gYW5kIHRoZW4gaXQgd291bGQgb25seSBiZSBuZWNlc3NhcnkgdG8gY2hlY2sgY2Fw
YnVmW09TQ19RVUVSWV9EV09SRF0NCj4gaW4gdGhlIGxvb3AgdGVybWluYXRpb24gY29uZGl0aW9u
Lg0KPiANCj4gV291bGQgdGhhdCB3b3JrPw0KPiANCg0KSSB0aGluayBpdCB3aWxsLiAgSSdsbCB0
cnkgaXQgYW5kIHNlbmQgdXAgYSB2NyBpZiBzby4NCg0KPiA+ICsgICAgICAgICAgICAgICBrZnJl
ZShjb250ZXh0LnJldC5wb2ludGVyKTsNCj4gPiArICAgICAgIH0gd2hpbGUgKGNhcGJ1ZltPU0Nf
UVVFUllfRFdPUkRdICYmDQo+IGNhcGJ1ZltPU0NfU1VQUE9SVF9EV09SRF0pOw0KPiA+DQo+ID4g
LSAgICAgICAvKiBOb3cgcnVuIF9PU0MgYWdhaW4gd2l0aCBxdWVyeSBmbGFnIGNsZWFyICovDQo+
ID4gLSAgICAgICBjYXBidWZbT1NDX1FVRVJZX0RXT1JEXSA9IDA7DQo+ID4gKyAgICAgICAvKg0K
PiA+ICsgICAgICAgICogQXZvaWQgcHJvYmxlbXMgd2l0aCBCSU9TIGR5bmFtaWNhbGx5IGxvYWRp
bmcgdGFibGVzIGJ5IGluZGljYXRpbmcNCj4gPiArICAgICAgICAqIHN1cHBvcnQgZm9yIENQUEMg
ZXZlbiBpZiBpdCB3YXMgbWFza2VkLg0KPiANCj4gV2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5
ICJCSU9TIGR5bmFtaWNhbGx5IGxvYWRpbmcgdGFibGVzIj8NCg0KQXMgbWVudGlvbmVkIGluIGNv
bW1pdCAxNTlkOGMyNzRmZDk6DQoNCiAgICBPbiBjZXJ0YWluIHN5c3RlbXMgdGhlIEJJT1MgbG9h
ZHMgU1NEVCB0YWJsZXMgZHluYW1pY2FsbHkgYmFzZWQgb24gdGhlDQogICAgY2FwYWJpbGl0aWVz
IHRoZSBPUyBjbGFpbXMgdG8gc3VwcG9ydC4gSG93ZXZlciwgb24gdGhlc2Ugc3lzdGVtcyB0aGUN
CiAgICBfT1NDIGFjdHVhbGx5IGNsZWFycyBzb21lIG9mIHRoZSBiaXRzICh1bmRlciBjZXJ0YWlu
IGNvbmRpdGlvbnMpIHNvIHdoYXQNCiAgICBoYXBwZW5zIGlzIHRoYXQgbm93IHdoZW4gd2UgY2Fs
bCB0aGUgX09TQyB0d2ljZSB0aGUgc2Vjb25kIHRpbWUgd2UgcGFzcw0KICAgIHRoZSBjbGVhcmVk
IHZhbHVlcyBhbmQgdGhhdCByZXN1bHRzIGVycm9ycyBsaWtlIGJlbG93IHRvIGFwcGVhciBvbiB0
aGUNCiAgICBzeXN0ZW0gbG9nOg0KDQogICAgICBBQ1BJIEJJT1MgRXJyb3IgKGJ1Zyk6IENvdWxk
IG5vdCByZXNvbHZlIHN5bWJvbCBbXF9QUi5QUjAwLl9DUENdLCBBRV9OT1RfRk9VTkQgKDIwMjEw
MTA1L3BzYXJncy0zMzApDQogICAgICBBQ1BJIEVycm9yOiBBYm9ydGluZyBtZXRob2QgXF9QUi5Q
UjAxLl9DUEMgZHVlIHRvIHByZXZpb3VzIGVycm9yIChBRV9OT1RfRk9VTkQpICgyMDIxMDEwNS9w
c3BhcnNlLTUyOSkNCg0KVGhpcyBibG9jayAgaXMgdG8gYXZvaWQgcmVncmVzc2luZyB0aGF0IGFn
YWluIGJ5IGZvcmNpbmcgaXQgb24gdGhlc2Ugc3lzdGVtcy4NCg0KPiANCj4gPiArICAgICAgICAq
Lw0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+ICsgICAgICAgaWYgKGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9IV1ApKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGNhcGJ1ZltPU0NfU1VQUE9S
VF9EV09SRF0gfD0gT1NDX1NCX0NQQ19TVVBQT1JUOw0KPiA+ICsgICAgICAgICAgICAgICBjYXBi
dWZbT1NDX1NVUFBPUlRfRFdPUkRdIHw9IE9TQ19TQl9DUENWMl9TVVBQT1JUOw0KPiA+ICsgICAg
ICAgfQ0KPiA+ICsjZW5kaWYNCj4gPg0KPiA+ICsgICAgICAgLyogTm93IHJ1biBfT1NDIGFnYWlu
IHdpdGggcXVlcnkgZmxhZyBjbGVhciAqLw0KPiA+ICAgICAgICAgaWYgKEFDUElfRkFJTFVSRShh
Y3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm47DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
