Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A0275E28
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIWRD5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 13:03:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:42107 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIWRD5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 13:03:57 -0400
IronPort-SDR: NNKp3D0K9TNyjuxXVLoRb/vcy+zzVRyy38RIzhEj8TwzmVS6f3iSqOz09vWuofHBMOxeeBwBuz
 ZgmYFPjYLQXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161887359"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="161887359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:03:52 -0700
IronPort-SDR: CHyRcEqN40rh4xUQ929mk0trxvmXZd2/HLLfWOnff4nhSgnZxtCDvhg04MzcBVF/33rCLsAfOh
 rJ7nm6JUdahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="454989069"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2020 10:03:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 10:03:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Sep 2020 10:03:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 23 Sep 2020 10:03:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6jsI12cWRd0HSPZOJ+H4nEunFGqyG9VZp+YhQVS3Arj6BDYOyQI2ld6KrpEWXiSsn5wHI7M0L5o4b58LwMn2g8VCYxCTsz27i7WMRiC5kL9MV+8afpxODxMRF5MSys0DalLURRrZq/m1XPExJtS1ZWm917kg9ZqnlCCIWC3+3yKk94DCcVdThjFlQAfHdolGFkej7Yooj88qYsiZHzn2UHa5L5NK+Zpe/+aS8B2CiQXnNUxWCPclRdpGfJhxXIOOeTNksRIq6mFczVrSK5BuSlQdcY1xUubTPtA5Lqp3rPeWzdzMkenr36qL/CrBTAoPQMhHGomYe3ugqCfahF1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy+U2Wjphltn3LI9M/4lfUPk7iAsYkN5XeyexXYkye0=;
 b=BwWBhAKjFkNc4QU4fQyQPrxkhU4Y4tse77ALVknt/lJC4/PzKxTfqPxhT0w79BJRQ1wAlFU6wVK4YdFOjtzDnPXFOr1u59c8ZlMQt7R9hJKRxsWb6Yx1jAxMAJg2rk1ZXr7g6P3U4QITx9bwbWeFvMoIcEzsOhHwPZhT3nn/EApVwgteRAEAZ2rovSpBvtFxmIPf9swc6z6umQKDRsafPOOxZpoax4Z/vltajvwS7Q8tRtpoE1DgQ4X/7453LYVZchU5E68/O7hzw5w30+TH+DGgwJJ53yuOzTXx0KKr7MEJabGsHPOkIiD3PqT1RKqQxt2pjvvou9Ri0KCD1YetqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy+U2Wjphltn3LI9M/4lfUPk7iAsYkN5XeyexXYkye0=;
 b=nKaz+TIQAWuLCTdJ9d3h4zyLqJEMpNBVFofNeqn4oovA7qOiEm/9yR2607Ml7PKfOij8sPCoZk4zgC051UcuBo5ytICtFxEuxTSbsLiRYJkN/rCRH+NWL066gRhZfrk5mWlR/IWPV0xik8UZrV3CxwEgwE4dGs61M1afkI/NS/Q=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 17:03:43 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::996f:395:61c4:2f93]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::996f:395:61c4:2f93%7]) with mapi id 15.20.3348.019; Wed, 23 Sep 2020
 17:03:42 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Zou Wei <zou_wei@huawei.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] ACPICA: Remove unneeded semicolon
Thread-Topic: [PATCH -next] ACPICA: Remove unneeded semicolon
Thread-Index: AQHWkLPWBi7SYd1tMU+/dwp0RI0iQql2dYWA
Date:   Wed, 23 Sep 2020 17:03:42 +0000
Message-ID: <BYAPR11MB325605CF9CC0C660510F0BE687380@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <1600760929-102547-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1600760929-102547-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ccd7dfa-f7d4-430b-73fc-08d85fe2a051
x-ms-traffictypediagnostic: BY5PR11MB3975:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39757899D42C26AA229A587487380@BY5PR11MB3975.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8f+NK7dqDb0tJecn15g7C7GF5CjkB3YH3VfyjqJgfDby9FZe/LY03cUxZ+9hzfypNQ3UjNOG8OUaU83EtmQBh4Fn8tZnNR4oIN1PowrzpRKgR0EIwRajmF+HULhg2aKc1Geqc4giSWbufYHVAoWgMiYkg7PJJkOSGCmdC6mSDBzLywWy4lNQrMWSGT6+L5YzLE5biALDNU2amGW9+eiDL0/o57rcAhjSxwGbTnIqxjr018gIfTfJwGPmR0X4076kbXs99xXxBUsiBxBMXLH6UQO4yTgoSubZGaiJv9lHeapbCJJ5I6f2I8ZyBirFEh2hFjrRBLRWBtEGNgETePXefPebCJBoQZVgxgK9JX/1wIvdlzOO6akiIs6vM6iVTfN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(54906003)(5660300002)(52536014)(71200400001)(2906002)(33656002)(86362001)(110136005)(55016002)(83380400001)(316002)(6506007)(64756008)(66556008)(66946007)(66476007)(66446008)(8936002)(76116006)(9686003)(478600001)(26005)(4326008)(186003)(8676002)(53546011)(4744005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K0KvpH+n60LpLDMvF3tu+O9L+sbm3opTcfvVGHtLKurKswDlXGT2DOld5HSHb9QaBQGngYfScAv8fjOVjdFLbEuSQ+Xj06OASxuRiPXV1nDcI4iOf/NQjvYP/kKhY3jNB3OxTYguVDQ1ulST6zwyYEaacDwosXaSAt7+ZVzjps5ggkbkJdBN5ALSgfjrZMQycpaFOeEEk9TZ0sTe5aeJNqEeRuDIe6cUKhh0Buz7GIbK3A5WW/fft/xaL/mvMwRqA9+vwEJrz4TvzUGi4oiIFvax1txi8fESkQW5BZQZpiMIeSBPSf+y1HgrxJ7V4bPGdJvQEMSsvmPoKzd4VUeN506aYdY6aAYd96zAaG4cuViOW9xJVpC9C82TXyvi7wildcEQ/4gzaH4cPCjoZed44HQELrpu+5G52VxHmRnm1j/He2Onip35kvbytULRxT65GWXIIsEg4s/6+YgDlApZq+/n6CfKs6bd2jjq74iV2qppZ0IruJw5sdrhYZXT7spZ8pZ4c5TT7umVw39Lp1LVYAcuL9fXKrNT9jgQvthcQ1f864SlDFDzqDVcwvR5evHMW2U4/UHi4uDE/pTNTrgsQTRRicitmUr43JVAolwHGz+M6GZKVtM5OoQ4AjYpq+lXHVJ7qit7EUIJCqmcDcMkVg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd7dfa-f7d4-430b-73fc-08d85fe2a051
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 17:03:42.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDeEwQKLY/d4xMhbMAyIVEuIb8S1EZafW4MJVX4Lqsd/wgLAcXg8VBr0jzkh/rKSaU/aswy58oqVSo8BKwLWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Got it, thanks.
Bob


-----Original Message-----
From: Zou Wei <zou_wei@huawei.com>=20
Sent: Tuesday, September 22, 2020 12:49 AM
To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.=
org; Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPICA: Remove unneeded semicolon

Fixes coccicheck warning:

./drivers/acpi/acpica/nsalloc.c:297:2-3: Unneeded semicolon

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/acpica/nsalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c =
index fe9b363..83d26ab 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -294,7 +294,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node=
 *parent_node)
 		node_to_delete =3D next_node;
 		next_node =3D next_node->peer;
 		acpi_ns_delete_node(node_to_delete);
-	};
+	}
=20
 	/* Clear the parent's child pointer */
=20
--
2.6.2

