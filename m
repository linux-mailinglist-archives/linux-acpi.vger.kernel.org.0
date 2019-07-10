Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862A964C45
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfGJShV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:21 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:28282
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728166AbfGJShT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gyOZG+r1U2rG6K5YYAVtq1E2dodsASbALyGvprSxuQ=;
 b=cla/rQ8CxEL8ms3GGEiiRgp5wNSTUaozuGWaA1NKvbPY/YDLNE02UGPZ8wGsYAWSiWNzEdCPPwLegrfLZeIfXkG4c7ad2bqyLih0AD6ZCW302gEivD9qy2dY4cFurhp64aR0ReD9p3Sm8gP3GPZVU1DUi/o2VSiuC54XLWeKWrs=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2621.namprd12.prod.outlook.com (52.135.103.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 18:37:16 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:16 +0000
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
Subject: [PATCHv3 3/6] acpi/cppc: Rework cppc_set_perf() to use cppc_regs
 index
Thread-Topic: [PATCHv3 3/6] acpi/cppc: Rework cppc_set_perf() to use cppc_regs
 index
Thread-Index: AQHVN05+ZGHRO/MraUWKit0+yoLPzQ==
Date:   Wed, 10 Jul 2019 18:37:14 +0000
Message-ID: <9bc091f450bea98454685e6118a37d0b32b7db96.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 567b6f4d-c86d-4e51-aa56-08d70565a100
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2621;
x-ms-traffictypediagnostic: SN6PR12MB2621:
x-microsoft-antispam-prvs: <SN6PR12MB262162C315957AEE62B11E8EE7F00@SN6PR12MB2621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(50226002)(4326008)(81156014)(81166006)(71200400001)(14454004)(71190400001)(476003)(11346002)(446003)(68736007)(2616005)(6116002)(3846002)(486006)(256004)(305945005)(7736002)(478600001)(14444005)(25786009)(5660300002)(36756003)(2906002)(76176011)(53936002)(66476007)(66556008)(64756008)(66066001)(66446008)(6512007)(2501003)(8936002)(118296001)(6436002)(6486002)(8676002)(66946007)(316002)(52116002)(102836004)(2201001)(6506007)(99286004)(26005)(386003)(86362001)(110136005)(54906003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2621;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfxzYu+k6u5t8q5E8xnFOoFbhQpwHoFvWKPeEN/xUuW/2NwFaR6SQxWgYmrkxNHJ3165vq6aSK/tcHwFNEaMIqAaWKkXvqto7oaMMqLx4nKVVHmPnfkqoSluM88OXBKmLsXKICHkwz8vKgnkVxiCaf2JEYZZ1H5BD8Oj0GVvro5yu2/x07vj2hxBt3Qyh+iZQXlZVUwXL6WngrIRVivIhHmwRuQ+ZWf/g92QGVqLxRz+rDKgQ9fg+KztIensggFV6JIX6v1IIXJmhoX6r/JrA0qbq57UK4O6Zr0n7Ng99U84f+3g5CTyELuicerKrEYPam5stmRRXOhKdIYyi74qCaQ3Q49KIp4wj8e4hpBjKDLFs8JFcK2jAsU2yfNEBochiH0l/KrSWUBsE1KBVWikLi82txsuPX/7mKh3otIYp0c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567b6f4d-c86d-4e51-aa56-08d70565a100
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:15.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

The cppc_set_perf() currently only works for DESIRED_PERF. To make it
generic, pass in the index of the register being accessed.

Also, rename cppc_set_perf() to cppc_set_reg(). This is in preparation
for it to be used for more than just the DESIRED_PERF register.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
 drivers/cpufreq/cppc_cpufreq.c |  6 +++---
 include/acpi/cppc_acpi.h       |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53a9dc9960b6..c13dacea4a8b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -56,7 +56,7 @@ struct cppc_pcc_data {
 	/*
 	 * Lock to provide controlled access to the PCC channel.
 	 *
-	 * For performance critical usecases(currently cppc_set_perf)
+	 * For performance-critical usecases(currently cppc_set_reg)
 	 *	We need to take read_lock and check if channel belongs to OSPM
 	 * before reading or writing to PCC subspace
 	 *	We need to take write_lock before transferring the channel
@@ -1341,26 +1341,38 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
=20
 /**
- * cppc_set_perf - Set a CPU's performance controls.
- * @cpu: CPU for which to set performance controls.
+ * cppc_set_reg - Set the CPUs control register.
+ * @cpu: CPU for which to set the register.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ * @reg_idx: Index of the register being accessed
  *
  * Return: 0 for success, -ERRNO otherwise.
  */
-int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls,
+		 enum cppc_regs reg_idx)
 {
 	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_reg;
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	struct cpc_register_resource *reg;
 	int ret =3D 0;
+	u32 value;
=20
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
=20
-	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	switch (reg_idx) {
+	case DESIRED_PERF:
+		value =3D perf_ctrls->desired_perf;
+		break;
+	default:
+		pr_debug("CPC register index #%d not writeable\n", reg_idx);
+		return -EINVAL;
+	}
+
+	reg =3D &cpc_desc->cpc_regs[reg_idx];
=20
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -1369,7 +1381,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1396,14 +1408,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
 	 * Skip writing MIN/MAX until Linux knows how to come up with
 	 * useful values.
 	 */
-	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	cpc_write(cpu, reg, value);
=20
-	if (CPC_IN_PCC(desired_reg))
+	if (CPC_IN_PCC(reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
-	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * Short Summary: Basically if we think of a group of cppc_set_reg
 	 * requests that happened in short overlapping interval. The last CPU to
 	 * come out of Phase-I will enter Phase-II and ring the doorbell.
 	 *
@@ -1446,7 +1458,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
@@ -1462,7 +1474,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_perf);
+EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.=
c
index 8d8da763adc5..81e9dff03c92 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -207,7 +207,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_polic=
y *policy,
 	freqs.new =3D target_freq;
=20
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret =3D cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu->cpu, &cpu->perf_ctrls, DESIRED_PERF);
 	cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
=20
 	if (ret)
@@ -231,7 +231,7 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy=
 *policy)
=20
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.lowest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
@@ -344,7 +344,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy =
*policy)
 					cpu->perf_caps.highest_perf);
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.highest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.highest_perf, cpu_num, ret);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a6a9373ab863..f229e903525d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -135,7 +135,7 @@ struct cppc_cpudata {
=20
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
-extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1

