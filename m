Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE64BC51E
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Feb 2022 04:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiBSDCH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 22:02:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiBSDCG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 22:02:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83B3E0D3
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 19:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etg7SH4FTFwXHzf3nHj1OF51C1TwCPHH6HitrYcel1xGCDjVVdDvrixaNYt/fyR874mZtlKI9u0Yvjyd8Ya1uc6HIj2aLwT7A+jxG9Ix0Yr9dP7JsbROLrhMSh08sHDWhP16HI+SkhZgrKNU81f4cdevK3Dgrn2SWYalKUvluJX8TdZDxHuSXnCC+42JkRxyZ81qSlTxHbzpbL810BlvPlYbE+WQKrVH1yZWRLB/WEwrTt7pVdVULI3nztwX9XM9urkzy4ApZ6cHRY3w5trAsdaOvtxodk/nNxu1ffvG3h1CEozzTN3bcK3xzTpUjTh8k4UPxc26pPBMG0G4ARB6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KAo35BdG2A3EJ42JIjYzBOikykt7sKN9yPRt+IpOhg=;
 b=gm/WctRXcA7egOG0AC22CWx/Yiuhew6khStuDOkSzpeFMT6W2EHgfTj7fMaKJLlZ5SUp0nsSbbTZy69X1zKLXBUSXqYxZLxFkxrWH+rpwwDydecEIPzaFMwuxIPi+mxs2FZHg8nG5WunPGPpkcUsb6r8Fdip8UfaoyDhGjNPFzOEU0LAIWFyoW3CJ3QlQnwbMtAylNS0MkT2PXz2kdDA7LZ0H4KcateUt9FPG0rxaiR9VAY3jeThoLxhUEJwDJxKLAilUu11AQ1UGlqe0l5RtRrYx7i7mIY4R53ahgE3+6UOm1DzpIQRjEYQebRHWdS7l4w1wPIYUgeIqFbC+sK6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KAo35BdG2A3EJ42JIjYzBOikykt7sKN9yPRt+IpOhg=;
 b=q4oRHEZvgOY78iKO2vqnAHKLbZNk70glAuMhLv4/EKktEENbLnRfM7OYHbAhqmAAxgl1tGvhKpMQeuKyh3YbfpItaqhvHlLK+h2YoRYMQqwpDANfsFLqtPrgZSFKrYXlAR0KFJBkPg8UeO67yKLw3Z9HxuTM9pthlAF1cfLqjcY=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1819.namprd12.prod.outlook.com (2603:10b6:3:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 03:01:42 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.024; Sat, 19 Feb 2022
 03:01:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: Regression in 5.16-rc1 with suspend to idle
Thread-Topic: Regression in 5.16-rc1 with suspend to idle
Thread-Index: AdgjxKRqoif+H8GDSFuptXvIhGhWMAAJ0i2AAAqAH3AAMzUMAAAESZ8AABIh2uA=
Date:   Sat, 19 Feb 2022 03:01:41 +0000
Message-ID: <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-19T03:01:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a88f88ac-aac5-41db-884e-2845135aa4e2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-19T03:01:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2c7b0276-159c-4040-ad82-f965c748dc07
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68bf714b-e66a-4464-d83c-08d9f35427d6
x-ms-traffictypediagnostic: DM5PR12MB1819:EE_
x-microsoft-antispam-prvs: <DM5PR12MB181982AE54E18390B39E8D65E2389@DM5PR12MB1819.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JV1YwIsyKbugRn6O8rmQrInmuINRfrOJRVufm78tYOvjAw9k8iPfLimx4h7aiV3ar1BBahYpf3eUDQzgZ+P6R5ZJCbhYx8d6p6PT6A90QgNRgYA+oaUURslV/Xeg5suuTeE7KSiMI+dl/FEtx65vjAtdSchNNOfPVvo5eZRGnoLF56kuWf6YIpXIneOsd9/86hiZ/MS6SYnHHmrQ0bjj1Ba1eVhC/8ccU1Qih5GNfostGsgI5j4oAhv7S/h0oJZ4DmbFC51TyW1/ZbCQ/dANmQ7jG4pEB8KT/eEeLRrc0OffIvMY6CBLASOPYHWPiEsmJMVndl33rgE3nip1K8xhDTsftu1OdwvFFG18rWsNC3003usoBzGCf8jMU4Q6ROO0lsSXlR0TDI25NL4KE1ZRufoqBa68l3MOb5gNgsq6gLJ8aso7DnIQ/qQduj+K3RWjFt5ElC7TlGp9pyhBG3soyWYifLkU6rVWE+WfkAOEw8EwE0AKidFzrrPGUvu/zA37jzXL8MM1PUVFE2RF3ImBb9ZbIXXcvHQ/H+P+bCW83saSVghUTxkTFUPk375X+pBUmzUzTV1WB5xQnhJyAcD3hC5ofv/iwYY8p991vGhMfpguS5Zpi61phBg0iwM1I2X5Ek6AnxlnhWS26vAA7Dm4UeFTAgo6SyZd2oC2GZNl3UwAWxtcpNw41Iwt5l7SwVpi6W+zaFDYGvWB8S5jlT8iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(7696005)(6506007)(54906003)(52536014)(8936002)(508600001)(71200400001)(6916009)(9686003)(33656002)(86362001)(83380400001)(8676002)(4326008)(76116006)(66476007)(66946007)(66556008)(66446008)(64756008)(186003)(2906002)(15650500001)(38070700005)(55016003)(122000001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNBcHNpTnVWNTF1aFhMT1JwUDBHN1BGUmhJS1R5R2haY3J3RGtMdld0WjlZ?=
 =?utf-8?B?eTQ5VHVRbFkydE4zeTVhMkdRcXJ0Q1M4WjNXNWRrTGdoa0R3ZVdaZVhyWDlr?=
 =?utf-8?B?SFN1NUFvRkJ3NjdTanhMRVVaZmZoQlFrQkJtZlEvMmZFRXVTR2NtNTcrSjRN?=
 =?utf-8?B?dVp4QzNHVHNaYzVIbVl2NmUvMWhNeWw0ZHhRa2Q1V1Q1b2lrelhVS1IzSXNm?=
 =?utf-8?B?YThqaFFYSDlzc1ZnaklkYTg2dGhnQjczLzY3bWU3UFdRbG9TbTl4UHBIY0Zx?=
 =?utf-8?B?a3dlamRLS1pidDNRVXN6YUxiTGYyQU1YcHJqQVRGWnh1NitHbkxEc1BWNnF3?=
 =?utf-8?B?SFFwWDB2NjhKQThNZTUya0NYbDJPN0RvWFpkQld2K0Y5MDk4N3FPaTRHc2VC?=
 =?utf-8?B?YTh2T015NU5HaXhId0JYdGRFUXFGeEd4dm5Wa2xFb1FGYzgxNStWQ0xuNmNm?=
 =?utf-8?B?YVE2RkF1bkM5TnZDdnMyL245WEhFMGs5cy8yeG5WZmU4elVSTFJIR2l0K2xx?=
 =?utf-8?B?dHQycVFlZmx4Q3VKUHRjaFY4MlhPUFNScCtQNCt2UTZRd2xvSEZQRmlFby96?=
 =?utf-8?B?bEo0Ulk0azRYMGVaMDJLblg1NHRUcWttZE9jazBUdWZUQ2pmTXI5K1pSUnFH?=
 =?utf-8?B?YTZ1VmRUOWdoYkt4dTFXUjEyeEtCR0RVRytUcUVOdWRNWHlnYS9TV2p0ZUtu?=
 =?utf-8?B?bTNwZ29pbVpDMWFnUFRsdTRCUWcwSkp3OEl3U0lzZDN2RW5yakFERkVXYVZt?=
 =?utf-8?B?bFNweXh5QmJkSFNnckswRUVkQUJoRXVUQzhQNmJVSE02TjVRTXlYWU5vVXpO?=
 =?utf-8?B?aUU3SDlmVDRRbGJWL29SejRKZCtTNCtvR08xalNvVnh4eTFMcUp3VUlOd1p4?=
 =?utf-8?B?c0p4ekNKdGxQRVhvQnNvWVNLT3ROaWlSZ1dJNjlrUGFRRk83VFZxeWlkM1Bx?=
 =?utf-8?B?WDNKZHhXczZoTmpmbzgveXJGdTk5bDBVOFVnZkU3enNNMVVjSVoxNS9hSWVl?=
 =?utf-8?B?c1BmL0JxdC90M0V5emVKakdUdGJYMkowdk04aFZLcnliaVFvQWs1eGRDWHZx?=
 =?utf-8?B?eTFUR0VrSENnTStuVnEyaXJsanEzSlpJWC94anBYUzRpY3RaRXBFZTR5T0t4?=
 =?utf-8?B?SFhYSSs0US9JYkxYLzB6dlFDbUp3MFo0RktNS1pTbEFNcWhla2I2VGcvSG1V?=
 =?utf-8?B?blBYdG9xdnJUd21XLzFnL1YxT2owaHZ6UEVpYldpSWRnMEVnRmNYcGZPcmdi?=
 =?utf-8?B?NkM3QlBrNmt1d2duQnJUNTFpRTBXSWxGOE4wV3hvZ0hBVWNpeDJvOWFYVm5T?=
 =?utf-8?B?TXBxRkIrc252ZE9jTGpEZGZwUUVlSWZIQlpYTlN6Q0JOSHdESDRzMHZXdFNy?=
 =?utf-8?B?UmxNMlpXTnRQVjcxL1lITmdIdjZmTUsyOTBicHp6Qmx5ZDZpWlNueXd5OEdr?=
 =?utf-8?B?R3RoSk80SEl5dmhNWURMVXVLQldpUng2T0ZoZUhCc2VqY0oveTVTN21QNmFz?=
 =?utf-8?B?blM5RUVMTndyRlJYajhoNTFUaWdVd25GSUcwb3p1dEdJL0Y5Slc4TDVkOUV6?=
 =?utf-8?B?UDh4cHJCNUs2RnpUNC9rMlU5dmhwSFFBWFhoY0QzQW0wTGJ6UmxBOU90VFdi?=
 =?utf-8?B?amNKNHFOMjlPMWl3R05IRlF2NEtuZHpsZUpnRWwyOW1WSHZpUzFNZVRaTEly?=
 =?utf-8?B?R3NhcXdvOHJYVG9xZENQemhJcnZLYmswTWQ1anl2L1pGTkpselYyWHhESThx?=
 =?utf-8?B?MEZCV2JkdEM2YjRUcDlSalNxNDdsWXpVM3ZTWUxkaE91NGo3dTZIeEFadEFk?=
 =?utf-8?B?MXI0VlY4OVhtSS92YklPamFaVmZVRzZCZTRtUUQwT3pWNmExR1ArTUpORTNm?=
 =?utf-8?B?Mk5YdEppcHlaLzhFQkh2TzlFMmhqUVVQektKTEwyZXVCK29HUHYwdFpGdUZB?=
 =?utf-8?B?TmkzUjlKdHdGUUxpZHRqY3ZtUHNEWjdXdFRuQ0NyQW1BN2t4VkM2VG9Mc0tV?=
 =?utf-8?B?WEZuL0FNY3FtUzNXWVBFaitsTkJTSVhYSjdPUnN6WjhxVGlaTGZ1dXl3V1lC?=
 =?utf-8?B?b3cvQk1rMUk2TXhNU1RlQ3RjMElMbWpSaXdhSHQwZmJzSFBaTEhaZ1RJNTFO?=
 =?utf-8?B?UDVjUUtJbFprbFJyeWxhbXlEUS9sRVNTNHRsSVk1ZUdqQks2am5GemhibS9n?=
 =?utf-8?B?cUdoOXg5czhNODYxZUhycVNpMzZOTTFIcFNpejNWck1qQ3h4a05rOGtJWGRQ?=
 =?utf-8?B?bGdXUHhQOGdGQVkycHFPL3FmTEdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf714b-e66a-4464-d83c-08d9f35427d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 03:01:41.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYNW/eY2BAknCsofHm27pSvLi6rIl++n1etle7mZjm4XduPABmtd2YQa3s+K9Wr9ISpSPiDPf8nkmxCCyUXvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiBpdDoNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNl
L3Bvd2VyL21haW4uYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMNCj4gPiA+IGluZGV4IDA0
ZWE5MmNiZDljZi4uZjViZjQ2NzgyMDQzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9iYXNl
L3Bvd2VyL21haW4uYw0KPiA+ID4gKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYw0KPiA+
ID4gQEAgLTMyLDYgKzMyLDcgQEANCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc3VzcGVuZC5oPg0K
PiA+ID4gICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvcG93ZXIuaD4NCj4gPiA+ICAjaW5jbHVkZSA8
bGludXgvY3B1ZnJlcS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9jcHVpZGxlLmg+DQo+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L2RldmZyZXEuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvdGlt
ZXIuaD4NCj4gPiA+DQo+ID4gPiBAQCAtMTM1MCw2ICsxMzUxLDggQEAgaW50IGRwbV9zdXNwZW5k
X25vaXJxKHBtX21lc3NhZ2VfdCBzdGF0ZSkNCj4gPiA+ICB7DQo+ID4gPiAgICAgICAgIGludCBy
ZXQ7DQo+ID4gPg0KPiA+ID4gKyAgICAgICBjcHVpZGxlX3BhdXNlKCk7DQo+ID4NCj4gPiBDYW4g
eW91IHJlcGxhY2UgdGhpcyB3aXRoIHdha2VfdXBfYWxsX2lkbGVfY3B1cygpIGFuZCByZW1vdmUg
dGhlDQo+ID4gY3B1aWRsZV9yZXN1bWUoKS9jcHVpZGxlX3BhdXNlKCkgY2FsbHMgZnJvbSBzMmlk
bGVfZW50ZXIoKSBhbmQgc2VlDQo+ID4gd2hhdCBoYXBwZW5zPw0KPiA+DQo+ID4gPiArDQo+ID4g
PiAgICAgICAgIGRldmljZV93YWtldXBfYXJtX3dha2VfaXJxcygpOw0KPiA+ID4gICAgICAgICBz
dXNwZW5kX2RldmljZV9pcnFzKCk7DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9w
b3dlci9zdXNwZW5kLmMgYi9rZXJuZWwvcG93ZXIvc3VzcGVuZC5jDQo+ID4gPiBpbmRleCA2ZmNk
ZWU3ZTg3YTUuLjE3MDhhNjQzYmE1ZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9wb3dlci9z
dXNwZW5kLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9wb3dlci9zdXNwZW5kLmMNCj4gPiA+IEBAIC05
Nyw2ICs5Nyw3IEBAIHN0YXRpYyB2b2lkIHMyaWRsZV9lbnRlcih2b2lkKQ0KPiA+ID4gICAgICAg
ICByYXdfc3Bpbl91bmxvY2tfaXJxKCZzMmlkbGVfbG9jayk7DQo+ID4gPg0KPiA+ID4gICAgICAg
ICBjcHVzX3JlYWRfbG9jaygpOw0KPiA+ID4gKyAgICAgICBjcHVpZGxlX3Jlc3VtZSgpOw0KPiA+
ID4NCj4gPiA+ICAgICAgICAgLyogUHVzaCBhbGwgdGhlIENQVXMgaW50byB0aGUgaWRsZSBsb29w
LiAqLw0KPiA+ID4gICAgICAgICB3YWtlX3VwX2FsbF9pZGxlX2NwdXMoKTsNCj4gPiA+IEBAIC0x
MDQsNiArMTA1LDcgQEAgc3RhdGljIHZvaWQgczJpZGxlX2VudGVyKHZvaWQpDQo+ID4gPiAgICAg
ICAgIHN3YWl0X2V2ZW50X2V4Y2x1c2l2ZShzMmlkbGVfd2FpdF9oZWFkLA0KPiA+ID4gICAgICAg
ICAgICAgICAgICAgICBzMmlkbGVfc3RhdGUgPT0gUzJJRExFX1NUQVRFX1dBS0UpOw0KPiA+ID4N
Cj4gPiA+ICsgICAgICAgY3B1aWRsZV9wYXVzZSgpOw0KPiA+ID4gICAgICAgICBjcHVzX3JlYWRf
dW5sb2NrKCk7DQo+ID4gPg0KPiA+ID4gICAgICAgICByYXdfc3Bpbl9sb2NrX2lycSgmczJpZGxl
X2xvY2spOw0KPiA+ID4NCj4gPiA+DQo+ID4gPiAqIFJlbW92aW5nIHRoZSBjcHVpZGxlX3BhdXNl
IGNhbGwgZnJvbSBzMmlkbGVfZW50ZXIgd2lsbCBmaXggdGhlIGNyYXNoLA0KPiA+ID4gICBidXQg
dGhlIHN5c3RlbSBkb2Vzbid0IGVudGVyIHRoZSBkZWVwZXN0IHNsZWVwIHN0YXRlLg0KPiA+DQo+
ID4gSSB0aGluayB5b3UgbWVhbiB0aGF0IHJlbW92aW5nIGl0IGRvZXNuJ3QgbWFrZSBhIGRpZmZl
cmVuY2UgZXhjZXB0DQo+ID4gdGhhdCBpdCBwcmV2ZW50cyB0aGUgZGVlcGVzdCBzdGF0ZSBmcm9t
IGJlaW5nIGVudGVyZWQuDQo+ID4NCj4gPiBQYXVzaW5nIGNwdWlkbGUgaGVyZSBpcyBraW5kIG9m
IHJlZHVuZGFudCwgYmVjYXVzZSBpdCBqdXN0IGZsaXBzIHRoZQ0KPiA+ICJpbml0aWFsaXplZCIg
ZmxhZyB0aGF0J3MgZ29pbmcgdG8gYmUgZmxpcHBlZCBhZ2FpbiBieQ0KPiA+IGNwdWlkbGVfcmVz
dW1lKCkgaW4gdGhlIG5leHQgaXRlcmF0aW9uLiAgW0JUVywgeW91ciBwYXRjaCBpcyBtaXNzaW5n
DQo+ID4gb25lIGFuIGFkZGl0aW9uYWwgY3B1aWRsZV9yZXN1bWUoKSBpbiB0aGUgcmVzdW1lIHBh
dGggdG8gbWF0Y2ggdGhpcw0KPiA+IGNwdWlkbGVfcGF1c2UoKS5dICBBbHNvIGNhbGxpbmcgIHdh
a2VfdXBfYWxsX2lkbGVfY3B1cygpIGlzIG5vdCBsaWtlbHkNCj4gPiB0byBtYWtlIGEgZGlmZmVy
ZW5jZSwgc28gSSdtIGd1ZXNzaW5nIHRoYXQgc3luY2hyb25pemVfcmN1KCkgZG9lcyB0aGUNCj4g
PiB0cmljay4NCj4gPg0KPiA+ID4gKiByZW1vdmluZyB0aGUgY3B1aWRsZV9wYXVzZSBjYWxsIGZy
b20gZHBtX3N1c3BlbmRfbm9pcnEgdGhlDQo+IGZpcm13YXJlIGNvbnRpbnVlcyB0bw0KPiA+ID4g
ICAgY3Jhc2guDQo+ID4NCj4gPiBTbyB0aGUgY3Jhc2ggb2NjdXJzIHdoaWxlIHJ1bm5pbmcgZHBt
X3N1c3BlbmRfbm9pcnEoKS4NCj4gPg0KPiA+ID4gSSBhbHNvIGNvbmZpcm1lZCB0aGF0IHJldmVy
dGluZyBib3RoIG9mIHRoZXNlIGNvbW1pdHMgdG9nZXRoZXIgb24gdG9wIG9mDQo+IDUuMTctcmM0
IGZpeGVzIGl0Og0KPiA+ID4NCj4gPiA+IDhkODk4MzViMDQ2NyAoIlBNOiBzdXNwZW5kOiBEbyBu
b3QgcGF1c2UgY3B1aWRsZSBpbiB0aGUgc3VzcGVuZC10by0NCj4gaWRsZSBwYXRoIikNCj4gPiA+
IDIzZjYyZDdhYjI1YiAoIlBNOiBzbGVlcDogUGF1c2UgY3B1aWRsZSBsYXRlciBhbmQgcmVzdW1l
IGl0IGVhcmxpZXINCj4gZHVyaW5nIHN5c3RlbSB0cmFuc2l0aW9ucyIpDQo+ID4gPg0KPiA+ID4g
VGhlIGNvbW1pdCBtZXNzYWdlcyBhdCBsZWFzdCBtYWtlIGl0IHNvdW5kIGxpa2UgaXQgd2FzIGp1
c3QgYSByZXdvcmsgZm9yDQo+IHVuaWZpY2F0aW9uIG9mIHRoZSBjb2RlcGF0aHMsDQo+ID4gPiBu
b3Qgc3VwcG9zZWQgdG8gYmUgZm9yIGFueXRoaW5nIHRvIGJlIGFjdHVhbGx5IGZpeGVkLCBzbyBJ
IHdvdWxkIHRoaW5rIGl0DQo+IHNob3VsZCBiZSBzYWZlIHRvIHJldmVydC4NCj4gPg0KPiA+IFRo
ZXJlIGlzIGEgZGVlcGVyIGlzc3VlIHJlbGF0ZWQgdG8gdGhlc2UgY29tbWl0cyBhbmQgSSdtIG5v
dCBpbmNsaW5lZA0KPiA+IHRvIGdvIGJhY2sgdG8gdGhlIG9sZCBjb2RlIGlmIHRoZXJlIGlzIG9u
bHkgb25lIHN5c3RlbSBhZmZlY3RlZCBieQ0KPiA+IHRoaXMgYW5kIHRoZSBwcm9ibGVtIGlzIHJl
bGF0ZWQgdG8gdGhlIHBsYXRmb3JtIGZpcm13YXJlIG9uIHRoYXQNCj4gPiBzeXN0ZW0uDQo+ID4N
Cj4gPiA+IFNvIHBsZWFzZSBhZHZpc2Ugd2hpY2ggd2F5IHlvdSB3YW50IHRvIGdvIGFuZCBJJ2xs
IHNlbmQgdXAgYSBwYXRjaCAob3IgaWYNCj4geW91IHdhbnQgdG8gd3JpdGUgb25lDQo+ID4gPiBJ
J20gaGFwcHkgdG8gdGFrZSBpdCBhbmQgdGVzdCBpdCBzaW5jZSBJIGNhbiByZWFkaWx5IHJlcHJv
ZHVjZSBpdCkuDQo+ID4NCj4gPiBUbyBzdGFydCB3aXRoLCBwbGVhc2UgdGVzdCB0aGUgYXR0YWNo
ZWQgZGVidWcgcGF0Y2ggb24gdG9wIG9mIC1yYzQuDQo+IA0KPiBBdHRhY2hlZCBpcyBhbm90aGVy
IHBhdGNoIHRvIHRyeSwgdGVzdGluZyB0aGUgaHlwb3RoZXNpcyB0aGF0IHRoZQ0KPiBvYnNlcnZl
ZCBjcmFzaCBpcyByZWxhdGVkIHRvIENQVXMgYmVpbmcgaW4gaWRsZSBzdGF0ZSB0aGF0IGFyZSB0
b28NCj4gZGVlcCBmb3Igc29tZSByZWFzb24gZHVyaW5nIGxhdGUgc3VzcGVuZCBhbmQgZWFybHkg
cmVzdW1lLg0KDQpJIHRyaWVkIDMgdGVzdCBrZXJuZWxzOg0KKiA1LjE3LXJjNCArIFlvdXIgc2Vj
b25kIGRlYnVnZ2luZyBwYXRjaA0KKiA1LjE3LXJjNCsgWW91ciBmaXJzdCBkZWJ1Z2dpbmcgcGF0
Y2gNCiogNS4xNy1yYzQgKyBBIGhhY2sgSSB3cm90ZSB0aGF0IHB1c2hlZCBhbWQtcG1jIGludG8g
ImxhdGVyIiBpbiB0aGUgc3VzcGVuZA0KdXNpbmcgYSBnbG9iYWwgc3ltYm9sIGNhbGxlZCBhZnRl
ciBMUFMwIGluc3RlYWQgb2YgbGV0dGluZyBpdCBydW4gaW4gbm9pcnEgc3RhZ2UNCiANCkl0IHdv
cmtzIHByb3Blcmx5IG9uIGFsbCBvZiB0aG9zZSwgdHJpZWQgYWJvdXQgNXggdGltZSBpbiBlYWNo
Lg0KDQpUaGVuIEkgY29uZmlybWVkIEkgY291bGQgc3RpbGwgY3Jhc2ggaXQgb24gNS4xNy1yYzQg
d2l0aCBteSBjb250cm9sIGtlcm5lbC4NCg==
