Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90164C3D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfGJShg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:36 -0400
Received: from mail-eopbgr740044.outbound.protection.outlook.com ([40.107.74.44]:2304
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728313AbfGJShX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8ioBU9PAAqJNA9ahES7jO0iNWd7rat9aN50Rsi2OtI=;
 b=gp/yoUtNS021+2qiPQ8zd6/6sl+QHHbGvtqsvyIrU3b5gIfgM/pBv25YWVgSy/nvMVcJb2I6Xa2ZvxG2o1W8cVJKUgGy4CskwW4/Fcd2As/CtrC4L40KXpyhFF1kfCjH6Y0ncqY+7vsfXt4Igmnqr22nd/yxZpXM2Zt5OB8o5LA=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 18:37:20 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:20 +0000
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
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCHv3 5/6] acpi/cppc: Add support for CPPC Enable register
Thread-Topic: [PATCHv3 5/6] acpi/cppc: Add support for CPPC Enable register
Thread-Index: AQHVN06A9flMOYmKH0yRLd2nLrnssw==
Date:   Wed, 10 Jul 2019 18:37:17 +0000
Message-ID: <40c32db191fa023f7f8f1e48d58565a22b8fcbd6.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: d0749c57-ff40-4eae-c3bb-08d70565a249
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-microsoft-antispam-prvs: <SN6PR12MB274988621803B2A51600902CE7F00@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(66476007)(66946007)(5660300002)(66556008)(81166006)(2906002)(54906003)(64756008)(50226002)(36756003)(186003)(6486002)(6506007)(386003)(316002)(110136005)(102836004)(2501003)(14454004)(8936002)(68736007)(66446008)(2201001)(99286004)(7736002)(446003)(478600001)(118296001)(305945005)(52116002)(53936002)(76176011)(6512007)(8676002)(86362001)(256004)(11346002)(486006)(25786009)(14444005)(476003)(2616005)(3846002)(6436002)(26005)(6116002)(71200400001)(71190400001)(81156014)(6666004)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PXxgfJXmR4zEpUVENmUVVCP5kW1ZM6VWbFYkECRBjD27EkNYi7KkMcMTiJ2b5ufhKKXVAfcdf3LAZxzz2WEZgwjOCI9R1yUJqL8T1PQN1iO8Xkgv4ZlpwJeqvbLjgzX/bZdii5Y8j+KPCOiCLRJnM/tx60v3e3hgWbniH+qQNHBfW0AeA2WKj8lcNkwThu4OUeYQ2jBjw6HTUgVk8qFBQrn/MXf0iNxJBxQSSOIrnKHlNqmvrEawqYDqUoKWMbcdruI3eOcVwXIQz+P3mVXwqSc+301NmtTAHQ9dGxVL2K3QxmRI3Xu0LhdzlOdmqEw6VVa6JhR1QTIho+cYZYRuZ/dWoFpE2Uin069PB2yDvCqGCHA3qD8c8JpclyKet6V8X7YZwMSiKs3f8Ost2fHpo6af1LZSu0H/HJ9zBHTAblU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0749c57-ff40-4eae-c3bb-08d70565a249
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:17.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

To enable CPPC on a processor, the OS should write a value "1" to the
CPPC Enable register. Add support for this register.

Since we have a new variable "enable" in cppc_perf_ctrls, rename it
and the associated functions i.e. cppc_perf_ctrls->cppc_ctrls and
cppc_get_perf()->cppc_get_ctrls().

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++----------------
 include/acpi/cppc_acpi.h | 10 +++++----
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b24e54263efb..3199433e3f71 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1343,12 +1343,12 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 /**
  * cppc_set_reg - Set the CPUs control register.
  * @cpu: CPU for which to set the register.
- * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ * @ctrls: ptr to cppc_ctrls. See cppc_acpi.h
  * @reg_idx: Index of the register being accessed
  *
  * Return: 0 for success, -ERRNO otherwise.
  */
-int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls,
+int cppc_set_reg(int cpu, struct cppc_ctrls *ctrls,
 		 enum cppc_regs reg_idx)
 {
 	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
@@ -1364,20 +1364,23 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls,
 	}
=20
 	switch (reg_idx) {
+	case ENABLE:
+		value =3D ctrls->enable;
+		break;
 	case DESIRED_PERF:
-		value =3D perf_ctrls->desired_perf;
+		value =3D ctrls->desired_perf;
 		break;
 	case MAX_PERF:
-		value =3D perf_ctrls->max_perf;
+		value =3D ctrls->max_perf;
 		break;
 	case MIN_PERF:
-		value =3D perf_ctrls->min_perf;
+		value =3D ctrls->min_perf;
 		break;
 	case ENERGY_PERF:
-		value =3D perf_ctrls->energy_perf;
+		value =3D ctrls->energy_perf;
 		break;
 	case AUTO_SEL_ENABLE:
-		value =3D perf_ctrls->auto_sel_enable;
+		value =3D ctrls->auto_sel_enable;
 		break;
 	default:
 		pr_debug("CPC register index #%d not writeable\n", reg_idx);
@@ -1485,13 +1488,14 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls,
 }
 EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
-int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+int cppc_get_ctrls(int cpu, struct cppc_ctrls *ctrls)
 {
 	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
 	struct cpc_register_resource *desired_reg, *max_reg, *min_reg;
 	struct cpc_register_resource *energy_reg, *auto_sel_enable_reg;
+	struct cpc_register_resource *enable_reg;
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
-	u64 desired, max, min, energy, auto_sel_enable;
+	u64 desired, max, min, energy, auto_sel_enable, enable;
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
 	int ret =3D 0, regs_in_pcc =3D 0;
=20
@@ -1500,6 +1504,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 		return -ENODEV;
 	}
=20
+	enable_reg =3D &cpc_desc->cpc_regs[ENABLE];
 	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
 	max_reg =3D &cpc_desc->cpc_regs[MAX_PERF];
 	min_reg =3D &cpc_desc->cpc_regs[MIN_PERF];
@@ -1509,7 +1514,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	/* Check if any of the perf registers are in PCC */
 	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(max_reg) ||
 	    CPC_IN_PCC(min_reg) || CPC_IN_PCC(energy_reg) ||
-	    CPC_IN_PCC(auto_sel_enable_reg)) {
+	    CPC_IN_PCC(auto_sel_enable_reg) || CPC_IN_PCC(enable_reg)) {
 		pcc_ss_data =3D pcc_data[pcc_ss_id];
 		down_write(&pcc_ss_data->pcc_lock);
 		regs_in_pcc =3D 1;
@@ -1521,10 +1526,14 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
 		}
 	}
=20
-	/* desired_perf is the only mandatory value in perf_ctrls */
+	/* desired_perf is the only mandatory value in ctrls */
 	if (cpc_read(cpu, desired_reg, &desired))
 		ret =3D -EFAULT;
=20
+	if (CPC_SUP_BUFFER_ONLY(enable_reg) &&
+	    cpc_read(cpu, enable_reg, &enable))
+		ret =3D -EFAULT;
+
 	if (CPC_SUP_BUFFER_ONLY(max_reg) && cpc_read(cpu, max_reg, &max))
 		ret =3D -EFAULT;
=20
@@ -1540,11 +1549,12 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
 		ret =3D -EFAULT;
=20
 	if (!ret) {
-		perf_ctrls->desired_perf =3D desired;
-		perf_ctrls->max_perf =3D max;
-		perf_ctrls->min_perf =3D min;
-		perf_ctrls->energy_perf =3D energy;
-		perf_ctrls->auto_sel_enable =3D auto_sel_enable;
+		ctrls->enable =3D enable;
+		ctrls->desired_perf =3D desired;
+		ctrls->max_perf =3D max;
+		ctrls->min_perf =3D min;
+		ctrls->energy_perf =3D energy;
+		ctrls->auto_sel_enable =3D auto_sel_enable;
 	}
=20
 out_err:
@@ -1552,7 +1562,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 		up_write(&pcc_ss_data->pcc_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_get_perf);
+EXPORT_SYMBOL_GPL(cppc_get_ctrls);
=20
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 80720b246c51..e6cd2a487874 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -109,7 +109,8 @@ struct cppc_perf_caps {
 	u32 nominal_freq;
 };
=20
-struct cppc_perf_ctrls {
+struct cppc_ctrls {
+	bool enable;
 	u32 max_perf;
 	u32 min_perf;
 	u32 desired_perf;
@@ -128,17 +129,18 @@ struct cppc_perf_fb_ctrs {
 struct cppc_cpudata {
 	int cpu;
 	struct cppc_perf_caps perf_caps;
-	struct cppc_perf_ctrls perf_ctrls;
+	struct cppc_ctrls ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	struct cpufreq_policy *cur_policy;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
 };
=20
+extern int cppc_get_enable(int cpu);
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
-extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
-extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_reg(int cpu, struct cppc_ctrls *ctrls, enum cppc_regs =
reg_idx);
+extern int cppc_get_ctrls(int cpu, struct cppc_ctrls *ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1

