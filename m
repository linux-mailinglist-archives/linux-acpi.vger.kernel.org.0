Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4250686086
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Feb 2023 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBAHXL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Feb 2023 02:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjBAHXH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2023 02:23:07 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2133.outbound.protection.outlook.com [40.107.104.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EA3D0B7;
        Tue, 31 Jan 2023 23:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElfIqRzUwvsi6mgdTcAWl/P5UyPqYzjMFZ2yiIDTjFXq9WSrkniPP+q5klkGtNzAWe6QRscBCCOdsCwJ/XmSY4qw61TipN9+p9oKmyhdQrtsZoKiNFk6L97Hy3R6/Wdk9eVKolrCTRf6CID0BhNJAmQnsSJdF1Nbuah7Oe7ukEtCsVr1HEOBckuEvZG5PQN/hAtrSpb/bQ68661Pp4bVQpiSbOw1DX8S7KoY8rInudECQ8eCL69L+1NabSAdnZ4bMD0V2CcWu2djkZPMKCgNF9Xr774inXaihyKJCd4SfsIiRzZhZFm9+Y5wjqP49Jb1ni6h4IVzQIk+K+UbOf6/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU2oX/o9PrpfRhpAkgxwWiYoEddFBoMBrXE5Uy2ilIM=;
 b=YeEMRoY33KR6SCiAylxiwOeOAmqKRBKqA0YQuDMmx8SJXUtoyiBLovP1nKQ9bV38UFjh89CwWn8o2m2JMv2dgrgHBclQ000sbKLvWo9F+m+I+s3U1c0x9LeaLrVYuTam0MR4Vln+NnLP0H3ZVoZZNMCAKiS/K4G+4IFKNL5TGPabuCUBujnIWLjZCJqKu5TNY23Prk4FEFnfzaBHJCcLPq0g1b1UyNnTrIu496OWK32c/tgcnA/Y3UyuWhLCqXYFhDPD+y5d7ZowkmBQcAIleTAYOn81k6lWM3ijgtAL2mfz/ioDXjthHmPVmzbK+KJpwBCEYWGBsQtf3BxU2CZ5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visionappster.com; dmarc=pass action=none
 header.from=visionappster.com; dkim=pass header.d=visionappster.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=visionappster.onmicrosoft.com; s=selector2-visionappster-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU2oX/o9PrpfRhpAkgxwWiYoEddFBoMBrXE5Uy2ilIM=;
 b=S9TbzYwS8tUqNe0VYFWtMizfFzx1E5nUpi5oGSFRcefegJuCpW60STYLwQ9GS1ZmQ+sJaQnSzraaWg5RUuIBzudcmzlZ5ht62bFZVlGJixIqz9vIIu2BriFltufXq/4z1+M5P0EyUTxk9z4wAT5UbeiKfXV0+iwGgDJ+AwnR3yo=
Received: from DB9P193MB1755.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:24c::14)
 by PR3P193MB0927.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 07:23:01 +0000
Received: from DB9P193MB1755.EURP193.PROD.OUTLOOK.COM
 ([fe80::cbd7:4bbe:be46:2c74]) by DB9P193MB1755.EURP193.PROD.OUTLOOK.COM
 ([fe80::cbd7:4bbe:be46:2c74%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 07:23:01 +0000
From:   =?utf-8?B?VG9waSBNw6RlbnDDpMOk?= <topi.maenpaa@visionappster.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: ACPI BIOS bug breaks wake from sleep
Thread-Topic: ACPI BIOS bug breaks wake from sleep
Thread-Index: AQHZNHdbtzsqjn0OVEKjPU+oPYN5I664DCiAgAGm8AA=
Date:   Wed, 1 Feb 2023 07:23:01 +0000
Message-ID: <162871e81cada4a43654e91e80d40e94e6b42aa8.camel@visionappster.com>
References: <465f350f019667aa353bad8d1939a683fd400fc3.camel@visionappster.com>
         <8d9af4cf1adf0700c4c2092e66eb9af4eb934d4c.camel@intel.com>
In-Reply-To: <8d9af4cf1adf0700c4c2092e66eb9af4eb934d4c.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visionappster.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P193MB1755:EE_|PR3P193MB0927:EE_
x-ms-office365-filtering-correlation-id: 3ac69e55-cbf1-4572-3114-08db042526fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i297pVAGRrts+vtn/KtmPZfTFvxHHKPwW81B05Jw5hPGdAFk+HNmsdXbLmzylWx/WP8XNgaNUQBhWsHI7kxmYuHKV44sEyY/4d7JteBQLmTd/P89nZh46vaGxg1lMwXi+wYBxt+gp9eMez+JolB28MAD075Y9sVkG7SVgU7nTx/KN7lZK2CmBoWpiRTizesFzBmw3/NAtOPB6ClSCGQpkYYBlvC2I5I6FFkRWAB66tzRkBrbyvtIMRDrlUtXeFOcti3exT6iSHzyCf44MP8SbL2E/OKduRCNXTRPY3p+SW6S7yaCA/WDxcKVydzaAnMNtVBLueTn4dPQ0mG1Y/Ili0y9CjEADRv7BnkyAKS5F+5VSBImYH8hpOISpSsRkb2BtJ6Aa/LKHQF7H5468QedhBqQV+9YXTUMqi7jqJdnbdqXxeSEH1c2+S33LeeZ1YNIfvAAFrc2ucePguMJXJdzBiW/ESRTg4mKqwX4ReFm/ygC6RZikCVoxSw1LxiNztPEet1SZyhTNN5cK/rHnCacKCDRTchFpEH41JveeDRQNBkJqCzTbRtAQ87HY7ZzgustPw1p38RU2muNtemEmL5Q/V1dhsBX+p62UmTHZ4lIWP/0NsmX6TWSFWZFzY7TpcYcANjjzGmHZAdNJyo2X9eSrBIY+JujBdeHMQ3+4So3nxLx1xrZ1VdA9ycvP8zDBTMnNINwgunGMd/4rBWS39nJjK1ujMeBA3wAIp2UXIt1R+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P193MB1755.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199018)(41300700001)(122000001)(85182001)(36756003)(85202003)(64756008)(110136005)(91956017)(66946007)(8676002)(316002)(66476007)(8936002)(66556008)(66446008)(76116006)(5660300002)(38100700002)(86362001)(38070700005)(6506007)(186003)(6512007)(966005)(71200400001)(66574015)(2906002)(478600001)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FUWkh1WnZ5bk9NSnhhekVGMlNBZ0dCZHIxdGpFZTBQK3V2RkIwS1JBYVE3?=
 =?utf-8?B?aHMreng1TE82UTFpdjhIS1JXSENCUlZScHdEUm43N2sxSGd4Tk5hemdTK2pF?=
 =?utf-8?B?Q0hXQUlsS2ZVelBiUzQ2Tk1UcWc3Q3EzSDZ1VDNqbVBoOVpqRkNhb0w4U29R?=
 =?utf-8?B?U3pnTDd2b0xUNVJyWko3NkI0bVA4RndrWDh6ZUdUN1Uxc0NxY1JRdlUwd1Zs?=
 =?utf-8?B?KzRFRjBGQ29TWExlcnR1ZWplU0NRdWtaRzVDV3ErYzZQL1h4WjVKVkp0TzdD?=
 =?utf-8?B?RVFielhtbkRXeWRiMEJHdnNHUnhzYkpSYzcwSVZGQ3BGZGNjNmdDUUs2R1ox?=
 =?utf-8?B?VzVxdDQ4eGFQbnlWamRuQS9DU2lkRmI3azk2blY4bjIxa3U5YmE3ZHVuRVZF?=
 =?utf-8?B?ZnU1RFBPdktQUlpmTVd3VWhEQ3ZJWVFBOHI3ZjkzTlViekdNaURkSFp4NStN?=
 =?utf-8?B?NmtRVU8zMzBRT3k1cnljajZoMmRLZ1JrUUFLbW9qTVJHSC9BemdoU1JVQ29r?=
 =?utf-8?B?dDM0R1cwK1ZtOWpKMExtcWp3SW5JbVBrSlZjaG9VcjZTZXlBV1NiQnpxc1J6?=
 =?utf-8?B?S0EzK3QzdWJCRjFUQkpSbEF3Tk1EYXA5djMxYTl3eGE5K3IvYlo1T2ZzL1NT?=
 =?utf-8?B?VjlWa2Ftanl1SThhNlRBOTlEd0xiZ0pRMEdqbWdkeGxlLzBkbWpEbWVtY3kr?=
 =?utf-8?B?UEQ0L0k4T1FpbU1xWmYxS3B4aVhPKzJYTWU5dU92Vm1sY0VtYXVvT2hqOFpo?=
 =?utf-8?B?aS94MDFhb2tCWGpHM05UOWJZQURiY1lSeWFWakJnaENpdjlOWVA4NXQ1ajdQ?=
 =?utf-8?B?MDZsYnpzYWVIMHQvWHVVM0lKRjlTbElOaGNuTVRsNmJwTjljRzZ4OW92Ym1x?=
 =?utf-8?B?ZlNVKzJjSzk4MitrOTZjeE9aNGRCT0JBMG92QS9saGZFMkhjYS9NNXFhMk01?=
 =?utf-8?B?SzIrQ2IxSVlMNWE1RFdQNURVM09MSGVGZnJKSUQrV3F6Z1poamhFSnJsL05V?=
 =?utf-8?B?T3BwUnRQOGVma29CWHFyZlo5NDV4T3VzcVQyYWd5dk5LMDNQZWhXdkRjSFds?=
 =?utf-8?B?RTdIWmtndDNlbE9iR1FzeWFweDhxejVTTlNqcnF4WTVTck1sWkgyMmNFbWFF?=
 =?utf-8?B?d0kya043aUMvQmNXSnFCYlA1aGduS1dBL09HNVBGS1RHeUh1Wi9hSVZ2VjZG?=
 =?utf-8?B?a252Tmh5WHF6VHVodVBZbFJuWkJMUUo1SGtaNXhuQmZvSDZhM2NDdmRkbTJS?=
 =?utf-8?B?Q2FUcHZ1RHZSMHFXbVl0SWdMRVJTcVRGZmpyazlmaVBQTXRMaW1qZDFTMmVk?=
 =?utf-8?B?cXdxTTVzNktiQVUvcEU5dEQ1OHFIbGdFM0NjSGVhYnF1ZStGQXZEbXVLY3Ro?=
 =?utf-8?B?SWJOaXFWNmNiSEo3eVRJcTBMWWtzZTJiWVhkUk9ncDg5R2JOa000d3JGbVdL?=
 =?utf-8?B?VFlZUG1mTTR2TUIrM2IvdFpTOFdLL2JONUtrbXMrZmVRN2ppMVU0MWhGUjhF?=
 =?utf-8?B?YWVhd3hZSTZKMXc2bjcycFNtTFJ5VGNnRE5EWEJqc0VNMnJQZFIrL0h6dHJt?=
 =?utf-8?B?clZKaysxVmtvRkRZUjJaOW82aFJmaUk5THh6ZmRRTDZEUnQyYmd5YXZRaVZw?=
 =?utf-8?B?TXZBQ1Fkb0lhUU9JYjAzNUVXQmFYS1Z2aG9VS3RndE8rTzY0eWsrb3J2NU5n?=
 =?utf-8?B?NU1vZFVYMy90TWpnSHVwNXJjZWZvSnlQQTgvaUZ6WFhncmZBKzFrdzY2dlZm?=
 =?utf-8?B?Q1poMWFjTDlCWGhCbWNpa2tBNjRIT1cxMG9PeEp5QnJJRFk2Y2c5Qnp0RXp0?=
 =?utf-8?B?czJFUENaUE9BOHRDNDZlNC9PaXBkNFNoMzV4U3ZCS3J3VWF3Vm9SblIyc2JJ?=
 =?utf-8?B?bFBvdWRSNFo1YUJoUmNZUW5zdGpzbHlTdklxZVZLNksydXJoNFV4V0hsZVVV?=
 =?utf-8?B?TU15ZjNRQUtZUnFkakhLY05IK096WDlVVVgvNWJzSGZWSk1zQWxQTm5RS2pW?=
 =?utf-8?B?ZCtZeDR2NENHclR2UW8zSElrMEdMMW9OMWdEN2VsRHRsQ256aCsvTlMzdlJi?=
 =?utf-8?B?VFNzd0pmRXRjQW1UcWhWVGNNSVJOSGF4d0E4a3lpTEZkT2t6VHB4Nml2UmZw?=
 =?utf-8?B?N3F6eVdDZ3Z5TzFLRmRpUW1DUWRVSHp3SEZlQXpmWktSM3I4bjFtWXIvdUdH?=
 =?utf-8?B?NFBjeldBc0lDL0RGd2dHYzNPWFNkNVN4QnVWcmNVL3hCb2pGTm51Ukt4b0tx?=
 =?utf-8?Q?Vzu8hFvQ1cQNucOei3P4VVGh+0Iv/VfHwFWlAcI2VQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80ECE76F7C0D994BBCFE441CDB359F88@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionappster.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P193MB1755.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac69e55-cbf1-4572-3114-08db042526fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 07:23:01.7329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2c9dc36e-3126-45af-85b8-9d3f8a550ef5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFSPjX2TW4ddyj/zKLUOHIFlN/900dwnF/lYs0IIzpnyagswZbhJvhhwuzl/9slY1ShsG5OSjTaLs8AfpcKE5BX8IbgNIJ3QVIVy5ATc4Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0927
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIGFkdmljZS4gSSBpbnN0YWxsZWQga2VybmVsIHZlcnNpb24g
Ni4xLjguIFRoZSBwcm9ibGVtIGlzIHN0aWxsIHRoZXJlLiBUaGUgdXBkYXRlIGRpZCBob3dldmVy
IHNvbHZlIHNvbWUNCm90aGVyIGlzc3VlcyByZWxhdGVkIHRvIE52aWRpYSBkcml2ZXJzIGFuZCBp
dCBzZWVtcyB0aGUgR1BVIG5vdyB3b3JrcyB3aXRoIENVREEgYXQgbGVhc3QuDQoNCkFkZGluZyAi
bm9tb2Rlc2V0IiB0byBrZXJuZWwgYm9vdCBwYXJhbWV0ZXJzIGhhZCBhIHN1cnByaXNpbmcgZWZm
ZWN0OiB0aGUgc3lzdGVtIGZyZWV6ZWQgd2hpbGUgYm9vdGluZyB3aXRoIGEgVUJTQU4NCmVycm9y
LiBJIHNlZSB0aGlzIG9uIG15IHNjcmVlbiBqdXN0IGJlZm9yZSB0aGUgaGFuZzoNCg0KQUNQSSBC
SU9TIEVycm9yIChidWcpOiBDb3VsZCBub3QgcmVzb2x2ZSBzeW1ib2wgW1xfVFouRVRNRF0sIEFF
X05PVF9GT1VORCAoMjAyMjAzMzEvcHNhcmdzLTMzMCkNCkFDUEkgRXJyb3I6IEFib3J0aW5nIG1l
dGhvZCBcX1NCLklFVE0uX09TQyBkdWUgdG8gcHJldmlvdXMgZXJyb3IgKEFFX05PVF9GT1VORCkg
KDIwMjIwMzMxL3BzcGFyc2UtNTI5KQ0KQmx1ZXRvb3RoOiBoY2kwOiBNYWxmb3JtZWQgTVNGVCB2
ZW5kb3IgZXZlbnQ6IDB4MDINCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpVQlNBTjogYXJyYXkt
aW5kZXgtb3V0LW9mLWJvdW5kcyBpbiAvYnVpbGQvbGludXgtNi4xLjgtcmNWcVNuL2xpbnV4LTYu
MS44LTYuMS44L2RyaXZlcnMvYWNwaS9hY3BpY2EvZHN3ZXhlYy5jOjQwMToxMg0KaW5kZXggLTEg
aXMgb3V0IG9mIHJhbmdlIGZvciB0eXBlICdhY3BpX29wZXJhbmRfb2JqZWN0ICpbOV0nDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KDQpCUiwNClRvcGkNCg0KDQpPbiB0aSwgMjAyMy0wMS0zMSBh
dCAwNjowOSArMDAwMCwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gVGhpcyBzZWVtcyBsaWtlIGEgZ3Jh
cGhpY3MgaXNzdWUuDQo+IFBsZWFzZSBjb25maXJtIGlmIHRoZSBwcm9ibGVtIHN0aWxsIGV4aXN0
cyB3aXRoIExBVEVTVCB2YW5pbGxhIGtlcm5lbC4NCj4gSWYgeWVzLCBwbGVhc2UgYm9vdCB3aXRo
IGtlcm5lbCBwYXJhbWV0ZXIgIm5vbW9kZXNldCIgYW5kIHNlZSBpZiB0aGUNCj4gcHJvYmxlbSBp
cyBzdGlsbCB0aGVyZS4NCj4gDQo+IHRoYW5rcywNCj4gcnVpDQo+IA0KPiBPbiBNb24sIDIwMjMt
MDEtMzAgYXQgMDY6NTIgKzAwMDAsIFRvcGkgTcOkZW5ww6TDpCB3cm90ZToNCj4gPiBIaSwNCj4g
PiANCj4gPiBJIGhvcGUgSSdtIG5vdCBicmVha2luZyBydWxlcyBieSBwb3N0aW5nIHRoaXMgcXVl
c3Rpb24gaGVyZS4gSWYgSSBhbSwNCj4gPiBjb3VsZCB5b3UgcGxlYXNlIHBvaW50IG1lIHRvIHRo
ZSByaWdodCBmb3J1bT8NCj4gPiANCj4gPiBJIHJlY2VudGx5IGJvdWdodCBhIG5ldyBsYXB0b3Ag
SSBhc3N1bWVkIHdhcyBjbG9zZSBlbm91Z2ggdG8gb3RoZXIgSFANCj4gPiBsYXB0b3AgbW9kZWxz
IHRoYXQgd29ya2VkIGZpbmUgd2l0aCBMaW51eC4gSXQgYXBwYXJlbnRseSB3YXNuJ3QuDQo+ID4g
SGFyZHdhcmUgc3BlY3M6DQo+ID4gaHR0cHM6Ly9zdXBwb3J0LmhwLmNvbS91cy1lbi9kb2N1bWVu
dC9pc2hfNTk5NDY0MS01OTk0NzA1LTE2LiBJIGhhdmUNCj4gPiB0aGUgbW9kZWwgd2l0aCBhbiBJ
bnRlbCBDb3JlIGk3IDEyNzAwSCBhbmQgTlZJRElBIFJUWCBBMjAwMC4NCj4gPiANCj4gPiBJJ20g
cnVubmluZyBLdWJ1bnR1IDIyLjEwICh0cmllZCAyMi4wNCBmaXJzdCkgd2l0aCBrZXJuZWwgdmVy
c2lvbg0KPiA+IDUuMTkuMC0yOS4gSSB1cGdyYWRlZCB0aGUgZmlybXdhcmUgdG8gdGhlIGxhdGVz
dCB2ZXJzaW9uIGZvdW5kIG9uDQo+ID4gSFAncw0KPiA+IHNpdGUuIFRoZSB2ZXJzaW9uIGlzIG5v
dyBCSU9TIFU5NyBWZXIuIDAxLjA0LjAxIDEwLzI1LzIwMjIuIFRoaXMgaGFkDQo+ID4gbm8NCj4g
PiBlZmZlY3QuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0gaXMgdGhlIGxhcHRvcCB3b24ndCB3YWtl
IHVwIGFmdGVyIGJlaW5nIHN1c3BlbmRlZC4gVGhpcw0KPiA+IGhhcHBlbnMgaXJyZXNwZWN0aXZl
IG9mIHRoZSB3YXkgdGhlIHN1c3BlbmQgaGFwcGVuZWQ7IGNsb3NpbmcgdGhlIGxpZA0KPiA+IGFu
ZCBleHBsaWNpdGx5IGludm9raW5nICJzeXN0ZW1jdGwgc3VzcGVuZCIgaGF2ZSB0aGUgc2FtZSBl
ZmZlY3QuDQo+ID4gT25jZQ0KPiA+IHN1c3BlbmRlZCwgb3BlbmluZyB0aGUgbGlkIG9yIHByZXNz
aW5nIHRoZSBwb3dlciBidXR0b24gd2lsbCBjYXVzZQ0KPiA+IHRoZQ0KPiA+IGtleWJvYXJkIGJh
Y2tsaWdodCB0byB0dXJuIG9uIGZvciBhIHdoaWxlIGFuZCB0aGUgc2NyZWVuIHRvIGZsYXNoIGEN
Cj4gPiBmZXcNCj4gPiB0aW1lcy4gSSBhbHNvIHNlZSBBQ1BJIHJlbGF0ZWQgZXJyb3IgbWVzc2Fn
ZXMgcXVpY2tseSBmbGFzaGluZyBvbiB0aGUNCj4gPiBzY3JlZW4uIEkgdG9vayBhIHZpZGVvIHRv
IGNvbmZpcm0gdGhleSB3ZXJlIHRoZSBzYW1lIEkgc2VlIGluIHRoZQ0KPiA+IHN5c3RlbSBqb3Vy
bmFsLg0KPiA+IA0KPiA+IEkgYXR0YWNoZWQgdGhlIChob3BlZnVsbHkpIHJlbGV2YW50IHBhcnRz
IG9mIG15IHN5c3RlbSBqb3VybmFsLiBUaGUNCj4gPiBmaXJzdCBlcnJvciBhcHBlYXJlZCBkdXJp
bmcgIm5vcm1hbCIgb3BlcmF0aW9uIGJlZm9yZSBJIGNsb3NlZCB0aGUNCj4gPiBsaWQuDQo+ID4g
VGhlIG5leHQgY2h1bmsgb2YgdGhlIGxvZyBpcyB3aGVuIEkgY2xvc2VkIHRoZSBsaWQsIGFuZCB0
aGUgdGhpcmQgb25lDQo+ID4gd2hlbiBJIHJlb3BlbmVkIGl0LiANCj4gPiANCj4gPiBJIGRvbid0
IGFsd2F5cyBzZWUgdGhlICJMaWQgY2xvc2VkIiBtZXNzYWdlIGluIHRoZSBsb2csIGJ1dCAiQUNQ
SQ0KPiA+IEJJT1MNCj4gPiBFcnJvciAoYnVnKTogQUVfQU1MX1BBQ0tBR0VfTElNSVQsIEluZGV4
ICgweDAwMDAwMDBGRikgaXMgYmV5b25kIGVuZA0KPiA+IG9mDQo+ID4gb2JqZWN0IChsZW5ndGgg
MHgxMikgKDIwMjIwMzMxL2V4b3BhcmcyLTM5MykiIGlzIGFsd2F5cyB0aGVyZS4gU2FtZQ0KPiA+
IGdvZXMgdG8gdGhlIHBhcnQgdGhhdCBzdGFydHMgd2l0aCAiWyBjdXQgaGVyZSBdIi4gSXQgaXMg
YSBiaXQgaGFyZCB0bw0KPiA+IHN5bmNocm9uaXplIHRoZSBsb2cgYW5kIHRoZSBwaHlzaWNhbCBl
dmVudHMsIGJ1dCBpdCBzZWVtcyB0byBtZSB0aGF0DQo+ID4gdGhlIGVycm9yIG1lc3NhZ2VzIGNh
biBhcHBlYXIgZWl0aGVyIHdoZW4gSSBjbG9zZSB0aGUgbGlkIG9yIHdoZW4gSQ0KPiA+IG9wZW4g
aXQuDQo+ID4gDQo+ID4gDQo+ID4gTXkgcXVlc3Rpb25zOg0KPiA+IA0KPiA+IDEuIElzIHRoZXJl
IGEgd2F5IEkgY2FuIHdvcmsgYXJvdW5kIHRoaXMgdXNpbmcga2VybmVsIGJvb3QgcGFyYW1ldGVy
cw0KPiA+IG9yIHRoZSBsaWtlPyBJJ20gYXNzdW1pbmcgZGlzYWJsaW5nIEFDUEkgd291bGQgbWFr
ZSBpdCBkaXNhcHBlYXIsIGJ1dA0KPiA+IHRoYXQgaXNuJ3QgYW4gb3B0aW9uIGZvciBhIGEgbGFw
dG9wLg0KPiA+IA0KPiA+IDIuIFdoYXQgd291bGQgaXQgdGFrZSB0byB3b3JrIGFyb3VuZCB0aGlz
IGluIHRoZSBBQ1BJLXJlbGF0ZWQga2VybmVsDQo+ID4gc291cmNlIGNvZGU/DQo+ID4gDQo+ID4g
DQo+ID4gLSBUb3BpDQoNCi0tIA0KVG9waSBNw6RlbnDDpMOkDQpDVE8sIFZpc2lvbkFwcHN0ZXIN
CiszNTggNDAgNzc0IDc3NDkNCg==
