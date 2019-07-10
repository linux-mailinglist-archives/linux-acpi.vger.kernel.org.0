Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6D64C32
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGJShQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 14:37:16 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:14752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbfGJShQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRC+ehMukb6Qa+LQ1I/g4rpi1wuFsq1+PXtFQWilG6M=;
 b=o9TO7Psg4d16AvYdYu6ei95y42PR+6EdcpfkiPd24na5hhS2WgUbRAJTQ1EH8ul3S6xngkE4hK7LKCrOrcESFKY+O0dEPbdvA/BioCgKKpKkbWpnaeFiKDSUMbyaBgt8EO9JoPOc4bLIJO0FcWVYP1n/NKVwFpTC5PmEr8nBmtM=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2846.namprd12.prod.outlook.com (52.135.103.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 18:37:12 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 18:37:12 +0000
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
Subject: [PATCHv3 0/6] CPPC optional registers AMD support
Thread-Topic: [PATCHv3 0/6] CPPC optional registers AMD support
Thread-Index: AQHVN057bBT6zB/KfUWS9uFb7V9o2g==
Date:   Wed, 10 Jul 2019 18:37:09 +0000
Message-ID: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 5c3bb6aa-0c5f-4f2f-63f8-08d705659e0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2846;
x-ms-traffictypediagnostic: SN6PR12MB2846:
x-microsoft-antispam-prvs: <SN6PR12MB2846135FB694E71AE0D783ADE7F00@SN6PR12MB2846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(6512007)(14454004)(71190400001)(71200400001)(7736002)(25786009)(26005)(186003)(102836004)(52116002)(486006)(50226002)(6436002)(64756008)(66446008)(53936002)(386003)(99286004)(6506007)(2201001)(66946007)(66476007)(8676002)(305945005)(81166006)(68736007)(6116002)(8936002)(81156014)(86362001)(3846002)(66556008)(6486002)(110136005)(316002)(2501003)(2616005)(5660300002)(256004)(4326008)(36756003)(476003)(14444005)(478600001)(6666004)(2906002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xAmmub16/QE7iVZ7OfMlApteW+NjlYT64jZlYglYAiJBrKp2C5FNtPMkCLp5FKBXlNHa4hoDx1K530B1EfXFeHm2uycEVLNb/dk4IwUjU4gKidZ1dS56lIFIyzvDhq3l4Wqj1qPAaDICugdUuUuwW1ICL48PcZQ5nRhs14lH2zfl2Mq2kSS8Fh2xYm36l3d0lRou9ociaLCu43bZbA7HAO2ALTwsn+4EmSc5bV9XB1le91/ZJvuSyQvd8TkgR8j1xCf9lfOLXCFQ1g9l6/RaPCmSgEPmBHDNnAzhV9cvahWcXNE1vhopil65Q9oiUaap1fm/KazZTsxMLQUYBXuryUv2gQAjtTyAoEPZXVvP6My9jk83jCQ9LCe7vDzIDRAo7GM6X7jD7kZKw+Qsd2908r8TtCH2Ur7bypPnQXhPuI0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3bb6aa-0c5f-4f2f-63f8-08d705659e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 18:37:11.3514
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

CPPC (Collaborative Processor Performance Control) offers optional
registers which can be used to tune the system based on energy and/or
performance requirements.

Newer AMD processors (>=3D Family 17h) add support for a subset of these
optional CPPC registers, based on ACPI v6.1.

The following are the supported CPPC registers for which sysfs entries
are created:
* enable                (NEW)
* max_perf              (NEW)
* min_perf              (NEW)
* energy_perf
* lowest_perf
* nominal_perf
* desired_perf          (NEW)
* feedback_ctrs
* auto_sel_enable       (NEW)
* lowest_nonlinear_perf

First, update cppc_acpi to create sysfs entries only when the optional
registers are known to be supported.

Next, a new CPUFreq driver is introduced to enable the OSPM and the userspa=
ce
to access the newly supported registers through sysfs entries found in
/sys/devices/system/cpu/cpu<num>/amd_cpufreq/.

This new CPUFreq driver can only be used by providing a module parameter,
amd_cpufreq.cppc_enable=3D1.

The purpose of exposing the registers via the amd-cpufreq sysfs entries is =
to
allow the userspace to:
* Tweak the values to fit its workload.
* Apply a profile from AMD's optimization guides.

Profiles will be documented in the performance/optimization guides.

Note:
* AMD systems will not have a policy applied in the kernel at this time.

TODO:
* Create a linux userspace tool that will help users generate a CPPC profil=
e
  for their target workload.
* Create a general CPPC policy in the kernel.

v1->v2:
* Add macro to ensure BUFFER only registers have BUFFER type.
* Add support macro to make the right check based on register type.
* Remove support checks for registers which are mandatory.

v2->v3:
* Introduce new amd-cpufreq driver which will have priority over acpi-cpufr=
eq.
* Move new sysfs entries creation to amd-cpufreq.

Janakarajan Natarajan (3):
  acpi/cppc: Add macros for CPPC register checks
  acpi/cppc: Ensure only supported CPPC sysfs entries are created
  drivers/cpufreq: Add a CPUFreq driver for AMD processors (Fam17h and
    later)

Yazen Ghannam (3):
  acpi/cppc: Rework cppc_set_perf() to use cppc_regs index
  acpi/cppc: Add support for optional CPPC registers
  acpi/cppc: Add support for CPPC Enable register

 drivers/acpi/cppc_acpi.c       | 244 ++++++++++++++++++++++++++++-----
 drivers/cpufreq/Kconfig.x86    |  14 ++
 drivers/cpufreq/Makefile       |   4 +-
 drivers/cpufreq/amd-cpufreq.c  | 233 +++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |   6 +-
 include/acpi/cppc_acpi.h       |  11 +-
 6 files changed, 474 insertions(+), 38 deletions(-)
 create mode 100644 drivers/cpufreq/amd-cpufreq.c

--=20
2.17.1

