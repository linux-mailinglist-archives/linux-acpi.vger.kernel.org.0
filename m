Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59364C3A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfGJSh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:27 -0400
Received: from mail-eopbgr730083.outbound.protection.outlook.com ([40.107.73.83]:45272
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbfGJSh1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzqTVqGv71g2DtZWBEu+CjQ3CTOwcVMwGyPCs3sQM/I=;
 b=P1V2N4btIAGr5ePlQTTa3YdicJN/7yy14QUADOwu70P4sJxVXLazGoUs5tvPfJN2zXPFEk7eeuyJcCb7SUvB9n6MlniQudWGtER9S5nX91N1nIHrdPDmBMvXSxNYy3trBA2cYo+B1S5HnpsTAv4M1aDJAIykxWUSdTgilDWTaYY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 18:37:21 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:21 +0000
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
Subject: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Thread-Topic: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Thread-Index: AQHVN06AuI3rG5PgEkGK1o9FtbMXtQ==
Date:   Wed, 10 Jul 2019 18:37:18 +0000
Message-ID: <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: eb687ae8-0adf-46f9-e3a8-08d70565a2f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2639;
x-ms-traffictypediagnostic: SN6PR12MB2639:
x-microsoft-antispam-prvs: <SN6PR12MB263919F101BA3BC41618CA19E7F00@SN6PR12MB2639.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(11346002)(446003)(99286004)(3846002)(6436002)(6116002)(2501003)(6666004)(66066001)(71200400001)(71190400001)(316002)(476003)(25786009)(2616005)(6506007)(386003)(76176011)(486006)(36756003)(14454004)(66946007)(305945005)(6486002)(64756008)(66446008)(66476007)(8936002)(66556008)(81156014)(81166006)(54906003)(53936002)(186003)(2201001)(8676002)(26005)(4326008)(50226002)(118296001)(52116002)(102836004)(68736007)(86362001)(6512007)(5660300002)(2906002)(256004)(14444005)(110136005)(7736002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2639;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PZtyf9U8T0BLfvcrdIyhtTmd6AyTWWCc4m1S+ANTibJneEYOfLLPipa7iM0taupgi/b0UOZg4jHM1RIFsYO7to2GuZ2dFqmwGi2qQnM2L3MCjbbckHqtq71tv4usmzrzqDojJlp/DpML1rOD2RAtHbd/O3r4taDm32Q6XUI8A4jVWOOO/D9aIzu/G69joE0SDI3k8HrLH8RvYeVx2220o3mUoZQ2MdNWK+sZQSSo2qWEcDuKK7jOuls4J09R9S2KSpOkDhM6+gB/qW8haRG27E5fHJzYQAZSvlYVA0lerK0RkxdR9usToQ+PSXqeQTRkqDH3Ca8mP+VWWwXPu6Ep5Zkty8VqYtvdP6iB9PidS+ZCdjywlqpRZan2eETBKkMfS64MqKB6DfB4NnHNr/IXlp3+uinu6kE4ZtDCUOtVDvo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb687ae8-0adf-46f9-e3a8-08d70565a2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:18.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new CPUFreq driver which exposes sysfs entries to control the
platform. To make use of this driver use a kernel commandline option.

Ex: amd_cpufreq=3Denable	- Enable AMD CPUFreq driver for Fam17h and later

Also, place amd-cpufreq before acpi-cpufreq in the Makefile to give it
higher priority.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/cpufreq/Kconfig.x86   |  14 ++
 drivers/cpufreq/Makefile      |   4 +-
 drivers/cpufreq/amd-cpufreq.c | 233 ++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/amd-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..01c7c5b5486a 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -32,6 +32,20 @@ config X86_PCC_CPUFREQ
=20
 	  If in doubt, say N.
=20
+config X86_AMD_CPUFREQ
+	tristate "AMD CPUFreq driver"
+	depends on ACPI_PROCESSOR
+	select ACPI_CPPC_LIB
+	help
+	  This adds a CPUFreq driver which uses CPPC methods
+	  as described in the ACPI v6.1 spec for newer (>=3D Fam17h)
+	  AMD processors.
+
+	  When this driver is enabled it will become preferred to
+	  the acpi-cpufreq driver.
+
+	  If in doubt, say N.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..b2837ed9aff2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -22,8 +22,10 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+=3D cpufreq-dt-platdev=
.o
 # Link order matters. K8 is preferred to ACPI because of firmware bugs in =
early
 # K8 systems. This is still the case but acpi-cpufreq errors out so that
 # powernow-k8 can load then. ACPI is preferred to all other hardware-speci=
fic drivers.
-# speedstep-* is preferred over p4-clockmod.
+# speedstep-* is preferred over p4-clockmod. amd-cpufreq is preferred to a=
cpi-cpufreq
+# for Fam17h or newer AMD processors. For others, acpi-cpufreq will be use=
d.
=20
+obj-$(CONFIG_X86_AMD_CPUFREQ)		+=3D amd-cpufreq.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+=3D acpi-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+=3D powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+=3D pcc-cpufreq.o
diff --git a/drivers/cpufreq/amd-cpufreq.c b/drivers/cpufreq/amd-cpufreq.c
new file mode 100644
index 000000000000..262c8de3be2e
--- /dev/null
+++ b/drivers/cpufreq/amd-cpufreq.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD CPUFREQ driver for Family 17h or greater AMD processors.
+ *
+ * Copyright (C) 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
+ */
+#define pr_fmt(fmt)	"AMD Cpufreq: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/vmalloc.h>
+#include <linux/cpufreq.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+
+#include <asm/unaligned.h>
+
+#include <acpi/cppc_acpi.h>
+
+struct amd_desc {
+	int cpu_id;
+	struct cppc_ctrls ctrls;
+	struct kobject kobj;
+};
+
+struct amd_desc **all_cpu_data;
+
+static unsigned int cppc_enable;
+module_param(cppc_enable, uint, 0644);
+MODULE_PARM_DESC(cppc_enable,
+		 "1 - enable AMD CpuFreq, create CPPC sysfs entries.");
+
+#define to_amd_desc(a) container_of(a, struct amd_desc, kobj)
+
+#define show_func(access_fn, struct_name, member_name)			\
+	static ssize_t show_##member_name(struct kobject *kobj,		\
+					  struct kobj_attribute *attr,	\
+					  char *buf)			\
+	{								\
+		struct amd_desc *desc =3D to_amd_desc(kobj);		\
+		struct struct_name st_name =3D {0};			\
+		int ret;						\
+									\
+		ret =3D access_fn(desc->cpu_id, &st_name);		\
+		if (ret)						\
+			return ret;					\
+									\
+		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
+				 (u64)st_name.member_name);		\
+	}								\
+
+#define store_func(struct_name, member_name, reg_idx)			\
+	static ssize_t store_##member_name(struct kobject *kobj,	\
+					   struct kobj_attribute *attr,	\
+					   const char *buf, size_t count)\
+	{								\
+		struct amd_desc *desc =3D to_amd_desc(kobj);		\
+		struct struct_name st_name =3D {0};			\
+		u32 val;						\
+		int ret;						\
+									\
+		ret =3D kstrtou32(buf, 0, &val);				\
+		if (ret)						\
+			return ret;					\
+									\
+		st_name.member_name =3D val;				\
+									\
+		ret =3D cppc_set_reg(desc->cpu_id, &st_name, reg_idx);	\
+		if (ret)						\
+			return ret;					\
+									\
+		return count;						\
+	}								\
+
+#define define_one_rw(struct_name, access_fn, member_name, reg_idx)	\
+	show_func(access_fn, struct_name, member_name)			\
+	store_func(struct_name, member_name, reg_idx)			\
+	define_one_global_rw(member_name)
+
+define_one_rw(cppc_ctrls, cppc_get_ctrls, enable, ENABLE);
+define_one_rw(cppc_ctrls, cppc_get_ctrls, max_perf, MAX_PERF);
+define_one_rw(cppc_ctrls, cppc_get_ctrls, min_perf, MIN_PERF);
+define_one_rw(cppc_ctrls, cppc_get_ctrls, desired_perf, DESIRED_PERF);
+define_one_rw(cppc_ctrls, cppc_get_ctrls, auto_sel_enable, AUTO_SEL_ENABLE=
);
+
+static struct attribute *amd_cpufreq_attributes[] =3D {
+	&enable.attr,
+	&max_perf.attr,
+	&min_perf.attr,
+	&desired_perf.attr,
+	&auto_sel_enable.attr,
+	NULL
+};
+
+static const struct attribute_group amd_cpufreq_attr_group =3D {
+	.attrs =3D amd_cpufreq_attributes,
+};
+
+static struct kobj_type amd_cpufreq_type =3D {
+	.sysfs_ops =3D &kobj_sysfs_ops,
+	.default_attrs =3D amd_cpufreq_attributes,
+};
+
+static int amd_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static int amd_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static int amd_cpufreq_cpu_verify(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static int amd_cpufreq_cpu_target_index(struct cpufreq_policy *policy,
+					unsigned int index)
+{
+	return 0;
+}
+
+static struct cpufreq_driver amd_cpufreq_driver =3D {
+	.name =3D "amd_cpufreq",
+	.init =3D amd_cpufreq_cpu_init,
+	.exit =3D amd_cpufreq_cpu_exit,
+	.verify =3D amd_cpufreq_cpu_verify,
+	.target_index =3D amd_cpufreq_cpu_target_index,
+};
+
+static void amd_cpufreq_sysfs_delete_params(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		if (all_cpu_data[i]) {
+			kobject_del(&all_cpu_data[i]->kobj);
+			kfree(all_cpu_data[i]);
+		}
+	}
+
+	kfree(all_cpu_data);
+}
+
+static int __init amd_cpufreq_sysfs_expose_params(void)
+{
+	struct device *cpu_dev;
+	int i, ret;
+
+	all_cpu_data =3D kcalloc(num_possible_cpus(), sizeof(void *),
+			       GFP_KERNEL);
+
+	if (!all_cpu_data)
+		return -ENOMEM;
+
+	for_each_possible_cpu(i) {
+		all_cpu_data[i] =3D kzalloc(sizeof(struct amd_desc), GFP_KERNEL);
+		if (!all_cpu_data[i]) {
+			ret =3D -ENOMEM;
+			goto free;
+		}
+
+		all_cpu_data[i]->cpu_id =3D i;
+		cpu_dev =3D get_cpu_device(i);
+		ret =3D kobject_init_and_add(&all_cpu_data[i]->kobj, &amd_cpufreq_type,
+					   &cpu_dev->kobj, "amd_cpufreq");
+		if (ret)
+			goto free;
+	}
+
+	return 0;
+free:
+	amd_cpufreq_sysfs_delete_params();
+	return ret;
+}
+
+static int __init amd_cpufreq_init(void)
+{
+	int ret =3D 0;
+
+	/*
+	 * Use only if:
+	 * - AMD,
+	 * - Family 17h (or) newer and,
+	 * - Explicitly enabled
+	 */
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD ||
+	    boot_cpu_data.x86 < 0x17 || !cppc_enable)
+		return -ENODEV;
+
+	ret =3D cpufreq_register_driver(&amd_cpufreq_driver);
+	if (ret) {
+		pr_info("Failed to register driver\n");
+		goto out;
+	}
+
+	ret =3D amd_cpufreq_sysfs_expose_params();
+	if (ret) {
+		pr_info("Could not create sysfs entries\n");
+		cpufreq_unregister_driver(&amd_cpufreq_driver);
+		goto out;
+	}
+
+	pr_info("Using amd-cpufreq driver\n");
+	return ret;
+
+out:
+	return ret;
+}
+
+static void __exit amd_cpufreq_exit(void)
+{
+	amd_cpufreq_sysfs_delete_params();
+	cpufreq_unregister_driver(&amd_cpufreq_driver);
+}
+
+static const struct acpi_device_id amd_acpi_ids[] __used =3D {
+	{ACPI_PROCESSOR_DEVICE_HID, },
+	{}
+};
+
+device_initcall(amd_cpufreq_init);
+module_exit(amd_cpufreq_exit);
+MODULE_DEVICE_TABLE(acpi, amd_acpi_ids);
+
+MODULE_AUTHOR("Janakarajan Natarajan");
+MODULE_DESCRIPTION("AMD CPUFreq driver based on ACPI CPPC v6.1 spec");
+MODULE_LICENSE("GPL");
--=20
2.17.1

