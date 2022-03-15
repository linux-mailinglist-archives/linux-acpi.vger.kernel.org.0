Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAEF4D9350
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 05:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbiCOEb7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 00:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiCOEb6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 00:31:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EE48E56
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 21:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFqLc6vy45djHflyoX+J7PM7sGMMIvLHt0918pGDa3n6U/ahHumzao9Ig1RHX6JrZFJm9NPMQxQrY8BcfX2z9y/epzpaOBj7j6c5NiZVXa7FlMd51thd5xdzOXNkwHWgWIZnAmjtRM5lsmswNPxHa6pa8ptR0K0oOgWzqvKTqroRzWXyr+r3jfrHdAKvBO4/qqTNA8on8R3tS6KRGpo6sHIDbPOy5WUdDjNstiIQEWRyKoFPfs6tFU3xaPV+aFdvpZqQWetdf5VUSVV0LA8KuCSXY/Rrt2IAt6cR0CS5vykPLYOVvApjXuqiAXg4Kk2MslUrM+0sk/ffaYXF8sV0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkpYuFpDguPNc4yo8csZiE+wZ2xmSd7qJWiTgVSpjxk=;
 b=ZmIQE52JzCujfxeIegAdmYNUtfw9o28ySDNAZfRRQBSVrazzbftK3uLt8YZgjmsuYU2K6/oZJDyYHoP5b0lRGkcI5RjpBkP2lFpVoQimXDJqO8IcrGvema7bHf2N33F5e4FojI55q5n+HPH+vcbFhV7wTJP9/gJlYQEz0N4xB1+TrqokWCXEKWMxeEwpFx/tYbiuU8aa/RRDosfvLVSG1KcvXdFdTOtJqgneTKqlXIbG0aU9xO83jf0dPisbiuqpHNsrk4O1Vw/ktl8/p2xwwyE502ixYlWG1giFKTMaHi3NdV+DNnKggmHGgJc1U+29oBiH9xbJ8/zKOE64bwHkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkpYuFpDguPNc4yo8csZiE+wZ2xmSd7qJWiTgVSpjxk=;
 b=Oy0xt6eaFilEv7IKfa3twuKI4KCuW6J2r3lM9JB0MY4qmcWWqZlvBaVOS1et8pYbhjKTzn+56l9kYbFRvjnwEWHLwbwxtX/taotH+KX+4XM/OMmBUjb09HtI0CMQgA5a3wzCMRh93t7uyNmkoNGzucrPY+ex8DpRGT+aIx5nE08=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 04:30:36 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 04:30:36 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Topic: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Index: AQHYNMYH7nSloADYlk2nIR9Xb+AhIay6UkUAgAOsBiCAAVS4gIAAjdlQ
Date:   Tue, 15 Mar 2022 04:30:36 +0000
Message-ID: <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
 <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T04:30:34Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=476ea495-6827-4037-b828-7a87ddcde6dc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T04:30:34Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3772a9a3-3394-4f0d-a487-14b1c9e6956e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de6e747-73a7-483f-5f04-08da063c8d5d
x-ms-traffictypediagnostic: BL0PR12MB2338:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2338199A15C5EA570E56D761E2109@BL0PR12MB2338.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipiVztDfnUOWOUuxiO1TpaxSgVUbg7HIeQO/LRtN+rAvHC18VnzRXokH07PFBx/bLaQGi1ceQPZe3svCwdXljs1rE2Zz8hrDjftwCdcdqKf535uhHnaSYSEcGcUo9bGD5mLfAcftxqXh8YSF6fTFnxVchWyLMcWV0v1f7eAWvgT2zQH5p4EbLpSmdk62otD5EXyLdSgfXY1ul/eK/rLofoGuDqZS660SuYnSQJen6/5zWVE5XthfNtdiu4Kf3N3V00yo6pcGG7TZJ8Ctm8scL2h9gB+mAYOtK3TcBdbEXP0NIhCjl2gFeRSR7BGfKnwgdvDUJgZojr2mwhGrJ7wABO3P7prPVxkgn1nviucaaMtoiZLkDAB1UR40TM3MHUinZ0uWkXCdLvGVth0b2TSeGCnfX+pu4aWPeso03Nmk4nD5cQhj0aReaYXfLjYE6Pf3aj3FHhib0B1+WDY6cDDq/BOR7S1Fr8La768eb+zkpkcZMudX36CQ1cqH47Y9eFcLA+wS4yLPp0jJ6cMghpXIM0s0gFxr7ubxSqAVgvorhHAUgywxDnDMlEAGJrPiK7W3dMVOm7dYehk/kvJbOqgXQPz/XeJfrDa/nlKhw0ooM8qE52kDaN+TG3gv/Z423EdZHuGONhYNilzPEfMF1n1onT8nRtPiixcuLYT5udE3HNsFyPNbZXoUSCwUY0jh8BxSUFYM70JxAY1062IJ2/aYBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(508600001)(76116006)(71200400001)(122000001)(38100700002)(66476007)(66446008)(66946007)(66556008)(64756008)(316002)(8676002)(6916009)(86362001)(26005)(186003)(4326008)(54906003)(53546011)(33656002)(9686003)(7696005)(6506007)(83380400001)(2906002)(8936002)(52536014)(55016003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFYQXZ5Z0praXRMN3VGSHBUb0hrajEwVnlDMWZPTGN0NUVYeGlEOWorUzdQ?=
 =?utf-8?B?SEpqb3QzTVBic0RFUjVHSlVOWlExWkZHVXpObGFKN3pPa0xPZFNZaTNqSTlT?=
 =?utf-8?B?b1pvUXpPMExFczk3cVRGVGVhajgvTzExSHgxUW1xaXhmQTArL1loVCtBWUNO?=
 =?utf-8?B?N1dUeUZPZkJHUS9aaGtheERINjZnVUNkMXlicjRrMW5pMEduODQ1WGVxMkVO?=
 =?utf-8?B?VGM5VlpNbDh0MGhLM3JROCtReUVSOWdPVWprWG02d1dyT2pXMnZjSWFnN05n?=
 =?utf-8?B?UitkWDBXbnFnUTBySFQ2TnhLZTRudVpRRTB5VklES0k0T1JKemdTNXB3ZzhJ?=
 =?utf-8?B?aFJzemF4WUNOcFIrZnovYkJEVlpoVkRhRFhjK2NObzVJTmErZUZ6OXVIdXJB?=
 =?utf-8?B?ZjVMRVRwUHlwRlZsRzF6ajhYdGNQV1djU3Zid3U5NTl3Z01MWmFOejNMRDU0?=
 =?utf-8?B?cmUzRk9JMXRFSkpNclJQUXFSVDA5QTlvZERFYzZnTjlzSEhXck50b1Q0RUxR?=
 =?utf-8?B?SEpYYW0yNW5jMm9wM1hmRXVuVVo5Ry9NcEdCd3BoNU1WMWNrdEQ2T2JhcC9a?=
 =?utf-8?B?ZGJUeUJHa0FDeVNhWGhHQUdpQjdrNXEvUzB4RzJwR0xGdmZJZWMzc05GcXZw?=
 =?utf-8?B?UmZMSENMNWNTWWI1VFk2RFh4NVZxejVlQ0tEUTVYci9SbVRobUNkSUlFdlhV?=
 =?utf-8?B?QzZ0UDd3TDUwK1dxR2JXaDludDVsc3BqM1l4TWJVRTVteUJnNlM5WFNLakFQ?=
 =?utf-8?B?bXNGRFdwaXNuMlRiaW0ybFg0cVpod1h3RFJUQ3BvanZldk11SmZTcnpORVVs?=
 =?utf-8?B?ZnlnNG03NkhleUVjMCt5a21tSXQ2di9hNTBFeWVRNi9aOXl2Mk5vSXFDU1VI?=
 =?utf-8?B?L1R6bGNpY29aZk5FZ0V0alhsYTBDZmhoVlNYdkF6enNFZTlpKzRsVUo5d1VO?=
 =?utf-8?B?VW9IQjRPcVBybHlQT2JEamZuL0k2ZW1sckFOZDJGSmtKbHhXbFo2bEtxRzBP?=
 =?utf-8?B?aExGaGFTZVRDL1FWdjZPWllvR1U3WDh4TFFtS2NLMlNadDdlVnVTY1FRS2I2?=
 =?utf-8?B?RXdUdTVaVmNOLzY1YU5wQ2RQbTVmNkErNnhyUDdBNTdJdlNoN2dnVHM3VlRF?=
 =?utf-8?B?N0QxSmp3YjhGRnV4YW8xM3ptK1ROKyt3OTVzN3pGM1Y4Y2l3aW9NWUt3bC94?=
 =?utf-8?B?eWMzeDdvcjczQ1krUXBxUDVhRlE1eCtRcVE2anYvSzJDc1Q1M1J5elhDYVZE?=
 =?utf-8?B?TDJBd3lORnFSSnhKY1Z3TitQajd5Z3VMbmE4bG16Y1pmWEJhMXdxNXA1L2ky?=
 =?utf-8?B?eTEvK0FaM2ZlaFdYcEhtS1hlWHJjS2hTTlBDMjl5TFdMVXFMMFF1UzdRM1Nh?=
 =?utf-8?B?c3FJWDRzRFJlamNHUkNBaDU0VWRjcEFwUkYyUVRvVjVRRUUxajVjaHJRQ3No?=
 =?utf-8?B?bEJpV2NnalhIR3VBRkhHV0hwS2VjL0xFQXE1NXJaeWdLTk5FanFEb2w3UlUz?=
 =?utf-8?B?OHJScVU1VW81S3F5OGF4WCs4TE81N0YzUFJmazJVR3Q4dnFTbVNXeUZJT1Qy?=
 =?utf-8?B?ZGNuM3RYL1ZWOUw4NmlWV21MOE5uYkJtd1FXQzRWL2xJOEFOUzBTem9rdmRi?=
 =?utf-8?B?UjJvRm9IQ2Y4d3NnUVJrMGkwUHgxOGFWZ1dadUsvOGtVaUVGTXZtMit5UEhq?=
 =?utf-8?B?a3RNOGM5QitTVWNFWGw1RmYybkNrdEkvWmxvcXo1VWNMaW5qV0prQ09HM2xn?=
 =?utf-8?B?RzRlaytqRy9pd0dvckcvdjQvNlczWEExWTB5UG5BK2huNEZCV0szclpwME91?=
 =?utf-8?B?aWZCZTNqOHJiOVVGV3Z0Mk1KcGN0Y0RnWlB3MUdSY2hodjRQNzB4aXVML3dF?=
 =?utf-8?B?ajUxNHZwdU1UOStHanZNeVFpSFhQOEFiUjI5ZXZ0dWdkRTZYMGFuditCZFln?=
 =?utf-8?Q?qoDQKZDkWxNigSP/ZmOolCYW/HnNKWBj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de6e747-73a7-483f-5f04-08da063c8d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 04:30:36.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndqKXYclcE/8QUASjVvpg50LOJBOmBSMjA2v/ONIgfCkz24yg1rb46h7xnj2XAxREzMpQIS/xaQ52py8T3T/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50
OiBNb25kYXksIE1hcmNoIDE0LCAyMDIyIDE1OjAxDQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFm
YWVsQGtlcm5lbC5vcmc+OyBSYWZhZWwgSiAuIFd5c29ja2kNCj4gPHJqd0Byand5c29ja2kubmV0
PjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+Ow0K
PiBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+OyBIb3Us
IFhpYW9tZW5nDQo+IChNYXR0aGV3KSA8WGlhb21lbmcuSG91QGFtZC5jb20+OyBMaXUsIEFhcm9u
IDxBYXJvbi5MaXVAYW1kLmNvbT47DQo+IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsg
SGFucyBkZSBHb2VkZQ0KPiA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Nl0gQUNQSTogYnVzOiBGb3IgcGxhdGZvcm0gT1NDIG5lZ290aWF0ZSBjYXBhYmlsaXRp
ZXMNCj4gDQo+IE9uIE1vbiwgTWFyIDE0LCAyMDIyIGF0IDEyOjQ1IEFNIExpbW9uY2llbGxvLCBN
YXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBbUHVi
bGljXQ0KPiA+DQo+ID4gPiBJIHdvdWxkIGRvDQo+ID4gPg0KPiA+ID4gaWYgKGNhcGJ1ZltPU0Nf
U1VQUE9SVF9EV09SRF0gPT0NCj4gY2FwYnVmX3JldFtPU0NfU1VQUE9SVF9EV09SRF0pDQo+ID4g
PiAgICAgICAgIGNhcGJ1ZltPU0NfUVVFUllfRFdPUkRdID0gMDsNCj4gPiA+IGVsc2UNCj4gPiA+
ICAgICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSAmPQ0KPiBjYXBidWZfcmV0W09TQ19T
VVBQT1JUX0RXT1JEXTsNCj4gPiA+DQo+ID4gPiBzbyB0aGF0IHRoZSBsb29wIHRlcm1pbmF0ZXMg
ZXZlbiBpZiB0aGUgZmlybXdhcmUgZG9lcyBzdHJhbmdlIHRoaW5ncw0KPiA+ID4gYW5kIHRoZW4g
aXQgd291bGQgb25seSBiZSBuZWNlc3NhcnkgdG8gY2hlY2sNCj4gY2FwYnVmW09TQ19RVUVSWV9E
V09SRF0NCj4gPiA+IGluIHRoZSBsb29wIHRlcm1pbmF0aW9uIGNvbmRpdGlvbi4NCj4gPiA+DQo+
ID4gPiBXb3VsZCB0aGF0IHdvcms/DQo+ID4gPg0KPiA+DQo+ID4gSSB0aGluayBpdCB3aWxsLiAg
SSdsbCB0cnkgaXQgYW5kIHNlbmQgdXAgYSB2NyBpZiBzby4NCj4gPg0KPiA+ID4gPiArICAgICAg
ICAgICAgICAga2ZyZWUoY29udGV4dC5yZXQucG9pbnRlcik7DQo+ID4gPiA+ICsgICAgICAgfSB3
aGlsZSAoY2FwYnVmW09TQ19RVUVSWV9EV09SRF0gJiYNCj4gPiA+IGNhcGJ1ZltPU0NfU1VQUE9S
VF9EV09SRF0pOw0KPiA+ID4gPg0KPiA+ID4gPiAtICAgICAgIC8qIE5vdyBydW4gX09TQyBhZ2Fp
biB3aXRoIHF1ZXJ5IGZsYWcgY2xlYXIgKi8NCj4gPiA+ID4gLSAgICAgICBjYXBidWZbT1NDX1FV
RVJZX0RXT1JEXSA9IDA7DQo+ID4gPiA+ICsgICAgICAgLyoNCj4gPiA+ID4gKyAgICAgICAgKiBB
dm9pZCBwcm9ibGVtcyB3aXRoIEJJT1MgZHluYW1pY2FsbHkgbG9hZGluZyB0YWJsZXMgYnkNCj4g
aW5kaWNhdGluZw0KPiA+ID4gPiArICAgICAgICAqIHN1cHBvcnQgZm9yIENQUEMgZXZlbiBpZiBp
dCB3YXMgbWFza2VkLg0KPiA+ID4NCj4gPiA+IFdoYXQgZXhhY3RseSBkbyB5b3UgbWVhbiBieSAi
QklPUyBkeW5hbWljYWxseSBsb2FkaW5nIHRhYmxlcyI/DQo+ID4NCj4gPiBBcyBtZW50aW9uZWQg
aW4gY29tbWl0IDE1OWQ4YzI3NGZkOToNCj4gPg0KPiA+ICAgICBPbiBjZXJ0YWluIHN5c3RlbXMg
dGhlIEJJT1MgbG9hZHMgU1NEVCB0YWJsZXMgZHluYW1pY2FsbHkgYmFzZWQgb24gdGhlDQo+ID4g
ICAgIGNhcGFiaWxpdGllcyB0aGUgT1MgY2xhaW1zIHRvIHN1cHBvcnQuIEhvd2V2ZXIsIG9uIHRo
ZXNlIHN5c3RlbXMgdGhlDQo+ID4gICAgIF9PU0MgYWN0dWFsbHkgY2xlYXJzIHNvbWUgb2YgdGhl
IGJpdHMgKHVuZGVyIGNlcnRhaW4gY29uZGl0aW9ucykgc28gd2hhdA0KPiA+ICAgICBoYXBwZW5z
IGlzIHRoYXQgbm93IHdoZW4gd2UgY2FsbCB0aGUgX09TQyB0d2ljZSB0aGUgc2Vjb25kIHRpbWUg
d2UNCj4gcGFzcw0KPiA+ICAgICB0aGUgY2xlYXJlZCB2YWx1ZXMgYW5kIHRoYXQgcmVzdWx0cyBl
cnJvcnMgbGlrZSBiZWxvdyB0byBhcHBlYXIgb24gdGhlDQo+ID4gICAgIHN5c3RlbSBsb2c6DQo+
ID4NCj4gPiAgICAgICBBQ1BJIEJJT1MgRXJyb3IgKGJ1Zyk6IENvdWxkIG5vdCByZXNvbHZlIHN5
bWJvbCBbXF9QUi5QUjAwLl9DUENdLA0KPiBBRV9OT1RfRk9VTkQgKDIwMjEwMTA1L3BzYXJncy0z
MzApDQo+ID4gICAgICAgQUNQSSBFcnJvcjogQWJvcnRpbmcgbWV0aG9kIFxfUFIuUFIwMS5fQ1BD
IGR1ZSB0byBwcmV2aW91cyBlcnJvcg0KPiAoQUVfTk9UX0ZPVU5EKSAoMjAyMTAxMDUvcHNwYXJz
ZS01MjkpDQo+ID4NCj4gPiBUaGlzIGJsb2NrICBpcyB0byBhdm9pZCByZWdyZXNzaW5nIHRoYXQg
YWdhaW4gYnkgZm9yY2luZyBpdCBvbiB0aGVzZSBzeXN0ZW1zLg0KPiANCj4gV2VsbCwgdGhpcyBt
ZWFucyB0aGF0IHRoZSBjb2RlIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIHBhdGNoIGlzIG5vdA0KPiBh
Y3R1YWxseSBmb2xsb3dpbmcgdGhlIHNwZWMuDQo+IA0KPiBGaXJzdCBvZmYsIGFzIG1lbnRpb25l
ZCBpbiB0aGUgY2hhbmdlbG9nIG9mIGNvbW1pdCAxNTlkOGMyNzRmZDkgKGluDQo+IHRoZSBwYXJ0
IHRoYXQgaGFzIG5vdCBiZWVuIHF1b3RlZCBhYm92ZSksIHRoZSBPUyBpcyByZXF1aXJlZCB0byBw
YXNzDQo+IHRoZSBzYW1lIHNldCBvZiBjYXBhYmlsaXRpZXMgZXZlcnkgdGltZSBfT1NDIGlzIGV2
YWx1YXRlZC4gIFRoaXMNCj4gZG9lc24ndCBoYXBwZW4gYWZ0ZXIgdGhlIGNoYW5nZS4NCj4gDQo+
IFNlY29uZCwgYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKCkgc2hvdWxk
IHRha2UgdGhlDQo+IGNhcGFiaWxpdGllcyBtYXNrIHJldHVybmVkIGJ5IHRoZSBwbGF0Zm9ybSB3
aGljaCBpdCBkb2Vzbid0IGRvIHdpdGhvdXQNCj4gdGhlIHBhdGNoLg0KDQpSaWdodCBvbiBib3Ro
IHBvaW50cy4NCg0KPiANCj4gVGhhdCBsYXR0ZXIgcGllY2UgYXBwZWFycyB0byBiZSB0aGUgYnVn
IGluIHF1ZXN0aW9uIGhlcmUgYW5kIElNTw0KPiBmaXhpbmcgaXQgZG9lc24ndCBldmVuIHJlcXVp
cmUgY2FsbGluZyBhY3BpX3J1bl9vc2MoKSB3aXRoIHRoZSBxdWVyeQ0KPiBmbGFnIHNldCBmb3Ig
bXVsdGlwbGUgdGltZXMuDQoNCkkgdGhpbmsganVzdCB0YWtpbmcgdGhlIHJlc3VsdHMgd2lsbCBy
ZS1pbnRyb2R1Y2UgdGhlIENQQyBidWcgdGhvdWdoDQp3b24ndCBpdD8gIFNvIGhvdyB0byBhdm9p
ZCBpdCBidXQgYWxzbyB0byB0YWtlIHRoZSByZXN1bHRzPw0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+
ID4gPiArICAgICAgICAqLw0KPiA+ID4gPiArI2lmZGVmIENPTkZJR19YODYNCj4gPiA+ID4gKyAg
ICAgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUCkpIHsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGNhcGJ1ZltPU0NfU1VQUE9SVF9EV09SRF0gfD0gT1NDX1NCX0NQQ19TVVBQT1JU
Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSB8PQ0K
PiBPU0NfU0JfQ1BDVjJfU1VQUE9SVDsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICsjZW5k
aWYNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICAvKiBOb3cgcnVuIF9PU0MgYWdhaW4gd2l0aCBx
dWVyeSBmbGFnIGNsZWFyICovDQo+ID4gPiA+ICAgICAgICAgaWYgKEFDUElfRkFJTFVSRShhY3Bp
X3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4NCg==
