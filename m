Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822C837AD10
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhEKRZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 13:25:51 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:15136
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhEKRZv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 13:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ+6ofUuX3nXe0GIhjml/P7AzKID1wMD+v+4/kwOssa86SalMLjo+nu1zqd+J5j7fa5sQJWD+Gk0vVxIv2dHOXO9H9B0Mh/APvnxYNXfwou+5JyeuEJXcC8EetaW/52HrzV0hgO5j11LTmjPSWb92sPms5KylqJyHF10Iv3OV9teTtwMp0PKAjrlGAi+dvuBSUnPuO5oss54JVl6UC4jBR6nbxzFP0D+TJmmc8+8HkKosXfz02o2z/7FHyKKgp5cond/ZF7q883JbSfNO7HX17viOjXxmqEXqnS285D0iJWuyMCAghLFSQ2S1o+lbVzXeUzKJDLamgGh1u8QOZe2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdZhKYtG8sSXvzTgR276/YlF6cGVFYcGw/fx4ecvhSA=;
 b=UMv/xrSlT6WDgFaBzY1HlkRsn1kO1/z1hYF/rujPI82WoZZ+FEFVlT7wLP7+xEhilsTXEYYQ9OjyQLy3Mdb6jMPuXTL8JnTViRoqzrHOVQq6kYbJeMjV3i8LoB2U7gDpaA6Rp1FL+cDyqnrpWnqh4pN99n5kFZb6drIZkaXDu8/YaTrx/GRaTnjD//5ot3AtKeAqlqXTZIH9NTxWuOCP163DqlU91Gbc2bcJQMbe+Z6NNJY9Z7nfpkQarvfVvG0iP6BVxJbq+U/D4nf0d1fG4bXPMx/EukB6FRqttKRVy0tFCoPrG98U3j74IT5hIgZd5znKARSouJigtRLqqRjpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdZhKYtG8sSXvzTgR276/YlF6cGVFYcGw/fx4ecvhSA=;
 b=e2ewaTaz+6AyDZFec17ZCib9GHvmngd3dkGoR+1eIn/ceZQPXKFdoaqx+LCu0m94Zy4mrZf60YyTQZkZx+x+G//iyDFjPNUcZE/Q023OdGi/9r5uZJ3Ii0YMng/VwHrXPF7wpzfj6B/AH9S+X64OZFW5uvtyWrjpltXT6TyyWsE=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 17:24:43 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 17:24:43 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXRhB2PGuo7Bnw1UWLxLUelvn94KreE2SAgABSPyCAABwqAIAAASCAgAAANIA=
Date:   Tue, 11 May 2021 17:24:43 +0000
Message-ID: <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Prike.Liang@amd.com,Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-11T17:24:31Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=13668c12-1c91-4094-972e-e52f0d596402;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:5f0:f9af:d99c:b88f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d746e1c9-8ace-4a4a-0024-08d914a1aa9f
x-ms-traffictypediagnostic: BY5PR12MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB48692BA3687F4561BB9B09D3E2539@BY5PR12MB4869.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spjIhef4fRiWNa0H3/D+ru8PydwY1pa60yNNsG4+a3sA+uCMG2PFtXAdeJk0h801n7MdltlMJoBaX4fYHl/2RdkfpVkbojZysAXkFbbnxEm4N5bzrgw79RsX9z0Z8815sZYC6hyi7BemQMG+OVbZzADzAvDR8TkDdxKvVvjuiU6mZodxTaOqTlpaaV8xfl2tOOt/j0o3jVj4Lkn+5t2q0XoFBD3L968K5BmVFSvRqA3tjiRCpYQBcCcoSXHNqV/HHIJ47szPUdDYt6zyUkolskdIW6HE6crLiiKPJjFmlbfldGEkkwkqE47J7EVF3ncFkdv6RSqnsdziF5l6oiArhY+3z1neYybS4Iy424jWLj4UV5eJIgu+EnlCEYvZi4IEyRvqNPWPjZ3n9Ibjjyl6E5mXxB0RGNka6OFZiz2MYwVi0do6Evo4FG0O99RCjEGyk6rz9rXYecQc3wxofNAxor3yG2q7MKGjt/kyNf2kn8am2EREHRFGnTUMGlWjxOx4/oe+3t2FpnVx/7/7xIMVTN4KkEbpCIRi5qJmlKZMZ1OV2f0vM+j0q3ihKNDcOAFHQ6jXoJ1Bof5lyTJweRjkOiXBUpQmpqZAqLEVrU1+APb0VmGIjLz/wBeZAka+JBn8czeW4ppbod01zMtmJhnnHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(86362001)(7696005)(53546011)(6506007)(4326008)(8676002)(5660300002)(122000001)(8936002)(478600001)(71200400001)(38100700002)(2906002)(66446008)(54906003)(64756008)(66556008)(76116006)(66476007)(110136005)(33656002)(9686003)(316002)(186003)(83380400001)(66946007)(52536014)(6636002)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dE9wTldQdnRVOXRDOE02RU9XMzF6bGFOYmlwbkRteXVtS2ZTeHQvZjlsN0tS?=
 =?utf-8?B?clFLYTBobER0dlhyRWZTay9zN0ZlS2JJT1FQbGc0RmdleVRtWEhTSjdYOVN0?=
 =?utf-8?B?WS8yZ0pHUzR1WHZpNGVxaWRQL3o3N2FKeGUyTUJUS093a2lTaVVPVjZuek81?=
 =?utf-8?B?RllQd2NSRVpHYkpKcUQya09FWGtLdFUwVUpTNTY1VFFvaU5VYlFPSEZEdnNs?=
 =?utf-8?B?dVVDV096OHF0KzNpMXJGdTI3a3dSRmxBdll3V1JGdEw2WnFXYWJBTGNuaWVY?=
 =?utf-8?B?b2lkeHhCUUFNVTBLaEZ6UXBWU2ZzNjlPbFM3Zm1IMXV0T2ZQaGk4VFJWcGxC?=
 =?utf-8?B?bFEwVTZTc0thVWFERXArby9YdngzQmdsazBRVVFyWStDUEFwMGhQYTFtM2sr?=
 =?utf-8?B?UFVqSXBTYUlVbmxkM080ZmRMdHZiMnFCbWhyWk94ZStFdlliaFZxd0Y0TXZW?=
 =?utf-8?B?eFJrL29Ya2lqQW1Ba3hwd3R0WDRQYzZNMHBPckN6MWhKdzE1RU12Z0kxYk5v?=
 =?utf-8?B?OEE3SXVyS2plMEJxbkpvTjFWYVFkMFpTbmN0NitjcjRLdnVWNlFrSll2aFkw?=
 =?utf-8?B?V1RXYUpDenBIMEFWMTl1bGNtMysyc2E4Zm13WnVSaXVBWEJJM3JnS3FFa3BQ?=
 =?utf-8?B?K1ovTXNoSUxaUFduREs2QVgrT0JPamR5cnBsNWRwbjJ4TnJKZTUwU0duTmdL?=
 =?utf-8?B?bktTSEp6RzU0bFExVXBxYnpVcERVLzRCcGt5OVN2UnFXYThMdFZOdktYUkc0?=
 =?utf-8?B?VkZkbGpwNmsxMkt1dk1XSnRpTXFjdDFBb29oTGYreDB1Skh0VHkxRHJhWEEw?=
 =?utf-8?B?dSt2ZE0zVHVoNjBidmdRbG1zelpsQllBbklYR2t0cldrakJFRFhUaUVUQkpH?=
 =?utf-8?B?VUVwYUR2YWVqaEdPMHNlYkZFMWNzSDF3K25RZlZaWmdlczhnUmhyUE1Fb3NO?=
 =?utf-8?B?VkVYN2VWTzNvbmRiYzRJamFJQVk2R0lWSWM0MkdYY1ZIUFRHWlN3SFp3T1FP?=
 =?utf-8?B?alJxLzBjOXBvZWNaWksrKzhXay92WmJHNmxpRVVFV1E5cXVMOU5yOWlhR0pM?=
 =?utf-8?B?c2xUdExPWDlhUURRZXBDTlZBNmZtVHV1NWpuSTBvUEMyWktIRDV1V1dDejdK?=
 =?utf-8?B?NXRPT3RlNHoycUZHWFRJQ1JUbkdJb2tYQkpHa0dKN2FOVmRiTDI1d29wS2JL?=
 =?utf-8?B?WU9iKzgwQmRWV3pKbVl1TnZ1cXFiTFpVTGU5K0doTDkwWGZnSXlyYVJtZFRj?=
 =?utf-8?B?ODhmOWN0dlAwc0duSHlXSnpJZ2Q1LzVHd2I0eEk4SkRMbHkvZ0ludUNJcVpF?=
 =?utf-8?B?Tk5TZkx6aFhJR1NDcXgxSkpiZkpWdTQ5c0JJN25YZjdJblVMZi9OMXZzbEZC?=
 =?utf-8?B?SEtDSERTbDUyeWlZdTgyMGxKTVdUVnJSRUxEUDI4cmpHNzREZUhaUjlncFpR?=
 =?utf-8?B?RzJBdFBTeU11b2p1ZjQ3U2ZPdjJNRnQ2NTJabEg4TlFBSWM4R2tyaTVRVUVF?=
 =?utf-8?B?T3VVakdvamhUT2RJYWhHcHBmZlRWcGE4UEUxK0lWMTZHVFV3eGl3WW1mRmNn?=
 =?utf-8?B?K2c5M01QcklnZm5zMU93KzhuMFBsdC8ycERNU2xTb3ByNHhSVjZGckhLMHBs?=
 =?utf-8?B?WDRZU1B2d1hSU0lmcDdUaVJLd255NTh3UGExeGdvUURZQ3c2WWhsWHJtaWh0?=
 =?utf-8?B?a0J0YTZ6Ynh5NUNEUXpTVW9WWVdMOGlXR2s3SW9hSGs3YkEwUUpJQ0gvNGhQ?=
 =?utf-8?B?N3Z6YzdkeVZ6Z0lUWEdaWjNqM2xaa09GdnppYlk2ZHg3VWN6UXFzcHFGaW9l?=
 =?utf-8?B?TmQvNEZGYkg2QzhuQ2FRb3JPZXE3YjlKeWh4NEh3MW56NWszV3JYbEduVHZm?=
 =?utf-8?Q?G5oWujD0Nwqbh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d746e1c9-8ace-4a4a-0024-08d914a1aa9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 17:24:43.3015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Bnwnn0eELe1pa31KO/kob9InecNu/wQsMyg6KLPNv2vHuA5MSLju4STgF1IcS6voEcFQxwEVCy6r4y+lROryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCA2OjU5IFBNIFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCA1
OjIxIFBNIExpbW9uY2llbGxvLCBNYXJpbw0KPiA+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IFdlbGwsIGlmIGZpbmRfZGVlcGVzdF9zdGF0ZSgpIGxv
b2tlZCBhdCB0aGUgdGFyZ2V0IHJlc2lkZW5jeSBpbnN0ZWFkDQo+ID4gPiA+IG9mIHRoZSBleGl0
IGxhdGVuY3ksIHRoaXMgd291bGQgd29yayBJIHN1cHBvc2U/DQo+ID4gPg0KPiA+ID4gVW5mb3J0
dW5hdGVseSBJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgaGVscCAtIGZyb20gYW4gT0VNIHN5c3Rl
bSB0aGUNCj4gZm9sbG93aW5nDQo+ID4gPiB0YXJnZXQgcmVzaWRlbmN5IHZhbHVlczoNCj4gPiA+
DQo+ID4gPiAjIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWlkbGUvKi9yZXNp
ZGVuY3kNCj4gPiA+IDANCj4gPiA+IDINCj4gPiA+IDgwMA0KPiA+ID4gNzAwDQo+ID4NCj4gPiBC
dXQgdGhpcyBtZWFucyB0aGF0IG5vdCBqdXN0IFMwaXgsIGJ1dCBjcHVpZGxlIGluIGdlbmVyYWwg
ZG9lc24ndCB3b3JrDQo+ID4gY29ycmVjdGx5IG9uIHRob3NlIHN5c3RlbXMgYW5kIHRoZSBsYXRl
bmN5IHF1aXJrIGRvZXNuJ3QgaGVscCBoZXJlLg0KPiA+DQo+ID4gV2VsbCwgaXQgbG9va3MgbGlr
ZSB0aGUgZHJpdmVyIG5lZWRzIHRvIHNvcnQgdGhlIEMtc3RhdGVzIHRhYmxlLCB0aGVuLg0KPiAN
Cj4gQnV0IHRoYXQgd291bGRuJ3QgaGVscCwgYmVjYXVzZSB0aGUgNzAwIHVzIGlkbGUgc3RhdGUg
aXMgaW4gZmFjdCBkZWVwZXIsIHJpZ2h0Pw0KPiANCj4gQXJlIHRoZSB2YWx1ZXMganVzdCBzd2Fw
cGVkIG9yIGFyZSB0aGV5IGNvbXBsZXRlbHkgYm9ndXM/DQoNCkFjdHVhbGx5IEkgdGhpbmsgdGhl
IHZhbHVlIHNldCBpbiB0aGUgT0VNIEJJT1MgZm9yIHN0YXRlMiBmcm9tIExQSSBsb29rcyBib2d1
cyB0b28uDQpJdCBzaG91bGQgaGF2ZSBiZWVuIDM2dXMuDQoNCkBMaWFuZywgUHJpa2UgYW5kIEBE
ZXVjaGVyLCBBbGV4YW5kZXIgeW91IGhhdmUgc29tZSBtb3JlIGhpc3Rvcnkgb24gdGhpcw0KdGhh
biBJIGRvLg0K
