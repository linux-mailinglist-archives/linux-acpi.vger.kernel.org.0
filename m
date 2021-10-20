Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81C4355AD
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Oct 2021 00:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJTWGP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 18:06:15 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:34177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhJTWGO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 18:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfSBX9Jl9wcyyJOoSQ2vZuzjSWIbDDvhsntteulq1o6koa60/DB88uFs3Nam5oTMkfqxmwb9jPcZ64VL9iiWFuLLQnZHk3tlcAGKCFLVzpOMcD3p82OehjJfGfWtumBjQNqR9RC3p9ZMvfeip5RGbK9d+RPDpbSnBYPXDbA5VYUeoPF5IGEFT9I2Q9QaqRvDlCENV0S79qd2TojKHjPoNgJ01LI0m8XlF48FkcFcye5toRcflo7XSRWmRgFR+jW0Vpy117wfSXJEU3PYHc9DdVcJBKcx+iItkyczFGanOJXp7Wuk1o3ArjcnThaDmkyrHWHlc2u1a2JFPXQuOVyYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz4BjB9PZkQNZsAOkkfvZFaIlogb5YBZs67LkzJNEfc=;
 b=PS+RW7IQI4sytH+H9IYitUWCwo0qEe1CDet9Pi419ezmaTNUEtIE9ui1NqjyUX1axL55hasC8wmgZo6NiPdaE0WcqY0zfr6pRhsleimNWXC3YduabQP6fpkJ5WtrG2S7vnsuDW5H6iQlXIr1MDFEE9fTqW+TK9ovBdxkCYMoG+/2NDQYxXDwod6FKjbM3UZIWfZZ2VQ5s28jA/Saqg22jRQlF7bxXpDF299lbT5UMsm35Gm4fGeRyPJKKr2mjiDTxFVGZPDB71i65dT1k5+TNqOj83U/fMrm7Q9uH6pa2mPBp2MFHmHOrGIbBrwF3TeuUjBGC3NiwgTThTHxJ3Y4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz4BjB9PZkQNZsAOkkfvZFaIlogb5YBZs67LkzJNEfc=;
 b=SwgYUGdsWYHiIVtzeTca+CGBPNLLvYTQY1OG9fZl+XnUvx0jmQRJqzhbIDcKoVmv+BSjGSS6unYUy0crLQ9EYD/LoaNdaznQlS9XhhoUZs0RC8qw+jHhRgPzJTSaUnej6ueeo7hijToN8iK74oZ5SYwsrjZZRkMAEQVYS1ubcPUW1/opaGsqVpB8rPv8QPAGIwcAQtJWo22AH0tjDv4IcWi5+8XNCQJoHax8Ccs+CpmR5ilgqXmNGcEM9mhEdXzizDrfTY0ZyR92ZVE6a/IPXD8SiGlDXttA1dWyBa0lasdcFsbxWUpJO6xkb3To/gmU3tdpSA81PgWMj5h9QCUZvg==
Received: from SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 22:03:58 +0000
Received: from SN6PR12MB2653.namprd12.prod.outlook.com
 ([fe80::40c5:c7eb:1d30:ef68]) by SN6PR12MB2653.namprd12.prod.outlook.com
 ([fe80::40c5:c7eb:1d30:ef68%4]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 22:03:58 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Thread-Topic: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Thread-Index: AQHXxKZe60cPDaefoEWZ2yrjkoK6lqvccmsQ
Date:   Wed, 20 Oct 2021 22:03:58 +0000
Message-ID: <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
References: <20211019050908.449231-1-alison.schofield@intel.com>
In-Reply-To: <20211019050908.449231-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5825b3de-58e1-4e24-3691-08d994158451
x-ms-traffictypediagnostic: SA0PR12MB4576:
x-microsoft-antispam-prvs: <SA0PR12MB45768A7AA712CDF03DE1E221BDBE9@SA0PR12MB4576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:20;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mw8FYxt2tJdni5p+3G6pT7H9TB0MEt2jb5sI2TdoFXeZ+7TRIn7ceuuP3+ArR5SizCF15KQCrmu4+Ww72HQQarN27g32P29YX4WWva1YYDWI1/2bcGKsBChkR9PoQcYWuO+U0S1nWgEEENUWwXfymv5mbafNMiqLY+Sw250zZPjmc1yKUJj2C7ZxDz5H+9Pxvsui11A7miY+qOpGvYZM4OZGmha207abVJjfI0YVUBDzA7hl8oBqq79Z4qTHnLYc4SCyuLKR9Ff5gIeyh3CL/yDuXF3yXtn5WPVqkb2/v2NKtL7LSsTgp/AGdCdP2WFP0mO1BwSNOdQt7ktxREUdzSP0D0h611wbiN2O5VWWtJ8pV4q4yAwbLsNDH47bMLhtvJUbwz6nUqv1T7wjxQ3fCDNRU4NmcSxpGt74fWDyb4KTwG9C1JQz62bw9G0WTO/gf2W7tsvFav+H0Hh5XkfHdHPzWCj8/TnMB+vHlWW0opT8b+V31pVJWooG5c2RNZhvZInODli2cfwkmTg70x1FC4FNLVidTce4KdvpvkO0Rxow3R/z0j/YQlc1jzT97RyzAu9v+4qY2F3KoEtT+8uQFJtBiwhoUxk3PP9/eLSoxKEvJBxh7RkOuuAbatkmyXyzYwm8NbtdH+MXbdagF+SnEt3WuWMC9lv+jW5+k/iU5rbjbnUmZPHGzUjvLpYHDdo5o+nUKm/6BjkA9b6znTTQJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2653.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(9686003)(316002)(186003)(508600001)(8936002)(5660300002)(4326008)(110136005)(38070700005)(2906002)(26005)(71200400001)(53546011)(52536014)(8676002)(86362001)(83380400001)(6506007)(64756008)(66476007)(66556008)(66446008)(66946007)(7696005)(76116006)(122000001)(38100700002)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3zhpxqowLj7N5pkFjAh7uXI2dK56cVeOLu1TWNtbehuoNcYLtR1fklOVrku8?=
 =?us-ascii?Q?C4cdNeyn4HexA9RHs8TjNcVs9pMvKronUV7lmrMePas/l14qefNt6s6M8AQR?=
 =?us-ascii?Q?ySZMtU7e6D4REO7+1jEP/a0mNPCRtXjnHhwj0oBPxzw9F9dmJURZLw9/bRU6?=
 =?us-ascii?Q?gMc2XMkxmHYN3LPij177iwFFnWsBRvHjLeTn4pXdFPXQ5C0rVdln0pnkavS0?=
 =?us-ascii?Q?9Or+9V32AYA6BhS1Gq/GX+qYW//BjXvjOhE6o7Asf42mVefgRf842f1FRkdK?=
 =?us-ascii?Q?oN5p9NmMSs8vh6Gt1PQeSBJiQdy9Tgc/LUv87isE34RnHv84OheAAeHkGSPU?=
 =?us-ascii?Q?GNrEbUZ99Gic57l2D3TlR23mjasyKmQEi73M/5z/oOgIrhrTyHtANMC46KRV?=
 =?us-ascii?Q?4zhHeoY5UUPFCquXd6jfioxFQKvUiRweLrtXV8Ks91doVQB4u40Huqt7N9iM?=
 =?us-ascii?Q?gdMOiTTHXVL8GDIozPhIt6rj50FKxHxCUZ3CcZ1zOeAiXiYH3GgQT4z5kRni?=
 =?us-ascii?Q?8M7KbimTnt09bliyGwVReGVnwPflt8owZaWg/RgUogUgwcPCYfYZxPPFr/Ab?=
 =?us-ascii?Q?t1thU8Db4720bUi6dmB4GuLsNc+KmBNGRNtamGFZPAaRmlFVnHUATIuXXKdI?=
 =?us-ascii?Q?gP/Up2Sdwj594FwDqpASZZtmio2uQELGeeWrCi2VqF1bReY7RAnRUoIWIMng?=
 =?us-ascii?Q?UzyzlKzPyLECP3T27spVd9s1Qf9fAGwuWMsDcf0zkNCVYiyu1eAuQoiWVWSJ?=
 =?us-ascii?Q?Idssoag2aGT4rCYIEfQBLPEsmVrlzZGEsfgmu7ItMGQhBDNPG4bDNwFjb5Po?=
 =?us-ascii?Q?HgDvRkbIR2e+YMlkoNlcJxyBCfGiLTdNerJeXg/n0BPVCGnQQbZgvRP59aHu?=
 =?us-ascii?Q?U4QYbKugj6rURj4Bv5gBr3bRXvQwFhQCvHwavYQLFLRk0Al9L05lKaSWFrau?=
 =?us-ascii?Q?uy588fJr4F4yXwA3oD3fdPzPxGyyAoCG3lhjfpMTihNFj+i8qxa+akWMIdmO?=
 =?us-ascii?Q?hNWreDo96mFV4Pf8r2RneZBa3rCYn/vJN9oTQk9oUXWSQZi+EKi/HoXGZprz?=
 =?us-ascii?Q?q+8WYgGvyal9LveMQ6QBpMOMIKwijV1TVatJGvdlHRLTqxtXFmpsAvxm35Yn?=
 =?us-ascii?Q?91oTBTlqcL/iivUClTHJL8odvhBmK9ZDHAqiaGgb/QpLfZnJowElcifFWFEV?=
 =?us-ascii?Q?vxNbquu6jd84887n6lm4s8EQYvzGnlFJNAx112m5ltTiEsA4InCjCK+d++v8?=
 =?us-ascii?Q?xz828QvzjELs5qIbOJU5ithU7bCo5X2YDgrLFkySIKo9ddHB+ymLqmNI6+T6?=
 =?us-ascii?Q?OxVj/Cx3NZu7Kr0k+3k0Gv4V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2653.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5825b3de-58e1-4e24-3691-08d994158451
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 22:03:58.3915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsethi@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Alison,=20

> -----Original Message-----
> From: alison.schofield@intel.com <alison.schofield@intel.com>
> Sent: Tuesday, October 19, 2021 12:09 AM
> To: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> Vishal Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>;
> Ben Widawsky <ben.widawsky@intel.com>; Dan Williams
> <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>; linux-cxl@vger.kernel.=
org;
> linux-acpi@vger.kernel.org
> Subject: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS
> not in SRAT
>=20
> From: Alison Schofield <alison.schofield@intel.com>
>=20
> During NUMA init, CXL memory defined in the SRAT Memory Affinity
> subtable may be assigned to a NUMA node. Since there is no requirement
> that the SRAT be comprehensive for CXL memory another mechanism is
> needed to assign NUMA nodes to CXL memory not identified in the SRAT.
>=20
> Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL Early
> Discovery Table (CEDT) to find all CXL memory ranges.
> Create a NUMA node for each CFMWS that is not already assigned to a
> NUMA node. Add a memblk attaching its host physical address range to the
> node.
>=20
> Note that these ranges may not actually map any memory at boot time.
> They may describe persistent capacity or may be present to enable hot-plu=
g.
>=20
> Consumers can use phys_to_target_node() to discover the NUMA node.

Does this patch work for CXL type 2 memory which is not in SRAT? A type 2 d=
river=20
can find its HDM BASE physical address from its CXL registers and figure ou=
t=20
its NUMA node id by calling phys_to_target_node?
Or is type 2 HDM currently being skipped altogether?

Thanks
>=20
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Changes in v3:
> - Initial variable pxm (Ben)
>=20
> Changes in v2:
> - Use MAX_NUMNODES as max value when searching node_to_pxm_map()
> (0-day)
> - Add braces around single statement for loop (coding style)
> - Rename acpi_parse_cfmws() to acpi_cxl_cfmws_init to be more like other
>   functions in this file doing similar work.
> - Comments: remove superflous and state importance of the init order,
>   CFMWS after SRAT, (Ira, Dan)
> - Add prototype for numa_add_memblk() (0-day)
>=20
>  drivers/acpi/numa/srat.c | 70
> ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.c       |  8 +++--
>  include/linux/acpi.h     |  1 +
>  3 files changed, 76 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c index
> b8795fc49097..daaaef58f1e6 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,67 @@ acpi_numa_memory_affinity_init(struct
> acpi_srat_mem_affinity *ma)  }  #endif /* defined(CONFIG_X86) || defined
> (CONFIG_ARM64) */
>=20
> +static int __init acpi_cxl_cfmws_init(struct acpi_table_header
> +*acpi_cedt) {
> +       struct acpi_cedt_cfmws *cfmws;
> +       acpi_size len, cur =3D 0;
> +       int i, node, pxm =3D 0;
> +       void *cedt_subtable;
> +       u64 start, end;
> +
> +       /* Find the max PXM defined in the SRAT */
> +       for (i =3D 0; i < MAX_NUMNODES - 1; i++) {
> +               if (node_to_pxm_map[i] > pxm)
> +                       pxm =3D node_to_pxm_map[i];
> +       }
> +       /* Start assigning fake PXM values after the SRAT max PXM */
> +       pxm++;
> +
> +       len =3D acpi_cedt->length - sizeof(*acpi_cedt);
> +       cedt_subtable =3D acpi_cedt + 1;
> +
> +       while (cur < len) {
> +               struct acpi_cedt_header *c =3D cedt_subtable + cur;
> +
> +               if (c->type !=3D ACPI_CEDT_TYPE_CFMWS)
> +                       goto next;
> +
> +               cfmws =3D cedt_subtable + cur;
> +               if (cfmws->header.length < sizeof(*cfmws)) {
> +                       pr_warn_once("CFMWS entry skipped:invalid length:=
%u\n",
> +                                    cfmws->header.length);
> +                       goto next;
> +               }
> +
> +               start =3D cfmws->base_hpa;
> +               end =3D cfmws->base_hpa + cfmws->window_size;
> +
> +               /*
> +                * Skip if the SRAT already described
> +                * the NUMA details for this HPA.
> +                */
> +               node =3D phys_to_target_node(start);
> +               if (node !=3D NUMA_NO_NODE)
> +                       goto next;
> +
> +               node =3D acpi_map_pxm_to_node(pxm);
> +               if (node =3D=3D NUMA_NO_NODE) {
> +                       pr_err("ACPI NUMA: Too many proximity domains.\n"=
);
> +                       return -EINVAL;
> +               }
> +
> +               if (numa_add_memblk(node, start, end) < 0) {
> +                       /* CXL driver must handle the NUMA_NO_NODE case *=
/
> +                       pr_warn("ACPI NUMA: Failed to add memblk for CFMW=
S node
> %d [mem %#llx-%#llx]\n",
> +                               node, start, end);
> +               }
> +               pxm++;
> +next:
> +               cur +=3D c->length;
> +       }
> +       return 0;
> +}
> +
>  static int __init acpi_parse_slit(struct acpi_table_header *table)  {
>         struct acpi_table_slit *slit =3D (struct acpi_table_slit *)table;=
 @@ -478,6
> +539,15 @@ int __init acpi_numa_init(void)
>         /* SLIT: System Locality Information Table */
>         acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>=20
> +       /*
> +        * CEDT: CXL Fixed Memory Window Structures (CFMWS)
> +        * must be parsed after the SRAT. It creates NUMA
> +        * Nodes for CXL memory ranges not already defined
> +        * in the SRAT and it assigns PXMs after the max PXM
> +        * defined in the SRAT.
> +        */
> +       acpi_table_parse(ACPI_SIG_CEDT, acpi_cxl_cfmws_init);
> +
>         if (cnt < 0)
>                 return cnt;
>         else if (!parsed_numa_memblks)
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c index
> 10120e4e0b9f..ccf73f0a59a7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -122,9 +122,11 @@ static void cxl_add_cfmws_decoders(struct device
> *dev,
>                                 cfmws->base_hpa, cfmws->base_hpa +
>                                 cfmws->window_size - 1);
>                 } else {
> -                       dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> -                               dev_name(&cxld->dev), cfmws->base_hpa,
> -                                cfmws->base_hpa + cfmws->window_size - 1=
);
> +                       dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\=
n",
> +                               dev_name(&cxld->dev),
> +                               phys_to_target_node(cxld->range.start),
> +                               cfmws->base_hpa,
> +                               cfmws->base_hpa + cfmws->window_size -
> + 1);
>                 }
>                 cur +=3D c->length;
>         }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> 974d497a897d..f837fd715440 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -426,6 +426,7 @@ extern bool acpi_osi_is_win8(void);  #ifdef
> CONFIG_ACPI_NUMA  int acpi_map_pxm_to_node(int pxm);  int
> acpi_get_node(acpi_handle handle);
> +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
>=20
>  /**
>   * pxm_to_online_node - Map proximity ID to online node
>=20
> base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> prerequisite-patch-id: f09c67c6b3801f511521fd29c1cc01f5c5b1e9de
> --
> 2.31.1

