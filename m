Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B4380EB4
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhENRU4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 13:20:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:33326 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234792AbhENRU4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 13:20:56 -0400
IronPort-SDR: LwYnGsfH5r8MHMsJorF5DTV6eA9mSjH7a7RAgxJPy4WleTJmhL7w13cb39wZfPqIaDi62N2Kvs
 8iHVpiAWGJoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197124099"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197124099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 10:19:40 -0700
IronPort-SDR: NYZ/ZBR/M0sAt8ivx97pC7M6FKT4juXxZRKMSUCEE3kS0v4jCEqywJk93Tmvt4ULuBpzpSShKA
 VgKadPuAfdKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="627224247"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2021 10:19:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 14 May 2021 10:19:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 10:19:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 10:19:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 14 May 2021 10:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCjrOTpLvla3bZK8fu2FxWDSL1imWKvM5VNUW7HF1nol0QdfxtPKZtTAuDunrCld+hmf/HFIpktW2F9xICOFSm2mrSh3wYwehHeMH73kLcOy60zPaVNG7T0PJ1AsoHguaY82iH3ncV3R4l+2Yuu4+OAntlf3+odiZZzuTdPkkj0/jexAziL7wQzBE6KqsF6nAXXUlrBLiDDZhQW+121YOD4Hty/s+0PDroqGSqZ3vmYDZP290QXogNmsMiTMZuqmNrmfpN7LRZ6agWT8LMN/GsA1F0tghVizQsIDjWZS3yk3qjSkSUDPGQ84BBrSjybeH7xWuN/vKTdpCN6+FNVQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS6uZoS4tiLlSRX7bnh0UtOWziaG7Iq1pI9nDo7WnDc=;
 b=aBClPlQ4y6bP1y3MQn4gPejiJZCfQ9y8TVQZZwGz951m33bkvgY7YhHBv6WkAnp9x1Gepf1OH83bjVqf+3F7zRL1Yocp5C5KeIIArn7TcM3oXCW1s7Ig3f53OwsUylNzkNZcimuTJ/s0TWWgT28WCaDcEUCqQ7PV/TJfwGMWNm1P5wt+k3GbFThPnsJEzJjx/I9N+A7hmB2V/h9rq/mE6UuI82HeQldIsieSdvhkx8BK/Hcmo2Rzji8eFy/IBwcvUML3hZleb/U+axxNCmkeg0xsxZwUGNFFUzc1S69zPFNLh5Hf9qCbSJDJ3E2i9ENHNuH/RojWhlv9iYWnOU8Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS6uZoS4tiLlSRX7bnh0UtOWziaG7Iq1pI9nDo7WnDc=;
 b=PQC315irny8oKIItAYDcA74oyRrSIKiCVi6Wv8t7mG13Dk6iG2yCHCrC/Bqt9DSYb32uSHDH00O77kGeQlU5TXDqgmc3LUKUJrMnubRu6A9OWv4D83QPpNXq3j2m5J1MUxDWUyfXs8NuQKM5HLR7mT8/wNKxvTZZQlLPECX4YD0=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 17:19:37 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4108.036; Fri, 14 May 2021
 17:19:37 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Use ACPI_FALLTHROUGH
Thread-Topic: [PATCH] ACPICA: Use ACPI_FALLTHROUGH
Thread-Index: AQHXRzXLfMTR2xfx+EGhKhkGGYYxqKrjO9lA
Date:   Fri, 14 May 2021 17:19:37 +0000
Message-ID: <MWHPR11MB1599C04B3AAA3A1A14A0D7FCF0509@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210512135018.20253-1-jj251510319013@gmail.com>
In-Reply-To: <20210512135018.20253-1-jj251510319013@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.17.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c40f848-558e-439e-892e-08d916fc7365
x-ms-traffictypediagnostic: CO1PR11MB5042:
x-microsoft-antispam-prvs: <CO1PR11MB50420B4A357E853F5327988EF0509@CO1PR11MB5042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kSsJ8bwxvIo3PYX2bI/uqanh9GOiU8F+AuEN7UT1eLxBPgX6qXxrz4w3gqjkV+2H+32AXFYBELwqgWSetknQKH3Us8/ObnqwRlUAL7GF6oDo/gx5ly+fWv4aWO60r38Av+RmWFF1HOwRLfqs+Y/xcgORvu/0bL0rCvV2VD4/T8Fn5mwG7jc1037cOFM195L/TjQLRwv8KAIYh57flCSXNMuBH0S4++puVq6aNhc2baz4bAn5A99N2YbiuJr+n1T7M+f/XvnIWk1X4CDPLz2B7TDojGb/GG66Spm2ap041ZN8vtmxSSlr4aJrBow7KOwFC9Qv/Ld2NuOYd4kPwHXMCKe5qHNu2n+D6NtAqQuJKAQWiVyZFwgyEns25N1x2b3KEsL8AlMvNSqstdo9ZaVfGx2h/zQf5jqZ/PkgQTPiv5GXjJimE+T97oFyaCp0SF3S5R+5/kOOH6dOoE8EgyasAX7elVZ3gh9VtG73sjH0i6kwscnnSWguhXu12uz7BDrnnPUW64XoTJ1VpF+Thls9sp51ayXoLN137sH65dbpWj3DaFm2TTr9k1JWSiA7yBdr53sJlTKuV04y8T3YoUE/4rDLn7TZYUfyxWxjEEPUlXNAhMy5sJpH/ftiNPuTP1kHA04PXGDflrDxAHhoV9lkKglb/aZnvRqd41qpZv05k4AVH57czI+qHAdtXNovs7BQkOmbQ4YfBwZXTqC/x0Up8u1wDxz/sTb+n4jf95/nSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(4326008)(6506007)(66446008)(66476007)(66556008)(83380400001)(76116006)(53546011)(7696005)(64756008)(52536014)(2906002)(71200400001)(966005)(5660300002)(8676002)(478600001)(26005)(8936002)(66946007)(33656002)(316002)(38100700002)(122000001)(9686003)(55016002)(86362001)(110136005)(54906003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2N9aBMx9oCkOBve9u8XHEhkYAj4EAu51f84OBbeNrfvSTlLtuve1gohCTrwi?=
 =?us-ascii?Q?eNNuF6727KuZcXx5GMgg1MY13ZD8GJZktU5cKboMYz28ep3HQYe5PxvkvheU?=
 =?us-ascii?Q?eXwlnHVyU6LchFMnEIGVCQzJPHvkfbK9E2q2eKU0lZkQeZImKZHuLw8lLmf/?=
 =?us-ascii?Q?I07Q98ICj++yGr9L43O2CTnGAbmT6cb7FLBy+aG0EXt3bcXBBBF2ec8W8ifD?=
 =?us-ascii?Q?6/o3OCYIRVFQ+eDFnXXwkvyi5u4HyltCkRABQXK3bFk+NVT0RyGlEtKqGXTg?=
 =?us-ascii?Q?4aTJI773FJ5wrtugSKsEvs7tTkTlXv9fzGWzyJxxpDOr4BRqOqVPRG9ggOaL?=
 =?us-ascii?Q?5PjF2g6R9RCAmH1k6544rIiAIsC53J9OeQdYQtuw5HrVj9na/8/HUKnwfWcI?=
 =?us-ascii?Q?RRWbvTNJYjToPYUi1iRK1A7TorsmQM8F4ctkm2hIo8UcRsQGibUiQWma6A1Q?=
 =?us-ascii?Q?DN6rOniH5Kv3C+zuOv1HLXeTyOCuy5cj+6qi/Y1GAduESu4Sy7OtynuJs9+b?=
 =?us-ascii?Q?Ifp2RighCHfe+ojNXPOc9lNWcXkOWrpUtdaErTVccf3mmFw3SQnnFCdge9fe?=
 =?us-ascii?Q?6IcTylegbV8vEqZLt6c62CBXIxmVZUq9IaHr6rL4/egRHEfFUZ8mXC5traUP?=
 =?us-ascii?Q?YlqRsK3BRfLZLAcMC77iz+sgyvaGgjMRRY4yMVPhL0VwqXBIzvQIYv1X9zLo?=
 =?us-ascii?Q?pBK806HpkJ9NFx8vOO8E0M5HkVVoXhZmAJxzkybLN2+Ii9HXatWaKvOdPSzx?=
 =?us-ascii?Q?fJUo1BF6dBdNS+k6kEYl6s4DrmTrbTo1LXFIWx7CXReVR/nqH8gO9LMuhy68?=
 =?us-ascii?Q?+dBv1EBUgOgJjkCKnqH6JD3DzpFrz+QbWSxC0GUpAGP4lmnkWfhyI5zUDxza?=
 =?us-ascii?Q?9SJDcEKJD6/78DaYSwAC79h28OTAuIGQTdb3XUxeBUNuJXJtKqsxhJaTNFJO?=
 =?us-ascii?Q?2WUFVUnqi/wG54KSFxOhm1p5t+/21sPE4BtPt+5IjmQ3N0ZswXvtlKKvh5uL?=
 =?us-ascii?Q?su88/par2BtGWZBgT1Pcrb8xqFNOmso9/r6AenKPgGU4GVJrSWTRwtbDC9U3?=
 =?us-ascii?Q?2fT3s2LIl7shtXpFKXPu8pijMu50OTVahxYjeGu1qIJxcDZYCGsG5cTNSTU/?=
 =?us-ascii?Q?4M2wJXY/I5qo5hmthpKmPbOlzXwi+zXrIxhmcPfYZKfD3JlaLMDhaPUlLa6b?=
 =?us-ascii?Q?oWecj0xJ1pCYGuuf4yvBxHp8FTJHPRMZ7zBevLP2f+NnXoTSMBHj4R+OqcQB?=
 =?us-ascii?Q?G8EwwxybUXuHT9M8HQHbJLKI87VU+BMWdq1efbcwEtbhMrRBtI+iGj1NttHE?=
 =?us-ascii?Q?LWE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c40f848-558e-439e-892e-08d916fc7365
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 17:19:37.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6Awfge9r4ud0B/50X+2D39D1uxItCqvDMT+LqX/xkW7K9TY66XIYPImNPfSkqx41Pxgx2cY3IDEV7VBQ/33gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Wei Ming Chen <jj251510319013@gmail.com>
> Sent: Wednesday, May 12, 2021 6:50 AM
> To: linux-kernel@vger.kernel.org
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; devel@acpica.org; linux-
> acpi@vger.kernel.org; Wei Ming Chen <jj251510319013@gmail.com>
> Subject: [PATCH] ACPICA: Use ACPI_FALLTHROUGH
>=20
> Replace /* FALLTHROUGH */ comment with ACPI_FALLTHROUGH
>=20
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/acpi/acpica/utprint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.=
c
> index e37d612e8db5..05426596d1f4 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const cha=
r
> *format, va_list args)
>  		case 'X':
>=20
>  			type |=3D ACPI_FORMAT_UPPER;
> -			/* FALLTHROUGH */
> +			ACPI_FALLTHROUGH;
>=20
>  		case 'x':
>=20
> --
> 2.25.1

I made a pull request here: https://github.com/acpica/acpica/pull/688
I'll circulate it to Linux upstream after we do a release (about once per m=
onth).

Thanks,
Erik=20

