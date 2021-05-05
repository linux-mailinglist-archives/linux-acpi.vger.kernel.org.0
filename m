Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87AB374BBC
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 01:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhEEXMq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 19:12:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:53089 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEEXMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 May 2021 19:12:45 -0400
IronPort-SDR: V2B8afOcZs6Ny/i1kYZpx7jLQILYdIV19vu90LpkpoS065kcohM4IXRCI38scTh/2TVDMaaYPA
 zayCazxsvabw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="177884671"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="177884671"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 16:11:43 -0700
IronPort-SDR: zea8WnRgrA/5ZEWaPUlc9WggkQchG0DwpGl6urKqjQgOSbsDC0BwO6RJ453YFQ35I4oA8PHePv
 d1T8HhPxDUKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="389357486"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2021 16:11:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 16:11:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 5 May 2021 16:11:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 5 May 2021 16:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM4IxQg4wkOFNqKJ6QZZgCxCdd0lZqgfMlNI2Z4mVp4+Dr9stC4DTn9HJxluLXs7PZvCtUAVZCy7iEuvF+BaFn6U6qTs1JKqyLzQA0bCnK2X3RNXZhJ8WYeJM0JbvAtV0xARlIKZFPv2kwAso49IuT7/h/Ozy6Z4CzbYRaSSDfQFf2J1qQrpQ7psZm3arHFQ2kfw/G382+pagt3US2hIZDOPm1DeuZGNW/q5ZLodE2PLswuBrzwRQxb7B07maGFjyptf8rsZ6TMKHHIM+QC+fHZRLqmAandn4qrgsHena5K7Jimau1Am3izFchu8q3+2D2HtCOhFyK2VgW8TAHzIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4HUi23MUeFuXeGvXYRQbUDHQ0Q7I6ICO4J6PsiEExg=;
 b=YqHwoI8C2863CtsYRS4jIGe3r4VvHuk3rtac9xV16XEk/pVqWzA1lyqzRoQWTgz4uto3x5yn8qeD8spF0WrJ5vK1ycmvjinnecsqaU46z2xyfOekDYUgNpnWMVh+SVpsWk4jsfcrq8aGaJW+Vt/bQZyQ6CK857b0yd73xQeiWSrnX8P5xkd47GqM++ZnyLMVZWx1k55s/E6Wan5b1SqEQnbCRf6U5eYAfBnZUPABH/4RCNtjrqnWmLQO/tWkLaLavN924ICvblmFfQdEhaMczOtiWEohAXe0myjVMWFPFIxk29wveCkelcLK9qHjOk8xL+7jKo51yRQErHK9MN5zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4HUi23MUeFuXeGvXYRQbUDHQ0Q7I6ICO4J6PsiEExg=;
 b=yRt7nTBISf6FSTltZ8N9hV0tc0LVm72Kzuc+MS4ZmKjNi6a+gd9w4dbuT6afmP/RFvnsPbMl1qk7GzVAgkoNBHqjL8U1aZfq8lwOTAuKjVnQBfNFnV3ZnZCeLZAGT/OXSAW4vHr2swsbJ4yLQSjqSqnI+tuccucsV6lzH/k/6zk=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1646.namprd11.prod.outlook.com (2603:10b6:301:c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 23:11:36 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 23:11:36 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA:dbnames: Fix a error free in
 acpi_db_walk_for_fields
Thread-Topic: [PATCH] ACPICA:dbnames: Fix a error free in
 acpi_db_walk_for_fields
Thread-Index: AQHXOwaEMMs9kJYcc06jsm/pDRsLMarLxwAwgAnGeQA=
Date:   Wed, 5 May 2021 23:11:36 +0000
Message-ID: <MWHPR11MB15993557BD12B767517A09B4F0599@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210427014134.3568-1-lyl2019@mail.ustc.edu.cn>
 <MWHPR11MB15992FA009C23A74FCBFD204F05F9@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB15992FA009C23A74FCBFD204F05F9@MWHPR11MB1599.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:306c:de08:5ab3:a78d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c715d7a9-f238-4ff2-4969-08d9101b21b6
x-ms-traffictypediagnostic: MWHPR11MB1646:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB164613949A43B04F4654EC7DF0599@MWHPR11MB1646.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt1R5gtnYZbUx7PZpFQUnyF4XLyDR1lWzb3K7yrlzME+ci/yEzXD7lK1S34pmFLj7RphNx977nVFiNJHPnuwi2L9Le/+o8LGsgf/zlJBTD7NB2yNlsRUagBdYo9x3H/cOGumCgWGUjFB/L+9zD+jzQMrs7qTYExU3lxW9D3hADmIvyf+fuCAgjPUQHggRrOVkz3lNKLew+3yBScDyXwdaMKrHCGoyjz22lJf9DtqjEqs9n3bgYumRqO2CYMd2RbswD5+wOOZqgkRZzfYugAUL7okAXKoaROV0i6nFt+X0Co364RF3oD5gPXYAih5/mIx82NEOEusGSJwNKO6zS2qMGhw9x7ErLpimMlnUD0daXsgRjqEj9IBNd6HV6IouQAED0afFz5bCSw3jNt6GDWhl5dvTiC3ipgJaHungNhjLENGvNd7sENQ+vZaI4mRV8i8Xqz3DzTTBq0MBW8PAUFflqFZU+LFrEb2IbDfWAJ0dJIm/uagabh7+7KF31fYwf4t6TZ8KB8R762oGkSTf+n7VVwieLcm+nZ0wq0XHD5W8AnUQ7gfVeY+wG/P3eBVz1mvlQ5gTuIahnmfwr4p98S7YElPr+UGvv/prScH9cUjy0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(8676002)(186003)(71200400001)(66476007)(6506007)(66556008)(9686003)(55016002)(76116006)(110136005)(53546011)(66446008)(64756008)(8936002)(2906002)(86362001)(33656002)(316002)(66946007)(54906003)(4326008)(122000001)(38100700002)(5660300002)(83380400001)(478600001)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yW1cczsjJm8MxgRF2R8bGO9B/HrLvgIm2HI/YLxIyV8gHii7e2OPByXtN00k?=
 =?us-ascii?Q?6iHxk+5A8kQHAoRSdmiJxK7wP4Vj5l6CJ1qvbEX/ZnWbXH1+g/C87F67WRBG?=
 =?us-ascii?Q?qEf6TdbkqJqcjoWQkbT5pAKw6XiB0ly2PxLl+ItUAwbj32LLcblhew0dTXmB?=
 =?us-ascii?Q?WwxIREtzKraNHJhd8p8YzmBVLa2yTYonWxTjk360H77T8flVR08o1qcBFiAD?=
 =?us-ascii?Q?kumRd1DxqVC7vT37UZpo6/2kQjNMCF05AaehkCzjSLF4HDut2FuCfaS3jDtz?=
 =?us-ascii?Q?QxNSPIdhr7Sd5J4f+JyaNBdgXiFC6H/m8FnLKpZLPQPcdPiJ/2SAAP2zYq+A?=
 =?us-ascii?Q?cP0vLXjSfOhn9wqA3t1+lxRWYw2AC6IGF/+PjYv84h+fQ/3uZHkETpA7DzfD?=
 =?us-ascii?Q?kus6wgu0sxNtLtq/OEVWdJWycpgCyAt9NTY5vShyfJ/0zje1/V8HUfl2g0dD?=
 =?us-ascii?Q?e2ZdnG2jbvEaYYosG5GVibhLXjjKcJZBSMpLJhnQvLQpdrdXU7z4zDCJ/dg6?=
 =?us-ascii?Q?mpCrdcfDp+x/UzLQiDVcW9pSYD8MeRSzmR6xvfRFIVgvVZBf0a+eHaq53Qcd?=
 =?us-ascii?Q?9gHpdr75+3UDSvDzRowDs0r7mNxOlMIN2IzVI90rPzVuefK6t2IDd/ZzVQ+C?=
 =?us-ascii?Q?yce8Q0MMHO8vjCNsEFOC/QGSxgDYhf1uaXRZLU1GB2GAWF4N4nKUITRI8WHx?=
 =?us-ascii?Q?ZISQ2hEp72WArSkM8a+Ma3Fde71YY8n6DFPFLeVWTxkF6URS8mHLUc+7jnly?=
 =?us-ascii?Q?L1VxTLvD4WNIJBN08c9TUuiuBhVS/Epq2JUoY2vhCx5y77qs6fj2ZoJ3COM3?=
 =?us-ascii?Q?ChEkQd8DM1S2j+PmwRHXeQA/oKSNtHXV6ATUqxXc9ethyIMjNZaAdFUgl+DC?=
 =?us-ascii?Q?7v3xyh40A0bPh27xVL9wlmeepbmBKB1oIYe9+FG3nBlQF0xV0vFyJafQv7Hp?=
 =?us-ascii?Q?YkJ1a4VelQ9FR0tR9cKYQrn6f0v6f2WlFvjh440Qtgp3I4uXuxbdcLix1EQr?=
 =?us-ascii?Q?3BTStPKxnwT8fa16uz1rjTFSpXco/K7HCKjQrzr8oePRBmqi/dHWuCeechsD?=
 =?us-ascii?Q?OP/eVjiYxR+l4A/rzQrtVGCQK+C7lWeGwl5ToAtPxi0gpBL0MbH7MQo2OyV0?=
 =?us-ascii?Q?RAABa4XhAC7lMSnxIFHhQ+bEnp47KUaBk/UT9AEXrAvw8hTc2liR/BRBjhL3?=
 =?us-ascii?Q?ebDymJ6sPt1DjX+23yymaAAFCdTlLXMvRH7tsRlY0DZNeUyWT3fPqovHD5iU?=
 =?us-ascii?Q?1/UczJktY+XMAnYnrc46w6WBshiji+Ixej2bm08S17oaGOH9aG55ROjhyyM0?=
 =?us-ascii?Q?EWU1qkxbOVXja54U+qU1xNOQKbuyWLogsZbkWYS1+lmwdKE2qfvrhCkXbZgz?=
 =?us-ascii?Q?FfEQd1+2Y7uFrqc3t7Sil6n+BdiC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c715d7a9-f238-4ff2-4969-08d9101b21b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 23:11:36.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBGAINrw/GF9ArZwFc3ypzEJEz57eyP4tWdgmyttVk9RFcNflpYf2ozj9JbRvYn2jgvG+j60nvIzA18FCB2Pdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda@intel.com>
> Sent: Thursday, April 29, 2021 11:01 AM
> To: Lv Yunlong <lyl2019@mail.ustc.edu.cn>; Moore, Robert
> <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] ACPICA:dbnames: Fix a error free in
> acpi_db_walk_for_fields
>=20
>=20
>=20
> > -----Original Message-----
> > From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > Sent: Monday, April 26, 2021 6:42 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>=
;
> > lenb@kernel.org
> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > kernel@vger.kernel.org; Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > Subject: [PATCH] ACPICA:dbnames: Fix a error free in
> > acpi_db_walk_for_fields
> >
> > In acpi_db_walk_for_fields, buffer.pointer is freed in the first
> > time via ACPI_FREE() after acpi_os_printf("%s ", (char *)buffer.pointer=
).
> > But later, buffer.pointer is assigned to ret_value, and the freed
> > pointer is dereferenced by ret_value, which is use after free.
> >
> > In addition, buffer.pointer is freed by ACPI_FREE() again after
> > acpi_os_printf("}\n"), which is a double free.
> >
> > My patch removes the first ACPI_FREE() to avoid the uaf and double
> > free bugs.
> >
>=20
> I'll take a look
>=20
> Thanks
>=20
> > Fixes: 5fd033288a866 ("ACPICA: debugger: add command to dump all fields
> > of particular subtype")
> > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > ---
> >  drivers/acpi/acpica/dbnames.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbname=
s.c
> > index 3615e1a6efd8..dabd76df15ec 100644
> > --- a/drivers/acpi/acpica/dbnames.c
> > +++ b/drivers/acpi/acpica/dbnames.c
> > @@ -547,7 +547,6 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
> >  	}
> >
> >  	acpi_os_printf("%s ", (char *)buffer.pointer);
> > -	ACPI_FREE(buffer.pointer);

This is freeing the pointer allocated by acpi_ns_handle_to_pathname

> >
> >  	buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
> >  	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);

This call to acpi_evaluate_object will allocate an object in Buffer.Pointer=
 object so the dereference of buffer->pointer is not a use after free

> > --
> > 2.25.1
> >

