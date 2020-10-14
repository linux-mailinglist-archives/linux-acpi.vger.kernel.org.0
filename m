Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5EC28E7ED
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgJNUhE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 16:37:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:42907 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgJNUhE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 16:37:04 -0400
IronPort-SDR: yOHbpP9DPa8yA0zzIihnao9mJMiZbKn2nGsyx6DXG1ixZZNrEsRkQN6IIJiaUkHVIDT1gJ9lnK
 RwUrAbXCLgyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="146056811"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="146056811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 13:36:58 -0700
IronPort-SDR: NAFNcg/yfFfzJNaL7TNwsZapD4BgwSZdqZS6pRVs2G1yj6GWvAPNzdV50kFFYm2LB3G83v6rzM
 36UmepYX1HXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="346634633"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2020 13:36:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 13:36:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 13:36:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 13:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLTX11NHEcz/OP2gMdeXDzTHfqMZLTEfZpOUByf27QSCo4JKnrp5xDA4kufnv64ZiScPagAib8ciQHTZpAhgzdXqRPn8eUSxH97QiPm32ajfX/57D9eFJxYqPkctkDLcWfEOebOhhm2DJsI/e4jIYXb9jGXO8mykr3eB7QMg+JN/jdUnR2spVm7rCc25elPCyzY5u8UaXUT8Ttr9YaTvO9fANzuUKdSGn0wRyY1JhkNErtnaiNk4O/upU95yHdGHy1F21Y3ydJzSgoXjJLU566LVjs4phEb58G7fpgAU2W5zWWjYkhBFNeHFG/IPFhmzVdYDCJ+fx1kEp6/2TZEFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Exd4uxfhjc/ygOpy1wQHwk+HyO/XPfEu8qUAjrn0Ds=;
 b=ggSvwOTxtIy5qgFqvTSG4omeh3ZDsihtS6JcpFQqDjze3lfu/yg/BNUGKkQL1Tl9Q4m5M58AOkK6LqHr8YflWMvKtL5m24EzYvgKU4qLDM3E1nWGnPZ4NDS6uEV5QKFf8RSLDgbqtTsspaeCPp5HOiXZ22BNRv6ils3VqeewVoebdpuEfuKY3gvxSsUiofnbhd70EwAUf5OezDmUN7nLc3tFlcEN92FlD7W89tnBym/6bZ/XuRCUhFVNbVIsOeqDNzB/Z4afRn5eUQke03buSoL7lbQ8VhkU7AzDRxuS2b3pZhZx/ABvDF5IIbLIN0mP8lcQZgHmPn4rgvZLc66hMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Exd4uxfhjc/ygOpy1wQHwk+HyO/XPfEu8qUAjrn0Ds=;
 b=ydHR1MVuMyYrWsFklG1kpu+omt+qX3l1qirVKSBWgGO4t7d1x60V9sdUhgvt8vjEeqBDOq56CA2GzLR3p4GM2U2yLmtF9/PkLWBIGxDPp9RDQgNf5GgIA656+dp/ziulBcK4+AT+Dj+DX4uPTcKb6c9OyQD1SengYlZ15BEMrqY=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 14 Oct
 2020 20:36:54 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::bce9:aefc:561a:ee66]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::bce9:aefc:561a:ee66%7]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 20:36:54 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     lkp <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse:
 sparse: incorrect type in assignment (different address spaces)
Thread-Topic: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse:
 sparse: incorrect type in assignment (different address spaces)
Thread-Index: AQHWg7M7Htf0fwhMkkW1M1o4+dHJEKmXy66A
Date:   Wed, 14 Oct 2020 20:36:54 +0000
Message-ID: <BYAPR11MB3256FDBA54924A32BE878CF787050@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <202009060245.jmydrp7B%lkp@intel.com>
In-Reply-To: <202009060245.jmydrp7B%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2426d391-cc22-4a2e-3696-08d87080e338
x-ms-traffictypediagnostic: SJ0PR11MB4784:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB478459FA509C77354DE7980387050@SJ0PR11MB4784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:30;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHjOXLfn3rA8trPVM+6KQUFogE7zKHx/k9Jm4x6C3xYlTU7ioOXt6aBnfuC9VHlL42JwPtvFJ9SvFPPR+NA6/s0gcITJmgq7QmUHg7DywijzmoDyd/v66LPl1MTnuyXKXCgLxfkVgAr/PjegzQb/ph4jQDdCl4Vzlw47lFWHFSpI+5NcfIgD1y9HGt3F5bktDt0ktvEDAfHHFojmldeVK0AFQ/0uAyEmjhEHMPFMgj8T9qon2QOVQ9CXNRDH6QzHIfeHNk/PT4Y/7Or5VQrMlr8rghIFuCu5AmHYkPr9mWpm3J8clLvZrrAJ9QLwAzSidpXXU8mu4zUbYCbBkLmm8/PLYJa0+KXlfrrnG476zY+/qCE3GLT4fSMYOgX2V393FQ7qBEpPIexRuxGveE+dlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(76116006)(110136005)(316002)(66476007)(52536014)(6506007)(26005)(53546011)(66556008)(66446008)(5660300002)(186003)(33656002)(6636002)(83380400001)(66946007)(64756008)(7696005)(2906002)(71200400001)(9686003)(478600001)(54906003)(4326008)(966005)(8676002)(86362001)(8936002)(83080400001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9VquDO4mx7P90FJMxrqOMAbYtyqHs3g8giASxdoitUGsBE8meuHLyVKbqbxr3VU6a0kZ1+De0ecseccqM5c08KAC+8K3dmJwcpCaxVa9QTSsWs6GWjoi/P8c+oTM7yFX9w9JBA2NXv/aVce4UTgMPK8IV8prxeX16DT9hlFEkdOjnOjQbx4/hMyszjt9zF9zUJI8tpOpQTME4Wl/URAhAJ7wx8nZv+uOq8DW2Z466tbU6mxYLhqXOSApBwnR0Fse66yXEoZ/KBNmKvl9FrW5ZQlOpPuzSEnM/NKgmdTANPVqmJZQWHJE2+k4xLDO9fT6lGO3Eob5SVS6uCr8cYo6mkSoJZrx5Ai5jYUB2d55grtjZg0AjQ6s3OJ629rxDrWa7ss58hFPrG2e+xhT4eG38FbEJlFZv6Bs/3MKGABADdeknUcNySvagnLtQsXfSqaOTAlxyMVK5ozuSAPQhzTq07YrGBmeWwrXBjnqGaYJm7K1YnR1scSLaxNFkMkXkR6yXA+BiQggNvsFFOg/jLNGPxYCTuqRo/LFwkiGbeHWHJ9lq4tQGZPS8RgEqxacRRj4TdkQSI1UZUArtwGR/19pvLbQhDCsABN0GTETt5W4JQfyv6geeTeGVDVXsgu3w29t0tP/KCkdiI3qJ/1MucJ9CQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2426d391-cc22-4a2e-3696-08d87080e338
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 20:36:54.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2r2ku6GAIAURiclQXCZltorWnEDFV676zkEw8iJrIUXGw3wfrikOtA2CMtPviUf6zoaR5y/cmcptTMM278meCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I believe the file " drivers/acpi/osl.c " is part of the core linux, not AC=
PICA.

-----Original Message-----
From: kernel test robot <lkp@intel.com>=20
Sent: Saturday, September 05, 2020 11:34 AM
To: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: kbuild-all@lists.01.org; linux-acpi@vger.kernel.org; devel@acpica.org; =
linux-pm@vger.kernel.org
Subject: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse: sp=
arse: incorrect type in assignment (different address spaces)

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 acpica-osl
head:   c32c3c4079f8a62616413abbead45b6622fb7602
commit: c32c3c4079f8a62616413abbead45b6622fb7602 [6/6] ACPI: OSL: Make ACPI=
CA use logical addresses of GPE blocks
config: x86_64-randconfig-s022-20200904 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout c32c3c4079f8a62616413abbead45b6622fb7602
        # save the attached .config to linux build tree
        make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=
=3Dx86_64=20

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/acpi/osl.c:376:17: sparse: sparse: cast removes address space '_=
_iomem' of expression
>> drivers/acpi/osl.c:1748:46: sparse: sparse: incorrect type in assignment=
 (different address spaces) @@     expected void *extern [addressable] [top=
level] acpi_gbl_xgpe0_block_logical_address @@     got void [noderef] __iom=
em * @@
>> drivers/acpi/osl.c:1748:46: sparse:     expected void *extern [addressab=
le] [toplevel] acpi_gbl_xgpe0_block_logical_address
   drivers/acpi/osl.c:1748:46: sparse:     got void [noderef] __iomem *
>> drivers/acpi/osl.c:1750:46: sparse: sparse: incorrect type in assignment=
 (different address spaces) @@     expected void *extern [addressable] [top=
level] acpi_gbl_xgpe1_block_logical_address @@     got void [noderef] __iom=
em * @@
>> drivers/acpi/osl.c:1750:46: sparse:     expected void *extern [addressab=
le] [toplevel] acpi_gbl_xgpe1_block_logical_address
   drivers/acpi/osl.c:1750:46: sparse:     got void [noderef] __iomem *
   drivers/acpi/osl.c:1760:20: sparse: sparse: incorrect type in assignment=
 (different address spaces) @@     expected void *rv @@     got void [noder=
ef] __iomem * @@
   drivers/acpi/osl.c:1760:20: sparse:     expected void *rv
   drivers/acpi/osl.c:1760:20: sparse:     got void [noderef] __iomem *
   drivers/acpi/osl.c:708:1: sparse: sparse: context imbalance in 'acpi_os_=
read_memory' - wrong count at exit
   drivers/acpi/osl.c:741:1: sparse: sparse: context imbalance in 'acpi_os_=
write_memory' - wrong count at exit

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?id=3Dc32c3c4079f8a62616413abbead45b6622fb7602
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/li=
nux-pm.git
git fetch --no-tags pm acpica-osl
git checkout c32c3c4079f8a62616413abbead45b6622fb7602
vim +1748 drivers/acpi/osl.c

  1742=09
  1743	acpi_status __init acpi_os_initialize(void)
  1744	{
  1745		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
  1746		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
  1747=09
> 1748		acpi_gbl_xgpe0_block_logical_address =3D
  1749			acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> 1750		acpi_gbl_xgpe1_block_logical_address =3D
  1751			acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
  1752=09
  1753		if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) {
  1754			/*
  1755			 * Use acpi_os_map_generic_address to pre-map the reset
  1756			 * register if it's in system memory.
  1757			 */
  1758			void *rv;
  1759=09
  1760			rv =3D acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
  1761			pr_debug(PREFIX "%s: map reset_reg %s\n", __func__,
  1762				 rv ? "successful" : "failed");
  1763		}
  1764		acpi_os_initialized =3D true;
  1765=09
  1766		return AE_OK;
  1767	}
  1768=09

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org
