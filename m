Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209044D4F4C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiCJQab (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 11:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiCJQaa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 11:30:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB5455224;
        Thu, 10 Mar 2022 08:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FltYFKfwDs8150kquztuOmmVvIIO6K6T4DG4ujBz8O2y+vrnB1UxcjpSS/k7JK3rvsu1CMtkflrL1wBqDLZjWLiGHI2aZ5tPWRCaxYdyYCaNug0xSUnUHmv8EX5btmqk5xJKjp0dMqvOSJtCJ7AoPvTZUJBZtZ3k9xZdDTXbc0SS0+gPIJXWcmqtnTrIL0TFfLNxj0SI+oVeJ+rS+9GyWrprszWGWjXRLXtoKRLmcXqNO8UYHisFgZcHbHYVbD1MwTznDXp3lY0F5ERGxCM4fc0pjYoWtZ9PIH/0T5HtSx/OxKKDHX/5l65JoieWU5QalTGKmA1vOb8qTZlSuqUybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaXXnR5Jf0ocQRXwVl5nF23Ly5tYc1likCtD7wNH5mQ=;
 b=DLiL+QODSnd0ZX4yowmq3EupHSuYgZg0H3d9rwAr6RYmjYMCy5+2hM6uQSkk3Mp1MBnLvZ7VnTJrI5riTwoohcSLG4thG/7AWAVQqkQgyxU5e8qH/QD0YBDd13DTDDwMGykC1YwDlhkS0hyiwl9dqwAxTr9A5nMCL+tjCz8isekD733tVgZS97ABG8owyKg/OnObXwr91EvMEwqy04t71n5KkuD58lJN7O8bKdTa3M1cg8K959pPiBhyP9gZQGkUiNHu55sXBirxbSobgmzgky8V6PfWkoHdmn6euQbd0blygVUylAhUryNN2m7ndDE0gbT7ETf0K6dvABN9wXLXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaXXnR5Jf0ocQRXwVl5nF23Ly5tYc1likCtD7wNH5mQ=;
 b=B5yUbFB3LO+KuJoH1Iecl7Aa7ghSoQQfzJc9Wn9iIznPigOwcZemlsSI2jv4FtkYXAeDVQP6wMUa3KDDhOyvBbJB1LOLdI4h+af/eyiG0zqpxy/3Q3G+GAZmduHj2H61A7wJ9ws+yH1Mw2pL5N63okQBkiGCegNfMNow30/dxG8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3695.namprd12.prod.outlook.com (2603:10b6:208:15a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 16:29:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 16:29:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 2/4] ACPI / x86: Pass the constraints checking result to
 LPS0 callback
Thread-Topic: [PATCH 2/4] ACPI / x86: Pass the constraints checking result to
 LPS0 callback
Thread-Index: AQHYNJJ1NaCRRz4Gi06RctTt4uLMI6y4zgyAgAAAVLA=
Date:   Thu, 10 Mar 2022 16:29:26 +0000
Message-ID: <BL1PR12MB51574ED8DA675D0B3C6173F6E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
         <20220310151705.577442-2-mario.limonciello@amd.com>
 <493159542d69de10383595ed018cb086a455e1b7.camel@linux.intel.com>
In-Reply-To: <493159542d69de10383595ed018cb086a455e1b7.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T16:27:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9a635408-34a7-486b-9eeb-811068a398c1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-10T16:29:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: bb740e65-ed23-4a08-94cf-857569e837e5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11693b9-4278-446c-222c-08da02b324b1
x-ms-traffictypediagnostic: MN2PR12MB3695:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3695164B82E3AFDF11B38621E20B9@MN2PR12MB3695.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wdoz/lDbrkXNVlX9ufQq4P118Gh8z25RH9oHAaUlLAIOhmLCxY2PnVYmUQDlI7YXiCMJfW7jrXjjQMLuRRMzc2k/RAyB/ydPCs0Bq0AJ6EnlsrzHUD1vvnQAU8CzKM1hVoKzvbTPy6Zb7lSO4T9fbJafrI/LOXiiyD6RBdpEdzt2ChfN5OINaiLZ53jJcMHmxFQO4O9MO4OKrTsAeJ5E0Ihc0C5QwgxHDD8p0etFm6bFVPayGjF0SMjlUzCGNtYqkXRS2fZMSYifcWc2wkI5QEQorAkBKW7cvxE8flv/T7uAj1VvRfs1I3qflZWGb0M1l1OKEkdcIAs+QXu8RXGAObCEuOC8uy2zS347uXB/4cXxlj2NDebbo5VmnNdruoeCZ0ZwGO5FuAEn4LK7atHMEGLN0ctRh9IbiLWZ3bNNxLnmpJHrxu8mDCASP5MjkoyRcNM39og/tyDCh70lXsUsBBEvHym0v9DMHOgg3eC13zcBA/FyN0/2T3/1Ilk+2dzFkj5pVRZ2CXusUPFlayMcpX1V9mRwejcS7FY9mxqEzTMnaGmCrQrV/spi77B1kbZmAvt6uDf/jGUQAVPgB9P/L0kp8WeyL761ZQZCb4to5vFZB69HqI2Nnv40eymjzsj+3Rn7lidsmbJf8tH7pspzJo3Rxj9GYNCpTPKS5+TJtpi3xH0XYRQwt2vHPV90xolYIZHficHDOXP9d4eDFg0btQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(83380400001)(71200400001)(2906002)(316002)(53546011)(7696005)(6506007)(508600001)(110136005)(54906003)(26005)(186003)(33656002)(52536014)(66446008)(76116006)(66946007)(66556008)(64756008)(66476007)(9686003)(38070700005)(8676002)(4326008)(38100700002)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NNWEJxQkxyWWUvRUFpNHhKZkNCNmN5eE9mR2lsOHZ2QTBjL2p4djBsZVdq?=
 =?utf-8?B?MVlKMXBqYkZ0RzJDTkY0TjI0MHhyR0tBN3B4THc1VUlEM2YwNlFIczYrRGJ6?=
 =?utf-8?B?eWVXNEl6Wnk0cDRHM2NQTDIvaWJMWkE4YVYvWXljdUE1dm1TNTlHYW03dUg5?=
 =?utf-8?B?aWtsL2pJblplSktTTFlrTk9QMlhBOGVnSWcvK1FnQ1NadHRUVGZJSTNFQW5B?=
 =?utf-8?B?THFid2dWaUpuVUdkb2NkdTRTMUo3NFZQYkxZS2g0ZUdBWTRJS1h2N0NXbUFO?=
 =?utf-8?B?eEZ2ZXF4RFpWSjJERytCZGRtcnJjY1hBVGUxNGQvdG1teEhPTm9tTnh4V05G?=
 =?utf-8?B?eXZaMm1UNzVlK0ZCY1JvNVN1eGtBbWpybzVQK21IbFUyeEI5Z1Y5czl2V0cz?=
 =?utf-8?B?TkFMeUR1MEI4Yi9EVk9XcjltNVl3ZTJDQkZodytMSFk2MGdDdCtRNDJDTXhj?=
 =?utf-8?B?Qy9kckhpK2dBUDJZM2xFYkdvN1hQMng5MzlWc0oyaWE1U1FCd1dRd0ErOHVN?=
 =?utf-8?B?RzFpL2NxdFpWNVJ1cWcxUFlyUmFFcmhLN1FESEFnWGpEM25neFhwUjNIcjg5?=
 =?utf-8?B?Y2djaEV3Q1R3dzBXbDAyOFRmSVpSWTk2K1JQam1hNitoOGlDNFB5ZkJ5Z3hO?=
 =?utf-8?B?Y1RZbzgxWDJRQTNJZnBvdDByNzRTc2xYR294d3I0alhDWkpJVWxMaE5kTDdo?=
 =?utf-8?B?OUtPclN1Szc2Ym55alVkck03cGNzbXo1cmlPSlBxSjVTS084azVKWm9YeGk3?=
 =?utf-8?B?K0JiNmcyR0VVNTlWbGNmMmQ4V25SQWlTRGdCcHd4RDJVOXdJbUZYRGEyb1hP?=
 =?utf-8?B?ZWIrdkdyT2pyTGE3SVdkcnZSR1F5dUZPMGRNK0krWkxKTk1pNllNMkZJNXY4?=
 =?utf-8?B?dXBQYk1YUWdod1o0SVZ2QnlmTEVSM2NjeGViUVpCOUpyZUx2ZUZ6c09zTjBE?=
 =?utf-8?B?Wm1adDNUS0NZam9ML3J4cXVnaTVTR0RtQVRFZHY3M3oySXF0dkJjc3podEZs?=
 =?utf-8?B?ZUExYWNmSU80aWJZKzlCS2dNc0hucDZ0L0N4T2paTlpSQWdIbmxTd3BSOWV0?=
 =?utf-8?B?aWhlaWRKRDBYWGt6V3JTYjkydE1oWUh1MTNNazdpcG5ST0NoYWNwSG9iSkQ4?=
 =?utf-8?B?a3FzcUQvQXJVcTkxdDFTbkxMOWF2dTF3TFlvaE9ET3hnMlZiNzVHSzUvenUx?=
 =?utf-8?B?UHpMdGRFM0t6MEhMNW1wSU1TdXlya0xJNDR2ZFQwSUE1SjFtRUlIWEZrR2hJ?=
 =?utf-8?B?dFRsczgyV1VoYWxpbS9NNFNjWnNicU5sTEx1UlJiSGdIYzRJSis1K3F4VWpG?=
 =?utf-8?B?MDNrYndVZW94QUxDcEpQeHBNT0Rna0wzZUppUmRQRW51NkoyYXg1UUhKbEl5?=
 =?utf-8?B?SkhqbS9HYUJmNXNSU1lvWXphZVluVHRTYklPODJjQ0hVMFh0eFRlRnBSdWFO?=
 =?utf-8?B?dDZCMnNqbW5pWUhyK211RGFoem5ZdGhueVZ5K1JkNUcwSHdOM3BxeUE2U0hE?=
 =?utf-8?B?MEpnQWtkckRtOXhNcGM3M2VEa2hoZy9xTWdqQWY4bllZYlcwK283M0tRRmtO?=
 =?utf-8?B?MEI0MEtFcjc4NllheEE0TUVIdTlKOHRHYW5NeVJrNlRXaWhuRS9pcGxROSt0?=
 =?utf-8?B?bjE5SHhLc3BITzN5U3VwTzJvR1h6VUxmSlg5cnpURStIbnBzRW9TV0V2dThW?=
 =?utf-8?B?eVozTTNBT0R1VjAzMU4yVVpENnFZSVRreDBNbzB6UXdrdWlEcnN2SDdIUHll?=
 =?utf-8?B?OVdUR2tSaWNLMUhsVDBGdkpITWsreGlkamZVTkUwYzdVUmJSbTNXdDJMcDdx?=
 =?utf-8?B?NzlWdW1uQXhwdGZYbDlwWitrdFFISmYveU1ncElhaXp2RmgwYXVtYUYrT3pw?=
 =?utf-8?B?ZmU2a1VNU0V3MTJuYWNEUVhRS0FKVVJUTjFnMTBycEd3SDlMN0VoRnRMVk1W?=
 =?utf-8?Q?hfcvAA5iUYxEXPeO5FvqLVK12qUB80zI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11693b9-4278-446c-222c-08da02b324b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 16:29:26.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i13ZyhSnkJnqufBGfVPrY5yIP3HUm8YOwInPpVdVUpVzAdNm4wazURbHlEkq0x9cQ3fR0ZS7BcKns4t9+CRG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2
aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAxMCwgMjAyMiAxMDoyNg0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPjsgSGFucyBkZSBHb2VkZQ0KPiA8aGRlZ29lZGVAcmVkaGF0LmNv
bT47IE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+OyBSYWZhZWwgSiAuDQo+IFd5
c29ja2kgPHJqd0Byand5c29ja2kubmV0Pg0KPiBDYzogb3BlbiBsaXN0Olg4NiBQTEFURk9STSBE
UklWRVJTIDxwbGF0Zm9ybS1kcml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1h
Y3BpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gQUNQSSAvIHg4
NjogUGFzcyB0aGUgY29uc3RyYWludHMgY2hlY2tpbmcgcmVzdWx0IHRvDQo+IExQUzAgY2FsbGJh
Y2sNCj4gDQo+IE9uIFRodSwgMjAyMi0wMy0xMCBhdCAwOToxNyAtMDYwMCwgTWFyaW8gTGltb25j
aWVsbG8gd3JvdGU6DQo+ID4gSWYgY29uc3RyYWludHMgY2hlY2tpbmcgaGFzIGJlZW4gZW5hYmxl
ZCBieSB0aGUgTFBTMCBjb2RlLCBpdCBtYXkNCj4gPiBhbHNvIGJlIHVzZWZ1bCBmb3IgZHJpdmVy
cyB1c2luZyB0aGUgY2FsbGJhY2sgdG8gbWFrZSBhIGRlY2lzaW9uIHdoYXQNCj4gPiB0byBkby4N
Cj4gPg0KPiA+IEZvciBleGFtcGxlIHRoaXMgbWF5IGluIHRoZSBmdXR1cmUgYWxsb3cgYSBmYWls
aW5nIGNvbnN0cmFpbnRzIGNoZWNrDQo+ID4gcHJldmVudGluZyBhbm90aGVyIGRyaXZlciBmcm9t
IG5vdGlmeWluZyBmaXJtd2FyZSB0aGF0IGFsbCByZXF1aXJlZA0KPiA+IGRldmljZXMgaGF2ZSBl
bnRlcmVkIHRoZSBkZWVwZXN0IHN0YXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvYWNwaS94ODYvczJpZGxlLmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPiA+ICBpbmNs
dWRlL2xpbnV4L2FjcGkuaCAgICAgIHwgIDQgKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL3g4Ni9zMmlkbGUuYyBiL2RyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMNCj4gPiBp
bmRleCA2NTJkYzJkNzU0NTguLmM3MzdhOGU1ZDVhNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2FjcGkveDg2L3MyaWRsZS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYw0K
PiA+IEBAIC04OCw3ICs4OCw3IEBAIHN0cnVjdCBscGlfZGV2aWNlX2NvbnN0cmFpbnRfYW1kIHsN
Cj4gPg0KPiA+ICBzdHJ1Y3QgbHBzMF9jYWxsYmFja19oYW5kbGVyIHsNCj4gPiAgCXN0cnVjdCBs
aXN0X2hlYWQgbGlzdF9ub2RlOw0KPiA+IC0JaW50ICgqcHJlcGFyZV9sYXRlX2NhbGxiYWNrKSh2
b2lkICpjb250ZXh0KTsNCj4gPiArCWludCAoKnByZXBhcmVfbGF0ZV9jYWxsYmFjaykodm9pZCAq
Y29udGV4dCwgYm9vbCBjb25zdHJhaW50cyk7DQo+ID4gIAl2b2lkICgqcmVzdG9yZV9lYXJseV9j
YWxsYmFjaykodm9pZCAqY29udGV4dCk7DQo+ID4gIAl2b2lkICpjb250ZXh0Ow0KPiA+ICB9Ow0K
PiA+IEBAIC0yOTcsNyArMjk3LDcgQEAgc3RhdGljIHZvaWQgbHBpX2RldmljZV9nZXRfY29uc3Ry
YWludHModm9pZCkNCj4gPiAgCUFDUElfRlJFRShvdXRfb2JqKTsNCj4gPiAgfQ0KPiA+DQo+ID4g
LXN0YXRpYyB2b2lkIGxwaV9jaGVja19jb25zdHJhaW50cyh2b2lkKQ0KPiA+ICtzdGF0aWMgdm9p
ZCBscGlfY2hlY2tfY29uc3RyYWludHMoYm9vbCAqbWV0KQ0KPiA+ICB7DQo+ID4gIAlpbnQgaTsN
Cj4gPg0KPiA+IEBAIC0zMTksMTEgKzMxOSwxMyBAQCBzdGF0aWMgdm9pZCBscGlfY2hlY2tfY29u
c3RyYWludHModm9pZCkNCj4gPiAgCQkJY29udGludWU7DQo+ID4gIAkJfQ0KPiA+DQo+ID4gLQkJ
aWYgKGFkZXYtPnBvd2VyLnN0YXRlIDwgbHBpX2NvbnN0cmFpbnRzX3RhYmxlW2ldLm1pbl9kc3Rh
dGUpDQo+ID4gKwkJaWYgKGFkZXYtPnBvd2VyLnN0YXRlIDwgbHBpX2NvbnN0cmFpbnRzX3RhYmxl
W2ldLm1pbl9kc3RhdGUpDQo+IHsNCj4gPiAgCQkJYWNwaV9oYW5kbGVfaW5mbyhoYW5kbGUsDQo+
ID4gIAkJCQkiTFBJOiBDb25zdHJhaW50IG5vdCBtZXQ7IG1pbiBwb3dlciBzdGF0ZTolcw0KPiA+
IGN1cnJlbnQgcG93ZXIgc3RhdGU6JXNcbiIsDQo+ID4NCj4gCWFjcGlfcG93ZXJfc3RhdGVfc3Ry
aW5nKGxwaV9jb25zdHJhaW50c190YWJsZVtpXQ0KPiA+IC5taW5fZHN0YXRlKSwNCj4gPiAgCQkJ
CWFjcGlfcG93ZXJfc3RhdGVfc3RyaW5nKGFkZXYtDQo+ID5wb3dlci5zdGF0ZSkpOw0KPiA+ICsJ
CQkqbWV0ID0gZmFsc2U7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4NCj4gPiBAQCAt
NDU1LDEzICs0NTcsMTQgQEAgc3RhdGljIHN0cnVjdCBhY3BpX3NjYW5faGFuZGxlciBscHMwX2hh
bmRsZXIgPSB7DQo+ID4gIGludCBhY3BpX3MyaWRsZV9wcmVwYXJlX2xhdGUodm9pZCkNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IGxwczBfY2FsbGJhY2tfaGFuZGxlciAqaGFuZGxlcjsNCj4gPiArCWJv
b2wgY29uc3RyYWludHNfbWV0ID0gdHJ1ZTsNCj4gPiAgCWludCByYyA9IDA7DQo+ID4NCj4gPiAg
CWlmICghbHBzMF9kZXZpY2VfaGFuZGxlIHx8IHNsZWVwX25vX2xwczApDQo+ID4gIAkJcmV0dXJu
IDA7DQo+ID4NCj4gPiAgCWlmIChwbV9kZWJ1Z19tZXNzYWdlc19vbikNCj4gPiAtCQlscGlfY2hl
Y2tfY29uc3RyYWludHMoKTsNCj4gPiArCQlscGlfY2hlY2tfY29uc3RyYWludHMoJmNvbnN0cmFp
bnRzX21ldCk7DQo+IA0KPiBscGlfY2hlY2tfY29uc3RyYWludHMoKSB3YXMgb25seSB1c2VkIGZv
ciBkdW1waW5nIGluZm9ybWF0aW9uIHRvIGRtZXNnLiBJZg0KPiB5b3UNCj4gd2FudCB0byBtYWtl
IGEgZGVjaXNpb24gYmFzZWQgb24gd2hldGhlciBhIGNvbnN0cmFpbnQgd2FzIG1ldCB0aGVuIHlv
dQ0KPiBwcm9iYWJseQ0KPiB3YW50IHRvIHJ1biBpdCBhbGwgdGhlIHRpbWUuIFlvdSBjb3VsZCB1
c2UgcG1fZGVidWdfbWVzc2FnZXNfb24gaW5zaWRlIG9mDQo+IGxwaV9jaGVja19jb250cmFpbnRz
KCkgdG8gZGVjaWRlIHdoZXRoZXIgdG8gcHJpbnQgdG8gdGhlIGxvZy4NCg0KVGhhdCdzIGEgZ29v
ZCBpZGVhLg0KDQo+IA0KPiA+DQo+ID4gIAkvKiBTY3JlZW4gb2ZmICovDQo+ID4gIAlpZiAobHBz
MF9kc21fZnVuY19tYXNrID4gMCkNCj4gPiBAQCAtNDkwLDcgKzQ5Myw3IEBAIGludCBhY3BpX3My
aWRsZV9wcmVwYXJlX2xhdGUodm9pZCkNCj4gPg0KPiA+ICAJbXV0ZXhfbG9jaygmbHBzMF9jYWxs
YmFja19oYW5kbGVyX211dGV4KTsNCj4gPiAgCWxpc3RfZm9yX2VhY2hfZW50cnkoaGFuZGxlciwg
JmxwczBfY2FsbGJhY2tfaGFuZGxlcl9oZWFkLA0KPiBsaXN0X25vZGUpIHsNCj4gPiAtCQlyYyA9
IGhhbmRsZXItPnByZXBhcmVfbGF0ZV9jYWxsYmFjayhoYW5kbGVyLT5jb250ZXh0KTsNCj4gPiAr
CQlyYyA9IGhhbmRsZXItPnByZXBhcmVfbGF0ZV9jYWxsYmFjayhoYW5kbGVyLT5jb250ZXh0LA0K
PiA+IGNvbnN0cmFpbnRzX21ldCk7DQo+IA0KPiBPdGhlcndpc2UsIGlzIGl0IG9rYXkgdGhhdCBj
b25zdHJhaW50c19tZXQgd2lsbCBhbHdheXMgYmUgdHJ1ZSBpZg0KPiBwbV9kZWJ1Z19tZXNzYWdl
c19vbiBpc24ndD8NCg0KSSB3YXNuJ3QgcmVhZHkgdG8gbWFrZSBkZWNpc2lvbnMgYmFzZWQgb24g
aXQsIGJ1dCB5b3UncmUgcmlnaHQgYXQgbGVhc3QNCnJ1bm5pbmcgaXQgYWxsIHRoZSB0aW1lIGFu
ZCBzaG93aW5nIHRoZSBpbXBhY3RmdWwgbWVzc2FnZXMgd2hlbiBkZWJ1Z2dpbmcNCm9uIGlzIGEg
Z29vZCBzdGFydC4NCg0KVGhhbmtzIQ0KDQo+IA0KPiBEYXZpZA0KPiANCj4gPiAgCQlpZiAocmMp
DQo+ID4gIAkJCWdvdG8gb3V0Ow0KPiA+ICAJfQ0KPiA+IEBAIC01NTQsNyArNTU3LDcgQEAgdm9p
ZCBhY3BpX3MyaWRsZV9zZXR1cCh2b2lkKQ0KPiA+ICAJczJpZGxlX3NldF9vcHMoJmFjcGlfczJp
ZGxlX29wc19scHMwKTsNCj4gPiAgfQ0KPiA+DQo+ID4gLWludCBhY3BpX3JlZ2lzdGVyX2xwczBf
Y2FsbGJhY2tzKGludCAoKnByZXBhcmVfbGF0ZSkodm9pZCAqY29udGV4dCksDQo+ID4gK2ludCBh
Y3BpX3JlZ2lzdGVyX2xwczBfY2FsbGJhY2tzKGludCAoKnByZXBhcmVfbGF0ZSkodm9pZCAqY29u
dGV4dCwgYm9vbA0KPiA+IGNvbnN0cmFpbnRzKSwNCj4gPiAgCQkJCSB2b2lkICgqcmVzdG9yZV9l
YXJseSkodm9pZCAqY29udGV4dCksDQo+ID4gIAkJCQkgdm9pZCAqY29udGV4dCkNCj4gPiAgew0K
PiA+IEBAIC01NzgsNyArNTgxLDcgQEAgaW50IGFjcGlfcmVnaXN0ZXJfbHBzMF9jYWxsYmFja3Mo
aW50DQo+ICgqcHJlcGFyZV9sYXRlKSh2b2lkDQo+ID4gKmNvbnRleHQpLA0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0xfR1BMKGFjcGlfcmVnaXN0ZXJfbHBzMF9jYWxsYmFja3MpOw0KPiA+DQo+
ID4gLXZvaWQgYWNwaV91bnJlZ2lzdGVyX2xwczBfY2FsbGJhY2tzKGludCAoKnByZXBhcmVfbGF0
ZSkodm9pZCAqY29udGV4dCksDQo+ID4gK3ZvaWQgYWNwaV91bnJlZ2lzdGVyX2xwczBfY2FsbGJh
Y2tzKGludCAoKnByZXBhcmVfbGF0ZSkodm9pZCAqY29udGV4dCwNCj4gYm9vbA0KPiA+IGNvbnN0
cmFpbnRzKSwNCj4gPiAgCQkJCSAgICB2b2lkICgqcmVzdG9yZV9lYXJseSkodm9pZCAqY29udGV4
dCksDQo+ID4gIAkJCQkgICAgdm9pZCAqY29udGV4dCkNCj4gPiAgew0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2FjcGkuaCBiL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+ID4gaW5kZXgg
Y2FlMGZkZTMwOWYyLi41YWFlNzc0NjcwZGMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9hY3BpLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2FjcGkuaA0KPiA+IEBAIC0xMDI0LDEw
ICsxMDI0LDEwIEBAIHZvaWQgYWNwaV9vc19zZXRfcHJlcGFyZV9leHRlbmRlZF9zbGVlcChpbnQN
Cj4gKCpmdW5jKSh1OA0KPiA+IHNsZWVwX3N0YXRlLA0KPiA+ICBhY3BpX3N0YXR1cyBhY3BpX29z
X3ByZXBhcmVfZXh0ZW5kZWRfc2xlZXAodTggc2xlZXBfc3RhdGUsDQo+ID4gIAkJCQkJICAgdTMy
IHZhbF9hLCB1MzIgdmFsX2IpOw0KPiA+ICAjaWZkZWYgQ09ORklHX1g4Ng0KPiA+IC1pbnQgYWNw
aV9yZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyhpbnQgKCpwcmVwYXJlX2xhdGUpKHZvaWQgKmNvbnRl
eHQpLA0KPiA+ICtpbnQgYWNwaV9yZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyhpbnQgKCpwcmVwYXJl
X2xhdGUpKHZvaWQgKmNvbnRleHQsIGJvb2wNCj4gPiBjb25zdHJhaW50cyksDQo+ID4gIAkJCQkg
dm9pZCAoKnJlc3RvcmVfZWFybHkpKHZvaWQgKmNvbnRleHQpLA0KPiA+ICAJCQkJIHZvaWQgKmNv
bnRleHQpOw0KPiA+IC12b2lkIGFjcGlfdW5yZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyhpbnQgKCpw
cmVwYXJlX2xhdGUpKHZvaWQgKmNvbnRleHQpLA0KPiA+ICt2b2lkIGFjcGlfdW5yZWdpc3Rlcl9s
cHMwX2NhbGxiYWNrcyhpbnQgKCpwcmVwYXJlX2xhdGUpKHZvaWQgKmNvbnRleHQsDQo+IGJvb2wN
Cj4gPiBjb25zdHJhaW50cyksDQo+ID4gIAkJCQkgICAgdm9pZCAoKnJlc3RvcmVfZWFybHkpKHZv
aWQgKmNvbnRleHQpLA0KPiA+ICAJCQkJICAgIHZvaWQgKmNvbnRleHQpOw0KPiA+ICAjZW5kaWYg
LyogQ09ORklHX1g4NiAqLw0K
