Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF864C33
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfGJShV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:21 -0400
Received: from mail-eopbgr740045.outbound.protection.outlook.com ([40.107.74.45]:40544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728162AbfGJShS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EuYjhv0K981eq+CHQGYecMhyIdmi6r6HsOp6EUH6sg=;
 b=rU0PuqznwLpfkwvTBg8Fy9PfPIWcRJBbcNBLOXqQbIwCTH9NM6bf2tm9Q/UjVq9sANT0AfykQ11FkXr4YuFCLCfxuZnyyQCBWSKCeG5z5+rHyMiBYZWLO7TYZZCg67J+dD0Q/aemByYf3OIP549nXME4NRyzhGKMpaJR/bOL3So=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2846.namprd12.prod.outlook.com (52.135.103.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 18:37:14 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:14 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCHv3 1/6] acpi/cppc: Add macros for CPPC register checks
Thread-Topic: [PATCHv3 1/6] acpi/cppc: Add macros for CPPC register checks
Thread-Index: AQHVN059RHJ8UgAi2UmQapw4p1j2fg==
Date:   Wed, 10 Jul 2019 18:37:12 +0000
Message-ID: <668aa711c3c455e926c066a27cb62720399fb2df.1562781484.git.Janakarajan.Natarajan@amd.com>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0064.namprd02.prod.outlook.com
 (2603:10b6:803:20::26) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 519148af-081f-4840-79ed-08d705659fca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2846;
x-ms-traffictypediagnostic: SN6PR12MB2846:
x-microsoft-antispam-prvs: <SN6PR12MB28465D2EF744D91BA917A44CE7F00@SN6PR12MB2846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(6512007)(14454004)(71190400001)(71200400001)(7736002)(25786009)(26005)(186003)(102836004)(76176011)(52116002)(486006)(50226002)(6436002)(64756008)(66446008)(53936002)(386003)(99286004)(6506007)(2201001)(66946007)(66476007)(8676002)(305945005)(81166006)(68736007)(6116002)(8936002)(81156014)(86362001)(3846002)(66556008)(6486002)(110136005)(316002)(2501003)(11346002)(446003)(2616005)(5660300002)(256004)(4326008)(36756003)(476003)(118296001)(478600001)(2906002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +RaGSnKTBl89QJVfOEsOCET37Yq9J8a3Bh0ECgh3YcbWl+8Lg+iNIqCIVKLxaN5bbnnq8/dgVQGhFADfysO+nN8ZnLX301bbYe9iBBApJc0NvjTiK1LVLiXpfsA+GxVq1K7lCfLfqT2vt5buBqNCfoejsSZIGAfDoJntMYebnJ/AxxBMlNuuoXGPZCH2xewhewA6k6TxEs6H4uT7lNOyP7F6jj5Io634nV6rpkJ0CkX/4C5lbJd/CBen+Pr/TgCUIfdBD02+vkDkuBHJb713/9NjKFcczy2plLNRGmXIfMce7RgOMc+hHdjyY698CvLKNeXbfs78F9K37xNw9wCPkt/+6eQf5u44DQoPrmPwqidf42uPYlYDBpEbvUNSQvWuzrGehqwu4EYoTT6AK/V1kmwnIi/PADImgKhJrk8wNY4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519148af-081f-4840-79ed-08d705659fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:13.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce two macros to help with checking the support for optional CPPC
registers.

CPC_SUP_BUFFER_ONLY ensures that an expected BUFFER only register has a
register type of ACPI_TYPE_BUFFER and is not NULL.

REG_SUPPORTED decides which check to perform based the expected type of
the CPPC register.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 15f103d7532b..c43de65531ae 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -111,6 +111,14 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr)=
;
 #define CPC_SUPPORTED(cpc) ((cpc)->type =3D=3D ACPI_TYPE_INTEGER ?		\
 				!!(cpc)->cpc_entry.int_value :		\
 				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
+
+/*
+ * Evaluates to True if an optional cpc field is supported and is
+ * BUFFER only
+ */
+#define CPC_SUP_BUFFER_ONLY(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&	\
+				  !IS_NULL_REG(&(cpc)->cpc_entry.reg))
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
@@ -705,6 +713,26 @@ static bool is_cppc_supported(int revision, int num_en=
t)
  *	}
  */
=20
+static bool is_buf_only(int reg_idx)
+{
+	switch (reg_idx) {
+	case HIGHEST_PERF:
+	case NOMINAL_PERF:
+	case LOW_NON_LINEAR_PERF:
+	case LOWEST_PERF:
+	case CTR_WRAP_TIME:
+	case AUTO_SEL_ENABLE:
+	case REFERENCE_PERF:
+		return false;
+	default:
+		return true;
+	}
+}
+
+#define REG_SUPPORTED(cpc, idx) (is_buf_only(idx) ?			    \
+				 CPC_SUP_BUFFER_ONLY(&cpc->cpc_regs[idx]) : \
+				 CPC_SUPPORTED(&cpc->cpc_regs[idx]))
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
--=20
2.17.1

