Return-Path: <linux-acpi+bounces-2608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53681DE6E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Dec 2023 06:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91454B20FA3
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Dec 2023 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB7CED7;
	Mon, 25 Dec 2023 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="we+S4ye7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277E10FE
	for <linux-acpi@vger.kernel.org>; Mon, 25 Dec 2023 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQAlf0TwU1mKyj80ai+yCtz7MbWz9vlhAPQnxj9odc/7ytnGdNBvyvMuBFj7IUeQFqPGns1QA/lgFWdE3G6HIkRzDv7q7ZwI+/7gJ04K0COJe1OpivU6fHSt4QZGa8y8jD8Lp3cZQox3xfj/FxXqEdnT8tmWiiDfdG2i1r0+nSeOUuNH3SluSOUapo/ro0scJIU0F+m/1Vjs52iIcj13sTCyVpqJ+uujSHyuI/M5cpFlpuWz11nLWpLEfh8ljU1lpMirDsUAR7VZBYAgTLgXoPH2MLmRYunIwpH6gcwmLR27PVyIkrT1fTW22KSmaj2MSMHijFoSRxYpDN8IDR4QgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdJSr7uEGrcI30tB/WmRUL0wXqO/gWZGIIz8+0ATUvw=;
 b=f9lcq4HfUbWuBCCGyFwJbv1wxSvcileFgJyz85pElYxm+dGif3AFd6UzuoGP5XeU5VDR+hFYFkK1B8LCnXVBDXlGzT7JQSCSuMdJ6752R8RauYO8cLTgsTWn9Qr5iuiMiIuSmfuv5mHiT8LW6O/P+18vSnYqIOmobGySwxz1X00CUaatdgO2lysTdtzGID70PQPVFsfy6RG8AyJkx9BQXl0cWtqXhLHemHFOFoFK+LgHldwBTtIyDcUtmUxRgM7+TajKhLcC7qu9JXHz4mxk1Hfw3xcfLLhdMu6dbI07wF1Zg4/GwTs2aaxq+mGVM6n2hOOzHo02LI9xf8sv9YLnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdJSr7uEGrcI30tB/WmRUL0wXqO/gWZGIIz8+0ATUvw=;
 b=we+S4ye7hhIPyNGuEIQqIhnpXKYQvn3Cfuz6UZx/eekan2jU4faYqav01n4KqdezTypkMXEsZSb6AukdJiZPgEpla7q+S+VreGWH2tBLiZjlvVUPAKirQIqSNG2Qt7YS4Nrq6aCcFND9V3JPZSS1QfgFamVdR7aqW1BUqIUq76c=
Received: from PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 05:56:42 +0000
Received: from PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::e2ad:75e9:8638:43ef]) by PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::e2ad:75e9:8638:43ef%7]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 05:56:42 +0000
From: "Xue, Ken" <Ken.Xue@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"cwhuang@linux.org.tw" <cwhuang@linux.org.tw>
Subject: RE: [PATCH V5] acpi: trigger wakeup key event from power button
Thread-Topic: [PATCH V5] acpi: trigger wakeup key event from power button
Thread-Index: AQHZ+POnGOlpOVOIi02tdL9bTidFyLC0QRAAgAWPIRA=
Date: Mon, 25 Dec 2023 05:56:41 +0000
Message-ID:
 <PH7PR12MB697848C0386F2B9420F49105FB99A@PH7PR12MB6978.namprd12.prod.outlook.com>
References: <20231007075433.555715-1-Ken.Xue@amd.com>
 <CAJZ5v0ioghNbRXO=N1zVqksP6J=0ubfULLCoad_4A=Mz2F9UoA@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0ioghNbRXO=N1zVqksP6J=0ubfULLCoad_4A=Mz2F9UoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a55d0aa8-fc14-4609-9291-0e7fb59702e5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-25T03:18:36Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6978:EE_|LV2PR12MB5967:EE_
x-ms-office365-filtering-correlation-id: 4421170c-d7e5-4a50-d97f-08dc050e448e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ftcvqMpgV5o4xmNIiMD3iP6rvVxvIiNRsC4PTKTIEkVzxWN7zozTeft4ozFTcaX/h2BP8I3NUnLoTcB9dV4P61LA7kbeRNYGRk0oZyMIgqejU38ZNmDeNmbszM4a6jwfAaBKkQ0mY8HA63Ecs3xwapUxNn0utTUVIK80YSy8P538A3zxBCGYt/qw90kD2D3svFp1TfgMZuYjSJ+/pTk/q//PSkvpOGm4XDfrQsPGOgVCIU9D/+rTYBZpKjaho7H7zbKJlNgHfzwcM+kK6OwHUAAI/3BzxwktyN8A5lgQCM+q/iu7DwxyHhUBH5rxHuOu0oa5ow0wTesDDV4aelibNfo7kyV5MXi7oHXvrnG75C50cxMRECTT4hUXpXKzaBKZFzV7kpPsZdER4SfkRW4Ze60i4DZivSv9UCK26O0lCLXxg3uMkubb2wBYM9H8XcaawYSxH1h8leOR6CfNL/SMubJSMNq7ghC9Ca8ixl3qwYQXcM0OF0orAKu6UJmo2tMfaRuQiBHAZD5QF5wSCdwoRsmLTZ3YurEoP1MA9DtWpDGs5ph7hMJfl5yoV88jTIVWKu5pMXYcrNl5b2d6h+ALgMjGc5kAy3Vpp0QLE9kC9jhsmbjICvl6Ef5TDazk4M5e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6978.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(52536014)(8936002)(5660300002)(2906002)(4326008)(4744005)(478600001)(9686003)(66946007)(6506007)(7696005)(66556008)(76116006)(66446008)(66476007)(54906003)(316002)(6916009)(64756008)(41300700001)(38070700009)(122000001)(38100700002)(55016003)(26005)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUNjUTFyWW56VHFaYnJmRUdqQzZ5OTZVbnVzU0xYSXJmOVVHOWlYMEsvRklB?=
 =?utf-8?B?UFZCbHNiZFhCaEptUEN6d1hpTCs5azRKWUJ1U1FRbFJIZVEzQ0ExdlVPZHhs?=
 =?utf-8?B?VWx2b1M2OUd3bTlkNnM0UzJ3TUJDOVpsU1VRZUgvbGV5WkFTWnVCUmxsTFNI?=
 =?utf-8?B?aWpyemlDVlYrZTBWL0svdFNwRHdjYVk3d2JOb2FYb3FRVksvVkVOL3FSMDJp?=
 =?utf-8?B?S1N4Umt4dGJPZFh0aWFGKzlkdTJuVEE5SXlwSng1eTVMZnBRaFFURExhWlVO?=
 =?utf-8?B?MVdpb0xjSDhNQWhCQ1h6RGFrTVRoVzFTbFNkamtyc0UwQktmQW55a244RHV5?=
 =?utf-8?B?bExNbHAvWTJGZ3Q1bDZmTGZVOFM5L3p4cjJkRVBYajNoZFJUcXRET0JSYlQz?=
 =?utf-8?B?RXlsZlA5K2dvTy82YWJMVmNHRHE2K0ZFU1FsVzFKRzdtWHZJQ0J1b0x4OGkv?=
 =?utf-8?B?TGRvZjFGRkNNSTdOeHBHUEtSbHJPdDNYeVFGWTJZUG93cFFDWUlXeVRONkM0?=
 =?utf-8?B?SGEzZ2tvMXI1cVhGR1RGVnZ1TFdzNHRiaWhkY3AxbXBlM3NkdFVwSzBhMU9z?=
 =?utf-8?B?ZzlMUlh3SlNteC8vdVNQSEROU1UwZlhrWDlQcXJ6b3gwQndjTDMxTlIxeWxo?=
 =?utf-8?B?QmVrNFRxVllpVkZWaTFneVhZZ1JyTllYd2dKbG5lVkFENVN0M2x1RE54Zllp?=
 =?utf-8?B?UFpjOEROSUgwY2k4clZjM1IxVHc2SlViZXhEYm1hMVhZY0F4UUVKdFVDN0My?=
 =?utf-8?B?ZnZrVk9zQklKSFpIOEJGU0phWjZZMmJNOXFQendtUHFwVmR1UE9kTzNLaEZq?=
 =?utf-8?B?OVhUeGVxSWk4ZjBXYjMzOVRPc0gyUU9YcmhhbTJjbm5QUC9NV0hZTDNHSjhF?=
 =?utf-8?B?VExlbTNiS0djUEFSMTVNZnhhakFvNUhQWnhZbjZKTlJkNHU3S3VQZEJpZWpl?=
 =?utf-8?B?UGpXWHlWQ2lhTFlKTkYzcCsrSmpmRmpEZGZwZ1VTTjRHcnlpQjk2QXlUa1J2?=
 =?utf-8?B?YUlIQUFiWmw1UXFLdHIwdkxMb3Q5UWFROGRQRkVHN25CNC95c1RuWlRYS2Uz?=
 =?utf-8?B?MkFqNjlUU2x0VzdYVXQwTGFSV1ZRa2RNZjJnYzAwN0NJZDV1ck0rRFJxU2Fw?=
 =?utf-8?B?RWhTY0Y4dWhvZkVrRC9SalVuR0lMU3gzamxNM04zQjNGbXdlRmhCUDQzeWQ1?=
 =?utf-8?B?ZTBZUDdZOTh6bE56YjIzdHVYTCtkR3BZaHZ5SmZTc3pObU85YVZINGMzYWRF?=
 =?utf-8?B?UEdCN3lTRWhHa00vYWEzL3c0UFVGdm1ZamNEYVhSbmdjYmNjYXdzenludDNY?=
 =?utf-8?B?Tk1kcGFzNGJCWGN4MnBPSG9aaXdXVHhUNFpQS2FvS1pOMWxtVlBQeERqOTF6?=
 =?utf-8?B?d01JR0lLWW1jeEh2N2F4dUg4L0pnZnNPanRvMlVZTWRDejhUR0R5TWZBRkZ2?=
 =?utf-8?B?Tll0by9zR1pCdCtIN0xVZ2g3YWNwTmxMbnZQVllrWEhuZXpRZ3YvVEk2U2h0?=
 =?utf-8?B?ZWdIM2RiRStVMFlEZk9IRmtSYUF4YWtzVnBveXFIbUZETjNXeWpQeEZkVXk3?=
 =?utf-8?B?emprVkpSTHU3b2p3bGVEUXlQY05FcGNIeldNMGdNNnpTK2pEVDBvLzhWbmg5?=
 =?utf-8?B?MVZHb3ZtT3E0YklqMEpLL0pNRDVkRllFaFljSzNMRWdVcDV6clpSRkdwclRl?=
 =?utf-8?B?eEhpM1ZrYktacnRMdW0zWmJyY2lvWDVZNVJBd2ozQThNRXhQZkRUa3lucEZE?=
 =?utf-8?B?OVdPdzE1dUpnYXdHVmZ1YWd5VVRmS0lLc2U2SFppQzlEOWtEeGtPREJ0U2lQ?=
 =?utf-8?B?YXZoa3BHVGhoRHA3Q3JzeGZaUzc2OXQ1cjdlWGFjQ1ZyV1RFNkt6TzI4Q3dV?=
 =?utf-8?B?WWdnc0h0YXJtUmc0QTVTNTROaEhvQ2dJU0dhUGd1RUg1N3FpOGVrSUQ0bTkw?=
 =?utf-8?B?ODZTbHFSaDdPd3FkK1NnYjQzTEc5SVQrL2haMFh5THNmWUY0am9XdmxnbWN3?=
 =?utf-8?B?ZFVjazZwdWJWOUM2UzVaMTFkUy92UUVTeDUyME1hRC9vbmc2UGpvY3dBaUp5?=
 =?utf-8?B?bWhhSnV1dnUyS1JNVkVrVEdyWWVlZGxtcndkckQ4SVNESjM0Qkx5engwbU9T?=
 =?utf-8?Q?9kI4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6978.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4421170c-d7e5-4a50-d97f-08dc050e448e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 05:56:41.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgXYtLjdLm1Qtjcd1LU3SUffq5V9+HnL6lbLnMI5MhPN3nb7pg/6bMSIKnIOn5c3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gPiAgI2luY2x1ZGUgImludGVy
bmFsLmgiDQo+ID4gICNpbmNsdWRlICJzbGVlcC5oIg0KPiA+DQo+ID4gQEAgLTUwNyw2ICs1MTEs
NyBAQCBzdGF0aWMgdm9pZCBhY3BpX3BtX2ZpbmlzaCh2b2lkKQ0KPiA+ICAgICAgICAgcHdyX2J0
bl9hZGV2ID0NCj4gYWNwaV9kZXZfZ2V0X2ZpcnN0X21hdGNoX2RldihBQ1BJX0JVVFRPTl9ISURf
UE9XRVJGLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVUxMLCAtMSk7DQo+ID4gICAgICAgICBpZiAocHdyX2J0bl9hZGV2KSB7DQo+ID4g
KyAgICAgICAgICAgICAgIGFjcGlfcG93ZXJfYnV0dG9uX3dha2V1cChwd3JfYnRuX2FkZXYpOw0K
Pg0KPiBXaHkgZG9lcyB0aGlzIG5lZWQgdG8gYmUgZG9uZSBmcm9tIGhlcmU/DQo+DQo+IENhbid0
IHRoZSBidXR0b24gZHJpdmVyIGl0c2VsZiB0byBpdD8NCltLZW5dIFRoYW5rcyBmb3IgcmVtaW5k
aW5nLiBJdCBkb2VzIHdvcmsgaW4gYnV0dG9uIGRyaXZlciBpdHNlbGYgdG9vLg0KVGhpcyBwYXRj
aCBqdXN0IHRyaWVkIHRvIG1ha2Ugc3VyZSAid2FrZXVwIiBldmVudCBpcyByZXBvcnRlZCBhZnRl
ciBwd3JfYnRuX2V2ZW50X3BlbmRpbmcgYmVjb21lcyBmYWxzZSBieSBhZGRpbmcgY29kZXMgaGVy
ZS4NCkJ1dCBpbiBmYWN0LCBSZXBvcnRpbmcgIndha2V1cCIgZXZlbnQgaW4gYnV0dG9uIGRyaXZl
ciBpdHNlbGYgYWxzbyBjYW4gc3VwcG9ydCBzYW1lIHNlcXVlbmNlLg0KSSB3aWxsIHN1Ym1pdCBh
IG5ldyBwYXRjaCBsYXRlci4NCg==

