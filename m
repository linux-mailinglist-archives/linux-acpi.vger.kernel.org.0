Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5921264C40
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGJShV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:21 -0400
Received: from mail-eopbgr740044.outbound.protection.outlook.com ([40.107.74.44]:2304
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727476AbfGJShV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdnND8Pqmww9QDdwO7mKz/FqsNzO3shuGm4eOoieHxE=;
 b=X4jKJR1ecxS6Dtz4IqelbdNRpfkWVgikhHLDg98K6Nt7NI2uOzezTsq3VCpnzGGdYesigR8yN/+PTJGQ2SHDWK6ukrZkcMKZXbZpc6vKrNAPHJoZs3eVkBODLE/MgWN2ogOdSCPqBaZbICCXHNjVvyC3AmzIB82WMhBgRapBQqM=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 18:37:18 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:18 +0000
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
Subject: [PATCHv3 4/6] acpi/cppc: Add support for optional CPPC registers
Thread-Topic: [PATCHv3 4/6] acpi/cppc: Add support for optional CPPC registers
Thread-Index: AQHVN05/uCAmzktiqUqe1+5kYIkwWA==
Date:   Wed, 10 Jul 2019 18:37:16 +0000
Message-ID: <296ef9c218d1ef240c33c3beb68b7caef4d77940.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 8ca2853d-6ea4-4df8-e5b8-08d70565a194
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-microsoft-antispam-prvs: <SN6PR12MB27497090B7AE95911A8E15B5E7F00@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(66476007)(66946007)(5660300002)(66556008)(81166006)(2906002)(54906003)(64756008)(50226002)(36756003)(186003)(6486002)(6506007)(386003)(316002)(110136005)(102836004)(2501003)(14454004)(8936002)(68736007)(66446008)(2201001)(99286004)(7736002)(446003)(478600001)(118296001)(305945005)(52116002)(53936002)(76176011)(6512007)(8676002)(86362001)(256004)(11346002)(486006)(25786009)(14444005)(476003)(2616005)(3846002)(6436002)(26005)(6116002)(71200400001)(71190400001)(81156014)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HunOsVXhHnQo16/AYrvVECL0KbHRuFbL6TjfYNms1zZ2m0zbEoOt0+0vQH3hJtE6UUHi/9coxShgVdhikFU6c0d2zMvINlvjRBV023Ll5tyd1yJmqaZ1VKKDc4JSzospAgNuNBcUAlQ4jwKvsmJfzjgGu9BThe+/tMyFYNDqBzgoNiOefOFC+ZjKpbOrC2dHpyuCpWeRhzOaYj2wMnSj/maeEeolAP+71dzP6eXipGay5rl+hpBSwiKfTeb4BqFzdlIblT5kWOc4iWc2sCegUlwr2N/VBfZS83FhM7Fx6p19s8LYvCEVagbvXkfFE94IZ9u7cy9bnpFyl8jeRRKUjdcNlh/AZHidCeO5cl8qOFRJOlugl9OCognEJUnAbUBmF5QGHy83xsnUpPUEn5LKIqN73Vxe8mtrAkGPP/lmHuA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca2853d-6ea4-4df8-e5b8-08d70565a194
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:16.3196
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

Newer AMD processors support a subset of the optional CPPC registers.
Add support for these optional registers.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 88 +++++++++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h |  3 ++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c13dacea4a8b..b24e54263efb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1367,6 +1367,18 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 	case DESIRED_PERF:
 		value =3D perf_ctrls->desired_perf;
 		break;
+	case MAX_PERF:
+		value =3D perf_ctrls->max_perf;
+		break;
+	case MIN_PERF:
+		value =3D perf_ctrls->min_perf;
+		break;
+	case ENERGY_PERF:
+		value =3D perf_ctrls->energy_perf;
+		break;
+	case AUTO_SEL_ENABLE:
+		value =3D perf_ctrls->auto_sel_enable;
+		break;
 	default:
 		pr_debug("CPC register index #%d not writeable\n", reg_idx);
 		return -EINVAL;
@@ -1404,11 +1416,8 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 		cpc_desc->write_cmd_status =3D 0;
 	}
=20
-	/*
-	 * Skip writing MIN/MAX until Linux knows how to come up with
-	 * useful values.
-	 */
-	cpc_write(cpu, reg, value);
+	if (CPC_SUPPORTED(reg))
+		cpc_write(cpu, reg, value);
=20
 	if (CPC_IN_PCC(reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
@@ -1476,6 +1485,75 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 }
 EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg, *max_reg, *min_reg;
+	struct cpc_register_resource *energy_reg, *auto_sel_enable_reg;
+	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
+	u64 desired, max, min, energy, auto_sel_enable;
+	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	int ret =3D 0, regs_in_pcc =3D 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU: %d\n", cpu);
+		return -ENODEV;
+	}
+
+	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	max_reg =3D &cpc_desc->cpc_regs[MAX_PERF];
+	min_reg =3D &cpc_desc->cpc_regs[MIN_PERF];
+	energy_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
+	auto_sel_enable_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	/* Check if any of the perf registers are in PCC */
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(max_reg) ||
+	    CPC_IN_PCC(min_reg) || CPC_IN_PCC(energy_reg) ||
+	    CPC_IN_PCC(auto_sel_enable_reg)) {
+		pcc_ss_data =3D pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc =3D 1;
+
+		/*Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret =3D -EIO;
+			goto out_err;
+		}
+	}
+
+	/* desired_perf is the only mandatory value in perf_ctrls */
+	if (cpc_read(cpu, desired_reg, &desired))
+		ret =3D -EFAULT;
+
+	if (CPC_SUP_BUFFER_ONLY(max_reg) && cpc_read(cpu, max_reg, &max))
+		ret =3D -EFAULT;
+
+	if (CPC_SUP_BUFFER_ONLY(min_reg) && cpc_read(cpu, min_reg, &min))
+		ret =3D -EFAULT;
+
+	if (CPC_SUP_BUFFER_ONLY(energy_reg) &&
+	    cpc_read(cpu, energy_reg, &energy))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(auto_sel_enable_reg) &&
+	    cpc_read(cpu, auto_sel_enable_reg, &auto_sel_enable))
+		ret =3D -EFAULT;
+
+	if (!ret) {
+		perf_ctrls->desired_perf =3D desired;
+		perf_ctrls->max_perf =3D max;
+		perf_ctrls->min_perf =3D min;
+		perf_ctrls->energy_perf =3D energy;
+		perf_ctrls->auto_sel_enable =3D auto_sel_enable;
+	}
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
  *
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index f229e903525d..80720b246c51 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -113,6 +113,8 @@ struct cppc_perf_ctrls {
 	u32 max_perf;
 	u32 min_perf;
 	u32 desired_perf;
+	u32 auto_sel_enable;
+	u32 energy_perf;
 };
=20
 struct cppc_perf_fb_ctrs {
@@ -136,6 +138,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
 extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1

