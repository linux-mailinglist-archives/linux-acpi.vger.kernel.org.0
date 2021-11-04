Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26E444F7F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDHRG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 03:17:06 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:8920 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhKDHRF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2021 03:17:05 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 03:17:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636010069; x=1667546069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pL3ttmLyNKLAdQeoLIE02DFE/T+8keZ0rsvaT2JB8RI=;
  b=OtIHeH4Dqs0lqw+0mZ6xEezMPiPB55jauaCuYHBI6DGE+WNJIo1iXbpJ
   IzfFRwWYCC/vtQqaUo8oeFj3zFO4kNVyuJLLeFs3YpsQ+EsaeesCHCzKs
   cKN2uQkEV9LC25RA0yayIorlLNyHmneejjm0t51xP8KROL2ONHv6uff5o
   7jZpvOoiByWiPps3FQy6/vmx2/lXmDqEMOlSRUy3W11Ltt9HCJtntn5Gj
   rioVAGN1fKfv52Sk4+D4pCyz36vQWZ4Cy8OiTDvJLskj44Y19B3T0+Wf0
   waupdEcdqc4hbQI3anzEAPUgaS9lrIRTec+eyr5V5ffpfdSP2+EGd01va
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="42511327"
X-IronPort-AV: E=Sophos;i="5.87,208,1631545200"; 
   d="scan'208";a="42511327"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 16:07:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMkkuvi5ae3fNoHitsk0/pcto2qzszfD3ywb3HJVw4dN01VvafsTm8oojvhTzE4aDjzazc+qo4/vl2Ri401fifhLXwKCNIJby/VktHzVYO76NCSaekE0jhcI4iuuXzo/fOAh49QpcuEoHzCZZ21oAynWHrZ0WC+y29alHsjUj//50E3avVtoT05RSBuF6vHxCpsy6uNOR2+IXl0pXkzjn/2cAciDMzzSaoeP1comzUB9YiWDdjYOkMK5T3EtsA+6hYbYuZvqO58TxJje0xIcpisBzsKx6cXt7TCliYttneQXTsgjIlFA8Nd7omnwT0jL8EGbMW+FH8H9jcE2IPSTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMhn/3+L98/YCmPZ9jmzrOM6k73EVqQDziXxxwgFyME=;
 b=hNO21Toith7qdXilvzRJGhLjoPPUyEubyKQoDepQgLJvx4V2iF/JglLBnvW981tLK9DMziq+fFwC+9tJ+nYDB1rIvc/sTGNvMn0yikB0LAORCANKSqZTod8aaEYaaieL/+EJlZxdmI/2S9MYma81fOyfKiFs0gMGuOc53ZVN0cY88KgGc52pgB8sA4f/35Hh9BHdRH/wLgZMgPrS+UPQF8S1HQX1gpf5CJ6BExzcRQnyIE8LDGM9SrAoHTW0VnOWXJ1hUnks3hO2LtEISguFIMtoV4FJ4lZaQjzksuKdTNb3d8d8y4KlOixuBWsVUo0NT60mkQzDj7Fe5wC/FKnGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMhn/3+L98/YCmPZ9jmzrOM6k73EVqQDziXxxwgFyME=;
 b=rDXR+97Swp4z3w0y2euI5pj+p7MnpfFEBO9X3xpSVBFo34FTp460wKlaQUy26TDrDglv0tGWIIf/2CnuvEkXeb+luwzxomsn1jBxRqkDMuy965FPNcmIna8lmqUTlYvIe2W/x146zZyuc29KiwaXzgLT9TMOG9xD0IQV88FSwzY=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYCPR01MB5805.jpnprd01.prod.outlook.com (2603:1096:400:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 07:07:06 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef%3]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 07:07:06 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "'lorenzo.pieralisi@arm.com'" <lorenzo.pieralisi@arm.com>,
        "'guohanjun@huawei.com'" <guohanjun@huawei.com>,
        "'sudeep.holla@arm.com'" <sudeep.holla@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Thread-Topic: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Thread-Index: AQHXyj6Hgz1OGMPqUUClqTokcEL2AKvyn4RQ
Date:   Thu, 4 Nov 2021 07:07:06 +0000
Message-ID: <TYCPR01MB6160403C510AE93C1EC2635DE98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211026075257.3785036-1-ishii.shuuichir@fujitsu.com>
In-Reply-To: <20211026075257.3785036-1-ishii.shuuichir@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MDlhNDQ2NDktMjAzMi00N2VmLWFhNjAtZGQ1?=
 =?iso-2022-jp?B?YTM4ZjBiM2Y1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMDRUMDE6MTk6MjRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f82172-d504-4db9-d37a-08d99f61b5d8
x-ms-traffictypediagnostic: TYCPR01MB5805:
x-microsoft-antispam-prvs: <TYCPR01MB5805B11ACCC0FEA210DD6CF0E98D9@TYCPR01MB5805.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dO9Z/cmI8zbc1BKhker4Djm2VV0w7Ea2gzAG/COBiNjoC39QmgIUGF+7QZxoQHHO4Qm3jRYgLKOm6rvTuDXWqOESJB75hkUuxyP2BNDIKjkA2crNbawzZeJWb3B0oIbKQHI3nOG2bp5sPY2Is3C+ZnVT9fl1IZ64K1Ux7HVnnjvdJ4NpaZnIIWmkhrR2UrBAd6/IJ6IWl6QUA/yPIaQo/SC8lFKvHMtDUXFBGB1DcSBcWNxTBvMlXKiIjpYHOufIKJ6pX/Nj15rU3e12omroznsBYjb7kWzKN5hOOdq9fZ5MdrW4wkG4m5eNMosYBYjgeJvqB6yuL4eCFHfQ69GX1KzI2UDAEK8wfhkwj83KK6DJc/5HXMfnzGkOfZbButKV8dm+9nPd+I72W0EUTX3f7gznt5BEWADZhISrRoCXpGETSyJtk4fJ694XIdM4pVn+mXxXikNjuNwqWZF0H2h+SGB1hslujQX17BOEGsbniZChQYdmKZrQxHm/Xo0j7VviJ7ekk9nhIl0qRq7imAMqvYljm6lTrCoHYnF1sAiJ6f1U54WhEOBLTL4Y1fZktbJEEIhMlahqrKDnO7ZaYkRjwzHgghITaelqgm/EmS8r2r6fvpnDyT9uOj355IRzSA3LqASpSGSVMi2lHaspWyRmBtMqzZ2Ip8d4Sx3DfhGsop/wccgGArmwhtXhksyxvmTvQsIvGtSLSOIclALnWBYfB8DiOmq8WBX4jRCC5Rt8U4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(86362001)(9686003)(55016002)(2906002)(66476007)(64756008)(66556008)(66946007)(66446008)(107886003)(921005)(5660300002)(52536014)(71200400001)(82960400001)(38070700005)(4326008)(85182001)(316002)(508600001)(53546011)(122000001)(110136005)(7696005)(6506007)(7416002)(8676002)(38100700002)(76116006)(26005)(186003)(33656002)(8936002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Nkh6bzhNUDJVOHZhRW1xeFo2RXM4MmdYc0JlUU9ObWJKOXpzeXFhbjZB?=
 =?iso-2022-jp?B?MFB4MnorWWJNWGIxR2VBNTN0cm1UaC9vUmM1b0kyOHdUd01hWnY0d0Zm?=
 =?iso-2022-jp?B?TVN5MEdzVGt3RjY0QWhxTmgwc3hkSDJlVWRDdjFuT2pxWWwrUVFScU42?=
 =?iso-2022-jp?B?V2Y0TzQ1bjR4UGFlUEhHTWdHZzdjZld3SVFRY21RMGwzVEkzZXA0UVlM?=
 =?iso-2022-jp?B?SVZ5R2oyYlVJOHByYmgzUXVTbFMzR096L0V2VzEvZmZLWFk5aVduUmxX?=
 =?iso-2022-jp?B?Slh6Zmc2aUVvMURxZ21YSlAzN016VlFBRURFajlWUklQQ0pMQTd2VE5Z?=
 =?iso-2022-jp?B?eEVSVkhCT2U0d2QvUzlEREQ2UHVkN3p1Sjk1djNzMkRsMG45TFdOajNl?=
 =?iso-2022-jp?B?aFQ2TUJVN2txdm9MNFdGUXNZaVZSWnFHckZXTUN3bE50bERNbVRWS08y?=
 =?iso-2022-jp?B?S2JYVW05Q21KOUVzUS9ycFVqcUIrRm1ONDlsQlV6TitFb3ptTkh4VFho?=
 =?iso-2022-jp?B?OVpuSDVLQ2lzVXpBZy9Cd29Oa1pVQjRaSi9wRmtMWXVQU2RPVElpUDdj?=
 =?iso-2022-jp?B?NUxwYVFneDN0cmtZU1FFd1NmdUUveG9IbG9UWFoxbW0rVk5aaWM3VnYv?=
 =?iso-2022-jp?B?VmZONS9lb0dOSXBTdW9zM1RURmJzTzFUdHBwbDBMM3R2Zk84bnhNTEZr?=
 =?iso-2022-jp?B?ekdNUGozNzc5N3R2SllqdUpVeVJlM3IwaUZ5M3RtWnFJbkx5NVBpckxK?=
 =?iso-2022-jp?B?QnNOdTJmbVJub3NVbFNpeXhmQzJ1LzUyNTlQWVZ6dzYvUlZuVnBZQnRT?=
 =?iso-2022-jp?B?RnNlaVMyb3JpS2kyOWRkR0YwWGJmTHhmRTdKOWFwOW8zSURBTDdaQmdV?=
 =?iso-2022-jp?B?TitXU0hVeGFLcTBoOWZpWHdqR2NyTmhMZVRPV3hlMWV3cEEvYUkrOXhS?=
 =?iso-2022-jp?B?ZGdUUjlKaEVVeDFMcTg1dHRlL2dRNFNnVisyekRzZzJkcGZzR0tvK2Fw?=
 =?iso-2022-jp?B?dldwNHcxRDdwRlR4RHhSaExhb0tFNDl3ZzI3b3VkYkpBSWR1N1lJTm5i?=
 =?iso-2022-jp?B?QXh3ZFJrMGNJZWJnN1VtQWpXYTJpVERpL2JXcTd3K2J2VVREN255T2tI?=
 =?iso-2022-jp?B?TnE1TnpSb2NsM2ljZUZHUGZFTTE0WURZUmg4emlXbVB5UjhyRE05SnFW?=
 =?iso-2022-jp?B?OXVJdlJJdTlXOTJ5QnloOTZGTkhOb3JuVWlIT05Dc3pVZ3VGU2J2cVFz?=
 =?iso-2022-jp?B?dEZNaC9wNVgrSmhOTFVIL0dPUnpNa3BUU3A2eTdpN2F2SlRHdldOckMv?=
 =?iso-2022-jp?B?RWUwdlBvU0Exc1hPbFJmdlNkbllmbzNpWUlCTHBaaEg1Z1BpZHdUcS94?=
 =?iso-2022-jp?B?WFgvclhaUHprendBaStlWHFKTTF4VUZCQ2t3MmVURDdHaFZSZnRYWHJD?=
 =?iso-2022-jp?B?dVdrSDhsWUR2K2lYR1ZDTWp1dm0zTGlkNVo2aURyTXRCc05yVHN6VGh1?=
 =?iso-2022-jp?B?R3BVTU1veU8vK01TM0NySEp5SC9aYnJaeHYvL2hSQ1VTcTRKSVlIRmpT?=
 =?iso-2022-jp?B?VTdPVXZ5bm4vajgrTG9iQjFsSXBsbi9NeERiZ3QzWDFzcm1nNllEQ3FK?=
 =?iso-2022-jp?B?eUl6YTJXQWhVa04wZE9OdlF5UG1RTHFIRE9rRWEzUHByR0w2b3BSTkNR?=
 =?iso-2022-jp?B?TmtabEp3SG50b2g0NmV2TURsRy9qZHhmY2ppdUY3bmx5WWxDTzMveWpr?=
 =?iso-2022-jp?B?R0FScWp4cXR0UDUrMzlzS3ZFWlJXcmcxVGh6cEF4YU5wcHhGbkgxaDRK?=
 =?iso-2022-jp?B?L2dqeWR2QjVzYkpKbm1mQm1XNzcwcmJNZXd1OTQwaDFsK09CNlNHNXpT?=
 =?iso-2022-jp?B?dERXZ0VrOTRHeXoyQVlncVc2UVNyTlk0WFdoYmlDdllWNjVOYWRXK2hN?=
 =?iso-2022-jp?B?aDBVNW8zNS9TYXVZS3V6VDdCZ2RMKzRDY0oxWGI3LzFLMWhKR2Qyd1JT?=
 =?iso-2022-jp?B?QmhRWlVFYWsvbi9TWGFvaTNvTG83T3hwdlpTNG9BSlhPb2NiRVFjUUFu?=
 =?iso-2022-jp?B?eHc0M01Yc1FWYWtNVkNxdnlvZUZzQ01mbnpaem5xcEx4dm5kWFE0U0F4?=
 =?iso-2022-jp?B?TzhDWmdoV2twYWVaa0wwZk55RDhlYjZmL1VWSmRWaTB3TjRtM3EyV1lW?=
 =?iso-2022-jp?B?VllrM1dsVHoyZTlEeFU0amdBMmVuT3RqbUxGdGdDSVhoZWN3a294b0NQ?=
 =?iso-2022-jp?B?ZHZYVDhnT1hFWllJMFZmMFJ4QUNJbG12SE00UW5QNVFLcXFCSDZqaDV4?=
 =?iso-2022-jp?B?a2NGc0dpeXd4dE9rM3AvY2w1aFN2Z1o0VG8vM0Z3RGJCZzhaOU5LQ2hk?=
 =?iso-2022-jp?B?S2ZPa0hxV2tWc05hem1CTEEzWWs2ei9aTXd0Qm0vVUF2NmFCUVhteTBs?=
 =?iso-2022-jp?B?TndzajR3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f82172-d504-4db9-d37a-08d99f61b5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 07:07:06.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYB6TGkVjmJ7FkdICycBujQZbXkWqixCfRxKXWPJO1j840cNZ1CoQYKEndNSAHb5m7LkUQddJxKHiGsxGN3BfH4jRzG6pft3ovAyoD074Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5805
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ping?

P.S.
We should have added the maintainer of ACPI FOR ARM64 (ACPI/arm64) first,=20
but since AEST is an arm-spec ACPI table, added the concerned persons
as new e-mail addresses.

> -----Original Message-----
> From: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> Sent: Tuesday, October 26, 2021 4:53 PM
> To: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; robert.moore@intel.com; erik.kaneda@intel.c=
om;
> rafael.j.wysocki@intel.com; devel@acpica.org
> Cc: Ishii, Shuuichirou/=1B$B@P0f=1B(B =1B$B<~0lO:=1B(B <ishii.shuuichir@f=
ujitsu.com>
> Subject: [PATCH] ACPI: Add AEST in ACPI Table Definitions
>=20
> When We added AEST using the Upgrading ACPI tables via initrd function, t=
he
> kernel could not recognize the AEST, so We added AEST the ACPI table defi=
nition.
>=20
> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> ---
>  drivers/acpi/tables.c | 2 +-
>  include/acpi/actbl2.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> f9383736fa0f..ab0fb4c33e07 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -499,7 +499,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> __initconst =3D {
>  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT };
> +	ACPI_SIG_NHLT, ACPI_SIG_AEST };
>=20
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>=20
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> a47b32a5cbde..b586e40d4b86 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -48,6 +48,7 @@
>  #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
>  #define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table
> */
>  #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key
> Location Table */
> +#define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
>=20
>  /*
>   * All tables must be byte-packed to match the ACPI specification, since
> --
> 2.27.0

