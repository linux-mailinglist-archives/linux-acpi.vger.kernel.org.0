Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD6334B121
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZVPp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 17:15:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:44224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCZVPf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Mar 2021 17:15:35 -0400
IronPort-SDR: ZY2s8evmBVBXBtnzXyGF0kuAyQTirgkE+DOcDOmZ1tWhEYhGyEk8vaxESmLGwP8vikvfpD2pUQ
 aLPcXTVeGz+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191314181"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191314181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:15:33 -0700
IronPort-SDR: /PX6v6lxRCYys1Rp83B/DhWWn4IgwPY1rAjoEvr6ipYWcr5uQjuWITGe8l7So510dja80xczv/
 2JXTDkc3zs+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416695935"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2021 14:15:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 14:15:33 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 14:15:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 26 Mar 2021 14:15:32 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 26 Mar 2021 14:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMJ/E6Md7iWIN5wuSQ2H1KcLJGnXoBSsa3lXGQ2jxfzoBEBIIgfNVatzvHxQQ43yL2mq7uHCVloAmeBytVAcaZ7ZWr+MAPoULl+V8BPZbvyXoH7+NaiohfGxWKDjNj2tH1BPHJky7Q0EL/PSuKBBhuc1zhMFVdRmjeyiQDeI5yGkNetTG5Q10qv0kXwcA+XvNBWBeX/IdhXSv2dd9Kc2Ofl3XaUTK8GGsNXzAxrv36BZiIcfYzidvstqoTeo2qHy6KOYkJZpNjw5UlD0AGWpbXRUVNuJf1esTexfKXhgjO5FVCSjZFR5YuT6izhg7YLjrCRrDcBTjP20xeAejpneuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxOzKp+ip+FxF/ERBVoUvmBA2NDGnZGwoerNsfh+cXg=;
 b=DI6gaXXqY+8+ZM0pNlK1EXyLvMSAZ0NMQx15tKniY2y3jEMhtV2LDrYDMmuxbxhpkzXdr2haMEwOlDDXEMs4e+BAbIGz0sQdm8DDZ1z4D7tbhZQhk4IoYuO45O2wkpwKpFwHw+P6Fdo4z1S07IalP8F29OGErHu6vsytQTi+qOmAIyk3r0y1TqoAe8ZoPkx7VXKKZ3QWCKKgihBRpkXBxc8AQENO79JAuu+Si36VkbwkQd7AmOruFFuaNJgTbsM4GBxpDtT445Rq6f1+rE6XKaEMVx7Fk+HE5yJ8SYL+Bpgl37JwqZvqQ4usbKsLmW+yC9J9Eoi88KvV+hFWPtxEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxOzKp+ip+FxF/ERBVoUvmBA2NDGnZGwoerNsfh+cXg=;
 b=xa1FD7RT+Ok0qoUQnTXRnfWg2r8yO3ZUj0IcZpoho1McXmuZ64o0VTITLVj2cEZFlHfyr47Bn3wkw7YAnvN8MpxpukEwe5w4JXYnAAR6F6tlkwKZjkmBfpwFaUjbccQ3ceyE3IU9/T0KpyKNPOPS20ED9q4YK4jWHOeq3ubzWNg=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1758.namprd11.prod.outlook.com (2603:10b6:300:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Fri, 26 Mar
 2021 21:15:28 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e%5]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 21:15:28 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: [PATCH] ACPICA: Fix a typo
Thread-Topic: [PATCH] ACPICA: Fix a typo
Thread-Index: AQHXIdYAmyJ9Mtfa/0+JACyqBrsGAqqWXM8AgABRlgCAABZFwA==
Date:   Fri, 26 Mar 2021 21:15:28 +0000
Message-ID: <MWHPR11MB15993B9E8584A9EEC44499C6F0619@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210326001922.4767-1-unixbhaskar@gmail.com>
 <BYAPR11MB325648858A1C06D2E80DF7AE87619@BYAPR11MB3256.namprd11.prod.outlook.com>
 <YF46nvV3yhZ/D1M6@Gentoo>
In-Reply-To: <YF46nvV3yhZ/D1M6@Gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc9ecd4-8638-4b48-059c-08d8f09c4803
x-ms-traffictypediagnostic: MWHPR11MB1758:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17581C513851BC1251D95A58F0619@MWHPR11MB1758.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPToCOjWB0jZkpZ4reBrgTMs/lsKTUEk9JzImx0RFDzP0vi2l2a9XnAISEzHriIuofOysLWZs2hQwmIDkE5fOaifurLJiAqb+JsoqFJbfcjmx1bMCMYSscah1vwZJQbdMYacJnyeR0TGV+M0Y9cHrUlHaGDyGZlaamxI77en1YqWADBFrz/uh53Sd5CodNupkaDM9lfOpgF7KYGx3XRmkR+s0Isil0nQeQtoKvzK/6EdaDvZlOqQ2KTgqDQDP0O2ZnKSYDa9YGR3BPntRVm8dMB/U4x4DXUAaoMxqGEhZfcrwnw+NgWmDz+xpCzE+rk1isPmtfQYDj+QuHbno0aCp33QtmAgB7Qug2hlRmY+2JQt7y6hxqq8ZFSgR2SnRnnrA+RqwyyxGUg3UePBFqL70kiSqD9eFpxRzg3xdD5tFzAojciSRQ8EoGQvZ+Dec7TlQIz04pVi3y9kx+CpWK5rreNDOncHSm7zRQddqBhi7mXlzQhHXnxwfyZZqnX1kNegaQhEZASncrrt7THgyRZmIAfn+LNibCXvuFW35Z5Iom0rsMFyI/z4xD8vZg5Wq5SWAmJKe/l/3bW4tS8ncNVYr6DGtfbw8n8xrTO/FGe45znbCyK9WfD+n65NJzQcxql2aAeJO4zzsPtrf6mf1n1NRVazdZrbYFCxeHEHtByOBWNZR/IT3G4xYw0u8S9jfyl3qWfdOUcx0+FEXZ+3Nx7JgaIc2ODsC0RP5xKdBTgguHG3DjwoGqkx+ZJvaNX0u/aZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(9686003)(316002)(2906002)(64756008)(55016002)(26005)(54906003)(5660300002)(110136005)(38100700001)(52536014)(966005)(4326008)(8676002)(8936002)(478600001)(7696005)(33656002)(76116006)(186003)(83380400001)(66476007)(53546011)(86362001)(71200400001)(66946007)(66556008)(66446008)(6506007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LV44Jq7XWieOwr9eJbG2NSuy99o+MocRv7aMBnGD2rojSq07H3mnXpaQsT2n?=
 =?us-ascii?Q?Js2OxbVA/rcM9bcC5H9ulTsC7wDXtdQ9rXRTudywedqebhH7C3C+Su2AqvLV?=
 =?us-ascii?Q?2heFxjcUNu8W4Gg4P25z0yLoCStTLBfOfSEtXmJuUDfGbwKgcKHLXxygWrBc?=
 =?us-ascii?Q?QKQiePQyq7o0A+tD4L5GaF9dfIgOIbx3a9QICnrVsasbyv16FF7JLjwysQy3?=
 =?us-ascii?Q?bKWw7AeCu8EIqbgnkLjK1gd8HEXVMwlI6DGVCi9aGdi2MRi4J799fC2suzU/?=
 =?us-ascii?Q?3pvnYW5kRNKMAI78PSh/3/sOqm3SwkyhrYSX8J3FvoM6i++XpMzmIbXQGyD7?=
 =?us-ascii?Q?zkrfZ5BVNC2ohIVK7oH1FsAmPY7zM51CQAzxPi6shE408JTnnIoMwFO4RZ/r?=
 =?us-ascii?Q?rPTX3BTrQWEZoq9E01CqzlfDmevrXedRb8cahMMImBj28+zyKitu6ToNpxia?=
 =?us-ascii?Q?0rX2bCeeKtNuDzCY+ilDQarrVw6PH2DYErIwImo+IoYwB5sWUKoh/EV3T7fs?=
 =?us-ascii?Q?2ey1X+6hmtd0EzEETWg95cRDT7buztOBIvV+in+gSYflkHXJEQPpVZtNt/tF?=
 =?us-ascii?Q?B2p6VDRHrCgpTtPHmz4EGhoWqhy3RI3c55I9kAW2OJ0YO0aOu3XD6CbyFEON?=
 =?us-ascii?Q?fYoiWGH0p7IntuLaFj6HCVW/WCB6JCCbP3Yu/7IBA6Ew4Y4fPIyotPeh9Ufv?=
 =?us-ascii?Q?TZaJ9uxizO65EGVSo+exxz0diwqZal3xsbD1RwBHSu/eveW7kxS/HcKsSapP?=
 =?us-ascii?Q?Z/jfII1iamYnCxvqHj4+aWvIQqkpFjuDWfGw8hD2XKv3PbhgYRuriH2KLs0y?=
 =?us-ascii?Q?0jqn1pSKCPUM1JzuqBF4DWWRswKwQ3N7fPADODgjzbPoN/0WOIEKksQLJq7c?=
 =?us-ascii?Q?Ofd8LC1j9dSgggcalicIaLXYVSUsUbORLrE2UKiHke4QzcPekVEwlXCAozeJ?=
 =?us-ascii?Q?WxlOWQrA8B8AGkF1QnKxp4Ldy5RmhkzJ3a7R12oKz4m5xnkYgNr2xoaAgsIO?=
 =?us-ascii?Q?PjfQBW5RYL3RDrv1acjW5M30uNvYdIAkTzKxz0Xwz+rH+nk+xZhKscNVyVEB?=
 =?us-ascii?Q?QmeR/xQ69oVUetjhb7HeS+zrMRugTtfoXL8AsuqFuVBXrPDp/20AHw6dxvjA?=
 =?us-ascii?Q?4ulskC2tCK9FFAM7u5ibG8AinT0KolCUd6SJ380a4iqnIH35SqV/sjM7tA2A?=
 =?us-ascii?Q?zW/buE5k8oYAOvp3o5FgSogXvHzSa7qs90fJjNtoAx0As8llLkwnTjWM0t10?=
 =?us-ascii?Q?DrEaIWuFwEBvftxB9UUYlXV6fBArRDpPlSAIH4PBBoLIViLOrcANBHLOLW3U?=
 =?us-ascii?Q?B2tpqHsPXWYipH2WHju9k3FL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc9ecd4-8638-4b48-059c-08d8f09c4803
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 21:15:28.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxBK5jdemo1lFyVWOd5oO0/U7rRpcR0BZOGQeOSH3FHJPC95Keq6R+OuxFzhJiAP5B3QQi0SXxra6nLCWFA7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1758
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Sent: Friday, March 26, 2021 12:49 PM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-acpi@vger.kernel.org=
;
> devel@acpica.org; linux-kernel@vger.kernel.org; rdunlap@infradead.org
> Subject: Re: [PATCH] ACPICA: Fix a typo
>=20
> On 14:56 Fri 26 Mar 2021, Moore, Robert wrote:
> >Please make a pull request for this on our github.
> >Thanks,
> >Bob
> >
>=20
> A pull request for this trivial spelling fix? Kindly be reasonable , it i=
s
> just a single spelling fix, had it been many ,the suggestion could stand.
>
> Kindly, also , let me know aren't we  applying patches from the ML , or i=
s
> there some specific rule for this project. I might be missing the basic s=
tuff.

The code under drivers/acpi/acpica is from a separate open source project l=
ocated here:

https://github.com/acpica/acpica

You submitting a pull request on the github facilitates our maintenance.
Please make the pull request there so that the codebases are easy to mainta=
in.

For more info, read Documentation/driver-api/acpi/linuxized-acpica.rst

Erik
>=20
> Thanks,
> Bhaskar
> >
> >-----Original Message-----
> >From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >Sent: Thursday, March 25, 2021 5:19 PM
> >To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> >Cc: rdunlap@infradead.org; Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >Subject: [PATCH] ACPICA: Fix a typo
> >
> >
> >s/optimzation/optimization/
> >
> >Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >---
> > include/acpi/acoutput.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index
> 1538a6853822..1b4c45815695 100644
> >--- a/include/acpi/acoutput.h
> >+++ b/include/acpi/acoutput.h
> >@@ -362,7 +362,7 @@
> >  *
> >  * A less-safe version of the macros is provided for optional use if th=
e
> >  * compiler uses excessive CPU stack (for example, this may happen in t=
he
> >- * debug case if code optimzation is disabled.)
> >+ * debug case if code optimization is disabled.)
> >  */
> >
> > /* Exit trace helper macro */
> >--
> >2.26.2
> >
