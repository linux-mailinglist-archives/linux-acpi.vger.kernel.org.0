Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA124366ED
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Oct 2021 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJUP7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Oct 2021 11:59:04 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:38413
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231621AbhJUP7D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Oct 2021 11:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuQp5UJaSIbBcEiaIr9MiVoSU1GFekl2WpL7QFSP+6iemcwJ5jxNIZIagGajw83CZfINc21vqB2kZiFuKSrEAQB+ghm40TYcgx7b7DyWetsXJV1TJdq4TyJvgAvYSgg5sX/HihocDUtn5Sw/jeqCRrP3s4K3FYHajiTxQ2g3nzGQdV14RxwnF4ZdhbsyoNndvUHUEQKEHtzt1hhNHvJ4bq6TzURt7CHN3iwbk6/XzJNkB03Hd3cnT2DbYj/J+U746aTcoEBy6+ryGdeSATxySN9mo1yv4nDnwqlFzvmFoLxsucTVCvSSYFY6HItDthOpMQj4wMRpSiIRgB8pmhflxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECguZF7EYYDe2IMpDrbKBjaSg57m3KJOBx7EdCabiB8=;
 b=G28LLns1Urrkt6ZG/tOHMdX3upAci6KmH9vP3Lvq4+3sgLe74oaokqa8EqBS3RLNGo0MxRytRl7N+5puQD6nyeBCaI2zuXlDaF9v0hQcPDcyitJLCYYzRtx6Dxd/w2wZLV5u+GTkfV0sWCKn9wR3rT/ZBERdXLQE4PjxGKnnhXyKRYuPoTd507gNWNV3fgtmkLPii+aQQUCXNnEEdspa6UFm2ZKyFjwSFNXT82F5o9nJ55fssVrRGwZ/qUfVoS1cEeoeNCMy0rGgVoTlT35AVYMrHk1Vpe9nvBMIfweyvhYfmfTPt0p/2rVkmJwwxzfOBCycEzLVzuZzgs2Q+0I0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECguZF7EYYDe2IMpDrbKBjaSg57m3KJOBx7EdCabiB8=;
 b=e9tmCGhd/W4HK5ik8trbTOMylVxpwa2o79Q+ggOkGr8he1xBxy18z/0RM/XhvHabQHPEYmzgFreUvL7CFoDToNoEEPrQeE+Kz6bjgiluvgm6uhUxJYOL+M2WDtlhDdxlG2oOaKXoI5uq2DGaDaAuDXgd37fZnEOGo+QbP9Vnei3GnzPQzqacvFRmeAlZt+E+EbzQaQy5N80O4MJ9mbJajK7Vw6JW/heJ6IYRi78bYpVR2pYbz9BGB/pgm5jQuFe0tifYitBsPidzvtoYW4XwoR8EMw/+HlaJG/9Q0R4NDZ23JgdF4NCF3JryNCxnbWdxbMkaKf5kHYpMOd+/5WrdVA==
Received: from SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 15:56:44 +0000
Received: from SN6PR12MB2653.namprd12.prod.outlook.com
 ([fe80::40c5:c7eb:1d30:ef68]) by SN6PR12MB2653.namprd12.prod.outlook.com
 ([fe80::40c5:c7eb:1d30:ef68%4]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 15:56:44 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Thread-Topic: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Thread-Index: AQHXxKZe60cPDaefoEWZ2yrjkoK6lqvccmsQgAAyVYCAAPOoEA==
Date:   Thu, 21 Oct 2021 15:56:44 +0000
Message-ID: <SN6PR12MB265309099EDA5C3C1311C6B8BDBF9@SN6PR12MB2653.namprd12.prod.outlook.com>
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
 <20211021010023.GA457926@alison-desk>
In-Reply-To: <20211021010023.GA457926@alison-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d294722-2cdf-47cd-a739-08d994ab61b8
x-ms-traffictypediagnostic: SN1PR12MB2400:
x-microsoft-antispam-prvs: <SN1PR12MB2400EF8DA08D1C242687F2FBBDBF9@SN1PR12MB2400.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ev7cK0vk+ZdcpruROINCAH4gg9gvfQwKW9vSGvRqw/m4ZkRhIuY+i+0ihvi9ejnk0nbXq7nw3eSGyzNkAyKX1MwyEdG2nXts3l4iKva+XkdvAZ7Bp7UYVHU0S2P8FnVWS4+Fs4l9MfjJ55bBMfFwlvY+hv857ODM1jJ77nLGbY1/pTX0BZr/oy3hX5YEQjvvZy+PvqgvW62ubmJl3YjBBgbmtXVydGP92FyJtRcTMF53eIoMvWG0FvfRaVpSKJUclQP8Na4NXSszDGp7lcZAE93NKS6dALGHJndz3EPnqAW3Ojrzjx94aDmB3ZDv/ODX9CAB6kr16y5/5i4pJ9odk89NkxezNh6vThgSPv5Mfep1R7bgPiUjtSmZvBjA9r65cmXBCIJmoDQ8KkDw777enPswI7SVh0Rpy+r4xdxri/t5XfTJCUAWWzeT+lNkPWYR4Yr2ENE9zBhlMHWF+j7+L+0G9WeZ6jInslebAxHr4B0pOYhU/yINfvQQb3OifZqanMv06X+ZQx64zQUpJRpZRschXQxLRKhFygBN6OqmnETRg4NtmTYUfj5Yh7WjEvWD7DHD9+Ac+lElBG5BQT4MXoQcfKXwkakI4Gyk2e6NgDQ63KP1lcbRzG3au4wxOOc0HVPDpxOoQcj74YORy1AM+GAA0f95hs8tH3ePLbZrQeJSrWvg+rS/gOAnarQynczGfLSx2hD5Ecy4ATE+5QE8ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2653.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(54906003)(6916009)(33656002)(64756008)(66446008)(83380400001)(508600001)(66476007)(66946007)(26005)(71200400001)(186003)(8676002)(66556008)(9686003)(4326008)(7696005)(5660300002)(76116006)(55016002)(38100700002)(38070700005)(316002)(8936002)(122000001)(52536014)(2906002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3QQzilPWPFdwbF65+DBwGJg0ks6rMDqDfd8aXy4R8t9myG+wEm/FKRL4lmGu?=
 =?us-ascii?Q?Sv+MZQ5fRazxpQWHgyCxOd6gYslsBQqgPmnROHmWfMkCc5jDeaTqQiChLUH/?=
 =?us-ascii?Q?MLPjGbetNjx0PPhcDnyNBg8cQxT38Nt6j8pxkw5wVJmyj9gN2TNvcT+QEBRm?=
 =?us-ascii?Q?sbyMIYRXGYL9hPA/H6SiO01MQdMT+ffmn0mxAitn6pgsqIX+PZSBZbL0lhDA?=
 =?us-ascii?Q?WhOxMIR3sO7cj8rtOUnYD25t8MBLe4Z89TS2u/FZai7lhkrpqs5kHbIZ+APL?=
 =?us-ascii?Q?pC/J1FQJ/TaqDMlmE4pd1zA6uyhFwbnF5h8WmEL0sPnztkY/6ae/a989XoaB?=
 =?us-ascii?Q?oSUvEEW/6zDdM3aM8TERlEHyFo9gcB3AFeJESs3RQsoj8dmnzO+cYlatJlja?=
 =?us-ascii?Q?+ubsLi1GavGX2ATJ/DRd0bMe+YOg6HZ1cxraafbJ8EDDVnidVgWLJ+cHSVri?=
 =?us-ascii?Q?AwG5il6mrSpGNDI4Qiq3ufhQTG2UhYRXFeuadnNHK0sBDqKL7xQLd+Qdw5eu?=
 =?us-ascii?Q?f/7FyebF7rU+5hzAS0I15AbyaWRp3ADz4pLWXR3E/AwtXdZGgcP6izLJI85h?=
 =?us-ascii?Q?1DwkIudYl3y+GFh2n9ESq9Kogw2GklYjmB3zvNOI1oq0dDQ5MtSZwr8a9WEY?=
 =?us-ascii?Q?QMwZSFdoWLeSkVw5uzQO5OmitUquxMKMV2m17wgzWmEp0o+RZLlnWbyOLY3X?=
 =?us-ascii?Q?40Zoc4I0ldTKMEzuuM4/aYPGyXQ/3PKL1cJCfBS6LV/YiNSdHYxqpDA4RGQM?=
 =?us-ascii?Q?/3akzqYZi8CRsaO80oCu1NCIYjA7VCnJAah3vjUZLqsWB04o5hyac5FdMWbR?=
 =?us-ascii?Q?AUUy8ugvh2VdnFwWF+5E0mAtqWEwK5EnfYgkOIklIIFP2r9tjcvjiEaM4R0C?=
 =?us-ascii?Q?Dp18bmiivgjTw9nevpvTv+TPVDP+9ibrsf8D5NhhuN2jyerQcVko+eZbqDqq?=
 =?us-ascii?Q?rYvEYPcEgQQF0kv9ZeXetmRXaq7RK0boXUf+25HdI2cspgkXWM6miXpBpTyl?=
 =?us-ascii?Q?0+Ii2aK5H5vASp/stimcAip7YSgMGSO+8Mco5qC9/rWo7mRtmNHXlgCzs+lg?=
 =?us-ascii?Q?TOfOy9msUAFOvsLFb0cK9Eib+0p9gnoxt5J88a47FvoEKhX6LxB2jDE+fQcb?=
 =?us-ascii?Q?v5aeSQpxS1lRAs4e3U48q9BV7QlhYpXRgTp8rW1yf9oNU4y/84OvikbojWYN?=
 =?us-ascii?Q?z/yi0vhCIoIl+OEX7WhyrNqoCjskgJNg5/eAiEmWspmlRyRJAGff4qCHZ5gu?=
 =?us-ascii?Q?uVk2J1nzvRcIGpHRTD8ozAPegQf3XH185d8ziDJieVlHz0prP7zWiDju+TjH?=
 =?us-ascii?Q?P2ur+i9a8SCKEyigEV7CbS8v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2653.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d294722-2cdf-47cd-a739-08d994ab61b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 15:56:44.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsethi@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Wednesday, October 20, 2021 8:00 PM
> To: Vikram Sethi <vsethi@nvidia.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> Vishal Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>;
> Ben Widawsky <ben.widawsky@intel.com>; Dan Williams
> <dan.j.williams@intel.com>; linux-cxl@vger.kernel.org; linux-
> acpi@vger.kernel.org
> Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each
> CFMWS not in SRAT
>
snip
=20
> > >
> > > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Does this patch work for CXL type 2 memory which is not in SRAT? A
> > type 2 driver can find its HDM BASE physical address from its CXL
> > registers and figure out its NUMA node id by calling phys_to_target_nod=
e?
>=20
> Yes. This adds the nodes for the case where the BIOS doesn't fully descri=
be
> everything in CFMWS in the SRAT. And, yes, that is how the NUMA node can
> be discovered.
>=20
> > Or is type 2 HDM currently being skipped altogether?
>=20
> Not sure what you mean by 'being skipped altogether'? The BIOS may
> describe (all or none or some) of CXL Memory in the SRAT. In the case whe=
re
> BIOS describes it all, NUMA nodes will already exist, and no new nodes wi=
ll
> be added here.
>=20
My question about skipping type2 wasn't directly related to your patch,
but more of a question about current upstream support for probe/configurati=
on
of type 2 accelerator devices memory, irrespective of whether FW shows type=
 2=20
memory in SRAT.
The desired outcome is that the kernel CXL driver recognizes such type 2 HD=
M,=20
and assigns it a NUMA node such that the type 2 driver can later add/online=
 this memory,=20
via add_memory_driver_managed which requires a NUMA node ID (which driver c=
an=20
discover after your patch by calling phys_to_target_node).
Would the current upstream code for HDM work as described above, and if so,=
 does it
rely on CDAT DSEMTS structure showing a specific value for EFI memory type?=
 i.e would it
work if that field in DSEMTS was either EFI_CONVENTIONAL_MEMORY with EFI_ME=
MORY_SP,=20
or EFI_RESERVED_MEMORY?

Thanks,
Vikram


> Alison
>=20
> >
> > Thanks
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > > Changes in v3:
> > > - Initial variable pxm (Ben)
> > >
> > > Changes in v2:
> > > - Use MAX_NUMNODES as max value when searching
> node_to_pxm_map()
> > > (0-day)
> > > - Add braces around single statement for loop (coding style)
> > > - Rename acpi_parse_cfmws() to acpi_cxl_cfmws_init to be more like
> other
> > >   functions in this file doing similar work.
> > > - Comments: remove superflous and state importance of the init order,
> > >   CFMWS after SRAT, (Ira, Dan)
> > > - Add prototype for numa_add_memblk() (0-day)
> > >
> > >  drivers/acpi/numa/srat.c | 70
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/acpi.c       |  8 +++--
> > >  include/linux/acpi.h     |  1 +
> > >  3 files changed, 76 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index
> > > b8795fc49097..daaaef58f1e6 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -300,6 +300,67 @@ acpi_numa_memory_affinity_init(struct
> > > acpi_srat_mem_affinity *ma)  }  #endif /* defined(CONFIG_X86) ||
> > > defined
> > > (CONFIG_ARM64) */
> > >
> > > +static int __init acpi_cxl_cfmws_init(struct acpi_table_header
> > > +*acpi_cedt) {
> > > +       struct acpi_cedt_cfmws *cfmws;
> > > +       acpi_size len, cur =3D 0;
> > > +       int i, node, pxm =3D 0;
> > > +       void *cedt_subtable;
> > > +       u64 start, end;
> > > +
> > > +       /* Find the max PXM defined in the SRAT */
> > > +       for (i =3D 0; i < MAX_NUMNODES - 1; i++) {
> > > +               if (node_to_pxm_map[i] > pxm)
> > > +                       pxm =3D node_to_pxm_map[i];
> > > +       }
> > > +       /* Start assigning fake PXM values after the SRAT max PXM */
> > > +       pxm++;
> > > +
> > > +       len =3D acpi_cedt->length - sizeof(*acpi_cedt);
> > > +       cedt_subtable =3D acpi_cedt + 1;
> > > +
> > > +       while (cur < len) {
> > > +               struct acpi_cedt_header *c =3D cedt_subtable + cur;
> > > +
> > > +               if (c->type !=3D ACPI_CEDT_TYPE_CFMWS)
> > > +                       goto next;
> > > +
> > > +               cfmws =3D cedt_subtable + cur;
> > > +               if (cfmws->header.length < sizeof(*cfmws)) {
> > > +                       pr_warn_once("CFMWS entry skipped:invalid len=
gth:%u\n",
> > > +                                    cfmws->header.length);
> > > +                       goto next;
> > > +               }
> > > +
> > > +               start =3D cfmws->base_hpa;
> > > +               end =3D cfmws->base_hpa + cfmws->window_size;
> > > +
> > > +               /*
> > > +                * Skip if the SRAT already described
> > > +                * the NUMA details for this HPA.
> > > +                */
> > > +               node =3D phys_to_target_node(start);
> > > +               if (node !=3D NUMA_NO_NODE)
> > > +                       goto next;
> > > +
> > > +               node =3D acpi_map_pxm_to_node(pxm);
> > > +               if (node =3D=3D NUMA_NO_NODE) {
> > > +                       pr_err("ACPI NUMA: Too many proximity domains=
.\n");
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               if (numa_add_memblk(node, start, end) < 0) {
> > > +                       /* CXL driver must handle the NUMA_NO_NODE ca=
se */
> > > +                       pr_warn("ACPI NUMA: Failed to add memblk for
> > > + CFMWS node
> > > %d [mem %#llx-%#llx]\n",
> > > +                               node, start, end);
> > > +               }
> > > +               pxm++;
> > > +next:
> > > +               cur +=3D c->length;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  static int __init acpi_parse_slit(struct acpi_table_header *table)  =
{
> > >         struct acpi_table_slit *slit =3D (struct acpi_table_slit
> > > *)table; @@ -478,6
> > > +539,15 @@ int __init acpi_numa_init(void)
> > >         /* SLIT: System Locality Information Table */
> > >         acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
> > >
> > > +       /*
> > > +        * CEDT: CXL Fixed Memory Window Structures (CFMWS)
> > > +        * must be parsed after the SRAT. It creates NUMA
> > > +        * Nodes for CXL memory ranges not already defined
> > > +        * in the SRAT and it assigns PXMs after the max PXM
> > > +        * defined in the SRAT.
> > > +        */
> > > +       acpi_table_parse(ACPI_SIG_CEDT, acpi_cxl_cfmws_init);
> > > +
> > >         if (cnt < 0)
> > >                 return cnt;
> > >         else if (!parsed_numa_memblks) diff --git
> > > a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c index
> > > 10120e4e0b9f..ccf73f0a59a7 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -122,9 +122,11 @@ static void cxl_add_cfmws_decoders(struct
> > > device *dev,
> > >                                 cfmws->base_hpa, cfmws->base_hpa +
> > >                                 cfmws->window_size - 1);
> > >                 } else {
> > > -                       dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> > > -                               dev_name(&cxld->dev), cfmws->base_hpa=
,
> > > -                                cfmws->base_hpa + cfmws->window_size=
 - 1);
> > > +                       dev_dbg(dev, "add: %s node: %d range %#llx-%#=
llx\n",
> > > +                               dev_name(&cxld->dev),
> > > +                               phys_to_target_node(cxld->range.start=
),
> > > +                               cfmws->base_hpa,
> > > +                               cfmws->base_hpa + cfmws->window_size
> > > + - 1);
> > >                 }
> > >                 cur +=3D c->length;
> > >         }
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> > > 974d497a897d..f837fd715440 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -426,6 +426,7 @@ extern bool acpi_osi_is_win8(void);  #ifdef
> > > CONFIG_ACPI_NUMA  int acpi_map_pxm_to_node(int pxm);  int
> > > acpi_get_node(acpi_handle handle);
> > > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > >
> > >  /**
> > >   * pxm_to_online_node - Map proximity ID to online node
> > >
> > > base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> > > prerequisite-patch-id: f09c67c6b3801f511521fd29c1cc01f5c5b1e9de
> > > --
> > > 2.31.1
> >
