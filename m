Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11648B40F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbiAKRd2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 12:33:28 -0500
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:6177
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344602AbiAKRcw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 12:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFTF6vCPQXlOnK2T8cADq8evgwHlNPQAAIFZmvW0OUDTs4vEYTEVB2zIT50GjmifUtM3sga+C7a5F7LZ4EeGIFJCu9TmU9Dmeyjqq2lDCujIPTv2qU68MzCWfqoMWEFVEXSE6r/hZWuX1/hEe+64upYz4Al6DZqpg4Q+wtEDL0Of7uz9q/Y7/LQ1ePk3STE0vZAoDYtY8RrBpeicXl0TwusSLa2bIUVwBjgcy1voj1IwGSDcGI+FQdIE1Ng+8nLoH4K/o13r8++OSfw1UqAijfP8nmWulVbV9V7mm8gTQ8KcvHD4GkO22a3VtXwOezhY+b7qqrXzgXuH560rTEq3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJIsa/NGgh7nixTz8S42ricyLEnSacVLFgDBBWLQElU=;
 b=atWHwBPvtIg6YWAxx1Couho+Mczrwdeb3GCckoXDCua65xIFYalxTyUOtIlRYRL+ixEiRpiwJgQQJl/4oMtj3HAEJRDehH7ZbJN6yM9RIkWQ/oIiglsd2DkDB0iMFmvdgA47brn1wztGP9YSpZF0hphtZSvy8hkNt/8tfkAF4DuawcIfYK/jd1P/bO9prRCUsIjs4osd7rEijao28KBJ4uq9bSBmytuIAxYDmAJFGPO+seYB7hOS8aAbB2vDVuIZ364K7BaAbwCYZNfJwvQhp3O7D8nG3ySTktrViKm7r4ZE95nL9rvJ+NCqf6N4LV7Azx1/R1fhvMherGVIkaICbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJIsa/NGgh7nixTz8S42ricyLEnSacVLFgDBBWLQElU=;
 b=Y0ah8xLsYUkTTkzkEemkjub0hCnV/y0ECPwUdt8oVGRxkMcZlsJkTYQKjHxqcBJpFx/JZ1+xkeBaB4KYTHYjFom12SaoNKwN6ZUwdA5bXbAO9VqCsYxnlON+xSGfu0gyQ/eWOjMrGdeL7r4HiWgxU/Ll6djk3D79UwkbUFOVUKs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 17:32:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:32:50 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bjoern.daase@gmail.com" <bjoern.daase@gmail.com>
Subject: RE: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Thread-Topic: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Thread-Index: AQHYBwebi6CSE600EUuOx4ACt7owGqxeDN4AgAABUMA=
Date:   Tue, 11 Jan 2022 17:32:50 +0000
Message-ID: <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
 <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T17:10:24Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=629d73d2-82db-41e6-ba7e-91726e0fa714;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-11T17:32:47Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8b0997fe-1f95-4ef1-9703-d5e0f029eec7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 991501ad-50a5-43a1-90dd-08d9d5286445
x-ms-traffictypediagnostic: BL1PR12MB5157:EE_
x-microsoft-antispam-prvs: <BL1PR12MB515712E0682D4D175B518F6FF7519@BL1PR12MB5157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ml2pvGK3+5JQUYh+jla53UKH9x95LhASarU3mIaVaB1TwKsUXULFKZNELU5VjyyNNk5B3fI0gNB9sGXAceQzlvTzJcMli7wSkrDnVS72Z4wRW0JahqDio+QbTl+HWuvbXSAo3SxMuFbvDmjnnyiaqPCcy6hT8jlO4uxF2QEMkeXV+0cBVu+epivrFeRa/EBFEV6QQgmfeTPnoZaOht56CdVxiLMmPmOzfpR+U7pDRELBo7ydrFqXcQS4f2Sj1/zsXWwd7JbUOMIMvD1vtAfanDXrGstcWC3NlMZOF+zmzRysbzc4PiyAxoTXwakDvqlA0Wdtn6aaPFTEfvcF6BDe35DXReDS7bzR7D1UQ2xQYUK+73VFoIPLAA7xGuyH+q6AP6eMXkNSGEE+q0Ki9yWwgfLQ5Pp/or0z7VCVvMWXp1PcKRtlpIGU6Fpz8/t5J1HJokzXc+oVtW42lRynqCY6BjoNtJCmTrcJHwCthM95K/0w5H5CmnsG1nJmDrV85RN1/iWHBQJ9Cs8f1oN7g2UtuVOtpJtwVK2/Sf19nq2V41WpIaedA+98dGjJ3gXn3THgJFrnNKja6fsE5v0fSwFD6b6UQNkxO40Yjk+uFocA9bNYvOfR9aRge4HbuV7cJ+me7HETNMKgfegsFINCU2d67yVosHTenCQs55LRNRErFHzceCopoG0yq5nC59p8fMioLr3d+DGYmwOFrfYOHrDw4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2906002)(110136005)(54906003)(7696005)(52536014)(508600001)(5660300002)(66556008)(316002)(64756008)(66446008)(38070700005)(86362001)(6636002)(4326008)(76116006)(8676002)(38100700002)(53546011)(26005)(71200400001)(8936002)(122000001)(33656002)(55016003)(83380400001)(9686003)(66946007)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE1zZkVBbzc2cCtWcUhvTEdqbUhVMDBWaEZUd2ovZElKeDlkMzdjblVYTDNY?=
 =?utf-8?B?OHB5bDdSYU9sQXRxZVJoVHl1VjJtcjB5ZnJhNCszaVA3aHhaUUZTWTI3R2d0?=
 =?utf-8?B?S3B6Nk96NHRLZUZhRGp1MldqZXJJV0duVmN3VjlRbTFtWGUvTHorZm8yWVJN?=
 =?utf-8?B?dmZvMHRBWDh2RE1RdFBrL2p4bjRablFuVHVMM200enIrWHVBaGRiUk80S2J6?=
 =?utf-8?B?SVNBSUs5N2hrSFYzMEdrcFRlME1IdnZSclkwUGhWQUNNSmpWSk1vS2swVUNw?=
 =?utf-8?B?NDVOOExlRU9SOEplK21XUFc3UG9Sa0ZQK3FScHhBdGdZaXVFcEJXMEpEMUp1?=
 =?utf-8?B?aXlDNzlhRndqbXRDQ1BvaFBCSWV3TzFrUmRWVXQvQzEyeGkxK3RkU2lXT3Bj?=
 =?utf-8?B?OU9iQkRmODhSTnBBSTc2RFRXei80c2lGZVdja2pSc0tvandnbnV6YlJoYUc1?=
 =?utf-8?B?VzR5SVRJSDk1QUhkQ1lkK3cxVHJHd2p1RnZzdzJtTCsyMit0NnprOEhZcko3?=
 =?utf-8?B?RzEzZjBEaW9nM3lxMC9iZHRLQndXZ3ZNN2lkemVwUFRsRUUxUnZiM3F6K2pW?=
 =?utf-8?B?djUrZFF3bG5Ec1NlK2JkQ1ljZkkzZU8vb3VCZTByOWRDTVF3clp6RHhnd25t?=
 =?utf-8?B?ZUlIeXE0cmVVMzFWT3hMK0lGbDNNT1ljY0RlVXlRU3k0ckMvcEptbXJGbFBG?=
 =?utf-8?B?VFk1WU5LNkFuMlZLN0hwTlBZSEpsSjlkVm93bkFFUDR3NkRyb3FGbVFpcXhj?=
 =?utf-8?B?eTMweFZMdldGVG1SM3M2Rk5GQlJNQVROTEErcUtUVU9hN3IrTXdQZ0paUXpW?=
 =?utf-8?B?aE0zbEVFb2czRC9pMDdSS1JqZ2EzOVg0ZVVkVGhMa281L1pJODErQ1lRWHA4?=
 =?utf-8?B?YUlkM2tIRGNzNEY3K3lwbmxmOEpNU2VvTUFPT0RrNVMydk9OR1lBSmNaYlBI?=
 =?utf-8?B?S3NoRVRhdkJxdGtUQWhEZ2pueTBibHh6eENUY0FnSXd4Um93cXhZTGdrb0NV?=
 =?utf-8?B?dmFxWW9UY3AzenNPRW55Z2E5N3ZDZlB0aStxd1ZoZGxsRk1lb1VUeUE3cC9t?=
 =?utf-8?B?WTg0a2NnVm5QOENyR09QRGZnU2pLMXhaQnhkb05XcWl5SGYrMnFudGJ6MFU4?=
 =?utf-8?B?bTliNHlnSUFubXNUdy95OElJVytkYmtsWTFJbklxMm1YdGlyWFZqK1p5MTRG?=
 =?utf-8?B?a3RhWnNuQ1pYbHhnTmM2SUtjYk9CU0hmNzJPZU9Mb2RNSWRSdU5MQ1FML05p?=
 =?utf-8?B?RE9WQ0IzbzhKVlFtWllOQTF5cVVuNjlzdjQrdUtZSTdjTE1JdzBsSXZLL2lQ?=
 =?utf-8?B?ZmxIcFk0Rm1RUWdDOWFJK2lpSHo5Q0xDYnZzelRXNVY3dXo2VGpLSEtYTUUv?=
 =?utf-8?B?Yk44YmJYckNKS1BCcUYvejRXM2xzaG9iSno0N1d5K1RSQVpNcjc4aXNVd05z?=
 =?utf-8?B?b1NGNGRHY0xPQllDOWhRRk82d2wzbDRLMXlQV1lNYlQ2S0gxRk0yZ244UmhK?=
 =?utf-8?B?bmhTR1FMS0hPc0c3b3d1NytmZW42cFJhVUFsVzRiM29KQkpST1Q4RFBBVTRV?=
 =?utf-8?B?YUg4TVlPOFRFL1p2eEJXUG1ZK2tJa3ZhVERDQSsxTnpFYnlYMEFGNXZpVzVv?=
 =?utf-8?B?MXA1K2c2NDdqNlNramdlM3oxd1lFUXd1aTdNTWNPV2duZGREYnlHOWZ6UXRt?=
 =?utf-8?B?WW9lbVhjSWVMMmd4a2U1R3ZnUXUwVXZLbjRyalpGeXQ1dFdpZnQ0ZkttczFu?=
 =?utf-8?B?ZGU0bnVTcThUZ2k0clZMeDVOeXdqZWRUUEpOUFAyeDNBcEk3QlRWSmtuSFQy?=
 =?utf-8?B?ZWJ6dDNBdTBhQkJORENFeGRrcGNpdkI5QWNpUTNhTWlvZXZiZ0kvZjU0cytP?=
 =?utf-8?B?N0pWWWNqSko5V3NDVlk4L21CUGxsejV0M3ErbzdtTmtsdXlUQlprWUNiUzEy?=
 =?utf-8?B?dVovSitpT1p4cStLbW5hMEhhNkNtbk13d3RWRVhKR0ovdzdEM1liYzh2cXJh?=
 =?utf-8?B?cmFYWnBsOWFva001c3RES0N5TnF3QmFpWjZXSmtqNU1QejlmTmVRKzNiak9j?=
 =?utf-8?B?S1JkaTRuSUdLRmlGRG1RcVpIMXl0Q0JDdXVZMXNtRmdTcm8wazdCVDN2N25Q?=
 =?utf-8?B?a2g0RnhJbWgyTHkxRXE3NXZiL3ZMcm4vQVovVzIyQUdiSlN1NDFrQzA1T1p4?=
 =?utf-8?Q?uDZM3c5yVIWRF25DtyHw3xg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991501ad-50a5-43a1-90dd-08d9d5286445
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 17:32:50.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub+sFs7qXM9pK6GKiyZ3DZEfel9TP8I0GCq4SA+oyY7jizuLj9hO6ghr46/mZqFm+GfG1H0FrEsO/8gSJ2lbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1
ZXNkYXksIEphbnVhcnkgMTEsIDIwMjIgMTI6MDYgUE0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJp
byA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxy
YWZhZWxAa2VybmVsLm9yZz47IFJhZmFlbCBKIC4gV3lzb2NraQ0KPiA8cmp3QHJqd3lzb2NraS5u
ZXQ+OyBBQ1BJIERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47
DQo+IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlhbS1zdW5kYXIuUy1rQGFtZC5jb20+OyBOYXRpa2Fy
LCBCYXNhdmFyYWoNCj4gPEJhc2F2YXJhai5OYXRpa2FyQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBiam9lcm4uZGFhc2VAZ21haWwu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBPbiBBTUQgcGxhdGZvcm1zIG9ubHkgb2Zm
ZXIgczJpZGxlIHcvIHByb3BlciBGVw0KPiANCj4gT24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgNToy
MyBQTSBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gK0FsZXgNCj4gPg0KPiA+IE9uIDEvMTEvMjAyMiAwOTo1MiwgUmFmYWVs
IEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEphbiA1LCAyMDIyIGF0IDg6MzkgUE0g
TWFyaW8gTGltb25jaWVsbG8NCj4gPiA+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90
ZToNCj4gPiA+Pg0KPiA+ID4+IEN1cnJlbnRseSB0aGUgTGludXgga2VybmVsIHdpbGwgb2ZmZXIg
czJpZGxlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlcg0KPiA+ID4+IHRoZSBGQURUIGluZGljYXRlcyB0
aGUgc3lzdGVtIHNob3VsZCB1c2Ugb3Igb24gWDg2IGlmIHRoZSBMUFMwIEFDUEkNCj4gPiA+PiBk
ZXZpY2UgaGFzIGJlZW4gYWN0aXZhdGVkLg0KPiA+ID4+DQo+ID4gPj4gT24gc29tZSBub24tQU1E
IHBsYXRmb3JtcyBzMmlkbGUgY2FuIGJlIG9mZmVyZWQgZXZlbiB3aXRob3V0DQo+IHByb3Blcg0K
PiA+ID4+IGZpcm13YXJlIHN1cHBvcnQuICBUaGUgcG93ZXIgY29uc3VtcHRpb24gbWF5IGJlIGhp
Z2hlciBpbiB0aGVzZQ0KPiA+ID4+IGluc3RhbmNlcyBidXQgdGhlIHN5c3RlbSBvdGhlcndpc2Ug
cHJvcGVybHkgc3VzcGVuZHMgYW5kIHJlc3VtZXMuDQo+ID4gPg0KPiA+ID4gV2VsbCwgdGhlIGlk
ZWEgaXMgdGhhdCBzMmlkbGUgc2hvdWxkIG5vdCByZXF1aXJlIEZXIHN1cHBvcnQgYXQgYWxsLg0K
PiA+ID4gPg0KPiA+DQo+ID4gTWF5IEkgYXNrIC0gd2h5PyAgSXQncyBhbiBpbnRlbnRpb25hbCBk
ZXNpZ24gZGVjaXNpb24/DQo+IA0KPiBZZXMsIGl0IGlzLg0KPiANCj4gPiA+IEl0IG1heSBub3Qg
YmUgcG9zc2libGUgdG8gcmVhY2ggdGhlIG1pbmltdW0gcG93ZXIgbGV2ZWwgb2YgdGhlDQo+ID4g
PiBwbGF0Zm9ybSB3aXRob3V0IEZXIHN1cHBvcnQsIGJ1dCB0aGF0IHNob3VsZCBub3QgcHJldmVu
dCBzMmlkbGUgZnJvbQ0KPiA+ID4gYmVpbmcgdXNlZC4NCj4gPiA+DQo+ID4gPj4gT24gQU1EIHBs
YXRmb3JtcyBob3dldmVyIHdoZW4gdGhlIEZXIGhhcyBiZWVuIGNvbmZpZ3VyZWQgbm90IHRvDQo+
ID4gPj4gb2ZmZXIgczJpZGxlIHNvbWUgZGlmZmVyZW50IGhhcmR3YXJlIGluaXRpYWxpemF0aW9u
IGhhcyBvY2N1cnJlZA0KPiA+ID4+IHN1Y2ggdGhhdCB0aGUgc3lzdGVtIHdvbid0IHByb3Blcmx5
IHJlc3VtZS4NCj4gPiA+DQo+ID4gPiBUaGF0J3MgcmF0aGVyIHVuZm9ydHVuYXRlLg0KPiA+ID4N
Cj4gPiA+IENhbiB5b3UgcGxlYXNlIHNoYXJlIHNvbWUgZGV0YWlscyBvbiB3aGF0J3MgZ29pbmcg
b24gaW4gdGhvc2UgY2FzZXM/DQo+ID4gPg0KPiA+ID4gVGVjaG5pY2FsbHksIHdpdGhvdXQgRlcg
c3VwcG9ydCB0aGVyZSBzaG91bGQgYmUgbm8gZGlmZmVyZW5jZQ0KPiA+ID4gYmV0d2VlbiB0aGUg
cGxhdGZvcm0gc3RhdGUgcmVhY2hhYmxlIHZpYSBzMmlkbGUgYW5kIHRoZSBwbGF0Zm9ybQ0KPiA+
ID4gc3RhdGUgcmVhY2hhYmxlIHZpYSBydW50aW1lIGlkbGUuDQo+ID4NCj4gPiBEdXJpbmcgcmVz
dW1lIHRoZXJlIGlzIGEgbnVtYmVyIG9mIHBhZ2UgZmF1bHRzIHRoYXQgb2NjdXIgYW5kIGR1cmlu
Zw0KPiA+IGluaXRpYWxpemF0aW9uIHRoZSByaW5nIHRlc3RzIGZhaWwuICBUaGUgZ3JhcGhpY3Mg
aXMgdW51c2FibGUgYXQgdGhpcw0KPiA+IHRpbWUgYXMgYSByZXN1bHQuDQo+ID4NCj4gPiBUaGUg
YW1kZ3B1IGNvZGUgYWN0dWFsbHkgKmRvZXMqIGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlIDMgZGlm
ZmVyZW50DQo+ID4gY2FzZXMgb2YgUzMsIFMwaXgsIGFuZCBydW50aW1lIHN1c3BlbmQuDQo+IA0K
PiBCdXQgczJpZGxlIGRvZXNuJ3QgZ3VhcmFudGVlIFMwaXggaW4gYW55IGNhc2UuDQo+IA0KPiA+
IFRoZSBmdW5jdGlvbiAiYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUiIGNhdXNlcyBkaWZmZXJl
bnQgY29kZXBhdGhzDQo+ID4gdG8gYmUgdXNlZCBkdXJpbmcgdGhlIHN1c3BlbmQgcm91dGluZS4N
Cj4gDQo+IFdlbGwsIGFzIEkgc2FpZCwgczJpZGxlIG5lZWQgbm90IG1lYW4gUzBpeC4NCj4gDQo+
ID4gSW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UgdGhhdCBGQURUIGRvZXNuJ3Qgc2V0IHRoZSBsb3cg
cG93ZXIgaWRsZSBiaXQNCj4gPiBhbmQgdGhhdCBmdW5jdGlvbiByZXR1cm5zIGZhbHNlIG1lYW5p
bmcgdGhlIHMzIGNvZGVwYXRoIGlzIHRha2VuIGJ1dA0KPiA+IHRoZSBoYXJkd2FyZSBkaWRuJ3Qg
Z28gdGhyb3VnaCBhIHJlc2V0Lg0KPiANCj4gSWYgdGhlcmUgaXMgYSBzZXBhcmF0ZSBTMyBjb2Rl
IHBhdGgsIHRha2luZyBpdCB3aGVuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlDQo+ID09IFBNX1NV
U1BFTkRfVE9fSURMRSBpcyBpbmNvcnJlY3QuDQo+IA0KPiA+IEl0ICptaWdodCogYWxzbyBiZSBw
b3NzaWJsZSB0byBzb2x2ZSB0aGlzIGJ5IG1hbmRhdGluZyBhbiBBU0lDIHJlc2V0DQo+ID4gaW4g
c3VjaCBhIGNhc2UgKHdlIGRpZG4ndCB0cnkpLg0KPiANCj4gSSdkIHJhdGhlciBkbyBhIFBNLXJ1
bnRpbWUgcGF0aCBlcXVpdmFsZW50IGlmIHRoZSB0YXJnZXQgc2xlZXAgc3RhdGUgaXMNCj4gUE1f
U1VTUEVORF9UT19JRExFIGFuZCB0aGVyZSBpcyBubyBGVyBzdXBwb3J0IGZvciBTMGl4Lg0KPiAN
Cj4gPiBIb3dldmVyIGl0IGNvbWVzIGJhY2sgdG8gbXkgZmlyc3QgdXBsZXZldmVsZWQgcXVlc3Rp
b24gLSBpcyB0aGlzIGENCj4gPiBjYXNlIHdlIHJlYWxseSB3YW50IHRvIHN1cHBvcnQgYW5kIGVu
Y291cmFnZT8gIFRoaXMgdHlwZSBvZiBidWcgYW5kDQo+ID4gY29tYmluYXRpb24gb2YgY29kZXBh
dGhzIGlzIG5vdCBhIGNhc2UgdGhhdCBpcyBnb2luZyB0byBiZSB3ZWxsIHRlc3RlZC4NCj4gPiBU
aGlzIHBhdGNoIHNlcmllcyB3aWxsIGFsaWduIHRoZSBrZXJuZWwgYmVoYXZpb3IgdG8gb25seSB3
aGF0IEFNRCB2YWxpZGF0ZXMuDQo+IA0KPiBCdXQgdGhpcyBkb2VzIG5vdCBmb2xsb3cgdGhlIGRl
ZmluaXRpb24gb2YgczJpZGxlIGFuZCBpdHMgZG9jdW1lbnRhdGlvbi4NCg0KQXQgbGVhc3QgZm9y
IGRldmljZXMgaW50ZWdyYXRlZCBpbnRvIHRoZSBTb0MsIHRoZSBwb3dlciByYWlscyBhcmUgY29u
dHJvbGxlZCBieSB0aGUgZmlybXdhcmUgaW4gdGhlIFNvQy4gIEZvciBTMywgdGhlIHBvd2VyIHJh
aWxzIGFyZSBjdXQgYnkgdGhlIEZXIHdoZW4gdGhlIHBsYXRmb3JtIGVudGVycyBTMy4gIEZvciBT
MGl4LCB0aGUgcG93ZXIgcmFpbHMgYXJlIGN1dCB3aGVuIGFsbCBvZiB0aGUgZGV2aWNlcyBvbiB0
aGUgcmFpbCBzdXNwZW5kZWQgYW5kIHZhcmlvdXMgY29uZGl0aW9ucyBhcmUgbWV0LiAgQWxzbywg
aW4gdGhlIGNhc2Ugb2Ygc29tZSBkZXZpY2VzLCB0aGUgZGV2aWNlIGhhcyB0byBiZSBpbiBhIHZl
cnkgc3BlY2lmaWMgc3RhdGUgZm9yIHMwaXggdG8gd29yayBwcm9wZXJseS4gIFRoZSBHUFUgaXMg
dGhlIGJpZyBvbmUgaGVyZS4gIEZvciBTMywgdGhlIGVudGlyZSBHUFUgaGFzIHRvIGJlIHJlLWlu
aXRpYWxpemVkIGF0IHJlc3VtZS4gIEZvciBTMGl4LCB0aGUgR1BVJ3Mgc3RhdGUgaXMgbGFyZ2Vs
eSBoYW5kbGVkIGJ5IHRoZSBmaXJtd2FyZSBhbmQgYXR0ZW1wdGluZyB0byByZS1pbml0aWFsaXpl
IGl0IHdvbid0IHdvcmsgdW5sZXNzIHlvdSByZXNldCBpdC4gIEludGVncmF0ZWQgQU1EIGdyYXBo
aWNzIGRvbid0IHN1cHBvcnQgcnVudGltZSBwb3dlciBtYW5hZ2VtZW50LCBvbmx5IGRHUFVzIGRv
LiAgRm9yIGludGVncmF0ZWQgZ3JhcGhpY3MgdGhlIGZpcm13YXJlIGR5bmFtaWNhbGx5IGNvbnRy
b2xzIHRoZSBwb3dlciBhdCBydW50aW1lIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZG8gYW55dGhp
bmcgc3BlY2lhbCBmb3IgcnVudGltZSBwbS4gIEZvciBkR1BVcyB3ZSBzdXBwb3J0IGQzY29sZCBl
aXRoZXIgdmlhIEFDUEkgb24gcGxhdGZvcm1zIGxpa2UgYWxsLWluLW9uZXMgYW5kIGxhcHRvcHMg
b3IgdmlhIGEgZHJpdmVyIGluaXRpYXRlZCBzZXF1ZW5jZSBmb3IgYWRkLWluLWNhcmRzLg0KDQpX
aGF0IGRvZXMgUzJpZGxlIHVsdGltYXRlbHkgZG8gd2hlbiBhbGwgZGV2aWNlcyBoYXZlIHN1c3Bl
bmRlZD8gIERvZXMgaXQgZW50ZXIgUzBpeCBvciBTMyBhdCB0aGUgZW5kIHdoZW4gaXQgd2FudCB0
byB1bHRpbWF0ZWx5IHN1c3BlbmQgdGhlIHBsYXRmb3JtLCBvciBpcyB0aGUgYXNzdW1wdGlvbiB0
aGF0IGlmIGFsbCBkZXZpY2VzIGhhdmUgc3VzcGVuZGVkLCB0aGUgdGhhdCBpcyBlcXVpdmFsZW50
IHRvIFMwaXggb3IgUzM/ICBGb3IgQU1EIHBsYXRmb3JtcywgZWl0aGVyIFMzIG9yIFMwaXggbmVl
ZHMgdG8gYmUgZW50ZXJlZCBmb3IgdGhlIHBsYXRmb3JtIHRvIGFjdHVhbGx5IHBvd2VyIGRvd24g
bW9zdCBvZiB0aGUgcG93ZXIgcmFpbHMuICBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHdlIHNo
b3VsZCBkbyBmb3IgczJpZGxlLg0KDQpBbGV4DQo=
