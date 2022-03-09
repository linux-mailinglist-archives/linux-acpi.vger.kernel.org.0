Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DD4D3D66
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiCIXMY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 18:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiCIXMX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 18:12:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2E2122218
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 15:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or9Wr+UW2sH3nJzm5+dfJauFT8hfGkOyH8sEFWds7k96C8b/TMm5k7MK3p6FktWLFGs+6xwPQ6PUhc4fK2dy2yTyE9DAVy13eH59Hzj0tPLVIUmmoF6Fq+Ny9qZJMAZj1vEWm+OKVIKEullDwnrij21B8bGorvFd+YUhCC4uihNrOGOMgt1iEXLsfQkft5ounbjpfFo0mSfq3Q9LDC2H8x5S1le7XLleldpX19fbi45OtE7CvgZcZWsa7zhze1Wo5QYc4/svTfcvx8y9gk0uS7n1un965j3hM7i9udqQQGmsWVVr9bzkwJt5vUq2KOnY0Lo1PSICytjFY/mHIYddEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6FVBG9rEGr0fpVQIXriuOCuKCqvB7VZYY5BKpbqM9c=;
 b=bS/ai/O+xqol4ObIUdKOchsdPwo5We9jc5nGPYhR/2Dqwn1xB+ljFbZcPwCOdySKL8Cs40IGhtZpidyjEsqai6G9yd5kpglFtI+CqgaqNefQATW8LvHKhQpjn4XLkObd5DceEDGWag594vacJXITZS8bRw3+6n3gTMyLLUd4gqegmx54OLtCTikyGUn4TCDt+/6Iwj6jZBaEbZ1iK87onOaXPtTdzgzD+0YlqdPZxRw44w3OZ9XLtYlGQ12k/NZVa5yNKM8G7QqU4BlBUfxccmgH6LKG8p/b091YGkWvgFXQmAyS7H7KbDC2PfNS3RZRR78PnO8yYHj+Poax5K7m5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6FVBG9rEGr0fpVQIXriuOCuKCqvB7VZYY5BKpbqM9c=;
 b=XGobfm1x5OvR74fOio8jNG4GvAvXWqxTjgKB0VM1QVEJx/IfF7UGOUbIeXZU8OTfBsqAiGPM9t6/DXML4vCi03Qi6u9mD8BcLG81Xmd8OO2yI9P6j/VkcbEBqNm4VTASqlKnunrx+SBzklNJ/B05MGd19Kq4QhL1eqTPU2E9Jz0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 23:11:21 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 23:11:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: RE: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
Thread-Topic: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
Thread-Index: AQHYMz4dV+TeLnmW50K8sfbt3FV7say3DayAgAABRrCAAA2BAIAAkoSw
Date:   Wed, 9 Mar 2022 23:11:21 +0000
Message-ID: <BL1PR12MB5157B961D5BD3F59415072C1E20A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220308224200.2691564-1-mario.limonciello@amd.com>
 <CAJZ5v0ixsSuH_d+CCiU_Mn7HaCf6mLekOadte9j33NKg4aH20w@mail.gmail.com>
 <BL1PR12MB515736C2283780FA1215554EE20A9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g8L9cLOx+1Hrb=JyVzqZwPfs09RUYMxKvOA41rtw4Ghg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g8L9cLOx+1Hrb=JyVzqZwPfs09RUYMxKvOA41rtw4Ghg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-09T23:10:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d56163c1-5a14-4ea2-99d7-49861fa32017;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-09T23:11:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 56fe9084-d91a-40f3-9c55-3b488946b254
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42263689-a330-4fe1-4e6b-08da0222200b
x-ms-traffictypediagnostic: MN0PR12MB5835:EE_
x-microsoft-antispam-prvs: <MN0PR12MB5835537B2B2BA9D780F5A05CE20A9@MN0PR12MB5835.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXwRRAFSxA6Y01yDSSedJ1nG7gQ5buXHoM0QpnsYm/mOTuvmHSa72nPaQY5obLBCshTXij8mWWGQwXnfldH+JTRFvPryAHMAltH1WTiduHQ8GXHpzPvEJK1HcoOjYONCB3yMK1DkiYG5RxLky/NM7/kurVSZEybXTj9UNSAAfdEvU56R02Ur9N7j3Hk3reWLfJUnS0PJKDS1vgyxrfl+KbZBYQrSxKw2fO2/qoeU/NHlqY8NM/Hy5a92+eTPA9SQa6ExqZxins+gzsY9yGzzXTx/4MrH5AVQ6+YzQ+PwHgwcCXL0Ekt15cx38MlE9vcm3knPJJYpaJsAFDYk7LY8IINMFr7Iv32gQrqE9bTG+5XWy16g9SBexPV1+gB8fjXyGQjYTwk3/Aui8SKn3gJQyCJILeg+zhT7c8NjdYcwdSpp2PmIh04wXkBW8Esbuuf2P6/lDgGBBbDvhkXjTNil4tMpbsrRD/uChHUp5NmHME/QTXpxsnzb/6e1UhVuNRT3k2vxpfdSZ+YfXpIsdfhKHAoyQypEeGDBXXvkPVXlvIpLDsF6TkvjDqtppJpQgrrH1U3x/YDblKeZgHap8vpKM7U/LOryP0kTCzkGHWvqFg7S+qBE9/96Bx9TwyzcIMT0KyStPHWbqzPxRnDsjOAl3Yk38G2my8hzQ+KW4faQB5y1Gvgoe9Vo22eN+nrsFkSxImaE2A+3QRwxl/UpWyoNiVJbVwTCvLShdbeC8YJNnJ5kJurLInNiiDqt+1UWosOD6LFDhNrhhhe1AKNotG9QTGrZ84IVd8VdRK9MPsxF49mXNdqK8PH4VLraOq4PyxoV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(64756008)(5660300002)(38100700002)(33656002)(66446008)(66556008)(66476007)(4326008)(66946007)(8676002)(8936002)(86362001)(76116006)(54906003)(6916009)(2906002)(83380400001)(52536014)(316002)(9686003)(53546011)(6506007)(38070700005)(7696005)(71200400001)(26005)(186003)(508600001)(122000001)(55016003)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1UrajFIdk5qUWg0K2Q4bkVBUkIwc1c3TWNOdkRzTFFKZWhicnJUeUlsSi8r?=
 =?utf-8?B?RUNqblNXODdLaHNUMkFSKzJxZUJPd3RtbzdiZXJpV3Q0VFBEN3paRDBRSlll?=
 =?utf-8?B?Z21PejRvR1dmcU5PQmJTZFk4eUc2aG4yeVJyK2MrTnkzbk9aaEZHdW5wMWZV?=
 =?utf-8?B?N09BcGg2UmJrdDJDQmxVK1pEWHlkTDZHTnBGckp0QjFmSGR4T0tOT05DV05W?=
 =?utf-8?B?K3kyMHI2cVlmanhhRkYrVnp0a3hKNndzWWN2Z2ZzSWhIL253SC8rSGZSK3Jz?=
 =?utf-8?B?NWJrMzFTOTNKUWFycERSZVFtN3FJRFRubzl0a2Z3Tm5nZ2EvQ2ErYm5peXc0?=
 =?utf-8?B?VWJtN2llNmFMdVl3bUc2MElxcFludEdET0t1ZnVRRXY4bzNYWEk0N3MvbXlI?=
 =?utf-8?B?N2RlM2RYSUlXV3N6ZXpoaGFlbHQ0T05BWW5KL0tJbzQwbmNVS0U1aFBibmcy?=
 =?utf-8?B?NlhNRjE0eUdCUHFmTDNOWER2T21EdGFCYnVtUURhaGdXOWFocXVVZXA5ckY5?=
 =?utf-8?B?Qjl4enRvYUdqTXFHYXZGdlRxRmFBbHVuVUxCMnZqK0dDRGlNV3hpd2dlcUtM?=
 =?utf-8?B?WGVIY293d1JEV2hWZXh2c29Xbzd3dU80R0YyK3NSb3dqVzl6QUdteEpWOG1H?=
 =?utf-8?B?SVBNeU5MajcwcDFJOFpFZnJqa1BVVmF6dkxDbUVXNFY2a2J4eHNpQzhDdlpI?=
 =?utf-8?B?dW1ZQWdGQWszVjRXZncvd09tZ1RkSExNRmM1TmlTb1dWcjl6eG1SZndEYUYx?=
 =?utf-8?B?UjF3NDVhWEhhNHhsM25wcElERFV1a3RTdHZBR09ZdTcyN0N6aW9DZWI3Snl0?=
 =?utf-8?B?VkwxelpJbWlNUEZEYldHajgvclRMSDJLaUszWUtsMEdpTjNlY2piUml2OFNW?=
 =?utf-8?B?T202WnRjSTFZcTJKbHhuTmRkSmxSMkYvS1hzOGQzNGl0a0l6MzNPV3U4dG04?=
 =?utf-8?B?dVk0QlhDNVVudnBkTExMcGpTUVFvc0FpZXpjWE1ZQjBpM0JZYXBJTG51ZTB4?=
 =?utf-8?B?a2RBTDRudHRqc2txQmdncjZyUEllYXcxNzMvVEdYUWhZaUw0VzFsZlBybExz?=
 =?utf-8?B?T1c2aUl4RWlOYnlBT1V5OU16T21JNHdxZHZiWENGTVpIUWw0M3A3dUVtRFhn?=
 =?utf-8?B?OEprMDZvcExBNWoxOW5UV1ZkWFd2eXBOd3pHRXU1UEFCcUNUM1dYbGJGdExK?=
 =?utf-8?B?Z1lPVTA3VVU5ektPOFVPTTJ0YTFjZ0plSml4KysreC9LZldkYmZSNVVReXgv?=
 =?utf-8?B?amNmdjFlQmtycmdtVCtpUlA0R0h3T0lQTVFPZFdnUnZsZGpyMEpqRUIyYjg3?=
 =?utf-8?B?MVhzYmhUdStxTDZHVE14YlVCVjRxM1BFS281S3Z1c1pXczBDOWVvS25iQThD?=
 =?utf-8?B?ZEJiYzVJTVNrRTU3YTMzQSt1Z3NWV1pMMXBPKzFkelZQZGFOZHQvdEs0eXAr?=
 =?utf-8?B?RzFNa1FZN1FzdURwNUtjcUt0SG5veWkxbkcyeW83b3lOd2JGUncwK0grU3pQ?=
 =?utf-8?B?TDZ1WVlKTkw5Z05PdHVSSVdCRE5Bb2pBZGY0bWVuTHFzTDBjaytteGMxVDlv?=
 =?utf-8?B?MkxMT1d2SjJ6bFZOR2w1RWptYkkzcXM0VVNIYkxkY0hhR3FVSmZIMlI1QXo5?=
 =?utf-8?B?VERyQStWM2tCS0ZWSFZ6TEprK2Z5SWdKVDNzdWF2ZlE4QjM3QUhFalF0b1BZ?=
 =?utf-8?B?anE4WDM5OG0wR3hHamZZR2NQbGgxVXVsbkJpaUJoSTdHa1FKYVpNWU9Pa0Uv?=
 =?utf-8?B?WmxKVU52VXJUVGFlKzZpYVFIMW1QY1A4V1N0dU9qZXlSWDZsQjlxRWY5T3FT?=
 =?utf-8?B?ejVRNlNRRlN3V091R29wOC9FQUIyeVNKNUZNRXdlYWFJTEhqVERaMS9LOTRz?=
 =?utf-8?B?UHhSNXlLR2pCa1hsclRoSzBIMEVMUmJHaklYMTZoTEVxcHBlSWUvcWs1Yjdm?=
 =?utf-8?B?dGdYcmRWV3lsc051NWtYa1hnbkh5NDhhbXhxQzhabzFEaGhZcjJ5bUF0U1Zj?=
 =?utf-8?B?RE41bVJ2QmVsU3prZStvWk9BTHFPeE9Uem82SG9YcVkvOTl4R3lxN2JPa1Za?=
 =?utf-8?B?M3RFYzJRVktNTERTSlora1h3NSt2enJuS1JFbGUxaTJKU2R2Ykx6ZDRMazg1?=
 =?utf-8?B?cjFLdGRDT0F5K0lDbTlEY2orTktNY3B1Z0tXcUUzb0ZOVG01TWNST20yQk8r?=
 =?utf-8?Q?8lXfLGYKoaxhG2qo1UpC7nU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42263689-a330-4fe1-4e6b-08da0222200b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 23:11:21.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jif6Nva+XGeioJDFfuphMU6P2BUMHQCv3vwKiNUU0b68HOyzJoIAXTGeYy/XZrpIC8FUozB4IED+Vl/x/Y1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
OSwgMjAyMiAwODoyNQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPg0KPiBDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsg
UmFmYWVsIEogLiBXeXNvY2tpDQo+IDxyandAcmp3eXNvY2tpLm5ldD47IEFDUEkgRGV2ZWwgTWFs
aW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsNCj4gUWlhbiBDYWkgPHF1aWNf
cWlhbmNhaUBxdWljaW5jLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJL0FDUEk6IEFk
ZCBzdXBwb3J0IGZvciBgQUVfU1VQUE9SVGAgaW4gX09TQw0KPiBxdWVyaWVzDQo+IA0KPiBPbiBX
ZWQsIE1hciA5LCAyMDIyIGF0IDI6NDggUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHldDQo+ID4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBjb21taXQgYTQxMmNhZWE1YTJkICgiQUNQ
STogYnVzOiBBbGxvdyBuZWdvdGlhdGluZyBfT1NDIGNhcGFiaWxpdGllcyIpDQo+ID4gPiA+IGFk
ZGVkIHN1cHBvcnQgZm9yIGBhY3BpX3J1bl9vc2NgIHRvIHJldHVybiBgQUVfU1VQUE9SVGAgd2hl
bg0KPiBuZWdvdGlhdGluZw0KPiA+ID4gPiBhbiBfT1NDLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlz
IHdhcyBmaXhlZCBpbiBvdGhlciBrZXJuZWwgY29uc3VtZXJzLCBidXQgYGFjcGlfcGNpX3J1bl9v
c2NgIHdhcw0KPiA+ID4gPiBtaXNzZWQuICBVcGRhdGUgdGhlIGZ1bmN0aW9uIHRvIGRldGVjdCB3
aGVuIGNhbGxlZCB3aXRoDQo+ID4gPiBgT1NDX1FVRVJZX0VOQUJMRWANCj4gPiA+ID4gc2V0IGFu
ZCBhdHRlbXB0IHRvIG5lZ290aWF0ZSB1cCB0byA1IHRpbWVzLg0KPiA+ID4NCj4gPiA+IFRoaXMg
aXMgbm90IGhvdyBpdCBpcyBkZXNpZ25lZCB0byB3b3JrLCB0aG91Z2guDQo+ID4gPg0KPiA+ID4g
YWNwaV9wY2lfcXVlcnlfb3NjKCkgaXMgZm9yIHRoYXQuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
PiBSZXBvcnRlZC1ieTogUWlhbiBDYWkgPHF1aWNfcWlhbmNhaUBxdWljaW5jLmNvbT4NCj4gPiA+
ID4gRml4ZXM6IGE0MTJjYWVhNWEyZCAoIkFDUEk6IGJ1czogQWxsb3cgbmVnb3RpYXRpbmcgX09T
QyBjYXBhYmlsaXRpZXMiKQ0KPiA+ID4NCj4gPiA+IFNvIEknbSBzZXJpb3VzbHkgdGhpbmtpbmcg
YWJvdXQgZHJvcHBpbmcgdGhhdCB3aG9sZSBsb3QgYXQgdGhpcyBwb2ludC4NCj4gPg0KPiA+IERv
IHlvdSB3YW50IG1lIHRvIHNlbmQgdXAgYSBzZXJpZXMgcGVyaGFwcyB0aGF0IHJldmVydHMgdGhv
c2UgMyBjb21taXRzDQo+IA0KPiBJIGNhbiBqdXN0IGRyb3AgdGhlbSBhdCB0aGlzIHBvaW50LCBz
byBubyBuZWVkIHRvIHJldmVydC4NCj4gDQo+ID4gYW5kIGluc3RlYWQgbW92ZXMgdGhlIGxvZ2lj
IGNoYW5nZXMgb24gcXVlcnkgaGFuZGxpbmcgZnJvbSBhY3BpX3J1bl9vc2MNCj4gaW50bw0KPiA+
IGFjcGlfYnVzX29zY19uZWdvdGlhdGVfcGxhdGZvcm1fY29udHJvbD8NCj4gDQo+IFllcywgcGxl
YXNlIQ0KDQpIZXJlIGl0IGlzLiAgSSBkaWQgaXQgYmFzZWQgb24gbGludXgtcG0vYmxlZWRpbmct
ZWRnZSB3aXRoIHRob3NlIDMgY29tbWl0cyByZXZlcnRlZCBmaXJzdCAob24gdGhlIGFzc3VtcHRp
b24gdGhleSBkcm9wKS4NClNob3VsZCBoYXZlIGRvbmUgdGhpcyBmcm9tIHN0YXJ0IC0gaXQncyBz
byBtYW55IGxlc3MgTE9DIGFuZCBlYXNpZXIgdG8gZm9sbG93IQ0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFjcGkvcGF0Y2gvMjAyMjAzMDkxNjM3NDkuNzczNDc0
LTEtbWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbS8NCg==
