Return-Path: <linux-acpi+bounces-8602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111A7994AB1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853C01F21C69
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC4190663;
	Tue,  8 Oct 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danelec.com header.i=@danelec.com header.b="SS0ZQv1C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E81779B1
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390942; cv=fail; b=pGRm+e7p/NbRL3jlAvJVg/sc00Ag6EEkj07VIA//8uCQs8+TjRwqOsI3/NN/W+FystILzByDZ8oaa8CLZmbaUpex9yGlIIOzCISrcMCle2SBpMujb0k4SfqUT9Ho7kHVCZ/xlKNLOyROO+gwnp3KHgbPWRumClwcz4O1ZAXsNl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390942; c=relaxed/simple;
	bh=4p0yKAAK2w9pl9LhtpYZ7Ra2d+GXUVRGJ0ZcdAQ3Y30=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tAtf/P8luTDYi5plznZjQDAIq413cU+fKsy+EXrxrVFaWHGf0YcJR4sUN/WAKm3nTDsJ/C+D/IiWi0B8sW0vGAgyAbXCZGsV7mHpazGSy0CnpZXMpyDT7UuOKDFYnPXYe1pm/qVDGU79aWPgmQZqfElEfvcfMqdzWpx/GMI+/Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danelec.com; spf=pass smtp.mailfrom=danelec.com; dkim=pass (2048-bit key) header.d=danelec.com header.i=@danelec.com header.b=SS0ZQv1C; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danelec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danelec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqhCzL4I+qwzGK+toUf91Qs3Ik3uQDsp6K+3cdG69GIHqEi4+nAUaJPgNI/tySeUlXPWUaY7MzCU9+vQpecssgONr0KBc2vmMxVgXi8QJJPng/Ho+SXFFizqqGWKjV87SdnMZeWsvJPfAjOcBkC/Dx4lXMmKagEnOLeqdJnYGsvUMiItj8XuUgnLmMYrw37cLAxS+IwgFL3heoVo9cMrtF0ofj4CYHxyk/Wqr6JGtfl0X6VsHFsRraLHceG6e1RNPxCLyiVqZZD0+M9ijdRknzkpyXagsGPMsmN1E2VSx7zwPJ5qc3lcw+vA1S3X10YoGKiY18U2J42vzTHMTSJE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p0yKAAK2w9pl9LhtpYZ7Ra2d+GXUVRGJ0ZcdAQ3Y30=;
 b=NvCIZVp29lOEZ0VQfeZQ/fKEp1hVcrzPPZ9/oL9m6JowkZYbjCOutiXN/5K85hqal4U3C8IXHSRoUcCbroz0JNMhGW4/16hiyFN6joUuJAo1GEijVmx0wTC5rPxi/zTkJA1UOn9y4eG6fHH3DUhYUgZoYzrOEe6dTe3b7lk/vixqM5Unc7jZGP1vJwaWhQVWJXvPFP1shs85D5faU9SFyicwnKplIxKe2PUyibjqAqu8nNAcBic21wWuOCGtr1gg02LxtC/Q9JDDNngwjFte8+7PheD7h1tU3fcvJMh8yrpUkEAZxufK43qVbS8h0JJkkwAXXjmm+J/GvdeDwyvQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=danelec.com; dmarc=pass action=none header.from=danelec.com;
 dkim=pass header.d=danelec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danelec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p0yKAAK2w9pl9LhtpYZ7Ra2d+GXUVRGJ0ZcdAQ3Y30=;
 b=SS0ZQv1COK47SFJeLi++UST6pqahi4HQyNMpBu6tkseVk9Zvv5EPCstS/s4K8Vd11k6JZkefIewP/n0U8u3ABlweV+eDQ4rFg2oDvm9iO94+u0zzZ6dRqun3ciy9JZO6ynKvYrN2yWdcRzwj7gPq0tPpWl5Y9P3y5N3uk8tswEfHKpaOR74itOWuqkCIp0CrL9H+h5D/Wh6ynFsuqPb+ZSgJz2+F++rD3Mx4/5smP1hHStE+SEAe5F3+eROHo98zDFhcbbq0w8ySfGRW6msV0OWTmbUjKeD9AXYs6y3+fRVmVSOJ59Popo06nA/vWG7O4dc1FSX6c9MFtSpZTy/YPw==
Received: from AS4P189MB2133.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:518::15)
 by PA4P189MB1261.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 12:35:35 +0000
Received: from AS4P189MB2133.EURP189.PROD.OUTLOOK.COM
 ([fe80::290d:81d4:f68d:41f9]) by AS4P189MB2133.EURP189.PROD.OUTLOOK.COM
 ([fe80::290d:81d4:f68d:41f9%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 12:35:35 +0000
From: Mikael Lund Jepsen <mlj@danelec.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Multiple ads7830 defined via ACPI all show up as ads7830-virtual-0
Thread-Topic: Multiple ads7830 defined via ACPI all show up as
 ads7830-virtual-0
Thread-Index: AdsZdsaJMeuKXLKkTEihGVJBY3jPVg==
Date: Tue, 8 Oct 2024 12:35:35 +0000
Message-ID:
 <AS4P189MB21333CF67856C181281114C5BA7E2@AS4P189MB2133.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-xink-handled: Yes
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=danelec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P189MB2133:EE_|PA4P189MB1261:EE_
x-ms-office365-filtering-correlation-id: 9a02eb80-b67f-4810-fecb-08dce795b557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjJxMmM1V3BFaUxBRElPaVloY1pyVnBPWUhhZU5lTzYzdHlpN0RBNCtPdHFP?=
 =?utf-8?B?MWFHZGxuNzdRYkxlcTRTMnpQQzI2eHdyamVFdGRKTVQ3eDB1Mkd2SERoaXV0?=
 =?utf-8?B?T3BpYW5sZlVMZ2V2clhZWWIwWEYwdmZxdkVhbFBSNi9HdStCNWZHdUxQa1RX?=
 =?utf-8?B?RmJ5UTdTYU1zODE3WU5Xa0YrMXBVNnNJWEJWM0JZNFFWb3BCN2RJQUdDTnp0?=
 =?utf-8?B?aFhhYTU0aWNPdUFuQmhTT012NnJ0VlUwWFVtWVQ0TUY3N0ZwMCthMlBVZVRY?=
 =?utf-8?B?TE1XamZaenpiMko5UEJxSjMzMGFaM2tzTTNFTW13TlptL1h0ZytOS1JrK1FQ?=
 =?utf-8?B?VzBnRjlZa2RvRVlTUXhDWHFhYmc4amh1Uk8rNFkwWHFNenlpUTBySys3dXIz?=
 =?utf-8?B?WlpGRHFVb1YyS2kwSk5kVEJDcURHNHdDTkpCZ3hqMDlUK1lhV01Nc3lnV01s?=
 =?utf-8?B?WjNDdDlTd2t2ck95cnl1U2Q4UDVGNC92T0dadllWUmhMVTE3d0VOZUlaZEg1?=
 =?utf-8?B?cVEyTUdLdzIvMlV2NDFFcVNONU5KSUNSTVJmUUZNSWp4dnV6SEN0N2hGV1RZ?=
 =?utf-8?B?MmVETFpEYnRpWjlSazNZMms3NDRkb2J3cjA2MnFjYTVOVkpBNXFiVUJsN05W?=
 =?utf-8?B?Qk9PMDk5cVM1bWhpYkxYbitnMi9NblExODBJQkdOOXkzaSszRmROUmIzcHFP?=
 =?utf-8?B?bmJDSnhvUXFNbWdwV3RNQ2NTYmtvSTBhcHZ2czlld1doOE0zb1N1ejNaY1hP?=
 =?utf-8?B?dnhaN3FzaytqS1Z5dmRLVENrdVVndzJYQ1o3QnNHanMzUkRCK3lrQXlFTWxT?=
 =?utf-8?B?SExaSFh2RUswdDNhL0ZINkZrYjJhS2VQZ2NDUEgxcUJxdHh0YklYcWMraXNR?=
 =?utf-8?B?NkU3R0V2UDNMYk5jb1lzbXNrSGdPSmxuLzJVV0tQVitYWnFYanRBaU9rcUZS?=
 =?utf-8?B?aWplbUQvRWlZZlBBZHU0a09HeGdpeVBWVkpqZjlTYWQrdWRUNmc3Y1piRlRa?=
 =?utf-8?B?SUFsd0NTYlRUKzBkZERrWHZXNlpyMDBhemFpbjdjV01vMUlZNkxQVzJhUjBE?=
 =?utf-8?B?RTMrZitVdTk4UVhCSjcwb1JNNHBlVzhFdW1YVmVSVXFSS3dHdHpPRnJFZnhM?=
 =?utf-8?B?VWtWWUllSDB5RVRwcHNpQnJwcDZycnkxZTdnZ2o4NDVzZzF0eE5ydnZIMm5H?=
 =?utf-8?B?OGRsTEdtODYzaUIyQjJTL3B3NDh4RTRaMVY1ZVpubmtoVmV1cUJHWnhNWEhX?=
 =?utf-8?B?UmczdmhjMUgvbUdEN2p6UXkrQkhreE1PVlBEQ1gyQjhxQ3ZVTEt0VGpPWHF5?=
 =?utf-8?B?WkhINXZSRXBSODQvYkpmUnVzcUlXOHNXR1dSdjBNUm90TUgrQ1NoOVd0Z01Z?=
 =?utf-8?B?SXgyejlZd3FiZFF5Z1pFemJPZ3FFQXRVOTRyN3dncmFJODdiZTVhU2g2QWMw?=
 =?utf-8?B?RE52eGZyZHJQNEs4VGVNKzdaV3BNOUF0elRvdXlrWWxnZHBOdENnQ0lUSUlq?=
 =?utf-8?B?SkYzSGJ4cTcvUXhoQ013UVVEYmVRTGh0MGR2SklramFHZlFYdkY5Y1ZnR00y?=
 =?utf-8?B?RG5oWWpYNFYvVjMxam1tbTdZVWJDRUhmSkVIWE9BNWs4SWhPYTU2dy9SaTdK?=
 =?utf-8?B?ZEFxSXZBdFN0RGNyWkw5T082UmRmTE1XOXR2UTJ0d2ZmZndOSWk1ZEk0bVRk?=
 =?utf-8?B?eVBZdWc4Kytmand2QkxRS3M1S25maFlOSnFPSkx2clRPenlOME9vejRFTW1R?=
 =?utf-8?B?KzNVQ1dTanl1ZHdPay9kY09hTkpBWk43OWZDMzhpbHFIbm03dzR2ZCtYdXF4?=
 =?utf-8?B?THliRm56NEs4V0EzUUZTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P189MB2133.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dytidGZqaEpUQmJCQ3Z0VkU4aDZzVGEzUFp5MHNQT3U3aURjczRxWnYrMG1E?=
 =?utf-8?B?WVBjT2lwb0c2aTkvZ21YSmwxVW5MTWlTN0NNQU9scm4yWW5SVHc1QktSRXZ2?=
 =?utf-8?B?RVNyb2lNUWluWkJxMk9NQUxpNjV1SFRZWk15R0dIMGtyWlVLQWNrcUZ2TVJv?=
 =?utf-8?B?c050cE1MbXQwZzNURWI5NkJZMWNXdnFadTNEK1dXa0o5N28rNE1vazlka0lY?=
 =?utf-8?B?bTBJbGJHOFBkL2NBTVdiZ01CbDg4WE82OFVCTEkvdVNCV1J0LzNQZW1qRDhw?=
 =?utf-8?B?Um9Rd2RjTUFQSWMzNXhvekR4UkVmRlVPbjJTMXBSa295SkV5QXk2RUFXOWlB?=
 =?utf-8?B?UjhzUEhaL2p0QjIveUhGZjFVMDR2RlZ5OEh6aG1vQVpBUklJUWJiSFZQajN4?=
 =?utf-8?B?U2J0QWJzODRCM3Fhd3dtaTVPNE5JUUdNRWdSRFVnZjBKeThpWVVwZGN2b29N?=
 =?utf-8?B?ZzBCalllYmlEdnpPWGJoV3YwUGlBdktVaSszRzRLckY3NVgrYjl2UkhyMi9E?=
 =?utf-8?B?TFNTeDRZeDFudnNmSXB2SGtMQlVORHdVdHVkYW42U0NjeVN1ZTlzMnNUbmxH?=
 =?utf-8?B?a0k1b0tKUWltaGNNMGlKdWdPY1JJdlpFb0VZdDJ2ZEladFl6VTYzVkFOdXdk?=
 =?utf-8?B?U0dhcDZJdUMwTjFEZUFpTTdWUUZiZHZkelNCV2gxb2VYQ2RCaTNMOXJtOVYx?=
 =?utf-8?B?NVpLL2NDZklOQmpUd296U2IxMCtDUmIvcmVLNG9WZHJSbmtyM1RlNG5NTERI?=
 =?utf-8?B?V05tK08yMnd4cXZ0WnYwMURMRHArbXZDWDlnblp0VXRoalJzRWtWbXUwdUFw?=
 =?utf-8?B?MjdCNEFBZGVZTnZuaFo3N0l4NnNHQUVZdWY4MDhRUDQ2R2dsUHpNNnFDTjl5?=
 =?utf-8?B?dUVqNTNMa1EwOGRyZ3RlUFNydEVmSGp4MzVXclMvQXF6YUJOSzFYWStBUlZz?=
 =?utf-8?B?a3FIckRiTmhQalpBZTNSRXplUDkyd3V4RnRIaHVwanhEdTZHY3dhbnVraElO?=
 =?utf-8?B?S3drcTF6cDlaR0UwT2haZDFYNDBPb0pHOW5YL3NNbXRmYTc5SmNyK0xham9R?=
 =?utf-8?B?N05VajNnSlN3ZVNseDd4UHZFR2lrNUt5TkR5c3lJZzMxZ1V1eGtTc1hXLzEz?=
 =?utf-8?B?Y2VHVi9yZ3hYWFFPd0lkaGM3Y1ZlRDdKczVaSGFCdDdHZ0tYZmdoT2ZxaGow?=
 =?utf-8?B?VkU0RUVPSkxoSHhEQXhrTm0rWWM1ZGFKdGtsZHNCcVdoM2h1Mm15STE3a05H?=
 =?utf-8?B?MjFUcjVGdDlkNVUzVzRSUXB0VVhGZjRlUFdLYUVLVCtGdEZjYkVHVmRIenBp?=
 =?utf-8?B?YldsK0JOTGhOdTJ1b2dOVzRTVDYwYWVPQnRDME5kVmpueFBJMGp6MWpST0ZS?=
 =?utf-8?B?alAzckV5RTBlODRmbDhSeEhQK0FrcVJ1anByV25VSGdkWXpvdlA0R09UUzh3?=
 =?utf-8?B?Z0o2aDFJV2g5dFExR1JPbmhSRVloQ3lXVm8rL2U3UERTV2ZkbnVsYjJheit4?=
 =?utf-8?B?SGhUNGJUVElrT3RUb2k2NitidW9rRXdueFpzRUczWGxodS9YQ0NCWlFNOXZy?=
 =?utf-8?B?aWxickV6VGpQQlBJUmIrQTl4OTlvaTVUZDhnNlI5MHV1TmR2T283a0NDQVZK?=
 =?utf-8?B?bXJSSDlzUitaUzdMbllJT3ZRVFZiSllNRThpeTBLblpDd29hbzNlZUoyZERF?=
 =?utf-8?B?RU9wMlJLR0NiRXpvL2h2bDc3dzNhZ29nUEFTOS9UVDlydjd4ZVdjdFVhU1po?=
 =?utf-8?B?Ni9sL0hMNVIzM1lINHc0a1Q1UDcvbC9GMGVMR0RMYjNlOTQ0OVh1UjB6SktS?=
 =?utf-8?B?OERLOXFXTG9Wd1F0VUpvbjAyc1grbHlUSXFDT2xDZzVwU3dlbjh4TWUvSWZD?=
 =?utf-8?B?K3dsdXR6dXBOd3pHTTlmWFY1VVdvRXZhY3FiR1RPQmEzMTIyQjhBVWNuMTV1?=
 =?utf-8?B?bVRPdzdIeHZPdzBlY09RZnA5bnZXeStPa2tpMStSVDFBemdqNVRBVlRkbk05?=
 =?utf-8?B?eVlldDZseFZsZ3p1ajNOSjdNdW1rdHdqSTZYVjVLQThxbFlQNVMyL2NOb1JV?=
 =?utf-8?B?SmdOeWtCRWs3ODROR2N3b252citDVjdGVmNFY2dhMllWcTl3RjBmdk1wWWdX?=
 =?utf-8?Q?+Zac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: danelec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P189MB2133.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a02eb80-b67f-4810-fecb-08dce795b557
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 12:35:35.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6bfedfe-b78c-47c3-8370-03356c3b6cf5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ll/oAV6PTRuuHNFlYumPrjTfIaD6+nR6L9U1mRyRKw0aTCFRPd4AfQ+3CA9ydCJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1261

SSdtIHRyeWluZyB0byBhZGQgQUNQSSBkZWZpbml0aW9ucyBmb3IgdHdvIGkyYy1iYXNlZCBhZHM3
ODMwIHNlbnNvcnMsIGJ1dCBzdHJ1Z2dsZSB0byBnZXQgdGhlbSBwcm9wZXJseSBkZWZpbmVkLCBz
byBJIGNhbiBwcm92aWRlIHNlcGFyYXRlIGxtLXNlbnNvcnMgY29uZmlnIGZvciB0aGVtLiANCkN1
cnJlbnRseSwgbG0tc2Vuc29yIHJlcG9ydHMgYm90aCBkZXZpY2VzIGFzICJhZHM3ODMwLXZpcnR1
YWwtMCIuDQoNCkkndmUgZm9sbG93ZWQgdGhlIGRvY3VtZW50YXRpb24gZm9yIEFDUEkgQmFzZWQg
RGV2aWNlIEVudW1lcmF0aW9uLCB1c2luZyBQUlAwMDAxIGFzIF9ISUQgdG8gbWF0Y2ggdGhlIGRy
aXZlciB2aWEgdGhlIGNvbXBhdGlibGUgcHJvcGVydHk6DQoNCkRlZmluaXRpb25CbG9jayAoIlRl
bGVtZXRyeUFEQy5hbWwiLCAiU1NEVCIsIDEsICJNeU9FTSIsICJNeVRhYmxlIiwgMHgwMDAwMDAw
MSkNCnsNCiAgICAgICAgRXh0ZXJuYWwgKFxfU0IuUEMwMC5JMkMwLCBEZXZpY2VPYmopDQogICAg
ICAgIFNjb3BlIChcX1NCLlBDMDAuSTJDMCkNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIERl
dmljZSAoQURTMCkNCiAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAgICAgICAgICBO
YW1lIChfSElELCAiUFJQMDAwMSIpDQogICAgICAgICAgICAgICAgICAgICAgICBOYW1lIChfRFNE
LCBQYWNrYWdlICgpDQogICAgICAgICAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFRvVVVJRCgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJmNGFh
MzAxIiksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBhY2thZ2UgKCkNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBhY2thZ2UgKCkgeyAiY29tcGF0aWJsZSIsIFBhY2thZ2UoKSB7ICJ0aSxh
ZHM3ODMwIiB9IH0sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAg
ICAgICAgICAgICAgICAgIH0pDQogICAgICAgICAgICAgICAgICAgICAgICBOYW1lIChfQ1JTLCBS
ZXNvdXJjZVRlbXBsYXRlKCkNCiAgICAgICAgICAgICAgICAgICAgICAgIHsNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSTJjU2VyaWFsQnVzVjIgKA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4NGEsIENvbnRyb2xsZXJJbml0aWF0ZWQsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAwMDAwLCBBZGRyZXNzaW5nTW9kZTdC
aXQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlxcX1NCLlBDMDAu
STJDMCIsIDB4MDAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVz
b3VyY2VDb25zdW1lciwgLCBFeGNsdXNpdmUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICkNCiAgICAgICAgICAgICAgICAgICAgICAgIH0pDQogICAgICAgICAgICAgICAgfQ0KDQog
ICAgICAgICAgICAgICAgRGV2aWNlIChBRFMxKQ0KICAgICAgICAgICAgICAgIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIE5hbWUgKF9ISUQsICJQUlAwMDAxIikNCiAgICAgICAgICAgICAgICAg
ICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKCkNCiAgICAgICAgICAgICAgICAgICAgICAgIHsN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVG9VVUlEKCJkYWZmZDgxNC02ZWJhLTRk
OGMtOGE5MS1iYzliYmY0YWEzMDEiKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UGFja2FnZSAoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUGFja2FnZSAoKSB7ICJjb21wYXRpYmxlIiwg
UGFja2FnZSgpIHsgInRpLGFkczc4MzAiIH0gfSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfQ0KICAgICAgICAgICAgICAgICAgICAgICAgfSkNCiAgICAgICAgICAgICAgICAgICAg
ICAgIE5hbWUgKF9DUlMsIFJlc291cmNlVGVtcGxhdGUoKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJMmNTZXJpYWxCdXNWMiAoDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg0YiwgQ29udHJvbGxlcklu
aXRpYXRlZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMDAwMDAs
IEFkZHJlc3NpbmdNb2RlN0JpdCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiXFxfU0IuUEMwMC5JMkMwIiwgMHgwMCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBSZXNvdXJjZUNvbnN1bWVyLCAsIEV4Y2x1c2l2ZSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKQ0KICAgICAgICAgICAgICAgICAgICAgICAgfSkNCiAgICAg
ICAgICAgICAgICB9DQogICAgICAgIH0NCn0NCg0KV2l0aCB0aGlzLCBsbS1zZW5zb3JzIGZpbmRz
IHRoZSBkZXZpY2VzLCBidXQgcmVwb3J0cyBib3RoIGRldmljZXMgYXMgImFkczc4MzAtdmlydHVh
bC0wIiwgc28gSSBjYW5ub3QgbWF0Y2ggc2VwYXJhdGUgbGlic2Vuc29ycyBjb25maWdzIGZvciBl
YWNoIG9mIHRoZW0uIA0KSWYgSSByZWdpc3RlciB0aGUgc2Vuc29ycyBmcm9tIHVzZXJzcGFjZSB2
aWEgc3lzZnMsIGl0IHdvcmtzIGFzIGV4cGVjdGVkLCBhbmQgaHdtb24gc2hvd3MgdHdvIHNlcGFy
YXRlIGRldmljZXMgb24gdGhlIGZvcm0gYWRzNzgzMC1pMmMtMC00YS4NClRoZSBhZGFwdGVyIG9u
IGFuIEFDUEkgZGVmaW5lZCBzZW5zb3IgaXMgYmVpbmcgcmVwb3J0ZWQgYnkgbG0tc2Vuc29ycyBh
cyAiVmlydHVhbCBkZXZpY2UiLCBub3QgIlN5bm9wc3lzIERlc2lnbldhcmUgSTJDIGFkYXB0ZXIi
IGFzIHdoZW4gcmVnaXN0ZXJlZCB2aWEgc3lzZnMsIHNvIGl0IHNlZW1zIHRoYXQgdGhlIGkyYyBi
dXMgaXMgbm90IGlkZW50aWZpZWQgcHJvcGVybHkgaW4gdGhlIEFDUEkgY2FzZS4gDQoNCklmIEkg
dHJ5IHRvIGRlZmluZSBvbmUgc2Vuc29yIChhZGRyIDB4NGEpIGluIEFDUEkgYW5kIHJlZ2lzdGVy
IHRoZSBvdGhlciAoMHg0YikgdmlhIHN5c2ZzLCBJIHNlZSB0aGlzIGluIC9zeXMvYnVzL2kyYy9k
ZXZpY2VzLw0KbHJ3eHJ3eHJ3eCAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgMCBPY3Qg
IDggMTI6MTcgMC0wMDRiIC0+IC4uLy4uLy4uL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1
LjAvaTJjX2Rlc2lnbndhcmUuMC9pMmMtMC8wLTAwNGINCmxyd3hyd3hyd3ggICAgMSByb290ICAg
ICByb290ICAgICAgICAgICAgIDAgT2N0ICA4IDEyOjEyIGkyYy0wIC0+IC4uLy4uLy4uL2Rldmlj
ZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1LjAvaTJjX2Rlc2lnbndhcmUuMC9pMmMtMA0KLi4uDQps
cnd4cnd4cnd4ICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAgICAgICAwIE5vdiAxMSAxMjoxMiBp
MmMtUFJQMDAwMTowMCAtPiAuLi8uLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxNS4w
L2kyY19kZXNpZ253YXJlLjAvaTJjLTAvaTJjLVBSUDAwMDE6MDANCg0KQW55IGlkZWEgd2hhdCBJ
J20gZG9pbmcgd3JvbmcgaW4gbXkgQUNQSSBkZWZpbml0aW9uPw0KDQpCZXN0IHJlZ2FyZHMNCk1p
a2FlbCBMdW5kIEplcHNlbg0KU29mdHdhcmUgRW5naW5lZXINCkRhbmVsZWMNCg==

