Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C986D2B
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2019 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfHHWZl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 18:25:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37642 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732708AbfHHWZl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 18:25:41 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x78MP3AH020420;
        Thu, 8 Aug 2019 15:25:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2tZynPahsicucwpfp8QnlQYolobtTItaExtdzliVknw=;
 b=JRqLBGONVDJj1V1/kitBV6TWSnXF1WRLAeYxjIgdwJYxCIq8DigrYG0HMWjKLfSStB++
 WbsL9qFQuQM3XLoR/Y/90DQdU5ppwc6ZxHFbW0HLRqooYUZthVpZQhxC5LFKNvCBK3Dv
 nlQeQB4P6Vo3rWxiFT+lOAQzGS5y7qAD875mW5n8GHmolQx1CXbFbUMMssVqbjUsxYgK
 0BKjSAh4/B0tlsTCl7zloS2qbGaZA+mb6k7wPTYeErqCmgwRa94BZ19vMMSUBcpQANph
 T3RqpX9Ktd9CqiQx67GWfQW/bCFVawn4v3ozP8IKmH6SxokCerwhVs13RuDvCh9cQe+x XQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u8cqjbkv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 15:25:28 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 8 Aug
 2019 15:25:27 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 8 Aug 2019 15:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjzjxZX1aG5cg1PBNJBMtZMFrXn22K445n0gtEE7ZMfx9I7T0+IGcIo8TJzyfrivGvynIVtbsrmdx5HCgi66vzt6Jinkp27QJdCdZK3sSAcB2RAT0eY8uw/M6/dzspBYzX1cSRYHiTzKD+CpEVh3FgtKKPStqgBkJOIi7Di9HGEbRYdy1Rgfj8HjT2SyvspSDO8MF9eDw47Eoub/hmMoeGt/6MMZilzEedKr1G9AZ0OlBHU5BxlQyzh+Ng7Mi9FnFmwEZ/Sxaj0P/Fj/Lgp3RBR1LjvtdfsE5dRlpHmZEzurzXFsB8AegX5QRVXA6qponEodJdyL3jtGLLF6fmSgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tZynPahsicucwpfp8QnlQYolobtTItaExtdzliVknw=;
 b=BelUEpmtQdb+olwargsDwj+vQnWMk0h0uboSCrYbVUjhHO1Jju1J9FpUcuNFoJ5PwNW4NAbUltNdNKc38ZfQlsimX/BYNljDRZtpCUEfvkQSP9JwShhVLuALKuLOCz7q8FOcMXn4eeyfjzyxdEHg0ZTSGnDpI6NhSQ/C/yrmL53VNRcBXnGIOua1wo1tBZGvBuDiHVAeJbkXLKJ2amSQSfkHXWuoEghqTgdeeyij+TUpZmaN+Dn4dkwHo63iVrGYsb6IBG9t0x2b+dNtlajsXF2yfBLPyJnpOGv8oO9MNQIkd08shoh9A4j4wWS4wv6cLax8EW9oJKQZCS+czcxT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tZynPahsicucwpfp8QnlQYolobtTItaExtdzliVknw=;
 b=QaQzs9qTJZfaJFzCxJnjeqgoNMWInPOIL6LG3mu1NwnzbVeqU3lddXDnrqatQenUMBqebC4m011S0b7ngJ3FnCbSzBspB7UTsHD/mdxwRYwzUhrn60arvJLPhs+2z+FV/whIw3JmLImbRT8D7cB/CdnoyVyovILXUl85oT02H9c=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2448.namprd18.prod.outlook.com (20.179.82.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 8 Aug 2019 22:25:26 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 22:25:26 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Thread-Topic: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Thread-Index: AQHVTjgts9H+xresCE6MuiMwEkeEAA==
Date:   Thu, 8 Aug 2019 22:25:26 +0000
Message-ID: <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
References: <20190808204007.30110-1-jeremy.linton@arm.com>
 <20190808204007.30110-2-jeremy.linton@arm.com>
In-Reply-To: <20190808204007.30110-2-jeremy.linton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21cb4154-9b34-45b8-c2c2-08d71c4f4fdd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2448;
x-ms-traffictypediagnostic: MN2PR18MB2448:
x-microsoft-antispam-prvs: <MN2PR18MB24484A2054040F8ABA4147C8D9D70@MN2PR18MB2448.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(2906002)(53936002)(14454004)(66066001)(53546011)(102836004)(81166006)(81156014)(6506007)(386003)(316002)(9686003)(5660300002)(26005)(6512007)(305945005)(11346002)(478600001)(7736002)(486006)(3846002)(52116002)(4744005)(446003)(6916009)(25786009)(6436002)(6246003)(476003)(71200400001)(256004)(76176011)(71190400001)(99286004)(6116002)(14444005)(1076003)(229853002)(186003)(4326008)(6486002)(8676002)(64756008)(66556008)(66446008)(86362001)(54906003)(66476007)(8936002)(7416002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2448;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /kBEjygy56gRFJfQrML05EJgE9jS3iiS0Ew6ju1M5LlLRbKHPTwHHhJQskKoxMhnf1gF10Pu9fjf1gj22Z99n94RsJExAHnHjhYAq+BtNsZlz+wuB5TR6NFyidB3kZUqO90hUe27NMmFuXIMuADpMjjr47ps9lrR82R+UEcnvE2IEY0iCEfbegZeQaj+k25oBN1NzGSuxdUQvJyNrR77H+bIKt6pr7duyjbxF1I2XamtmfkB9zcPtIuWNUXnJ4y6+5jSkf0y8Nz2SJdNSHRM3J2zp51brlRNCaRzPDvIdQFflu+NskRSwp4eWbKry3Nytv/Ks5fuR9axaHZB49BWipZpXdt9ebUhVE4STPyZMi4LqrDqgRmKF2mqbRrqFLRLp6ZILZdtqT8Y1UgG+WLUObo0XprxWF7EuzQ9Jc0U4IY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A5D0AC3D412314FA116545468E21C0B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb4154-9b34-45b8-c2c2-08d71c4f4fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 22:25:26.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PDYV9hrfOvqt36EYuW00uQc2li2j7WqOOuVEP0BMSbvO3Vllr/bVCGZgK42frokPEaA82BPMUo+EBpsTkEIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2448
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-08_09:2019-08-07,2019-08-08 signatures=0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08.08.19 15:40:06, Jeremy Linton wrote:
> ACPI 6.3 adds a flag to the CPU node to indicate whether
> the given PE is a thread. Add a function to return that
> information for a given linux logical CPU.
>=20
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c  | 53 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h |  5 +++++
>  2 files changed, 57 insertions(+), 1 deletion(-)

Reviewed-by: Robert Richter <rrichter@marvell.com>
