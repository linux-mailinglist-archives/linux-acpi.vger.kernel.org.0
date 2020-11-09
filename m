Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2B2AB83E
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKIM3y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 07:29:54 -0500
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:60990
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729302AbgKIM3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 07:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=nR1mmu21IUzw/EOzQefip4jSZzx0dMF90aQ4DAvV0uDJjvehmIZ76PUHmhkJdyjelk4uDaQglWyrhA1amUrXf3mYJ0dC57jMQD+n+fx1ZM3+XfMr3tEZg7XamSZF13OhrDSW9464c3/rSeh+CH6fBvqu8c/nLKplo7W9R1bG3Cc=
Received: from DB9PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:10:1da::11)
 by DB8PR08MB5178.eurprd08.prod.outlook.com (2603:10a6:10:ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 9 Nov
 2020 12:29:46 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::25) by DB9PR05CA0006.outlook.office365.com
 (2603:10a6:10:1da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 12:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 12:29:46 +0000
Received: ("Tessian outbound 13ed5f5344c0:v71"); Mon, 09 Nov 2020 12:29:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from f3133d7c02e4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D2654B0B-83A0-4593-9547-D92E224FFDD7.1;
        Mon, 09 Nov 2020 12:29:41 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f3133d7c02e4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 09 Nov 2020 12:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5YvSAIwTuice2xduZJYHMJzeDLZud9QYg9Y20Ue4m4UnElq2zTlgUSaLmbwsZeybaD1j556Hsu5s7KGgkAln+hpl9Ln/Us3GNj8wRI46jw70AOfnRKyoKMQz1DPTuXd0nFI14Wjc1j21Q3PmuHQ37WEiq6ylPk8gMFrQq/BzsntNoOC/Nmhs27cjOCJEA6PBoKyapoGlPVZ7ipUg6Ow3YL4FoWlOQoI0894LbplBq0Ps/PN9Y6HAALLxr/TqTP4OcRVf9Ml/nS3fX2Li241aJGFj5pSpr667ZACMDdoRfQeZZk8RzMh5gMdoGeb8QoGq3m+KsmLv4v6Ia2MtNIP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=Qb/+azt/gAdW7VqSZY9qWGHIuhsZlYTcvA5IGRCmIkXPZ/15S8CyQUvajx1Q+e2Ljhxfr5uw9xrWSBK5IRPAqdf8TFNrfTLPIilTlXnKRr5aKS0pYefsRU3dwVA7X3HKJgqYomsk3ho0gdWGQ9/CJZcNHBC+QiUHSq0rrlBuzBZMCSimyX4+lfeZoSJtdDmPyUgNaJVDU3BVaTi6b/czsHZN4iRL2F8zCGi8LjbQZphCkma3lEBZaxwUWCNNnsFFoG7wzsrQ5YfdH8uoElSeCHRbjn/bSvTKod7qgdlg1fScuKH920bfEno6PthUompOjN1dfQ3tb39ybQr85w7Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=nR1mmu21IUzw/EOzQefip4jSZzx0dMF90aQ4DAvV0uDJjvehmIZ76PUHmhkJdyjelk4uDaQglWyrhA1amUrXf3mYJ0dC57jMQD+n+fx1ZM3+XfMr3tEZg7XamSZF13OhrDSW9464c3/rSeh+CH6fBvqu8c/nLKplo7W9R1bG3Cc=
Received: from DB7PR08MB3097.eurprd08.prod.outlook.com (2603:10a6:5:1d::27) by
 DBBPR08MB6299.eurprd08.prod.outlook.com (2603:10a6:10:20d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 12:29:40 +0000
Received: from DB7PR08MB3097.eurprd08.prod.outlook.com
 ([fe80::897b:8573:fd4b:d06b]) by DB7PR08MB3097.eurprd08.prod.outlook.com
 ([fe80::897b:8573:fd4b:d06b%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:29:40 +0000
From:   Sami Mujawar <Sami.Mujawar@arm.com>
To:     "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        nd <nd@arm.com>
Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Topic: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Index: AQHWrVpjD7ff2ZbXik6CnzMoubH0pam/uMvg
Date:   Mon, 9 Nov 2020 12:29:39 +0000
Message-ID: <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
         <20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com>
 <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
In-Reply-To: <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3A01DFA93301644C87586B117271E683.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [109.146.228.240]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d108f902-e1c0-4fe8-a0cc-08d884ab24b1
x-ms-traffictypediagnostic: DBBPR08MB6299:|DB8PR08MB5178:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5178C3B8901417E4EA9A514484EA0@DB8PR08MB5178.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:517;OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6xYPjOo6CCXTxL2CN9FALeelXR2wEyeIxW1V76k0uoV8tmv7gmRLYnbWLKsme5B+PiVB1pNtgt0DIEReA+l2wLqVofbiAxoggCBq1vAtqK363td6NBxh1UPDqZLSUOC8NdjEeAdiDIBIQiirfPbgGGs/kIyjDqotafD+MDyXyPF3FUeNrETw0j25YRDwQQUC/gpvWGhD/HtURrIwKdWT57szOQyt3RdVq8un+mY3IicYteLuCxsyuJaqfkT3EF84RNrR1lZF2xn6SM3wqokSvx0DIEYTGQptI8qiA1RCKWVckffUYn+Y2o+1iz9u8R/94kjzqIKlh2OsayRfl9WxDA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3097.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(4001150100001)(86362001)(316002)(478600001)(66946007)(2906002)(64756008)(8676002)(66556008)(66446008)(83380400001)(66476007)(76116006)(33656002)(7696005)(6506007)(7416002)(53546011)(54906003)(4326008)(71200400001)(5660300002)(55016002)(8936002)(52536014)(110136005)(26005)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c/8yl3XQzyAn8g0eP5GujEo9aJDVb/nUwLr5oSUuG0IpA0HaIo75pW4K5I4wNKTRim5QSbxleIHKcoF2F37+TD/n937AtCb86LIeMqwrPNU1BU/vmgvYkuiCdmAtkRsX0NAP0a4mulA+yfbSMijm2XgC8gyx3I0uVu8W/PVVSEWT9DpPAxk8SUBeuJ/Rbj9tuWnwTmvxUtp4RFdErP17kQwRGEWfxRG2ZvYtPmB7ruEx5FGCt+gQqO/OQk8OQtvPPuJLuls9Ym3rJiwVlKL8SNq5eWvirrFFEh9n+pIJ0I9ftYqsLFzn2OikmyTYGxHP5RNMKXHXIGubo88gkbl+sAFGOIVzRT9Eh1GKjG10hCwLj4TLBSC3zhqi2GMF8cS8MTk+vFdbhhzIk8Qx3SEPjlUYFuMUruBskMNxjFOO1VHw2jCKmZVRuA8/6+1fb0PxhxPxwU1PAI53MNxiY1M8rmcwyd2sYQ3TfzqTVqEvCQrbo28PhALeiC6DGc/PNBJNaXVci1FOR48umx6EQAOxO83dpWAQxp/CjYfk92AUK8pyCTX7noYOFsF9ExGe9VNPCxsuuahkTzQmawJdAb26rOVPV+YhLgVUSgqFNyZHDgd6S5BtaO5nw1S0xQ+oyT7Kzz8Rj3esiJUXN8wKZIbbcg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6299
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6cad0bdb-2d4d-4cd9-4141-08d884ab20ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KriN9JXhWi21YibRItlkLST6qNfJnEInk6JzOZ0jGwGKUykQ/l/bUrOE5XwzMs+1Vj6DaI38K1XxGc42bgb+OP6pDotcNnHB5+GWa1aG6HSDBiK3mOSUbsiMe0A/YP8/HSWbsDj+qwoh0W6gD0jXaeHFn6VrFo3U2aydxxwkwdV3WHD9kRqaKmTFddtjee2VTOLpAaRKHLFELj+RPOyncv9Mh6cbLOdrJQcCKx0I3vpJTkTt55m8r6oDEfsuwfjTgCNLehERrYZKWbkV7Mm5+EipRwP7kP/GfD/U4Wwd81AC5MMY23VX7eJOQffKeIvbBcPNmRCO+OEcxOtl2PWuV+PA4kKc3VrYItZntK1Gbj74kZRIZGVr3xSYLi2i7q1dpPbcLm5fS9ZdnvSxN3WH2g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966005)(110136005)(70206006)(478600001)(52536014)(81166007)(2906002)(47076004)(5660300002)(6506007)(82310400003)(356005)(9686003)(55016002)(82740400003)(316002)(8936002)(83380400001)(53546011)(70586007)(186003)(54906003)(8676002)(336012)(86362001)(33656002)(4001150100001)(26005)(4326008)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:29:46.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d108f902-e1c0-4fe8-a0cc-08d884ab24b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5178
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

-----Original Message-----
From: David E. Box <david.e.box@linux.intel.com>=20
Sent: 28 October 2020 06:44 PM
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; linux-arm-kern=
el@lists.infradead.org; linux-acpi@vger.kernel.org; iommu@lists.linux-found=
ation.org; devel@acpica.org
Cc: linuxarm@huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>; jor=
o@8bytes.org; Robin Murphy <Robin.Murphy@arm.com>; wanghuiqiang@huawei.com;=
 jonathan.cameron@huawei.com
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node pa=
rsing

Hi,

On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:

...

> @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
>  #else
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> { }
>  #endif
> +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> +{
> +	struct iort_rmr_entry *e;
> +	u64 end, start =3D desc->base_address, length =3D desc->length;
> +
> +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K !=3D 0))

You could just do:

if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))

[SAMI] In my opinion, the following may be better:
	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))=20
[/SAMI]

Regards,

Sami Mujawar

David
_______________________________________________
Devel mailing list -- devel@acpica.org
To unsubscribe send an email to devel-leave@acpica.org
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
