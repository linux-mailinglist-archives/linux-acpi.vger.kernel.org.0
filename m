Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF55431078
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJRG1v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 02:27:51 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:41884 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhJRG1u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 02:27:50 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 02:27:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634538340; x=1666074340;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Xg9PCLEM2O8lX1SywXisz52536+zhjlF1H+rXdMtv/o=;
  b=NGpHZQXF6cVMPBQMs2r25haRPeWG8D0raFAbVI10v/msDkzg6BTopkQ+
   u/j/AVJblHjK83jDqbur9pEI1v6A1AP9fVWzGjDZCZtS/Ifh3MP2PL6MO
   BqAJORZrN0TfyFSxAu8ATTq5ZUf4wRQgt4LX69qBwFa0I+djDbZbO/HrI
   4XsFbT1GUsO6JXhwANMKr0UG5UGYca1/ZkkVpw2qOM9i9EXUku1qTGb1m
   BhxszdSKPa+ozGq5Om2bPmHISpw7sYh9M8p1yGGiBROFpZMaTMWJA99g2
   krzJrhDViUvrKDdykRpUtHfIxGfh27R5/KHOoKkJh3lvPGYsHlxRKjFKo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="41894829"
X-IronPort-AV: E=Sophos;i="5.85,381,1624287600"; 
   d="scan'208";a="41894829"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 15:18:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGKpIGNReDuz/IJc/nMv7RNZU0pqaz2C3puHEhWj16KDNC6800pM1Gim5zUdBOCNtx78eM5bh8WO7nH3KncQNcJxHUvP9Wozfe407fyloAd8xsL+L/JBgr2BjazlIOY0x+zVPW/5REd2ZnG9rW+i7Nb7p4OZFQe01y9gFagciucsYo+crvNhsUJ4rke7dnspMY3i43NNNZeRbJddTQNwIwDgiZJ8HjwlpWgN6gT0dHfTJ1TrrIgK2jb/PPv9NnzKmWEHqKvzMyEOuuPuWu5Y8IEE+X6sfLWMO3tlr6DmsRNQylC5wkul4hEaXQ+BWvtnh7Q6ADitehl7WR8+gV7tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg9PCLEM2O8lX1SywXisz52536+zhjlF1H+rXdMtv/o=;
 b=BUXIdxl3yhkHpPl/p8C2b9XTUpzz7al5YT4i+bR8qAg0GaPZflFE6E5mNxy3K4LX2D24WUnBuq6u4PqYu7taSbTUuE3UJIGVzZX+bTahCPzT+K1O2Te8mMLjgDhk2Z8s5MTjsdh+8FpJSBIjkwLPLkI7+zWidu5ximE6VBB6wLYo9VxhjicUo9nsGtbtkZhoBoq2RHUzMIBz6xybG2QmTU0AxdYp5TTUi+H8ZBwXe374a5wLwXR3b/C8oICILAMVTKCukjMdU9HyGfk0i/4uevN903ctLhS26VClnonPShwmbQclotLljRow34gMfGjZ309xJEc950lwKIBd+sHN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg9PCLEM2O8lX1SywXisz52536+zhjlF1H+rXdMtv/o=;
 b=pj2VesIMjIKcKMcrmRxCE3F/n6I8B17BYXULmOGZdrqXlzzyZPzkVB5S7c9YT65zKWKy/5K9qmkvnrLUMXyYGRSXAhi4RupXh2IfhUBEyu5szqWAKUPnI/FpRuZLs3oVwEsXyddNsMy81FlWfdL0IZxyao0QcXjpSZKTzHaBzWE=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TY2PR01MB4138.jpnprd01.prod.outlook.com (2603:1096:404:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 06:18:25 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 06:18:25 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "'baicar@os.amperecomputing.com'" <baicar@os.amperecomputing.com>
CC:     "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
        "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: About the ARM Error Source Table Support patch series.
Thread-Topic: About the ARM Error Source Table Support patch series.
Thread-Index: AdfD5/UJ3DiYw/q1QYuoOnzuG5OpkA==
Date:   Mon, 18 Oct 2021 06:18:25 +0000
Message-ID: <TYCPR01MB61604CDECA902F560C805EF4E9BC9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9YjliZjdhMzctMDA1Yi00MmNhLTlkOTYtZGE3?=
 =?iso-2022-jp?B?MGY5MWRkNjQwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTAtMThUMDY6MTU6MjRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: os.amperecomputing.com; dkim=none (message not signed)
 header.d=none;os.amperecomputing.com; dmarc=none action=none
 header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4826b6d-efec-49ff-76b7-08d991ff1809
x-ms-traffictypediagnostic: TY2PR01MB4138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB41385A21277785F5F09A5615E9BC9@TY2PR01MB4138.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+6feWF4sGxuWgmEJxUZ4Z+abNHj+EJXHWaKBLqp2olKMST2gv92uoMGipGpD8gsZQu2qJH/13lfaxMywfSFQ6w2ATtwZj/lgb8Ch035wgOWlVCjVPCsK4EI/g29zz+eN67m8fft6pbwtshwLIYvd0OKv921MvahGICDCQmTzFxIodgGCaMW5VkzSlzZDRFpHxexBZZLcHtUH0CfShtvWLfrTsfejdgCvj+3ARBLxjmWhhZpW4QFQuXa0g6yaBDuQxf2dwsEDbWKXrD46YaLq4y+4NHA8+6kLbC27Tt6ZOI8pVVVfzChFhUikV2aBwx+Ar/ggHAZq4u0fQJ0ttFjKy26u5RSIAOh24UHlJ8u+WPMvWGVZKjf9ruLgEV/t9/66IQ7JplDyg6ikhrvWRIQW8U5bxM3f3dSYXplB0/+kLtFeOb2S1f8oUchSYdqs7+MwuiHlbX2L1d9BYB3EfV2avgLPSxnSE5hZZ1f3MG0E3smOIBR4zPLSliDPJtSLt1eA+0Sl0foRPNAoqPX1qr3UEUvqdkSSaoAVxyYcVvQR/j5t2+ltrmsezh5B7/I/PVr1/z7NvNB4GvRYc9sfkKq9V/ddOI+TvGycPg33bd8X25yZ0tm3B+R/qnKR0aXHNX+FnWkMv0gUjY3pTAHVKPRPo+7EEoRCzJtxC1YKgeypgY6yffLRp8i77DpITv7wcHpswFP5TDE97PFpXOGwtZkoLNnwT7MD1c7E831lOxfGbKnrh9wsNSyUsKYedkhrw2EURJsbmE6dQEqr+55iJ/5f+4u8ddX24ViT2W0OLWV05kC37XRrVsQJ02IT5x+mAuJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(6506007)(33656002)(66446008)(316002)(122000001)(9686003)(7696005)(4744005)(85182001)(82960400001)(966005)(8676002)(52536014)(54906003)(76116006)(186003)(26005)(6916009)(2906002)(508600001)(86362001)(38100700002)(71200400001)(8936002)(66556008)(4326008)(64756008)(66476007)(38070700005)(107886003)(66946007)(55016002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dEx6WDRZOW1iRDNYMTRXdnJYemFSNFFNTFBGRVF2N1FQL0d5TWZJOUMx?=
 =?iso-2022-jp?B?S2hEcnNEMnVCbVJTVGk4bjZMbXJBKzhwOS84bmV5eHA2YjgrS2U0ZkJ2?=
 =?iso-2022-jp?B?cG9idUpqaDhtakJBZDBaUmdOSk8yZklnOUtNN2tkNWUySnVqZGpwR2lW?=
 =?iso-2022-jp?B?VzhaL0JFMGRWanU0RStVQk1XdHg5WUxPZld6VVNrdmF0Y3hqYjhuT1Vu?=
 =?iso-2022-jp?B?UGN6bHhBdk1CSjNQbnlSc2dPTDZpRzZxWExKaWtvR3J6Q3kyUE50Sk1i?=
 =?iso-2022-jp?B?dElvOXB4VnViREQybndhWFRzZ2pHZTdZcThEYXFHSXUyK3h1eFQ4WS9N?=
 =?iso-2022-jp?B?Wll2UFh6YTJMWkQwaVBBUkJyc1lnNUFaOWxETkdSdjlVZjZGYWNnSnJ0?=
 =?iso-2022-jp?B?bWZhWnV0YXd3NGpNaDZ2eFoyQUV1M3A2emU2bXRVdk1jc0hNMGdnNjMz?=
 =?iso-2022-jp?B?WWE1QkhNaWVUVG5zb2s3YVR1dlcrRnRBcUVaTW1MajFXd0dpeDhmaDJU?=
 =?iso-2022-jp?B?eFd0MllPd0pkN0ZvL3ZTMllVNGdxVzRBZUJpMXlCREN1Q3ZWZ2pocjVi?=
 =?iso-2022-jp?B?Y0NzdFc3OXpxanZZemUwcU5oaGVLQTBhRXUwM2UwS3o0K2RJd0hrb3p0?=
 =?iso-2022-jp?B?SDA1TDNseEtmSnZVTkZCRHVmM1pDcWJlVUNKdzBxTVpmbnlwOU4rZDRa?=
 =?iso-2022-jp?B?b1R5ZTdLT3dPOW5id1cveXVobE1KQUZMbzR5TEM0S3ZWNWczbXZ2aUxn?=
 =?iso-2022-jp?B?VnBJcWFqcU9BaTJidVBpUnJqdGo4UUdQQ2hiY1FPUHJBc2JPekpvMnZI?=
 =?iso-2022-jp?B?SGY5c0h0NnM0N3RRMUhMWFJDcjFLRzdIWDQ3UlBld3FjTmVqRlprdmM0?=
 =?iso-2022-jp?B?Q1FqSTI1ckdZcUR1RkxpL3BTY0MxaDZ4ak10eDhBY3huM2VyMWNJTll0?=
 =?iso-2022-jp?B?Q0h1Vi9XRUtNV29nWlhoRmRxUG9zRjR1KzJNeWJ2LzJBaTFxeWkvK2ZP?=
 =?iso-2022-jp?B?c0xNeEJYVWVxc3h0MXhWb0Z0SHh1RG9rRnU4Vnd0S2diTkxqdnRMTTZ4?=
 =?iso-2022-jp?B?ZGFtQ3NoRjhDUm5MWGNQQkNIb3dHNVh2Q2ZvakI4dTBmQklIMTU2S2Ja?=
 =?iso-2022-jp?B?Tk9OUlBDUHR1aDdtejJwMkZRUEdtUndmVTdxeGQrNndtQ0EraE1PbVE4?=
 =?iso-2022-jp?B?dlNSWEZpVitRT3NHeDl6WlN5ZGwrNWhFQjF3RjV1Z252dm96RHFqZTh6?=
 =?iso-2022-jp?B?V0J6d3JqVkFwY21TeG9YeDlsNS9xdjkzUmlPM2lGWUpObGJxQXhCaEV6?=
 =?iso-2022-jp?B?K0NieFNPd0NtQXA0SlJHcFN5MWNWaThtcVNiRmdMN2JFakR2L1JjaWVp?=
 =?iso-2022-jp?B?aWVoSUR2TngvMzdUUnZReEZJcW1oYTYzS3RPYmN1M0puWVgwZFZFbCtl?=
 =?iso-2022-jp?B?eEZhcTVpd2srbEdPQnJFdE5RazNsRzhrZFV5NDZPRHNrN2h0TE9pci82?=
 =?iso-2022-jp?B?TVF2TGRFUk84dXRhTmpjSk55aW1jc0h4VmFjN2FBQ0VQeDNRWmRqeDlv?=
 =?iso-2022-jp?B?RDFZTzg1T3pYdCtTNGYwa1lSSXRKS056ZTJIdmcrbGU1OWhKSEZEUTVP?=
 =?iso-2022-jp?B?T3IwUGVvbGxqSjFyUTVjcUljNGpGcUJNTjVQY1hlSkF2ZzN3V3NrZzlG?=
 =?iso-2022-jp?B?elo1MWVJNG1MZTE1QVUrWTRFeWxZTUEycm5MNXVSOHB4RkN5ZzQ4cXFs?=
 =?iso-2022-jp?B?eGFIdDIwU0pDQlpycVJhQk1oR05PSG56TG1MOUhkTFZ3R0tQNnJVNG1X?=
 =?iso-2022-jp?B?akRHRWpwNE5BNkt4VWpKWktNYnNWWEExaFYrazVUOTh2L1FsRXIxU3JU?=
 =?iso-2022-jp?B?M1F1WlB6c0ZQZENPbHlTZEN6WDdDeUp0SnRnQ1VKL2hkMGZLTllBUVY5?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4826b6d-efec-49ff-76b7-08d991ff1809
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 06:18:25.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmggF2dM7kKfOnaZRPYK+4TkAb3CCRChs33nM2onP8Y6/orcgGJZyZHHKAMoEjohlyDWPT4Vkxv3pSZQJM2TCr6bvkGdtBBqIv02A3ahvlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4138
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Tyler, and everyone.
nice to meet you.

We are trying to develop an AEST driver.

We checked the llinux ML to see if a patch series has already been posted, =
and found that you have posted an RFC patch series.

[1] https://lore.kernel.org/linux-acpi/1562086280-5351-1-git-send-email-bai=
car@os.amperecomputing.com/

So We have the following questions.

1) Is it correct to assume that the RFC patch you have already posted is th=
e latest one?
2) In that case, we would like to implement features as needed based on thi=
s RFC patch. Is there any problem with that?

Best regards,
Shuuichirou.


