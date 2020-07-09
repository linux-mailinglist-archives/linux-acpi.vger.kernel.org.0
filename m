Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DB21A270
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGIOtZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 10:49:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:8705 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgGIOtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 10:49:25 -0400
IronPort-SDR: hj+yBzppA/STumwnkDCJMcKInNzVkrKiHey0mn7nj6YXnc0CXCKrC/gqttuzNg7ZNFPfHMfjzT
 2I99T9/fbOoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146092301"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="146092301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 07:49:22 -0700
IronPort-SDR: lxdIzXj9YnhWi3X5lr9/yNT/LdwZHedoQWVxV5oF67eZ6OIUwOXCQaYZFDYwcPvtFpcFhRkYTV
 bJveNgpJdykQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="324243209"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 07:49:21 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 07:49:21 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 07:49:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 07:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHWqk1CWflXmbM3XkubB1C5cRopgJEdGNu8O+s/V1KTOvA5S8ayH5NUpnIkhUUd9FKL9YhppIKm9E6GtSkuK9qahPX+cUljSciOVSeVYv0p+TnGYXFD4ET904mnwbLWwEO7ABc1NGyAzbbP8XM3anOWqks2QFEHw1k18RGBBc/PVCAfSF+Fs1LDDJAcqqh36d+EKHQWMBHOTRQ7yafgSlidU7+FWPKxBw45/5ccDlj5n1fn3mEnOG4y3tXDZSU7kJ/jxUSmcfYsPtR7Z7N2y1LG5LickBmRsMY8Zu2vbalMVKoiUOb0mpaUy0GpIRDDCMLCNw1kmN8ngZ+7b9juHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3olccjvRSAKD60SinJG/NJIaLCxpIzptIzOcaRIBwL4=;
 b=dRZyNiXVr1160QDkQZXvr0KMh7XF64XZVF8yHbBsfaiftdLRjQSiWFn+juASqaBCmeKVwJlPEszKoSDDllgZKEarSjGRTlM7jaG+eClHuFqoC6FVgwbsW3+IfzleqDf8MLr7J1PviwrxMUxQ1omP4p9WTnD5/qEjfeyWr4oJFe8r70CtYzLeSEGBgfyWooKk7zqOBtuYbSBZjydvt0nIvuvTP+JGsQUgl7lDP0I3toZ5KlVTdblSTosJYaZ6zlJbESUXC0CMIdJHUiULowTbVhQDkmHEOTt/NN54rMhh2LhcVMmY9OJqLZH0Qdk0h8Vc0grofC/SP8O8WjAMkXJMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3olccjvRSAKD60SinJG/NJIaLCxpIzptIzOcaRIBwL4=;
 b=zx/RNYiRqTzICUJ9yiDz22/mEuVxL2txZZAkfeZuP9IVw9dgg6UbjvFOVL5Zz2GPa1A/DjHwKqdLNr8qFe67rWUnlWxSRaLsGvmo9XKoHugf/p31BAqLDKMsYPHEEHTGQ0OoTytVBovNmMpSw734bx1wjqf1xW+rmjbtVcC5Ip8=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 14:49:18 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c%4]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 14:49:18 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Xu Wang <vulab@iscas.ac.cn>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] service_layers: osunixmap: Remove unnecessary brackets in
 acpi_os_map_memory()
Thread-Topic: [PATCH] service_layers: osunixmap: Remove unnecessary brackets
 in acpi_os_map_memory()
Thread-Index: AQHWVcgik7eppFgSsk2P33P93bkikKj/VH9g
Date:   Thu, 9 Jul 2020 14:49:17 +0000
Message-ID: <BYAPR11MB3256999B714C7F5598E3213687640@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20200709080806.14328-1-vulab@iscas.ac.cn>
In-Reply-To: <20200709080806.14328-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a90b89b-2804-463a-e887-08d8241741e0
x-ms-traffictypediagnostic: BY5PR11MB4226:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB422603A578C748BE8A494FE887640@BY5PR11MB4226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:226;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnkkquuKdL2DidiZNAKx6SfiVtolNIYTO+nBjWHS65tfL0PzCJQGC8lffz6mZdp/0L6+3KbjnmmXoqnDzpR62z0D6r2weHXeuYzFO2C6i+tbWcA8w/+pA4wdmjdvpSs2xu/GM4VtX7SgMXaCOmdLQ9hJxe8m7+P3aHUiXaWROuR4GeRHu8RetW59bVw2g+yzIFQz9MGpm4WnD4a4t6N4APkLLI5BLRt/V9hcNq0HbWNNc1qtLuBTTR5X6gz1sSGSkbEVpv+gwLl0DlPLwiSfa/V0zy0y0wU1w0QbRXytPXt6/TpH9TDwpjpMWP0lEuK7FgkfWF/ciUQbYww1eRQPVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(66556008)(7696005)(55016002)(53546011)(6506007)(83380400001)(71200400001)(76116006)(66946007)(8936002)(66476007)(66446008)(64756008)(52536014)(186003)(9686003)(26005)(86362001)(316002)(8676002)(110136005)(5660300002)(4326008)(33656002)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pEFN4lx0BHc6r8UnsXZCn7BC03Wo4LIM3cd5q/JE9J3fL6TAVJytHX+yhKJJPgaDSewbfxOKaMfhWhMm9CplXSALeCMtwzfTXwSrLNBZHvATC8z9T9inNQ8W2fbSteU5KZMqHG0G+BQnk4PeKLjY1Oui4D6Ne7ODRM0shDGN6ngy2t0Fs/NV6MTlMDLG5Unb/z9jqVtcAACAxNdDeA94kqpZuU/buu6rRuu0VLcrplQ6lfRdBLMSKCQU2SHGFgSCxxBs4obPIkINnBjPH2AhOf1aUA+DFPs5RoyD0cJTszB6MUdZ0mS0awBr2t5Dt4aNGVdQ0Xcwq0Vp4LaqhFvkKSK9uHA0Neibz2Q6zmvDrkLj8x9rY2iqjRo0eSnywXgD23N4hgfKZVvHxyEq8hSWdOUJFHj9TKewTpmg2ma24m6vqhugng42neTC62WXw1SZUUOlsFN1RXhLBAtpVmXJoAbQuLSruGBI5rTP09jDC9qbyLV0P4LnYXNYJhppbDBZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90b89b-2804-463a-e887-08d8241741e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 14:49:17.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /P2XI8ZSd8eJwQ6jOikF1ACRzSEjy9ceIh/scGWvJ8yIy6CZGaFUWpOvIgsZLa9ljjIl9WuVqA7i5e6E6xTaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-		return (NULL);
+		return NULL;

This is the ACPICA coding standard, and it does not affect anything.
Bob

-----Original Message-----
From: Xu Wang <vulab@iscas.ac.cn>=20
Sent: Thursday, July 09, 2020 1:08 AM
To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; vul=
ab@iscas.ac.cn; linux-acpi@vger.kernel.org; devel@acpica.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] service_layers: osunixmap: Remove unnecessary brackets in =
acpi_os_map_memory()

Remove extra brackets.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 tools/power/acpi/os_specific/service_layers/osunixmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tool=
s/power/acpi/os_specific/service_layers/osunixmap.c
index c565546e85bc..52f3e70b5c81 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -70,7 +70,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acp=
i_size length)
 	fd =3D open(SYSTEM_MEMORY, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open %s\n", SYSTEM_MEMORY);
-		return (NULL);
+		return NULL;
 	}
=20
 	/* Align the offset to use mmap */
@@ -85,7 +85,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acp=
i_size length)
 	if (mapped_memory =3D=3D MAP_FAILED) {
 		fprintf(stderr, "Cannot map %s\n", SYSTEM_MEMORY);
 		close(fd);
-		return (NULL);
+		return NULL;
 	}
=20
 	close(fd);
--=20
2.17.1

