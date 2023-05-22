Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151170BB1F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjEVLHf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 07:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjEVLHP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 07:07:15 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AF189;
        Mon, 22 May 2023 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9z9YHloSI6raVW3FwJRtv0KKwXWm4773k5WQx971RY=;
 b=wyk9nVaCeffKj5U/thF4yjal8Q93nQczFaaxYmMPjlSWuAdMDirehp3wJGCurfkTZ1weRLcMdQ2C0zgUnvYQQOdobEqcnYYqLFo2iRvm2UHl9Lvu6+h/uFuUZF6BdvokSuCE2oP8l0XLroLX831bLmj2Vogd9QqyO5ZXMjGeAYA=
Received: from AS9P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::27)
 by AS2PR08MB8454.eurprd08.prod.outlook.com (2603:10a6:20b:55a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Mon, 22 May
 2023 10:55:17 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:50f:cafe::84) by AS9P251CA0022.outlook.office365.com
 (2603:10a6:20b:50f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 10:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.13 via Frontend Transport; Mon, 22 May 2023 10:55:17 +0000
Received: ("Tessian outbound e13c2446394c:v136"); Mon, 22 May 2023 10:55:16 +0000
X-CR-MTA-TID: 64aa7808
Received: from b9eabcb1afcd.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33750FBF-F48F-4A80-B568-0E00C3D35D46.1;
        Mon, 22 May 2023 10:55:10 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b9eabcb1afcd.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 May 2023 10:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq9iw9EYrVY/7J1OXAd1IOJB7h+Ecn1Q5P/TFpGklV8TDWkTJeh6lk7NHDjpT6yXkIzHvhwkABq+BFYyJzhNLXijZPxZmO9E4IdGfvJUCJvQpLSfKbUzzHAbvlME80fW2SKA29MWGSPcURaqcTNbvAFCwQBPARJvT360gmwy0GOAUC0HVZBdO4NWmlWVxo1jvpHKCtMyZwKmEg5Mgc95//gAWp7l+/55sB5eazJfxED8iGsjYEnGIkcItQgQR30WDOpjNjANLgV5Yye/sx9aJx5kt9NMr1LvgB8nNTwC9suSb3m5E+6cKR9HyUnNpMslVm8NGZUBg6NAHxz9dLeJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9z9YHloSI6raVW3FwJRtv0KKwXWm4773k5WQx971RY=;
 b=UBo+4Lehny2B+Xfq0SVpW2VDflmShTSq5VESZWzX8w7fLMlu1CYHImDIPGK0JhrFuRnUJDn8O8WnbMHZST6O5PLUHCNb+uPxShUBe4gtsXfNtvkTOM5xidD9vqZdsF6LeuDQ9rtNFr/7rwoqQXLJcIYS4ec04aJeQhlWvQEFeKQr3Uw8gP/DV/dBlV8tZ4g9VmfTdQrXcHo6UAhJHlQk9hMzntZIxik5H/USkd6Oes8Xzw2h2bPa6MVSl9/Bcj2wve2FXiH1NsZ4ca4sp1U6zAra8SrY1tsqew4Z6u1xYDT+v2M6i1GW9ZKh1K7H4fc+pSKvkW4d6grA78bkz1zs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9z9YHloSI6raVW3FwJRtv0KKwXWm4773k5WQx971RY=;
 b=wyk9nVaCeffKj5U/thF4yjal8Q93nQczFaaxYmMPjlSWuAdMDirehp3wJGCurfkTZ1weRLcMdQ2C0zgUnvYQQOdobEqcnYYqLFo2iRvm2UHl9Lvu6+h/uFuUZF6BdvokSuCE2oP8l0XLroLX831bLmj2Vogd9QqyO5ZXMjGeAYA=
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com (2603:10a6:10:205::9)
 by AS8PR08MB8300.eurprd08.prod.outlook.com (2603:10a6:20b:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:55:06 +0000
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::f713:dc49:79be:3b4a]) by DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::f713:dc49:79be:3b4a%5]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 10:55:06 +0000
From:   Jose Marinho <Jose.Marinho@arm.com>
To:     Robin Murphy <Robin.Murphy@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
Thread-Topic: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
Thread-Index: AQHZiXcNaBOt64qzaUigg1uTYpm6lq9f79CAgAAZ/QCAASUlAIAAPbMAgASuFmA=
Date:   Mon, 22 May 2023 10:55:03 +0000
Message-ID: <DBBPR08MB6012B565A6B819C2506E62BF88439@DBBPR08MB6012.eurprd08.prod.outlook.com>
References: <20230518105202.451739-1-jose.marinho@arm.com>
 <20230518105202.451739-4-jose.marinho@arm.com>
 <0969894f-d653-482c-f043-2a085ee3b404@huawei.com>
 <e9918d6e-ca5c-5a3a-6ff4-27acf7f73b30@arm.com>
 <dd0114f5-2e9c-40ea-8722-93fdf3f57b87@huawei.com>
 <3dcc08c8-f8e8-69d0-7ad8-e8938f4f2cca@arm.com>
In-Reply-To: <3dcc08c8-f8e8-69d0-7ad8-e8938f4f2cca@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0072B921A01E0145A3146591716C6124.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB6012:EE_|AS8PR08MB8300:EE_|AM7EUR03FT042:EE_|AS2PR08MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 407feb86-fc1f-4599-35bf-08db5ab30761
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XWI9rucjZaIku45xjl/jq5y2jdA42aJVW56JpMiyI1y4IWdwxBsPTez6mAcE7p7IppsC0ziveinxLAvNkEFcWDWlV1Ql9Ff6zvjh8iba45cWQnZjiofw0d/OhUYfDQsyMz9iH2+WioHPWFcMFAWBLAJuoOmJC7QmGd+3T1dB9Nc+M8HqLNpzknlrH3l5Bst2bNzO4I2FKKiqyKUBhBfvQBUuliCUR0YeBoPCUBlZVi2SoB67KMUMkjaLpVev7RtYyIetbrcQJLRiPlaL38XJL0gbb+8ccpdsXOUW92xanxKvbDzmSjm/9GoimZC/mrfxrDv4BJpFtNOnyN6OUd/MQa6OVyQt8kgeoPONQoL3rZ6g1eYWJn1WQJG/0ivKVhcywXIBo1VHYkrLaEBrVc7mqaVkSwqweWOpDxeAQdgvRzX8W33YP8cFzfXBB1iFJz6s+WYYmr2WrWN5L7R4LcrucGecq8mI8KLy7P6+mvoPW0Db0AEReGzx1Q28kc52I0aOLf6JrlIY/SlqADAc9HyByma2ycywXnbQOwxW5F6yn3wuKjU6kRVYbcmFy7ZDdcHNGAT/4+sAqlZ3keZMOM+dR94+17vOlLK4IHtwH9LFvQ4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB6012.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(110136005)(86362001)(54906003)(122000001)(478600001)(83380400001)(6666004)(7696005)(966005)(66476007)(66946007)(66556008)(64756008)(66446008)(76116006)(71200400001)(38100700002)(316002)(4326008)(6506007)(41300700001)(2906002)(26005)(186003)(8676002)(8936002)(9686003)(38070700005)(53546011)(5660300002)(33656002)(55016003)(52536014)(15650500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8300
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 985a810e-2ce8-45a3-a3f8-08db5ab2ff63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCYyHRXVFWHGzKeviTELiRrPFY7lFkbblExKLTmo6WAGQ8RwNCem4F36UnBGKZWd86ly5JkcmmuEeq12lVOfzFxktsmpbcm8MF0cOPOr2Lj1Spothjf9HLLJjrIXIgUe/l9sLziPu+vtQ1dIJQ9De3zMl/g+pty3aOHRVwhXOCfI046OO84xM7GPEGCtVXC57hIpOTX3bqJxNITTSPY5c+bPzOpE59u2G3EeFEHOzoIpJ7BFpvvG6otXw21qtV3tWxeuiE/EaTzhjvjDhQf1kWc8Fwa1IkZqhvO/62pG2KRmoyC5FExR7AUS4/RFjougTTmhr7lKAAjf2DS/hNSHUHikUFz3RU/Zz23OlfJuuXMTygQR4tkFNyCx/XasQcqEmmCnDVA1fkP7JEMQ90lWhUGSM/B00NvvGCCGM6R9QYAlS17djYfo3XnlJTEnecnR+CX13QffMeVrvoUVhPqeHRHjY1pUjykeNDXZXmFe4Fy2WEYs/HMy7bvaxgMnQDXfj05u7+SvQMXzCOaPEGZOI02Otn3AoKZK8Y6eyGn7qA/Cl4ao7o9cOXh1SAIUmiaW0HNkaKFGpxKf9ViW7GgcNW/M81T+ZuTXKrQlCal5+MLn5p2aDn1i2Qv8NFt/LL6cTTyzViIglNYs1qoKHMHV/V6jHeqqXz2cu673geJlHm63leaqv75LUYeT9Gxf6mKUnRlU3P213BpiZok07G20lwcfU85yM3obI02EQyx3I5Q=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(8676002)(8936002)(5660300002)(52536014)(6666004)(4326008)(70206006)(54906003)(70586007)(110136005)(41300700001)(966005)(9686003)(26005)(6506007)(7696005)(15650500001)(53546011)(36860700001)(450100002)(83380400001)(316002)(336012)(47076005)(82740400003)(356005)(81166007)(33656002)(86362001)(82310400005)(186003)(2906002)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:55:17.1420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407feb86-fc1f-4599-35bf-08db5ab30761
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8454
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgSGFuanVuLCBSb2JpbiwNCg0KPiBPbiAyMDIzLTA1LTE5IDA4OjEwLCBIYW5qdW4gR3VvIHdy
b3RlOg0KPiA+IE9uIDIwMjMvNS8xOCAyMTo0MCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiA+PiBP
biAyMDIzLTA1LTE4IDEzOjA3LCBIYW5qdW4gR3VvIHdyb3RlOg0KPiA+Pj4gSGkgSm9zZSwNCj4g
Pj4+DQo+ID4+PiBPbiAyMDIzLzUvMTggMTg6NTIsIEpvc2UgTWFyaW5obyB3cm90ZToNCj4gPj4+
PiBUaGUgQkJSIHNwZWNpZmljYXRpb24gcmVxdWlyZXMgKG9yIGNvbmRpdGlvbmFsbHkgcmVxdWly
ZXMpIGEgc2V0IG9mDQo+ID4+Pj4gQUNQSSB0YWJsZXMgZm9yIGEgcHJvcGVyIHdvcmtpbmcgc3lz
dGVtLg0KPiA+Pj4+IFRoaXMgY29tbWl0IHVwZGF0ZXM6DQo+ID4+Pj4gLSB0aGUgbGlzdCBvZiBB
Q1BJIHRhYmxlcyB0byByZWZsZWN0IHRoZSBjb250ZW50cyBvZiBCQlIgdmVyc2lvbg0KPiA+Pj4+
IDIuMCAoc2VlIGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMDQ0
L2cpLg0KPiA+Pj4+IC0gdGhlIGxpc3Qgb2YgQUNQSSB0YWJsZXMgaW4gYWNwaV9vYmplY3RfdXNh
Z2UuIFRoaXMgbGFzdCB1cGRhdGUNCj4gPj4+PiBlbnN1cmVzIHRoYXQgYm90aCBmaWxlcyByZW1h
aW4gY29oZXJlbnQuDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlLCBzb21lIGNv
bW1lbnRzIGlubGluZS4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3Nl
IE1hcmluaG8gPGpvc2UubWFyaW5ob0Bhcm0uY29tPg0KPiA+Pj4+IFJldmlld2VkLWJ5OiBTYW1l
ciBFbC1IYWotTWFobW91ZCA8U2FtZXIuRWwtSGFqLQ0KPiBNYWhtb3VkQGFybS5jb20+DQo+ID4+
Pj4gLS0tDQo+ID4+Pj4gwqAgRG9jdW1lbnRhdGlvbi9hcm02NC9hY3BpX29iamVjdF91c2FnZS5y
c3QgfCA4MQ0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4+Pj4gwqAgRG9jdW1l
bnRhdGlvbi9hcm02NC9hcm0tYWNwaS5yc3TCoMKgwqDCoMKgwqDCoMKgwqAgfCA3MQ0KPiA+Pj4+
ICsrKysrKysrKysrKysrKysrLS0tDQo+ID4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMzkgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9hcm02NC9hY3BpX29iamVjdF91c2FnZS5yc3QNCj4gPj4+PiBiL0RvY3Vt
ZW50YXRpb24vYXJtNjQvYWNwaV9vYmplY3RfdXNhZ2UucnN0DQo+ID4+Pj4gaW5kZXggNDg0ZWY5
Njc2NjUzLi4xZGEyMjIwMGZkZjggMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9h
cm02NC9hY3BpX29iamVjdF91c2FnZS5yc3QNCj4gPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Fy
bTY0L2FjcGlfb2JqZWN0X3VzYWdlLnJzdA0KPiA+Pj4+IEBAIC0xNywxNiArMTcsMzcgQEAgRm9y
IEFDUEkgb24gYXJtNjQsIHRhYmxlcyBhbHNvIGZhbGwgaW50byB0aGUNCj4gPj4+PiBmb2xsb3dp
bmcgY2F0ZWdvcmllczoNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgIC3CoCBSZWNvbW1lbmRlZDog
QkVSVCwgRUlOSiwgRVJTVCwgSEVTVCwgUENDVCwgU1NEVA0KPiA+Pj4+IC3CoMKgwqDCoMKgwqAg
LcKgIE9wdGlvbmFsOiBCR1JULCBDUEVQLCBDU1JULCBEQkcyLCBEUlRNLCBFQ0RULCBGQUNTLA0K
PiA+Pj4+IEZQRFQsIElCRlQsDQo+ID4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoCBJT1JULCBNQ0hJ
LCBNUFNULCBNU0NULCBORklULCBQTVRULCBSQVNGLCBTQlNULCBTTElULA0KPiA+Pj4+IFNQTUks
IFNSQVQsDQo+ID4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoCBTVEFPLCBUQ1BBLCBUUE0yLCBVRUZJ
LCBYRU5WDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoCAtwqAgT3B0aW9uYWw6IEFHREksIEJHUlQsIENF
RFQsIENQRVAsIENTUlQsIERCRzIsIERSVE0sDQo+ID4+Pj4gK0VDRFQsDQo+ID4+Pj4gRkFDUywg
RlBEVCwNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIEhNQVQsIElCRlQsIElPUlQsIE1DSEks
IE1QQU0sIE1QU1QsIE1TQ1QsIE5GSVQsIFBNVFQsDQo+ID4+Pj4gUFBUVCwgUkFTRiwgU0JTVCwN
Cj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIFNERUksIFNMSVQsIFNQTUksIFNSQVQsIFNUQU8s
IFRDUEEsIFRQTTIsIFVFRkksIFhFTlYNCj4gPj4+PiAtwqDCoMKgwqDCoMKgIC3CoCBOb3Qgc3Vw
cG9ydGVkOiBCT09ULCBEQkdQLCBETUFSLCBFVERULCBIUEVULCBJVlJTLCBMUElULA0KPiA+Pj4+
IE1TRE0sIE9FTXgsDQo+ID4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoCBQU0RULCBSU0RULCBTTElD
LCBXQUVULCBXREFULCBXRFJULCBXUEJUDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoCAtwqAgTm90IHN1
cHBvcnRlZDogQUVTVCwgQVBNVCwgQk9PVCwgREJHUCwgRE1BUiwgRVREVCwgSFBFVCwNCj4gPj4+
PiBJVlJTLCBMUElULA0KPiA+Pj4NCj4gPj4+IEFFU1QgaXMgQVJNIEVycm9yIFNvdXJjZSBUYWJs
ZSwgYW5kIGl0IGNhbiBiZSB1c2VkIGZvciBBUk0NCj4gPj4+IHBsYXRmb3Jtcywgc28gSSB0aGlu
c2sgQUVTVCBpcyBub3QgYmVsb25nIHRvICJOb3Qgc3VwcG9ydHRlZCIsICJPcHRpb25hbCINCj4g
aW5zdGVhZC4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBwb2ludCB0byB0aGUgY29kZSBpbiBMaW51eCB3
aGljaCBkb2VzIGFueXRoaW5nIHdpdGggQUVTVCwNCj4gPj4gb3B0aW9uYWxseSBvciBvdGhlcndp
c2U/IDspDQo+ID4+PiBhbmQgQVBNVCBpcyB0aGUgc2FtZS4NCj4gPj4+DQo+ID4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoCBNU0RNLCBPRU14LCBQRFRULCBQU0RULCBSQVMyLCBSU0RULCBTTElDLCBX
QUVULCBXREFULA0KPiA+Pj4+IFdEUlQsIFdQQlQNCj4gPj4+DQo+ID4+PiBQRFRUIGFuZCBSQVMy
IGFyZSBub3cgdXNlZCBmb3IgQVJNIHRvbywgcGxlYXNlIG1vdmUgaXQgdG8gT3B0aW9uYWwNCj4g
Pj4+IDopDQoNClRoZSA2LjMga2VybmVsIGRvZXMgbm90IHlldCBoYXZlIGNvZGUgY29uc3VtaW5n
IGVpdGhlciB0YWJsZS4NCg0KUGVyaGFwcyB0aGUgY2F0ZWdvcmllcyB7IlJlcXVpcmVkIiwgIlJl
Y29tbWVuZGVkIiwgIk9wdGlvbmFsIiwgIk5vdCBzdXBwb3J0ZWQifQ0KbGlzdGVkIGluIERvY3Vt
ZW50YXRpb24vYXJtNjQvYWNwaV9vYmplY3RfdXNhZ2UucnN0IHNob3VsZCBiZSBkZWZpbmVkLg0K
DQpNeSBvcGluaW9uICh3aGljaCBtYXkgYmUgdW5hbGlnbmVkIHdpdGggdGhlIG9yaWdpbmFsIGlu
dGVudCBiZWhpbmQgdGhlIGNhdGVnb3JpZXMpIGlzLCBJZiBhIHRhYmxlIA0KaXMgY29uc3VtZWQg
Ynkga2VybmVsIGNvZGUsIHRoZW4gaXQgaXMgc3VwcG9ydGVkLCBpLmUuIGluIHsiUmVxdWlyZWQi
LCAiUmVjb21tZW5kZWQiLCAiT3B0aW9uYWwifS4NCk90aGVyd2lzZSwgdGhlIHRhYmxlIGlzICJO
b3Qgc3VwcG9ydGVkIi4NCg0KPiA+Pg0KPiA+PiBEaXR0bzsgYXMgc3RhdGVkIGluIGFybS1hY3Bp
LnJzdCB0aGlzIGlzIExpbnV4IGRvY3VtZW50YXRpb24gY292ZXJpbmcNCj4gPj4gdGhlIGludGVy
YWN0aW9uIGJldHdlZW4gTGludXggYW5kIEFDUEkuIEl0IGlzIG5vdCBzb21lIGtpbmQgb2YNCj4g
Pj4gZ2VuZXJpYw0KPiA+DQo+ID4gSG1tLCBsZXQgbWUgc2VlLi4uDQo+ID4NCj4gPiBPSywgSSBj
aGVja2VkIHRoZSBhcm0tYWNwaS5yc3QsIGl0IGlzIHNheWluZzoNCj4gPg0KPiA+ICJEZXRhaWxl
ZCBleHBlY3RhdGlvbnMgZm9yIEFDUEkgdGFibGVzIGFuZCBvYmplY3QgYXJlIGxpc3RlZCBpbiB0
aGUNCj4gPiBmaWxlIERvY3VtZW50YXRpb24vYXJtNjQvYWNwaV9vYmplY3RfdXNhZ2UucnN0LiIN
Cj4gPg0KPiA+IFNvIGlmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCBpdCBpcyB0aGUgZ3VpZGFuY2Ug
b2YgQUNQSSB0YWJsZXMgYW5kDQo+ID4gbWV0aG9kcyB1c2FnZSBvbiBhcm02NCwgdG8gYWxpZ24g
d2l0aCB0aGUgQkJSLg0KPiANCj4gIlRoZSBwdXJwb3NlIG9mIHRoaXMgZG9jdW1lbnQgaXMgdG8g
ZGVzY3JpYmUgdGhlIGludGVyYWN0aW9uIGJldHdlZW4gQUNQSQ0KPiBhbmQgTGludXggb25seSwg
b24gYW4gQVJNdjggc3lzdGVtIC0tIHRoYXQgaXMsIHdoYXQgTGludXggZXhwZWN0cyBvZiBBQ1BJ
DQo+IGFuZCB3aGF0IEFDUEkgY2FuIGV4cGVjdCBvZiBMaW51eC4iDQo+IA0KPiBJIGRvbid0IHNl
ZSBob3cgaXQgY291bGQgZ2V0IG11Y2ggY2xlYXJlciB0aGFuIHRoYXQuIFllcywgcGhyYXNpbmcg
bGlrZSAiQUNQSQ0KPiBvbiBhcm02NCIgaXMgdXNlZCBlbHNld2hlcmUsIGJ1dCByZW1lbWJlciB0
aGF0IGluIGNvbnRleHQgImFybTY0Ig0KPiBtZWFucyAiQUFyY2g2NCBMaW51eCIuDQo+IA0KPiA+
PiBBQ1BJLW9uLUFybSBndWlkYW5jZSB3aGl0ZXBhcGVyLiBJZiBhbmQgd2hlbiBMaW51eCBhY3R1
YWxseSBzdXBwb3J0cw0KPiA+PiB0aGVzZSB0YWJsZXMgaW4gdGhlIHNlbnNlIG9mIG1lYW5pbmdm
dWxseSBjb25zdW1pbmcgdGhlbSwgdGhhdCBpcw0KPiA+PiB3aGVuIHdlIGNhbiBkb2N1bWVudCBz
dWNoIHN1cHBvcnQuDQo+ID4NCj4gPiBJZiB0aGlzIGlzIHRoZSBjYXNlLCB3ZSBkb24ndCBuZWVk
IGNhdGVnb3JpZXMgb2YgIlJlcXVpcmVkIiwNCj4gPiAiUmVjb21tbWVuZWQiIGFuZCBldGMuDQo+
IA0KPiBDZXJ0YWlubHkgdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4gcmVxdWlyZWQgYW5kIG9wdGlv
bmFsIGlzIHNpZ25pZmljYW50IGFuZA0KPiB1c2VmdWwsIHNpbmNlIExpbnV4IG1heSBmYWlsIHRv
IGJvb3QgYXQgYWxsIGlmIGEgcmVxdWlyZWQgdGFibGUgaXMgbWlzc2luZy4gSSdkDQo+IGFncmVl
IEkgY2FuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2Ugb2YgdGhlICJyZWNvbW1lbmRlZCINCj4gY2F0ZWdv
cnkgdGhvdWdoIC0gaXQncyBub3QgbGlrZSBmaXJtd2FyZSBjb3VsZCBtYWtlIHVwIFJBUyBzdXBw
b3J0IGlmIHRoZQ0KPiBoYXJkd2FyZSBkb2Vzbid0IGhhdmUgaXQsIGFuZCB3aGV0aGVyIFNTRFRz
IGFyZSBhcHByb3ByaWF0ZSBvciBub3Qgc2VlbXMNCj4gdG8gZGVwZW5kIG9uIHRoZSBmdW5kYW1l
bnRhbCBkZXNpZ24gb2YgdGhlIHN5c3RlbSwgcmF0aGVyIHRoYW4gYmVpbmcNCj4gc29tZXRoaW5n
IGFuIE9TIHNob3VsZCBkaWN0YXRlIDovDQo+IA0KDQpJIGFncmVlIHdpdGggUm9iaW4gdGhhdCBp
dCBpc27igJl0IGNsZWFyIHdoYXQgIlJlY29tbWVuZGVkIiB2ZXJzdXMgIk9wdGlvbmFsIiBzaWdu
aWZpZXMuDQpNYXliZSB0aGUgZGlzdGluY3Rpb24gc2hvdWxkIGJlIGJldHRlciBkaXNjdXNzZWQs
IGFuZCB3ZSBjYW4gbWFrZSB0aG9zZSBjbGFyaWZpY2F0aW9ucyBpbiBhIHNlcGFyYXRlIGNoYW5n
ZT8NCg0KPiBIb3dldmVyIHRoYXQncyBzb21ldGhpbmcgd2UgY2FuIHRoaW5rIGFib3V0IHNlcGFy
YXRlbHksIHNpbmNlIGl0J3MNCj4gb3J0aG9nb25hbCB0byB0aGlzIGNvbnRlbnQgdXBkYXRlLg0K
PiANCj4gVGhhbmtzLA0KPiBSb2Jpbi4NCg==
