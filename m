Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2164C41
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGJShl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:41 -0400
Received: from mail-eopbgr740045.outbound.protection.outlook.com ([40.107.74.45]:40544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728168AbfGJShW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G1+O/qT6Yvto1oKEvQiiFZ3riOC1p6vsSY6aymBSmI=;
 b=YBVg0daAD/JJTDOkkH2XCeBIC/xODiC+ToZfwLRGL6mDplwCZETIJi7KOWts+at4/KiVqaQmAwAeTtqfc6Imh3CJUsYWDHzoiF8rfC+iiGjfa5M0pAssoQQE+I+LapNoh8+4zebK3DOR1XMx+XUg5RWo8iB83tO7ZBxMOMEGnOw=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2846.namprd12.prod.outlook.com (52.135.103.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 18:37:15 +0000
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
Subject: [PATCHv3 2/6] acpi/cppc: Ensure only supported CPPC sysfs entries are
 created
Thread-Topic: [PATCHv3 2/6] acpi/cppc: Ensure only supported CPPC sysfs
 entries are created
Thread-Index: AQHVN05+WQrgmSia/kKIgKq6JMN9/g==
Date:   Wed, 10 Jul 2019 18:37:13 +0000
Message-ID: <10d1f1e3ad8d6faeaa7ca70ac800ffea371f8707.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 39218fcf-a9c2-46b6-0877-08d70565a054
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2846;
x-ms-traffictypediagnostic: SN6PR12MB2846:
x-microsoft-antispam-prvs: <SN6PR12MB284644BFF9B5B25168332C9BE7F00@SN6PR12MB2846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(6512007)(14454004)(71190400001)(71200400001)(7736002)(25786009)(26005)(186003)(102836004)(76176011)(52116002)(486006)(50226002)(6436002)(64756008)(66446008)(53936002)(386003)(99286004)(6506007)(2201001)(66946007)(66476007)(8676002)(305945005)(81166006)(68736007)(6116002)(8936002)(81156014)(86362001)(3846002)(66556008)(6486002)(110136005)(316002)(2501003)(11346002)(446003)(2616005)(5660300002)(256004)(4326008)(36756003)(476003)(118296001)(478600001)(2906002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ouLVYekNv7eZc3awB7XnDkToPy6uaXsmrUkpNxu9Jxipmxzg2Sq0iXTnSnFg0+prnRdgDlJh5dUgcQ9j8wEMQluQsEp/8q3WMOvc7hXZdnnRRwnzTduudfvUCD1CAPDtBFZPXqtoqkU1eCysOglE5HOrH/PPkdnYoKJRhsFEmzZAYffReQTgcZaWz7C1SJ57SCekZOMCQXpB8bFXa2c5mjQ3EXpaO+jf2Mf15eCs6ucpkjFFlycLT4RjY6IzQ9jomBOrTqEbWOuxLVZVWnp2uxOUxVLiLxSKrMwkMV1lSSInEsuxUg4mSBwBJk5rWwZh9LzLtwrb81VvZsB6J9P75IkFJ6B78OwXk3Wv0VhoTbPXvpCr4QtkUtHpan9jUzc7DhLl+L5ikkyZzATnIMblix1VfDDzyFywSSEYsYy94NA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39218fcf-a9c2-46b6-0877-08d70565a054
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:13.8980
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

Add attributes only for registers that are supported by the platform.
This prevents unsupported, optional registers from having sysfs entries
created.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 82 +++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c43de65531ae..53a9dc9960b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -183,22 +183,8 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj=
,
 }
 define_one_cppc_ro(feedback_ctrs);
=20
-static struct attribute *cppc_attrs[] =3D {
-	&feedback_ctrs.attr,
-	&reference_perf.attr,
-	&wraparound_time.attr,
-	&highest_perf.attr,
-	&lowest_perf.attr,
-	&lowest_nonlinear_perf.attr,
-	&nominal_perf.attr,
-	&nominal_freq.attr,
-	&lowest_freq.attr,
-	NULL
-};
-
 static struct kobj_type cppc_ktype =3D {
 	.sysfs_ops =3D &kobj_sysfs_ops,
-	.default_attrs =3D cppc_attrs,
 };
=20
 static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
@@ -733,6 +719,69 @@ static bool is_buf_only(int reg_idx)
 				 CPC_SUP_BUFFER_ONLY(&cpc->cpc_regs[idx]) : \
 				 CPC_SUPPORTED(&cpc->cpc_regs[idx]))
=20
+static int is_mandatory_reg(int reg_idx)
+{
+	switch (reg_idx) {
+	case HIGHEST_PERF:
+	case NOMINAL_PERF:
+	case LOW_NON_LINEAR_PERF:
+	case LOWEST_PERF:
+	case REFERENCE_CTR:
+	case DELIVERED_CTR:
+		return 1;
+	}
+
+	return 0;
+}
+
+#define MANDATORY_REG_CNT	6
+
+static int set_cppc_attrs(struct cpc_desc *cpc, int entries)
+{
+	int i, attr_i =3D 0, opt_reg_cnt;
+	static struct attribute **cppc_attrs;
+
+	cppc_attrs =3D kcalloc(entries, sizeof(*cppc_attrs), GFP_KERNEL);
+	if (!cppc_attrs)
+		return -ENOMEM;
+
+	/* Set optional regs */
+	opt_reg_cnt =3D entries - MANDATORY_REG_CNT;
+	for (i =3D 0; i < MAX_CPC_REG_ENT && attr_i < opt_reg_cnt; i++) {
+		if (is_mandatory_reg(i) || !REG_SUPPORTED(cpc, i))
+			continue;
+
+		switch (i) {
+		case NOMINAL_FREQ:
+			cppc_attrs[attr_i++] =3D &nominal_freq.attr;
+			break;
+		case LOWEST_FREQ:
+			cppc_attrs[attr_i++] =3D &lowest_freq.attr;
+			break;
+		case REFERENCE_PERF:
+			cppc_attrs[attr_i++] =3D &reference_perf.attr;
+			break;
+		case CTR_WRAP_TIME:
+			cppc_attrs[attr_i++] =3D &wraparound_time.attr;
+			break;
+		}
+	}
+
+	/* Set mandatory regs */
+	cppc_attrs[attr_i++] =3D &highest_perf.attr;
+	cppc_attrs[attr_i++] =3D &nominal_perf.attr;
+	cppc_attrs[attr_i++] =3D &lowest_nonlinear_perf.attr;
+	cppc_attrs[attr_i++] =3D &lowest_perf.attr;
+
+	/* Set feedback_ctr sysfs entry */
+	cppc_attrs[attr_i] =3D &feedback_ctrs.attr;
+
+	/* Set kobj_type member */
+	cppc_ktype.default_attrs =3D cppc_attrs;
+
+	return 0;
+}
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
@@ -887,6 +936,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *p=
r)
 	/* Plug PSD data into this CPU's CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) =3D cpc_ptr;
=20
+	ret =3D set_cppc_attrs(cpc_ptr, num_ent - 2);
+	if (ret)
+		goto out_free;
+
 	ret =3D kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
 	if (ret) {
@@ -948,6 +1001,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *p=
r)
 			iounmap(addr);
 	}
=20
+	kfree(cppc_ktype.default_attrs);
 	kobject_put(&cpc_ptr->kobj);
 	kfree(cpc_ptr);
 }
--=20
2.17.1

