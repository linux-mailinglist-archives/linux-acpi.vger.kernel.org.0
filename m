Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4D4DB51A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiCPPoh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiCPPof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:44:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529F1D336;
        Wed, 16 Mar 2022 08:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQKYradbm8KaT3T/G2yYoV9J30++HcTKcdV4IvJ0r5+WOgWmPmxFjIDReX4Ca+YM8PV76B7oYZ93DPQ+SI6xz2bcOtvGkUse6M0sUgE9UsTgyVihlyobdzK74e3BMmf5en7iQB7SzYG+uMDj+ABLxg9ISAhRfz/PfcPXce+QDwif8n3SNwPkfbC8vpxxP6/kng/ZomZB6fgZRWy8ojQ94kZk8FeTLIpTSqLNEpvZGVxqdFarpUenTeU4A3OvYmCCyCCYJTsrDiQyEHHujP/hkxuRoos87lamBVJgs3BadlFm01GuUW57DEarr324DKPPsjrOehNWusauhl09Dvk5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/OneDPMupAhTeWUnTDS1jkSujLDIRfuP/rf2CTWkAc=;
 b=Xah9whAO1mVRfDGYCUZ6ZcGipBuMuKqnA7USrI12EjsVc4cjw5rkYNO947tTXFF8tVFmdk4H5tOfpMYRprGr+ckkDprZGHaqEVtyVRZNeYMwfQV3LzvtMxY1S/xZdGIRtlociVW9TPrSW5QpAYD0myOePpSaSw3KDqAMaX6qLnwiqedPXMbbPtlboQS01bo4MvGHmtIKqs1qINJwf3o4DD6HA+mFu0ygeSrRcychAPTW3DcSQ+o8Z4liiYfJveyV1LqxTo/0iLnE2E/OorLLG0hP1wRRfpdTd37cJrBHgVcdCrhsJnYlvev0aWDoUAx08gATH1wEerBPUrdyzi0Cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/OneDPMupAhTeWUnTDS1jkSujLDIRfuP/rf2CTWkAc=;
 b=SecTlm2SGWij5nuIx0O+gKq2hwBl/Nyj1esvGROUd2GcI3o5Tzjdzi+lDlZHlNgFvZJsglYldavBgR8xYtOKmRpJxEcUSOvJxCVqRBj4AEc5ZeuFbVCkb7+bKT90Ws2kA+VpPKDIA3Li0lmRZE/XuEIcUhutGU4ddbnRSzfVXFk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 15:43:19 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 15:43:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Subject: RE: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Topic: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Index: AQHYN2DqFPMQrXTwwk2R9AIKdGhSYay+lpgAgABJyACAAAIfAIADPJGAgAAI9ACAAAA/QA==
Date:   Wed, 16 Mar 2022 15:43:18 +0000
Message-ID: <BL1PR12MB51571612A9594F5B759EDD81E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
 <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com>
 <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
 <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T15:41:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b49ed75d-5b48-4c62-8d1f-660de1c90f21;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T15:43:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8c07c6af-7292-4f3c-a3bf-9f7ee37efb32
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b30390e-069a-4682-368c-08da0763b1bc
x-ms-traffictypediagnostic: SN1PR12MB2558:EE_
x-microsoft-antispam-prvs: <SN1PR12MB2558BF741C6A0E3D894F12A9E2119@SN1PR12MB2558.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOGkoWahJSBA+8exI7YZfm1x/o/aO+cctkf3hmcuInt2fJtLpkxf3+ToninJ1+2ba+atkbeuv63xOiylaa2iyIguG7GrvTvL6QxmCuoDIZEXKdvw55yP/6bCHeNuILeuJ58oz86Zcf6f3c+ew8PPk0lJ9Es6GMp6hddeKCLQ3x1bqLnOWRbE3/5uDSMLhpdZsV0P1Dus0wJEyg3q3DCR7iFQ0/d8rPoONqraIOGm+/lQmamR6SqZhNgo/EsLDtgTdEkqid2gofIp1jUrYJZvFIC0s3QmpUvkqNE0qAg8IaskCXntjVFDgza3w4rl3CfTebvvB4c+NkfMEKYbD0ZZ56CBtAlg26dNk24CrJPbfKFh1A3UqnnbLtj0EhP8caQX/K/k/oIGdqJv2O7xuOMv86OO4/UN0VGdWn685PJiO6sgw3NO2xmgUTPJnFUrP8G6vH0Flh9FYt5q+c3Ojl5itpqFU1locIBo55d/C7gHaNN/6JUNfqsD+Ntp4hn+tRrPmsyqXHf/cHAA6PMuURvmN60WQssAdXMXxB78MdeNoIvsR+jzlGoGTZ2rUtr+sWEk0/tQ53v5HrZa1iWhKNf5LLbPDAOyOSBqGY4FYfguzTo5/gxPbaQZs6Er2ej4JFCZbqMtFSdhEICVJuZC3YPX75cJ6BpV5JRysZmyj9GbYbJOEpxXStJ28gdSpWrLEaKX56XSMWsj8CSccgbTPwjakw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(9686003)(38070700005)(55016003)(76116006)(71200400001)(86362001)(54906003)(316002)(66946007)(110136005)(33656002)(53546011)(6506007)(7696005)(4326008)(66556008)(64756008)(66446008)(8676002)(66476007)(508600001)(122000001)(2906002)(8936002)(52536014)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW8vSWszM0JualZlS3pXeDFXYytXNmM4ckUwMlhCeExiK2dsN3R5ajhLQlV6?=
 =?utf-8?B?M09WbW5QZ0Nub1JYTmxUangyZEo1cG9JMDJZS1V1a2RnNHMrTStLK2tEU0Nq?=
 =?utf-8?B?RVB3UW00cisvd0JsRFZiVGVCY2RTWkVUN0wrS3dPdkxMN1h4bGgxZzdSNHpX?=
 =?utf-8?B?UisxQXg2ZFVkZmFzcXdTekNlVm5MSHVqaHZaeThMRmc3VnppYmpZSU9mZjF3?=
 =?utf-8?B?Ti8xb3BCT3NVbVcyQWhlbk02M0dJSnJjdEhRWmpUMkVuWkdiY3BUOFBiK3V2?=
 =?utf-8?B?NnV5VG0rYXJhSWVUZzI1ckJJZUREb1RBM0c4VlZPc3o0S0QwYWdDZk1aQWU4?=
 =?utf-8?B?dmdGZUFFakI4TGJzV05kbDdPRTVUVUpPMVhRVlZPb0xkQmk0MTVQTERKbm04?=
 =?utf-8?B?Z0lJZkRPRmhTOWM3MVhPVVZoZHordG4zbEpKR1VtN21rNytxSnZPUHJRRmN2?=
 =?utf-8?B?YkROYi8rWWZwNG40djQrQUxDQ3dLNzM3UW9BelJQNjZyamwxYU42QVJzaHRh?=
 =?utf-8?B?RW5QZllxODMyU0hhK3VsQkdDODdWZnFOaGNsRE5HVEFWbTRoWE5xWWJ4V3NM?=
 =?utf-8?B?dHRGQjBKUVVpZzZCL0VhM0QrWndZeVJOQ1pkSlZkRGxSOERjUW1qRHB4c1BT?=
 =?utf-8?B?azRqM3Z4TmlEcXl5Y0xua0tVWGFmSmtYY2xzdkR0VUdhZDlhS0hKbE82Sksw?=
 =?utf-8?B?dmJFM29KaWtva2VFMjFuM1FIckxTRCtiaTQvWGVvUk5sSHc0cTdpbDV2S3k3?=
 =?utf-8?B?ZzJhTElzaWJjZW52bXV5dTdZS0UxeDlYTHFaRGo5elprenV0b2RTZitQTzla?=
 =?utf-8?B?ZGhucmdmTkJQc3dBUkkySE9XNmNtdTFVOUc2Sld6U0RCWmlaeGRJMi9Fc21t?=
 =?utf-8?B?Vy80Z0Y1QTg0bnVISnA5VWN2MFU5RlFsL21GVEhqWHJvSlpiNW9WNENFbjlj?=
 =?utf-8?B?UjBRU2ErZzh5cGVJNHIyREZub3lCVkFYU2o1bmg0dk9iaXo5VXRxZjJRS25z?=
 =?utf-8?B?dWs1U3ZKeDZQSnIxZDNuR2krbVhIbitORjNIaUttSjc2ak80cVBZekJEeDlN?=
 =?utf-8?B?Y3FkdzFjb0RzVnBhVitON20xZEFQS2NXSE9zTWJZTmdZVjlSTHZIMk9mbFVl?=
 =?utf-8?B?b0xxNC9mRm16QlBxaTVEa3dBY0VYWEcwVTl2MjJSSG5STTFOK0U0QUgzSEMr?=
 =?utf-8?B?QTRWaFNacmZWQ3EzcXFSUG9IbGRJMzlZMVNDWERFa1lRQUVkeEZnYkRubW5B?=
 =?utf-8?B?ZTJXalRrYW40YUZ2eklBRUI1VUUwc1Zodk1oV0VrV2lkYzNPWGtMQUVIcnpl?=
 =?utf-8?B?ZlpNV1VoMWhWRG0yaFAyeW1uMEgvdm1ic3dBajAydnVtSFVYU3NZZ3BKdU56?=
 =?utf-8?B?OHVNeVp2RzFxVnF1eFYycnNUOEhUb1VuU0pxeU1oc0tJellOL3VkUkl2WFhL?=
 =?utf-8?B?VVhKK0lROFJyWVVUYlpFZVU3Q3FPaHV1Q3dRZ1NaNWxaZzlJczRIZ1BzS1F3?=
 =?utf-8?B?QnF3T3lSay9NeU9TVmNuSEpsN1BtQnVYTjYyaWFHR1pLSy9PV2xKRlZUU2lh?=
 =?utf-8?B?c29uVldNc1AyRFl2MlNyNVNUY3RGbEMxKzBtT1ZKRHRQNWJhb0RKRDJPbG5R?=
 =?utf-8?B?SVhlaGpTeWVISFFmUVJoem5pcmhndFJEaEE1a2xHaGlmaDZFMzNPanp5RHJw?=
 =?utf-8?B?MmU2K1R3SStnQndSTzVxc3M3ckIwZFFCbVd1b3hiOTZnQVZkSXpyQWZKOXZH?=
 =?utf-8?B?VVBvS1NOT2VZVUlIaGd3ZG1tMGRMWUNHcis4OGNLV2VwRldBMHlPZFo1WDND?=
 =?utf-8?B?MUNqOXlvemxjRWFZVmNMN1VRZjhwdDFNWHhhY0s5OU1lRUxzMEJmYndwL05E?=
 =?utf-8?B?bmxMVFJVMnpXMTlZY3gzQmNsV3NRUXNUajh3SUdTemJjUWswSW0xZ1RLT1lm?=
 =?utf-8?B?SThtaEFZd0IrcVNWanhvWHdzL1JVUHQxRGtjZXJxWmdnRWFPZzhrZFZucm1N?=
 =?utf-8?B?TlpDWnlrRU5ORHhGQTNKbjFqZ2NrRExOelZ3TFh5L2xud0FSaW01UWdyb2Rm?=
 =?utf-8?Q?YXyP9C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b30390e-069a-4682-368c-08da0763b1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 15:43:19.0155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICUJbwodXo42KrDzEBG13uAO6hcvfOJM4ypUJqbmV8rb6PbEXV7g5A+T2dJ7FRTw6lcK/tzGHspjr5B1zoVuXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDE2LCAyMDIyIDEwOjM1DQo+IFRvOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0K
PiBDYzogTWFyayBHcm9zcyA8bWdyb3NzQGxpbnV4LmludGVsLmNvbT47IFJhZmFlbCBKIC4gV3lz
b2NraQ0KPiA8cmp3QHJqd3lzb2NraS5uZXQ+OyBvcGVuIGxpc3Q6WDg2IFBMQVRGT1JNIERSSVZF
UlMgPHBsYXRmb3JtLWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnOyBTLWssIFNoeWFtLXN1bmRhcg0KPiA8U2h5YW0tc3VuZGFyLlMta0Bh
bWQuY29tPjsgR29zd2FtaSwgU2Fua2V0DQo+IDxTYW5rZXQuR29zd2FtaUBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gQUNQSSAvIHg4NjogQWRkIHN1cHBvcnQgZm9yIExQ
UzAgY2FsbGJhY2sgaGFuZGxlcg0KPiANCj4gT24gV2VkLCBNYXIgMTYsIDIwMjIgYXQgNDowMiBQ
TSBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gT24gTW9uLCBNYXIgMTQsIDIwMjIgYXQgMjozNyBQTSBIYW5zIGRlIEdvZWRlDQo+IDxoZGVn
b2VkZUByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiBP
biAzLzE0LzIyIDE0OjMyLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4gPiA+IFtQdWJs
aWNdDQo+ID4gPiA+DQo+ID4gPiA+Pj4gK2ludCBhY3BpX3JlZ2lzdGVyX2xwczBfY2FsbGJhY2tz
KHN0cnVjdCBscHMwX2NhbGxiYWNrX2hhbmRsZXIgKmFyZykNCj4gPiA+ID4+PiArew0KPiA+ID4g
Pj4+ICsgICBzdHJ1Y3QgbHBzMF9jYWxsYmFja19oYW5kbGVyICpoYW5kbGVyOw0KPiA+ID4gPj4+
ICsNCj4gPiA+ID4+PiArICAgaWYgKCFscHMwX2RldmljZV9oYW5kbGUgfHwgc2xlZXBfbm9fbHBz
MCkNCj4gPiA+ID4+PiArICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4+PiArDQo+
ID4gPiA+Pj4gKyAgIGhhbmRsZXIgPSBrbWFsbG9jKHNpemVvZigqaGFuZGxlciksIEdGUF9LRVJO
RUwpOw0KPiA+ID4gPj4+ICsgICBpZiAoIWhhbmRsZXIpDQo+ID4gPiA+Pj4gKyAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+Pj4gKyAgIGhhbmRsZXItPnByZXBhcmVfbGF0ZV9jYWxs
YmFjayA9IGFyZy0+cHJlcGFyZV9sYXRlX2NhbGxiYWNrOw0KPiA+ID4gPj4+ICsgICBoYW5kbGVy
LT5yZXN0b3JlX2Vhcmx5X2NhbGxiYWNrID0gYXJnLT5yZXN0b3JlX2Vhcmx5X2NhbGxiYWNrOw0K
PiA+ID4gPj4+ICsgICBoYW5kbGVyLT5jb250ZXh0ID0gYXJnLT5jb250ZXh0Ow0KPiA+ID4gPj4+
ICsNCj4gPiA+ID4+PiArICAgbXV0ZXhfbG9jaygmbHBzMF9jYWxsYmFja19oYW5kbGVyX211dGV4
KTsNCj4gPiA+ID4+PiArICAgbGlzdF9hZGQoJmhhbmRsZXItPmxpc3Rfbm9kZSwgJmxwczBfY2Fs
bGJhY2tfaGFuZGxlcl9oZWFkKTsNCj4gPiA+ID4+PiArICAgbXV0ZXhfdW5sb2NrKCZscHMwX2Nh
bGxiYWNrX2hhbmRsZXJfbXV0ZXgpOw0KPiA+ID4gPj4+ICsNCj4gPiA+ID4+PiArICAgcmV0dXJu
IDA7DQo+ID4gPiA+Pj4gK30NCj4gPiA+ID4+PiArRVhQT1JUX1NZTUJPTF9HUEwoYWNwaV9yZWdp
c3Rlcl9scHMwX2NhbGxiYWNrcyk7DQo+ID4gPiA+Pg0KPiA+ID4gPj4gVHlwaWNhbGx5IHdpdGgg
Y2FsbHMgbGlrZSB0aGVzZSB3ZSBzaW1wbHkgbGV0IHRoZSBjYWxsZXIgb3duIHRoZSBzdHJ1Y3QN
Cj4gPiA+ID4+IGxwczBfY2FsbGJhY2tfaGFuZGxlcg0KPiA+ID4gPj4gYW5kIG9ubHkgbWFrZSB0
aGUgbGlzdF9hZGQoKSBjYWxsIGhlcmUuIFR5cGljYWxseSB0aGUgc3RydWN0DQo+ID4gPiA+PiBs
cHMwX2NhbGxiYWNrX2hhbmRsZXIgd2lsbA0KPiA+ID4gPj4gYmUgZW1iZWRkZWQgaW4gdGhlIGRy
aXZlcl9kYXRhIG9mIHRoZSBkcml2ZXIgcmVnaXN0ZXJpbmcgdGhlIGhhbmRsZXINCj4gYW5kIGl0
DQo+ID4gPiA+PiB3aWxsDQo+ID4gPiA+PiBjYWxsIHRoZSB1bnJlZ2lzdGVyIGZ1bmN0aW9uIGJl
Zm9yZSBmcmVlLWluZyBpdHMgZHJpdmVyX2RhdGEuDQo+ID4gPiA+Pg0KPiA+ID4gPg0KPiA+ID4g
PiBXaGVuIEkgcHV0IHRoaXMgdG9nZXRoZXIgSSB3YXMgbW9kZWxpbmcgaXQgb2ZmIG9mIGBzdHJ1
Y3QNCj4gYWNwaV93YWtldXBfaGFuZGxlcmANCj4gPg0KPiA+IFRoZSBzdHJ1Y3R1cmUgYWRkZWQg
YnkgdGhpcyBwYXRjaCBpcyBtb3JlIGxpa2Ugc3RydWN0IGRldl9wbV9vcHMsIHRob3VnaC4NCj4g
Pg0KPiA+ID4gPiB3aGljaCB0aGUgaGFuZGxpbmcgYW5kIHRoZSB1c2UgaW4gdGhlIGtlcm5lbCBk
b2Vzbid0IHNlZW0gdG8gZm9sbG93IHRoZQ0KPiBkZXNpZ24gcGF0dGVybg0KPiA+ID4gPiB5b3Ug
ZGVzY3JpYmUuDQo+ID4gPg0KPiA+ID4gQWgsIGZhaXIgZW5vdWdoLiBXaGF0ZXZlciBSYWZhZWwg
cHJlZmVycyB3b3JrcyBmb3IgbWUuDQo+ID4NCj4gPiBNeSBwcmVmZXJlbmNlIGF0IHRoaXMgcG9p
bnQgd291bGQgYmUgdG8gdXNlIGEgbm90aWZpZXIgY2hhaW4sIHVubGVzcw0KPiA+IHRoYXQncyBu
b3Qgc3VmZmljaWVudCBmb3Igc29tZSByZWFzb24sIGJlY2F1c2UgaXQgYXBwZWFycyB0byBtYXRj
aCB0aGUNCj4gPiBub3RpZmllciB1c2FnZSBtb2RlbC4NCj4gDQo+IFdlbGwsIEknbSBhY3R1YWxs
eSBub3Qgc3VyZSBhYm91dCB0aGF0Lg0KPiANCj4gPiA+IEkgcG9pbnRlZCB0aGlzIG91dCwgYmVj
YXVzZSBtYWtpbmcgdGhpcyBjaGFuZ2Ugd291bGQgYWxzbyBtYWtlIDQvNSBhIGJpdA0KPiA+ID4g
Y2xlYW5lci4gWW91IGFyZSByZWNyZWF0aW5nIHRoZSBzYW1lIHN0cnVjdCBscHMwX2NhbGxiYWNr
X2hhbmRsZXIgb24NCj4gPiA+IHN0YWNrIHR3aWNlIHRoZXJlLCB3aGljaCBsb29rZWQgd2VpcmQg
dG8gbWUuDQo+ID4gPg0KPiA+ID4gTm90ZSBpZiBSYWZhZWwgd2FudHMgdG8gc3RpY2sgd2l0aCB0
aGUgYXBwcm9hY2ggZnJvbSB0aGlzIHYzLCB0aGVuDQo+ID4gPiBJIGd1ZXNzIHRoYXQgdGhlIGFw
cHJvYWNoIGluIDQvNSBpcyBmaW5lLg0KPiA+ID4gPiBSYWZhZWwgLSBjYW4geW91IHBsZWFzZSBj
b25maXJtIHdoaWNoIGRpcmVjdGlvbiB5b3Ugd2FudCB0byBzZWUgaGVyZQ0KPiBmb3IgdGhpcz8N
Cj4gDQo+IFNvIHRoZSBpZGVhIGlzIHRoYXQgdGhlIFBNQyBkcml2ZXIncyAic3VzcGVuZCIgbWV0
aG9kIG5lZWRzIHRvIGJlDQo+IGludm9rZWQgZnJvbSBhY3BpX3MyaWRsZV9wcmVwYXJlX2xhdGUo
KSwgc28gaXQgZG9lc24ndCBpbnRlcmZlcmUgd2l0aA0KPiB0aGUgc3VzcGVuZCBvZiB0aGUgb3Ro
ZXIgZGV2aWNlcyBpbiB0aGUgc3lzdGVtIGFuZCBzbyBpdCBjYW4gdGFrZSB0aGUNCj4gY29uc3Ry
YWludHMgaW50byBhY2NvdW50Lg0KDQpUaGUgcmVhc29uIHRvIGRvIG5vdGhpbmcgKGJlc2lkZXMg
YSBkZWJ1ZyBsZXZlbCBtZXNzYWdlIHJpZ2h0IG5vdykgd2l0aCB0aGUgY29uc3RyYWludHMNCmlu
Zm9ybWF0aW9uIGlzIHRoYXQgYXQgbGVhc3Qgb24gdG9kYXkncyBPRU0gcGxhdGZvcm1zIHRoZXJl
IGFyZSBzb21lIGluc3RhbmNlcyBjb25zdHJhaW50cw0KYXJlbid0IG1ldCBvbiBMaW51eCB0aGF0
IG5lZWQgdG8gYmUgaW52ZXN0aWdhdGVkIGFuZCByb290IGNhdXNlZC4gIFRoZXNlIHBhcnRpY3Vs
YXIgY29uc3RyYWludHMNCmRvbid0IGFjdHVhbGx5IGNhdXNlIHByb2JsZW1zIHJlYWNoaW5nIHMw
aXggcmVzaWRlbmN5IHRob3VnaC4NCg0KPiANCj4gV2hhdCBpcyBpdCBnb2luZyB0byBkbywgaW4g
dGhlIGZ1dHVyZSwgZGVwZW5kaW5nIG9uIHdoZXRoZXIgb3Igbm90IHRoZQ0KPiBjb25zdHJhaW50
cyBhcmUgbWV0Pw0KDQpUaGUgaWRlYSB3YXMgdGhhdCBpZiBjb25zdHJhaW50cyB3ZXJlIG1ldCB0
aGF0IGl0IHdvdWxkIHNlbmQgdGhlIE9TX0hJTlQgYXMgcGFydCBvZg0KYW1kX3BtY19zdXNwZW5k
L2FtZF9wbWNfcmVzdW1lLCBhbmQgaWYgdGhleSBhcmVuJ3QgbWV0IHRoZW4gc2tpcCB0aGlzIHN0
ZXAuDQoNCkl0IHdvdWxkIGVmZmVjdGl2ZWx5IGJsb2NrIHRoZSBzeXN0ZW0gZnJvbSBnZXR0aW5n
IHMwaXggcmVzaWRlbmN5IHVubGVzcyB0aGUgY29uc3RyYWludHMNCmFyZSBhbGwgbWV0LiAgR2l2
ZW4gd2Uga25vdyBzb21lIE9FTSBwbGF0Zm9ybXMgaGF2ZSBwcm9ibGVtcyBpbiBjdXJyZW50IGdl
bmVyYXRpb25zDQp3aXRoIGNvbnN0cmFpbnRzIGl0IHdvdWxkIHByb2JhYmx5IG5lZWQgdG8gYmUg
cmVzdHJpY3RlZCB0byB0aGlzIGJlaGF2aW9yIG9ubHkgb24gYSBmdXR1cmUNClNPQyB0aGF0IHdl
IGFyZSBjb25maWRlbnQgb2YgYWxsIGRyaXZlcnMgYW5kIGZpcm13YXJlIGFyZSBkb2luZyB0aGUg
cmlnaHQgdGhpbmcuDQoNCkJ5IHBhc3NpbmcgdGhlIGluZm9ybWF0aW9uIHRvIGFtZF9wbWMgd2Ug
Y2FuIGtlZXAgdGhhdCBsb2dpYyByZXN0cmljdGluZyB0aGUgYmVoYXZpb3IgdG8NCm9ubHkgdGhv
c2UgcGxhdGZvcm1zIHRoYXQgd2UncmUgY29uZmlkZW50IG9uIHRoYXQgYmVoYXZpb3IuDQo=
