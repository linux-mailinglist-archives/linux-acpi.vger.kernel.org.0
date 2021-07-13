Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA23C73DA
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jul 2021 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGMQLW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Jul 2021 12:11:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:38150 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhGMQLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Jul 2021 12:11:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197466116"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="197466116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 09:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="503199535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2021 09:05:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 09:05:19 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 09:05:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 13 Jul 2021 09:05:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 13 Jul 2021 09:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF1GEALtLMUcG8Z1H8rK/FKAv2ydu9mrmGoy1Gv2b1wTZJaKWa0bF0dA1Vs+KpdRejonXzBVJup1UEpffHXIm/ytxFNwG2d+fFkGM3qgX4zsAgNliLzgQyOyjHKh/aC4gYHRLDhgTnEPEh7tjImL74AgDsoWXIka4vzp9mq6FXt+IuuYkaXE+Xu2V1OX9KdtmUWGK7FAo5Yewuk26gimK9uPBP+D4wtXjVL3sq9FcoYHJEgUylaWjJ1Txqgwinxsl15GhZP7WwjBVBz0ydPbqeLF3FQzYaovLF4HafAcXZwgCHVXX+yzAT3m1bqEO2y+RK2OQlverd/uPJF9yRtriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SDFJc6V//gx04pQEpnGwksX6C6WyT2izhWtl7Bu3Yg=;
 b=bZFcr5JyDx+DbCdHQqCqhS6zVoTTj8uWY1LlCXR3hs7wNWLHE5I6HKhVE8KtRDjPGW3LsfZow2297g2QV9sPR52rnabrYxUQOfxkRpoPYIujQAClHmtJn0VA3B8PnNkpKnOKWZ0esv2MYmAGbpPb+yuViLuugSlsYB8Fn7fpseySARTi6jD7bOS8esHGT983anZhJ27r47CrkV4pB+plp5hMJmp4Qbv+4C6ssYj1mGzT5qJVHQPHFMLblDzvOk1zEYU/T4AcFjVOANfjUKUlSH5ywLgOL4teJzjw5TrlgO7qj09cfS+khoe62oaGS1j/1SFo0P575lRr+3wbGxPoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SDFJc6V//gx04pQEpnGwksX6C6WyT2izhWtl7Bu3Yg=;
 b=aJ7ZGVqVrtIgB1x3I5Yc+wH7A5Gz16cRetZwNYDtMlHfTul69OtcXrISn79A503JIPdPwlN4tK1ggBlRmkWsotHSORvSjapxBvonk4Dri31E6oHFZk6SDckrEqm2hHz2QGJoAhbfDG7AU55T9wJT8FkJYbzM3I1xGVgSnFenHwg=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 16:05:16 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:05:16 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Huilong Deng <denghuilong@cdjrlc.com>,
        "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: macros should not use a trailing semicolon
Thread-Topic: [PATCH] ACPICA: macros should not use a trailing semicolon
Thread-Index: AQHXdiCsOq9KNdYiyE+YI9k+Z5yl2qtBFWlg
Date:   Tue, 13 Jul 2021 16:05:16 +0000
Message-ID: <BYAPR11MB3256BFA3E0749F609239FF4587149@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210711064552.59735-1-denghuilong@cdjrlc.com>
In-Reply-To: <20210711064552.59735-1-denghuilong@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: cdjrlc.com; dkim=none (message not signed)
 header.d=none;cdjrlc.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cba8b6da-3acd-4cb7-fabe-08d946180145
x-ms-traffictypediagnostic: SJ0PR11MB5008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB50083C1773EC749BC15D62F287149@SJ0PR11MB5008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLAlUg01u9S1UPy7kie4EXSPTN8BFuzBW2M+I/TbWUfM6xFHNjpCdfx72If1RGKj1HRnlRwUQB4O4fwIyql9QR33hI7MuoebVKbafRHIsyyf5brHIkWc4ASGVkxtCDdatSL9b32aOEG91Oek/pJxVdL9uTTI8A6Ov+D0+SfgrVtJAVGjK48Df1va/ArIpP7Zi7qnhxY1SH84AsCZ6sk+skxqeW6nxM36ffrLzM43UlXyZLFsQeomGO7biAWzZEyyHlFn6nrkksRjS3RLsNh5RP9taScfFFcCrols+umDUNOC/BHXaa4EHTNtYR1HVRR/AE/4x2mLfnLCO7olKmLYQfIyvyYM+Q60kUqlGLqKLkqtvplSfEyGpmanXqBQeo3kskb22u0oYRwOil6GyvsytXgXv3FLJXeRnWTVPnpPkmcVwrPuSYdCtF0/bIhLjp0ZeqFemxCM+hwNpw+JZr1DUpKLVzwbMEtRu3Up32aYvpFJmI2deIGlyShH0dSw8KqXoZP+GbR9YiARv1oy9m2TQRCh3rx6yElsXSx9fscP9Tb8Md5u/zsVltBTnBN5ISEw6fa/p91thnINd1SruqhkSzylAERQpKaRWh35JWRL9vtRKp5gtY32jZtS2LOI1Nr8nhbjfXkdX9cCTc6cQf9F5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(38100700002)(186003)(83380400001)(8676002)(110136005)(26005)(5660300002)(122000001)(71200400001)(66556008)(478600001)(76116006)(53546011)(64756008)(4744005)(66446008)(52536014)(4326008)(86362001)(6506007)(66476007)(66946007)(55016002)(8936002)(316002)(7696005)(9686003)(54906003)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TLskdew53JlKXYKbqJGyJY0YXGKT3kHCiBLtbUtxd4R4aIG2AJ6jHzVo9Bn2?=
 =?us-ascii?Q?RR8griBfjQrMKa9RogF34i4t14qTkcFQopiWmew3pb9CLtXVe1W49JJZeYgk?=
 =?us-ascii?Q?aFYWLkbIaPn4T5try83VlIJPAIWQUT+XzqrUlpsrmOFT6vpz9gGc7v2UzSqb?=
 =?us-ascii?Q?LwYYmXmiR5/l6MZPfycF6s92WTLTR3dVy9bW9Jy+CnKb7OAht6WSwxfMDCjD?=
 =?us-ascii?Q?elcWBv4+swB2XV6A2Rq9ckEs4mhhKcVvFAx0LVMqKuZLNQCFzxNoR95sCOkO?=
 =?us-ascii?Q?Aj5pM40DFUqffmMifj2ziRk7I+TBvBH0qZQ7fWfJJ2KbDVSZ+cL4S+XSSsy8?=
 =?us-ascii?Q?WhUzUI4Kf1eBcgJDFggX2jpQyq4RPxDNlNXm+F2Uidnd/b9Wi+Ax1/34fa9x?=
 =?us-ascii?Q?T6zkNHqirxF4hyLr5GEtxk7VV4/Ged+l5T6aswdAOqd4/HPz1ZHZORGOmNK8?=
 =?us-ascii?Q?senUMnykcNXVOfbXd/Nuk612dT6sCwq3BT9hAUqNb3uEXEb5K0k1pPF9/SeR?=
 =?us-ascii?Q?hp16y500C+4ODFihuxHKsY0w0bT83phiwGfCEPMMS0vsiFAOIRnsw2shu6OS?=
 =?us-ascii?Q?8n9JuqySQ3Q8YQ3Wm6ZtC85vGMtuhkJLACM8b55UpfGB9eljnak3H/qH9XT6?=
 =?us-ascii?Q?Pbu/RKeDccEZSfu1Nl6iNiQjpnqyNJwQiXQS1r6XwQ10WG9p7aiYgD/ZNtev?=
 =?us-ascii?Q?IuDexKMBOYsKyePoCxh4UwvG34Fi0jeuGpNyKZj8hNwNpkv01878Rs5rRuYV?=
 =?us-ascii?Q?li1210+c1IFPcUKCuA49cPKn0ZuXYv6DiiAuEb6X2QvNp1d8dbFhIW1b6hrC?=
 =?us-ascii?Q?EM7GuJBRT2KpsvShP7MLnQPjmv3unGakVlPT2meCzlp4PQb+HyFT/fq2NeMN?=
 =?us-ascii?Q?yYotxzF+e+PJqqyklcXJFArBJVDKE683zcy1yD8llZLdQgNKRIkQq1c7vUYX?=
 =?us-ascii?Q?ja3Y36UqDZ8YfTASGzyjXzZUTq2QEJfy0jPIDyPWmtBz5PaHeNAt+TfVvi9i?=
 =?us-ascii?Q?2iqEo8f91zw4GHEjj1xD1rek9wxUzX/zP9Jp4SB56iWycgW9mR0x6joVlhHu?=
 =?us-ascii?Q?/g7whxa7fdHBnaGONBVvfZMEJqsPCrpNJOf/4bELrJ9JygnPsul6HLyS9H94?=
 =?us-ascii?Q?frGPJvusH/K+D+gvn3LLFsrQQdwsJM88+UwrEbbAWiwnGu7U8iFgL5mw00Ej?=
 =?us-ascii?Q?JfHZ5dYf5ccsMYZRisX2HipdnfER/rVnHpLypshTtKqpRJKpgQTybn2olJzs?=
 =?us-ascii?Q?UH3kbHNiV2vtSQjzA5ALsBZU7Q0MaNeCqdp6jml1320z7iOKwmvtOKrj3V7E?=
 =?us-ascii?Q?ziRdDg0jX9iCwKc95RXBXnsO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba8b6da-3acd-4cb7-fabe-08d946180145
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 16:05:16.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6WgmjlBT+lhpNNK/N2HGYH14uT5yHeo0TesMqBR1buXON03waqWArYTqTZeWZyoFHW9VE+zNx05b2D5TuHKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Got it, thanks.
Bob


-----Original Message-----
From: Huilong Deng <denghuilong@cdjrlc.com>=20
Sent: Saturday, July 10, 2021 11:46 PM
To: Moore, Robert <robert.moore@intel.com>; erik.kaneda@intel.com; Wysocki,=
 Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.=
org; Huilong Deng <denghuilong@cdjrlc.com>
Subject: [PATCH] ACPICA: macros should not use a trailing semicolon

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index 1b4c45=
815695..5a3875744678 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -415,7 +415,7 @@
 /* Conditional execution */
=20
 #define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
+#define ACPI_DEBUG_ONLY_MEMBERS(a)      a
 #define _VERBOSE_STRUCTURES
=20
 /* Various object display routines for debug */
--
2.32.0



