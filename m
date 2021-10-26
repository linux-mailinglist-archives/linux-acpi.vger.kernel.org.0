Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64F43B9BA
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhJZSlF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:41:05 -0400
Received: from mail-dm3nam07on2054.outbound.protection.outlook.com ([40.107.95.54]:10235
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235794AbhJZSlE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf7+qTAoJO1gPDvQonzqHzvAtJ0UHk+0Z+BoKoRUDKSVA+DCpfFmyFmfXiPbMOnkU8tLEVMgQG6HLSyqhVhE/Qm0DRgmUTVnNnwSTFuHyfptJYoJ1+c+0HdUxr+sAs5flHpCohUhUY7jJX0HknnnTm+ThU8tgkwTdgfxtV5pOuhSXmUGrA41WTlcxeS6TW3cVQyQwFbzXWlnqVBINpmJYWutWuiVa0lCyD9R3uDLZIfqTFud3vaumiKFRNqJcacyqnhKY6MklRSsJYt+0sqag3YRxM5GjM94zh+HluR6i/csFNdxylUCHshiRmu07EzQCyUvNlgMEQLie8Ic8fP1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN2t0UFfDrH0ZtaFRSHlWUxxoTjoNZndzU9S1hV8V9U=;
 b=Edwv5ADDGZIJw8mpsEHZ+1V18Wl8JZuXQMr0vzt1f8w5sDWR594nGu3wUc5JgrHh08PDZPxVZQkVCfdbQ4nt50I8c5maoj7Wo9e0dyIMBOxjK3SPtQbxADpg5YXoOd1LatdW7gsvJDWOhvXxQ3os1+1N1ROIkRCu28Vp/r3+/padLDPwQg1GFfnQJZpmpBubx/ROTjtJk7AvgaqXPmf65mKYrY+6jn+m/uaWe1pEpLYbc6kQrzVBLDSdLgi46skFV2PdHOpyu0vy6QwohypX6WsIQJhUCiNPLyfrt1WXjS6wszj+6qIA9tDtkxZY3nRE2+gGaI6xvCIa3zvCUj+u8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2t0UFfDrH0ZtaFRSHlWUxxoTjoNZndzU9S1hV8V9U=;
 b=HloZkFHsYZ3cmM40yXgi8IAJCdhCMK1kBKTV4ACWS3n4xG/phknziE72u6Hibmf6ZiG+vgt2CnX48mH9jdbnQwzL5fENj0kSnhtiSdXue4huE/8CNII9TBVW4jNXrKlg3Llxc6YExrB/MEU6BxGHroqeTAMliLmd3nZ0hdcnpvw=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 18:38:35 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4628.018; Tue, 26 Oct 2021
 18:38:35 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support for
 notification chains
Thread-Topic: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support
 for notification chains
Thread-Index: AQHXypQdQ8zuZQAM5kC+K14GdI5IOavlm4YAgAAAM7A=
Date:   Tue, 26 Oct 2021 18:38:35 +0000
Message-ID: <SA0PR12MB4510745D300C9E3239EACA00E2849@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
 <20211026180535.9096-4-mario.limonciello@amd.com>
 <9a4ef81f-a064-31c0-d52a-42f79b12191f@lenovo.com>
In-Reply-To: <9a4ef81f-a064-31c0-d52a-42f79b12191f@lenovo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-26T18:38:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=74c1a200-8a56-4e39-873c-6e40969c5880;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lenovo.com; dkim=none (message not signed)
 header.d=none;lenovo.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72b0e904-edee-4887-36c1-08d998afd1e9
x-ms-traffictypediagnostic: SN1PR12MB2509:
x-microsoft-antispam-prvs: <SN1PR12MB25096A331F3B842ACF9EEAD0E2849@SN1PR12MB2509.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zws13fgIrBKL/w3X+SMQuPpZwX5PYnsKeB3aFYLeNHTNkEJEdcowDQAugoaPhtqO2IzuCjs7ve4h+Dj+bHm24GFTvyoTQDuLYQAoqJp1642tEegTMfln4KI6GCd5MWKi1J6aJEWdTm2cy5SvbisEhbYRz7ZVEoBQgvM3+vrq5yRcISMYwEudUx87E8cux2+jw/gi9YfhVyPJi61ftcbukyyJSSnUlgm7PlZ+NaVH/NAbH5qbDsYSe0/qFOIDgtd2qHNgHN1rIV6dsLO37GaPeSdm0ZEFLcOJEoaFYwVuiSRXueOial05b/gpNN98vHcz1M5DtmNhKkCKCTC9O/R8joH7LYNsb0Pq4hy6kHZhxT9OXGymEQo80rckXVA3t4H6qW3ZB0BSy+60YpQhxvYnUfbqZ8U/cX0FL7ND2ub7jXP0VjVpXUPm4pRf8r3+8l9rJmMtJWPK5y/KUksAFXlitkpKgW4bj87KVyOEjqorhl5nC+FOLjr6JEBLIfVIoUk3hQ9NTRlh7U9vJLgOWPrgY+MKvC78A1oDTy0QHApdVVllyzRriIAG4GCLpFVkYgVQiIjQrSim13RxfxWIDWHO/Q5UCLwlmiF/UzgscMCLF0HCHUc6V/+NMZLLAJ3GUD+237nNerNfB5Cm094nVwIiyvjDh9nlnxFf26hmghixMtpbVF+J47VgZiVm65WPjsahzFBmjeMM3zw0CT00r5GInA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(38070700005)(53546011)(66946007)(15650500001)(66446008)(66556008)(5660300002)(76116006)(86362001)(186003)(7696005)(4001150100001)(64756008)(26005)(83380400001)(54906003)(6506007)(71200400001)(33656002)(316002)(8936002)(9686003)(2906002)(55016002)(8676002)(508600001)(122000001)(66476007)(110136005)(38100700002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTl1dEd0QUY1TVhQTDNJdXBjc08ydTkvZjFUYlRBZndXTXY2RUFuenRQbnVE?=
 =?utf-8?B?S1NpUlNBMDNDKzRwcFlNdEF3S2ZHRVRjSVFuUGx3bEpjdGtoTDVjbzRWRTNx?=
 =?utf-8?B?UitDRmJVQTh1ZVAya1lpQkRqZ1RleTlzVmdNYVdSeFN5VGxRNEpmcm5LRnZm?=
 =?utf-8?B?QVVDQytYRStJc0ZFMnNxa2RZT3VpNVg2WlBlSnpiMFVKc01Dd29VeGtqbEtw?=
 =?utf-8?B?U2VyQ200WHVhMkRteXdRRVFFK3A4Qy92OGpyVG00YjNMMWIxd1YrblczOTJH?=
 =?utf-8?B?UDVCUXRFZGQ5NW05K3lNVUpOTzBjTFdDUGlEVmNjc3NQRFBwRG9RT21zRDhy?=
 =?utf-8?B?QVRRbkowTnZ2dG5BR1Y4cHZlU1lPSGwwanN6UlA4VzNhbFBhanI3SWREcGx6?=
 =?utf-8?B?dlNRcUliVmQ4VnpqNzR2V01HU3hOSlplaXR4aG1ERjhmRHAyMTJyVmJuWlBI?=
 =?utf-8?B?UzRQWlcwWHFVTkYzNFpTWXZoV0dPRjV2ZFVwSnpoWU5Tc3RGKzdzUFNycHJI?=
 =?utf-8?B?OXYzZXJMS3RwamJTcHBPRVYxcGR0OGxZSHRqQUFadXA5MkFwLyt0T0ZRejE5?=
 =?utf-8?B?TzhJTGMwWURXSC85Y29Pa1RXYzV3TTdCSXdVRlR1SFBkN0RzOEY3bC9mQ1l6?=
 =?utf-8?B?Q21aajlnTE8zRUZ1VW1CNExKSC9FUWhqUkRDbmZNQnhSMXJUcy9JUzFjQmZi?=
 =?utf-8?B?ejRjYmZGMmV5YlJaSVZGdDBEVEEyU2p4VUM5YVRLOUcycytyYmlHSXBxV1FV?=
 =?utf-8?B?TDFXbGlMM1dqS1JCNHg2QlZFeVFCT2FuNWdQamMzNlRxTVc0d3hXeHFPM2pZ?=
 =?utf-8?B?ck1rM3pTNzhTdTZYVUdZcnpiMnlDeFBYOVN6TzhYcVlJS3RpRHBsek1ENTBm?=
 =?utf-8?B?VklRaW9YRXY2NXIyV3pFWVU0Sm9nN1k1RUYzVlgxM01CbnRGeC9WV3lGWlBK?=
 =?utf-8?B?TGE5enNvckEyOUsxcDFCaXRPcDk2NUhtYnYybFpUM1c5OE1vUHBiN3NZazBM?=
 =?utf-8?B?YTc4R3A5aHFqVU54NnRsemZWQ2JITUZjZlNYYVBWa1dranJuaG0yTFBwbHhZ?=
 =?utf-8?B?ZUpKWnh3MlFlUWR3Y1V5b1FLSGN1WUlEVXZuMGljM3NGcElXMGRkVFpXRmRG?=
 =?utf-8?B?NEdXbWIrWVNHY05laWZEaHh3OVlJZzZWZ0daYTlWeWFHZlovV3JCbHZsMGN1?=
 =?utf-8?B?amtrTEJkQ3RNa1I0cjJLTUdjMUNsRHFjYno4N0J4b3ljMzNLeTBpNkNQb1VN?=
 =?utf-8?B?akNoQlRGdGFWM200OE94RzE1MGJYR01OUy9acDhXQXErOHBsYlFFRGU1WXdD?=
 =?utf-8?B?Q3Nma25DeU1ZTmJLU2I1dmhDdDNaWkVuVjQrV1NPRlpxUGJEbUVLM0M0N1Jp?=
 =?utf-8?B?Mmh1T3B5b1ZleGFRbWMzeG80Q0oweE9yV1dIOWVDcnlYSFBvcXRvWXZLZjBw?=
 =?utf-8?B?YWlObmw2VkhjUXdWMThWT0dNYmdEcnJtVWFTSUx3K3JLeGhFRUdyN2ljMFZ3?=
 =?utf-8?B?amNJamR5QWUvZzZReFJZQW1EUWVXaVo2aWtGQ1dTMkpwcGNJOG9PVkJWSkV5?=
 =?utf-8?B?TnRYeUFEVTVzWkEvV3pmRFRIa0ZBN2kxejFYMWlUYVFXUEwwd2J5ZXNUQW9r?=
 =?utf-8?B?M1BPWHZiVVVMT1dTMjFCcndVRVcxNDFyTnU0aStMekJsUjhPQ3MxeHEzQ3Zk?=
 =?utf-8?B?MUpLTjNVaGFyTDZmTmo2dTZDZHJmbFFCMWZYVGpHTWltMVhwM1JLaFRkU3hl?=
 =?utf-8?B?T0JmSjVBNTBVN0NWWno1dko2a0hVeWNqNG9lVTJxcEp1cHRBc2tYTkNWczZG?=
 =?utf-8?B?YXVmbVQxdml0dVBhVHBYVDVpb3pidldWR3NsTmg1U29tYzd1NmRDdTg3UUZv?=
 =?utf-8?B?TGYwc3ZUdU5kalMzbW9pVEpqcTE4UDQra3htdW5aZTdsOVVzdGYrV0pKMFRt?=
 =?utf-8?B?cWxZb293SzBSTzJ4VThFbk5JOUNmZ2cvTUdKZmdwYUViZTF0M1E3cC8yMzQ4?=
 =?utf-8?B?NGJsRFlVOXlobjYyNU9qUWY2V3o1dzNyOXk0alNXa3luMmxvNkJyTUtLamN6?=
 =?utf-8?B?aGtyTlcrdW5TZk9TV1hFT2lSMHZaSjhIRXpXQ0dYQkRLcHNhcDFQb3dqK0d0?=
 =?utf-8?B?QjVKbmtIQ1ZkaVlDS2dyUUVMK3FIZXBMNllpbjBVQ0xyVFNxeVNiTzQ0WnAv?=
 =?utf-8?Q?LztG8bca/1L6h4prraYv0uI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b0e904-edee-4887-36c1-08d998afd1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 18:38:35.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1ChZAkBVvgvYK/xgOgOoiH/zs1Zc75Cz8n3xoHmmrbiy2FQ9fujOSJkWasMF08l7cE+Yz8YWOuhdyVbibV7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFBl
YXJzb24gPG1hcmtwZWFyc29uQGxlbm92by5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
MjYsIDIwMjEgMTM6MzYNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJr
IEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsgUmFmYWVsIEogLg0KPiBXeXNvY2tpIDxy
andAcmp3eXNvY2tpLm5ldD4NCj4gQ2M6IG9wZW4gbGlzdDpYODYgUExBVEZPUk0gRFJJVkVSUyA8
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1hY3BpQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSBbUEFUQ0ggdjMgMy8zXSBBQ1BJ
OiBwbGF0Zm9ybV9wcm9maWxlOiBBZGQgc3VwcG9ydCBmb3INCj4gbm90aWZpY2F0aW9uIGNoYWlu
cw0KPiANCj4gVGhhbmtzIE1hcmlvLA0KPiANCj4gUGF0Y2ggc2VyaWVzIGxvb2tzIGdvb2QuIE9u
ZSBtaW5vciBzdWdnZXN0aW9uIGJlbG93Lg0KDQpUaGFua3MgTWFyay4gIFdoYXQgZG8geW91IHRo
aW5rIG9mIHRoZSBvdGhlciBpZGVhIEkgaGFkIGluIG15IGNvdmVyIGxldHRlcj8NCkkgdGhpbmsg
dGhhdCdzIGFub3RoZXIgd2F5IHRvIGRvIHRoaXMsIHRoYXQgbWlnaHQgbWVhbiBsZXNzIHN1cmdl
cnkgdG8gdGhpcw0Kc291cmNlIGZpbGUgYW5kIG90aGVyIGZ1bmN0aW9uIGNhbGwuDQoNCkknbGwg
cmUtc3BpbiBpdCBlaXRoZXIgdG8gYWNjZXB0IHlvdXIgc3VnZ2VzdGlvbiBiZWxvdyBvciB0aGUg
b3RoZXIgaWRlYSBJIHB1dA0KaW4gdGhlIGNvdmVyIGxldHRlci4NCg0KPiANCj4gTWFyaw0KPiAN
Cj4gT24gMjAyMS0xMC0yNiAxNDowNSwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4gQWxs
b3cgb3RoZXIgZHJpdmVycyB0byBpbml0aWFsaXplIHJlbGF0aXZlIHRvIGN1cnJlbnQgYWN0aXZl
DQo+ID4gcHJvZmlsZSBhbmQgcmVhY3QgdG8gcGxhdGZvcm0gcHJvZmlsZSBjaGFuZ2VzLg0KPiA+
DQo+ID4gRHJpdmVycyB3aXNoaW5nIHRvIHV0aWxpemUgdGhpcyBzaG91bGQgcmVnaXN0ZXIgZm9y
IG5vdGlmaWNhdGlvbg0KPiA+IGF0IG1vZHVsZSBsb2FkIGFuZCB1bnJlZ2lzdGVyIHdoZW4gdW5s
b2FkaW5nLg0KPiA+DQo+ID4gTm90aWZpY2F0aW9ucyB3aWxsIGNvbWUgaW4gdGhlIGZyb20gYSBu
b3RpZmllciBjYWxsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8g
PG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2FjcGkv
cGxhdGZvcm1fcHJvZmlsZS5jICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
DQo+ID4gICBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX3Byb2ZpbGUuaCB8IDEwICsrKysrKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGxhdGZvcm1fcHJvZmlsZS5jIGIvZHJp
dmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYw0KPiA+IGluZGV4IGQ0MTg0NjJhYjc5MS4uMjI1
MjQ3ZWZhNTVmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9wbGF0Zm9ybV9wcm9maWxl
LmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvcGxhdGZvcm1fcHJvZmlsZS5jDQo+ID4gQEAgLTIx
LDYgKzIxLDI0IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgcHJvZmlsZV9uYW1lc1tdID0g
ew0KPiA+ICAgCVtQTEFURk9STV9QUk9GSUxFX1BFUkZPUk1BTkNFXSA9ICJwZXJmb3JtYW5jZSIs
DQo+ID4gICB9Ow0KPiA+ICAgc3RhdGljX2Fzc2VydChBUlJBWV9TSVpFKHByb2ZpbGVfbmFtZXMp
ID09IFBMQVRGT1JNX1BST0ZJTEVfTEFTVCk7DQo+ID4gK3N0YXRpYyBCTE9DS0lOR19OT1RJRklF
Ul9IRUFEKHBsYXRmb3JtX3Byb2ZpbGVfY2hhaW5faGVhZCk7DQo+ID4gKw0KPiA+ICtpbnQgcGxh
dGZvcm1fcHJvZmlsZV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5i
KQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gYmxvY2tpbmdfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIo
JnBsYXRmb3JtX3Byb2ZpbGVfY2hhaW5faGVhZCwNCj4gbmIpOw0KPiA+ICt9DQo+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKHBsYXRmb3JtX3Byb2ZpbGVfcmVnaXN0ZXJfbm90aWZpZXIpOw0KPiA+ICsN
Cj4gPiAraW50IHBsYXRmb3JtX3Byb2ZpbGVfdW5yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90
aWZpZXJfYmxvY2sgKm5iKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4NCj4gYmxvY2tpbmdfbm90aWZp
ZXJfY2hhaW5fdW5yZWdpc3RlcigmcGxhdGZvcm1fcHJvZmlsZV9jaGFpbl9oZWFkLCBuYik7DQo+
ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwocGxhdGZvcm1fcHJvZmlsZV91bnJlZ2lzdGVy
X25vdGlmaWVyKTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHBsYXRmb3JtX3Byb2ZpbGVfY2Fs
bF9ub3RpZmllcih1bnNpZ25lZCBsb25nIGFjdGlvbiwgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+
ICsJYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbigmcGxhdGZvcm1fcHJvZmlsZV9jaGFpbl9o
ZWFkLCBhY3Rpb24sDQo+IGRhdGEpOw0KPiA+ICt9DQo+ID4NCj4gPiAgIHN0YXRpYyBzc2l6ZV90
IHBsYXRmb3JtX3Byb2ZpbGVfY2hvaWNlc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAg
IAkJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gQEAgLTQ5LDExICs2Nyw4
IEBAIHN0YXRpYyBzc2l6ZV90IHBsYXRmb3JtX3Byb2ZpbGVfY2hvaWNlc19zaG93KHN0cnVjdA0K
PiBkZXZpY2UgKmRldiwNCj4gPiAgIAlyZXR1cm4gbGVuOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0
YXRpYyBzc2l6ZV90IHBsYXRmb3JtX3Byb2ZpbGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ID4gLQkJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gLQkJCQkJY2hhciAq
YnVmKQ0KPiA+ICtpbnQgcGxhdGZvcm1fcHJvZmlsZV9nZXQoZW51bSBwbGF0Zm9ybV9wcm9maWxl
X29wdGlvbiAqcHJvZmlsZSkNCj4gPiAgIHsNCj4gPiAtCWVudW0gcGxhdGZvcm1fcHJvZmlsZV9v
cHRpb24gcHJvZmlsZSA9DQo+IFBMQVRGT1JNX1BST0ZJTEVfQkFMQU5DRUQ7DQo+ID4gICAJaW50
IGVycjsNCj4gPg0KPiA+ICAgCWVyciA9IG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgmcHJvZmls
ZV9sb2NrKTsNCj4gPiBAQCAtNjUsMTUgKzgwLDI4IEBAIHN0YXRpYyBzc2l6ZV90IHBsYXRmb3Jt
X3Byb2ZpbGVfc2hvdyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsDQo+ID4gICAJCXJldHVybiAtRU5P
REVWOw0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JZXJyID0gY3VyX3Byb2ZpbGUtPnByb2ZpbGVfZ2V0
KGN1cl9wcm9maWxlLCAmcHJvZmlsZSk7DQo+ID4gKwllcnIgPSBjdXJfcHJvZmlsZS0+cHJvZmls
ZV9nZXQoY3VyX3Byb2ZpbGUsIHByb2ZpbGUpOw0KPiA+ICAgCW11dGV4X3VubG9jaygmcHJvZmls
ZV9sb2NrKTsNCj4gPiAgIAlpZiAoZXJyKQ0KPiA+ICAgCQlyZXR1cm4gZXJyOw0KPiA+DQo+ID4g
ICAJLyogQ2hlY2sgdGhhdCBwcm9maWxlIGlzIHZhbGlkIGluZGV4ICovDQo+ID4gLQlpZiAoV0FS
Tl9PTigocHJvZmlsZSA8IDApIHx8IChwcm9maWxlID49IEFSUkFZX1NJWkUocHJvZmlsZV9uYW1l
cykpKSkNCj4gPiArCWlmIChXQVJOX09OKCgqcHJvZmlsZSA8IDApIHx8ICgqcHJvZmlsZSA+PSBB
UlJBWV9TSVpFKHByb2ZpbGVfbmFtZXMpKSkpDQo+ID4gICAJCXJldHVybiAtRUlPOw0KPiA+DQo+
ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwbGF0Zm9ybV9w
cm9maWxlX2dldCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBwbGF0Zm9ybV9wcm9maWxl
X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICsJCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KPiA+ICsJCQkJCWNoYXIgKmJ1ZikNCj4gPiArew0KPiA+ICsJZW51bSBwbGF0
Zm9ybV9wcm9maWxlX29wdGlvbiBwcm9maWxlID0NCj4gUExBVEZPUk1fUFJPRklMRV9CQUxBTkNF
RDsNCj4gPiArCWludCByZXQgPSBwbGF0Zm9ybV9wcm9maWxlX2dldCgmcHJvZmlsZSk7DQo+ID4g
Kw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAgCXJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgIiVzXG4iLCBwcm9maWxlX25hbWVzW3Byb2ZpbGVdKTsNCj4gPiAgIH0NCj4g
Pg0KPiA+IEBAIC0xMzAsOSArMTU4LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRl
X2dyb3VwDQo+IHBsYXRmb3JtX3Byb2ZpbGVfZ3JvdXAgPSB7DQo+ID4NCj4gPiAgIHZvaWQgcGxh
dGZvcm1fcHJvZmlsZV9ub3RpZnkodm9pZCkNCj4gPiAgIHsNCj4gPiArCWVudW0gcGxhdGZvcm1f
cHJvZmlsZV9vcHRpb24gcHJvZmlsZTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICAgCWlm
ICghY3VyX3Byb2ZpbGUpDQo+ID4gICAJCXJldHVybjsNCj4gPiAgIAlzeXNmc19ub3RpZnkoYWNw
aV9rb2JqLCBOVUxMLCAicGxhdGZvcm1fcHJvZmlsZSIpOw0KPiA+ICsJcmV0ID0gcGxhdGZvcm1f
cHJvZmlsZV9nZXQoJnByb2ZpbGUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm47DQo+
IA0KPiBBcyBubyByZXR1cm4gdmFsdWUgdG8gZnVuY3Rpb24gdGhlbiBzaW1wbGlmeSB0bzoNCj4g
CWlmIChwbGF0Zm9ybV9wcm9maWxlX2dldCgmcHJvZmlsZSkpDQo+IAkJcmV0dXJuOw0KPiANCj4g
PiArCXBsYXRmb3JtX3Byb2ZpbGVfY2FsbF9ub3RpZmllcihQTEFURk9STV9QUk9GSUxFX0NIQU5H
RUQsDQo+ICZwcm9maWxlKTsNCj4gPiArDQo+ID4gICB9DQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQ
TChwbGF0Zm9ybV9wcm9maWxlX25vdGlmeSk7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9wbGF0Zm9ybV9wcm9maWxlLmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX3Byb2Zp
bGUuaA0KPiA+IGluZGV4IGU1Y2JiNjg0MWYzYS4uMDViYTM0MDM1MDlhIDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fcHJvZmlsZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9wcm9maWxlLmgNCj4gPiBAQCAtMTEsNiArMTEsOCBAQA0KPiA+DQo+ID4g
ICAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4NCj4gPiArc3RydWN0IG5vdGlmaWVyX2Js
b2NrOw0KPiA+ICsNCj4gPiAgIC8qDQo+ID4gICAgKiBJZiBtb3JlIG9wdGlvbnMgYXJlIGFkZGVk
IHBsZWFzZSB1cGRhdGUgcHJvZmlsZV9uYW1lcyBhcnJheSBpbg0KPiA+ICAgICogcGxhdGZvcm1f
cHJvZmlsZS5jIGFuZCBzeXNmcy1wbGF0Zm9ybV9wcm9maWxlIGRvY3VtZW50YXRpb24uDQo+ID4g
QEAgLTM3LDUgKzM5LDEzIEBAIHN0cnVjdCBwbGF0Zm9ybV9wcm9maWxlX2hhbmRsZXIgew0KPiA+
ICAgaW50IHBsYXRmb3JtX3Byb2ZpbGVfcmVnaXN0ZXIoc3RydWN0IHBsYXRmb3JtX3Byb2ZpbGVf
aGFuZGxlciAqcHByb2YpOw0KPiA+ICAgaW50IHBsYXRmb3JtX3Byb2ZpbGVfcmVtb3ZlKHZvaWQp
Ow0KPiA+ICAgdm9pZCBwbGF0Zm9ybV9wcm9maWxlX25vdGlmeSh2b2lkKTsNCj4gPiAraW50IHBs
YXRmb3JtX3Byb2ZpbGVfZ2V0KGVudW0gcGxhdGZvcm1fcHJvZmlsZV9vcHRpb24gKnByb2ZpbGUp
Ow0KPiA+ICsNCj4gPiAraW50IHBsYXRmb3JtX3Byb2ZpbGVfcmVnaXN0ZXJfbm90aWZpZXIoc3Ry
dWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7DQo+ID4gK2ludCBwbGF0Zm9ybV9wcm9maWxlX3VucmVn
aXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7DQo+ID4gKw0KPiA+ICtl
bnVtIHBsYXRmb3JtX3Byb2ZpbGVfbm90aWZpZXJfYWN0aW9ucyB7DQo+ID4gKwlQTEFURk9STV9Q
Uk9GSUxFX0NIQU5HRUQsDQo+ID4gK307DQo+ID4NCj4gPiAgICNlbmRpZiAgLypfUExBVEZPUk1f
UFJPRklMRV9IXyovDQo+ID4NCg==
